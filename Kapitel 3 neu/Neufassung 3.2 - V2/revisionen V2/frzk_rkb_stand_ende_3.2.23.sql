-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 30. Jul 2026 um 02:39
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
(53, 'Luhmann', 'Niklas', 'Luhmann, Niklas', NULL, 1927, 1998, 'Autor von Quelle [70].'),
(55, 'Lang', 'Serge', 'Lang, Serge', NULL, NULL, NULL, 'Autor der in Kapitel 3.2 verwendeten algebraischen Grundlagenliteratur.'),
(56, 'Rudin', 'Walter', 'Rudin, Walter', NULL, NULL, NULL, 'Autor der in Kapitel 3.2 verwendeten Grundlagenliteratur zur Analysis.'),
(57, 'Munkres', 'James R.', 'Munkres, James R.', NULL, NULL, NULL, 'Autor der in Kapitel 3.2 verwendeten topologischen Grundlagenliteratur.'),
(58, 'Strang', 'Gilbert', 'Strang, Gilbert', NULL, NULL, NULL, 'Autor der in Kapitel 3.2 verwendeten Grundlagenliteratur zur linearen Algebra.'),
(59, 'Kreyszig', 'Erwin', 'Kreyszig, Erwin', NULL, NULL, NULL, 'Autor der in Kapitel 3.2 verwendeten Grundlagenliteratur zur Funktionalanalysis.'),
(60, 'Reed', 'Michael', 'Reed, Michael', NULL, NULL, NULL, 'Erstautor der operatorentheoretischen Referenz [76].'),
(61, 'Simon', 'Barry', 'Simon, Barry', NULL, NULL, NULL, 'Zweitautor der operatorentheoretischen Referenz [76].'),
(62, 'Diestel', 'Reinhard', 'Diestel, Reinhard', NULL, NULL, NULL, 'Autor der in Kapitel 3.2 verwendeten graphentheoretischen Grundlagenliteratur.'),
(63, 'Kleene', 'Stephen Cole', 'Kleene, Stephen Cole', NULL, NULL, NULL, 'Autor der in Kapitel 3.2 verwendeten Grundlagenliteratur zur mathematischen Logik.'),
(64, 'Enderton', 'Herbert B.', 'Enderton, Herbert B.', NULL, NULL, NULL, 'Autor der mengentheoretischen Grundlagenquelle [80].'),
(65, 'Jech', 'Thomas', 'Jech, Thomas', NULL, NULL, NULL, 'Autor der axiomatischen und weiterführenden Mengenlehre [81].'),
(66, 'Bartle', 'Robert G.', 'Bartle, Robert G.', NULL, NULL, NULL, 'Erstautor der Quelle [83].'),
(67, 'Sherbert', 'Donald R.', 'Sherbert, Donald R.', NULL, NULL, NULL, 'Mitautor der Quelle [83].'),
(68, 'Golub', 'Gene H.', 'Golub, Gene H.', NULL, NULL, NULL, 'Autor der Quelle [84].'),
(69, 'Van Loan', 'Charles F.', 'Van Loan, Charles F.', NULL, NULL, NULL, 'Autor der Quelle [84].'),
(71, 'Higham', 'Nicholas J.', 'Higham, Nicholas J.', NULL, NULL, NULL, 'Autor der Quelle [85].'),
(72, 'Ben-Israel', 'Adi', 'Ben-Israel, Adi', NULL, NULL, NULL, 'Autor der Quelle [86].'),
(73, 'Greville', 'Thomas N. E.', 'Greville, Thomas N. E.', NULL, NULL, NULL, 'Autor der Quelle [86].'),
(74, 'Hansen', 'Per Christian', 'Hansen, Per Christian', NULL, NULL, NULL, 'Autor der Quelle [87].'),
(75, 'Saad', 'Yousef', 'Saad, Yousef', NULL, NULL, NULL, 'Autor der Quelle [88].'),
(76, 'Kelley', 'C. T.', 'Kelley, C. T.', NULL, NULL, NULL, 'Autor der Quelle [89].'),
(80, 'Hairer', 'Ernst', 'Hairer, Ernst', NULL, NULL, NULL, 'Autor der Quelle [90].'),
(81, 'Nørsett', 'Syvert P.', 'Nørsett, Syvert P.', NULL, NULL, NULL, 'Autor der Quelle [90].'),
(82, 'Wanner', 'Gerhard', 'Wanner, Gerhard', NULL, NULL, NULL, 'Autor der Quelle [90].'),
(83, 'Evans', 'Lawrence C.', 'Evans, Lawrence C.', NULL, NULL, NULL, 'Autor der Quelle [91].'),
(85, 'Kress', 'Rainer', 'Kress, Rainer', NULL, NULL, NULL, 'Autor der Quelle [92].'),
(86, 'Folland', 'Gerald B.', 'Folland, Gerald B.', NULL, NULL, NULL, 'Autor der Quelle [93].'),
(87, 'Mallat', 'Stéphane', 'Mallat, Stéphane', NULL, NULL, NULL, 'Autor der Quelle [94].');

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

--
-- Daten für Tabelle `definitions`
--

INSERT INTO `definitions` (`definition_id`, `definition_number`, `section_id`, `title`, `definition_text`, `formal_latex`, `word_latex`, `provenance`, `source_id`, `assumptions`, `notes`, `validation_status`, `created_revision_id`) VALUES
(1, '3.2.1', 14, 'Menge und Element', 'Eine Menge M ist eine formal bestimmte Zusammenfassung unterscheidbarer Objekte. Die zu M gehörenden Objekte werden als Elemente der Menge bezeichnet.', 'xin M;quad x\notin M', 'xin M;quad x\notin M', 'adapted', 68, 'Es wird eine formale Sprache mit einer wohldefinierten Zugehörigkeitsrelation vorausgesetzt.', 'An die etablierte Mengenlehre angepasste Arbeitsdefinition; keine FRZK-spezifische Eigenleistung.', 'verified', 14),
(2, '3.2.2', 14, 'Binäre Relation', 'Eine binäre Relation R zwischen den Mengen A und B ist eine Teilmenge ihres kartesischen Produkts A × B.', 'Rsubseteq A	imes B', 'Rsubseteq A	imes B', 'adapted', 68, 'Die Mengen A und B sowie ihr kartesisches Produkt sind definiert.', 'An die etablierte Mengenlehre angepasste Arbeitsdefinition.', 'verified', 14),
(3, '3.2.3', 15, 'Funktion', 'Eine Funktion f von A nach B ist eine Relation, die jedem Element aus A genau ein Element aus B zuordnet.', 'f:A\rightarrow B', 'f:A\rightarrow B', 'adapted', 68, 'Die verwendeten Mengen und Relationen sind definiert.', 'Etablierter mathematischer Begriff.', 'verified', 15),
(4, '3.2.4', 15, 'Bild und Urbild', 'Das Bild enthält die erreichten Funktionswerte; das Urbild enthält die zu einer Zielteilmenge gehörenden Eingangselemente.', 'f(A)={f(a)mid ain A};quad f^{-1}(D)={ain Amid f(a)in D}', 'f(A)={f(a)mid ain A};quad f^{-1}(D)={ain Amid f(a)in D}', 'adapted', 68, 'Die verwendeten Mengen und Relationen sind definiert.', 'Etablierter mathematischer Begriff.', 'verified', 15),
(5, '3.2.5', 15, 'Injektive Funktion', 'Eine Funktion ist injektiv, wenn verschiedene Eingangselemente verschiedene Funktionswerte besitzen.', 'forall a_1,a_2in A:f(a_1)=f(a_2)Rightarrow a_1=a_2', 'forall a_1,a_2in A:f(a_1)=f(a_2)Rightarrow a_1=a_2', 'adapted', 68, 'Die verwendeten Mengen und Relationen sind definiert.', 'Etablierter mathematischer Begriff.', 'verified', 15),
(6, '3.2.6', 15, 'Surjektive Funktion', 'Eine Funktion ist surjektiv, wenn jedes Element der Zielmenge erreicht wird.', 'forall bin B;exists ain A:f(a)=b', 'forall bin B;exists ain A:f(a)=b', 'adapted', 68, 'Die verwendeten Mengen und Relationen sind definiert.', 'Etablierter mathematischer Begriff.', 'verified', 15),
(7, '3.2.7', 15, 'Bijektive Funktion', 'Eine Funktion ist bijektiv, wenn sie injektiv und surjektiv ist.', 'f	ext{ bijektiv}Leftrightarrow f	ext{ injektiv}land f	ext{ surjektiv}', 'f	ext{ bijektiv}Leftrightarrow f	ext{ injektiv}land f	ext{ surjektiv}', 'adapted', 68, 'Die verwendeten Mengen und Relationen sind definiert.', 'Etablierter mathematischer Begriff.', 'verified', 15),
(8, '3.2.8', 15, 'Identische Funktion', 'Die identische Funktion ordnet jedem Element sich selbst zu.', 'operatorname{id}_A(a)=a', 'operatorname{id}_A(a)=a', 'adapted', 70, 'Die verwendeten Mengen und Relationen sind definiert.', 'Etablierter mathematischer Begriff.', 'verified', 15),
(9, '3.2.9', 15, 'Funktionsverkettung', 'Die Verkettung g∘f wendet zuerst f und anschließend g an.', '(gcirc f)(a)=g(f(a))', '(gcirc f)(a)=g(f(a))', 'adapted', 70, 'Die verwendeten Mengen und Relationen sind definiert.', 'Etablierter mathematischer Begriff.', 'verified', 15),
(10, '3.2.10', 15, 'Partielle Funktion', 'Eine partielle Funktion auf A ist nur auf einer Teilmenge D von A definiert.', 'f:D\rightarrow B,qquad Dsubseteq A', 'f:D\rightarrow B,qquad Dsubseteq A', 'adapted', 71, 'Die verwendeten Mengen und Relationen sind definiert.', 'Etablierter mathematischer Begriff.', 'verified', 15),
(11, '3.2.11', 16, 'Mathematische Abbildung', 'Seien X und Y Mengen. Eine Abbildung T von X nach Y ordnet jedem Element x aus X genau ein Element y aus Y zu.', 'T:X\\rightarrow Y,\\qquad T(x)=y', 'T:X\\rightarrow Y,\\qquad T(x)=y', 'adapted', 68, 'Die Mengen X und Y sowie der Begriff der eindeutigen Zuordnung sind definiert.', 'Etablierter Abbildungsbegriff; die strukturerhaltenden Eigenschaften werden anschließend gesondert eingeführt.', 'verified', 16),
(12, '3.2.12', 16, 'Linearer Operator', 'Eine lineare Abbildung T, deren Definitions- und Zielraum derselbe Vektorraum V ist, wird als linearer Operator bezeichnet.', 'T:V\\rightarrow V', 'T:V\\rightarrow V', 'adapted', 70, 'Der Vektorraum V sowie Additivität und Homogenität linearer Abbildungen sind definiert.', 'Etablierter Begriff eines linearen Endomorphismus beziehungsweise Operators.', 'verified', 16),
(13, '3.2.13', 17, 'Vektorraum', 'Sei K ein Körper. Ein Vektorraum V über K ist eine nichtleere Menge mit einer Vektoraddition und einer Skalarmultiplikation, welche die Vektorraumaxiome erfüllen.', '+:V\\times V\\rightarrow V;\\qquad \\cdot:K\\times V\\rightarrow V', '+:V\\times V\\rightarrow V;\\qquad \\cdot:K\\times V\\rightarrow V', 'adapted', 59, 'Der Körper K sowie innere und äußere Verknüpfungen sind definiert.', 'Etablierte Definition eines Vektorraums; keine FRZK-spezifische Eigenleistung.', 'verified', 17),
(14, '3.2.14', 17, 'Nullvektor', 'Der Nullvektor ist das eindeutig bestimmte neutrale Element der Vektoraddition. Für jeden Vektor v aus V gilt v plus 0_V gleich v.', '0_V\\in V;\\qquad v+0_V=v', '0_V\\in V;\\qquad v+0_V=v', 'adapted', 59, 'Der Vektorraum V und seine Addition sind definiert.', 'Etablierter Begriff des additiven neutralen Elements.', 'verified', 17),
(15, '3.2.15', 17, 'Untervektorraum', 'Eine Teilmenge U eines Vektorraums V heißt Untervektorraum, wenn U mit den aus V übernommenen Operationen selbst einen Vektorraum bildet.', 'U\\leq V', 'U\\leq V', 'adapted', 59, 'Der Vektorraum V sowie seine Addition und Skalarmultiplikation sind definiert.', 'Etablierte Untervektorraumdefinition.', 'verified', 17),
(16, '3.2.16', 18, 'Linearkombination', 'Seien v_1 bis v_n Vektoren eines Vektorraums V und lambda_1 bis lambda_n Skalare des zugrunde liegenden Körpers. Dann heißt die Summe lambda_1 v_1 plus lambda_2 v_2 bis plus lambda_n v_n eine Linearkombination der Vektoren v_1 bis v_n.', '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n', '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n', 'adapted', 59, 'Der Vektorraum V sowie Vektoraddition und Skalarmultiplikation sind definiert.', 'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 18),
(17, '3.2.17', 18, 'Spannraum', 'Der Spannraum einer endlichen Vektormenge ist die Menge aller Linearkombinationen dieser Vektoren. Er ist der kleinste Untervektorraum, der sämtliche betrachteten Vektoren enthält.', '\\operatorname{span}(v_1,\\ldots,v_n)=\\left\\{\\sum_{i=1}^{n}\\lambda_i v_i\\mid\\lambda_i\\in\\mathbb{R}\\right\\}', '\\operatorname{span}(v_1,\\ldots,v_n)=\\left\\{\\sum_{i=1}^{n}\\lambda_i v_i\\mid\\lambda_i\\in\\mathbb{R}\\right\\}', 'adapted', 59, 'Linearkombinationen und Untervektorräume sind definiert.', 'Etablierte Definition des linearen Spannraums.', 'verified', 18),
(18, '3.2.18', 19, 'Lineare Unabhängigkeit', 'Die Vektoren v_1 bis v_n heißen linear unabhängig, wenn aus einer Linearkombination mit Ergebnis Nullvektor notwendig folgt, dass sämtliche Koeffizienten null sind.', '\\lambda_1v_1+\\cdots+\\lambda_nv_n=0_V\\Rightarrow\\lambda_1=\\cdots=\\lambda_n=0', '\\lambda_1v_1+\\cdots+\\lambda_nv_n=0_V\\Rightarrow\\lambda_1=\\cdots=\\lambda_n=0', 'adapted', 59, 'Die vorausgehenden Begriffe sind definiert.', 'Etablierte Definition.', 'verified', 19),
(19, '3.2.19', 19, 'Lineare Abhängigkeit', 'Eine Vektormenge heißt linear abhängig, wenn eine nichttriviale Linearkombination ihrer Vektoren den Nullvektor ergibt.', '\\sum_{i=1}^{n}\\lambda_i v_i=0_V', '\\sum_{i=1}^{n}\\lambda_i v_i=0_V', 'adapted', 59, 'Die vorausgehenden Begriffe sind definiert.', 'Etablierte Definition.', 'verified', 19),
(20, '3.2.20', 19, 'Basis', 'Eine Basis eines Vektorraums ist ein linear unabhängiges Erzeugendensystem dieses Vektorraums.', 'B=(b_1,\\ldots,b_n),\\quad V=\\operatorname{span}(b_1,\\ldots,b_n)', 'B=(b_1,\\ldots,b_n),\\quad V=\\operatorname{span}(b_1,\\ldots,b_n)', 'adapted', 59, 'Die vorausgehenden Begriffe sind definiert.', 'Etablierte Definition.', 'verified', 19),
(21, '3.2.21', 19, 'Dimension', 'Besitzt ein Vektorraum eine endliche Basis mit n Elementen, so heißt n die Dimension des Vektorraums.', '\\dim(V)=n', '\\dim(V)=n', 'adapted', 59, 'Die vorausgehenden Begriffe sind definiert.', 'Etablierte Definition.', 'verified', 19),
(22, '3.2.22', 21, 'Determinante einer quadratischen Matrix', 'Die Determinante einer quadratischen Matrix A ist eine reelle Zahl und beschreibt den orientierten Volumenskalierungsfaktor der zugehörigen linearen Abbildung.', '\\det:\\mathbb{R}^{n\\times n}\\rightarrow\\mathbb{R}', '\\det:\\mathbb{R}^{n\\times n}\\rightarrow\\mathbb{R}', 'adapted', 59, 'Quadratische Matrizen und lineare Abbildungen sind definiert.', 'Etablierte Definition; keine FRZK-spezifische Eigenleistung.', 'verified', 21),
(23, '3.2.23', 22, 'Bild einer linearen Abbildung', 'Das Bild einer linearen Abbildung T:V→W ist die Menge aller Vektoren des Zielraums, die als T(v) für mindestens ein v aus V entstehen.', '\\operatorname{Bild}(T)=\\{\\,T(v)\\mid v\\in V\\,\\}', '\\operatorname{Bild}(T)=\\{\\,T(v)\\mid v\\in V\\,\\}', 'adapted', 59, 'Lineare Abbildungen und endlichdimensionale Vektorräume sind definiert.', 'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 22),
(24, '3.2.24', 22, 'Kern einer linearen Abbildung', 'Der Kern einer linearen Abbildung T:V→W ist die Menge aller Vektoren des Definitionsbereichs, die auf den Nullvektor des Zielraums abgebildet werden.', '\\ker(T)=\\{\\,v\\in V\\mid T(v)=0_W\\,\\}', '\\ker(T)=\\{\\,v\\in V\\mid T(v)=0_W\\,\\}', 'adapted', 59, 'Lineare Abbildungen und endlichdimensionale Vektorräume sind definiert.', 'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 22),
(25, '3.2.25', 22, 'Rang einer linearen Abbildung', 'Der Rang einer linearen Abbildung ist die Dimension ihres Bildes.', '\\operatorname{rang}(T)=\\dim(\\operatorname{Bild}(T))', '\\operatorname{rang}(T)=\\dim(\\operatorname{Bild}(T))', 'adapted', 59, 'Lineare Abbildungen und endlichdimensionale Vektorräume sind definiert.', 'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 22),
(26, '3.2.26', 23, 'Eigenvektor und Eigenwert', 'Ein von null verschiedener Vektor v heißt Eigenvektor eines linearen Operators T, wenn T(v)=λv gilt. λ heißt Eigenwert.', 'T(v)=\\lambda v', 'T(v)=\\lambda v', 'adapted', 59, 'Lineare Operatoren und endlichdimensionale Vektorräume sind definiert.', 'Etablierte lineare Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 23),
(27, '3.2.27', 23, 'Charakteristisches Polynom', 'Das charakteristische Polynom einer quadratischen Matrix A ist p_A(λ)=det(A-λI). Seine Nullstellen sind die Eigenwerte.', 'p_A(\\lambda)=\\det(A-\\lambda I)', 'p_A(\\lambda)=\\det(A-\\lambda I)', 'adapted', 59, 'Lineare Operatoren und endlichdimensionale Vektorräume sind definiert.', 'Etablierte lineare Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 23),
(28, '3.2.28', 23, 'Eigenraum', 'Der Eigenraum zu λ ist der Kern von A-λI und enthält den Nullvektor sowie alle zu λ gehörenden Eigenvektoren.', 'E_\\lambda=\\ker(A-\\lambda I)', 'E_\\lambda=\\ker(A-\\lambda I)', 'adapted', 59, 'Lineare Operatoren und endlichdimensionale Vektorräume sind definiert.', 'Etablierte lineare Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 23),
(29, '3.2.29', 24, 'Orthogonalität', '', NULL, NULL, 'original', NULL, NULL, NULL, 'verified', 24),
(30, '3.2.30', 24, 'Normierter Vektor', '', NULL, NULL, 'original', NULL, NULL, NULL, 'verified', 24),
(31, '3.2.31', 24, 'Orthonormalsystem', '', NULL, NULL, 'original', NULL, NULL, NULL, 'verified', 24),
(32, '3.2.32', 24, 'Orthonormalbasis', '', NULL, NULL, 'original', NULL, NULL, NULL, 'verified', 24),
(33, '3.2.33', 25, 'Transponierte Matrix', 'Die transponierte Matrix entsteht durch Vertauschen von Zeilen und Spalten.', 'A^{\\mathrm T}=(a_{ji})', 'A^{\\mathrm T}=(a_{ji})', 'adapted', 59, 'Reelle Matrizen, Vektorräume, Skalarprodukte und Eigenwerte sind definiert.', 'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 25),
(34, '3.2.34', 25, 'Symmetrische Matrix', 'Eine quadratische Matrix A heißt symmetrisch, wenn A^T=A gilt.', 'A^{\\mathrm T}=A', 'A^{\\mathrm T}=A', 'adapted', 59, 'Reelle Matrizen, Vektorräume, Skalarprodukte und Eigenwerte sind definiert.', 'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 25),
(35, '3.2.35', 25, 'Schiefsymmetrische Matrix', 'Eine quadratische Matrix A heißt schiefsymmetrisch, wenn A^T=-A gilt.', 'A^{\\mathrm T}=-A', 'A^{\\mathrm T}=-A', 'adapted', 59, 'Reelle Matrizen, Vektorräume, Skalarprodukte und Eigenwerte sind definiert.', 'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 25),
(36, '3.2.36', 25, 'Positiv definite Matrix', 'Eine reelle symmetrische Matrix A heißt positiv definit, wenn x^T A x für jeden von null verschiedenen Vektor x positiv ist.', 'x^{\\mathrm T}Ax>0\\qquad\\forall x\\neq0', 'x^{\\mathrm T}Ax>0\\qquad\\forall x\\neq0', 'adapted', 59, 'Reelle Matrizen, Vektorräume, Skalarprodukte und Eigenwerte sind definiert.', 'Etablierte Definition der linearen Algebra; keine FRZK-spezifische Eigenleistung.', 'verified', 25),
(37, '3.2.37', 26, 'Diagonalisierbare Matrix', 'Eine quadratische Matrix A heißt diagonalisierbar, wenn eine invertierbare Matrix P und eine Diagonalmatrix D existieren, sodass P^{-1}AP=D gilt.', 'P^{-1}AP=D', 'P^{-1}AP=D', 'adapted', 59, 'Grundbegriffe der linearen Algebra, Eigenwerte, Eigenvektoren und charakteristisches Polynom sind definiert.', 'Literaturgrundlagen: [71], [74] und [82].', 'verified', 29),
(38, '3.2.38', 26, 'Algebraische Vielfachheit', 'Die algebraische Vielfachheit eines Eigenwertes ist seine Vielfachheit als Nullstelle des charakteristischen Polynoms.', 'p_A(\\lambda)=(\\lambda-\\lambda_0)^m q(\\lambda)', 'p_A(\\lambda)=(\\lambda-\\lambda_0)^m q(\\lambda)', 'adapted', 59, 'Grundbegriffe der linearen Algebra, Eigenwerte, Eigenvektoren und charakteristisches Polynom sind definiert.', 'Literaturgrundlagen: [71], [74] und [82].', 'verified', 29),
(39, '3.2.39', 26, 'Geometrische Vielfachheit', 'Die geometrische Vielfachheit eines Eigenwertes ist die Dimension seines Eigenraumes.', 'm_{\\mathrm{geo}}(\\lambda)=\\dim\\ker(A-\\lambda I)', 'm_{\\mathrm{geo}}(\\lambda)=\\dim\\ker(A-\\lambda I)', 'adapted', 59, 'Grundbegriffe der linearen Algebra, Eigenwerte, Eigenvektoren und charakteristisches Polynom sind definiert.', 'Literaturgrundlagen: [71], [74] und [82].', 'verified', 29),
(40, '3.2.40', 27, 'Matrixzerlegung', 'Eine Matrixzerlegung ist eine Darstellung einer Matrix als Produkt oder Summe strukturell einfacherer Matrizen, die besondere Eigenschaften wie Dreiecksform, Orthogonalität, Diagonalform oder positive Definitheit besitzen.', 'A=A_1A_2\\cdots A_k\\quad\\text{oder}\\quad A=A_1+A_2+\\cdots+A_k', 'A=A_1A_2\\cdots A_k\\quad\\text{oder}\\quad A=A_1+A_2+\\cdots+A_k', 'adapted', 72, 'Reelle Matrizen mit den jeweils im Abschnitt angegebenen Strukturvoraussetzungen.', 'Etablierte Definition der linearen beziehungsweise numerischen Algebra.', 'verified', 30),
(41, '3.2.41', 27, 'LU-Zerlegung', 'Eine Darstellung A=LU heißt LU-Zerlegung, wenn L eine untere und U eine obere Dreiecksmatrix ist. Mit Pivotisierung wird allgemeiner PA=LU verwendet.', 'A=LU\\quad\\text{bzw.}\\quad PA=LU', 'A=LU\\quad\\text{bzw.}\\quad PA=LU', 'adapted', 72, 'Reelle Matrizen mit den jeweils im Abschnitt angegebenen Strukturvoraussetzungen.', 'Etablierte Definition der linearen beziehungsweise numerischen Algebra.', 'verified', 30),
(42, '3.2.42', 27, 'QR-Zerlegung', 'Eine Darstellung A=QR heißt QR-Zerlegung, wenn die Spalten von Q orthonormal sind und R eine obere Dreiecksmatrix ist.', 'A=QR,\\qquad Q^{\\mathsf T}Q=I_n', 'A=QR,\\qquad Q^{\\mathsf T}Q=I_n', 'adapted', 72, 'Reelle Matrizen mit den jeweils im Abschnitt angegebenen Strukturvoraussetzungen.', 'Etablierte Definition der linearen beziehungsweise numerischen Algebra.', 'verified', 30),
(43, '3.2.43', 27, 'Cholesky-Zerlegung', 'Ist A reell, symmetrisch und positiv definit, so heißt die eindeutige Darstellung A=LL^T mit unterer Dreiecksmatrix L und positiven Diagonalelementen Cholesky-Zerlegung.', 'A=LL^{\\mathsf T}', 'A=LL^{\\mathsf T}', 'adapted', 72, 'Reelle Matrizen mit den jeweils im Abschnitt angegebenen Strukturvoraussetzungen.', 'Etablierte Definition der linearen beziehungsweise numerischen Algebra.', 'verified', 30),
(51, '3.2.44', 29, 'Vektornorm', 'Eine Abbildung ||·|| von einem reellen Vektorraum V nach R heißt Norm, wenn Nichtnegativität, Definitheit, absolute Homogenität und Dreiecksungleichung erfüllt sind.', '|cdot|:V\rightarrowmathbb{R}', '|cdot|:V\rightarrowmathbb{R}', 'adapted', 70, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'Etablierte Definition aus linearer beziehungsweise numerischer Algebra.', 'verified', 32),
(52, '3.2.45', 29, 'Induzierte Matrixnorm', 'Die zu einer Vektornorm induzierte Matrixnorm ist die größte Verstärkung eines von null verschiedenen Vektors durch die Matrix.', '|A|=sup_{x\neq 0}frac{|Ax|}{|x|}', '|A|=sup_{x\neq 0}frac{|Ax|}{|x|}', 'adapted', 72, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'Etablierte Definition aus linearer beziehungsweise numerischer Algebra.', 'verified', 32),
(53, '3.2.46', 29, 'Frobeniusnorm', 'Die Frobeniusnorm einer Matrix ist die Quadratwurzel aus der Summe der Quadrate aller Matrixeinträge.', '|A|_{mathrm F}=sqrt{sum_{i=1}^{m}sum_{j=1}^{n}|a_{ij}|^2}', '|A|_{mathrm F}=sqrt{sum_{i=1}^{m}sum_{j=1}^{n}|a_{ij}|^2}', 'adapted', 72, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'Etablierte Definition aus linearer beziehungsweise numerischer Algebra.', 'verified', 32),
(54, '3.2.47', 29, 'Absolute und relative Abweichung', 'Die absolute Abweichung ist die Differenz zwischen Näherungswert und exaktem Wert. Die relative Abweichung setzt deren Norm zur Norm des Bezugswertes ins Verhältnis.', 'Delta x=widetilde{x}-x,qquaddelta_x=frac{|widetilde{x}-x|}{|x|}', 'Delta x=widetilde{x}-x,qquaddelta_x=frac{|widetilde{x}-x|}{|x|}', 'adapted', 74, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'Etablierte Definition aus linearer beziehungsweise numerischer Algebra.', 'verified', 32),
(55, '3.2.48', 29, 'Konditionszahl einer Matrix', 'Für eine invertierbare quadratische Matrix ist die Konditionszahl bezüglich einer induzierten Norm das Produkt aus der Norm der Matrix und der Norm ihrer Inversen.', 'kappa(A)=|A|,|A^{-1}|', 'kappa(A)=|A|,|A^{-1}|', 'adapted', 72, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'Etablierte Definition aus linearer beziehungsweise numerischer Algebra.', 'verified', 32),
(56, '3.2.49', 29, 'Gut und schlecht konditioniertes Problem', 'Ein Problem ist gut konditioniert, wenn kleine Eingabeänderungen nur kleine Lösungsänderungen verursachen, und schlecht konditioniert, wenn kleine Eingabeänderungen stark vergrößerte Lösungsänderungen hervorrufen können.', 'kappa(A)', 'kappa(A)', 'adapted', 74, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'Etablierte Definition aus linearer beziehungsweise numerischer Algebra.', 'verified', 32),
(57, '3.2.50', 29, 'Numerische Stabilität', 'Ein Verfahren heißt vorwärtsstabil, wenn das berechnete Ergebnis nahe der exakten Lösung liegt, und rückwärtsstabil, wenn es die exakte Lösung eines nur geringfügig gestörten Ausgangsproblems ist.', '(A+Delta A)widetilde{x}=b+Delta b', '(A+Delta A)widetilde{x}=b+Delta b', 'adapted', 74, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'Etablierte Definition aus linearer beziehungsweise numerischer Algebra.', 'verified', 32),
(58, '3.2.51', 30, 'Moore-Penrose-Pseudoinverse', 'Die Matrix A+ heißt Moore-Penrose-Pseudoinverse von A, wenn sie die vier Penrose-Bedingungen AA+A=A, A+AA+=A+, (AA+)^T=AA+ und (A+A)^T=A+A erfüllt.', 'AA^{+}A=A,qquad A^{+}AA^{+}=A^{+},qquadleft(AA^{+}\right)^{mathsf T}=AA^{+},qquadleft(A^{+}A\right)^{mathsf T}=A^{+}A', 'AA^{+}A=A,qquad A^{+}AA^{+}=A^{+},qquadleft(AA^{+}\right)^{mathsf T}=AA^{+},qquadleft(A^{+}A\right)^{mathsf T}=A^{+}A', 'adapted', 75, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'Etablierte Definition aus linearer Algebra, numerischer Mathematik oder Regularisierungstheorie.', 'verified', 33),
(59, '3.2.52', 30, 'Ausgleichslösung', 'Eine Ausgleichslösung minimiert die euklidische Norm des Residualvektors Ax-b.', 'x_{mathrm{LS}}inoperatorname*{arg,min}_{xinmathbb{R}^{n}}|Ax-b|_2', 'x_{mathrm{LS}}inoperatorname*{arg,min}_{xinmathbb{R}^{n}}|Ax-b|_2', 'adapted', 62, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'Etablierte Definition aus linearer Algebra, numerischer Mathematik oder Regularisierungstheorie.', 'verified', 33),
(60, '3.2.53', 30, 'Lösung kleinster Norm', 'Eine Lösung kleinster Norm erfüllt Ax=b und besitzt unter allen Lösungen die kleinste euklidische Norm.', '|x_{min}|_2=minleft{|x|_2mid Ax=b\right}', '|x_{min}|_2=minleft{|x|_2mid Ax=b\right}', 'adapted', 75, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'Etablierte Definition aus linearer Algebra, numerischer Mathematik oder Regularisierungstheorie.', 'verified', 33),
(61, '3.2.54', 30, 'Regularisiertes Ausgleichsproblem', 'Ein regularisiertes Ausgleichsproblem ergänzt die Residualminimierung durch einen gewichteten Regularisierungsterm.', 'x_{lambda}inoperatorname*{arg,min}_{x}left(|Ax-b|_2^2+lambdamathcal{R}(x)\right)', 'x_{lambda}inoperatorname*{arg,min}_{x}left(|Ax-b|_2^2+lambdamathcal{R}(x)\right)', 'adapted', 76, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'Etablierte Definition aus linearer Algebra, numerischer Mathematik oder Regularisierungstheorie.', 'verified', 33),
(62, '3.2.55', 30, 'Tikhonov-Regularisierung', 'Die Tikhonov-Regularisierung minimiert die Summe aus quadratischer Residualnorm und dem gewichteten quadratischen Regularisierungsterm.', 'J_{lambda}(x)=|Ax-b|_2^2+lambda|Lx|_2^2', 'J_{lambda}(x)=|Ax-b|_2^2+lambda|Lx|_2^2', 'adapted', 76, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'Etablierte Definition aus linearer Algebra, numerischer Mathematik oder Regularisierungstheorie.', 'verified', 33),
(63, '3.2.56', 30, 'Abgeschnittene Singulärwertzerlegung', 'Bei der abgeschnittenen Singulärwertzerlegung werden nur Singulärwerte oberhalb eines festgelegten Schwellenwertes invertiert.', 'A_{	au}^{+}=sum_{sigma_i>	au}frac{1}{sigma_i}v_i u_i^{mathsf T}', 'A_{	au}^{+}=sum_{sigma_i>	au}frac{1}{sigma_i}v_i u_i^{mathsf T}', 'adapted', 76, 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'Etablierte Definition aus linearer Algebra, numerischer Mathematik oder Regularisierungstheorie.', 'verified', 33),
(65, '3.2.57', 31, 'Stationäres Iterationsverfahren', 'Iteration mit fester Matrix B und konstantem Vektor c.', 'x^{(k+1)}=Bx^{(k)}+c', 'x^{(k+1)}=Bx^{(k)}+c', 'adapted', 77, 'Reelle endlichdimensionale Räume.', 'Etablierte Definition der numerischen linearen Algebra.', 'verified', 34),
(66, '3.2.58', 31, 'Iterationsfehler', 'Differenz zwischen exakter Lösung und aktueller Näherung.', 'e^{(k)}=x^ast-x^{(k)}', 'e^{(k)}=x^ast-x^{(k)}', 'adapted', 77, 'Reelle endlichdimensionale Räume.', 'Etablierte Definition der numerischen linearen Algebra.', 'verified', 34),
(67, '3.2.59', 31, 'Residuum eines Iterationsschrittes', 'Abweichung der Näherung von der Systemgleichung.', 'r^{(k)}=b-Ax^{(k)}', 'r^{(k)}=b-Ax^{(k)}', 'adapted', 74, 'Reelle endlichdimensionale Räume.', 'Etablierte Definition der numerischen linearen Algebra.', 'verified', 34),
(68, '3.2.60', 31, 'Strikte Diagonaldominanz', 'Der Betrag jedes Diagonaleintrags übersteigt die Summe der übrigen Beträge seiner Zeile.', '|a_{ii}|>sum_{substack{j=1\\j\neq i}}^n|a_{ij}|', '|a_{ii}|>sum_{substack{j=1\\j\neq i}}^n|a_{ij}|', 'adapted', 77, 'Reelle endlichdimensionale Räume.', 'Etablierte Definition der numerischen linearen Algebra.', 'verified', 34),
(69, '3.2.61', 31, 'Konvergenzordnung', 'Asymptotische Beziehung zwischen aufeinanderfolgenden Fehlern.', '|x^{(k+1)}-x^ast|leq C|x^{(k)}-x^ast|^p', '|x^{(k+1)}-x^ast|leq C|x^{(k)}-x^ast|^p', 'adapted', 77, 'Reelle endlichdimensionale Räume.', 'Etablierte Definition der numerischen linearen Algebra.', 'verified', 34),
(70, '3.2.62', 31, 'Vorkonditioniertes Gleichungssystem', 'Transformation eines Systems durch einen einfach invertierbaren Vorkonditionierer.', 'P^{-1}Ax=P^{-1}b', 'P^{-1}Ax=P^{-1}b', 'adapted', 77, 'Reelle endlichdimensionale Räume.', 'Etablierte Definition der numerischen linearen Algebra.', 'verified', 34),
(72, '3.2.63', 32, 'Nichtlineares Gleichungssystem', 'Vektorwertige Gleichung F(x)=0 mit nicht ausschließlich linearen Komponenten.', 'F(x)=0', 'F(x)=0', 'adapted', 78, 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'Definition der nichtlinearen numerischen Analysis.', 'verified', 35),
(73, '3.2.64', 32, 'Jacobi-Matrix einer nichtlinearen Abbildung', 'Matrix sämtlicher erster partieller Ableitungen.', 'J_F(x)=\\left(\\frac{\\partial f_i}{\\partial x_j}(x)\\right)', 'J_F(x)=\\left(\\frac{\\partial f_i}{\\partial x_j}(x)\\right)', 'adapted', 78, 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'Definition der nichtlinearen numerischen Analysis.', 'verified', 35),
(74, '3.2.65', 32, 'Newton-Schritt', 'Lösung des lokal linearisierten Systems.', 'J_F(x^{(k)})s^{(k)}=-F(x^{(k)})', 'J_F(x^{(k)})s^{(k)}=-F(x^{(k)})', 'adapted', 78, 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'Definition der nichtlinearen numerischen Analysis.', 'verified', 35),
(75, '3.2.66', 32, 'Gedämpftes Newton-Verfahren', 'Gewichteter Newton-Schritt mit 0<alpha_k<=1.', 'x^{(k+1)}=x^{(k)}+\\alpha_k s^{(k)}', 'x^{(k+1)}=x^{(k)}+\\alpha_k s^{(k)}', 'adapted', 78, 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'Definition der nichtlinearen numerischen Analysis.', 'verified', 35),
(76, '3.2.67', 32, 'Quasi-Newton-Verfahren', 'Ersetzung der exakten Jacobi-Matrix durch eine aktualisierte Näherungsmatrix.', 'B_k s^{(k)}=-F(x^{(k)})', 'B_k s^{(k)}=-F(x^{(k)})', 'adapted', 78, 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'Definition der nichtlinearen numerischen Analysis.', 'verified', 35),
(77, '3.2.68', 32, 'Fixpunktiteration', 'Iteration einer äquivalenten Gleichung x=G(x).', 'x^{(k+1)}=G(x^{(k)})', 'x^{(k+1)}=G(x^{(k)})', 'adapted', 78, 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'Definition der nichtlinearen numerischen Analysis.', 'verified', 35),
(79, '3.2.69', 34, 'Gewöhnliche Differentialgleichung erster Ordnung', 'Differentialgleichung erster Ordnung.', '\\dot{x}=f(t,x)', '\\dot{x}=f(t,x)', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(80, '3.2.70', 34, 'Anfangswertproblem', 'Differentialgleichung mit Anfangszustand.', '\\dot{x}(t)=f(t,x(t)),\\qquad x(t_0)=x_0', '\\dot{x}(t)=f(t,x(t)),\\qquad x(t_0)=x_0', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(81, '3.2.71', 34, 'Klassische Lösung', 'Stetig differenzierbare punktweise Lösung.', '\\dot{x}(t)=f(t,x(t))', '\\dot{x}(t)=f(t,x(t))', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(82, '3.2.72', 34, 'Fluss eines autonomen Systems', 'Zeitentwicklungsabbildung.', '\\Phi_t(x_0)=x(t;x_0)', '\\Phi_t(x_0)=x(t;x_0)', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(83, '3.2.73', 34, 'Trajektorie', 'Weg eines Zustands durch den Zustandsraum.', '\\mathcal{T}(x_0)=\\{\\Phi_t(x_0)\\mid t\\in I\\}', '\\mathcal{T}(x_0)=\\{\\Phi_t(x_0)\\mid t\\in I\\}', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(84, '3.2.74', 34, 'Gleichgewichtspunkt', 'Zustand mit verschwindendem Vektorfeld.', 'f(x^\\ast)=0', 'f(x^\\ast)=0', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(85, '3.2.75', 34, 'Matrixexponentialfunktion', 'Potenzreihendefinition der Matrixexponentialfunktion.', '\\mathrm{e}^{tA}=\\sum_{k=0}^{\\infty}\\frac{t^kA^k}{k!}', '\\mathrm{e}^{tA}=\\sum_{k=0}^{\\infty}\\frac{t^kA^k}{k!}', 'adapted', 72, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(86, '3.2.76', 34, 'Stabilität im Sinne von Ljapunow', 'Kleine Anfangsabweichungen bleiben klein.', '\\|x(0)-x^\\ast\\|<\\delta\\Rightarrow\\|x(t)-x^\\ast\\|<\\varepsilon', '\\|x(0)-x^\\ast\\|<\\delta\\Rightarrow\\|x(t)-x^\\ast\\|<\\varepsilon', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(87, '3.2.77', 34, 'Asymptotische Stabilität', 'Stabilität mit Konvergenz zum Gleichgewicht.', 'x(t)\\rightarrow x^\\ast', 'x(t)\\rightarrow x^\\ast', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(88, '3.2.78', 34, 'Hyperbolischer Gleichgewichtspunkt', 'Kein Eigenwert liegt auf der imaginären Achse.', '\\operatorname{Re}(\\lambda_i)\\neq0', '\\operatorname{Re}(\\lambda_i)\\neq0', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(89, '3.2.79', 34, 'Explizites Euler-Verfahren', 'Explizites Einschrittverfahren erster Ordnung.', 'x^{(k+1)}=x^{(k)}+hf(t_k,x^{(k)})', 'x^{(k+1)}=x^{(k)}+hf(t_k,x^{(k)})', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(90, '3.2.80', 34, 'Implizites Euler-Verfahren', 'Implizites Einschrittverfahren.', 'x^{(k+1)}=x^{(k)}+hf(t_{k+1},x^{(k+1)})', 'x^{(k+1)}=x^{(k)}+hf(t_{k+1},x^{(k+1)})', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(91, '3.2.81', 34, 'Konsistenz eines Zeitintegrationsverfahrens', 'Lokaler Fehler verschwindet für h gegen null.', '\\tau_k\\rightarrow0', '\\tau_k\\rightarrow0', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(92, '3.2.82', 34, 'Konvergenz eines Zeitintegrationsverfahrens', 'Diskrete Lösung nähert sich der exakten Lösung.', '\\max_k\\|x(t_k)-x^{(k)}\\|\\rightarrow0', '\\max_k\\|x(t_k)-x^{(k)}\\|\\rightarrow0', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(93, '3.2.83', 34, 'Steifes Differentialgleichungssystem', 'System mit stark verschiedenen Zeitskalen.', '|\\operatorname{Re}(\\lambda_{\\max})|\\gg|\\operatorname{Re}(\\lambda_{\\min})|', '|\\operatorname{Re}(\\lambda_{\\max})|\\gg|\\operatorname{Re}(\\lambda_{\\min})|', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(94, '3.2.84', 34, 'Adaptive Schrittweitensteuerung', 'Fehlerabhängige Anpassung der Schrittweite.', 'h_{\\mathrm{neu}}=\\eta h_{\\mathrm{alt}}\\left(\\frac{\\mathrm{TOL}}{E_k}\\right)^{\\frac{1}{p+1}}', 'h_{\\mathrm{neu}}=\\eta h_{\\mathrm{alt}}\\left(\\frac{\\mathrm{TOL}}{E_k}\\right)^{\\frac{1}{p+1}}', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'Etablierte Definition.', 'verified', 37),
(110, '3.2.100', 35, 'Lokale Erhaltungsgleichung', 'Bilanz aus gespeicherter Dichte, Fluss und Quelle.', 'frac{partial u}{partial t}+\nablacdot q=s', 'frac{partial u}{partial t}+\nablacdot q=s', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(111, '3.2.101', 35, 'Räumlich homogener Zustand', 'Zustand ohne Abhängigkeit vom Ortsparameter.', 'u(t,xi)=ar u(t)', 'u(t,xi)=ar u(t)', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(112, '3.2.102', 35, 'Feldzustand', 'Zustand als Funktion über einem Parameterraum.', 'u:Omega\rightarrow V', 'u:Omega\rightarrow V', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(113, '3.2.85', 35, 'Partielle Differentialgleichung', 'Gleichung für eine unbekannte Funktion mehrerer unabhängiger Variablen und deren partielle Ableitungen.', 'F(xi,u,\nabla u,\nabla^2u,ldots,\nabla^mu)=0', 'F(xi,u,\nabla u,\nabla^2u,ldots,\nabla^mu)=0', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(114, '3.2.86', 35, 'Partielle Ableitung', 'Grenzwertige lokale Änderung einer Funktion in einer Koordinatenrichtung.', 'frac{partial u}{partial xi_i}(xi)=lim_{h	o0}frac{u(xi+he_i)-u(xi)}{h}', 'frac{partial u}{partial xi_i}(xi)=lim_{h	o0}frac{u(xi+he_i)-u(xi)}{h}', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(115, '3.2.87', 35, 'Divergenz', 'Lokale Quellen- oder Senkenwirkung eines Vektorfeldes.', '\nablacdot q=sum_{i=1}^dfrac{partial q_i}{partial xi_i}', '\nablacdot q=sum_{i=1}^dfrac{partial q_i}{partial xi_i}', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(116, '3.2.88', 35, 'Laplace-Operator', 'Divergenz des Gradienten einer skalaren Funktion.', 'Delta u=\nablacdot\nabla u', 'Delta u=\nablacdot\nabla u', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(117, '3.2.89', 35, 'Quasilineare partielle Differentialgleichung', 'PDE, deren höchste Ableitungen linear auftreten.', 'sum_{i,j}a_{ij}(xi,u,\nabla u)u_{xi_ixi_j}=f(xi,u,\nabla u)', 'sum_{i,j}a_{ij}(xi,u,\nabla u)u_{xi_ixi_j}=f(xi,u,\nabla u)', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(118, '3.2.90', 35, 'Elliptische partielle Differentialgleichung', 'PDE mit definiter Koeffizientenmatrix der höchsten Ableitungen.', 'sum_{i,j}a_{ij}v_iv_j>0', 'sum_{i,j}a_{ij}v_iv_j>0', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(119, '3.2.91', 35, 'Parabolische partielle Differentialgleichung', 'PDE des Diffusions- und Ausgleichstyps.', 'frac{partial u}{partial t}-kappaDelta u=0', 'frac{partial u}{partial t}-kappaDelta u=0', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(120, '3.2.92', 35, 'Hyperbolische partielle Differentialgleichung', 'PDE des Wellen- und Ausbreitungstyps.', 'frac{partial^2u}{partial t^2}-c^2Delta u=0', 'frac{partial^2u}{partial t^2}-c^2Delta u=0', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(121, '3.2.93', 35, 'Dirichlet-Randbedingung', 'Vorgabe des Funktionswertes auf dem Rand.', 'u=g	ext{ auf }partialOmega', 'u=g	ext{ auf }partialOmega', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(122, '3.2.94', 35, 'Neumann-Randbedingung', 'Vorgabe der Normalenableitung auf dem Rand.', 'frac{partial u}{partial n}=g', 'frac{partial u}{partial n}=g', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(123, '3.2.95', 35, 'Robin-Randbedingung', 'Lineare Kombination aus Funktionswert und Normalenableitung.', 'alpha u+etafrac{partial u}{partial n}=g', 'alpha u+etafrac{partial u}{partial n}=g', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(124, '3.2.96', 35, 'Anfangs-Randwertproblem', 'PDE mit Anfangs- und Randbedingungen.', '	ext{PDE}+	ext{Anfangsbedingung}+	ext{Randbedingung}', '	ext{PDE}+	ext{Anfangsbedingung}+	ext{Randbedingung}', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(125, '3.2.97', 35, 'Testfunktion', 'Glatte Funktion mit kompaktem Träger.', 'varphiin C_c^infty(Omega)', 'varphiin C_c^infty(Omega)', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(126, '3.2.98', 35, 'Schwache Lösung der Poisson-Gleichung', 'Funktion, die die variationale Form der Poisson-Gleichung erfüllt.', 'int_Omega\nabla ucdot\nablavarphi=int_Omega fvarphi', 'int_Omega\nabla ucdot\nablavarphi=int_Omega fvarphi', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(127, '3.2.99', 35, 'Sobolev-Raum H1', 'Raum quadratintegrierbarer Funktionen mit quadratintegrierbaren schwachen ersten Ableitungen.', 'H^1(Omega)={uin L^2(Omega):partial_i uin L^2(Omega)}', 'H^1(Omega)={uin L^2(Omega):partial_i uin L^2(Omega)}', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'Etablierte Definition aus der Theorie partieller Differentialgleichungen.', 'verified', 38),
(172, '3.2.103', 37, 'Integraloperator', 'Operator, der eine Funktion durch Integration gegen einen Kern abbildet.', '(\\mathcal{K}u)(x)=\\int_\\Omega K(x,\\xi)u(\\xi)\\,\\mathrm{d}\\xi', '(\\mathcal{K}u)(x)=\\int_\\Omega K(x,\\xi)u(\\xi)\\,\\mathrm{d}\\xi', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(173, '3.2.104', 37, 'Lineare Integralgleichung', 'Integralgleichung mit linear auftretender unbekannter Funktion.', 'u=f+\\lambda\\mathcal{K}u', 'u=f+\\lambda\\mathcal{K}u', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(174, '3.2.105', 37, 'Fredholmsche Integralgleichung erster Art', 'Integralgleichung mit festen Grenzen und unbekannter Funktion nur unter dem Integral.', '\\mathcal{K}u=f', '\\mathcal{K}u=f', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(175, '3.2.106', 37, 'Fredholmsche Integralgleichung zweiter Art', 'Fredholm-Gleichung mit unbekannter Funktion außerhalb und innerhalb des Integrals.', '(I-\\lambda\\mathcal{K})u=f', '(I-\\lambda\\mathcal{K})u=f', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(176, '3.2.107', 37, 'Volterrasche Integralgleichung erster Art', 'Integralgleichung mit vom Auswertungspunkt abhängiger oberer Grenze.', 'f(t)=\\int_{t_0}^{t}K(t,\\tau)u(\\tau)\\,\\mathrm{d}\\tau', 'f(t)=\\int_{t_0}^{t}K(t,\\tau)u(\\tau)\\,\\mathrm{d}\\tau', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(177, '3.2.108', 37, 'Volterrasche Integralgleichung zweiter Art', 'Volterra-Gleichung zweiter Art mit kausaler zeitlicher Ordnung.', 'u(t)=f(t)+\\lambda\\int_{t_0}^{t}K(t,\\tau)u(\\tau)\\,\\mathrm{d}\\tau', 'u(t)=f(t)+\\lambda\\int_{t_0}^{t}K(t,\\tau)u(\\tau)\\,\\mathrm{d}\\tau', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(178, '3.2.109', 37, 'Picard-Iteration', 'Fixpunktiteration der Integralform eines Anfangswertproblems.', 'x^{(k+1)}=\\mathcal{P}x^{(k)}', 'x^{(k+1)}=\\mathcal{P}x^{(k)}', 'adapted', 80, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(179, '3.2.110', 37, 'Resolventenkern', 'Kern, der direkte und iterierte Kopplungen zusammenfasst.', 'R(x,\\xi;\\lambda)=\\sum_{n=1}^{\\infty}\\lambda^{n-1}K_n(x,\\xi)', 'R(x,\\xi;\\lambda)=\\sum_{n=1}^{\\infty}\\lambda^{n-1}K_n(x,\\xi)', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(180, '3.2.111', 37, 'Hilbert-Schmidt-Kern', 'Quadratintegrierbarer Integralkern.', '\\int_\\Omega\\int_\\Omega|K(x,\\xi)|^2\\,\\mathrm{d}\\xi\\,\\mathrm{d}x<\\infty', '\\int_\\Omega\\int_\\Omega|K(x,\\xi)|^2\\,\\mathrm{d}\\xi\\,\\mathrm{d}x<\\infty', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(181, '3.2.112', 37, 'Eigenfunktion eines Integraloperators', 'Nichttriviale Funktion, die durch den Operator skaliert wird.', '\\mathcal{K}u=\\mu u', '\\mathcal{K}u=\\mu u', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(182, '3.2.113', 37, 'Greensche Funktion', 'Punktantwort eines linearen Differentialoperators unter vorgegebenen Randbedingungen.', '\\mathcal{L}_xG(x,\\xi)=\\delta(x-\\xi)', '\\mathcal{L}_xG(x,\\xi)=\\delta(x-\\xi)', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(183, '3.2.114', 37, 'Fundamentallösung', 'Distributionelle Lösung der Operatorgleichung mit Dirac-Quelle.', '\\mathcal{L}\\Phi=\\delta', '\\mathcal{L}\\Phi=\\delta', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(184, '3.2.115', 37, 'Faltung', 'Gewichtete Überlagerung zweier Funktionen über alle Verschiebungen.', '(f*g)(x)=\\int f(x-\\xi)g(\\xi)\\,\\mathrm{d}\\xi', '(f*g)(x)=\\int f(x-\\xi)g(\\xi)\\,\\mathrm{d}\\xi', 'adapted', 81, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(185, '3.2.116', 37, 'Nichtlokaler Operator', 'Operator, dessen Wert nicht allein aus einer beliebig kleinen Umgebung bestimmt wird.', '(\\mathcal{N}u)(x)=\\int_\\Omega K(x,\\xi)u(\\xi)\\,\\mathrm{d}\\xi', '(\\mathcal{N}u)(x)=\\int_\\Omega K(x,\\xi)u(\\xi)\\,\\mathrm{d}\\xi', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(186, '3.2.117', 37, 'Normierter Integralkern', 'Nichtnegativer Kern mit Integral eins.', '\\int_\\Omega K(x,\\xi)\\,\\mathrm{d}\\xi=1', '\\int_\\Omega K(x,\\xi)\\,\\mathrm{d}\\xi=1', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(187, '3.2.118', 37, 'Nichtlokaler Diffusionsoperator', 'Integraloperator zum Ausgleich verteilter Zustandsdifferenzen.', '(\\mathcal{D}_Ju)(x)=\\int_\\Omega J(x,\\xi)(u(\\xi)-u(x))\\,\\mathrm{d}\\xi', '(\\mathcal{D}_Ju)(x)=\\int_\\Omega J(x,\\xi)(u(\\xi)-u(x))\\,\\mathrm{d}\\xi', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(188, '3.2.119', 37, 'Gedächtnisoperator', 'Volterra-Operator zur Gewichtung vergangener Zustände.', '(\\mathcal{M}x)(t)=\\int_{t_0}^{t}M(t,\\tau)x(\\tau)\\,\\mathrm{d}\\tau', '(\\mathcal{M}x)(t)=\\int_{t_0}^{t}M(t,\\tau)x(\\tau)\\,\\mathrm{d}\\tau', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(189, '3.2.120', 37, 'Hammerstein-Integralgleichung', 'Kombination eines linearen Integraloperators mit einer punktweisen Nichtlinearität.', 'u=f+\\lambda\\mathcal{K}\\mathcal{G}(u)', 'u=f+\\lambda\\mathcal{K}\\mathcal{G}(u)', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(190, '3.2.121', 37, 'Nyström-Verfahren', 'Quadraturbasierte Diskretisierung einer Integralgleichung.', 'U_i=F_i+\\lambda\\sum_jw_jK(x_i,\\xi_j)U_j', 'U_i=F_i+\\lambda\\sum_jw_jK(x_i,\\xi_j)U_j', 'adapted', 72, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(191, '3.2.122', 37, 'Schlecht gestelltes inverses Integralproblem', 'Inverses Problem ohne gesicherte Existenz, Eindeutigkeit oder Stabilität.', '\\mathcal{K}u=f', '\\mathcal{K}u=f', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(192, '3.2.123', 37, 'Tikhonov-Regularisierung', 'Stabilisierung eines inversen Problems durch Daten- und Regularisierungsterm.', 'u_\\alpha=\\operatorname*{arg\\,min}_u(\\|\\mathcal{K}u-f^\\delta\\|^2+\\alpha\\|\\mathcal{L}u\\|^2)', 'u_\\alpha=\\operatorname*{arg\\,min}_u(\\|\\mathcal{K}u-f^\\delta\\|^2+\\alpha\\|\\mathcal{L}u\\|^2)', 'adapted', 83, 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'Etablierte Definition.', 'verified', 40),
(203, '3.2.124', 38, 'Fourier-Transformation', 'Integraltransformation einer geeigneten Funktion in eine frequenzabhängige Spektraldarstellung.', '\\widehat{f}(\\omega)=\\int_{-\\infty}^{\\infty}f(t)\\mathrm{e}^{-\\mathrm{i}\\omega t}\\,\\mathrm{d}t', '\\widehat{f}(\\omega)=\\int_{-\\infty}^{\\infty}f(t)\\mathrm{e}^{-\\mathrm{i}\\omega t}\\,\\mathrm{d}t', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(204, '3.2.125', 38, 'Inverse Fourier-Transformation', 'Rekonstruktion einer Funktion aus ihrer Fourier-Transformierten.', 'f(t)=\\frac{1}{2\\pi}\\int_{-\\infty}^{\\infty}\\widehat{f}(\\omega)\\mathrm{e}^{\\mathrm{i}\\omega t}\\,\\mathrm{d}\\omega', 'f(t)=\\frac{1}{2\\pi}\\int_{-\\infty}^{\\infty}\\widehat{f}(\\omega)\\mathrm{e}^{\\mathrm{i}\\omega t}\\,\\mathrm{d}\\omega', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(205, '3.2.126', 38, 'Frequenzverschiebung', 'Verschiebung des Spektrums durch Multiplikation mit einer komplexen Schwingung.', '\\mathcal{F}\\left(\\mathrm{e}^{\\mathrm{i}\\omega_0t}f(t)\\right)=\\widehat{f}(\\omega-\\omega_0)', '\\mathcal{F}\\left(\\mathrm{e}^{\\mathrm{i}\\omega_0t}f(t)\\right)=\\widehat{f}(\\omega-\\omega_0)', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(206, '3.2.127', 38, 'Fourier-Multiplikator', 'Operator, der im Fourier-Raum durch punktweise Multiplikation mit einem Symbol wirkt.', '\\widehat{\\mathcal{T}u}(k)=m(k)\\widehat{u}(k)', '\\widehat{\\mathcal{T}u}(k)=m(k)\\widehat{u}(k)', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(207, '3.2.128', 38, 'Spektrale Energiedichte', 'Quadrat des Betrages einer Fourier-Transformierten.', 'S_f(\\omega)=|\\widehat{f}(\\omega)|^2', 'S_f(\\omega)=|\\widehat{f}(\\omega)|^2', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(208, '3.2.129', 38, 'Fourier-Koeffizient', 'Projektionskoeffizient einer periodischen Funktion auf eine harmonische Basisfunktion.', 'c_n=\\frac{1}{T}\\int_{t_0}^{t_0+T}f(t)\\mathrm{e}^{-\\mathrm{i}n\\omega_0t}\\,\\mathrm{d}t', 'c_n=\\frac{1}{T}\\int_{t_0}^{t_0+T}f(t)\\mathrm{e}^{-\\mathrm{i}n\\omega_0t}\\,\\mathrm{d}t', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(209, '3.2.130', 38, 'Harmonische Komponente', 'Sinus- und Kosinusanteil einer bestimmten Vielfachen der Grundfrequenz.', 'a_n\\cos(n\\omega_0t)+b_n\\sin(n\\omega_0t)', 'a_n\\cos(n\\omega_0t)+b_n\\sin(n\\omega_0t)', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(210, '3.2.131', 38, 'Spektrale Projektion', 'Projektion eines Zustands auf eine normierte Spektralbasisfunktion.', 'c_n=\\langle f,\\varphi_n\\rangle', 'c_n=\\langle f,\\varphi_n\\rangle', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(211, '3.2.132', 38, 'Spektraldarstellung eines Zustands', 'Darstellung eines Zustands als Summe oder Integral spektraler Komponenten.', 'u=\\sum_nc_n\\varphi_n', 'u=\\sum_nc_n\\varphi_n', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(212, '3.2.133', 38, 'Spektrum eines Operators', 'Menge der komplexen Zahlen, für die der verschobene Operator nicht invertierbar ist.', '\\sigma(\\mathcal{A})=\\{\\lambda\\in\\mathbb{C}\\mid \\mathcal{A}-\\lambda I\\text{ ist nicht invertierbar}\\}', '\\sigma(\\mathcal{A})=\\{\\lambda\\in\\mathbb{C}\\mid \\mathcal{A}-\\lambda I\\text{ ist nicht invertierbar}\\}', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(213, '3.2.134', 38, 'Punktspektrum', 'Teil des Spektrums, der aus den Eigenwerten eines Operators besteht.', '\\sigma_p(\\mathcal{A})=\\{\\lambda\\in\\mathbb{C}\\mid\\ker(\\mathcal{A}-\\lambda I)\\neq\\{0\\}\\}', '\\sigma_p(\\mathcal{A})=\\{\\lambda\\in\\mathbb{C}\\mid\\ker(\\mathcal{A}-\\lambda I)\\neq\\{0\\}\\}', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(214, '3.2.135', 38, 'Einseitige Laplace-Transformation', 'Integraltransformation einer Funktion auf dem nichtnegativen Zeitbereich.', 'F(s)=\\mathcal{L}\\{f\\}(s)=\\int_0^\\infty f(t)\\mathrm{e}^{-st}\\,\\mathrm{d}t', 'F(s)=\\mathcal{L}\\{f\\}(s)=\\int_0^\\infty f(t)\\mathrm{e}^{-st}\\,\\mathrm{d}t', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41);
INSERT INTO `definitions` (`definition_id`, `definition_number`, `section_id`, `title`, `definition_text`, `formal_latex`, `word_latex`, `provenance`, `source_id`, `assumptions`, `notes`, `validation_status`, `created_revision_id`) VALUES
(215, '3.2.136', 38, 'Konvergenzhalbebene', 'Bereich der komplexen Ebene, in dem die Laplace-Transformation absolut konvergiert.', '\\operatorname{Re}(s)>\\sigma_0', '\\operatorname{Re}(s)>\\sigma_0', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(216, '3.2.137', 38, 'Übertragungsfunktion', 'Quotient aus transformierter Ausgangs- und Eingangsgröße eines linearen zeitinvarianten Systems.', 'H(s)=\\frac{Y(s)}{U(s)}', 'H(s)=\\frac{Y(s)}{U(s)}', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(217, '3.2.138', 38, 'Pol einer Übertragungsfunktion', 'Stelle, an der der Betrag einer Übertragungsfunktion unbeschränkt anwächst.', '|H(s)|\\rightarrow\\infty\\quad\\text{für }s\\rightarrow s_p', '|H(s)|\\rightarrow\\infty\\quad\\text{für }s\\rightarrow s_p', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(218, '3.2.139', 38, 'Nullstelle einer Übertragungsfunktion', 'Stelle, an der eine Übertragungsfunktion den Wert null annimmt.', 'H(s_z)=0', 'H(s_z)=0', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(219, '3.2.140', 38, 'Spektrale Stabilitätsbedingung eines linearen Systems', 'Bedingung, dass alle Eigenwerte eines linearen Systems negative Realteile besitzen.', '\\operatorname{Re}(\\lambda_j)<0', '\\operatorname{Re}(\\lambda_j)<0', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(220, '3.2.141', 38, 'Diskrete Fourier-Transformation', 'Lineare Abbildung eines endlichdimensionalen Datenvektors in seine diskreten Frequenzanteile.', '(\\mathcal{F}_Nx)_k=\\sum_{n=0}^{N-1}x_n\\mathrm{e}^{-\\mathrm{i}2\\pi kn/N}', '(\\mathcal{F}_Nx)_k=\\sum_{n=0}^{N-1}x_n\\mathrm{e}^{-\\mathrm{i}2\\pi kn/N}', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(221, '3.2.142', 38, 'Aliasing', 'Mehrdeutigkeit bei der Abtastung, wenn verschiedene kontinuierliche Frequenzen dieselben diskreten Werte erzeugen.', 'f\\sim f+mf_s,\\quad m\\in\\mathbb{Z}', 'f\\sim f+mf_s,\\quad m\\in\\mathbb{Z}', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(222, '3.2.143', 38, 'Kurzzeit-Fourier-Transformation', 'Fensterbasierte lokalisierte Fourier-Transformation zur gemeinsamen Zeit-Frequenz-Darstellung.', 'V_wf(\\tau,\\omega)=\\int_{-\\infty}^{\\infty}f(t)\\overline{w(t-\\tau)}\\mathrm{e}^{-\\mathrm{i}\\omega t}\\,\\mathrm{d}t', 'V_wf(\\tau,\\omega)=\\int_{-\\infty}^{\\infty}f(t)\\overline{w(t-\\tau)}\\mathrm{e}^{-\\mathrm{i}\\omega t}\\,\\mathrm{d}t', 'adapted', 84, 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'Etablierte Definition.', 'verified', 41),
(234, '3.2.144', 39, 'Wavelet', 'Lokalisierte Analysefunktion, die durch Skalierung und Verschiebung zur Untersuchung mehrskaliger Strukturen verwendet wird.', '\\int_{-\\infty}^{\\infty}\\psi(t)\\,\\mathrm{d}t=0', '\\int_{-\\infty}^{\\infty}\\psi(t)\\,\\mathrm{d}t=0', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(235, '3.2.145', 39, 'Mutterwavelet', 'Ausgangsfunktion, aus der durch Skalierung und Verschiebung eine Wavelet-Familie erzeugt wird.', '\\psi_{a,b}(t)=\\frac{1}{\\sqrt{|a|}}\\psi\\left(\\frac{t-b}{a}\\right)', '\\psi_{a,b}(t)=\\frac{1}{\\sqrt{|a|}}\\psi\\left(\\frac{t-b}{a}\\right)', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(236, '3.2.146', 39, 'Kontinuierliche Wavelet-Transformation', 'Projektion einer Funktion auf skalierte und verschobene Wavelets.', 'W_{\\psi}f(a,b)=\\frac{1}{\\sqrt{|a|}}\\int_{-\\infty}^{\\infty}f(t)\\overline{\\psi\\left(\\frac{t-b}{a}\\right)}\\,\\mathrm{d}t', 'W_{\\psi}f(a,b)=\\frac{1}{\\sqrt{|a|}}\\int_{-\\infty}^{\\infty}f(t)\\overline{\\psi\\left(\\frac{t-b}{a}\\right)}\\,\\mathrm{d}t', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(237, '3.2.147', 39, 'Skalogramm', 'Quadratischer Betrag der kontinuierlichen Wavelet-Koeffizienten.', 'S_{\\psi}f(a,b)=|W_{\\psi}f(a,b)|^{2}', 'S_{\\psi}f(a,b)=|W_{\\psi}f(a,b)|^{2}', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(238, '3.2.148', 39, 'Zulässige Wavelet-Funktion', 'Wavelet mit endlicher Zulässigkeitskonstante.', 'C_{\\psi}=\\int_{-\\infty}^{\\infty}\\frac{|\\widehat{\\psi}(\\omega)|^{2}}{|\\omega|}\\,\\mathrm{d}\\omega<\\infty', 'C_{\\psi}=\\int_{-\\infty}^{\\infty}\\frac{|\\widehat{\\psi}(\\omega)|^{2}}{|\\omega|}\\,\\mathrm{d}\\omega<\\infty', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(239, '3.2.149', 39, 'Diskrete Wavelet-Transformation', 'Darstellung einer Funktion durch diskrete Wavelet-Koeffizienten.', 'd_{j,k}=\\langle f,\\psi_{j,k}\\rangle', 'd_{j,k}=\\langle f,\\psi_{j,k}\\rangle', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(240, '3.2.150', 39, 'Mehrskalenanalyse', 'Geschachtelte Folge abgeschlossener Unterräume zur Beschreibung verschiedener Auflösungsstufen.', '\\ldots\\subset V_{-1}\\subset V_{0}\\subset V_{1}\\subset\\ldots', '\\ldots\\subset V_{-1}\\subset V_{0}\\subset V_{1}\\subset\\ldots', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(241, '3.2.151', 39, 'Skalierungsfunktion', 'Funktion, deren verschobene und skalierte Kopien die Approximationsräume einer Mehrskalenanalyse erzeugen.', '\\varphi_{j,k}(t)=2^{j/2}\\varphi(2^{j}t-k)', '\\varphi_{j,k}(t)=2^{j/2}\\varphi(2^{j}t-k)', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(242, '3.2.152', 39, 'Detailraum', 'Orthogonales Komplement eines Approximationsraums im nächstfeineren Approximationsraum.', 'W_j=V_{j+1}\\ominus V_j', 'W_j=V_{j+1}\\ominus V_j', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(243, '3.2.153', 39, 'Zweiskalenrelation', 'Darstellung einer Skalierungsfunktion durch verschobene und skalierte Kopien ihrer selbst.', '\\varphi(t)=\\sqrt{2}\\sum_{k\\in\\mathbb{Z}}h_k\\varphi(2t-k)', '\\varphi(t)=\\sqrt{2}\\sum_{k\\in\\mathbb{Z}}h_k\\varphi(2t-k)', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(244, '3.2.154', 39, 'Analysefilterbank', 'Zerlegung diskreter Daten in Approximation und Detail durch Tiefpass- und Hochpassfilter.', 'c_j\\longrightarrow(c_{j-1},d_{j-1})', 'c_j\\longrightarrow(c_{j-1},d_{j-1})', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(245, '3.2.155', 39, 'Perfekte Rekonstruktion', 'Exakte Wiederherstellung des ursprünglichen Datenvektors aus Approximation und Detail.', '\\widetilde{x}=x', '\\widetilde{x}=x', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(246, '3.2.156', 39, 'Haar-Transformation zweier Werte', 'Normierte Zerlegung zweier benachbarter Werte in Mittelwert- und Differenzanteil.', 'a=\\frac{x_0+x_1}{\\sqrt{2}},\\quad d=\\frac{x_0-x_1}{\\sqrt{2}}', 'a=\\frac{x_0+x_1}{\\sqrt{2}},\\quad d=\\frac{x_0-x_1}{\\sqrt{2}}', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(247, '3.2.157', 39, 'Verschwindendes Moment', 'Bedingung, dass bestimmte polynomial gewichtete Integrale eines Wavelets verschwinden.', '\\int_{-\\infty}^{\\infty}t^{m}\\psi(t)\\,\\mathrm{d}t=0', '\\int_{-\\infty}^{\\infty}t^{m}\\psi(t)\\,\\mathrm{d}t=0', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(248, '3.2.158', 39, 'Lokaler Hölder-Exponent', 'Maß für die lokale Glattheit einer Funktion an einem Punkt.', '|f(t)-P(t-t_0)|\\leq C|t-t_0|^{\\alpha}', '|f(t)-P(t-t_0)|\\leq C|t-t_0|^{\\alpha}', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(249, '3.2.159', 39, 'Wavelet-Modulusmaximum', 'Lokales Maximum des Betrages eines Wavelet-Koeffizienten auf einer festen Skala.', '|W_{\\psi}f(a,b_0)|\\geq|W_{\\psi}f(a,b)|', '|W_{\\psi}f(a,b_0)|\\geq|W_{\\psi}f(a,b)|', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(250, '3.2.160', 39, 'Harte Schwellenwertbildung', 'Nichtlineare Abbildung, die Koeffizienten unterhalb eines Schwellenwerts auf null setzt.', 'T_{\\lambda}^{\\mathrm{hart}}(x)=\\begin{cases}x,&|x|\\geq\\lambda\\\\0,&|x|<\\lambda\\end{cases}', 'T_{\\lambda}^{\\mathrm{hart}}(x)=\\begin{cases}x,&|x|\\geq\\lambda\\\\0,&|x|<\\lambda\\end{cases}', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(251, '3.2.161', 39, 'Weiche Schwellenwertbildung', 'Nichtlineare Abbildung, die kleine Koeffizienten entfernt und verbleibende Koeffizienten verkleinert.', 'T_{\\lambda}^{\\mathrm{weich}}(x)=\\operatorname{sgn}(x)\\max\\left(|x|-\\lambda,0\\right)', 'T_{\\lambda}^{\\mathrm{weich}}(x)=\\operatorname{sgn}(x)\\max\\left(|x|-\\lambda,0\\right)', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(252, '3.2.162', 39, 'Zweidimensionale Detailzerlegung', 'Wavelet-Zerlegung in Approximation sowie horizontale, vertikale und diagonale Detailanteile.', 'A_j,\\qquad H_j,\\qquad V_j,\\qquad D_j', 'A_j,\\qquad H_j,\\qquad V_j,\\qquad D_j', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(253, '3.2.163', 39, 'Wavelet-Paket-Zerlegung', 'Rekursive Filterbankzerlegung von Tiefpass- und Hochpassanteilen.', 'W_{j,n}\\longrightarrow(W_{j+1,2n},W_{j+1,2n+1})', 'W_{j,n}\\longrightarrow(W_{j+1,2n},W_{j+1,2n+1})', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(254, '3.2.164', 39, 'Stationäre Wavelet-Transformation', 'Redundante Wavelet-Zerlegung ohne Unterabtastung.', 'h_j[n]=h[n]\\uparrow2^{j-1}', 'h_j[n]=h[n]\\uparrow2^{j-1}', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(255, '3.2.165', 39, 'Skalenabhängiger Zustandsanteil', 'Projektion eines Zustands auf einen Approximationsraum einer bestimmten Skala.', 'u_j=P_j u,\\quad d_j=Q_j u', 'u_j=P_j u,\\quad d_j=Q_j u', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42),
(256, '3.2.166', 39, 'Einflussbereich eines Wavelet-Koeffizienten', 'Bereich, über den ein skaliertes und verschobenes Wavelet wesentlich auf einen Koeffizienten wirkt.', '\\operatorname{supp}(\\psi_{a,b})', '\\operatorname{supp}(\\psi_{a,b})', 'adapted', 85, 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'Etablierte Definition.', 'verified', 42);

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
(11, 2, '3.1.7', 'Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung', 3, 3.1700, 'final', 1, 'Abschlussabschnitt der allgemeinen Grundlegung in Kapitel 3.1. Keine neuen Literaturstellen; keine nummerierten Gleichungen.', '2026-07-26 17:31:39', '2026-07-26 17:31:39'),
(12, 1, '3.2', 'Mathematische Grundlagen', 3, 3.2000, 'draft', 0, 'Kapitel 3.2 stellt die etablierten mathematischen Grundlagen bereit. Die eigenständige FRZK-Axiomatik beginnt erst in Kapitel 3.3.', '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(13, 12, '3.2.0', 'Einleitung', 3, 3.2000, 'final', 0, 'Einleitung in die mathematischen Grundlagen; Abgrenzung zwischen etablierter Mathematik und der ab Kapitel 3.3 entwickelten FRZK-Eigenleistung.', '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(14, 12, '3.2.1', 'Mengen, Elemente und elementare Relationen', 3, 3.2100, 'final', 0, 'Mathematische Grundlegung von Mengen, Elementen, Teilmengen, Mengenoperationen, kartesischen Produkten und binären Relationen. Gleichungen (3.1) bis (3.23); neue Literatur [80] und [81].', '2026-07-27 08:51:06', '2026-07-27 08:51:06'),
(15, 12, '3.2.2', 'Funktionen und eindeutige Zuordnungen', 3, 3.2200, 'final', 0, 'Grundlegung des Funktionsbegriffs; Literatur [82]-[83]; Definitionen 3.2.3-3.2.10; Gleichungen (3.24)-(3.58).', '2026-07-28 05:00:01', '2026-07-28 05:00:01'),
(16, 12, '3.2.3', 'Abbildungen, Operatoren und mathematische Transformationen', 3, 3.2300, 'final', 0, 'Etablierte mathematische Grundlagen zu Abbildungen, linearen Operatoren, Komposition, Identität, Invertierbarkeit, Matrixdarstellung und Eigenwertbegriff. Quellen [71], [74], [76], [80] und [82]; Definitionen 3.2.11 bis 3.2.12; Gleichungen (3.59) bis (3.76).', '2026-07-28 08:28:51', '2026-07-28 08:28:51'),
(17, 12, '3.2.4', 'Vektorräume als mathematische Zustandsräume', 3, 3.2400, 'final', 0, 'Etablierte Grundlagen reeller Vektorräume, Vektorraumaxiome, Nullvektor, Skalarmultiplikation mit null, Untervektorräume und Beispiele. Quellen [71], [74], [76] und [82]; Definitionen 3.2.13 bis 3.2.15; Gleichungen (3.77) bis (3.112).', '2026-07-28 10:43:02', '2026-07-28 10:43:02'),
(18, 12, '3.2.5', 'Linearkombinationen, Spannräume und Erzeugendensysteme', 3, 3.2500, 'final', 0, 'Etablierte Grundlagen zu Linearkombinationen, Spannräumen und Erzeugendensystemen. Quellen [71], [74] und [82]; Definitionen 3.2.16 bis 3.2.17; Gleichungen (3.113) bis (3.120).', '2026-07-28 11:04:00', '2026-07-28 11:04:00'),
(19, 12, '3.2.6', 'Lineare Unabhängigkeit, Basis und Dimension', 3, 3.2600, 'final', 0, 'Definitionen 3.2.18 bis 3.2.21; Gleichungen 3.121 bis 3.146; Quellen [71], [74], [82].', '2026-07-28 12:29:08', '2026-07-28 12:29:08'),
(20, 12, '3.2.7', 'Basiswechsel und Koordinatentransformationen', 3, 3.2700, 'final', 0, 'Gleichungen 3.147 bis 3.166; Quellen [71], [74], [76], [82].', '2026-07-28 12:29:08', '2026-07-28 12:29:08'),
(21, 12, '3.2.8', 'Determinanten, Orientierung und Volumenänderung', 3, 3.2800, 'final', 0, 'Definition 3.2.22; Gleichungen (3.167) bis (3.204); Quellen [71], [74] und [82].', '2026-07-28 14:59:36', '2026-07-28 14:59:36'),
(22, 12, '3.2.9', 'Rang, Kern und Bild linearer Abbildungen', 3, 3.2900, 'final', 0, 'Definitionen 3.2.23 bis 3.2.25; Gleichungen (3.205) bis (3.228); Quellen [71], [74] und [82].', '2026-07-28 15:26:24', '2026-07-28 15:26:24'),
(23, 12, '3.2.10', 'Eigenwerte und Eigenvektoren linearer Operatoren', 3, 3.2100, 'final', 0, 'Definitionen 3.2.26 bis 3.2.28; Gleichungen (3.229) bis (3.271); Quellen [71], [74], [76], [82].', '2026-07-28 16:24:47', '2026-07-28 16:24:47'),
(24, 12, '3.2.11', 'Orthogonale Projektionen und Orthonormalbasen', 3, 3.2110, 'final', 0, 'Definitionen 3.2.29–3.2.32; Gleichungen (3.272)–(3.294); Quellen [71],[74],[76],[82].', '2026-07-28 16:40:07', '2026-07-28 16:40:07'),
(25, 12, '3.2.12', 'Symmetrische, schiefsymmetrische und positiv definite Matrizen', 3, 3.2120, 'final', 0, 'Definitionen 3.2.33 bis 3.2.36; Gleichungen 3.295 bis 3.318; Quellen 71, 74, 76 und 82.', '2026-07-28 17:30:03', '2026-07-28 17:30:03'),
(26, 12, '3.2.13', 'Diagonalisierbarkeit und Spektralzerlegung', 3, 3.2130, 'final', 0, 'Diagonalisierbarkeit, algebraische und geometrische Vielfachheit, Matrixpotenzen, Matrixfunktionen, Spektralsatz und Spektralzerlegung. Literatur: [71], [74], [76], [82].', '2026-07-29 02:35:34', '2026-07-29 07:47:44'),
(27, 12, '3.2.14', 'Allgemeine Matrixzerlegungen', 3, 3.2140, 'final', 0, 'LU-, QR-, Cholesky- und Singulärwertzerlegung; Definitionen 3.2.40–3.2.43; Satz 3.2.11; Gleichungen (3.382)–(3.438); Literatur [74], [76], [82], [84].', '2026-07-29 02:44:10', '2026-07-29 10:14:50'),
(29, 12, '3.2.15', 'Matrixnormen, Kondition und numerische Stabilität', 3, 3.2150, 'final', 0, 'Vektor- und Matrixnormen, Fehlerfortpflanzung, Konditionszahl, Vorwärts- und Rückwärtsstabilität; Definitionen 3.2.44–3.2.50; Satz 3.2.12; Gleichungen (3.439)–(3.503); Literatur [74], [82], [84], [85].', '2026-07-29 11:23:35', '2026-07-29 11:23:35'),
(30, 12, '3.2.16', 'Pseudoinverse, Ausgleichslösungen und Regularisierung', 3, 3.2160, 'final', 0, 'Moore-Penrose-Pseudoinverse, Ausgleichslösungen, Normalgleichungen, Mindestnormlösung, Projektionsoperatoren, Tikhonov-Regularisierung und abgeschnittene Singulärwertzerlegung; Definitionen 3.2.51–3.2.56; Satz 3.2.13; Gleichungen (3.504)–(3.573); Literatur [74], [84], [85], [86], [87].', '2026-07-29 12:42:56', '2026-07-29 12:42:56'),
(31, 12, '3.2.17', 'Iterative Lösungsverfahren und Konvergenz', 3, 3.2170, 'final', 0, 'Definitionen 3.2.57–3.2.62; Satz 3.2.14; Gleichungen 3.574–3.673; Literatur [84], [85], [88].', '2026-07-29 13:05:34', '2026-07-29 13:05:34'),
(32, 12, '3.2.18', 'Nichtlineare Gleichungssysteme und lokale Linearisierung', 3, 3.2180, 'final', 0, 'Definitionen 3.2.63–3.2.68; Sätze 3.2.15–3.2.16; Gleichungen 3.674–3.768; Literatur [84], [85], [89].', '2026-07-29 14:00:05', '2026-07-29 14:00:05'),
(34, 12, '3.2.19', 'Gewöhnliche Differentialgleichungen und dynamische Zustandsentwicklung', 3, 3.2190, 'final', 0, 'Definitionen 3.2.69–3.2.84; Sätze 3.2.17–3.2.19; Gleichungen 3.769–3.889; Literatur [84], [85], [90].', '2026-07-29 22:32:07', '2026-07-29 22:32:07'),
(35, 12, '3.2.20', 'Partielle Differentialgleichungen und räumlich verteilte Zustandsentwicklung', 3, 3.2200, 'final', 0, 'PDE, Klassifikation, Randbedingungen, schwache Lösungen, Sobolev-Räume, Erhaltungsgleichungen, Diffusion, Advektion, Reaktions-Diffusions-Systeme, Energieabschätzungen und räumliche Diskretisierung.', '2026-07-29 22:49:24', '2026-07-29 22:49:24'),
(37, 12, '3.2.21', 'Integralgleichungen, Greensche Funktionen und nichtlokale Zustandskopplungen', 3, 3.2210, 'final', 0, 'Integraloperatoren, Fredholm- und Volterra-Gleichungen, Greensche Funktionen, Faltung, nichtlokale Diffusion, Gedächtniskerne und Regularisierung.', '2026-07-30 00:16:29', '2026-07-30 00:16:29'),
(38, 12, '3.2.22', 'Fourier- und Laplace-Transformationen sowie spektrale Zustandsdarstellungen', 3, 3.2220, 'final', 0, 'Fourier-Transformation, Fourier-Reihen, Faltung, Spektraldarstellung, Laplace-Transformation, Übertragungsfunktionen, DFT, Abtastung und Zeit-Frequenz-Lokalisation.', '2026-07-30 00:26:15', '2026-07-30 00:26:15'),
(39, 12, '3.2.23', 'Wavelet-Transformationen, Mehrskalenanalyse und lokal aufgelöste Zustandsstrukturen', 3, 3.2230, 'final', 0, 'Kontinuierliche und diskrete Wavelet-Transformation, Mehrskalenanalyse, Filterbänke, Haar-Wavelet, lokale Regularität, Schwellenwertbildung und FRZK-Anschluss.', '2026-07-30 00:39:14', '2026-07-30 00:39:14');

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

--
-- Daten für Tabelle `equations`
--

INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(1, '3.1', 14, 'Elementzugehörigkeit', 'xin M', 'xin M', 'Das Objekt x ist Element der Menge M.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(2, '3.2', 14, 'Nichtzugehörigkeit', 'x\notin M', 'x\notin M', 'Das Objekt x ist kein Element der Menge M.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(3, '3.3', 14, 'Aufzählende Mengendarstellung', 'M={a,b,c}', 'M={a,b,c}', 'Die Menge M enthält die Elemente a, b und c.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(4, '3.4', 14, 'Reihenfolge und Mehrfachnennung', '{a,b,c}={c,a,b}={a,a,b,c}', '{a,b,c}={c,a,b}={a,a,b,c}', 'Reihenfolge und Mehrfachnennung verändern eine Menge nicht.', 'derived', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(5, '3.5', 14, 'Menge durch Auswahlbedingung', 'M={xin Umid P(x)}', 'M={xin Umid P(x)}', 'M enthält genau die Elemente aus U, für die P(x) gilt.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(6, '3.6', 14, 'Gerade natürliche Zahlen', 'G={ninmathbb{N}mid exists kinmathbb{N}:n=2k}', 'G={ninmathbb{N}mid exists kinmathbb{N}:n=2k}', 'Definition der Menge gerader natürlicher Zahlen.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(7, '3.7', 14, 'Teilmengenrelation', 'Asubseteq BquadLongleftrightarrowquadforall x,(xin ARightarrow xin B)', 'Asubseteq BquadLongleftrightarrowquadforall x,(xin ARightarrow xin B)', 'A ist Teilmenge von B genau dann, wenn jedes Element von A auch Element von B ist.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(8, '3.8', 14, 'Echte Teilmenge', 'Asubset BquadLongleftrightarrowquad Asubseteq Bland A\neq B', 'Asubset BquadLongleftrightarrowquad Asubseteq Bland A\neq B', 'A ist echte Teilmenge von B, wenn A Teilmenge, aber nicht gleich B ist.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(9, '3.9', 14, 'Extensionalität', 'A=BquadLongleftrightarrowquadforall x,(xin ALeftrightarrow xin B)', 'A=BquadLongleftrightarrowquadforall x,(xin ALeftrightarrow xin B)', 'Zwei Mengen sind gleich, wenn sie genau dieselben Elemente enthalten.', 'definition', 'literature', 69, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(10, '3.10', 14, 'Leere Menge', 'forall x;(x\notinvarnothing)', 'forall x;(x\notinvarnothing)', 'Die leere Menge enthält kein Element.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(11, '3.11', 14, 'Leere Menge als Teilmenge', 'forall A;(varnothingsubseteq A)', 'forall A;(varnothingsubseteq A)', 'Die leere Menge ist Teilmenge jeder Menge.', 'derived', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(12, '3.12', 14, 'Vereinigung', 'Acup B={xmid xin Alor xin B}', 'Acup B={xmid xin Alor xin B}', 'Die Vereinigung enthält alle Elemente aus A oder B.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(13, '3.13', 14, 'Schnittmenge', 'Acap B={xmid xin Aland xin B}', 'Acap B={xmid xin Aland xin B}', 'Die Schnittmenge enthält alle Elemente, die zugleich in A und B liegen.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(14, '3.14', 14, 'Differenzmenge', 'Asetminus B={xmid xin Aland x\notin B}', 'Asetminus B={xmid xin Aland x\notin B}', 'Die Differenzmenge enthält Elemente aus A, die nicht in B liegen.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(15, '3.15', 14, 'Disjunktheit', 'Acap B=varnothing', 'Acap B=varnothing', 'A und B sind disjunkt, wenn ihre Schnittmenge leer ist.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(16, '3.16', 14, 'Potenzmenge', 'mathcal{P}(A)={Bmid Bsubseteq A}', 'mathcal{P}(A)={Bmid Bsubseteq A}', 'Die Potenzmenge enthält sämtliche Teilmengen von A.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(17, '3.17', 14, 'Beispiel einer Potenzmenge', 'mathcal{P}(A)={varnothing,{a},{b},{a,b}}', 'mathcal{P}(A)={varnothing,{a},{b},{a,b}}', 'Potenzmenge der zweielementigen Menge A={a,b}.', 'derived', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(18, '3.18', 14, 'Mächtigkeit der Potenzmenge', '|A|=nquadLongrightarrowquad|mathcal{P}(A)|=2^n', '|A|=nquadLongrightarrowquad|mathcal{P}(A)|=2^n', 'Eine endliche n-elementige Menge besitzt 2^n Teilmengen.', 'theorem', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(19, '3.19', 14, 'Reihenfolge im geordneten Paar', '(a,b)\neq(b,a)', '(a,b)\neq(b,a)', 'Im Allgemeinen unterscheidet sich ein geordnetes Paar bei Vertauschung der Komponenten.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(20, '3.20', 14, 'Kartesisches Produkt', 'A	imes B={(a,b)mid ain Aland bin B}', 'A	imes B={(a,b)mid ain Aland bin B}', 'Das kartesische Produkt enthält alle geordneten Paare aus A und B.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(21, '3.21', 14, 'Mächtigkeit des kartesischen Produkts', '|A	imes B|=|A|cdot|B|', '|A	imes B|=|A|cdot|B|', 'Für endliche Mengen ist die Mächtigkeit des kartesischen Produkts das Produkt der Mächtigkeiten.', 'theorem', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(22, '3.22', 14, 'Binäre Relation', 'Rsubseteq A	imes B', 'Rsubseteq A	imes B', 'Eine binäre Relation zwischen A und B ist eine Teilmenge des kartesischen Produkts.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(23, '3.23', 14, 'Relationsschreibweise', 'a,R,b', 'a,R,b', 'Kurzschreibweise dafür, dass das geordnete Paar (a,b) zur Relation R gehört.', 'definition', 'literature', 68, 'Standardform der elementaren Mengenlehre; im Abschnitt 3.2.1 begrifflich erläutert.', 'Die verwendeten Mengen, Elemente und logischen Verknüpfungen sind definiert.', 'verified', 14),
(24, '3.24', 15, 'Funktionsschreibweise', 'f:A\rightarrow B', 'f:A\rightarrow B', 'Funktionsschreibweise.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(25, '3.25', 15, 'Funktionswert', 'f(a)=b', 'f(a)=b', 'Funktionswert.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(26, '3.26', 15, 'Eindeutige Existenz', 'forall ain A;exists !,bin B:;f(a)=b', 'forall ain A;exists !,bin B:;f(a)=b', 'Eindeutige Existenz.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(27, '3.27', 15, 'Funktion als Relation', 'fsubseteq A	imes B', 'fsubseteq A	imes B', 'Funktion als Relation.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(28, '3.28', 15, 'Eindeutigkeitsbedingung', '(a,b_1)in fland(a,b_2)in fLongrightarrow b_1=b_2', '(a,b_1)in fland(a,b_2)in fLongrightarrow b_1=b_2', 'Eindeutigkeitsbedingung.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(29, '3.29', 15, 'Totalitätsbedingung', 'forall ain A;exists bin B:;(a,b)in f', 'forall ain A;exists bin B:;(a,b)in f', 'Totalitätsbedingung.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(30, '3.30', 15, 'Bildmenge', 'f(A)={f(a)mid ain A}', 'f(A)={f(a)mid ain A}', 'Bildmenge.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(31, '3.31', 15, 'Bild als Teilmenge', 'f(A)subseteq B', 'f(A)subseteq B', 'Bild als Teilmenge.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(32, '3.32', 15, 'Bild einer Teilmenge', 'f(C)={f(c)mid cin C}', 'f(C)={f(c)mid cin C}', 'Bild einer Teilmenge.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(33, '3.33', 15, 'Urbild einer Teilmenge', 'f^{-1}(D)={ain Amid f(a)in D}', 'f^{-1}(D)={ain Amid f(a)in D}', 'Urbild einer Teilmenge.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(34, '3.34', 15, 'Injektivität', 'forall a_1,a_2in A:f(a_1)=f(a_2)Longrightarrow a_1=a_2', 'forall a_1,a_2in A:f(a_1)=f(a_2)Longrightarrow a_1=a_2', 'Injektivität.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(35, '3.35', 15, 'Alternative Injektivitätsform', 'a_1\neq a_2Longrightarrow f(a_1)\neq f(a_2)', 'a_1\neq a_2Longrightarrow f(a_1)\neq f(a_2)', 'Alternative Injektivitätsform.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(36, '3.36', 15, 'Surjektivität', 'forall bin B;exists ain A:;f(a)=b', 'forall bin B;exists ain A:;f(a)=b', 'Surjektivität.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(37, '3.37', 15, 'Bild bei Surjektivität', 'f(A)=B', 'f(A)=B', 'Bild bei Surjektivität.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(38, '3.38', 15, 'Bijektivität', 'f	ext{ bijektiv}Longleftrightarrow f	ext{ injektiv}land f	ext{ surjektiv}', 'f	ext{ bijektiv}Longleftrightarrow f	ext{ injektiv}land f	ext{ surjektiv}', 'Bijektivität.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(39, '3.39', 15, 'Umkehrfunktion', 'f^{-1}:B\rightarrow A', 'f^{-1}:B\rightarrow A', 'Umkehrfunktion.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(40, '3.40', 15, 'Linksinverse Eigenschaft', 'f^{-1}(f(a))=aquadforall ain A', 'f^{-1}(f(a))=aquadforall ain A', 'Linksinverse Eigenschaft.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(41, '3.41', 15, 'Rechtsinverse Eigenschaft', 'f(f^{-1}(b))=bquadforall bin B', 'f(f^{-1}(b))=bquadforall bin B', 'Rechtsinverse Eigenschaft.', 'definition', 'literature', 68, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(42, '3.42', 15, 'Identische Funktion', 'operatorname{id}_A:A\rightarrow A', 'operatorname{id}_A:A\rightarrow A', 'Identische Funktion.', 'definition', 'literature', 70, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(43, '3.43', 15, 'Wirkung der Identität', 'operatorname{id}_A(a)=aquadforall ain A', 'operatorname{id}_A(a)=aquadforall ain A', 'Wirkung der Identität.', 'definition', 'literature', 70, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(44, '3.44', 15, 'Erste Funktion der Verkettung', 'f:A\rightarrow B', 'f:A\rightarrow B', 'Erste Funktion der Verkettung.', 'definition', 'literature', 70, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(45, '3.45', 15, 'Zweite Funktion der Verkettung', 'g:B\rightarrow C', 'g:B\rightarrow C', 'Zweite Funktion der Verkettung.', 'definition', 'literature', 70, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(46, '3.46', 15, 'Verkettete Funktion', 'gcirc f:A\rightarrow C', 'gcirc f:A\rightarrow C', 'Verkettete Funktion.', 'definition', 'literature', 70, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(47, '3.47', 15, 'Auswertung der Verkettung', '(gcirc f)(a)=g(f(a))', '(gcirc f)(a)=g(f(a))', 'Auswertung der Verkettung.', 'definition', 'literature', 70, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(48, '3.48', 15, 'Nichtkommutativität der Verkettung', 'gcirc f\neq fcirc g', 'gcirc f\neq fcirc g', 'Nichtkommutativität der Verkettung.', 'definition', 'literature', 70, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(49, '3.49', 15, 'Assoziativität der Verkettung', 'hcirc(gcirc f)=(hcirc g)circ f', 'hcirc(gcirc f)=(hcirc g)circ f', 'Assoziativität der Verkettung.', 'definition', 'literature', 70, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(50, '3.50', 15, 'Zweistellige Funktion', 'f:A	imes B\rightarrow C', 'f:A	imes B\rightarrow C', 'Zweistellige Funktion.', 'definition', 'literature', 71, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(51, '3.51', 15, 'Funktionswert einer zweistelligen Funktion', 'f(a,b)=cquad	ext{mit}quad cin C', 'f(a,b)=cquad	ext{mit}quad cin C', 'Funktionswert einer zweistelligen Funktion.', 'definition', 'literature', 71, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(52, '3.52', 15, 'Mehrstellige Funktion', 'f:A_1	imes A_2	imescdots	imes A_n\rightarrow B', 'f:A_1	imes A_2	imescdots	imes A_n\rightarrow B', 'Mehrstellige Funktion.', 'definition', 'literature', 71, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(53, '3.53', 15, 'Argumenttupel', '(a_1,a_2,ldots,a_n)in A_1	imes A_2	imescdots	imes A_n', '(a_1,a_2,ldots,a_n)in A_1	imes A_2	imescdots	imes A_n', 'Argumenttupel.', 'definition', 'literature', 71, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(54, '3.54', 15, 'Wert einer mehrstelligen Funktion', 'f(a_1,a_2,ldots,a_n)in B', 'f(a_1,a_2,ldots,a_n)in B', 'Wert einer mehrstelligen Funktion.', 'definition', 'literature', 71, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(55, '3.55', 15, 'Parametrisierte Funktionsfamilie', '{f_	hetamid	hetainTheta}', '{f_	hetamid	hetainTheta}', 'Parametrisierte Funktionsfamilie.', 'definition', 'literature', 71, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(56, '3.56', 15, 'Element einer Funktionsfamilie', 'f_	heta:A\rightarrow B', 'f_	heta:A\rightarrow B', 'Element einer Funktionsfamilie.', 'definition', 'literature', 71, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(57, '3.57', 15, 'Partielle Funktion', 'f:D\rightarrow B,qquad Dsubseteq A', 'f:D\rightarrow B,qquad Dsubseteq A', 'Partielle Funktion.', 'definition', 'literature', 71, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(58, '3.58', 15, 'Allgemeine funktionale Abhängigkeit', 'y=f(x)', 'y=f(x)', 'Allgemeine funktionale Abhängigkeit.', 'definition', 'literature', 71, 'Standardform des etablierten Funktionsbegriffs; im Abschnitt 3.2.2 erläutert.', 'Definitions- und Zielmengen sind festgelegt.', 'verified', 15),
(59, '3.59', 16, 'Abbildung von X nach Y', 'T:X\\rightarrow Y', 'T:X\\rightarrow Y', 'Die Abbildung T besitzt den Definitionsbereich X und den Zielbereich Y.', 'definition', 'literature', 68, 'Standardnotation für eine Abbildung zwischen zwei Mengen.', 'X und Y sind Mengen.', 'verified', 16),
(60, '3.60', 16, 'Wert einer Abbildung', 'T(x)=y', 'T(x)=y', 'Dem Element x wird durch T das Element y zugeordnet.', 'definition', 'literature', 68, 'Auswertung der Abbildung T an der Stelle x.', 'x liegt im Definitionsbereich von T.', 'verified', 16),
(61, '3.61', 16, 'Additivität einer linearen Abbildung', 'T(x+y)=T(x)+T(y)', 'T(x+y)=T(x)+T(y)', 'Eine lineare Abbildung erhält die Addition von Vektoren.', 'definition', 'literature', 59, 'Erste Bedingung der Linearität.', 'x und y liegen in einem Vektorraum und T ist auf diesem Raum definiert.', 'verified', 16),
(62, '3.62', 16, 'Homogenität einer linearen Abbildung', 'T(\\lambda x)=\\lambda T(x)', 'T(\\lambda x)=\\lambda T(x)', 'Eine lineare Abbildung ist mit der Skalarmultiplikation verträglich.', 'definition', 'literature', 59, 'Zweite Bedingung der Linearität.', 'lambda ist ein Skalar und x liegt im Definitionsbereich von T.', 'verified', 16),
(63, '3.63', 16, 'Linearer Operator auf V', 'T:V\\rightarrow V', 'T:V\\rightarrow V', 'Der Operator T bildet den Vektorraum V in sich selbst ab.', 'definition', 'literature', 70, 'Spezialisierung einer linearen Abbildung auf identische Definitions- und Zielräume.', 'V ist ein Vektorraum und T ist linear.', 'verified', 16),
(64, '3.64', 16, 'Erster Operator der Verkettung', 'A:V\\rightarrow V', 'A:V\\rightarrow V', 'A ist ein Operator auf dem Vektorraum V.', 'schema', 'literature', 70, 'Ausgangsoperator für die nachfolgende Komposition.', 'V ist ein Vektorraum.', 'verified', 16),
(65, '3.65', 16, 'Zweiter Operator der Verkettung', 'B:V\\rightarrow V', 'B:V\\rightarrow V', 'B ist ein Operator auf dem Vektorraum V.', 'schema', 'literature', 70, 'Zieloperator für die nachfolgende Komposition.', 'V ist ein Vektorraum.', 'verified', 16),
(66, '3.66', 16, 'Verkettung zweier Operatoren', 'B\\circ A', 'B\\circ A', 'Die Komposition wendet zuerst A und anschließend B an.', 'definition', 'literature', 70, 'Komposition zweier auf demselben Vektorraum definierter Operatoren.', 'Bildbereich von A und Definitionsbereich von B sind verträglich.', 'verified', 16),
(67, '3.67', 16, 'Wirkung einer Operatorverkettung', '(B\\circ A)(x)=B(A(x))', '(B\\circ A)(x)=B(A(x))', 'Die verkettete Abbildung wirkt schrittweise auf den Vektor x.', 'definition', 'literature', 70, 'Auswertung der Komposition B nach A.', 'x liegt im Definitionsbereich von A.', 'verified', 16),
(68, '3.68', 16, 'Nichtkommutativität von Operatoren', 'B\\circ A\\neq A\\circ B', 'B\\circ A\\neq A\\circ B', 'Die Reihenfolge zweier Operatoren kann unterschiedliche Ergebnisse erzeugen.', 'other', 'literature', 64, 'Allgemeine Aussage zur im Regelfall nichtkommutativen Operatorverkettung.', 'Es wird keine besondere Vertauschungsrelation zwischen A und B vorausgesetzt.', 'verified', 16),
(69, '3.69', 16, 'Identitätsoperator', 'I:V\\rightarrow V', 'I:V\\rightarrow V', 'Der Identitätsoperator ist auf dem Vektorraum V definiert.', 'definition', 'literature', 70, 'Definition des neutralen Operators bezüglich der Komposition.', 'V ist ein Vektorraum.', 'verified', 16),
(70, '3.70', 16, 'Wirkung des Identitätsoperators', 'I(x)=x', 'I(x)=x', 'Der Identitätsoperator lässt jeden Vektor unverändert.', 'definition', 'literature', 70, 'Punktweise Definition des Identitätsoperators.', 'x liegt in V.', 'verified', 16),
(71, '3.71', 16, 'Neutralität des Identitätsoperators', 'I\\circ T=T\\circ I=T', 'I\\circ T=T\\circ I=T', 'Die Komposition eines Operators mit der Identität verändert den Operator nicht.', 'derived', 'literature', 70, 'Folgt unmittelbar aus der Definition des Identitätsoperators.', 'T ist ein Operator auf V.', 'verified', 16),
(72, '3.72', 16, 'Inverser Operator', 'T^{-1}', 'T^{-1}', 'T hoch minus eins bezeichnet den inversen Operator zu T.', 'definition', 'literature', 64, 'Notation für die Umkehrabbildung eines invertierbaren Operators.', 'T ist bijektiv beziehungsweise besitzt eine wohldefinierte Inverse.', 'verified', 16),
(73, '3.73', 16, 'Linksinverse', 'T^{-1}\\circ T=I', 'T^{-1}\\circ T=I', 'Die Anwendung der Inversen nach T ergibt die Identität.', 'definition', 'literature', 64, 'Erste Bedingung für eine beidseitige Inverse.', 'T ist invertierbar.', 'verified', 16),
(74, '3.74', 16, 'Rechtsinverse', 'T\\circ T^{-1}=I', 'T\\circ T^{-1}=I', 'Die Anwendung von T nach seiner Inversen ergibt die Identität.', 'definition', 'literature', 64, 'Zweite Bedingung für eine beidseitige Inverse.', 'T ist invertierbar.', 'verified', 16),
(75, '3.75', 16, 'Matrixwirkung auf einen Koordinatenvektor', 'Ax=y', 'Ax=y', 'Die Matrix A bildet den Koordinatenvektor x auf den Koordinatenvektor y ab.', 'schema', 'literature', 62, 'Matrixdarstellung eines linearen Operators bezüglich einer gewählten Basis.', 'Der Vektorraum ist endlichdimensional und eine Basis wurde gewählt.', 'verified', 16),
(76, '3.76', 16, 'Eigenwertgleichung', 'Ax=\\lambda x', 'Ax=\\lambda x', 'Ein von null verschiedener Eigenvektor x wird durch A lediglich mit dem Eigenwert lambda skaliert.', 'definition', 'literature', 62, 'Standardgleichung zur Definition von Eigenwert und Eigenvektor.', 'x ist ungleich dem Nullvektor.', 'verified', 16),
(77, '3.77', 17, 'Vektoraddition als innere Verknüpfung', '+:V\\times V\\rightarrow V', '+:V\\times V\\rightarrow V', 'Die Vektoraddition ordnet zwei Vektoren aus V wieder einem Vektor aus V zu.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(78, '3.78', 17, 'Skalarmultiplikation als äußere Verknüpfung', '\\cdot:K\\times V\\rightarrow V', '\\cdot:K\\times V\\rightarrow V', 'Die Skalarmultiplikation ordnet einem Skalar und einem Vektor wieder einen Vektor aus V zu.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(79, '3.79', 17, 'Reeller Vektorraum', 'V\\text{ über }\\mathbb{R}', 'V\\text{ über }\\mathbb{R}', 'V wird als Vektorraum über dem Körper der reellen Zahlen betrachtet.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(80, '3.80', 17, 'Reelle Skalare', '\\lambda\\in\\mathbb{R}', '\\lambda\\in\\mathbb{R}', 'Der verwendete Skalar ist eine reelle Zahl.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(81, '3.81', 17, 'Vektoren des Raumes', 'u,v,w\\in V', 'u,v,w\\in V', 'Die Vektoren u, v und w sind Elemente des Vektorraums V.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(82, '3.82', 17, 'Abgeschlossenheit der Addition', 'u+v\\in V', 'u+v\\in V', 'Die Summe zweier Vektoren aus V ist wieder ein Vektor aus V.', 'axiom', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(83, '3.83', 17, 'Assoziativität der Vektoraddition', '(u+v)+w=u+(v+w)', '(u+v)+w=u+(v+w)', 'Die Vektoraddition ist assoziativ.', 'axiom', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(84, '3.84', 17, 'Kommutativität der Vektoraddition', 'u+v=v+u', 'u+v=v+u', 'Die Vektoraddition ist kommutativ.', 'axiom', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(85, '3.85', 17, 'Nullvektor als Raumelement', '0_V\\in V', '0_V\\in V', 'Der Nullvektor ist ein Element des Vektorraums V.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(86, '3.86', 17, 'Neutrale Wirkung des Nullvektors', 'v+0_V=v', 'v+0_V=v', 'Der Nullvektor ist das neutrale Element der Vektoraddition.', 'axiom', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(87, '3.87', 17, 'Nullvektor im zweidimensionalen Raum', '0_{\\mathbb{R}^2}=\\begin{pmatrix}0\\\\0 \\end{pmatrix}', '0_{\\mathbb{R}^2}=\\begin{pmatrix}0\\\\0 \\end{pmatrix}', 'Koordinatendarstellung des Nullvektors im zweidimensionalen reellen Vektorraum.', 'definition', 'literature', 62, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(88, '3.88', 17, 'Additives Inverses', 'v+(-v)=0_V', 'v+(-v)=0_V', 'Die Summe eines Vektors und seines additiven Inversen ergibt den Nullvektor.', 'axiom', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(89, '3.89', 17, 'Vektorsubtraktion', 'u-v', 'u-v', 'Notation der Subtraktion zweier Vektoren.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(90, '3.90', 17, 'Subtraktion als Addition des Inversen', 'u-v=u+(-v)', 'u-v=u+(-v)', 'Vektorsubtraktion wird als Addition des additiven Inversen definiert.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(91, '3.91', 17, 'Skalare des Körpers', '\\lambda,\\mu\\in K', '\\lambda,\\mu\\in K', 'Die Skalare lambda und mu sind Elemente des Skalarkörpers K.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(92, '3.92', 17, 'Abgeschlossenheit der Skalarmultiplikation', '\\lambda v\\in V', '\\lambda v\\in V', 'Das Produkt eines Skalars mit einem Vektor ist wieder ein Vektor aus V.', 'axiom', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(93, '3.93', 17, 'Verträglichkeit der Skalarmultiplikation', '(\\lambda\\mu)v=\\lambda(\\mu v)', '(\\lambda\\mu)v=\\lambda(\\mu v)', 'Die Skalarmultiplikation ist mit der Multiplikation im Körper verträglich.', 'axiom', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(94, '3.94', 17, 'Neutrales Skalarelement', '1_Kv=v', '1_Kv=v', 'Das multiplikative Einselement des Körpers wirkt neutral auf Vektoren.', 'axiom', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(95, '3.95', 17, 'Distributivität über der Vektoraddition', '\\lambda(u+v)=\\lambda u+\\lambda v', '\\lambda(u+v)=\\lambda u+\\lambda v', 'Die Skalarmultiplikation ist distributiv bezüglich der Vektoraddition.', 'axiom', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(96, '3.96', 17, 'Distributivität über der Skalaraddition', '(\\lambda+\\mu)v=\\lambda v+\\mu v', '(\\lambda+\\mu)v=\\lambda v+\\mu v', 'Die Skalarmultiplikation ist distributiv bezüglich der Addition im Skalarkörper.', 'axiom', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(97, '3.97', 17, 'Multiplikation eines Vektors mit null', '0_Kv=0_V', '0_Kv=0_V', 'Die Multiplikation eines Vektors mit dem skalaren Nullelement ergibt den Nullvektor.', 'derived', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(98, '3.98', 17, 'Ausgangspunkt der Nullskalarderivation', '0_Kv=(0_K+0_K)v', '0_Kv=(0_K+0_K)v', 'Das skalare Nullelement wird als Summe zweier Nullelemente dargestellt.', 'derived', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(99, '3.99', 17, 'Distributiver Schritt der Nullskalarderivation', '0_Kv=0_Kv+0_Kv', '0_Kv=0_Kv+0_Kv', 'Anwendung der Distributivität auf die Multiplikation mit dem skalaren Nullelement.', 'derived', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(100, '3.100', 17, 'Ergebnis der Nullskalarderivation', '0_V=0_Kv', '0_V=0_Kv', 'Nach Addition des inversen Vektors ergibt sich der Nullvektor.', 'derived', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(101, '3.101', 17, 'Skalarmultiplikation des Nullvektors', '\\lambda 0_V=0_V', '\\lambda 0_V=0_V', 'Jeder Skalar bildet den Nullvektor wieder auf den Nullvektor ab.', 'derived', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(102, '3.102', 17, 'Additive Zerlegung des Nullvektors', '0_V=0_V+0_V', '0_V=0_V+0_V', 'Der Nullvektor wird als Summe zweier Nullvektoren dargestellt.', 'derived', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(103, '3.103', 17, 'Skalierung der Nullvektorzerlegung', '\\lambda 0_V=\\lambda(0_V+0_V)', '\\lambda 0_V=\\lambda(0_V+0_V)', 'Die additive Zerlegung des Nullvektors wird mit einem Skalar multipliziert.', 'derived', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(104, '3.104', 17, 'Distributiver Schritt für den Nullvektor', '\\lambda 0_V=\\lambda 0_V+\\lambda 0_V', '\\lambda 0_V=\\lambda 0_V+\\lambda 0_V', 'Anwendung des Distributivgesetzes auf den skalierten Nullvektor.', 'derived', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(105, '3.105', 17, 'Invarianz des Nullvektors', '\\lambda 0_V=0_V', '\\lambda 0_V=0_V', 'Der Nullvektor bleibt unter jeder Skalarmultiplikation invariant.', 'derived', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(106, '3.106', 17, 'Untervektorraumrelation', 'U\\leq V', 'U\\leq V', 'U ist ein Untervektorraum von V.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(107, '3.107', 17, 'Abgeschlossenheit eines Untervektorraums unter Addition', 'u+v\\in U', 'u+v\\in U', 'Die Summe zweier Vektoren aus U liegt wieder in U.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(108, '3.108', 17, 'Abgeschlossenheit eines Untervektorraums unter Skalarmultiplikation', '\\lambda u\\in U', '\\lambda u\\in U', 'Das skalare Vielfache eines Vektors aus U liegt wieder in U.', 'definition', 'literature', 59, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(109, '3.109', 17, 'Reeller Koordinatenraum', '\\mathbb{R}^n', '\\mathbb{R}^n', 'Der n-dimensionale reelle Koordinatenraum.', 'definition', 'literature', 62, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(110, '3.110', 17, 'Vektor im zweidimensionalen reellen Raum', 'v=\\begin{pmatrix}v_1\\\\v_2 \\end{pmatrix}\\in\\mathbb{R}^2', 'v=\\begin{pmatrix}v_1\\\\v_2 \\end{pmatrix}\\in\\mathbb{R}^2', 'Darstellung eines Vektors im zweidimensionalen reellen Koordinatenraum.', 'definition', 'literature', 62, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(111, '3.111', 17, 'Vektor im dreidimensionalen reellen Raum', 'v=\\begin{pmatrix}v_1\\\\v_2\\\\v_3 \\end{pmatrix}\\in\\mathbb{R}^3', 'v=\\begin{pmatrix}v_1\\\\v_2\\\\v_3 \\end{pmatrix}\\in\\mathbb{R}^3', 'Darstellung eines Vektors im dreidimensionalen reellen Koordinatenraum.', 'definition', 'literature', 62, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(112, '3.112', 17, 'Matrizenraum', '\\mathbb{R}^{m\\times n}', '\\mathbb{R}^{m\\times n}', 'Der Raum aller reellen m-mal-n-Matrizen bildet einen reellen Vektorraum.', 'definition', 'literature', 62, 'Etablierte Aussage der linearen Algebra; im Abschnitt 3.2.4 erläutert.', 'Die Vektorraumstruktur und der zugrunde liegende Skalarkörper sind definiert.', 'verified', 17),
(113, '3.113', 18, 'Vektoren einer Linearkombination', 'v_1,v_2,\\ldots,v_n\\in V', 'v_1,v_2,\\ldots,v_n\\in V', 'Die Vektoren v_1 bis v_n sind Elemente des Vektorraums V.', 'definition', 'literature', 59, 'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.', 'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.', 'verified', 18),
(114, '3.114', 18, 'Skalare einer Linearkombination', '\\lambda_1,\\lambda_2,\\ldots,\\lambda_n\\in\\mathbb{R}', '\\lambda_1,\\lambda_2,\\ldots,\\lambda_n\\in\\mathbb{R}', 'Die Koeffizienten einer reellen Linearkombination sind reelle Skalare.', 'definition', 'literature', 59, 'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.', 'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.', 'verified', 18),
(115, '3.115', 18, 'Allgemeine Linearkombination', '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n', '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n', 'Allgemeine Linearkombination der Vektoren v_1 bis v_n.', 'definition', 'literature', 59, 'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.', 'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.', 'verified', 18),
(116, '3.116', 18, 'Beispielvektoren einer Linearkombination', 'u=\\begin{pmatrix}1\\\\2 \\end{pmatrix},\\qquad v=\\begin{pmatrix}3\\\\1 \\end{pmatrix}', 'u=\\begin{pmatrix}1\\\\2 \\end{pmatrix},\\qquad v=\\begin{pmatrix}3\\\\1 \\end{pmatrix}', 'Zwei Beispielvektoren im zweidimensionalen reellen Koordinatenraum.', '', 'literature', 62, 'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.', 'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.', 'verified', 18),
(117, '3.117', 18, 'Beispiel einer Linearkombination', '2u-v=\\begin{pmatrix}-1\\\\3 \\end{pmatrix}', '2u-v=\\begin{pmatrix}-1\\\\3 \\end{pmatrix}', 'Berechnete Linearkombination der in Gleichung (3.116) definierten Vektoren.', '', 'literature', 62, 'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.', 'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.', 'verified', 18),
(118, '3.118', 18, 'Notation des Spannraums', '\\operatorname{span}(v_1,\\ldots,v_n)', '\\operatorname{span}(v_1,\\ldots,v_n)', 'Notation für den von den Vektoren v_1 bis v_n erzeugten Spannraum.', 'definition', 'literature', 59, 'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.', 'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.', 'verified', 18),
(119, '3.119', 18, 'Mengendarstellung des Spannraums', '\\operatorname{span}(v_1,\\ldots,v_n)=\\left\\{\\sum_{i=1}^{n}\\lambda_i v_i\\mid\\lambda_i\\in\\mathbb{R}\\right\\}', '\\operatorname{span}(v_1,\\ldots,v_n)=\\left\\{\\sum_{i=1}^{n}\\lambda_i v_i\\mid\\lambda_i\\in\\mathbb{R}\\right\\}', 'Der Spannraum als Menge sämtlicher reeller Linearkombinationen der gegebenen Vektoren.', 'definition', 'literature', 59, 'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.', 'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.', 'verified', 18),
(120, '3.120', 18, 'Erzeugendensystem eines Vektorraums', 'V=\\operatorname{span}(v_1,\\ldots,v_n)', 'V=\\operatorname{span}(v_1,\\ldots,v_n)', 'Die Vektoren v_1 bis v_n erzeugen den gesamten Vektorraum V.', 'definition', 'literature', 59, 'Die Gleichung wird im Text von Abschnitt 3.2.5 eingeführt und anhand der zitierten Grundlagenliteratur erläutert.', 'Der Vektorraum V, seine Addition und seine Skalarmultiplikation sind gemäß Abschnitt 3.2.4 definiert.', 'verified', 18),
(121, '3.121', 19, 'Vektoren für die Unabhängigkeitsprüfung', 'v_1,v_2,\\ldots,v_n\\in V', 'v_1,v_2,\\ldots,v_n\\in V', 'Vektoren für die Unabhängigkeitsprüfung', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(122, '3.122', 19, 'Homogene Linearkombination', '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n=0_V', '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n=0_V', 'Homogene Linearkombination', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(123, '3.123', 19, 'Triviale Koeffizientenlösung', '\\lambda_1=\\lambda_2=\\cdots=\\lambda_n=0', '\\lambda_1=\\lambda_2=\\cdots=\\lambda_n=0', 'Triviale Koeffizientenlösung', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(124, '3.124', 19, 'Vektormenge', '\\{v_1,\\ldots,v_n\\}', '\\{v_1,\\ldots,v_n\\}', 'Vektormenge', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(125, '3.125', 19, 'Reelle Koeffizienten', '\\lambda_1,\\ldots,\\lambda_n\\in\\mathbb{R}', '\\lambda_1,\\ldots,\\lambda_n\\in\\mathbb{R}', 'Reelle Koeffizienten', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(126, '3.126', 19, 'Kriterium linearer Abhängigkeit', '\\sum_{i=1}^{n}\\lambda_i v_i=0_V', '\\sum_{i=1}^{n}\\lambda_i v_i=0_V', 'Kriterium linearer Abhängigkeit', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(127, '3.127', 19, 'Darstellung eines abhängigen Vektors', 'v_k=-\\sum_{\\substack{i=1\\\\i\\neq k}}^{n}\\frac{\\lambda_i}{\\lambda_k}v_i', 'v_k=-\\sum_{\\substack{i=1\\\\i\\neq k}}^{n}\\frac{\\lambda_i}{\\lambda_k}v_i', 'Darstellung eines abhängigen Vektors', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(128, '3.128', 19, 'Abhängige Beispielvektoren', 'v_1=\\begin{pmatrix}1\\\\2 \\end{pmatrix},\\qquad v_2=\\begin{pmatrix}2\\\\4 \\end{pmatrix}', 'v_1=\\begin{pmatrix}1\\\\2 \\end{pmatrix},\\qquad v_2=\\begin{pmatrix}2\\\\4 \\end{pmatrix}', 'Abhängige Beispielvektoren', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(129, '3.129', 19, 'Skalare Abhängigkeit', 'v_2=2v_1', 'v_2=2v_1', 'Skalare Abhängigkeit', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(130, '3.130', 19, 'Nichttriviale Nullkombination', '2v_1-v_2=0_{\\mathbb{R}^2}', '2v_1-v_2=0_{\\mathbb{R}^2}', 'Nichttriviale Nullkombination', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(131, '3.131', 19, 'Standardbasis in R2', 'e_1=\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\qquad e_2=\\begin{pmatrix}0\\\\1 \\end{pmatrix}', 'e_1=\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\qquad e_2=\\begin{pmatrix}0\\\\1 \\end{pmatrix}', 'Standardbasis in R2', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(132, '3.132', 19, 'Unabhängigkeitsprüfung', '\\lambda_1e_1+\\lambda_2e_2=\\begin{pmatrix}\\lambda_1\\\\\\lambda_2 \\end{pmatrix}=\\begin{pmatrix}0\\\\0 \\end{pmatrix}', '\\lambda_1e_1+\\lambda_2e_2=\\begin{pmatrix}\\lambda_1\\\\\\lambda_2 \\end{pmatrix}=\\begin{pmatrix}0\\\\0 \\end{pmatrix}', 'Unabhängigkeitsprüfung', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(133, '3.133', 19, 'Triviale Lösung', '\\lambda_1=0\\qquad\\text{und}\\qquad\\lambda_2=0', '\\lambda_1=0\\qquad\\text{und}\\qquad\\lambda_2=0', 'Triviale Lösung', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(134, '3.134', 19, 'Geordnete Basis', 'B=(b_1,\\ldots,b_n)', 'B=(b_1,\\ldots,b_n)', 'Geordnete Basis', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(135, '3.135', 19, 'Erzeugungseigenschaft', 'V=\\operatorname{span}(b_1,\\ldots,b_n)', 'V=\\operatorname{span}(b_1,\\ldots,b_n)', 'Erzeugungseigenschaft', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(136, '3.136', 19, 'Eindeutige Basisdarstellung', 'v=\\alpha_1b_1+\\cdots+\\alpha_nb_n', 'v=\\alpha_1b_1+\\cdots+\\alpha_nb_n', 'Eindeutige Basisdarstellung', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(137, '3.137', 19, 'Standardbasis allgemein', 'e_1,\\ldots,e_n', 'e_1,\\ldots,e_n', 'Standardbasis allgemein', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(138, '3.138', 19, 'Standardbasis in R3', 'e_1=\\begin{pmatrix}1\\\\0\\\\0 \\end{pmatrix},\\qquad e_2=\\begin{pmatrix}0\\\\1\\\\0 \\end{pmatrix},\\qquad e_3=\\begin{pmatrix}0\\\\0\\\\1 \\end{pmatrix}', 'e_1=\\begin{pmatrix}1\\\\0\\\\0 \\end{pmatrix},\\qquad e_2=\\begin{pmatrix}0\\\\1\\\\0 \\end{pmatrix},\\qquad e_3=\\begin{pmatrix}0\\\\0\\\\1 \\end{pmatrix}', 'Standardbasis in R3', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(139, '3.139', 19, 'Vektor in R3', 'v=\\begin{pmatrix}v_1\\\\v_2\\\\v_3 \\end{pmatrix}\\in\\mathbb{R}^3', 'v=\\begin{pmatrix}v_1\\\\v_2\\\\v_3 \\end{pmatrix}\\in\\mathbb{R}^3', 'Vektor in R3', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(140, '3.140', 19, 'Basiszerlegung in R3', 'v=v_1e_1+v_2e_2+v_3e_3', 'v=v_1e_1+v_2e_2+v_3e_3', 'Basiszerlegung in R3', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(141, '3.141', 19, 'Allgemeine Basisnotation', 'B=(b_1,\\ldots,b_n)', 'B=(b_1,\\ldots,b_n)', 'Allgemeine Basisnotation', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(142, '3.142', 19, 'Koordinatenvektor', '[v]_B=\\begin{pmatrix}\\alpha_1\\\\\\vdots\\\\\\alpha_n \\end{pmatrix}', '[v]_B=\\begin{pmatrix}\\alpha_1\\\\\\vdots\\\\\\alpha_n \\end{pmatrix}', 'Koordinatenvektor', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(143, '3.143', 19, 'Dimension', '\\dim(V)=n', '\\dim(V)=n', 'Dimension', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(144, '3.144', 19, 'Dimension von Rn', '\\dim(\\mathbb{R}^n)=n', '\\dim(\\mathbb{R}^n)=n', 'Dimension von Rn', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(145, '3.145', 19, 'Dimension von R2', '\\dim(\\mathbb{R}^2)=2', '\\dim(\\mathbb{R}^2)=2', 'Dimension von R2', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(146, '3.146', 19, 'Dimension von R3', '\\dim(\\mathbb{R}^3)=3', '\\dim(\\mathbb{R}^3)=3', 'Dimension von R3', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 19),
(147, '3.147', 20, 'Basis B', 'B=(b_1,b_2,\\ldots,b_n)', 'B=(b_1,b_2,\\ldots,b_n)', 'Basis B', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(148, '3.148', 20, 'Vektor im Vektorraum', 'v\\in V', 'v\\in V', 'Vektor im Vektorraum', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(149, '3.149', 20, 'Basisdarstellung', 'v=\\sum_{i=1}^{n}\\alpha_i b_i', 'v=\\sum_{i=1}^{n}\\alpha_i b_i', 'Basisdarstellung', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(150, '3.150', 20, 'Koordinatenvektor bezüglich B', '[v]_B=\\begin{pmatrix}\\alpha_1\\\\\\alpha_2\\\\\\vdots\\\\\\alpha_n \\end{pmatrix}', '[v]_B=\\begin{pmatrix}\\alpha_1\\\\\\alpha_2\\\\\\vdots\\\\\\alpha_n \\end{pmatrix}', 'Koordinatenvektor bezüglich B', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(151, '3.151', 20, 'Erste Basis', 'B=(b_1,\\ldots,b_n)', 'B=(b_1,\\ldots,b_n)', 'Erste Basis', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(152, '3.152', 20, 'Zweite Basis', 'C=(c_1,\\ldots,c_n)', 'C=(c_1,\\ldots,c_n)', 'Zweite Basis', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(153, '3.153', 20, 'Koordinaten bezüglich B', '[v]_B', '[v]_B', 'Koordinaten bezüglich B', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(154, '3.154', 20, 'Koordinaten bezüglich C', '[v]_C', '[v]_C', 'Koordinaten bezüglich C', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(155, '3.155', 20, 'Basiswechselmatrix', 'P_{B\\rightarrow C}', 'P_{B\\rightarrow C}', 'Basiswechselmatrix', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(156, '3.156', 20, 'Koordinatentransformation', '[v]_C=P_{B\\rightarrow C}[v]_B', '[v]_C=P_{B\\rightarrow C}[v]_B', 'Koordinatentransformation', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(157, '3.157', 20, 'Inverse Basiswechselmatrix', 'P_{C\\rightarrow B}=P_{B\\rightarrow C}^{-1}', 'P_{C\\rightarrow B}=P_{B\\rightarrow C}^{-1}', 'Inverse Basiswechselmatrix', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(158, '3.158', 20, 'Rücktransformation', '[v]_B=P_{C\\rightarrow B}[v]_C', '[v]_B=P_{C\\rightarrow B}[v]_C', 'Rücktransformation', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(159, '3.159', 20, 'Standardbasis in R2', 'B=\\left(\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\begin{pmatrix}0\\\\1 \\end{pmatrix}\\right)', 'B=\\left(\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\begin{pmatrix}0\\\\1 \\end{pmatrix}\\right)', 'Standardbasis in R2', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(160, '3.160', 20, 'Alternative Basis in R2', 'C=\\left(\\begin{pmatrix}1\\\\1 \\end{pmatrix},\\begin{pmatrix}1\\\\-1 \\end{pmatrix}\\right)', 'C=\\left(\\begin{pmatrix}1\\\\1 \\end{pmatrix},\\begin{pmatrix}1\\\\-1 \\end{pmatrix}\\right)', 'Alternative Basis in R2', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(161, '3.161', 20, 'Basiswechselmatrix im Beispiel', 'P_{C\\rightarrow B}=\\begin{pmatrix}1&1\\\\1&-1 \\end{pmatrix}', 'P_{C\\rightarrow B}=\\begin{pmatrix}1&1\\\\1&-1 \\end{pmatrix}', 'Basiswechselmatrix im Beispiel', 'definition', 'literature', 62, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(162, '3.162', 20, 'Linearer Operator', 'T:V\\rightarrow V', 'T:V\\rightarrow V', 'Linearer Operator', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(163, '3.163', 20, 'Matrixdarstellung bezüglich B', 'A_B', 'A_B', 'Matrixdarstellung bezüglich B', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(164, '3.164', 20, 'Ähnlichkeitstransformation', 'A_C=P_{B\\rightarrow C}A_BP_{C\\rightarrow B}', 'A_C=P_{B\\rightarrow C}A_BP_{C\\rightarrow B}', 'Ähnlichkeitstransformation', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(165, '3.165', 20, 'Determinanteninvarianz', '\\det(A_C)=\\det(A_B)', '\\det(A_C)=\\det(A_B)', 'Determinanteninvarianz', 'definition', 'literature', 59, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(166, '3.166', 20, 'Spektralinvarianz', '\\sigma(A_B)=\\sigma(A_C)', '\\sigma(A_B)=\\sigma(A_C)', 'Spektralinvarianz', 'definition', 'literature', 64, 'Im zugehörigen Abschnitt eingeführt und erläutert.', 'Die vorausgehenden Strukturen sind definiert.', 'verified', 20),
(167, '3.167', 21, 'Quadratische Matrix', 'A\\in\\mathbb{R}^{n\\times n}', 'A\\in\\mathbb{R}^{n\\times n}', 'A ist eine reelle quadratische n-mal-n-Matrix.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(168, '3.168', 21, 'Determinantennotation', '\\det(A)', '\\det(A)', 'Notation der Determinante.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(169, '3.169', 21, 'Alternative Determinantennotation', '|A|', '|A|', 'Alternative Notation der Determinante.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(170, '3.170', 21, 'Determinante als Abbildung', '\\det:\\mathbb{R}^{n\\times n}\\rightarrow\\mathbb{R}', '\\det:\\mathbb{R}^{n\\times n}\\rightarrow\\mathbb{R}', 'Die Determinante ordnet jeder quadratischen Matrix einen reellen Skalar zu.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(171, '3.171', 21, 'Allgemeine 2x2-Matrix', 'A=\\begin{pmatrix}a&b\\\\c&d \\end{pmatrix}', 'A=\\begin{pmatrix}a&b\\\\c&d \\end{pmatrix}', 'Allgemeine reelle 2x2-Matrix.', 'definition', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(172, '3.172', 21, 'Determinante einer 2x2-Matrix', '\\det(A)=\\begin{matrix}a&b\\\\c&d \\end{matrix}=ad-bc', '\\det(A)=\\begin{matrix}a&b\\\\c&d \\end{matrix}=ad-bc', 'Berechnung der Determinante einer 2x2-Matrix.', 'definition', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(173, '3.173', 21, 'Diagonalmatrix im Beispiel', 'A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}', 'A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}', 'Beispiel einer diagonalen Matrix.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(174, '3.174', 21, 'Determinante des Beispiels', '\\det(A)=2\\cdot3-0\\cdot0=6', '\\det(A)=2\\cdot3-0\\cdot0=6', 'Berechnung der Determinante des Beispiels.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(175, '3.175', 21, 'Allgemeine 3x3-Matrix', 'A=\\begin{pmatrix}a_{11}&a_{12}&a_{13}\\\\a_{21}&a_{22}&a_{23}\\\\a_{31}&a_{32}&a_{33} \\end{pmatrix}', 'A=\\begin{pmatrix}a_{11}&a_{12}&a_{13}\\\\a_{21}&a_{22}&a_{23}\\\\a_{31}&a_{32}&a_{33} \\end{pmatrix}', 'Allgemeine reelle 3x3-Matrix.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(176, '3.176', 21, 'Laplace-Entwicklung', '\\det(A)=a_{11}\\begin{matrix}a_{22}&a_{23}\\\\a_{32}&a_{33} \\end{matrix}-a_{12}\\begin{matrix}a_{21}&a_{23}\\\\a_{31}&a_{33} \\end{matrix}+a_{13}\\begin{matrix}a_{21}&a_{22}\\\\a_{31}&a_{32} \\end{matrix}', '\\det(A)=a_{11}\\begin{matrix}a_{22}&a_{23}\\\\a_{32}&a_{33} \\end{matrix}-a_{12}\\begin{matrix}a_{21}&a_{23}\\\\a_{31}&a_{33} \\end{matrix}+a_{13}\\begin{matrix}a_{21}&a_{22}\\\\a_{31}&a_{32} \\end{matrix}', 'Laplace-Entwicklung nach der ersten Zeile.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(177, '3.177', 21, 'Lineare Abbildung zur Matrix', 'T_A:\\mathbb{R}^n\\rightarrow\\mathbb{R}^n', 'T_A:\\mathbb{R}^n\\rightarrow\\mathbb{R}^n', 'Durch A dargestellte lineare Abbildung.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(178, '3.178', 21, 'Volumenskalierung', '\\operatorname{Vol}(T_A(M))=|\\det(A)|\\operatorname{Vol}(M)', '\\operatorname{Vol}(T_A(M))=|\\det(A)|\\operatorname{Vol}(M)', 'Der Betrag der Determinante skaliert Volumina.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(179, '3.179', 21, 'Volumenvergrößerung', '|\\det(A)|>1', '|\\det(A)|>1', 'Bedingung für Volumenvergrößerung.', 'derived', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(180, '3.180', 21, 'Volumenverkleinerung', '0<|\\det(A)|<1', '0<|\\det(A)|<1', 'Bedingung für Volumenverkleinerung.', 'derived', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(181, '3.181', 21, 'Volumenerhaltung', '|\\det(A)|=1', '|\\det(A)|=1', 'Bedingung für Volumenerhaltung.', 'derived', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(182, '3.182', 21, 'Positive Determinante', '\\det(A)>0', '\\det(A)>0', 'Orientierungserhaltende Transformation.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(183, '3.183', 21, 'Negative Determinante', '\\det(A)<0', '\\det(A)<0', 'Orientierungsumkehrende Transformation.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(184, '3.184', 21, 'Spiegelungsmatrix', 'S=\\begin{pmatrix}-1&0\\\\0&1 \\end{pmatrix}', 'S=\\begin{pmatrix}-1&0\\\\0&1 \\end{pmatrix}', 'Beispiel einer Spiegelungsmatrix.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(185, '3.185', 21, 'Determinante der Spiegelung', '\\det(S)=-1', '\\det(S)=-1', 'Determinante der Spiegelungsmatrix.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(186, '3.186', 21, 'Singularitätsbedingung', '\\det(A)=0', '\\det(A)=0', 'Bedingung für Singularität.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(187, '3.187', 21, 'Regularitätsbedingung', '\\det(A)\\neq0', '\\det(A)\\neq0', 'Bedingung für Regularität.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(188, '3.188', 21, 'Invertierbarkeitskriterium', 'A\\text{ ist invertierbar}\\iff\\det(A)\\neq0', 'A\\text{ ist invertierbar}\\iff\\det(A)\\neq0', 'Äquivalenz von Invertierbarkeit und nichtverschwindender Determinante.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(189, '3.189', 21, 'Singuläre Beispielmatrix', 'A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}', 'A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}', 'Beispiel einer singulären Matrix.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(190, '3.190', 21, 'Determinante der singulären Matrix', '\\det(A)=1\\cdot4-2\\cdot2=0', '\\det(A)=1\\cdot4-2\\cdot2=0', 'Berechnung der verschwindenden Determinante.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(191, '3.191', 21, 'Lineare Abhängigkeit der Spalten', '\\begin{pmatrix}2\\\\4 \\end{pmatrix}=2\\begin{pmatrix}1\\\\2 \\end{pmatrix}', '\\begin{pmatrix}2\\\\4 \\end{pmatrix}=2\\begin{pmatrix}1\\\\2 \\end{pmatrix}', 'Die zweite Spalte ist ein Vielfaches der ersten.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(192, '3.192', 21, 'Nichtverschwindende Determinante', '\\det(A)\\neq0', '\\det(A)\\neq0', 'Ausgangspunkt der Äquivalenzbedingungen.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(193, '3.193', 21, 'Voller Rang', '\\operatorname{rang}(A)=n', '\\operatorname{rang}(A)=n', 'Reguläre quadratische Matrix mit vollem Rang.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(194, '3.194', 21, 'Inverse Matrix', 'A^{-1}', 'A^{-1}', 'Notation der inversen Matrix.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(195, '3.195', 21, 'Äquivalenzen regulärer Matrizen', '\\det(A)\\neq0\\iff\\operatorname{rang}(A)=n\\iff A^{-1}\\text{ existiert}', '\\det(A)\\neq0\\iff\\operatorname{rang}(A)=n\\iff A^{-1}\\text{ existiert}', 'Äquivalenz von Determinante, Rang und Invertierbarkeit.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(196, '3.196', 21, 'Quadratische Matrizen A und B', 'A,B\\in\\mathbb{R}^{n\\times n}', 'A,B\\in\\mathbb{R}^{n\\times n}', 'Zwei quadratische Matrizen gleicher Ordnung.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(197, '3.197', 21, 'Multiplikativität', '\\det(AB)=\\det(A)\\det(B)', '\\det(AB)=\\det(A)\\det(B)', 'Multiplikativität der Determinante.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(198, '3.198', 21, 'Inverse Identitätsbeziehung', 'AA^{-1}=I', 'AA^{-1}=I', 'Produkt einer Matrix mit ihrer Inversen.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(199, '3.199', 21, 'Determinante der Einheitsmatrix', '\\det(I)=1', '\\det(I)=1', 'Die Einheitsmatrix besitzt Determinante eins.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(200, '3.200', 21, 'Determinante der inversen Matrix', '\\det(A^{-1})=\\frac{1}{\\det(A)}', '\\det(A^{-1})=\\frac{1}{\\det(A)}', 'Kehrwertbeziehung der Determinanten.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(201, '3.201', 21, 'Ähnlichkeitstransformation', 'A_C=P^{-1}A_BP', 'A_C=P^{-1}A_BP', 'Darstellung desselben Operators in einer anderen Basis.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(202, '3.202', 21, 'Determinante der Ähnlichkeitstransformation', '\\det(A_C)=\\det(P^{-1})\\det(A_B)\\det(P)', '\\det(A_C)=\\det(P^{-1})\\det(A_B)\\det(P)', 'Multiplikativität bei Ähnlichkeitstransformationen.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(203, '3.203', 21, 'Determinantenprodukt inverser Matrizen', '\\det(P^{-1})\\det(P)=1', '\\det(P^{-1})\\det(P)=1', 'Produkt der Determinanten inverser Matrizen.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(204, '3.204', 21, 'Basisinvarianz der Determinante', '\\det(A_C)=\\det(A_B)', '\\det(A_C)=\\det(A_B)', 'Ähnliche Matrizen besitzen dieselbe Determinante.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.8 eingeführt und erläutert.', 'Quadratische Matrizen, lineare Operatoren und Basiswechsel sind definiert.', 'verified', 21),
(205, '3.205', 22, 'Lineare Abbildung zwischen Vektorräumen', 'T:V\\rightarrow W', 'T:V\\rightarrow W', 'Lineare Abbildung vom Vektorraum V in den Vektorraum W.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(206, '3.206', 22, 'Bild einer linearen Abbildung', '\\operatorname{Bild}(T)=\\{\\,T(v)\\mid v\\in V\\,\\}', '\\operatorname{Bild}(T)=\\{\\,T(v)\\mid v\\in V\\,\\}', 'Menge aller durch T erreichbaren Vektoren im Zielraum.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(207, '3.207', 22, 'Kern einer linearen Abbildung', '\\ker(T)=\\{\\,v\\in V\\mid T(v)=0_W\\,\\}', '\\ker(T)=\\{\\,v\\in V\\mid T(v)=0_W\\,\\}', 'Menge aller Vektoren, die auf den Nullvektor abgebildet werden.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(208, '3.208', 22, 'Rang einer linearen Abbildung', '\\operatorname{rang}(T)=\\dim(\\operatorname{Bild}(T))', '\\operatorname{rang}(T)=\\dim(\\operatorname{Bild}(T))', 'Der Rang ist die Dimension des Bildraums.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(209, '3.209', 22, 'Rang einer Matrix', '\\operatorname{rang}(A)', '\\operatorname{rang}(A)', 'Notation des Rangs einer Matrix.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(210, '3.210', 22, 'Rechteckige Matrix', 'A\\in\\mathbb{R}^{m\\times n}', 'A\\in\\mathbb{R}^{m\\times n}', 'Allgemeine reelle m-mal-n-Matrix.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(211, '3.211', 22, 'Gleichheit von Spalten- und Zeilenrang', '\\operatorname{Spaltenrang}(A)=\\operatorname{Zeilenrang}(A)', '\\operatorname{Spaltenrang}(A)=\\operatorname{Zeilenrang}(A)', 'Spaltenrang und Zeilenrang einer Matrix stimmen überein.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(212, '3.212', 22, 'Beispielmatrix', 'A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}', 'A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}', 'Beispiel einer Matrix mit linear abhängigen Spalten.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(213, '3.213', 22, 'Abhängigkeit der Spalten', '\\begin{pmatrix}2\\\\4 \\end{pmatrix}=2\\begin{pmatrix}1\\\\2 \\end{pmatrix}', '\\begin{pmatrix}2\\\\4 \\end{pmatrix}=2\\begin{pmatrix}1\\\\2 \\end{pmatrix}', 'Die zweite Spalte ist ein skalares Vielfaches der ersten.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(214, '3.214', 22, 'Rang der Beispielmatrix', '\\operatorname{rang}(A)=1', '\\operatorname{rang}(A)=1', 'Die Beispielmatrix besitzt genau eine unabhängige Spaltenrichtung.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(215, '3.215', 22, 'Allgemeine Matrix für vollen Rang', 'A\\in\\mathbb{R}^{m\\times n}', 'A\\in\\mathbb{R}^{m\\times n}', 'Allgemeine Matrix zur Formulierung der Rangschranke.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(216, '3.216', 22, 'Rangschranke', '\\operatorname{rang}(A)\\le\\min(m,n)', '\\operatorname{rang}(A)\\le\\min(m,n)', 'Der Rang ist höchstens so groß wie die kleinere Matrixdimension.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(217, '3.217', 22, 'Voller Rang einer quadratischen Matrix', '\\operatorname{rang}(A)=n', '\\operatorname{rang}(A)=n', 'Bedingung für vollen Rang bei einer n-mal-n-Matrix.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(218, '3.218', 22, 'Determinantenkriterium', '\\det(A)\\neq0', '\\det(A)\\neq0', 'Nichtverschwindende Determinante als Äquivalent zu vollem Rang.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(219, '3.219', 22, 'Lineare Abbildung für den Dimensionssatz', 'T:V\\rightarrow W', 'T:V\\rightarrow W', 'Lineare Abbildung mit endlichdimensionalem Definitionsbereich.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(220, '3.220', 22, 'Dimensionssatz', '\\dim(V)=\\dim(\\ker(T))+\\operatorname{rang}(T)', '\\dim(V)=\\dim(\\ker(T))+\\operatorname{rang}(T)', 'Rang-Nullitätssatz für lineare Abbildungen.', 'theorem', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(221, '3.221', 22, 'Beispielmatrix zum Dimensionssatz', 'A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}', 'A=\\begin{pmatrix}1&2\\\\2&4 \\end{pmatrix}', 'Erneute Verwendung der singulären Beispielmatrix.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(222, '3.222', 22, 'Rang im Dimensionsbeispiel', '\\operatorname{rang}(A)=1', '\\operatorname{rang}(A)=1', 'Rang der Beispielmatrix.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(223, '3.223', 22, 'Dimension des Definitionsbereichs', '\\dim(\\mathbb{R}^2)=2', '\\dim(\\mathbb{R}^2)=2', 'Dimension des zweidimensionalen Definitionsbereichs.', '', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(224, '3.224', 22, 'Dimension des Kerns', '\\dim(\\ker(A))=1', '\\dim(\\ker(A))=1', 'Aus dem Dimensionssatz abgeleitete Kerndimension.', 'derived', 'literature', 62, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(225, '3.225', 22, 'Lineares Gleichungssystem', 'Ax=b', 'Ax=b', 'Matrixdarstellung eines linearen Gleichungssystems.', 'definition', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(226, '3.226', 22, 'Bedingung für eindeutige Lösung', '\\operatorname{rang}(A)=n', '\\operatorname{rang}(A)=n', 'Voller Spaltenrang als Bedingung für Eindeutigkeit im quadratischen Fall.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(227, '3.227', 22, 'Rangdefizit', '\\operatorname{rang}(A)<n', '\\operatorname{rang}(A)<n', 'Bedingung für fehlende Eindeutigkeit.', 'derived', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(228, '3.228', 22, 'Äquivalenzen für quadratische Matrizen', '\\det(A)\\neq0\\iff\\operatorname{rang}(A)=n\\iff\\ker(A)=\\{0\\}', '\\det(A)\\neq0\\iff\\operatorname{rang}(A)=n\\iff\\ker(A)=\\{0\\}', 'Zusammenhang zwischen Determinante, Rang und trivialem Kern.', 'theorem', 'literature', 59, 'Die Gleichung wird in Abschnitt 3.2.9 eingeführt und aus den Grundlagen der linearen Algebra erläutert.', 'Vektorräume, lineare Abbildungen, Dimension und Determinante sind definiert.', 'verified', 22),
(229, '3.229', 23, 'Linearer Operator', 'T:V\\rightarrow V', 'T:V\\rightarrow V', 'Linearer Operator auf V', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(230, '3.230', 23, 'Nichttrivialer Vektor', 'v\\in V,\\qquad v\\neq0_V', 'v\\in V,\\qquad v\\neq0_V', 'Voraussetzung für einen Eigenvektor', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(231, '3.231', 23, 'Eigenwert als Skalar', '\\lambda\\in\\mathbb{R}', '\\lambda\\in\\mathbb{R}', 'Reeller Skalar als möglicher Eigenwert', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(232, '3.232', 23, 'Eigenwertgleichung des Operators', 'T(v)=\\lambda v', 'T(v)=\\lambda v', 'Definitionale Eigenwertgleichung', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(233, '3.233', 23, 'Quadratische Darstellungsmatrix', 'A\\in\\mathbb{R}^{n\\times n}', 'A\\in\\mathbb{R}^{n\\times n}', 'Quadratische reelle Darstellungsmatrix', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(234, '3.234', 23, 'Eigenwertgleichung der Matrix', 'Av=\\lambda v', 'Av=\\lambda v', 'Matrixform der Eigenwertgleichung', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(235, '3.235', 23, 'Umgeformte Eigenwertgleichung', 'Av-\\lambda v=0', 'Av-\\lambda v=0', 'Homogene Umformung', 'derived', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(236, '3.236', 23, 'Homogenes Eigenwertsystem', '(A-\\lambda I)v=0', '(A-\\lambda I)v=0', 'Homogenes Eigenwertsystem', 'derived', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(237, '3.237', 23, 'Charakteristische Gleichung', '\\det(A-\\lambda I)=0', '\\det(A-\\lambda I)=0', 'Singularitätsbedingung', 'theorem', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(238, '3.238', 23, 'Charakteristisches Polynom', 'p_A(\\lambda)=\\det(A-\\lambda I)', 'p_A(\\lambda)=\\det(A-\\lambda I)', 'Definition des charakteristischen Polynoms', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(239, '3.239', 23, 'Nullstellenbedingung', 'p_A(\\lambda)=0', 'p_A(\\lambda)=0', 'Eigenwerte als Nullstellen', 'derived', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(240, '3.240', 23, 'Diagonalmatrix im Beispiel', 'A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}', 'A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}', 'Diagonale Beispielmatrix', '', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(241, '3.241', 23, 'Charakteristische Gleichung des Beispiels', '\\det\\begin{pmatrix}2-\\lambda&0\\\\0&3-\\lambda \\end{pmatrix}=0', '\\det\\begin{pmatrix}2-\\lambda&0\\\\0&3-\\lambda \\end{pmatrix}=0', 'Charakteristische Gleichung des Beispiels', '', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(242, '3.242', 23, 'Faktorisierte Gleichung', '(2-\\lambda)(3-\\lambda)=0', '(2-\\lambda)(3-\\lambda)=0', 'Faktorisierte charakteristische Gleichung', '', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(243, '3.243', 23, 'Eigenwerte der Diagonalmatrix', '\\lambda_1=2\\qquad\\text{und}\\qquad\\lambda_2=3', '\\lambda_1=2\\qquad\\text{und}\\qquad\\lambda_2=3', 'Eigenwerte des Beispiels', '', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(244, '3.244', 23, 'Erster Eigenvektor', 'v_1=\\begin{pmatrix}1\\\\0 \\end{pmatrix}', 'v_1=\\begin{pmatrix}1\\\\0 \\end{pmatrix}', 'Eigenvektor zu λ=2', '', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(245, '3.245', 23, 'Prüfung des ersten Eigenvektors', 'Av_1=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}\\begin{pmatrix}1\\\\0 \\end{pmatrix}=\\begin{pmatrix}2\\\\0 \\end{pmatrix}=2v_1', 'Av_1=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}\\begin{pmatrix}1\\\\0 \\end{pmatrix}=\\begin{pmatrix}2\\\\0 \\end{pmatrix}=2v_1', 'Prüfung von v1', '', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(246, '3.246', 23, 'Zweiter Eigenvektor', 'v_2=\\begin{pmatrix}0\\\\1 \\end{pmatrix}', 'v_2=\\begin{pmatrix}0\\\\1 \\end{pmatrix}', 'Eigenvektor zu λ=3', '', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(247, '3.247', 23, 'Prüfung des zweiten Eigenvektors', 'Av_2=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}\\begin{pmatrix}0\\\\1 \\end{pmatrix}=\\begin{pmatrix}0\\\\3 \\end{pmatrix}=3v_2', 'Av_2=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}\\begin{pmatrix}0\\\\1 \\end{pmatrix}=\\begin{pmatrix}0\\\\3 \\end{pmatrix}=3v_2', 'Prüfung von v2', '', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(248, '3.248', 23, 'Eigenraum als Kern', 'E_\\lambda=\\ker(A-\\lambda I)', 'E_\\lambda=\\ker(A-\\lambda I)', 'Definition des Eigenraums', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(249, '3.249', 23, 'Mengenbeschreibung des Eigenraums', 'E_\\lambda=\\{\\,v\\in V\\mid Av=\\lambda v\\,\\}', 'E_\\lambda=\\{\\,v\\in V\\mid Av=\\lambda v\\,\\}', 'Mengenbeschreibung des Eigenraums', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(250, '3.250', 23, 'Geometrische Vielfachheit', 'g_\\lambda=\\dim(E_\\lambda)', 'g_\\lambda=\\dim(E_\\lambda)', 'Definition der geometrischen Vielfachheit', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(251, '3.251', 23, 'Faktorisierung des charakteristischen Polynoms', 'p_A(\\lambda)=(\\lambda-\\lambda_1)^{m_1}\\cdots(\\lambda-\\lambda_k)^{m_k}', 'p_A(\\lambda)=(\\lambda-\\lambda_1)^{m_1}\\cdots(\\lambda-\\lambda_k)^{m_k}', 'Algebraische Vielfachheiten', 'definition', 'literature', 64, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(252, '3.252', 23, 'Zusammenhang der Vielfachheiten', '1\\le g_{\\lambda_i}\\le m_i', '1\\le g_{\\lambda_i}\\le m_i', 'Geometrische und algebraische Vielfachheit', 'theorem', 'literature', 64, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(253, '3.253', 23, 'Fixvektorbedingung', 'Av=v', 'Av=v', 'Eigenwert eins', 'derived', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(254, '3.254', 23, 'Negativer Einheitseigenwert', '\\lambda=-1', '\\lambda=-1', 'Eigenwert minus eins', 'definition', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(255, '3.255', 23, 'Orientierungsumkehr', 'Av=-v', 'Av=-v', 'Wirkung von λ=-1', 'derived', 'literature', 62, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(256, '3.256', 23, 'Null als Eigenwert', '\\lambda=0', '\\lambda=0', 'Eigenwert null', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(257, '3.257', 23, 'Nullabbildung eines Eigenvektors', 'Av=0', 'Av=0', 'Eigenvektor im Kern', 'derived', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(258, '3.258', 23, 'Null-Eigenwert und Kern', '0\\text{ ist Eigenwert von }A\\iff\\ker(A)\\neq\\{0\\}', '0\\text{ ist Eigenwert von }A\\iff\\ker(A)\\neq\\{0\\}', 'Äquivalenz mit nichttrivialem Kern', 'theorem', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(259, '3.259', 23, 'Null-Eigenwert und Singularität', '\\det(A)=0', '\\det(A)=0', 'Singularitätsbedingung', 'derived', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(260, '3.260', 23, 'Ähnlichkeitstransformation', 'A_C=P^{-1}A_BP', 'A_C=P^{-1}A_BP', 'Basiswechsel', 'derived', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(261, '3.261', 23, 'Invarianz der charakteristischen Determinante', '\\det(A_C-\\lambda I)=\\det(A_B-\\lambda I)', '\\det(A_C-\\lambda I)=\\det(A_B-\\lambda I)', 'Invarianz unter Ähnlichkeit', 'theorem', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(262, '3.262', 23, 'Invarianz des charakteristischen Polynoms', 'p_{A_C}(\\lambda)=p_{A_B}(\\lambda)', 'p_{A_C}(\\lambda)=p_{A_B}(\\lambda)', 'Gleiches charakteristisches Polynom', 'theorem', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(263, '3.263', 23, 'Invarianz des Spektrums', '\\sigma(A_C)=\\sigma(A_B)', '\\sigma(A_C)=\\sigma(A_B)', 'Gleiches Spektrum', 'theorem', 'literature', 64, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(264, '3.264', 23, 'Spektrum einer Matrix', '\\sigma(A)=\\{\\,\\lambda\\in\\mathbb{R}\\mid\\det(A-\\lambda I)=0\\,\\}', '\\sigma(A)=\\{\\,\\lambda\\in\\mathbb{R}\\mid\\det(A-\\lambda I)=0\\,\\}', 'Definition des reellen Spektrums', 'definition', 'literature', 64, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(265, '3.265', 23, 'Rotationsmatrix', 'R=\\begin{pmatrix}0&-1\\\\1&0 \\end{pmatrix}', 'R=\\begin{pmatrix}0&-1\\\\1&0 \\end{pmatrix}', 'Reelle Rotationsmatrix', '', 'literature', 64, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(266, '3.266', 23, 'Charakteristisches Polynom der Rotation', '\\det(R-\\lambda I)=\\lambda^2+1', '\\det(R-\\lambda I)=\\lambda^2+1', 'Polynom der Rotationsmatrix', '', 'literature', 64, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(267, '3.267', 23, 'Charakteristische Gleichung der Rotation', '\\lambda^2+1=0', '\\lambda^2+1=0', 'Eigenwertgleichung der Rotation', '', 'literature', 64, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(268, '3.268', 23, 'Komplexe Eigenwerte der Rotation', '\\lambda_1=i\\qquad\\text{und}\\qquad\\lambda_2=-i', '\\lambda_1=i\\qquad\\text{und}\\qquad\\lambda_2=-i', 'Komplexe Eigenwerte', '', 'literature', 64, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(269, '3.269', 23, 'Liste der Eigenwerte', '\\lambda_1,\\ldots,\\lambda_n', '\\lambda_1,\\ldots,\\lambda_n', 'Eigenwertliste', 'definition', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(270, '3.270', 23, 'Determinante als Eigenwertprodukt', '\\det(A)=\\prod_{i=1}^{n}\\lambda_i', '\\det(A)=\\prod_{i=1}^{n}\\lambda_i', 'Produkt der Eigenwerte', 'theorem', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(271, '3.271', 23, 'Spur als Eigenwertsumme', '\\operatorname{spur}(A)=\\sum_{i=1}^{n}\\lambda_i', '\\operatorname{spur}(A)=\\sum_{i=1}^{n}\\lambda_i', 'Summe der Eigenwerte', 'theorem', 'literature', 59, 'In Abschnitt 3.2.10 eingeführt oder hergeleitet.', 'Lineare Operatoren, Determinanten, Kern und Basiswechsel sind definiert.', 'verified', 23),
(272, '3.272', 24, 'Orthogonalität', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(273, '3.273', 24, 'Skalarprodukt = 0', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(274, '3.274', 24, 'Normierter Vektor', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(275, '3.275', 24, 'Normbedingung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(276, '3.276', 24, 'Orthonormalsystem', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(277, '3.277', 24, 'Kronecker-Delta', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(278, '3.278', 24, 'Definition Kronecker-Delta', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(279, '3.279', 24, 'Aufspannbedingung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(280, '3.280', 24, 'Koordinatendarstellung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(281, '3.281', 24, 'Einheitsvektor', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(282, '3.282', 24, 'Projektionsoperator', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(283, '3.283', 24, 'Projektionsmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(284, '3.284', 24, 'Idempotenz', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(285, '3.285', 24, 'Symmetrie', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(286, '3.286', 24, 'Beispielvektor', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(287, '3.287', 24, 'Projektionsmatrix Beispiel', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(288, '3.288', 24, 'Beispielvektor v', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(289, '3.289', 24, 'Projizierter Vektor', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(290, '3.290', 24, 'Gram-Schmidt Ausgangsbasis', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(291, '3.291', 24, 'Gram-Schmidt Schritt', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(292, '3.292', 24, 'Normierung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(293, '3.293', 24, 'Orthogonale Matrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(294, '3.294', 24, 'Inverse = Transponierte', '', '', '', 'other', 'original', NULL, NULL, NULL, 'verified', 24),
(295, '3.295', 25, 'Allgemeine Matrix', 'A=(a_{ij})\\in\\mathbb{R}^{m\\times n}', 'A=(a_{ij})\\in\\mathbb{R}^{m\\times n}', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(296, '3.296', 25, 'Transponierte Matrix', 'A^{\\mathrm T}=(a_{ji})', 'A^{\\mathrm T}=(a_{ji})', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(297, '3.297', 25, 'Doppelte Transposition', '(A^{\\mathrm T})^{\\mathrm T}=A', '(A^{\\mathrm T})^{\\mathrm T}=A', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(298, '3.298', 25, 'Symmetriebedingung', 'A^{\\mathrm T}=A', 'A^{\\mathrm T}=A', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(299, '3.299', 25, 'Beispiel einer symmetrischen Matrix', 'A=\\begin{pmatrix}2&3\\\\3&5 \\end{pmatrix}', 'A=\\begin{pmatrix}2&3\\\\3&5 \\end{pmatrix}', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(300, '3.300', 25, 'Symmetrieprüfung', 'A^{\\mathrm T}=A', 'A^{\\mathrm T}=A', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(301, '3.301', 25, 'Schiefsymmetriebedingung', 'A^{\\mathrm T}=-A', 'A^{\\mathrm T}=-A', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(302, '3.302', 25, 'Diagonaleinträge schiefsymmetrischer Matrizen', 'a_{ii}=0\\qquad(i=1,\\ldots,n)', 'a_{ii}=0\\qquad(i=1,\\ldots,n)', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(303, '3.303', 25, 'Beispiel einer schiefsymmetrischen Matrix', 'A=\\begin{pmatrix}0&2\\\\-2&0 \\end{pmatrix}', 'A=\\begin{pmatrix}0&2\\\\-2&0 \\end{pmatrix}', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(304, '3.304', 25, 'Schiefsymmetrieprüfung', 'A^{\\mathrm T}=-A', 'A^{\\mathrm T}=-A', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(305, '3.305', 25, 'Positive Definitheit', 'x^{\\mathrm T}Ax>0\\qquad\\forall x\\neq0', 'x^{\\mathrm T}Ax>0\\qquad\\forall x\\neq0', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(306, '3.306', 25, 'Quadratische Form', 'x^{\\mathrm T}Ax', 'x^{\\mathrm T}Ax', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(307, '3.307', 25, 'Positiv definite Diagonalmatrix', 'A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}', 'A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(308, '3.308', 25, 'Allgemeiner zweidimensionaler Vektor', 'x=\\begin{pmatrix}x_1\\\\x_2 \\end{pmatrix}', 'x=\\begin{pmatrix}x_1\\\\x_2 \\end{pmatrix}', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(309, '3.309', 25, 'Quadratische Form des Beispiels', 'x^{\\mathrm T}Ax=2x_1^2+3x_2^2', 'x^{\\mathrm T}Ax=2x_1^2+3x_2^2', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(310, '3.310', 25, 'Positivitätsnachweis', 'x^{\\mathrm T}Ax>0\\qquad(x\\neq0)', 'x^{\\mathrm T}Ax>0\\qquad(x\\neq0)', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(311, '3.311', 25, 'Positive Eigenwerte', '\\lambda_i>0\\qquad(i=1,\\ldots,n)', '\\lambda_i>0\\qquad(i=1,\\ldots,n)', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(312, '3.312', 25, 'Orthogonale Diagonalisierungsmatrix', 'Q', 'Q', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(313, '3.313', 25, 'Orthogonale Diagonalisierung', 'Q^{\\mathrm T}AQ=D', 'Q^{\\mathrm T}AQ=D', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(314, '3.314', 25, 'Diagonalmatrix der Eigenwerte', 'D=\\operatorname{diag}(\\lambda_1,\\ldots,\\lambda_n)', 'D=\\operatorname{diag}(\\lambda_1,\\ldots,\\lambda_n)', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(315, '3.315', 25, 'Quadratische Form als Funktion', 'q(x)=x^{\\mathrm T}Ax', 'q(x)=x^{\\mathrm T}Ax', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(316, '3.316', 25, 'Quadratische Zielfunktion', 'f(x)=\\frac12x^{\\mathrm T}Ax-b^{\\mathrm T}x', 'f(x)=\\frac12x^{\\mathrm T}Ax-b^{\\mathrm T}x', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(317, '3.317', 25, 'Gradientenbedingung', '\\nabla f(x)=Ax-b=0', '\\nabla f(x)=Ax-b=0', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(318, '3.318', 25, 'Lineares Gleichungssystem', 'Ax=b', 'Ax=b', 'Gleichung aus Abschnitt 3.2.12.', 'derived', 'literature', 59, 'Definition, Herleitung oder Beispielprüfung in Abschnitt 3.2.12.', 'Matrizenrechnung, Transposition, Skalarprodukte, Eigenwerte und lineare Gleichungssysteme sind definiert.', 'verified', 25),
(319, '3.319', 26, 'Diagonalisierbare Matrix', 'A\\in\\mathbb{R}^{n\\times n}', 'A\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.319 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(320, '3.320', 26, 'Definition der Diagonalisierung', 'P\\in\\mathbb{R}^{n\\times n}', 'P\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.320 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(321, '3.321', 26, 'Äquivalente Darstellung', 'D\\in\\mathbb{R}^{n\\times n}', 'D\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.321 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(322, '3.322', 26, 'Transformationsmatrix', 'P^{-1}AP=D', 'P^{-1}AP=D', 'Formale Gleichung 3.322 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(323, '3.323', 26, 'Eigenvektoren', 'A=PDP^{-1}', 'A=PDP^{-1}', 'Formale Gleichung 3.323 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(324, '3.324', 26, 'Matrix P', 'v_1,\\ldots,v_n', 'v_1,\\ldots,v_n', 'Formale Gleichung 3.324 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(325, '3.325', 26, 'Diagonalmatrix', 'P=\\begin{pmatrix}|&|&&|\\\\v_1&v_2&\\cdots&v_n\\\\|&|&&| \\end{pmatrix}', 'P=\\begin{pmatrix}|&|&&|\\\\v_1&v_2&\\cdots&v_n\\\\|&|&&| \\end{pmatrix}', 'Formale Gleichung 3.325 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(326, '3.326', 26, 'Eigenwertgleichung', 'D=\\begin{pmatrix}\\lambda_1&0&\\cdots&0\\\\0&\\lambda_2&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&\\lambda_n \\end{pmatrix}', 'D=\\begin{pmatrix}\\lambda_1&0&\\cdots&0\\\\0&\\lambda_2&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&\\lambda_n \\end{pmatrix}', 'Formale Gleichung 3.326 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(327, '3.327', 26, 'Matrixdarstellung', 'Av_i=\\lambda_i v_i', 'Av_i=\\lambda_i v_i', 'Formale Gleichung 3.327 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(328, '3.328', 26, 'Diagonalisierung', 'AP=PD', 'AP=PD', 'Formale Gleichung 3.328 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(329, '3.329', 26, 'Quadratische Matrix', 'P^{-1}AP=D', 'P^{-1}AP=D', 'Formale Gleichung 3.329 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(330, '3.330', 26, 'Diagonalisierungskriterium', 'A\\in\\mathbb{R}^{n\\times n}', 'A\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.330 aus Abschnitt 3.2.13.', 'theorem', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(331, '3.331', 26, 'Eigenraum', 'A\\text{ ist diagonalisierbar}\\Longleftrightarrow\\mathbb{R}^n\\text{ besitzt eine Eigenvektorbasis von }A', 'A\\text{ ist diagonalisierbar}\\Longleftrightarrow\\mathbb{R}^n\\text{ besitzt eine Eigenvektorbasis von }A', 'Formale Gleichung 3.331 aus Abschnitt 3.2.13.', 'theorem', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(332, '3.332', 26, 'Eigenwert', 'E_\\lambda=\\ker(A-\\lambda I)', 'E_\\lambda=\\ker(A-\\lambda I)', 'Formale Gleichung 3.332 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(333, '3.333', 26, 'Anzahl Eigenwerte', '\\lambda_1,\\ldots,\\lambda_k', '\\lambda_1,\\ldots,\\lambda_k', 'Formale Gleichung 3.333 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(334, '3.334', 26, 'Verschiedene Eigenwerte', '\\dim(E_{\\lambda_1})+\\cdots+\\dim(E_{\\lambda_k})=n', '\\dim(E_{\\lambda_1})+\\cdots+\\dim(E_{\\lambda_k})=n', 'Formale Gleichung 3.334 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(335, '3.335', 26, 'Hinreichende Bedingung', 'A\\text{ besitzt }n\\text{ paarweise verschiedene Eigenwerte}\\Longrightarrow A\\text{ ist diagonalisierbar}', 'A\\text{ besitzt }n\\text{ paarweise verschiedene Eigenwerte}\\Longrightarrow A\\text{ ist diagonalisierbar}', 'Formale Gleichung 3.335 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(336, '3.336', 26, 'Algebraische Vielfachheit', 'p_A(\\lambda)=\\det(A-\\lambda I)', 'p_A(\\lambda)=\\det(A-\\lambda I)', 'Formale Gleichung 3.336 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(337, '3.337', 26, 'Charakteristisches Polynom', 'p_A(\\lambda)=(\\lambda-\\lambda_0)^m q(\\lambda)', 'p_A(\\lambda)=(\\lambda-\\lambda_0)^m q(\\lambda)', 'Formale Gleichung 3.337 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(338, '3.338', 26, 'Beispiel Polynom', 'q(\\lambda_0)\\neq0', 'q(\\lambda_0)\\neq0', 'Formale Gleichung 3.338 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(339, '3.339', 26, 'Eigenwert', 'm_{\\mathrm{alg}}(\\lambda_0)=m', 'm_{\\mathrm{alg}}(\\lambda_0)=m', 'Formale Gleichung 3.339 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(340, '3.340', 26, 'Algebraische Vielfachheit', '\\sum_{\\lambda\\in\\sigma(A)}m_{\\mathrm{alg}}(\\lambda)=n', '\\sum_{\\lambda\\in\\sigma(A)}m_{\\mathrm{alg}}(\\lambda)=n', 'Formale Gleichung 3.340 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(341, '3.341', 26, 'Geometrische Vielfachheit', 'm_{\\mathrm{geo}}(\\lambda)=\\dim(E_\\lambda)', 'm_{\\mathrm{geo}}(\\lambda)=\\dim(E_\\lambda)', 'Formale Gleichung 3.341 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(342, '3.342', 26, 'Eigenraumgleichung', 'E_\\lambda=\\ker(A-\\lambda I)', 'E_\\lambda=\\ker(A-\\lambda I)', 'Formale Gleichung 3.342 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(343, '3.343', 26, 'Ungleichung', 'm_{\\mathrm{geo}}(\\lambda)=\\dim\\ker(A-\\lambda I)', 'm_{\\mathrm{geo}}(\\lambda)=\\dim\\ker(A-\\lambda I)', 'Formale Gleichung 3.343 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(344, '3.344', 26, 'Kriterium', '1\\le m_{\\mathrm{geo}}(\\lambda)\\le m_{\\mathrm{alg}}(\\lambda)', '1\\le m_{\\mathrm{geo}}(\\lambda)\\le m_{\\mathrm{alg}}(\\lambda)', 'Formale Gleichung 3.344 aus Abschnitt 3.2.13.', 'definition', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(345, '3.345', 26, 'Transformationsmatrix', 'm_{\\mathrm{geo}}(\\lambda)=m_{\\mathrm{alg}}(\\lambda)', 'm_{\\mathrm{geo}}(\\lambda)=m_{\\mathrm{alg}}(\\lambda)', 'Formale Gleichung 3.345 aus Abschnitt 3.2.13.', 'theorem', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(346, '3.346', 26, 'Diagonalisierung', '\\sum_{\\lambda\\in\\sigma(A)}m_{\\mathrm{geo}}(\\lambda)=n', '\\sum_{\\lambda\\in\\sigma(A)}m_{\\mathrm{geo}}(\\lambda)=n', 'Formale Gleichung 3.346 aus Abschnitt 3.2.13.', 'theorem', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(347, '3.347', 26, 'Nicht diagonalisierbar', 'm_{\\mathrm{geo}}(\\lambda)<m_{\\mathrm{alg}}(\\lambda)', 'm_{\\mathrm{geo}}(\\lambda)<m_{\\mathrm{alg}}(\\lambda)', 'Formale Gleichung 3.347 aus Abschnitt 3.2.13.', 'theorem', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(348, '3.348', 26, 'Beispiel Matrix', 'A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}', 'A=\\begin{pmatrix}2&0\\\\0&3 \\end{pmatrix}', 'Formale Gleichung 3.348 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(349, '3.349', 26, 'Eigenwerte', '\\lambda_1=2,\\qquad\\lambda_2=3', '\\lambda_1=2,\\qquad\\lambda_2=3', 'Formale Gleichung 3.349 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(350, '3.350', 26, 'Einheitsmatrix', 'v_1=\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\qquad v_2=\\begin{pmatrix}0\\\\1 \\end{pmatrix}', 'v_1=\\begin{pmatrix}1\\\\0 \\end{pmatrix},\\qquad v_2=\\begin{pmatrix}0\\\\1 \\end{pmatrix}', 'Formale Gleichung 3.350 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(351, '3.351', 26, 'Identität', 'P=\\begin{pmatrix}1&0\\\\0&1 \\end{pmatrix}=I', 'P=\\begin{pmatrix}1&0\\\\0&1 \\end{pmatrix}=I', 'Formale Gleichung 3.351 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(352, '3.352', 26, 'Jordan-Beispiel', 'P^{-1}AP=A', 'P^{-1}AP=A', 'Formale Gleichung 3.352 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(353, '3.353', 26, 'Charakteristisches Polynom', 'A=\\begin{pmatrix}1&1\\\\0&1 \\end{pmatrix}', 'A=\\begin{pmatrix}1&1\\\\0&1 \\end{pmatrix}', 'Formale Gleichung 3.353 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(354, '3.354', 26, 'Eigenwert', 'p_A(\\lambda)=\\det\\begin{matrix}1-\\lambda&1\\\\0&1-\\lambda \\end{matrix}=(1-\\lambda)^2', 'p_A(\\lambda)=\\det\\begin{matrix}1-\\lambda&1\\\\0&1-\\lambda \\end{matrix}=(1-\\lambda)^2', 'Formale Gleichung 3.354 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(355, '3.355', 26, 'Algebraische Vielfachheit', '\\lambda=1', '\\lambda=1', 'Formale Gleichung 3.355 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(356, '3.356', 26, 'Eigenraum', 'm_{\\mathrm{alg}}(1)=2', 'm_{\\mathrm{alg}}(1)=2', 'Formale Gleichung 3.356 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(357, '3.357', 26, 'Matrix A-I', 'A-I=\\begin{pmatrix}0&1\\\\0&0 \\end{pmatrix}', 'A-I=\\begin{pmatrix}0&1\\\\0&0 \\end{pmatrix}', 'Formale Gleichung 3.357 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(358, '3.358', 26, 'Lösung', '(A-I)v=0', '(A-I)v=0', 'Formale Gleichung 3.358 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(359, '3.359', 26, 'Dimension', 'v=\\begin{pmatrix}v_1\\\\v_2 \\end{pmatrix}', 'v=\\begin{pmatrix}v_1\\\\v_2 \\end{pmatrix}', 'Formale Gleichung 3.359 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(360, '3.360', 26, 'Vergleich', 'v_2=0', 'v_2=0', 'Formale Gleichung 3.360 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(361, '3.361', 26, 'Matrixpotenz', 'E_1=\\operatorname{span}\\left\\{\\begin{pmatrix}1\\\\0 \\end{pmatrix}\\right\\}', 'E_1=\\operatorname{span}\\left\\{\\begin{pmatrix}1\\\\0 \\end{pmatrix}\\right\\}', 'Formale Gleichung 3.361 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(362, '3.362', 26, 'Quadrat', 'm_{\\mathrm{geo}}(1)=1', 'm_{\\mathrm{geo}}(1)=1', 'Formale Gleichung 3.362 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(363, '3.363', 26, 'Inverse', 'm_{\\mathrm{geo}}(1)=1<2=m_{\\mathrm{alg}}(1)', 'm_{\\mathrm{geo}}(1)=1<2=m_{\\mathrm{alg}}(1)', 'Formale Gleichung 3.363 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(364, '3.364', 26, 'Vereinfachung', 'A=PDP^{-1}', 'A=PDP^{-1}', 'Formale Gleichung 3.364 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(365, '3.365', 26, 'Allgemeine Potenz', 'A^2=(PDP^{-1})(PDP^{-1})', 'A^2=(PDP^{-1})(PDP^{-1})', 'Formale Gleichung 3.365 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(366, '3.366', 26, 'Diagonalmatrix', 'P^{-1}P=I', 'P^{-1}P=I', 'Formale Gleichung 3.366 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(367, '3.367', 26, 'Potenz der Diagonalmatrix', 'A^2=PD^2P^{-1}', 'A^2=PD^2P^{-1}', 'Formale Gleichung 3.367 aus Abschnitt 3.2.13.', 'derived', 'adapted', 59, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(368, '3.368', 26, 'Matrixfunktion', 'A^k=PD^kP^{-1}', 'A^k=PD^kP^{-1}', 'Formale Gleichung 3.368 aus Abschnitt 3.2.13.', 'derived', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(369, '3.369', 26, 'Funktion', 'D=\\begin{pmatrix}\\lambda_1&0&\\cdots&0\\\\0&\\lambda_2&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&\\lambda_n \\end{pmatrix}', 'D=\\begin{pmatrix}\\lambda_1&0&\\cdots&0\\\\0&\\lambda_2&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&\\lambda_n \\end{pmatrix}', 'Formale Gleichung 3.369 aus Abschnitt 3.2.13.', 'derived', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(370, '3.370', 26, 'Definition Matrixfunktion', 'D^k=\\begin{pmatrix}\\lambda_1^k&0&\\cdots&0\\\\0&\\lambda_2^k&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&\\lambda_n^k \\end{pmatrix}', 'D^k=\\begin{pmatrix}\\lambda_1^k&0&\\cdots&0\\\\0&\\lambda_2^k&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&\\lambda_n^k \\end{pmatrix}', 'Formale Gleichung 3.370 aus Abschnitt 3.2.13.', 'derived', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(371, '3.371', 26, 'Funktion der Diagonalmatrix', 'A=PDP^{-1}', 'A=PDP^{-1}', 'Formale Gleichung 3.371 aus Abschnitt 3.2.13.', 'derived', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(372, '3.372', 26, 'Matrixexponentialfunktion', 'f(A)=Pf(D)P^{-1}', 'f(A)=Pf(D)P^{-1}', 'Formale Gleichung 3.372 aus Abschnitt 3.2.13.', 'derived', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(373, '3.373', 26, 'Exponentialfunktion', 'f(D)=\\begin{pmatrix}f(\\lambda_1)&0&\\cdots&0\\\\0&f(\\lambda_2)&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&f(\\lambda_n) \\end{pmatrix}', 'f(D)=\\begin{pmatrix}f(\\lambda_1)&0&\\cdots&0\\\\0&f(\\lambda_2)&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&f(\\lambda_n) \\end{pmatrix}', 'Formale Gleichung 3.373 aus Abschnitt 3.2.13.', 'derived', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(374, '3.374', 26, 'Exponentialfunktion Diagonalmatrix', 'e^A=\\sum_{k=0}^{\\infty}\\frac{A^k}{k!}', 'e^A=\\sum_{k=0}^{\\infty}\\frac{A^k}{k!}', 'Formale Gleichung 3.374 aus Abschnitt 3.2.13.', 'derived', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(375, '3.375', 26, 'Orthogonale Matrix', 'e^A=Pe^DP^{-1}', 'e^A=Pe^DP^{-1}', 'Formale Gleichung 3.375 aus Abschnitt 3.2.13.', 'derived', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(376, '3.376', 26, 'Inverse', 'e^D=\\begin{pmatrix}e^{\\lambda_1}&0&\\cdots&0\\\\0&e^{\\lambda_2}&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&e^{\\lambda_n} \\end{pmatrix}', 'e^D=\\begin{pmatrix}e^{\\lambda_1}&0&\\cdots&0\\\\0&e^{\\lambda_2}&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&e^{\\lambda_n} \\end{pmatrix}', 'Formale Gleichung 3.376 aus Abschnitt 3.2.13.', 'derived', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(377, '3.377', 26, 'Spektralsatz', 'A\\in\\mathbb{R}^{n\\times n}', 'A\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.377 aus Abschnitt 3.2.13.', 'theorem', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(378, '3.378', 26, 'Eigenvektoren', 'A^{\\mathsf T}=A', 'A^{\\mathsf T}=A', 'Formale Gleichung 3.378 aus Abschnitt 3.2.13.', 'theorem', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(379, '3.379', 26, 'Spektralzerlegung', 'Q^{-1}=Q^{\\mathsf T}', 'Q^{-1}=Q^{\\mathsf T}', 'Formale Gleichung 3.379 aus Abschnitt 3.2.13.', 'theorem', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(380, '3.380', 26, 'Projektionsoperator', 'Q^{\\mathsf T}AQ=D', 'Q^{\\mathsf T}AQ=D', 'Formale Gleichung 3.380 aus Abschnitt 3.2.13.', 'theorem', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(381, '3.381', 26, 'Darstellung als Projektionssumme', 'A=QDQ^{\\mathsf T}', 'A=QDQ^{\\mathsf T}', 'Formale Gleichung 3.381 aus Abschnitt 3.2.13.', 'theorem', 'adapted', 64, 'Im Abschnitt 3.2.13 hergeleitet oder als etablierte Standardbeziehung der linearen Algebra verwendet.', 'Endlichdimensionaler reeller Vektorraum und die jeweils angegebenen Voraussetzungen.', 'verified', 29),
(382, '3.382', 27, 'Ausgangsmatrix', 'A\\in\\mathbb{R}^{m\\times n}', 'A\\in\\mathbb{R}^{m\\times n}', 'Formale Gleichung 3.382 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(383, '3.383', 27, 'Produktzerlegung', 'A=A_1A_2\\cdots A_k', 'A=A_1A_2\\cdots A_k', 'Formale Gleichung 3.383 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(384, '3.384', 27, 'Summenzerlegung', 'A=A_1+A_2+\\cdots+A_k', 'A=A_1+A_2+\\cdots+A_k', 'Formale Gleichung 3.384 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(385, '3.385', 27, 'Struktureigenschaften', '\\text{Dreiecksform},\\qquad\\text{Orthogonalität},\\qquad\\text{Diagonalform}', '\\text{Dreiecksform},\\qquad\\text{Orthogonalität},\\qquad\\text{Diagonalform}', 'Formale Gleichung 3.385 aus Abschnitt 3.2.14.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(386, '3.386', 27, 'Positive Definitheit', '\\text{positive Definitheit}', '\\text{positive Definitheit}', 'Formale Gleichung 3.386 aus Abschnitt 3.2.14.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(387, '3.387', 27, 'Quadratische Matrix', 'A\\in\\mathbb{R}^{n\\times n}', 'A\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.387 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(388, '3.388', 27, 'LU-Zerlegung', 'A=LU', 'A=LU', 'Formale Gleichung 3.388 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(389, '3.389', 27, 'Untere Dreiecksmatrix', 'L=\\begin{pmatrix}l_{11}&0&\\cdots&0\\\\l_{21}&l_{22}&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\l_{n1}&l_{n2}&\\cdots&l_{nn} \\end{pmatrix}', 'L=\\begin{pmatrix}l_{11}&0&\\cdots&0\\\\l_{21}&l_{22}&\\cdots&0\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\l_{n1}&l_{n2}&\\cdots&l_{nn} \\end{pmatrix}', 'Formale Gleichung 3.389 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(390, '3.390', 27, 'Obere Dreiecksmatrix', 'U=\\begin{pmatrix}u_{11}&u_{12}&\\cdots&u_{1n}\\\\0&u_{22}&\\cdots&u_{2n}\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&u_{nn} \\end{pmatrix}', 'U=\\begin{pmatrix}u_{11}&u_{12}&\\cdots&u_{1n}\\\\0&u_{22}&\\cdots&u_{2n}\\\\\\vdots&\\vdots&\\ddots&\\vdots\\\\0&0&\\cdots&u_{nn} \\end{pmatrix}', 'Formale Gleichung 3.390 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(391, '3.391', 27, 'Doolittle-Normierung', 'l_{ii}=1\\qquad(i=1,\\ldots,n)', 'l_{ii}=1\\qquad(i=1,\\ldots,n)', 'Formale Gleichung 3.391 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(392, '3.392', 27, 'LU-Zerlegung mit Permutation', 'PA=LU', 'PA=LU', 'Formale Gleichung 3.392 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(393, '3.393', 27, 'Rücktransformation der LU-Zerlegung', 'A=P^{-1}LU', 'A=P^{-1}LU', 'Formale Gleichung 3.393 aus Abschnitt 3.2.14.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(394, '3.394', 27, 'Inverse einer Permutationsmatrix', 'P^{-1}=P^{\\mathsf T}', 'P^{-1}=P^{\\mathsf T}', 'Formale Gleichung 3.394 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(395, '3.395', 27, 'LU-Zerlegung mit transponierter Permutation', 'A=P^{\\mathsf T}LU', 'A=P^{\\mathsf T}LU', 'Formale Gleichung 3.395 aus Abschnitt 3.2.14.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(396, '3.396', 27, 'Lineares Gleichungssystem', 'Ax=b', 'Ax=b', 'Formale Gleichung 3.396 aus Abschnitt 3.2.14.', 'other', 'adapted', 62, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(397, '3.397', 27, 'Eingesetzte LU-Zerlegung', 'A=LU', 'A=LU', 'Formale Gleichung 3.397 aus Abschnitt 3.2.14.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(398, '3.398', 27, 'Zerlegtes Gleichungssystem', 'LUx=b', 'LUx=b', 'Formale Gleichung 3.398 aus Abschnitt 3.2.14.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(399, '3.399', 27, 'Hilfsvariable', 'y=Ux', 'y=Ux', 'Formale Gleichung 3.399 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(400, '3.400', 27, 'Unteres Dreieckssystem', 'Ly=b', 'Ly=b', 'Formale Gleichung 3.400 aus Abschnitt 3.2.14.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(401, '3.401', 27, 'Oberes Dreieckssystem', 'Ux=y', 'Ux=y', 'Formale Gleichung 3.401 aus Abschnitt 3.2.14.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(402, '3.402', 27, 'Mehrere rechte Seiten', 'Ax^{(j)}=b^{(j)}', 'Ax^{(j)}=b^{(j)}', 'Formale Gleichung 3.402 aus Abschnitt 3.2.14.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(403, '3.403', 27, 'Rechteckige Ausgangsmatrix der QR-Zerlegung', 'A\\in\\mathbb{R}^{m\\times n}\\qquad\\text{mit}\\qquad m\\ge n', 'A\\in\\mathbb{R}^{m\\times n}\\qquad\\text{mit}\\qquad m\\ge n', 'Formale Gleichung 3.403 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(404, '3.404', 27, 'QR-Zerlegung', 'A=QR', 'A=QR', 'Formale Gleichung 3.404 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(405, '3.405', 27, 'Orthogonaler Faktor', 'Q\\in\\mathbb{R}^{m\\times n}', 'Q\\in\\mathbb{R}^{m\\times n}', 'Formale Gleichung 3.405 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(406, '3.406', 27, 'Oberer Dreiecksfaktor', 'R\\in\\mathbb{R}^{n\\times n}', 'R\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.406 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(407, '3.407', 27, 'Spaltenorthogonalität', 'Q^{\\mathsf T}Q=I_n', 'Q^{\\mathsf T}Q=I_n', 'Formale Gleichung 3.407 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(408, '3.408', 27, 'Vollständige Orthogonalität', 'QQ^{\\mathsf T}=I_n', 'QQ^{\\mathsf T}=I_n', 'Formale Gleichung 3.408 aus Abschnitt 3.2.14.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(409, '3.409', 27, 'Inverse der orthogonalen Matrix', 'Q^{-1}=Q^{\\mathsf T}', 'Q^{-1}=Q^{\\mathsf T}', 'Formale Gleichung 3.409 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(410, '3.410', 27, 'Überbestimmtes Gleichungssystem', 'Ax\\approx b', 'Ax\\approx b', 'Formale Gleichung 3.410 aus Abschnitt 3.2.14.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(411, '3.411', 27, 'Euklidische Fehlernorm', '\\|Ax-b\\|_2', '\\|Ax-b\\|_2', 'Formale Gleichung 3.411 aus Abschnitt 3.2.14.', 'metric', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(412, '3.412', 27, 'QR-Zerlegung im Ausgleichsproblem', 'A=QR', 'A=QR', 'Formale Gleichung 3.412 aus Abschnitt 3.2.14.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(413, '3.413', 27, 'Fehlernorm nach Einsetzen', '\\|Ax-b\\|_2=\\|QRx-b\\|_2', '\\|Ax-b\\|_2=\\|QRx-b\\|_2', 'Formale Gleichung 3.413 aus Abschnitt 3.2.14.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(414, '3.414', 27, 'Norminvarianz unter orthogonaler Transformation', '\\|QRx-b\\|_2=\\|Rx-Q^{\\mathsf T}b\\|_2', '\\|QRx-b\\|_2=\\|Rx-Q^{\\mathsf T}b\\|_2', 'Formale Gleichung 3.414 aus Abschnitt 3.2.14.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(415, '3.415', 27, 'Quadratische Matrix der Cholesky-Zerlegung', 'A\\in\\mathbb{R}^{n\\times n}', 'A\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.415 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(416, '3.416', 27, 'Symmetriebedingung', 'A^{\\mathsf T}=A', 'A^{\\mathsf T}=A', 'Formale Gleichung 3.416 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(417, '3.417', 27, 'Positive Definitheit', 'x^{\\mathsf T}Ax>0\\qquad\\text{für alle }x\\in\\mathbb{R}^n\\setminus\\{0\\}', 'x^{\\mathsf T}Ax>0\\qquad\\text{für alle }x\\in\\mathbb{R}^n\\setminus\\{0\\}', 'Formale Gleichung 3.417 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(418, '3.418', 27, 'Cholesky-Zerlegung', 'A=LL^{\\mathsf T}', 'A=LL^{\\mathsf T}', 'Formale Gleichung 3.418 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(419, '3.419', 27, 'Obere Cholesky-Form', 'A=R^{\\mathsf T}R', 'A=R^{\\mathsf T}R', 'Formale Gleichung 3.419 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(420, '3.420', 27, 'Beziehung der Dreiecksfaktoren', 'R=L^{\\mathsf T}', 'R=L^{\\mathsf T}', 'Formale Gleichung 3.420 aus Abschnitt 3.2.14.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(421, '3.421', 27, 'Beliebige reelle Matrix', 'A\\in\\mathbb{R}^{m\\times n}', 'A\\in\\mathbb{R}^{m\\times n}', 'Formale Gleichung 3.421 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(422, '3.422', 27, 'Linke orthogonale Matrix', 'U\\in\\mathbb{R}^{m\\times m}', 'U\\in\\mathbb{R}^{m\\times m}', 'Formale Gleichung 3.422 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(423, '3.423', 27, 'Rechte orthogonale Matrix', 'V\\in\\mathbb{R}^{n\\times n}', 'V\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.423 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(424, '3.424', 27, 'Singulärwertmatrix', '\\Sigma\\in\\mathbb{R}^{m\\times n}', '\\Sigma\\in\\mathbb{R}^{m\\times n}', 'Formale Gleichung 3.424 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(425, '3.425', 27, 'Singulärwertzerlegung', 'A=U\\Sigma V^{\\mathsf T}', 'A=U\\Sigma V^{\\mathsf T}', 'Formale Gleichung 3.425 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(426, '3.426', 27, 'Orthogonalität von U', 'U^{\\mathsf T}U=I_m', 'U^{\\mathsf T}U=I_m', 'Formale Gleichung 3.426 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(427, '3.427', 27, 'Orthogonalität von V', 'V^{\\mathsf T}V=I_n', 'V^{\\mathsf T}V=I_n', 'Formale Gleichung 3.427 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(428, '3.428', 27, 'Geordnete Singulärwerte', '\\sigma_1\\ge\\sigma_2\\ge\\cdots\\ge\\sigma_r>0', '\\sigma_1\\ge\\sigma_2\\ge\\cdots\\ge\\sigma_r>0', 'Formale Gleichung 3.428 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(429, '3.429', 27, 'Rang der Matrix', 'r=\\operatorname{rang}(A)', 'r=\\operatorname{rang}(A)', 'Formale Gleichung 3.429 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(430, '3.430', 27, 'Singulärwerte als Quadratwurzeln', '\\sigma_i=\\sqrt{\\lambda_i\\left(A^{\\mathsf T}A\\right)}', '\\sigma_i=\\sqrt{\\lambda_i\\left(A^{\\mathsf T}A\\right)}', 'Formale Gleichung 3.430 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(431, '3.431', 27, 'Reduzierte Singulärwertzerlegung', 'A=U_r\\Sigma_rV_r^{\\mathsf T}', 'A=U_r\\Sigma_rV_r^{\\mathsf T}', 'Formale Gleichung 3.431 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(432, '3.432', 27, 'Rang-eins-Darstellung der Matrix', 'A=\\sum_{i=1}^{r}\\sigma_i u_i v_i^{\\mathsf T}', 'A=\\sum_{i=1}^{r}\\sigma_i u_i v_i^{\\mathsf T}', 'Formale Gleichung 3.432 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(433, '3.433', 27, 'Rang als Anzahl positiver Singulärwerte', '\\operatorname{rang}(A)=\\#\\{i\\mid\\sigma_i>0\\}', '\\operatorname{rang}(A)=\\#\\{i\\mid\\sigma_i>0\\}', 'Formale Gleichung 3.433 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(434, '3.434', 27, 'Bedingung für vollen Spaltenrang', '\\sigma_n>0', '\\sigma_n>0', 'Formale Gleichung 3.434 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(435, '3.435', 27, 'Bedingung der Rangreduktion', 'k<r', 'k<r', 'Formale Gleichung 3.435 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(436, '3.436', 27, 'Rang-k-Approximation', 'A_k=\\sum_{i=1}^{k}\\sigma_i u_i v_i^{\\mathsf T}', 'A_k=\\sum_{i=1}^{k}\\sigma_i u_i v_i^{\\mathsf T}', 'Formale Gleichung 3.436 aus Abschnitt 3.2.14.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(437, '3.437', 27, 'Fehler der Rang-k-Approximation in Spektralnorm', '\\|A-A_k\\|_2=\\sigma_{k+1}', '\\|A-A_k\\|_2=\\sigma_{k+1}', 'Formale Gleichung 3.437 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(438, '3.438', 27, 'Fehler der Rang-k-Approximation in Frobeniusnorm', '\\|A-A_k\\|_{\\mathrm F}=\\sqrt{\\sum_{i=k+1}^{r}\\sigma_i^2}', '\\|A-A_k\\|_{\\mathrm F}=\\sqrt{\\sum_{i=k+1}^{r}\\sigma_i^2}', 'Formale Gleichung 3.438 aus Abschnitt 3.2.14.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.14 hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle Matrizen und die jeweils im Abschnitt angegebenen Struktur- und Dimensionsvoraussetzungen.', 'verified', 30),
(468, '3.439', 29, 'Normabbildung', '\\|\\cdot\\|:V\\rightarrow\\mathbb{R}', '\\|\\cdot\\|:V\\rightarrow\\mathbb{R}', 'Formale Gleichung 3.439 aus Abschnitt 3.2.15.', 'definition', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(469, '3.440', 29, 'Nichtnegativität der Norm', '\\|x\\|\\geq 0', '\\|x\\|\\geq 0', 'Formale Gleichung 3.440 aus Abschnitt 3.2.15.', 'definition', 'adapted', 70, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(470, '3.441', 29, 'Definitheit der Norm', '\\|x\\|=0\\quad\\Longleftrightarrow\\quad x=0', '\\|x\\|=0\\quad\\Longleftrightarrow\\quad x=0', 'Formale Gleichung 3.441 aus Abschnitt 3.2.15.', 'definition', 'adapted', 70, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(471, '3.442', 29, 'Absolute Homogenität der Norm', '\\|\\alpha x\\|=|\\alpha|\\,\\|x\\|', '\\|\\alpha x\\|=|\\alpha|\\,\\|x\\|', 'Formale Gleichung 3.442 aus Abschnitt 3.2.15.', 'definition', 'adapted', 70, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(472, '3.443', 29, 'Dreiecksungleichung', '\\|x+y\\|\\leq\\|x\\|+\\|y\\|', '\\|x+y\\|\\leq\\|x\\|+\\|y\\|', 'Formale Gleichung 3.443 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 70, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(473, '3.444', 29, 'Allgemeiner Vektor in R hoch n', 'x=\\begin{pmatrix}x_1\\\\x_2\\\\\\vdots\\\\x_n \\end{pmatrix}\\in\\mathbb{R}^n', 'x=\\begin{pmatrix}x_1\\\\x_2\\\\\\vdots\\\\x_n \\end{pmatrix}\\in\\mathbb{R}^n', 'Formale Gleichung 3.444 aus Abschnitt 3.2.15.', 'definition', 'adapted', 62, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(474, '3.445', 29, 'Einsnorm eines Vektors', '\\|x\\|_1=\\sum_{i=1}^{n}|x_i|', '\\|x\\|_1=\\sum_{i=1}^{n}|x_i|', 'Formale Gleichung 3.445 aus Abschnitt 3.2.15.', 'definition', 'adapted', 62, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(475, '3.446', 29, 'Euklidische Norm', '\\|x\\|_2=\\sqrt{\\sum_{i=1}^{n}x_i^2}', '\\|x\\|_2=\\sqrt{\\sum_{i=1}^{n}x_i^2}', 'Formale Gleichung 3.446 aus Abschnitt 3.2.15.', 'definition', 'adapted', 62, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(476, '3.447', 29, 'Euklidische Norm über Skalarprodukt', '\\|x\\|_2=\\sqrt{x^{\\mathsf T}x}', '\\|x\\|_2=\\sqrt{x^{\\mathsf T}x}', 'Formale Gleichung 3.447 aus Abschnitt 3.2.15.', 'derived', 'adapted', 62, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(477, '3.448', 29, 'Maximumsnorm', '\\|x\\|_{\\infty}=\\max_{1\\leq i\\leq n}|x_i|', '\\|x\\|_{\\infty}=\\max_{1\\leq i\\leq n}|x_i|', 'Formale Gleichung 3.448 aus Abschnitt 3.2.15.', 'definition', 'adapted', 62, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(478, '3.449', 29, 'Allgemeine p-Norm', '\\|x\\|_p=\\left(\\sum_{i=1}^{n}|x_i|^p\\right)^{1/p}', '\\|x\\|_p=\\left(\\sum_{i=1}^{n}|x_i|^p\\right)^{1/p}', 'Formale Gleichung 3.449 aus Abschnitt 3.2.15.', 'definition', 'adapted', 70, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(479, '3.450', 29, 'Äquivalenz endlichdimensionaler Normen', 'c\\|x\\|_a\\leq\\|x\\|_b\\leq C\\|x\\|_a', 'c\\|x\\|_a\\leq\\|x\\|_b\\leq C\\|x\\|_a', 'Formale Gleichung 3.450 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 70, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(480, '3.451', 29, 'Matrix für induzierte Norm', 'A\\in\\mathbb{R}^{m\\times n}', 'A\\in\\mathbb{R}^{m\\times n}', 'Formale Gleichung 3.451 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(481, '3.452', 29, 'Induzierte Matrixnorm', '\\|A\\|=\\sup_{x\\neq 0}\\frac{\\|Ax\\|}{\\|x\\|}', '\\|A\\|=\\sup_{x\\neq 0}\\frac{\\|Ax\\|}{\\|x\\|}', 'Formale Gleichung 3.452 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(482, '3.453', 29, 'Induzierte Matrixnorm auf Einheitsvektoren', '\\|A\\|=\\sup_{\\|x\\|=1}\\|Ax\\|', '\\|A\\|=\\sup_{\\|x\\|=1}\\|Ax\\|', 'Formale Gleichung 3.453 aus Abschnitt 3.2.15.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(483, '3.454', 29, 'Grundlegende Operatorabschätzung', '\\|Ax\\|\\leq\\|A\\|\\,\\|x\\|', '\\|Ax\\|\\leq\\|A\\|\\,\\|x\\|', 'Formale Gleichung 3.454 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(484, '3.455', 29, 'Allgemeine Matrixeinträge', 'A=(a_{ij})\\in\\mathbb{R}^{m\\times n}', 'A=(a_{ij})\\in\\mathbb{R}^{m\\times n}', 'Formale Gleichung 3.455 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(485, '3.456', 29, 'Induzierte Einsnorm einer Matrix', '\\|A\\|_1=\\max_{1\\leq j\\leq n}\\sum_{i=1}^{m}|a_{ij}|', '\\|A\\|_1=\\max_{1\\leq j\\leq n}\\sum_{i=1}^{m}|a_{ij}|', 'Formale Gleichung 3.456 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(486, '3.457', 29, 'Induzierte Unendlichnorm einer Matrix', '\\|A\\|_{\\infty}=\\max_{1\\leq i\\leq m}\\sum_{j=1}^{n}|a_{ij}|', '\\|A\\|_{\\infty}=\\max_{1\\leq i\\leq m}\\sum_{j=1}^{n}|a_{ij}|', 'Formale Gleichung 3.457 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(487, '3.458', 29, 'Spektralnorm über Eigenwert', '\\|A\\|_2=\\sqrt{\\lambda_{\\max}\\left(A^{\\mathsf T}A\\right)}', '\\|A\\|_2=\\sqrt{\\lambda_{\\max}\\left(A^{\\mathsf T}A\\right)}', 'Formale Gleichung 3.458 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(488, '3.459', 29, 'Spektralnorm über größten Singulärwert', '\\|A\\|_2=\\sigma_{\\max}(A)=\\sigma_1', '\\|A\\|_2=\\sigma_{\\max}(A)=\\sigma_1', 'Formale Gleichung 3.459 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(489, '3.460', 29, 'Matrix für Frobeniusnorm', 'A=(a_{ij})\\in\\mathbb{R}^{m\\times n}', 'A=(a_{ij})\\in\\mathbb{R}^{m\\times n}', 'Formale Gleichung 3.460 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(490, '3.461', 29, 'Frobeniusnorm über Matrixeinträge', '\\|A\\|_{\\mathrm F}=\\sqrt{\\sum_{i=1}^{m}\\sum_{j=1}^{n}|a_{ij}|^2}', '\\|A\\|_{\\mathrm F}=\\sqrt{\\sum_{i=1}^{m}\\sum_{j=1}^{n}|a_{ij}|^2}', 'Formale Gleichung 3.461 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(491, '3.462', 29, 'Frobeniusnorm über Spur', '\\|A\\|_{\\mathrm F}=\\sqrt{\\operatorname{tr}\\left(A^{\\mathsf T}A\\right)}', '\\|A\\|_{\\mathrm F}=\\sqrt{\\operatorname{tr}\\left(A^{\\mathsf T}A\\right)}', 'Formale Gleichung 3.462 aus Abschnitt 3.2.15.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(492, '3.463', 29, 'Frobeniusnorm über Singulärwerte', '\\|A\\|_{\\mathrm F}=\\sqrt{\\sum_{i=1}^{r}\\sigma_i^2}', '\\|A\\|_{\\mathrm F}=\\sqrt{\\sum_{i=1}^{r}\\sigma_i^2}', 'Formale Gleichung 3.463 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(493, '3.464', 29, 'Submultiplikativität', '\\|AB\\|\\leq\\|A\\|\\,\\|B\\|', '\\|AB\\|\\leq\\|A\\|\\,\\|B\\|', 'Formale Gleichung 3.464 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(494, '3.465', 29, 'Erster Beweisschritt der Submultiplikativität', '\\|ABx\\|\\leq\\|A\\|\\,\\|Bx\\|', '\\|ABx\\|\\leq\\|A\\|\\,\\|Bx\\|', 'Formale Gleichung 3.465 aus Abschnitt 3.2.15.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(495, '3.466', 29, 'Zweiter Beweisschritt der Submultiplikativität', '\\|Bx\\|\\leq\\|B\\|\\,\\|x\\|', '\\|Bx\\|\\leq\\|B\\|\\,\\|x\\|', 'Formale Gleichung 3.466 aus Abschnitt 3.2.15.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(496, '3.467', 29, 'Kombinierte Abschätzung', '\\|ABx\\|\\leq\\|A\\|\\,\\|B\\|\\,\\|x\\|', '\\|ABx\\|\\leq\\|A\\|\\,\\|B\\|\\,\\|x\\|', 'Formale Gleichung 3.467 aus Abschnitt 3.2.15.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(497, '3.468', 29, 'Abschätzung auf dem Einheitsvektor', '\\|ABx\\|\\leq\\|A\\|\\,\\|B\\|', '\\|ABx\\|\\leq\\|A\\|\\,\\|B\\|', 'Formale Gleichung 3.468 aus Abschnitt 3.2.15.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(498, '3.469', 29, 'Schlussfolgerung der Submultiplikativität', '\\|AB\\|\\leq\\|A\\|\\,\\|B\\|', '\\|AB\\|\\leq\\|A\\|\\,\\|B\\|', 'Formale Gleichung 3.469 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(499, '3.470', 29, 'Absolute Abweichung', '\\Delta x=\\widetilde{x}-x', '\\Delta x=\\widetilde{x}-x', 'Formale Gleichung 3.470 aus Abschnitt 3.2.15.', 'definition', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(500, '3.471', 29, 'Norm der absoluten Abweichung', '\\|\\Delta x\\|=\\|\\widetilde{x}-x\\|', '\\|\\Delta x\\|=\\|\\widetilde{x}-x\\|', 'Formale Gleichung 3.471 aus Abschnitt 3.2.15.', 'definition', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(501, '3.472', 29, 'Relative Abweichung', '\\delta_x=\\frac{\\|\\widetilde{x}-x\\|}{\\|x\\|}', '\\delta_x=\\frac{\\|\\widetilde{x}-x\\|}{\\|x\\|}', 'Formale Gleichung 3.472 aus Abschnitt 3.2.15.', 'definition', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(502, '3.473', 29, 'Invertierbare Matrix zur Konditionszahl', 'A\\in\\mathbb{R}^{n\\times n}', 'A\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.473 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(503, '3.474', 29, 'Konditionszahl einer Matrix', '\\kappa(A)=\\|A\\|\\,\\|A^{-1}\\|', '\\kappa(A)=\\|A\\|\\,\\|A^{-1}\\|', 'Formale Gleichung 3.474 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(504, '3.475', 29, 'Konditionszahl in Spektralnorm', '\\kappa_2(A)=\\|A\\|_2\\|A^{-1}\\|_2', '\\kappa_2(A)=\\|A\\|_2\\|A^{-1}\\|_2', 'Formale Gleichung 3.475 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(505, '3.476', 29, 'Konditionszahl über Singulärwerte', '\\kappa_2(A)=\\frac{\\sigma_{\\max}(A)}{\\sigma_{\\min}(A)}', '\\kappa_2(A)=\\frac{\\sigma_{\\max}(A)}{\\sigma_{\\min}(A)}', 'Formale Gleichung 3.476 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(506, '3.477', 29, 'Untere Schranke der Konditionszahl', '\\kappa(A)\\geq 1', '\\kappa(A)\\geq 1', 'Formale Gleichung 3.477 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(507, '3.478', 29, 'Konditionszahl singulärer Matrizen', '\\kappa(A)=\\infty', '\\kappa(A)=\\infty', 'Formale Gleichung 3.478 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(508, '3.479', 29, 'Lineares Gleichungssystem zur Fehlerfortpflanzung', 'Ax=b', 'Ax=b', 'Formale Gleichung 3.479 aus Abschnitt 3.2.15.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(509, '3.480', 29, 'Gestörtes lineares Gleichungssystem', 'A(x+\\Delta x)=b+\\Delta b', 'A(x+\\Delta x)=b+\\Delta b', 'Formale Gleichung 3.480 aus Abschnitt 3.2.15.', 'definition', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(510, '3.481', 29, 'Ungestörtes lineares Gleichungssystem', 'Ax=b', 'Ax=b', 'Formale Gleichung 3.481 aus Abschnitt 3.2.15.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(511, '3.482', 29, 'Differenzgleichung der Störungen', 'A\\Delta x=\\Delta b', 'A\\Delta x=\\Delta b', 'Formale Gleichung 3.482 aus Abschnitt 3.2.15.', 'derived', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(512, '3.483', 29, 'Lösungsstörung', '\\Delta x=A^{-1}\\Delta b', '\\Delta x=A^{-1}\\Delta b', 'Formale Gleichung 3.483 aus Abschnitt 3.2.15.', 'derived', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(513, '3.484', 29, 'Normabschätzung der Lösungsstörung', '\\|\\Delta x\\|\\leq\\|A^{-1}\\|\\,\\|\\Delta b\\|', '\\|\\Delta x\\|\\leq\\|A^{-1}\\|\\,\\|\\Delta b\\|', 'Formale Gleichung 3.484 aus Abschnitt 3.2.15.', 'derived', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(514, '3.485', 29, 'Rechte Seite als Operatorwirkung', 'b=Ax', 'b=Ax', 'Formale Gleichung 3.485 aus Abschnitt 3.2.15.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(515, '3.486', 29, 'Normabschätzung der rechten Seite', '\\|b\\|\\leq\\|A\\|\\,\\|x\\|', '\\|b\\|\\leq\\|A\\|\\,\\|x\\|', 'Formale Gleichung 3.486 aus Abschnitt 3.2.15.', 'derived', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(516, '3.487', 29, 'Reziproke Lösungsabschätzung', '\\frac{1}{\\|x\\|}\\leq\\frac{\\|A\\|}{\\|b\\|}', '\\frac{1}{\\|x\\|}\\leq\\frac{\\|A\\|}{\\|b\\|}', 'Formale Gleichung 3.487 aus Abschnitt 3.2.15.', 'derived', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(517, '3.488', 29, 'Relative Fehlerabschätzung', '\\frac{\\|\\Delta x\\|}{\\|x\\|}\\leq\\kappa(A)\\frac{\\|\\Delta b\\|}{\\|b\\|}', '\\frac{\\|\\Delta x\\|}{\\|x\\|}\\leq\\kappa(A)\\frac{\\|\\Delta b\\|}{\\|b\\|}', 'Formale Gleichung 3.488 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(518, '3.489', 29, 'Konditionsmaß', '\\kappa(A)', '\\kappa(A)', 'Formale Gleichung 3.489 aus Abschnitt 3.2.15.', 'definition', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(519, '3.490', 29, 'Vorwärtsfehler', '\\frac{\\|\\widetilde{x}-x\\|}{\\|x\\|}\\ll 1', '\\frac{\\|\\widetilde{x}-x\\|}{\\|x\\|}\\ll 1', 'Formale Gleichung 3.490 aus Abschnitt 3.2.15.', 'definition', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(520, '3.491', 29, 'Rückwärtsstabiles gestörtes Problem', '(A+\\Delta A)\\widetilde{x}=b+\\Delta b', '(A+\\Delta A)\\widetilde{x}=b+\\Delta b', 'Formale Gleichung 3.491 aus Abschnitt 3.2.15.', 'definition', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(521, '3.492', 29, 'Relative Matrixstörung', '\\frac{\\|\\Delta A\\|}{\\|A\\|}', '\\frac{\\|\\Delta A\\|}{\\|A\\|}', 'Formale Gleichung 3.492 aus Abschnitt 3.2.15.', 'metric', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(522, '3.493', 29, 'Relative Störung der rechten Seite', '\\frac{\\|\\Delta b\\|}{\\|b\\|}', '\\frac{\\|\\Delta b\\|}{\\|b\\|}', 'Formale Gleichung 3.493 aus Abschnitt 3.2.15.', 'metric', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(523, '3.494', 29, 'Begriffliche Wirkung der Kondition', '\\text{Eingabestörung}\\longrightarrow\\text{Lösungsänderung}', '\\text{Eingabestörung}\\longrightarrow\\text{Lösungsänderung}', 'Formale Gleichung 3.494 aus Abschnitt 3.2.15.', 'other', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(524, '3.495', 29, 'Begriffliche Wirkung der Stabilität', '\\text{Rechenverfahren}\\longrightarrow\\text{zusätzlicher numerischer Fehler}', '\\text{Rechenverfahren}\\longrightarrow\\text{zusätzlicher numerischer Fehler}', 'Formale Gleichung 3.495 aus Abschnitt 3.2.15.', 'other', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(525, '3.496', 29, 'Begriffliche Gesamtfehlerzerlegung', '\\text{Gesamtfehler}=\\text{Problemempfindlichkeit}+\\text{Verfahrensfehler}', '\\text{Gesamtfehler}=\\text{Problemempfindlichkeit}+\\text{Verfahrensfehler}', 'Formale Gleichung 3.496 aus Abschnitt 3.2.15.', 'other', 'adapted', 74, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(526, '3.497', 29, 'Operatorenfolge', 'A_1,A_2,\\ldots,A_k', 'A_1,A_2,\\ldots,A_k', 'Formale Gleichung 3.497 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(527, '3.498', 29, 'Gesamtoperator einer Kaskade', 'T=A_kA_{k-1}\\cdots A_1', 'T=A_kA_{k-1}\\cdots A_1', 'Formale Gleichung 3.498 aus Abschnitt 3.2.15.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(528, '3.499', 29, 'Normabschätzung der Operatorenkaskade', '\\|T\\|\\leq\\|A_k\\|\\|A_{k-1}\\|\\cdots\\|A_1\\|', '\\|T\\|\\leq\\|A_k\\|\\|A_{k-1}\\|\\cdots\\|A_1\\|', 'Formale Gleichung 3.499 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(529, '3.500', 29, 'Wirkungsabschätzung der Operatorenkaskade', '\\|Tx\\|\\leq\\left(\\prod_{i=1}^{k}\\|A_i\\|\\right)\\|x\\|', '\\|Tx\\|\\leq\\left(\\prod_{i=1}^{k}\\|A_i\\|\\right)\\|x\\|', 'Formale Gleichung 3.500 aus Abschnitt 3.2.15.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(530, '3.501', 29, 'Mögliche Einzelverstärkung', '\\|A_i\\|>1', '\\|A_i\\|>1', 'Formale Gleichung 3.501 aus Abschnitt 3.2.15.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(531, '3.502', 29, 'Didaktischer Beispielvektor', 'x=\\begin{pmatrix}3\\\\-4 \\end{pmatrix}', 'x=\\begin{pmatrix}3\\\\-4 \\end{pmatrix}', 'Formale Gleichung 3.502 aus Abschnitt 3.2.15.', '', 'adapted', 62, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(532, '3.503', 29, 'Vergleich dreier Vektornormen', '\\|x\\|_1=7,\\qquad\\|x\\|_2=5,\\qquad\\|x\\|_{\\infty}=4', '\\|x\\|_1=7,\\qquad\\|x\\|_2=5,\\qquad\\|x\\|_{\\infty}=4', 'Formale Gleichung 3.503 aus Abschnitt 3.2.15.', '', 'adapted', 62, 'Im Abschnitt 3.2.15 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen beziehungsweise numerischen Algebra verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Voraussetzungen.', 'verified', 32),
(595, '3.504', 30, 'Allgemeine reelle Matrix', 'A\\in\\mathbb{R}^{m\\times n}', 'A\\in\\mathbb{R}^{m\\times n}', 'Formale Gleichung 3.504 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(596, '3.505', 30, 'Dimension der Pseudoinversen', 'A^{+}\\in\\mathbb{R}^{n\\times m}', 'A^{+}\\in\\mathbb{R}^{n\\times m}', 'Formale Gleichung 3.505 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(597, '3.506', 30, 'Erste Penrose-Bedingung', 'AA^{+}A=A', 'AA^{+}A=A', 'Formale Gleichung 3.506 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(598, '3.507', 30, 'Zweite Penrose-Bedingung', 'A^{+}AA^{+}=A^{+}', 'A^{+}AA^{+}=A^{+}', 'Formale Gleichung 3.507 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(599, '3.508', 30, 'Dritte Penrose-Bedingung', '\\left(AA^{+}\\right)^{\\mathsf T}=AA^{+}', '\\left(AA^{+}\\right)^{\\mathsf T}=AA^{+}', 'Formale Gleichung 3.508 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(600, '3.509', 30, 'Vierte Penrose-Bedingung', '\\left(A^{+}A\\right)^{\\mathsf T}=A^{+}A', '\\left(A^{+}A\\right)^{\\mathsf T}=A^{+}A', 'Formale Gleichung 3.509 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(601, '3.510', 30, 'Übereinstimmung mit gewöhnlicher Inversen', 'A^{+}=A^{-1}', 'A^{+}=A^{-1}', 'Formale Gleichung 3.510 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(602, '3.511', 30, 'Singulärwertzerlegung der Ausgangsmatrix', 'A=U\\Sigma V^{\\mathsf T}', 'A=U\\Sigma V^{\\mathsf T}', 'Formale Gleichung 3.511 aus Abschnitt 3.2.16.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(603, '3.512', 30, 'Pseudoinverse über die Singulärwertzerlegung', 'A^{+}=V\\Sigma^{+}U^{\\mathsf T}', 'A^{+}=V\\Sigma^{+}U^{\\mathsf T}', 'Formale Gleichung 3.512 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(604, '3.513', 30, 'Invertierung positiver Singulärwerte', '\\sigma_i\\longmapsto\\frac{1}{\\sigma_i}', '\\sigma_i\\longmapsto\\frac{1}{\\sigma_i}', 'Formale Gleichung 3.513 aus Abschnitt 3.2.16.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(605, '3.514', 30, 'Behandlung verschwindender Singulärwerte', '0\\longmapsto 0', '0\\longmapsto 0', 'Formale Gleichung 3.514 aus Abschnitt 3.2.16.', 'definition', 'adapted', 72, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(606, '3.515', 30, 'Reduzierte Darstellung der Pseudoinversen', 'A^{+}=\\sum_{i=1}^{r}\\frac{1}{\\sigma_i}v_i u_i^{\\mathsf T}', 'A^{+}=\\sum_{i=1}^{r}\\frac{1}{\\sigma_i}v_i u_i^{\\mathsf T}', 'Formale Gleichung 3.515 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(607, '3.516', 30, 'Verstärkungsfaktor kleiner Singulärwerte', '\\frac{1}{\\sigma_i}', '\\frac{1}{\\sigma_i}', 'Formale Gleichung 3.516 aus Abschnitt 3.2.16.', 'metric', 'adapted', 74, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(608, '3.517', 30, 'Lineares Gleichungssystem', 'Ax=b', 'Ax=b', 'Formale Gleichung 3.517 aus Abschnitt 3.2.16.', 'other', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(609, '3.518', 30, 'Dimensionen des Ausgleichsproblems', 'A\\in\\mathbb{R}^{m\\times n}\\qquad\\text{und}\\qquad b\\in\\mathbb{R}^{m}', 'A\\in\\mathbb{R}^{m\\times n}\\qquad\\text{und}\\qquad b\\in\\mathbb{R}^{m}', 'Formale Gleichung 3.518 aus Abschnitt 3.2.16.', 'definition', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(610, '3.519', 30, 'Definition der Ausgleichslösung', 'x_{\\mathrm{LS}}\\in\\operatorname*{arg\\,min}_{x\\in\\mathbb{R}^{n}}\\|Ax-b\\|_2', 'x_{\\mathrm{LS}}\\in\\operatorname*{arg\\,min}_{x\\in\\mathbb{R}^{n}}\\|Ax-b\\|_2', 'Formale Gleichung 3.519 aus Abschnitt 3.2.16.', 'definition', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(611, '3.520', 30, 'Residualvektor', 'r=b-Ax_{\\mathrm{LS}}', 'r=b-Ax_{\\mathrm{LS}}', 'Formale Gleichung 3.520 aus Abschnitt 3.2.16.', 'definition', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(612, '3.521', 30, 'Überbestimmte Näherungsgleichung', 'Ax\\approx b', 'Ax\\approx b', 'Formale Gleichung 3.521 aus Abschnitt 3.2.16.', 'other', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(613, '3.522', 30, 'Normalgleichungen', 'A^{\\mathsf T}Ax=A^{\\mathsf T}b', 'A^{\\mathsf T}Ax=A^{\\mathsf T}b', 'Formale Gleichung 3.522 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(614, '3.523', 30, 'Quadratische Residualfunktion', 'f(x)=\\|Ax-b\\|_2^2', 'f(x)=\\|Ax-b\\|_2^2', 'Formale Gleichung 3.523 aus Abschnitt 3.2.16.', 'definition', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(615, '3.524', 30, 'Residualfunktion als Skalarprodukt', '\\|Ax-b\\|_2^2=(Ax-b)^{\\mathsf T}(Ax-b)', '\\|Ax-b\\|_2^2=(Ax-b)^{\\mathsf T}(Ax-b)', 'Formale Gleichung 3.524 aus Abschnitt 3.2.16.', 'derived', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(616, '3.525', 30, 'Ausmultiplizierte Residualfunktion', 'f(x)=x^{\\mathsf T}A^{\\mathsf T}Ax-2x^{\\mathsf T}A^{\\mathsf T}b+b^{\\mathsf T}b', 'f(x)=x^{\\mathsf T}A^{\\mathsf T}Ax-2x^{\\mathsf T}A^{\\mathsf T}b+b^{\\mathsf T}b', 'Formale Gleichung 3.525 aus Abschnitt 3.2.16.', 'derived', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(617, '3.526', 30, 'Notwendige Optimalitätsbedingung', '\\nabla f(x)=0', '\\nabla f(x)=0', 'Formale Gleichung 3.526 aus Abschnitt 3.2.16.', 'derived', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(618, '3.527', 30, 'Gradientengleichung', '2A^{\\mathsf T}Ax-2A^{\\mathsf T}b=0', '2A^{\\mathsf T}Ax-2A^{\\mathsf T}b=0', 'Formale Gleichung 3.527 aus Abschnitt 3.2.16.', 'derived', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(619, '3.528', 30, 'Herleitung der Normalgleichung', 'A^{\\mathsf T}Ax=A^{\\mathsf T}b', 'A^{\\mathsf T}Ax=A^{\\mathsf T}b', 'Formale Gleichung 3.528 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(620, '3.529', 30, 'Orthogonalität des Residuals', 'A^{\\mathsf T}r=0', 'A^{\\mathsf T}r=0', 'Formale Gleichung 3.529 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(621, '3.530', 30, 'Residual orthogonal zum Bildraum', 'r\\perp\\operatorname{Bild}(A)', 'r\\perp\\operatorname{Bild}(A)', 'Formale Gleichung 3.530 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(622, '3.531', 30, 'Gram-Matrix des Ausgleichsproblems', 'A^{\\mathsf T}A', 'A^{\\mathsf T}A', 'Formale Gleichung 3.531 aus Abschnitt 3.2.16.', 'other', 'adapted', 72, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(623, '3.532', 30, 'Eindeutige Ausgleichslösung bei vollem Spaltenrang', 'x_{\\mathrm{LS}}=\\left(A^{\\mathsf T}A\\right)^{-1}A^{\\mathsf T}b', 'x_{\\mathrm{LS}}=\\left(A^{\\mathsf T}A\\right)^{-1}A^{\\mathsf T}b', 'Formale Gleichung 3.532 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(624, '3.533', 30, 'Pseudoinverse bei vollem Spaltenrang', 'A^{+}=\\left(A^{\\mathsf T}A\\right)^{-1}A^{\\mathsf T}', 'A^{+}=\\left(A^{\\mathsf T}A\\right)^{-1}A^{\\mathsf T}', 'Formale Gleichung 3.533 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 72, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(625, '3.534', 30, 'Ausgleichslösung über Pseudoinverse', 'x_{\\mathrm{LS}}=A^{+}b', 'x_{\\mathrm{LS}}=A^{+}b', 'Formale Gleichung 3.534 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(626, '3.535', 30, 'Unterbestimmtes oder nicht eindeutiges Gleichungssystem', 'Ax=b', 'Ax=b', 'Formale Gleichung 3.535 aus Abschnitt 3.2.16.', 'other', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(627, '3.536', 30, 'Exaktheitsbedingung der Mindestnormlösung', 'Ax_{\\min}=b', 'Ax_{\\min}=b', 'Formale Gleichung 3.536 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(628, '3.537', 30, 'Minimalitätsbedingung der Lösungsnorm', '\\|x_{\\min}\\|_2=\\min\\left\\{\\|x\\|_2\\mid Ax=b\\right\\}', '\\|x_{\\min}\\|_2=\\min\\left\\{\\|x\\|_2\\mid Ax=b\\right\\}', 'Formale Gleichung 3.537 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(629, '3.538', 30, 'Mindestnormlösung über Pseudoinverse', 'x_{\\min}=A^{+}b', 'x_{\\min}=A^{+}b', 'Formale Gleichung 3.538 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(630, '3.539', 30, 'Projektionsoperator auf den Spaltenraum', 'P_A=AA^{+}', 'P_A=AA^{+}', 'Formale Gleichung 3.539 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(631, '3.540', 30, 'Abbildung auf den Spaltenraum', 'P_A:\\mathbb{R}^{m}\\rightarrow\\operatorname{Bild}(A)', 'P_A:\\mathbb{R}^{m}\\rightarrow\\operatorname{Bild}(A)', 'Formale Gleichung 3.540 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(632, '3.541', 30, 'Projektion des Datenvektors', 'AA^{+}b', 'AA^{+}b', 'Formale Gleichung 3.541 aus Abschnitt 3.2.16.', 'derived', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(633, '3.542', 30, 'Projektionsoperator auf den Zeilenraum', 'P_{A^{\\mathsf T}}=A^{+}A', 'P_{A^{\\mathsf T}}=A^{+}A', 'Formale Gleichung 3.542 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(634, '3.543', 30, 'Zeilenraum der Matrix', '\\operatorname{Bild}(A^{\\mathsf T})', '\\operatorname{Bild}(A^{\\mathsf T})', 'Formale Gleichung 3.543 aus Abschnitt 3.2.16.', 'definition', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(635, '3.544', 30, 'Residual über den Projektionsoperator', 'r=\\left(I-AA^{+}\\right)b', 'r=\\left(I-AA^{+}\\right)b', 'Formale Gleichung 3.544 aus Abschnitt 3.2.16.', 'derived', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(636, '3.545', 30, 'Orthogonale Zerlegung des Datenvektors', 'b=AA^{+}b+\\left(I-AA^{+}\\right)b', 'b=AA^{+}b+\\left(I-AA^{+}\\right)b', 'Formale Gleichung 3.545 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 75, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(637, '3.546', 30, 'Allgemeines regularisiertes Ausgleichsproblem', 'x_{\\lambda}\\in\\operatorname*{arg\\,min}_{x}\\left(\\|Ax-b\\|_2^2+\\lambda\\,\\mathcal{R}(x)\\right)', 'x_{\\lambda}\\in\\operatorname*{arg\\,min}_{x}\\left(\\|Ax-b\\|_2^2+\\lambda\\,\\mathcal{R}(x)\\right)', 'Formale Gleichung 3.546 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(638, '3.547', 30, 'Regularisierungsterm', '\\mathcal{R}(x)', '\\mathcal{R}(x)', 'Formale Gleichung 3.547 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(639, '3.548', 30, 'Nichtnegativer Regularisierungsparameter', '\\lambda\\geq 0', '\\lambda\\geq 0', 'Formale Gleichung 3.548 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(640, '3.549', 30, 'Tikhonov-Funktional', 'J_{\\lambda}(x)=\\|Ax-b\\|_2^2+\\lambda\\|Lx\\|_2^2', 'J_{\\lambda}(x)=\\|Ax-b\\|_2^2+\\lambda\\|Lx\\|_2^2', 'Formale Gleichung 3.549 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(641, '3.550', 30, 'Dimension des Regularisierungsoperators', 'L\\in\\mathbb{R}^{p\\times n}', 'L\\in\\mathbb{R}^{p\\times n}', 'Formale Gleichung 3.550 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(642, '3.551', 30, 'Standardregularisierung mit Identität', 'L=I', 'L=I', 'Formale Gleichung 3.551 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(643, '3.552', 30, 'Standardform des Tikhonov-Funktionals', 'J_{\\lambda}(x)=\\|Ax-b\\|_2^2+\\lambda\\|x\\|_2^2', 'J_{\\lambda}(x)=\\|Ax-b\\|_2^2+\\lambda\\|x\\|_2^2', 'Formale Gleichung 3.552 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(644, '3.553', 30, 'Normalgleichung der allgemeinen Tikhonov-Regularisierung', '\\left(A^{\\mathsf T}A+\\lambda L^{\\mathsf T}L\\right)x_{\\lambda}=A^{\\mathsf T}b', '\\left(A^{\\mathsf T}A+\\lambda L^{\\mathsf T}L\\right)x_{\\lambda}=A^{\\mathsf T}b', 'Formale Gleichung 3.553 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(645, '3.554', 30, 'Normalgleichung der Standardregularisierung', '\\left(A^{\\mathsf T}A+\\lambda I\\right)x_{\\lambda}=A^{\\mathsf T}b', '\\left(A^{\\mathsf T}A+\\lambda I\\right)x_{\\lambda}=A^{\\mathsf T}b', 'Formale Gleichung 3.554 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(646, '3.555', 30, 'Explizite Standard-Tikhonov-Lösung', 'x_{\\lambda}=\\left(A^{\\mathsf T}A+\\lambda I\\right)^{-1}A^{\\mathsf T}b', 'x_{\\lambda}=\\left(A^{\\mathsf T}A+\\lambda I\\right)^{-1}A^{\\mathsf T}b', 'Formale Gleichung 3.555 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(647, '3.556', 30, 'Singulärwertzerlegung für Tikhonov', 'A=U\\Sigma V^{\\mathsf T}', 'A=U\\Sigma V^{\\mathsf T}', 'Formale Gleichung 3.556 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(648, '3.557', 30, 'Spektrale Tikhonov-Lösung', 'x_{\\lambda}=\\sum_{i=1}^{r}\\frac{\\sigma_i}{\\sigma_i^2+\\lambda}\\left(u_i^{\\mathsf T}b\\right)v_i', 'x_{\\lambda}=\\sum_{i=1}^{r}\\frac{\\sigma_i}{\\sigma_i^2+\\lambda}\\left(u_i^{\\mathsf T}b\\right)v_i', 'Formale Gleichung 3.557 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(649, '3.558', 30, 'Tikhonov-Filterfaktor', '\\phi_i(\\lambda)=\\frac{\\sigma_i^2}{\\sigma_i^2+\\lambda}', '\\phi_i(\\lambda)=\\frac{\\sigma_i^2}{\\sigma_i^2+\\lambda}', 'Formale Gleichung 3.558 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(650, '3.559', 30, 'Filterfaktor bei großem Singulärwert', '\\phi_i(\\lambda)\\approx 1', '\\phi_i(\\lambda)\\approx 1', 'Formale Gleichung 3.559 aus Abschnitt 3.2.16.', 'derived', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(651, '3.560', 30, 'Filterfaktor bei kleinem Singulärwert', '\\phi_i(\\lambda)\\approx 0', '\\phi_i(\\lambda)\\approx 0', 'Formale Gleichung 3.560 aus Abschnitt 3.2.16.', 'derived', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(652, '3.561', 30, 'Positiver Abschneideschwellenwert', '\\tau>0', '\\tau>0', 'Formale Gleichung 3.561 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(653, '3.562', 30, 'Regularisierte Pseudoinverse durch TSVD', 'A_{\\tau}^{+}=\\sum_{\\sigma_i>\\tau}\\frac{1}{\\sigma_i}v_i u_i^{\\mathsf T}', 'A_{\\tau}^{+}=\\sum_{\\sigma_i>\\tau}\\frac{1}{\\sigma_i}v_i u_i^{\\mathsf T}', 'Formale Gleichung 3.562 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(654, '3.563', 30, 'TSVD-Lösung', 'x_{\\tau}=A_{\\tau}^{+}b', 'x_{\\tau}=A_{\\tau}^{+}b', 'Formale Gleichung 3.563 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(655, '3.564', 30, 'Verworfene Singulärwerte', '\\sigma_i\\leq\\tau', '\\sigma_i\\leq\\tau', 'Formale Gleichung 3.564 aus Abschnitt 3.2.16.', 'definition', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(656, '3.565', 30, 'Grenzübergang für kleine Regularisierung', '\\lambda\\rightarrow 0\\quad\\Longrightarrow\\quad x_{\\lambda}\\rightarrow A^{+}b', '\\lambda\\rightarrow 0\\quad\\Longrightarrow\\quad x_{\\lambda}\\rightarrow A^{+}b', 'Formale Gleichung 3.565 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(657, '3.566', 30, 'Grenzübergang für starke Regularisierung', '\\lambda\\rightarrow\\infty\\quad\\Longrightarrow\\quad x_{\\lambda}\\rightarrow 0', '\\lambda\\rightarrow\\infty\\quad\\Longrightarrow\\quad x_{\\lambda}\\rightarrow 0', 'Formale Gleichung 3.566 aus Abschnitt 3.2.16.', 'theorem', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(658, '3.567', 30, 'Datenanpassung', '\\text{Datenanpassung}', '\\text{Datenanpassung}', 'Formale Gleichung 3.567 aus Abschnitt 3.2.16.', 'other', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(659, '3.568', 30, 'Lösungsstabilität', '\\text{Lösungsstabilität}', '\\text{Lösungsstabilität}', 'Formale Gleichung 3.568 aus Abschnitt 3.2.16.', 'other', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(660, '3.569', 30, 'Geringe Verzerrung und hohe Varianz', '\\text{kleine Verzerrung}\\quad+\\quad\\text{hohe Varianz}', '\\text{kleine Verzerrung}\\quad+\\quad\\text{hohe Varianz}', 'Formale Gleichung 3.569 aus Abschnitt 3.2.16.', 'other', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(661, '3.570', 30, 'Größere Verzerrung und geringere Varianz', '\\text{größere Verzerrung}\\quad+\\quad\\text{geringere Varianz}', '\\text{größere Verzerrung}\\quad+\\quad\\text{geringere Varianz}', 'Formale Gleichung 3.570 aus Abschnitt 3.2.16.', 'other', 'adapted', 76, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(662, '3.571', 30, 'Typisch überbestimmtes System', 'm>n\\quad\\Longrightarrow\\quad\\text{typischerweise überbestimmt}', 'm>n\\quad\\Longrightarrow\\quad\\text{typischerweise überbestimmt}', 'Formale Gleichung 3.571 aus Abschnitt 3.2.16.', 'other', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(663, '3.572', 30, 'Typisch unterbestimmtes System', 'm<n\\quad\\Longrightarrow\\quad\\text{typischerweise unterbestimmt}', 'm<n\\quad\\Longrightarrow\\quad\\text{typischerweise unterbestimmt}', 'Formale Gleichung 3.572 aus Abschnitt 3.2.16.', 'other', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(664, '3.573', 30, 'Didaktische Auswahlfrage', '\\text{Nach welchem Kriterium ist die Lösung die beste?}', '\\text{Nach welchem Kriterium ist die Lösung die beste?}', 'Formale Gleichung 3.573 aus Abschnitt 3.2.16.', 'other', 'adapted', 62, 'Im Abschnitt 3.2.16 definiert, hergeleitet oder als etablierte Standardbeziehung der linearen Algebra, Ausgleichsrechnung oder Regularisierungstheorie verwendet.', 'Reelle endlichdimensionale Vektor- und Matrixräume sowie die jeweils angegebenen Rang-, Invertierbarkeits- und Regularisierungsvoraussetzungen.', 'verified', 33),
(722, '3.574', 31, 'Lineares Gleichungssystem', 'Ax=b,\\qquad A\\in\\mathbb{R}^{n\\times n},\\qquad b\\in\\mathbb{R}^{n}', 'Ax=b,\\qquad A\\in\\mathbb{R}^{n\\times n},\\qquad b\\in\\mathbb{R}^{n}', 'Formale Gleichung 3.574 aus Abschnitt 3.2.17.', 'definition', 'adapted', 72, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(723, '3.575', 31, 'Stationäre Iterationsvorschrift', 'x^{(k+1)}=Bx^{(k)}+c', 'x^{(k+1)}=Bx^{(k)}+c', 'Formale Gleichung 3.575 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(724, '3.576', 31, 'Iterationsnäherung', 'x^{(k)}', 'x^{(k)}', 'Formale Gleichung 3.576 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(725, '3.577', 31, 'Iterationsmatrix', 'B\\in\\mathbb{R}^{n\\times n}', 'B\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.577 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(726, '3.578', 31, 'Konstanter Iterationsvektor', 'c\\in\\mathbb{R}^{n}', 'c\\in\\mathbb{R}^{n}', 'Formale Gleichung 3.578 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(727, '3.579', 31, 'Fixpunktgleichung', 'x^\\ast=Bx^\\ast+c', 'x^\\ast=Bx^\\ast+c', 'Formale Gleichung 3.579 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(728, '3.580', 31, 'Umgeformte Fixpunktgleichung', '(I-B)x^\\ast=c', '(I-B)x^\\ast=c', 'Formale Gleichung 3.580 aus Abschnitt 3.2.17.', 'derived', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(729, '3.581', 31, 'Übereinstimmung mit Ausgangssystem', 'Ax^\\ast=b', 'Ax^\\ast=b', 'Formale Gleichung 3.581 aus Abschnitt 3.2.17.', 'derived', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(730, '3.582', 31, 'Matrixzerlegung', 'A=M-N', 'A=M-N', 'Formale Gleichung 3.582 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(731, '3.583', 31, 'Zerlegte Systemgleichung', '(M-N)x=b', '(M-N)x=b', 'Formale Gleichung 3.583 aus Abschnitt 3.2.17.', 'derived', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(732, '3.584', 31, 'Umgestellte Systemgleichung', 'Mx=Nx+b', 'Mx=Nx+b', 'Formale Gleichung 3.584 aus Abschnitt 3.2.17.', 'derived', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(733, '3.585', 31, 'Implizite Iterationsvorschrift', 'Mx^{(k+1)}=Nx^{(k)}+b', 'Mx^{(k+1)}=Nx^{(k)}+b', 'Formale Gleichung 3.585 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(734, '3.586', 31, 'Explizite Iterationsvorschrift', 'x^{(k+1)}=M^{-1}Nx^{(k)}+M^{-1}b', 'x^{(k+1)}=M^{-1}Nx^{(k)}+M^{-1}b', 'Formale Gleichung 3.586 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(735, '3.587', 31, 'Iterationsmatrix aus der Zerlegung', 'B=M^{-1}N', 'B=M^{-1}N', 'Formale Gleichung 3.587 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(736, '3.588', 31, 'Iterationsvektor aus der Zerlegung', 'c=M^{-1}b', 'c=M^{-1}b', 'Formale Gleichung 3.588 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(737, '3.589', 31, 'Exakte Lösung', 'Ax^\\ast=b', 'Ax^\\ast=b', 'Formale Gleichung 3.589 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(738, '3.590', 31, 'Iterationsfehler', 'e^{(k)}=x^\\ast-x^{(k)}', 'e^{(k)}=x^\\ast-x^{(k)}', 'Formale Gleichung 3.590 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(739, '3.591', 31, 'Iterationsgleichung', 'x^{(k+1)}=Bx^{(k)}+c', 'x^{(k+1)}=Bx^{(k)}+c', 'Formale Gleichung 3.591 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(740, '3.592', 31, 'Fixpunktgleichung der exakten Lösung', 'x^\\ast=Bx^\\ast+c', 'x^\\ast=Bx^\\ast+c', 'Formale Gleichung 3.592 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(741, '3.593', 31, 'Fehlerrekursion', 'e^{(k+1)}=Be^{(k)}', 'e^{(k+1)}=Be^{(k)}', 'Formale Gleichung 3.593 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(742, '3.594', 31, 'Fehler nach k Schritten', 'e^{(k)}=B^k e^{(0)}', 'e^{(k)}=B^k e^{(0)}', 'Formale Gleichung 3.594 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(743, '3.595', 31, 'Stationäre Iteration', 'x^{(k+1)}=Bx^{(k)}+c', 'x^{(k+1)}=Bx^{(k)}+c', 'Formale Gleichung 3.595 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(744, '3.596', 31, 'Spektralradiuskriterium', '\\rho(B)<1', '\\rho(B)<1', 'Formale Gleichung 3.596 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(745, '3.597', 31, 'Definition des Spektralradius', '\\rho(B)=\\max\\left\\{|\\lambda|\\;\\middle|\\;\\lambda\\in\\sigma(B)\\right\\}', '\\rho(B)=\\max\\left\\{|\\lambda|\\;\\middle|\\;\\lambda\\in\\sigma(B)\\right\\}', 'Formale Gleichung 3.597 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(746, '3.598', 31, 'Fehlerdarstellung über Matrixpotenzen', 'e^{(k)}=B^k e^{(0)}', 'e^{(k)}=B^k e^{(0)}', 'Formale Gleichung 3.598 aus Abschnitt 3.2.17.', 'derived', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(747, '3.599', 31, 'Verschwinden des Fehlers', 'e^{(k)}\\rightarrow 0', 'e^{(k)}\\rightarrow 0', 'Formale Gleichung 3.599 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(748, '3.600', 31, 'Verschwinden der Matrixpotenzen', 'B^k\\rightarrow 0', 'B^k\\rightarrow 0', 'Formale Gleichung 3.600 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(749, '3.601', 31, 'Äquivalentes Spektralradiuskriterium', '\\rho(B)<1', '\\rho(B)<1', 'Formale Gleichung 3.601 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(750, '3.602', 31, 'Nichtkonvergenter Eigenwertbereich', '|\\lambda|\\geq 1', '|\\lambda|\\geq 1', 'Formale Gleichung 3.602 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(751, '3.603', 31, 'Residuum eines Iterationsschritts', 'r^{(k)}=b-Ax^{(k)}', 'r^{(k)}=b-Ax^{(k)}', 'Formale Gleichung 3.603 aus Abschnitt 3.2.17.', 'definition', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(752, '3.604', 31, 'Residuum der exakten Lösung', 'r^\\ast=b-Ax^\\ast=0', 'r^\\ast=b-Ax^\\ast=0', 'Formale Gleichung 3.604 aus Abschnitt 3.2.17.', 'definition', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(753, '3.605', 31, 'Beziehung zwischen Residuum und Fehler', 'r^{(k)}=Ae^{(k)}', 'r^{(k)}=Ae^{(k)}', 'Formale Gleichung 3.605 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(754, '3.606', 31, 'Fehlerdefinition', 'e^{(k)}=x^\\ast-x^{(k)}', 'e^{(k)}=x^\\ast-x^{(k)}', 'Formale Gleichung 3.606 aus Abschnitt 3.2.17.', 'definition', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(755, '3.607', 31, 'Herleitung der Residuum-Fehler-Beziehung', 'Ae^{(k)}=Ax^\\ast-Ax^{(k)}=b-Ax^{(k)}', 'Ae^{(k)}=Ax^\\ast-Ax^{(k)}=b-Ax^{(k)}', 'Formale Gleichung 3.607 aus Abschnitt 3.2.17.', 'derived', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(756, '3.608', 31, 'Fehler aus Residuum', 'e^{(k)}=A^{-1}r^{(k)}', 'e^{(k)}=A^{-1}r^{(k)}', 'Formale Gleichung 3.608 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(757, '3.609', 31, 'Fehlerabschätzung über Residuum', '\\|e^{(k)}\\|\\leq\\|A^{-1}\\|\\,\\|r^{(k)}\\|', '\\|e^{(k)}\\|\\leq\\|A^{-1}\\|\\,\\|r^{(k)}\\|', 'Formale Gleichung 3.609 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(758, '3.610', 31, 'Jacobi-Zerlegung', 'A=D+L+U', 'A=D+L+U', 'Formale Gleichung 3.610 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(759, '3.611', 31, 'Diagonalmatrix', 'D=\\operatorname{diag}(a_{11},a_{22},\\ldots,a_{nn})', 'D=\\operatorname{diag}(a_{11},a_{22},\\ldots,a_{nn})', 'Formale Gleichung 3.611 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(760, '3.612', 31, 'Zerlegte Jacobi-Gleichung', '(D+L+U)x=b', '(D+L+U)x=b', 'Formale Gleichung 3.612 aus Abschnitt 3.2.17.', 'derived', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(761, '3.613', 31, 'Umgestellte Jacobi-Gleichung', 'Dx=-(L+U)x+b', 'Dx=-(L+U)x+b', 'Formale Gleichung 3.613 aus Abschnitt 3.2.17.', 'derived', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(762, '3.614', 31, 'Implizites Jacobi-Verfahren', 'Dx^{(k+1)}=-(L+U)x^{(k)}+b', 'Dx^{(k+1)}=-(L+U)x^{(k)}+b', 'Formale Gleichung 3.614 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(763, '3.615', 31, 'Explizites Jacobi-Verfahren', 'x^{(k+1)}=-D^{-1}(L+U)x^{(k)}+D^{-1}b', 'x^{(k+1)}=-D^{-1}(L+U)x^{(k)}+D^{-1}b', 'Formale Gleichung 3.615 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(764, '3.616', 31, 'Jacobi-Iterationsmatrix', 'B_J=-D^{-1}(L+U)', 'B_J=-D^{-1}(L+U)', 'Formale Gleichung 3.616 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(765, '3.617', 31, 'Komponentenform des Jacobi-Verfahrens', 'x_i^{(k+1)}=\\frac{1}{a_{ii}}\\left(b_i-\\sum_{\\substack{j=1\\\\j\\neq i}}^{n}a_{ij}x_j^{(k)}\\right)', 'x_i^{(k+1)}=\\frac{1}{a_{ii}}\\left(b_i-\\sum_{\\substack{j=1\\\\j\\neq i}}^{n}a_{ij}x_j^{(k)}\\right)', 'Formale Gleichung 3.617 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(766, '3.618', 31, 'Nichtverschwindende Diagonaleinträge', 'a_{ii}\\neq 0\\qquad\\text{für alle }i', 'a_{ii}\\neq 0\\qquad\\text{für alle }i', 'Formale Gleichung 3.618 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(767, '3.619', 31, 'Gauß-Seidel-Zerlegung', 'A=D+L+U', 'A=D+L+U', 'Formale Gleichung 3.619 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(768, '3.620', 31, 'Umgestellte Gauß-Seidel-Gleichung', '(D+L)x=-Ux+b', '(D+L)x=-Ux+b', 'Formale Gleichung 3.620 aus Abschnitt 3.2.17.', 'derived', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(769, '3.621', 31, 'Implizites Gauß-Seidel-Verfahren', '(D+L)x^{(k+1)}=-Ux^{(k)}+b', '(D+L)x^{(k+1)}=-Ux^{(k)}+b', 'Formale Gleichung 3.621 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(770, '3.622', 31, 'Explizites Gauß-Seidel-Verfahren', 'x^{(k+1)}=-(D+L)^{-1}Ux^{(k)}+(D+L)^{-1}b', 'x^{(k+1)}=-(D+L)^{-1}Ux^{(k)}+(D+L)^{-1}b', 'Formale Gleichung 3.622 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(771, '3.623', 31, 'Gauß-Seidel-Iterationsmatrix', 'B_{\\mathrm{GS}}=-(D+L)^{-1}U', 'B_{\\mathrm{GS}}=-(D+L)^{-1}U', 'Formale Gleichung 3.623 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(772, '3.624', 31, 'Komponentenform des Gauß-Seidel-Verfahrens', 'x_i^{(k+1)}=\\frac{1}{a_{ii}}\\left(b_i-\\sum_{j=1}^{i-1}a_{ij}x_j^{(k+1)}-\\sum_{j=i+1}^{n}a_{ij}x_j^{(k)}\\right)', 'x_i^{(k+1)}=\\frac{1}{a_{ii}}\\left(b_i-\\sum_{j=1}^{i-1}a_{ij}x_j^{(k+1)}-\\sum_{j=i+1}^{n}a_{ij}x_j^{(k)}\\right)', 'Formale Gleichung 3.624 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(773, '3.625', 31, 'Allgemeine quadratische Matrix', 'A=(a_{ij})\\in\\mathbb{R}^{n\\times n}', 'A=(a_{ij})\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.625 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(774, '3.626', 31, 'Strikte Diagonaldominanz', '|a_{ii}|>\\sum_{\\substack{j=1\\\\j\\neq i}}^{n}|a_{ij}|', '|a_{ii}|>\\sum_{\\substack{j=1\\\\j\\neq i}}^{n}|a_{ij}|', 'Formale Gleichung 3.626 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(775, '3.627', 31, 'Vorläufiger Iterationswert', '\\widetilde{x}^{(k+1)}', '\\widetilde{x}^{(k+1)}', 'Formale Gleichung 3.627 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(776, '3.628', 31, 'Relaxationsschritt', 'x^{(k+1)}=x^{(k)}+\\omega\\left(\\widetilde{x}^{(k+1)}-x^{(k)}\\right)', 'x^{(k+1)}=x^{(k)}+\\omega\\left(\\widetilde{x}^{(k+1)}-x^{(k)}\\right)', 'Formale Gleichung 3.628 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(777, '3.629', 31, 'Positiver Relaxationsparameter', '\\omega>0', '\\omega>0', 'Formale Gleichung 3.629 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(778, '3.630', 31, 'Unterrelaxation', '0<\\omega<1', '0<\\omega<1', 'Formale Gleichung 3.630 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(779, '3.631', 31, 'Unverändertes Grundverfahren', '\\omega=1', '\\omega=1', 'Formale Gleichung 3.631 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(780, '3.632', 31, 'Überrelaxation', '\\omega>1', '\\omega>1', 'Formale Gleichung 3.632 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(781, '3.633', 31, 'Konvergenzordnung', '\\|x^{(k+1)}-x^\\ast\\|\\leq C\\|x^{(k)}-x^\\ast\\|^p', '\\|x^{(k+1)}-x^\\ast\\|\\leq C\\|x^{(k)}-x^\\ast\\|^p', 'Formale Gleichung 3.633 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(782, '3.634', 31, 'Positive Konvergenzkonstante', 'C>0', 'C>0', 'Formale Gleichung 3.634 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(783, '3.635', 31, 'Lineare Konvergenzordnung', 'p=1', 'p=1', 'Formale Gleichung 3.635 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(784, '3.636', 31, 'Quadratische Konvergenzordnung', 'p=2', 'p=2', 'Formale Gleichung 3.636 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(785, '3.637', 31, 'Asymptotische Fehlerabschätzung', '\\|e^{(k)}\\|\\approx C\\,\\rho(B)^k', '\\|e^{(k)}\\|\\approx C\\,\\rho(B)^k', 'Formale Gleichung 3.637 aus Abschnitt 3.2.17.', 'metric', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(786, '3.638', 31, 'Tatsächlicher Iterationsfehler', '\\|x^\\ast-x^{(k)}\\|', '\\|x^\\ast-x^{(k)}\\|', 'Formale Gleichung 3.638 aus Abschnitt 3.2.17.', 'metric', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(787, '3.639', 31, 'Absolutes Residualkriterium', '\\|r^{(k)}\\|\\leq\\varepsilon_{\\mathrm{abs}}', '\\|r^{(k)}\\|\\leq\\varepsilon_{\\mathrm{abs}}', 'Formale Gleichung 3.639 aus Abschnitt 3.2.17.', 'metric', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(788, '3.640', 31, 'Relatives Residualkriterium', '\\frac{\\|r^{(k)}\\|}{\\|b\\|}\\leq\\varepsilon_{\\mathrm{rel}}', '\\frac{\\|r^{(k)}\\|}{\\|b\\|}\\leq\\varepsilon_{\\mathrm{rel}}', 'Formale Gleichung 3.640 aus Abschnitt 3.2.17.', 'metric', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(789, '3.641', 31, 'Absolutes Änderungskriterium', '\\|x^{(k+1)}-x^{(k)}\\|\\leq\\varepsilon_x', '\\|x^{(k+1)}-x^{(k)}\\|\\leq\\varepsilon_x', 'Formale Gleichung 3.641 aus Abschnitt 3.2.17.', 'metric', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(790, '3.642', 31, 'Relatives Änderungskriterium', '\\frac{\\|x^{(k+1)}-x^{(k)}\\|}{\\max\\{1,\\|x^{(k+1)}\\|\\}}\\leq\\varepsilon_x', '\\frac{\\|x^{(k+1)}-x^{(k)}\\|}{\\max\\{1,\\|x^{(k+1)}\\|\\}}\\leq\\varepsilon_x', 'Formale Gleichung 3.642 aus Abschnitt 3.2.17.', 'metric', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(791, '3.643', 31, 'Maximale Iterationszahl', 'k\\leq k_{\\max}', 'k\\leq k_{\\max}', 'Formale Gleichung 3.643 aus Abschnitt 3.2.17.', 'metric', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(792, '3.644', 31, 'Vorkonditionierer', 'P\\in\\mathbb{R}^{n\\times n}', 'P\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.644 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(793, '3.645', 31, 'Linke Vorkonditionierung', 'P^{-1}Ax=P^{-1}b', 'P^{-1}Ax=P^{-1}b', 'Formale Gleichung 3.645 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(794, '3.646', 31, 'Substitution bei rechter Vorkonditionierung', 'x=P^{-1}y', 'x=P^{-1}y', 'Formale Gleichung 3.646 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(795, '3.647', 31, 'Rechts vorkonditioniertes System', 'AP^{-1}y=b', 'AP^{-1}y=b', 'Formale Gleichung 3.647 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(796, '3.648', 31, 'Ideale Vorkonditionierung', 'P^{-1}A\\approx I', 'P^{-1}A\\approx I', 'Formale Gleichung 3.648 aus Abschnitt 3.2.17.', 'other', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(797, '3.649', 31, 'Qualität der Approximation', '\\text{Qualität der Approximation}', '\\text{Qualität der Approximation}', 'Formale Gleichung 3.649 aus Abschnitt 3.2.17.', 'other', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(798, '3.650', 31, 'Aufwand des Vorkonditionierers', '\\text{Aufwand der Anwendung von }P^{-1}', '\\text{Aufwand der Anwendung von }P^{-1}', 'Formale Gleichung 3.650 aus Abschnitt 3.2.17.', 'other', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(799, '3.651', 31, 'Allgemeiner nichtstationärer Schritt', 'x^{(k+1)}=x^{(k)}+\\alpha_k p^{(k)}', 'x^{(k+1)}=x^{(k)}+\\alpha_k p^{(k)}', 'Formale Gleichung 3.651 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(800, '3.652', 31, 'Suchrichtung', 'p^{(k)}', 'p^{(k)}', 'Formale Gleichung 3.652 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(801, '3.653', 31, 'Schrittlänge', '\\alpha_k', '\\alpha_k', 'Formale Gleichung 3.653 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(802, '3.654', 31, 'A-Konjugiertheit der Suchrichtungen', '(p^{(i)})^{\\mathsf T}Ap^{(j)}=0\\qquad\\text{für }i\\neq j', '(p^{(i)})^{\\mathsf T}Ap^{(j)}=0\\qquad\\text{für }i\\neq j', 'Formale Gleichung 3.654 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(803, '3.655', 31, 'CG-Iterationsschritt', 'x^{(k+1)}=x^{(k)}+\\alpha_k p^{(k)}', 'x^{(k+1)}=x^{(k)}+\\alpha_k p^{(k)}', 'Formale Gleichung 3.655 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(804, '3.656', 31, 'CG-Residualaktualisierung', 'r^{(k+1)}=r^{(k)}-\\alpha_kAp^{(k)}', 'r^{(k+1)}=r^{(k)}-\\alpha_kAp^{(k)}', 'Formale Gleichung 3.656 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(805, '3.657', 31, 'CG-Schrittlänge', '\\alpha_k=\\frac{(r^{(k)})^{\\mathsf T}r^{(k)}}{(p^{(k)})^{\\mathsf T}Ap^{(k)}}', '\\alpha_k=\\frac{(r^{(k)})^{\\mathsf T}r^{(k)}}{(p^{(k)})^{\\mathsf T}Ap^{(k)}}', 'Formale Gleichung 3.657 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(806, '3.658', 31, 'CG-Suchrichtungsaktualisierung', 'p^{(k+1)}=r^{(k+1)}+\\beta_k p^{(k)}', 'p^{(k+1)}=r^{(k+1)}+\\beta_k p^{(k)}', 'Formale Gleichung 3.658 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(807, '3.659', 31, 'CG-Koeffizient Beta', '\\beta_k=\\frac{(r^{(k+1)})^{\\mathsf T}r^{(k+1)}}{(r^{(k)})^{\\mathsf T}r^{(k)}}', '\\beta_k=\\frac{(r^{(k+1)})^{\\mathsf T}r^{(k+1)}}{(r^{(k)})^{\\mathsf T}r^{(k)}}', 'Formale Gleichung 3.659 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(808, '3.660', 31, 'CG-Fehlerabschätzung', '\\|e^{(k)}\\|_A\\leq 2\\left(\\frac{\\sqrt{\\kappa_2(A)}-1}{\\sqrt{\\kappa_2(A)}+1}\\right)^k\\|e^{(0)}\\|_A', '\\|e^{(k)}\\|_A\\leq 2\\left(\\frac{\\sqrt{\\kappa_2(A)}-1}{\\sqrt{\\kappa_2(A)}+1}\\right)^k\\|e^{(0)}\\|_A', 'Formale Gleichung 3.660 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(809, '3.661', 31, 'Energienorm', '\\|x\\|_A=\\sqrt{x^{\\mathsf T}Ax}', '\\|x\\|_A=\\sqrt{x^{\\mathsf T}Ax}', 'Formale Gleichung 3.661 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(810, '3.662', 31, 'Große Konditionszahl', '\\kappa_2(A)\\gg 1', '\\kappa_2(A)\\gg 1', 'Formale Gleichung 3.662 aus Abschnitt 3.2.17.', 'metric', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(811, '3.663', 31, 'Verbesserte Kondition durch Vorkonditionierung', '\\kappa_2(P^{-1}A)<\\kappa_2(A)', '\\kappa_2(P^{-1}A)<\\kappa_2(A)', 'Formale Gleichung 3.663 aus Abschnitt 3.2.17.', 'metric', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(812, '3.664', 31, 'Startvektor', 'x^{(0)}', 'x^{(0)}', 'Formale Gleichung 3.664 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(813, '3.665', 31, 'Toleranz', '\\varepsilon', '\\varepsilon', 'Formale Gleichung 3.665 aus Abschnitt 3.2.17.', 'definition', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(814, '3.666', 31, 'Maximale Iterationszahl', 'k_{\\max}', 'k_{\\max}', 'Formale Gleichung 3.666 aus Abschnitt 3.2.17.', 'definition', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(815, '3.667', 31, 'Verwendete Norm', '\\|\\cdot\\|', '\\|\\cdot\\|', 'Formale Gleichung 3.667 aus Abschnitt 3.2.17.', 'definition', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(816, '3.668', 31, 'Vorkonditionierer als Dokumentationsgröße', 'P', 'P', 'Formale Gleichung 3.668 aus Abschnitt 3.2.17.', 'definition', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(817, '3.669', 31, 'Dokumentierter Residualverlauf', '\\left\\{\\|r^{(k)}\\|\\right\\}_{k=0}^{K}', '\\left\\{\\|r^{(k)}\\|\\right\\}_{k=0}^{K}', 'Formale Gleichung 3.669 aus Abschnitt 3.2.17.', 'metric', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(818, '3.670', 31, 'Fehlerfortschritt', 'e^{(k+1)}=Be^{(k)}', 'e^{(k+1)}=Be^{(k)}', 'Formale Gleichung 3.670 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(819, '3.671', 31, 'Gedämpfte Eigenwertrichtung', '|\\lambda|<1', '|\\lambda|<1', 'Formale Gleichung 3.671 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(820, '3.672', 31, 'Verstärkte Eigenwertrichtung', '|\\lambda|>1', '|\\lambda|>1', 'Formale Gleichung 3.672 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 77, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(821, '3.673', 31, 'Residuum-Fehler-Zusammenhang', 'r^{(k)}=Ae^{(k)}', 'r^{(k)}=Ae^{(k)}', 'Formale Gleichung 3.673 aus Abschnitt 3.2.17.', 'theorem', 'adapted', 74, 'In Abschnitt 3.2.17 definiert, hergeleitet oder als etablierte Beziehung verwendet.', 'Reelle endlichdimensionale Räume und die jeweils genannten Voraussetzungen.', 'verified', 34),
(849, '3.674', 32, 'Gleichung 3.674', 'Ax=b', 'Ax=b', 'Formale Gleichung 3.674 aus Abschnitt 3.2.18.', 'other', 'adapted', 72, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(850, '3.675', 32, 'Gleichung 3.675', 'F(x)=0', 'F(x)=0', 'Formale Gleichung 3.675 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(851, '3.676', 32, 'Gleichung 3.676', 'F:\\mathbb{R}^{n}\\rightarrow\\mathbb{R}^{n}', 'F:\\mathbb{R}^{n}\\rightarrow\\mathbb{R}^{n}', 'Formale Gleichung 3.676 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(852, '3.677', 32, 'Gleichung 3.677', 'x\\in\\mathbb{R}^{n}', 'x\\in\\mathbb{R}^{n}', 'Formale Gleichung 3.677 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(853, '3.678', 32, 'Gleichung 3.678', 'f_i(x_1,x_2,\\ldots,x_n)=0,\\qquad i=1,\\ldots,n', 'f_i(x_1,x_2,\\ldots,x_n)=0,\\qquad i=1,\\ldots,n', 'Formale Gleichung 3.678 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(854, '3.679', 32, 'Gleichung 3.679', 'F(x)=\\begin{pmatrix}f_1(x)\\\\f_2(x)\\\\\\vdots\\\\f_n(x) \\end{pmatrix}', 'F(x)=\\begin{pmatrix}f_1(x)\\\\f_2(x)\\\\\\vdots\\\\f_n(x) \\end{pmatrix}', 'Formale Gleichung 3.679 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(855, '3.680', 32, 'Gleichung 3.680', 'F(x^\\ast)=0', 'F(x^\\ast)=0', 'Formale Gleichung 3.680 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(856, '3.681', 32, 'Gleichung 3.681', 'F=\\begin{pmatrix}f_1\\\\f_2\\\\\\vdots\\\\f_m \\end{pmatrix}:\\mathbb{R}^{n}\\rightarrow\\mathbb{R}^{m}', 'F=\\begin{pmatrix}f_1\\\\f_2\\\\\\vdots\\\\f_m \\end{pmatrix}:\\mathbb{R}^{n}\\rightarrow\\mathbb{R}^{m}', 'Formale Gleichung 3.681 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(857, '3.682', 32, 'Gleichung 3.682', 'J_F(x)=\\left(\\frac{\\partial f_i}{\\partial x_j}(x)\\right)', 'J_F(x)=\\left(\\frac{\\partial f_i}{\\partial x_j}(x)\\right)', 'Formale Gleichung 3.682 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(858, '3.683', 32, 'Gleichung 3.683', 'J_F(x)\\in\\mathbb{R}^{n\\times n}', 'J_F(x)\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.683 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(859, '3.684', 32, 'Gleichung 3.684', 'h\\in\\mathbb{R}^{n}', 'h\\in\\mathbb{R}^{n}', 'Formale Gleichung 3.684 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(860, '3.685', 32, 'Gleichung 3.685', 'F(x+h)\\approx F(x)+J_F(x)h', 'F(x+h)\\approx F(x)+J_F(x)h', 'Formale Gleichung 3.685 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(861, '3.686', 32, 'Gleichung 3.686', 'F(x+h)=F(x)+J_F(x)h+r(h)', 'F(x+h)=F(x)+J_F(x)h+r(h)', 'Formale Gleichung 3.686 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(862, '3.687', 32, 'Gleichung 3.687', '\\lim_{\\|h\\|\\rightarrow 0}\\frac{\\|r(h)\\|}{\\|h\\|}=0', '\\lim_{\\|h\\|\\rightarrow 0}\\frac{\\|r(h)\\|}{\\|h\\|}=0', 'Formale Gleichung 3.687 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(863, '3.688', 32, 'Gleichung 3.688', 'F(x)=0', 'F(x)=0', 'Formale Gleichung 3.688 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(864, '3.689', 32, 'Gleichung 3.689', 'F(x^{(k)}+s^{(k)})\\approx F(x^{(k)})+J_F(x^{(k)})s^{(k)}', 'F(x^{(k)}+s^{(k)})\\approx F(x^{(k)})+J_F(x^{(k)})s^{(k)}', 'Formale Gleichung 3.689 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(865, '3.690', 32, 'Gleichung 3.690', 'F(x^{(k)})+J_F(x^{(k)})s^{(k)}=0', 'F(x^{(k)})+J_F(x^{(k)})s^{(k)}=0', 'Formale Gleichung 3.690 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(866, '3.691', 32, 'Gleichung 3.691', 'J_F(x^{(k)})s^{(k)}=-F(x^{(k)})', 'J_F(x^{(k)})s^{(k)}=-F(x^{(k)})', 'Formale Gleichung 3.691 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(867, '3.692', 32, 'Gleichung 3.692', 'x^{(k+1)}=x^{(k)}+s^{(k)}', 'x^{(k+1)}=x^{(k)}+s^{(k)}', 'Formale Gleichung 3.692 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(868, '3.693', 32, 'Gleichung 3.693', 's^{(k)}=-J_F(x^{(k)})^{-1}F(x^{(k)})', 's^{(k)}=-J_F(x^{(k)})^{-1}F(x^{(k)})', 'Formale Gleichung 3.693 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(869, '3.694', 32, 'Gleichung 3.694', 'x^{(k+1)}=x^{(k)}-J_F(x^{(k)})^{-1}F(x^{(k)})', 'x^{(k+1)}=x^{(k)}-J_F(x^{(k)})^{-1}F(x^{(k)})', 'Formale Gleichung 3.694 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(870, '3.695', 32, 'Gleichung 3.695', 'F(x^\\ast)=0', 'F(x^\\ast)=0', 'Formale Gleichung 3.695 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(871, '3.696', 32, 'Gleichung 3.696', '\\det J_F(x^\\ast)\\neq 0', '\\det J_F(x^\\ast)\\neq 0', 'Formale Gleichung 3.696 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(872, '3.697', 32, 'Gleichung 3.697', '\\|x^{(k+1)}-x^\\ast\\|\\leq C\\|x^{(k)}-x^\\ast\\|^2', '\\|x^{(k+1)}-x^\\ast\\|\\leq C\\|x^{(k)}-x^\\ast\\|^2', 'Formale Gleichung 3.697 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(873, '3.698', 32, 'Gleichung 3.698', 'F(x^\\ast)=F(x^{(k)})+J_F(x^{(k)})(x^\\ast-x^{(k)})+R^{(k)}', 'F(x^\\ast)=F(x^{(k)})+J_F(x^{(k)})(x^\\ast-x^{(k)})+R^{(k)}', 'Formale Gleichung 3.698 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(874, '3.699', 32, 'Gleichung 3.699', '\\|R^{(k)}\\|\\leq C_1\\|x^\\ast-x^{(k)}\\|^2', '\\|R^{(k)}\\|\\leq C_1\\|x^\\ast-x^{(k)}\\|^2', 'Formale Gleichung 3.699 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(875, '3.700', 32, 'Gleichung 3.700', 'F(x^\\ast)=0', 'F(x^\\ast)=0', 'Formale Gleichung 3.700 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(876, '3.701', 32, 'Gleichung 3.701', 'J_F(x^{(k)})(x^\\ast-x^{(k)})=-F(x^{(k)})-R^{(k)}', 'J_F(x^{(k)})(x^\\ast-x^{(k)})=-F(x^{(k)})-R^{(k)}', 'Formale Gleichung 3.701 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(877, '3.702', 32, 'Gleichung 3.702', 'J_F(x^{(k)})s^{(k)}=-F(x^{(k)})', 'J_F(x^{(k)})s^{(k)}=-F(x^{(k)})', 'Formale Gleichung 3.702 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(878, '3.703', 32, 'Gleichung 3.703', 'J_F(x^{(k)})(x^\\ast-x^{(k)}-s^{(k)})=-R^{(k)}', 'J_F(x^{(k)})(x^\\ast-x^{(k)}-s^{(k)})=-R^{(k)}', 'Formale Gleichung 3.703 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(879, '3.704', 32, 'Gleichung 3.704', 'x^{(k+1)}=x^{(k)}+s^{(k)}', 'x^{(k+1)}=x^{(k)}+s^{(k)}', 'Formale Gleichung 3.704 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(880, '3.705', 32, 'Gleichung 3.705', 'x^\\ast-x^{(k+1)}=-J_F(x^{(k)})^{-1}R^{(k)}', 'x^\\ast-x^{(k+1)}=-J_F(x^{(k)})^{-1}R^{(k)}', 'Formale Gleichung 3.705 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(881, '3.706', 32, 'Gleichung 3.706', 'f:\\mathbb{R}\\rightarrow\\mathbb{R}', 'f:\\mathbb{R}\\rightarrow\\mathbb{R}', 'Formale Gleichung 3.706 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(882, '3.707', 32, 'Gleichung 3.707', 'x^{(k+1)}=x^{(k)}-\\frac{f(x^{(k)})}{f\'(x^{(k)})}', 'x^{(k+1)}=x^{(k)}-\\frac{f(x^{(k)})}{f\'(x^{(k)})}', 'Formale Gleichung 3.707 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(883, '3.708', 32, 'Gleichung 3.708', 'f\'(x^{(k)})\\neq 0', 'f\'(x^{(k)})\\neq 0', 'Formale Gleichung 3.708 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(884, '3.709', 32, 'Gleichung 3.709', '\\left(x^{(k)},f(x^{(k)})\\right)', '\\left(x^{(k)},f(x^{(k)})\\right)', 'Formale Gleichung 3.709 aus Abschnitt 3.2.18.', 'other', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(885, '3.710', 32, 'Gleichung 3.710', 'x^2-2=0', 'x^2-2=0', 'Formale Gleichung 3.710 aus Abschnitt 3.2.18.', 'other', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(886, '3.711', 32, 'Gleichung 3.711', 'f(x)=x^2-2', 'f(x)=x^2-2', 'Formale Gleichung 3.711 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(887, '3.712', 32, 'Gleichung 3.712', 'f\'(x)=2x', 'f\'(x)=2x', 'Formale Gleichung 3.712 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(888, '3.713', 32, 'Gleichung 3.713', 'x^{(k+1)}=x^{(k)}-\\frac{(x^{(k)})^2-2}{2x^{(k)}}', 'x^{(k+1)}=x^{(k)}-\\frac{(x^{(k)})^2-2}{2x^{(k)}}', 'Formale Gleichung 3.713 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(889, '3.714', 32, 'Gleichung 3.714', 'x^{(k+1)}=\\frac{1}{2}\\left(x^{(k)}+\\frac{2}{x^{(k)}}\\right)', 'x^{(k+1)}=\\frac{1}{2}\\left(x^{(k)}+\\frac{2}{x^{(k)}}\\right)', 'Formale Gleichung 3.714 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(890, '3.715', 32, 'Gleichung 3.715', 'x^{(0)}=1', 'x^{(0)}=1', 'Formale Gleichung 3.715 aus Abschnitt 3.2.18.', 'other', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(891, '3.716', 32, 'Gleichung 3.716', 'x^{(1)}=\\frac{1}{2}\\left(1+\\frac{2}{1}\\right)=1{,}5', 'x^{(1)}=\\frac{1}{2}\\left(1+\\frac{2}{1}\\right)=1{,}5', 'Formale Gleichung 3.716 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(892, '3.717', 32, 'Gleichung 3.717', 'x^{(2)}=\\frac{1}{2}\\left(1{,}5+\\frac{2}{1{,}5}\\right)\\approx1{,}4167', 'x^{(2)}=\\frac{1}{2}\\left(1{,}5+\\frac{2}{1{,}5}\\right)\\approx1{,}4167', 'Formale Gleichung 3.717 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(893, '3.718', 32, 'Gleichung 3.718', 'x^{(3)}\\approx1{,}4142', 'x^{(3)}\\approx1{,}4142', 'Formale Gleichung 3.718 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(894, '3.719', 32, 'Gleichung 3.719', 'x^\\ast=\\sqrt{2}', 'x^\\ast=\\sqrt{2}', 'Formale Gleichung 3.719 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(895, '3.720', 32, 'Gleichung 3.720', 'x^{(k+1)}=x^{(k)}+s^{(k)}', 'x^{(k+1)}=x^{(k)}+s^{(k)}', 'Formale Gleichung 3.720 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(896, '3.721', 32, 'Gleichung 3.721', 'x^{(k+1)}=x^{(k)}+\\alpha_k s^{(k)}', 'x^{(k+1)}=x^{(k)}+\\alpha_k s^{(k)}', 'Formale Gleichung 3.721 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(897, '3.722', 32, 'Gleichung 3.722', '0<\\alpha_k\\leq 1', '0<\\alpha_k\\leq 1', 'Formale Gleichung 3.722 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(898, '3.723', 32, 'Gleichung 3.723', '\\alpha_k=1', '\\alpha_k=1', 'Formale Gleichung 3.723 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(899, '3.724', 32, 'Gleichung 3.724', '0<\\alpha_k<1', '0<\\alpha_k<1', 'Formale Gleichung 3.724 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(900, '3.725', 32, 'Gleichung 3.725', '\\Phi(x)=\\frac{1}{2}\\|F(x)\\|_2^2', '\\Phi(x)=\\frac{1}{2}\\|F(x)\\|_2^2', 'Formale Gleichung 3.725 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(901, '3.726', 32, 'Gleichung 3.726', 'F(x^\\ast)=0\\quad\\Longrightarrow\\quad\\Phi(x^\\ast)=0', 'F(x^\\ast)=0\\quad\\Longrightarrow\\quad\\Phi(x^\\ast)=0', 'Formale Gleichung 3.726 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(902, '3.727', 32, 'Gleichung 3.727', '\\Phi(x^{(k+1)})<\\Phi(x^{(k)})', '\\Phi(x^{(k+1)})<\\Phi(x^{(k)})', 'Formale Gleichung 3.727 aus Abschnitt 3.2.18.', 'metric', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(903, '3.728', 32, 'Gleichung 3.728', '\\Phi(x^{(k)}+\\alpha_k s^{(k)})\\leq\\Phi(x^{(k)})+c\\alpha_k\\nabla\\Phi(x^{(k)})^{\\mathsf T}s^{(k)}', '\\Phi(x^{(k)}+\\alpha_k s^{(k)})\\leq\\Phi(x^{(k)})+c\\alpha_k\\nabla\\Phi(x^{(k)})^{\\mathsf T}s^{(k)}', 'Formale Gleichung 3.728 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(904, '3.729', 32, 'Gleichung 3.729', '0<c<1', '0<c<1', 'Formale Gleichung 3.729 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(905, '3.730', 32, 'Gleichung 3.730', 'J_F(x^{(k)})', 'J_F(x^{(k)})', 'Formale Gleichung 3.730 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(906, '3.731', 32, 'Gleichung 3.731', 'B_k\\approx J_F(x^{(k)})', 'B_k\\approx J_F(x^{(k)})', 'Formale Gleichung 3.731 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(907, '3.732', 32, 'Gleichung 3.732', 'B_k s^{(k)}=-F(x^{(k)})', 'B_k s^{(k)}=-F(x^{(k)})', 'Formale Gleichung 3.732 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(908, '3.733', 32, 'Gleichung 3.733', 'B_{k+1}(x^{(k+1)}-x^{(k)})=F(x^{(k+1)})-F(x^{(k)})', 'B_{k+1}(x^{(k+1)}-x^{(k)})=F(x^{(k+1)})-F(x^{(k)})', 'Formale Gleichung 3.733 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(909, '3.734', 32, 'Gleichung 3.734', '\\frac{\\partial f_i}{\\partial x_j}(x)\\approx\\frac{f_i(x+h e_j)-f_i(x)}{h}', '\\frac{\\partial f_i}{\\partial x_j}(x)\\approx\\frac{f_i(x+h e_j)-f_i(x)}{h}', 'Formale Gleichung 3.734 aus Abschnitt 3.2.18.', 'derived', 'adapted', 74, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(910, '3.735', 32, 'Gleichung 3.735', '\\frac{\\partial f_i}{\\partial x_j}(x)\\approx\\frac{f_i(x+h e_j)-f_i(x-h e_j)}{2h}', '\\frac{\\partial f_i}{\\partial x_j}(x)\\approx\\frac{f_i(x+h e_j)-f_i(x-h e_j)}{2h}', 'Formale Gleichung 3.735 aus Abschnitt 3.2.18.', 'derived', 'adapted', 74, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(911, '3.736', 32, 'Gleichung 3.736', 'h\\ \\text{zu groß}\\quad\\Longrightarrow\\quad\\text{großer Diskretisierungsfehler}', 'h\\ \\text{zu groß}\\quad\\Longrightarrow\\quad\\text{großer Diskretisierungsfehler}', 'Formale Gleichung 3.736 aus Abschnitt 3.2.18.', 'other', 'adapted', 74, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(912, '3.737', 32, 'Gleichung 3.737', 'h\\ \\text{zu klein}\\quad\\Longrightarrow\\quad\\text{großer Rundungsfehler}', 'h\\ \\text{zu klein}\\quad\\Longrightarrow\\quad\\text{großer Rundungsfehler}', 'Formale Gleichung 3.737 aus Abschnitt 3.2.18.', 'other', 'adapted', 74, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(913, '3.738', 32, 'Gleichung 3.738', 'x=G(x)', 'x=G(x)', 'Formale Gleichung 3.738 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(914, '3.739', 32, 'Gleichung 3.739', 'x^{(k+1)}=G(x^{(k)})', 'x^{(k+1)}=G(x^{(k)})', 'Formale Gleichung 3.739 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(915, '3.740', 32, 'Gleichung 3.740', 'G(x^\\ast)=x^\\ast', 'G(x^\\ast)=x^\\ast', 'Formale Gleichung 3.740 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(916, '3.741', 32, 'Gleichung 3.741', '0\\leq q<1', '0\\leq q<1', 'Formale Gleichung 3.741 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(917, '3.742', 32, 'Gleichung 3.742', '\\|G(x)-G(y)\\|\\leq q\\|x-y\\|', '\\|G(x)-G(y)\\|\\leq q\\|x-y\\|', 'Formale Gleichung 3.742 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(918, '3.743', 32, 'Gleichung 3.743', 'x^{(k+1)}=G(x^{(k)})', 'x^{(k+1)}=G(x^{(k)})', 'Formale Gleichung 3.743 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(919, '3.744', 32, 'Gleichung 3.744', '\\|x^{(k)}-x^\\ast\\|\\leq q^k\\|x^{(0)}-x^\\ast\\|', '\\|x^{(k)}-x^\\ast\\|\\leq q^k\\|x^{(0)}-x^\\ast\\|', 'Formale Gleichung 3.744 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(920, '3.745', 32, 'Gleichung 3.745', '\\|x^{(k)}-x^\\ast\\|\\leq\\frac{q}{1-q}\\|x^{(k)}-x^{(k-1)}\\|', '\\|x^{(k)}-x^\\ast\\|\\leq\\frac{q}{1-q}\\|x^{(k)}-x^{(k-1)}\\|', 'Formale Gleichung 3.745 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(921, '3.746', 32, 'Gleichung 3.746', '\\sup_{x\\in D}\\|J_G(x)\\|\\leq q<1', '\\sup_{x\\in D}\\|J_G(x)\\|\\leq q<1', 'Formale Gleichung 3.746 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(922, '3.747', 32, 'Gleichung 3.747', '|G\'(x)|\\leq q<1', '|G\'(x)|\\leq q<1', 'Formale Gleichung 3.747 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(923, '3.748', 32, 'Gleichung 3.748', '|G\'(x^\\ast)|>1', '|G\'(x^\\ast)|>1', 'Formale Gleichung 3.748 aus Abschnitt 3.2.18.', 'theorem', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(924, '3.749', 32, 'Gleichung 3.749', '\\|F(x^{(k)})\\|\\leq\\varepsilon_F', '\\|F(x^{(k)})\\|\\leq\\varepsilon_F', 'Formale Gleichung 3.749 aus Abschnitt 3.2.18.', 'metric', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(925, '3.750', 32, 'Gleichung 3.750', '\\|s^{(k)}\\|\\leq\\varepsilon_x', '\\|s^{(k)}\\|\\leq\\varepsilon_x', 'Formale Gleichung 3.750 aus Abschnitt 3.2.18.', 'metric', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(926, '3.751', 32, 'Gleichung 3.751', '\\frac{\\|s^{(k)}\\|}{\\max\\{1,\\|x^{(k)}\\|\\}}\\leq\\varepsilon_x', '\\frac{\\|s^{(k)}\\|}{\\max\\{1,\\|x^{(k)}\\|\\}}\\leq\\varepsilon_x', 'Formale Gleichung 3.751 aus Abschnitt 3.2.18.', 'metric', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(927, '3.752', 32, 'Gleichung 3.752', 'k\\leq k_{\\max}', 'k\\leq k_{\\max}', 'Formale Gleichung 3.752 aus Abschnitt 3.2.18.', 'metric', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(928, '3.753', 32, 'Gleichung 3.753', '\\det J_F(x^{(k)})=0', '\\det J_F(x^{(k)})=0', 'Formale Gleichung 3.753 aus Abschnitt 3.2.18.', 'other', 'adapted', 74, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(929, '3.754', 32, 'Gleichung 3.754', '\\kappa(J_F(x^{(k)}))', '\\kappa(J_F(x^{(k)}))', 'Formale Gleichung 3.754 aus Abschnitt 3.2.18.', 'metric', 'adapted', 74, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(930, '3.755', 32, 'Gleichung 3.755', '\\delta F\\quad\\Longrightarrow\\quad\\delta s\\ \\text{stark vergrößert}', '\\delta F\\quad\\Longrightarrow\\quad\\delta s\\ \\text{stark vergrößert}', 'Formale Gleichung 3.755 aus Abschnitt 3.2.18.', 'other', 'adapted', 74, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(931, '3.756', 32, 'Gleichung 3.756', 'F(x_1^\\ast)=0,\\qquad F(x_2^\\ast)=0,\\qquad x_1^\\ast\\neq x_2^\\ast', 'F(x_1^\\ast)=0,\\qquad F(x_2^\\ast)=0,\\qquad x_1^\\ast\\neq x_2^\\ast', 'Formale Gleichung 3.756 aus Abschnitt 3.2.18.', 'other', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(932, '3.757', 32, 'Gleichung 3.757', '\\mathcal{B}(x^\\ast)=\\left\\{x^{(0)}\\;\\middle|\\;x^{(k)}\\rightarrow x^\\ast\\right\\}', '\\mathcal{B}(x^\\ast)=\\left\\{x^{(0)}\\;\\middle|\\;x^{(k)}\\rightarrow x^\\ast\\right\\}', 'Formale Gleichung 3.757 aus Abschnitt 3.2.18.', 'other', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(933, '3.758', 32, 'Gleichung 3.758', 'F(x+h)\\approx F(x)+J_F(x)h', 'F(x+h)\\approx F(x)+J_F(x)h', 'Formale Gleichung 3.758 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(934, '3.759', 32, 'Gleichung 3.759', 'x^{(0)}', 'x^{(0)}', 'Formale Gleichung 3.759 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(935, '3.760', 32, 'Gleichung 3.760', '\\varepsilon_F', '\\varepsilon_F', 'Formale Gleichung 3.760 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(936, '3.761', 32, 'Gleichung 3.761', '\\varepsilon_x', '\\varepsilon_x', 'Formale Gleichung 3.761 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(937, '3.762', 32, 'Gleichung 3.762', 'k_{\\max}', 'k_{\\max}', 'Formale Gleichung 3.762 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(938, '3.763', 32, 'Gleichung 3.763', '\\alpha_k', '\\alpha_k', 'Formale Gleichung 3.763 aus Abschnitt 3.2.18.', 'definition', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(939, '3.764', 32, 'Gleichung 3.764', '\\text{nichtlineares Problem}\\quad\\longrightarrow\\quad\\text{lokales lineares Ersatzproblem}', '\\text{nichtlineares Problem}\\quad\\longrightarrow\\quad\\text{lokales lineares Ersatzproblem}', 'Formale Gleichung 3.764 aus Abschnitt 3.2.18.', 'other', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(940, '3.765', 32, 'Gleichung 3.765', 'J_F(x^{(k)})s^{(k)}=-F(x^{(k)})', 'J_F(x^{(k)})s^{(k)}=-F(x^{(k)})', 'Formale Gleichung 3.765 aus Abschnitt 3.2.18.', 'derived', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(941, '3.766', 32, 'Gleichung 3.766', '\\text{Das Verfahren ist definiert.}', '\\text{Das Verfahren ist definiert.}', 'Formale Gleichung 3.766 aus Abschnitt 3.2.18.', 'other', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(942, '3.767', 32, 'Gleichung 3.767', '\\text{Das Verfahren konvergiert.}', '\\text{Das Verfahren konvergiert.}', 'Formale Gleichung 3.767 aus Abschnitt 3.2.18.', 'other', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(943, '3.768', 32, 'Gleichung 3.768', '\\text{Das Verfahren konvergiert zur gewünschten Lösung.}', '\\text{Das Verfahren konvergiert zur gewünschten Lösung.}', 'Formale Gleichung 3.768 aus Abschnitt 3.2.18.', 'other', 'adapted', 78, 'In Abschnitt 3.2.18 definiert oder hergeleitet.', 'Differenzierbarkeit und die jeweils genannten Voraussetzungen.', 'verified', 35),
(976, '3.769', 34, 'Gleichung 3.769', '\\frac{\\mathrm{d}x}{\\mathrm{d}t}=f(t,x)', '\\frac{\\mathrm{d}x}{\\mathrm{d}t}=f(t,x)', 'Formale Gleichung 3.769 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(977, '3.770', 34, 'Gleichung 3.770', 't\\in I\\subseteq\\mathbb{R}', 't\\in I\\subseteq\\mathbb{R}', 'Formale Gleichung 3.770 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(978, '3.771', 34, 'Gleichung 3.771', 'x:I\\rightarrow\\mathbb{R}^{n}', 'x:I\\rightarrow\\mathbb{R}^{n}', 'Formale Gleichung 3.771 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(979, '3.772', 34, 'Gleichung 3.772', 'f:I\\times\\mathbb{R}^{n}\\rightarrow\\mathbb{R}^{n}', 'f:I\\times\\mathbb{R}^{n}\\rightarrow\\mathbb{R}^{n}', 'Formale Gleichung 3.772 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(980, '3.773', 34, 'Gleichung 3.773', '\\dot{x}(t)=\\frac{\\mathrm{d}x(t)}{\\mathrm{d}t}', '\\dot{x}(t)=\\frac{\\mathrm{d}x(t)}{\\mathrm{d}t}', 'Formale Gleichung 3.773 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(981, '3.774', 34, 'Gleichung 3.774', '\\dot{x}=f(t,x)', '\\dot{x}=f(t,x)', 'Formale Gleichung 3.774 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(982, '3.775', 34, 'Gleichung 3.775', '\\dot{x}(t)=f(t,x(t)),\\qquad x(t_0)=x_0', '\\dot{x}(t)=f(t,x(t)),\\qquad x(t_0)=x_0', 'Formale Gleichung 3.775 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(983, '3.776', 34, 'Gleichung 3.776', 't_0\\in I', 't_0\\in I', 'Formale Gleichung 3.776 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(984, '3.777', 34, 'Gleichung 3.777', 'x_0\\in\\mathbb{R}^{n}', 'x_0\\in\\mathbb{R}^{n}', 'Formale Gleichung 3.777 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(985, '3.778', 34, 'Gleichung 3.778', 'x:I\\rightarrow\\mathbb{R}^{n}', 'x:I\\rightarrow\\mathbb{R}^{n}', 'Formale Gleichung 3.778 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(986, '3.779', 34, 'Gleichung 3.779', '\\dot{x}(t)=f(t,x(t))', '\\dot{x}(t)=f(t,x(t))', 'Formale Gleichung 3.779 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(987, '3.780', 34, 'Gleichung 3.780', 'x(t_0)=x_0', 'x(t_0)=x_0', 'Formale Gleichung 3.780 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(988, '3.781', 34, 'Gleichung 3.781', '\\dot{x}(t)=f(t,x(t))', '\\dot{x}(t)=f(t,x(t))', 'Formale Gleichung 3.781 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(989, '3.782', 34, 'Gleichung 3.782', 'x(t)-x(t_0)=\\int_{t_0}^{t}f(\\tau,x(\\tau))\\,\\mathrm{d}\\tau', 'x(t)-x(t_0)=\\int_{t_0}^{t}f(\\tau,x(\\tau))\\,\\mathrm{d}\\tau', 'Formale Gleichung 3.782 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(990, '3.783', 34, 'Gleichung 3.783', 'x(t)=x_0+\\int_{t_0}^{t}f(\\tau,x(\\tau))\\,\\mathrm{d}\\tau', 'x(t)=x_0+\\int_{t_0}^{t}f(\\tau,x(\\tau))\\,\\mathrm{d}\\tau', 'Formale Gleichung 3.783 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(991, '3.784', 34, 'Gleichung 3.784', '\\dot{x}(t)=f(t,x(t)),\\qquad x(t_0)=x_0', '\\dot{x}(t)=f(t,x(t)),\\qquad x(t_0)=x_0', 'Formale Gleichung 3.784 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(992, '3.785', 34, 'Gleichung 3.785', '\\|f(t,x)-f(t,y)\\|\\leq L\\|x-y\\|', '\\|f(t,x)-f(t,y)\\|\\leq L\\|x-y\\|', 'Formale Gleichung 3.785 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(993, '3.786', 34, 'Gleichung 3.786', 'L\\geq 0', 'L\\geq 0', 'Formale Gleichung 3.786 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(994, '3.787', 34, 'Gleichung 3.787', '\\dot{x}=f(x)', '\\dot{x}=f(x)', 'Formale Gleichung 3.787 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(995, '3.788', 34, 'Gleichung 3.788', '\\dot{x}(t)=f(x(t)),\\qquad x(0)=x_0', '\\dot{x}(t)=f(x(t)),\\qquad x(0)=x_0', 'Formale Gleichung 3.788 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(996, '3.789', 34, 'Gleichung 3.789', '\\Phi_t(x_0)=x(t;x_0)', '\\Phi_t(x_0)=x(t;x_0)', 'Formale Gleichung 3.789 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(997, '3.790', 34, 'Gleichung 3.790', 'x(t;x_0)', 'x(t;x_0)', 'Formale Gleichung 3.790 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(998, '3.791', 34, 'Gleichung 3.791', '\\Phi_0(x)=x', '\\Phi_0(x)=x', 'Formale Gleichung 3.791 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(999, '3.792', 34, 'Gleichung 3.792', '\\Phi_{t+s}(x)=\\Phi_t(\\Phi_s(x))', '\\Phi_{t+s}(x)=\\Phi_t(\\Phi_s(x))', 'Formale Gleichung 3.792 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1000, '3.793', 34, 'Gleichung 3.793', '\\mathcal{T}(x_0)=\\left\\{\\Phi_t(x_0)\\;\\middle|\\;t\\in I\\right\\}', '\\mathcal{T}(x_0)=\\left\\{\\Phi_t(x_0)\\;\\middle|\\;t\\in I\\right\\}', 'Formale Gleichung 3.793 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1001, '3.794', 34, 'Gleichung 3.794', '\\dot{x}=f(x)', '\\dot{x}=f(x)', 'Formale Gleichung 3.794 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1002, '3.795', 34, 'Gleichung 3.795', 'f(x^\\ast)=0', 'f(x^\\ast)=0', 'Formale Gleichung 3.795 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1003, '3.796', 34, 'Gleichung 3.796', 'x(0)=x^\\ast\\quad\\Longrightarrow\\quad x(t)=x^\\ast', 'x(0)=x^\\ast\\quad\\Longrightarrow\\quad x(t)=x^\\ast', 'Formale Gleichung 3.796 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1004, '3.797', 34, 'Gleichung 3.797', '\\dot{x}(t)=Ax(t)', '\\dot{x}(t)=Ax(t)', 'Formale Gleichung 3.797 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1005, '3.798', 34, 'Gleichung 3.798', 'A\\in\\mathbb{R}^{n\\times n}', 'A\\in\\mathbb{R}^{n\\times n}', 'Formale Gleichung 3.798 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1006, '3.799', 34, 'Gleichung 3.799', '\\dot{x}(t)=Ax(t),\\qquad x(0)=x_0', '\\dot{x}(t)=Ax(t),\\qquad x(0)=x_0', 'Formale Gleichung 3.799 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1007, '3.800', 34, 'Gleichung 3.800', 'x(t)=\\mathrm{e}^{tA}x_0', 'x(t)=\\mathrm{e}^{tA}x_0', 'Formale Gleichung 3.800 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1008, '3.801', 34, 'Gleichung 3.801', '\\mathrm{e}^{tA}=\\sum_{k=0}^{\\infty}\\frac{t^kA^k}{k!}', '\\mathrm{e}^{tA}=\\sum_{k=0}^{\\infty}\\frac{t^kA^k}{k!}', 'Formale Gleichung 3.801 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1009, '3.802', 34, 'Gleichung 3.802', '\\mathrm{e}^{tA}=I+tA+\\frac{t^2A^2}{2!}+\\frac{t^3A^3}{3!}+\\cdots', '\\mathrm{e}^{tA}=I+tA+\\frac{t^2A^2}{2!}+\\frac{t^3A^3}{3!}+\\cdots', 'Formale Gleichung 3.802 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1010, '3.803', 34, 'Gleichung 3.803', '\\mathrm{e}^{0A}=I', '\\mathrm{e}^{0A}=I', 'Formale Gleichung 3.803 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1011, '3.804', 34, 'Gleichung 3.804', '\\frac{\\mathrm{d}}{\\mathrm{d}t}\\mathrm{e}^{tA}=A\\mathrm{e}^{tA}=\\mathrm{e}^{tA}A', '\\frac{\\mathrm{d}}{\\mathrm{d}t}\\mathrm{e}^{tA}=A\\mathrm{e}^{tA}=\\mathrm{e}^{tA}A', 'Formale Gleichung 3.804 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1012, '3.805', 34, 'Gleichung 3.805', '\\frac{\\mathrm{d}}{\\mathrm{d}t}\\left(\\mathrm{e}^{tA}x_0\\right)=A\\mathrm{e}^{tA}x_0', '\\frac{\\mathrm{d}}{\\mathrm{d}t}\\left(\\mathrm{e}^{tA}x_0\\right)=A\\mathrm{e}^{tA}x_0', 'Formale Gleichung 3.805 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1013, '3.806', 34, 'Gleichung 3.806', 'A=PDP^{-1}', 'A=PDP^{-1}', 'Formale Gleichung 3.806 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1014, '3.807', 34, 'Gleichung 3.807', 'A^k=PD^kP^{-1}', 'A^k=PD^kP^{-1}', 'Formale Gleichung 3.807 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1015, '3.808', 34, 'Gleichung 3.808', '\\mathrm{e}^{tA}=P\\mathrm{e}^{tD}P^{-1}', '\\mathrm{e}^{tA}=P\\mathrm{e}^{tD}P^{-1}', 'Formale Gleichung 3.808 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1016, '3.809', 34, 'Gleichung 3.809', 'D=\\operatorname{diag}(\\lambda_1,\\lambda_2,\\ldots,\\lambda_n)', 'D=\\operatorname{diag}(\\lambda_1,\\lambda_2,\\ldots,\\lambda_n)', 'Formale Gleichung 3.809 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1017, '3.810', 34, 'Gleichung 3.810', '\\mathrm{e}^{tD}=\\operatorname{diag}\\left(\\mathrm{e}^{\\lambda_1t},\\mathrm{e}^{\\lambda_2t},\\ldots,\\mathrm{e}^{\\lambda_nt}\\right)', '\\mathrm{e}^{tD}=\\operatorname{diag}\\left(\\mathrm{e}^{\\lambda_1t},\\mathrm{e}^{\\lambda_2t},\\ldots,\\mathrm{e}^{\\lambda_nt}\\right)', 'Formale Gleichung 3.810 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1018, '3.811', 34, 'Gleichung 3.811', '\\dot{x}(t)=Ax(t)+g(t)', '\\dot{x}(t)=Ax(t)+g(t)', 'Formale Gleichung 3.811 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1019, '3.812', 34, 'Gleichung 3.812', 'x(t_0)=x_0', 'x(t_0)=x_0', 'Formale Gleichung 3.812 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1020, '3.813', 34, 'Gleichung 3.813', 'x(t)=\\mathrm{e}^{(t-t_0)A}x_0+\\int_{t_0}^{t}\\mathrm{e}^{(t-\\tau)A}g(\\tau)\\,\\mathrm{d}\\tau', 'x(t)=\\mathrm{e}^{(t-t_0)A}x_0+\\int_{t_0}^{t}\\mathrm{e}^{(t-\\tau)A}g(\\tau)\\,\\mathrm{d}\\tau', 'Formale Gleichung 3.813 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1021, '3.814', 34, 'Gleichung 3.814', '\\varepsilon>0', '\\varepsilon>0', 'Formale Gleichung 3.814 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1022, '3.815', 34, 'Gleichung 3.815', '\\delta>0', '\\delta>0', 'Formale Gleichung 3.815 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1023, '3.816', 34, 'Gleichung 3.816', '\\|x(0)-x^\\ast\\|<\\delta', '\\|x(0)-x^\\ast\\|<\\delta', 'Formale Gleichung 3.816 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1024, '3.817', 34, 'Gleichung 3.817', '\\|x(t)-x^\\ast\\|<\\varepsilon', '\\|x(t)-x^\\ast\\|<\\varepsilon', 'Formale Gleichung 3.817 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1025, '3.818', 34, 'Gleichung 3.818', 'x(t)\\rightarrow x^\\ast\\qquad\\text{für }t\\rightarrow\\infty', 'x(t)\\rightarrow x^\\ast\\qquad\\text{für }t\\rightarrow\\infty', 'Formale Gleichung 3.818 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1026, '3.819', 34, 'Gleichung 3.819', '\\text{kleine Abweichungen bleiben klein}', '\\text{kleine Abweichungen bleiben klein}', 'Formale Gleichung 3.819 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1027, '3.820', 34, 'Gleichung 3.820', '\\text{kleine Abweichungen verschwinden langfristig}', '\\text{kleine Abweichungen verschwinden langfristig}', 'Formale Gleichung 3.820 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1028, '3.821', 34, 'Gleichung 3.821', '\\dot{x}=Ax', '\\dot{x}=Ax', 'Formale Gleichung 3.821 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1029, '3.822', 34, 'Gleichung 3.822', 'x^\\ast=0', 'x^\\ast=0', 'Formale Gleichung 3.822 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1030, '3.823', 34, 'Gleichung 3.823', '\\operatorname{Re}(\\lambda_i)<0\\qquad\\text{für alle }i', '\\operatorname{Re}(\\lambda_i)<0\\qquad\\text{für alle }i', 'Formale Gleichung 3.823 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1031, '3.824', 34, 'Gleichung 3.824', '\\operatorname{Re}(\\lambda_i)>0', '\\operatorname{Re}(\\lambda_i)>0', 'Formale Gleichung 3.824 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1032, '3.825', 34, 'Gleichung 3.825', '\\mathrm{e}^{\\lambda_i t}', '\\mathrm{e}^{\\lambda_i t}', 'Formale Gleichung 3.825 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1033, '3.826', 34, 'Gleichung 3.826', '\\operatorname{Re}(\\lambda_i)<0', '\\operatorname{Re}(\\lambda_i)<0', 'Formale Gleichung 3.826 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1034, '3.827', 34, 'Gleichung 3.827', '\\left|\\mathrm{e}^{\\lambda_i t}\\right|=\\mathrm{e}^{\\operatorname{Re}(\\lambda_i)t}\\rightarrow 0', '\\left|\\mathrm{e}^{\\lambda_i t}\\right|=\\mathrm{e}^{\\operatorname{Re}(\\lambda_i)t}\\rightarrow 0', 'Formale Gleichung 3.827 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1035, '3.828', 34, 'Gleichung 3.828', '\\dot{x}=f(x)', '\\dot{x}=f(x)', 'Formale Gleichung 3.828 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1036, '3.829', 34, 'Gleichung 3.829', 'f(x^\\ast)=0', 'f(x^\\ast)=0', 'Formale Gleichung 3.829 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1037, '3.830', 34, 'Gleichung 3.830', '\\xi=x-x^\\ast', '\\xi=x-x^\\ast', 'Formale Gleichung 3.830 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1038, '3.831', 34, 'Gleichung 3.831', 'f(x^\\ast+\\xi)\\approx f(x^\\ast)+J_f(x^\\ast)\\xi', 'f(x^\\ast+\\xi)\\approx f(x^\\ast)+J_f(x^\\ast)\\xi', 'Formale Gleichung 3.831 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1039, '3.832', 34, 'Gleichung 3.832', '\\dot{\\xi}\\approx J_f(x^\\ast)\\xi', '\\dot{\\xi}\\approx J_f(x^\\ast)\\xi', 'Formale Gleichung 3.832 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1040, '3.833', 34, 'Gleichung 3.833', 'A=J_f(x^\\ast)', 'A=J_f(x^\\ast)', 'Formale Gleichung 3.833 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1041, '3.834', 34, 'Gleichung 3.834', '\\dot{x}=f(x)', '\\dot{x}=f(x)', 'Formale Gleichung 3.834 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1042, '3.835', 34, 'Gleichung 3.835', 'J_f(x^\\ast)', 'J_f(x^\\ast)', 'Formale Gleichung 3.835 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1043, '3.836', 34, 'Gleichung 3.836', '\\operatorname{Re}(\\lambda_i)\\neq 0\\qquad\\text{für alle }i', '\\operatorname{Re}(\\lambda_i)\\neq 0\\qquad\\text{für alle }i', 'Formale Gleichung 3.836 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1044, '3.837', 34, 'Gleichung 3.837', 't_k=t_0+kh', 't_k=t_0+kh', 'Formale Gleichung 3.837 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1045, '3.838', 34, 'Gleichung 3.838', 'h>0', 'h>0', 'Formale Gleichung 3.838 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1046, '3.839', 34, 'Gleichung 3.839', 'x^{(k)}\\approx x(t_k)', 'x^{(k)}\\approx x(t_k)', 'Formale Gleichung 3.839 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1047, '3.840', 34, 'Gleichung 3.840', '\\dot{x}(t_k)\\approx\\frac{x(t_{k+1})-x(t_k)}{h}', '\\dot{x}(t_k)\\approx\\frac{x(t_{k+1})-x(t_k)}{h}', 'Formale Gleichung 3.840 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1048, '3.841', 34, 'Gleichung 3.841', '\\dot{x}(t_k)=f(t_k,x(t_k))', '\\dot{x}(t_k)=f(t_k,x(t_k))', 'Formale Gleichung 3.841 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1049, '3.842', 34, 'Gleichung 3.842', 'x(t_{k+1})\\approx x(t_k)+hf(t_k,x(t_k))', 'x(t_{k+1})\\approx x(t_k)+hf(t_k,x(t_k))', 'Formale Gleichung 3.842 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1050, '3.843', 34, 'Gleichung 3.843', 'x^{(k+1)}=x^{(k)}+hf(t_k,x^{(k)})', 'x^{(k+1)}=x^{(k)}+hf(t_k,x^{(k)})', 'Formale Gleichung 3.843 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1051, '3.844', 34, 'Gleichung 3.844', 'x^{(k+1)}=x^{(k)}+hf(t_{k+1},x^{(k+1)})', 'x^{(k+1)}=x^{(k)}+hf(t_{k+1},x^{(k+1)})', 'Formale Gleichung 3.844 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1052, '3.845', 34, 'Gleichung 3.845', 'G(x^{(k+1)})=x^{(k+1)}-x^{(k)}-hf(t_{k+1},x^{(k+1)})=0', 'G(x^{(k+1)})=x^{(k+1)}-x^{(k)}-hf(t_{k+1},x^{(k+1)})=0', 'Formale Gleichung 3.845 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1053, '3.846', 34, 'Gleichung 3.846', 'x(t_{k+1})=x(t_k)+h\\dot{x}(t_k)+\\frac{h^2}{2}\\ddot{x}(\\xi_k)', 'x(t_{k+1})=x(t_k)+h\\dot{x}(t_k)+\\frac{h^2}{2}\\ddot{x}(\\xi_k)', 'Formale Gleichung 3.846 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1054, '3.847', 34, 'Gleichung 3.847', '\\xi_k\\in(t_k,t_{k+1})', '\\xi_k\\in(t_k,t_{k+1})', 'Formale Gleichung 3.847 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1055, '3.848', 34, 'Gleichung 3.848', '\\mathcal{O}(h^2)', '\\mathcal{O}(h^2)', 'Formale Gleichung 3.848 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1056, '3.849', 34, 'Gleichung 3.849', '\\mathcal{O}(h)', '\\mathcal{O}(h)', 'Formale Gleichung 3.849 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1057, '3.850', 34, 'Gleichung 3.850', 'h\\rightarrow 0', 'h\\rightarrow 0', 'Formale Gleichung 3.850 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1058, '3.851', 34, 'Gleichung 3.851', '\\tau_k\\rightarrow 0\\qquad\\text{für }h\\rightarrow 0', '\\tau_k\\rightarrow 0\\qquad\\text{für }h\\rightarrow 0', 'Formale Gleichung 3.851 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1059, '3.852', 34, 'Gleichung 3.852', '\\max_{0\\leq k\\leq N}\\|x(t_k)-x^{(k)}\\|\\rightarrow 0\\qquad\\text{für }h\\rightarrow 0', '\\max_{0\\leq k\\leq N}\\|x(t_k)-x^{(k)}\\|\\rightarrow 0\\qquad\\text{für }h\\rightarrow 0', 'Formale Gleichung 3.852 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1060, '3.853', 34, 'Gleichung 3.853', 'Nh=T-t_0', 'Nh=T-t_0', 'Formale Gleichung 3.853 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1061, '3.854', 34, 'Gleichung 3.854', '\\dot{x}=\\lambda x', '\\dot{x}=\\lambda x', 'Formale Gleichung 3.854 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1062, '3.855', 34, 'Gleichung 3.855', 'x(t)=\\mathrm{e}^{\\lambda t}x_0', 'x(t)=\\mathrm{e}^{\\lambda t}x_0', 'Formale Gleichung 3.855 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1063, '3.856', 34, 'Gleichung 3.856', 'x^{(k+1)}=x^{(k)}+h\\lambda x^{(k)}', 'x^{(k+1)}=x^{(k)}+h\\lambda x^{(k)}', 'Formale Gleichung 3.856 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1064, '3.857', 34, 'Gleichung 3.857', 'x^{(k+1)}=(1+h\\lambda)x^{(k)}', 'x^{(k+1)}=(1+h\\lambda)x^{(k)}', 'Formale Gleichung 3.857 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1065, '3.858', 34, 'Gleichung 3.858', 'x^{(k)}=(1+h\\lambda)^kx^{(0)}', 'x^{(k)}=(1+h\\lambda)^kx^{(0)}', 'Formale Gleichung 3.858 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1066, '3.859', 34, 'Gleichung 3.859', '|1+h\\lambda|<1', '|1+h\\lambda|<1', 'Formale Gleichung 3.859 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1067, '3.860', 34, 'Gleichung 3.860', '|1+h\\lambda|<1', '|1+h\\lambda|<1', 'Formale Gleichung 3.860 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1068, '3.861', 34, 'Gleichung 3.861', '0<h<\\frac{2}{|\\lambda|}', '0<h<\\frac{2}{|\\lambda|}', 'Formale Gleichung 3.861 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1069, '3.862', 34, 'Gleichung 3.862', '\\dot{x}=Ax', '\\dot{x}=Ax', 'Formale Gleichung 3.862 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1070, '3.863', 34, 'Gleichung 3.863', '|\\operatorname{Re}(\\lambda_{\\max})|\\gg|\\operatorname{Re}(\\lambda_{\\min})|', '|\\operatorname{Re}(\\lambda_{\\max})|\\gg|\\operatorname{Re}(\\lambda_{\\min})|', 'Formale Gleichung 3.863 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1071, '3.864', 34, 'Gleichung 3.864', 'k_1=f(t_k,x^{(k)})', 'k_1=f(t_k,x^{(k)})', 'Formale Gleichung 3.864 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1072, '3.865', 34, 'Gleichung 3.865', 'k_2=f\\left(t_k+\\frac{h}{2},x^{(k)}+\\frac{h}{2}k_1\\right)', 'k_2=f\\left(t_k+\\frac{h}{2},x^{(k)}+\\frac{h}{2}k_1\\right)', 'Formale Gleichung 3.865 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1073, '3.866', 34, 'Gleichung 3.866', 'k_3=f\\left(t_k+\\frac{h}{2},x^{(k)}+\\frac{h}{2}k_2\\right)', 'k_3=f\\left(t_k+\\frac{h}{2},x^{(k)}+\\frac{h}{2}k_2\\right)', 'Formale Gleichung 3.866 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1074, '3.867', 34, 'Gleichung 3.867', 'k_4=f\\left(t_k+h,x^{(k)}+hk_3\\right)', 'k_4=f\\left(t_k+h,x^{(k)}+hk_3\\right)', 'Formale Gleichung 3.867 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1075, '3.868', 34, 'Gleichung 3.868', 'x^{(k+1)}=x^{(k)}+\\frac{h}{6}(k_1+2k_2+2k_3+k_4)', 'x^{(k+1)}=x^{(k)}+\\frac{h}{6}(k_1+2k_2+2k_3+k_4)', 'Formale Gleichung 3.868 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1076, '3.869', 34, 'Gleichung 3.869', '\\mathcal{O}(h^4)', '\\mathcal{O}(h^4)', 'Formale Gleichung 3.869 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1077, '3.870', 34, 'Gleichung 3.870', 'E_k', 'E_k', 'Formale Gleichung 3.870 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1078, '3.871', 34, 'Gleichung 3.871', 'h_{\\mathrm{neu}}=h_{\\mathrm{alt}}\\left(\\frac{\\mathrm{TOL}}{E_k}\\right)^{\\frac{1}{p+1}}', 'h_{\\mathrm{neu}}=h_{\\mathrm{alt}}\\left(\\frac{\\mathrm{TOL}}{E_k}\\right)^{\\frac{1}{p+1}}', 'Formale Gleichung 3.871 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1079, '3.872', 34, 'Gleichung 3.872', '\\mathrm{TOL}>0', '\\mathrm{TOL}>0', 'Formale Gleichung 3.872 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1080, '3.873', 34, 'Gleichung 3.873', 'h_{\\mathrm{neu}}=\\eta h_{\\mathrm{alt}}\\left(\\frac{\\mathrm{TOL}}{E_k}\\right)^{\\frac{1}{p+1}},\\qquad 0<\\eta<1', 'h_{\\mathrm{neu}}=\\eta h_{\\mathrm{alt}}\\left(\\frac{\\mathrm{TOL}}{E_k}\\right)^{\\frac{1}{p+1}},\\qquad 0<\\eta<1', 'Formale Gleichung 3.873 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1081, '3.874', 34, 'Gleichung 3.874', '\\dot{x}=f(t,x),\\qquad x(t_0)=x_0', '\\dot{x}=f(t,x),\\qquad x(t_0)=x_0', 'Formale Gleichung 3.874 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1082, '3.875', 34, 'Gleichung 3.875', 'S(t)=\\frac{\\partial x(t;x_0)}{\\partial x_0}', 'S(t)=\\frac{\\partial x(t;x_0)}{\\partial x_0}', 'Formale Gleichung 3.875 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1083, '3.876', 34, 'Gleichung 3.876', '\\dot{S}(t)=J_f(t,x(t))S(t)', '\\dot{S}(t)=J_f(t,x(t))S(t)', 'Formale Gleichung 3.876 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1084, '3.877', 34, 'Gleichung 3.877', 'S(t_0)=I', 'S(t_0)=I', 'Formale Gleichung 3.877 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1085, '3.878', 34, 'Gleichung 3.878', '\\dot{x}=f(t,x)', '\\dot{x}=f(t,x)', 'Formale Gleichung 3.878 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1086, '3.879', 34, 'Gleichung 3.879', '\\text{lokale Änderungsregel}', '\\text{lokale Änderungsregel}', 'Formale Gleichung 3.879 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1087, '3.880', 34, 'Gleichung 3.880', '\\text{Anfangszustand}', '\\text{Anfangszustand}', 'Formale Gleichung 3.880 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1088, '3.881', 34, 'Gleichung 3.881', '\\text{resultierende Trajektorie}', '\\text{resultierende Trajektorie}', 'Formale Gleichung 3.881 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1089, '3.882', 34, 'Gleichung 3.882', 't_0', 't_0', 'Formale Gleichung 3.882 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1090, '3.883', 34, 'Gleichung 3.883', 'x_0', 'x_0', 'Formale Gleichung 3.883 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1091, '3.884', 34, 'Gleichung 3.884', 'h', 'h', 'Formale Gleichung 3.884 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1092, '3.885', 34, 'Gleichung 3.885', '\\mathrm{TOL}', '\\mathrm{TOL}', 'Formale Gleichung 3.885 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1093, '3.886', 34, 'Gleichung 3.886', 'T', 'T', 'Formale Gleichung 3.886 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1094, '3.887', 34, 'Gleichung 3.887', '\\dot{x}(t)=f(t,x(t))', '\\dot{x}(t)=f(t,x(t))', 'Formale Gleichung 3.887 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1095, '3.888', 34, 'Gleichung 3.888', 'x(t)=x_0+\\int_{t_0}^{t}f(\\tau,x(\\tau))\\,\\mathrm{d}\\tau', 'x(t)=x_0+\\int_{t_0}^{t}f(\\tau,x(\\tau))\\,\\mathrm{d}\\tau', 'Formale Gleichung 3.888 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1096, '3.889', 34, 'Gleichung 3.889', '\\text{kontinuierliche Differentialgleichung}\\neq\\text{diskretes Rechenverfahren}', '\\text{kontinuierliche Differentialgleichung}\\neq\\text{diskretes Rechenverfahren}', 'Formale Gleichung 3.889 aus Abschnitt 3.2.19.', 'other', 'adapted', 80, 'In Abschnitt 3.2.19 verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.19.', 'verified', 37),
(1103, '3.1000', 35, 'Gleichung 3.1000', '\\|u(t_2)\\|_{L^2(\\Omega)}\\leq\\|u(t_1)\\|_{L^2(\\Omega)}', '\\|u(t_2)\\|_{L^2(\\Omega)}\\leq\\|u(t_1)\\|_{L^2(\\Omega)}', 'Formale Gleichung 3.1000 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1104, '3.1001', 35, 'Gleichung 3.1001', 't_2\\geq t_1\\geq0', 't_2\\geq t_1\\geq0', 'Formale Gleichung 3.1001 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1105, '3.1002', 35, 'Gleichung 3.1002', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u\\leq0', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u\\leq0', 'Formale Gleichung 3.1002 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1106, '3.1003', 35, 'Gleichung 3.1003', '(0,T]\\times\\Omega', '(0,T]\\times\\Omega', 'Formale Gleichung 3.1003 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1107, '3.1004', 35, 'Gleichung 3.1004', '\\max_{[0,T]\\times\\overline{\\Omega}}u=\\max_{\\Gamma_P}u', '\\max_{[0,T]\\times\\overline{\\Omega}}u=\\max_{\\Gamma_P}u', 'Formale Gleichung 3.1004 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1108, '3.1005', 35, 'Gleichung 3.1005', '\\Gamma_P=\\left(\\{0\\}\\times\\overline{\\Omega}\\right)\\cup\\left([0,T]\\times\\partial\\Omega\\right)', '\\Gamma_P=\\left(\\{0\\}\\times\\overline{\\Omega}\\right)\\cup\\left([0,T]\\times\\partial\\Omega\\right)', 'Formale Gleichung 3.1005 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1109, '3.1006', 35, 'Gleichung 3.1006', '[a,b]', '[a,b]', 'Formale Gleichung 3.1006 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1110, '3.1007', 35, 'Gleichung 3.1007', 'x_i=a+i\\Delta x', 'x_i=a+i\\Delta x', 'Formale Gleichung 3.1007 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1111, '3.1008', 35, 'Gleichung 3.1008', '\\Delta x=\\frac{b-a}{N}', '\\Delta x=\\frac{b-a}{N}', 'Formale Gleichung 3.1008 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1112, '3.1009', 35, 'Gleichung 3.1009', '\\frac{\\partial^{2}u}{\\partial x^{2}}(x_i)\\approx\\frac{u(x_{i+1})-2u(x_i)+u(x_{i-1})}{(\\Delta x)^2}', '\\frac{\\partial^{2}u}{\\partial x^{2}}(x_i)\\approx\\frac{u(x_{i+1})-2u(x_i)+u(x_{i-1})}{(\\Delta x)^2}', 'Formale Gleichung 3.1009 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1113, '3.1010', 35, 'Gleichung 3.1010', 'u_i^{(k+1)}=u_i^{(k)}+\\mu\\left(u_{i+1}^{(k)}-2u_i^{(k)}+u_{i-1}^{(k)}\\right)', 'u_i^{(k+1)}=u_i^{(k)}+\\mu\\left(u_{i+1}^{(k)}-2u_i^{(k)}+u_{i-1}^{(k)}\\right)', 'Formale Gleichung 3.1010 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1114, '3.1011', 35, 'Gleichung 3.1011', '\\mu=\\frac{\\kappa\\Delta t}{(\\Delta x)^2}', '\\mu=\\frac{\\kappa\\Delta t}{(\\Delta x)^2}', 'Formale Gleichung 3.1011 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1115, '3.1012', 35, 'Gleichung 3.1012', '0\\leq\\mu\\leq\\frac{1}{2}', '0\\leq\\mu\\leq\\frac{1}{2}', 'Formale Gleichung 3.1012 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1116, '3.1013', 35, 'Gleichung 3.1013', '\\Delta t\\leq\\frac{(\\Delta x)^2}{2\\kappa}', '\\Delta t\\leq\\frac{(\\Delta x)^2}{2\\kappa}', 'Formale Gleichung 3.1013 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1117, '3.1014', 35, 'Gleichung 3.1014', '\\frac{\\mathrm{d}U}{\\mathrm{d}t}=F(t,U)', '\\frac{\\mathrm{d}U}{\\mathrm{d}t}=F(t,U)', 'Formale Gleichung 3.1014 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1118, '3.1015', 35, 'Gleichung 3.1015', 'U(t)=\\begin{pmatrix}u_1(t)\\\\u_2(t)\\\\\\vdots\\\\u_N(t)\\ \\end{pmatrix}', 'U(t)=\\begin{pmatrix}u_1(t)\\\\u_2(t)\\\\\\vdots\\\\u_N(t)\\ \\end{pmatrix}', 'Formale Gleichung 3.1015 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1119, '3.1016', 35, 'Gleichung 3.1016', '\\text{partielle Differentialgleichung}', '\\text{partielle Differentialgleichung}', 'Formale Gleichung 3.1016 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1120, '3.1017', 35, 'Gleichung 3.1017', '\\longrightarrow\\text{räumliche Diskretisierung}', '\\longrightarrow\\text{räumliche Diskretisierung}', 'Formale Gleichung 3.1017 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1121, '3.1018', 35, 'Gleichung 3.1018', '\\longrightarrow\\text{gewöhnliches Differentialgleichungssystem}', '\\longrightarrow\\text{gewöhnliches Differentialgleichungssystem}', 'Formale Gleichung 3.1018 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1122, '3.1019', 35, 'Gleichung 3.1019', '\\longrightarrow\\text{numerische Zeitintegration}', '\\longrightarrow\\text{numerische Zeitintegration}', 'Formale Gleichung 3.1019 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1123, '3.1020', 35, 'Gleichung 3.1020', 'u(t)\\in X', 'u(t)\\in X', 'Formale Gleichung 3.1020 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1124, '3.1021', 35, 'Gleichung 3.1021', 'X=L^2(\\Omega)', 'X=L^2(\\Omega)', 'Formale Gleichung 3.1021 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1125, '3.1022', 35, 'Gleichung 3.1022', 'X=H^1(\\Omega)', 'X=H^1(\\Omega)', 'Formale Gleichung 3.1022 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1126, '3.1023', 35, 'Gleichung 3.1023', 'X=C(\\overline{\\Omega})', 'X=C(\\overline{\\Omega})', 'Formale Gleichung 3.1023 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1127, '3.1024', 35, 'Gleichung 3.1024', '\\frac{\\mathrm{d}u}{\\mathrm{d}t}=\\mathcal{A}u+\\mathcal{N}(u)', '\\frac{\\mathrm{d}u}{\\mathrm{d}t}=\\mathcal{A}u+\\mathcal{N}(u)', 'Formale Gleichung 3.1024 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1128, '3.1025', 35, 'Gleichung 3.1025', '\\mathcal{A}:D(\\mathcal{A})\\subseteq X\\rightarrow X', '\\mathcal{A}:D(\\mathcal{A})\\subseteq X\\rightarrow X', 'Formale Gleichung 3.1025 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1129, '3.1026', 35, 'Gleichung 3.1026', '\\mathcal{N}:X\\rightarrow X', '\\mathcal{N}:X\\rightarrow X', 'Formale Gleichung 3.1026 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1130, '3.1027', 35, 'Gleichung 3.1027', 'u:\\Omega\\rightarrow V', 'u:\\Omega\\rightarrow V', 'Formale Gleichung 3.1027 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1131, '3.1028', 35, 'Gleichung 3.1028', 'u:[0,T]\\times\\Omega\\rightarrow V', 'u:[0,T]\\times\\Omega\\rightarrow V', 'Formale Gleichung 3.1028 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1132, '3.1029', 35, 'Gleichung 3.1029', 'u(t,\\cdot)', 'u(t,\\cdot)', 'Formale Gleichung 3.1029 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1133, '3.1030', 35, 'Gleichung 3.1030', '\\text{lokale Zustandsänderung}+\\text{räumliche Kopplung}=\\text{äußere und innere Einwirkung}', '\\text{lokale Zustandsänderung}+\\text{räumliche Kopplung}=\\text{äußere und innere Einwirkung}', 'Formale Gleichung 3.1030 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1134, '3.1031', 35, 'Gleichung 3.1031', '\\Omega', '\\Omega', 'Formale Gleichung 3.1031 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1135, '3.1032', 35, 'Gleichung 3.1032', '\\partial\\Omega', '\\partial\\Omega', 'Formale Gleichung 3.1032 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1136, '3.1033', 35, 'Gleichung 3.1033', 'u_0', 'u_0', 'Formale Gleichung 3.1033 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1137, '3.1034', 35, 'Gleichung 3.1034', '\\text{Randbedingungen}', '\\text{Randbedingungen}', 'Formale Gleichung 3.1034 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1138, '3.1035', 35, 'Gleichung 3.1035', '\\text{Koeffizienten}', '\\text{Koeffizienten}', 'Formale Gleichung 3.1035 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1139, '3.1036', 35, 'Gleichung 3.1036', '\\text{Lösungsbegriff}', '\\text{Lösungsbegriff}', 'Formale Gleichung 3.1036 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1140, '3.1037', 35, 'Gleichung 3.1037', '\\text{klassischer Lösung}', '\\text{klassischer Lösung}', 'Formale Gleichung 3.1037 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1141, '3.1038', 35, 'Gleichung 3.1038', '\\text{schwacher Lösung}', '\\text{schwacher Lösung}', 'Formale Gleichung 3.1038 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1142, '3.1039', 35, 'Gleichung 3.1039', '\\text{numerischer Näherung}', '\\text{numerischer Näherung}', 'Formale Gleichung 3.1039 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1143, '3.1040', 35, 'Gleichung 3.1040', '\\frac{\\partial u}{\\partial t}=\\mathcal{D}(u)+\\mathcal{R}(u)+\\mathcal{E}(t,\\xi)', '\\frac{\\partial u}{\\partial t}=\\mathcal{D}(u)+\\mathcal{R}(u)+\\mathcal{E}(t,\\xi)', 'Formale Gleichung 3.1040 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1144, '3.1041', 35, 'Gleichung 3.1041', '\\mathcal{D}(u)', '\\mathcal{D}(u)', 'Formale Gleichung 3.1041 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1145, '3.1042', 35, 'Gleichung 3.1042', '\\mathcal{R}(u)', '\\mathcal{R}(u)', 'Formale Gleichung 3.1042 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1146, '3.1043', 35, 'Gleichung 3.1043', '\\mathcal{E}(t,\\xi)', '\\mathcal{E}(t,\\xi)', 'Formale Gleichung 3.1043 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1147, '3.1044', 35, 'Gleichung 3.1044', 'x(t)=\\begin{pmatrix}x_1(t)\\\\x_2(t)\\\\\\vdots\\\\x_n(t)\\ \\end{pmatrix}', 'x(t)=\\begin{pmatrix}x_1(t)\\\\x_2(t)\\\\\\vdots\\\\x_n(t)\\ \\end{pmatrix}', 'Formale Gleichung 3.1044 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1148, '3.1045', 35, 'Gleichung 3.1045', 'u(t)=u(t,\\cdot)', 'u(t)=u(t,\\cdot)', 'Formale Gleichung 3.1045 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1149, '3.1046', 35, 'Gleichung 3.1046', '\\text{endlichdimensionaler Zustandsvektor}\\longrightarrow\\text{unendlichdimensionaler Feldzustand}', '\\text{endlichdimensionaler Zustandsvektor}\\longrightarrow\\text{unendlichdimensionaler Feldzustand}', 'Formale Gleichung 3.1046 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1150, '3.1047', 35, 'Gleichung 3.1047', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0', 'Formale Gleichung 3.1047 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1151, '3.1048', 35, 'Gleichung 3.1048', '\\text{Feldgleichung}+\\text{Zustandsraum}+\\text{Anfangsdaten}+\\text{Randbedingungen}+\\text{Lösungsbegriff}', '\\text{Feldgleichung}+\\text{Zustandsraum}+\\text{Anfangsdaten}+\\text{Randbedingungen}+\\text{Lösungsbegriff}', 'Formale Gleichung 3.1048 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1152, '3.890', 35, 'Gleichung 3.890', 'x(t)\\in\\mathbb{R}^{n}', 'x(t)\\in\\mathbb{R}^{n}', 'Formale Gleichung 3.890 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1153, '3.891', 35, 'Gleichung 3.891', 'u(t,\\xi)', 'u(t,\\xi)', 'Formale Gleichung 3.891 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1154, '3.892', 35, 'Gleichung 3.892', 'u:\\Omega\\rightarrow\\mathbb{R}', 'u:\\Omega\\rightarrow\\mathbb{R}', 'Formale Gleichung 3.892 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1155, '3.893', 35, 'Gleichung 3.893', '\\Omega\\subseteq\\mathbb{R}^{d}', '\\Omega\\subseteq\\mathbb{R}^{d}', 'Formale Gleichung 3.893 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1156, '3.894', 35, 'Gleichung 3.894', 'F\\left(\\xi,u,\\nabla u,\\nabla^{2}u,\\ldots,\\nabla^{m}u\\right)=0', 'F\\left(\\xi,u,\\nabla u,\\nabla^{2}u,\\ldots,\\nabla^{m}u\\right)=0', 'Formale Gleichung 3.894 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1157, '3.895', 35, 'Gleichung 3.895', '\\xi=\\begin{pmatrix}\\xi_1\\\\\\xi_2\\\\\\vdots\\\\\\xi_d\\ \\end{pmatrix}\\in\\Omega', '\\xi=\\begin{pmatrix}\\xi_1\\\\\\xi_2\\\\\\vdots\\\\\\xi_d\\ \\end{pmatrix}\\in\\Omega', 'Formale Gleichung 3.895 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1158, '3.896', 35, 'Gleichung 3.896', '\\frac{\\partial u}{\\partial \\xi_i}(\\xi)=\\lim_{h\\rightarrow0}\\frac{u(\\xi+he_i)-u(\\xi)}{h}', '\\frac{\\partial u}{\\partial \\xi_i}(\\xi)=\\lim_{h\\rightarrow0}\\frac{u(\\xi+he_i)-u(\\xi)}{h}', 'Formale Gleichung 3.896 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1159, '3.897', 35, 'Gleichung 3.897', 'e_i=\\begin{pmatrix}0\\\\\\vdots\\\\1\\\\\\vdots\\\\0\\ \\end{pmatrix}', 'e_i=\\begin{pmatrix}0\\\\\\vdots\\\\1\\\\\\vdots\\\\0\\ \\end{pmatrix}', 'Formale Gleichung 3.897 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1160, '3.898', 35, 'Gleichung 3.898', 'u:\\Omega\\subseteq\\mathbb{R}^{d}\\rightarrow\\mathbb{R}', 'u:\\Omega\\subseteq\\mathbb{R}^{d}\\rightarrow\\mathbb{R}', 'Formale Gleichung 3.898 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(1161, '3.899', 35, 'Gleichung 3.899', '\\nabla u=\\begin{pmatrix}\\frac{\\partial u}{\\partial \\xi_1}\\\\\\frac{\\partial u}{\\partial \\xi_2}\\\\\\vdots\\\\\\frac{\\partial u}{\\partial \\xi_d}\\ \\end{pmatrix}', '\\nabla u=\\begin{pmatrix}\\frac{\\partial u}{\\partial \\xi_1}\\\\\\frac{\\partial u}{\\partial \\xi_2}\\\\\\vdots\\\\\\frac{\\partial u}{\\partial \\xi_d}\\ \\end{pmatrix}', 'Formale Gleichung 3.899 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1162, '3.900', 35, 'Gleichung 3.900', 'v\\in\\mathbb{R}^{d},\\qquad\\|v\\|=1', 'v\\in\\mathbb{R}^{d},\\qquad\\|v\\|=1', 'Formale Gleichung 3.900 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1163, '3.901', 35, 'Gleichung 3.901', 'D_vu=\\nabla u\\cdot v', 'D_vu=\\nabla u\\cdot v', 'Formale Gleichung 3.901 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1164, '3.902', 35, 'Gleichung 3.902', 'q:\\Omega\\subseteq\\mathbb{R}^{d}\\rightarrow\\mathbb{R}^{d}', 'q:\\Omega\\subseteq\\mathbb{R}^{d}\\rightarrow\\mathbb{R}^{d}', 'Formale Gleichung 3.902 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1165, '3.903', 35, 'Gleichung 3.903', 'q=\\begin{pmatrix}q_1\\\\q_2\\\\\\vdots\\\\q_d\\ \\end{pmatrix}', 'q=\\begin{pmatrix}q_1\\\\q_2\\\\\\vdots\\\\q_d\\ \\end{pmatrix}', 'Formale Gleichung 3.903 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1166, '3.904', 35, 'Gleichung 3.904', '\\nabla\\cdot q=\\sum_{i=1}^{d}\\frac{\\partial q_i}{\\partial \\xi_i}', '\\nabla\\cdot q=\\sum_{i=1}^{d}\\frac{\\partial q_i}{\\partial \\xi_i}', 'Formale Gleichung 3.904 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1167, '3.905', 35, 'Gleichung 3.905', '\\nabla\\cdot q>0', '\\nabla\\cdot q>0', 'Formale Gleichung 3.905 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1168, '3.906', 35, 'Gleichung 3.906', '\\nabla\\cdot q<0', '\\nabla\\cdot q<0', 'Formale Gleichung 3.906 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1169, '3.907', 35, 'Gleichung 3.907', '\\Delta u=\\nabla\\cdot\\nabla u', '\\Delta u=\\nabla\\cdot\\nabla u', 'Formale Gleichung 3.907 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1170, '3.908', 35, 'Gleichung 3.908', '\\Delta u=\\sum_{i=1}^{d}\\frac{\\partial^{2}u}{\\partial \\xi_i^{2}}', '\\Delta u=\\sum_{i=1}^{d}\\frac{\\partial^{2}u}{\\partial \\xi_i^{2}}', 'Formale Gleichung 3.908 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1171, '3.909', 35, 'Gleichung 3.909', '\\Delta u=\\frac{\\partial^{2}u}{\\partial x^{2}}+\\frac{\\partial^{2}u}{\\partial y^{2}}+\\frac{\\partial^{2}u}{\\partial z^{2}}', '\\Delta u=\\frac{\\partial^{2}u}{\\partial x^{2}}+\\frac{\\partial^{2}u}{\\partial y^{2}}+\\frac{\\partial^{2}u}{\\partial z^{2}}', 'Formale Gleichung 3.909 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1172, '3.910', 35, 'Gleichung 3.910', '\\frac{\\partial u}{\\partial t}+a\\frac{\\partial u}{\\partial x}=0', '\\frac{\\partial u}{\\partial t}+a\\frac{\\partial u}{\\partial x}=0', 'Formale Gleichung 3.910 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1173, '3.911', 35, 'Gleichung 3.911', '\\frac{\\partial u}{\\partial t}-\\kappa\\frac{\\partial^{2}u}{\\partial x^{2}}=0', '\\frac{\\partial u}{\\partial t}-\\kappa\\frac{\\partial^{2}u}{\\partial x^{2}}=0', 'Formale Gleichung 3.911 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1174, '3.912', 35, 'Gleichung 3.912', '\\sum_{i,j=1}^{d}a_{ij}(\\xi)\\frac{\\partial^{2}u}{\\partial \\xi_i\\partial \\xi_j}+\\sum_{i=1}^{d}b_i(\\xi)\\frac{\\partial u}{\\partial \\xi_i}+c(\\xi)u=f(\\xi)', '\\sum_{i,j=1}^{d}a_{ij}(\\xi)\\frac{\\partial^{2}u}{\\partial \\xi_i\\partial \\xi_j}+\\sum_{i=1}^{d}b_i(\\xi)\\frac{\\partial u}{\\partial \\xi_i}+c(\\xi)u=f(\\xi)', 'Formale Gleichung 3.912 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1175, '3.913', 35, 'Gleichung 3.913', '\\sum_{i,j=1}^{d}a_{ij}(\\xi,u,\\nabla u)\\frac{\\partial^{2}u}{\\partial \\xi_i\\partial \\xi_j}=f(\\xi,u,\\nabla u)', '\\sum_{i,j=1}^{d}a_{ij}(\\xi,u,\\nabla u)\\frac{\\partial^{2}u}{\\partial \\xi_i\\partial \\xi_j}=f(\\xi,u,\\nabla u)', 'Formale Gleichung 3.913 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1176, '3.914', 35, 'Gleichung 3.914', 'A\\frac{\\partial^{2}u}{\\partial x^{2}}+2B\\frac{\\partial^{2}u}{\\partial x\\partial y}+C\\frac{\\partial^{2}u}{\\partial y^{2}}+\\text{Terme niedrigerer Ordnung}=0', 'A\\frac{\\partial^{2}u}{\\partial x^{2}}+2B\\frac{\\partial^{2}u}{\\partial x\\partial y}+C\\frac{\\partial^{2}u}{\\partial y^{2}}+\\text{Terme niedrigerer Ordnung}=0', 'Formale Gleichung 3.914 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1177, '3.915', 35, 'Gleichung 3.915', 'D=B^{2}-AC', 'D=B^{2}-AC', 'Formale Gleichung 3.915 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1178, '3.916', 35, 'Gleichung 3.916', 'B^{2}-AC<0', 'B^{2}-AC<0', 'Formale Gleichung 3.916 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1179, '3.917', 35, 'Gleichung 3.917', 'B^{2}-AC=0', 'B^{2}-AC=0', 'Formale Gleichung 3.917 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1180, '3.918', 35, 'Gleichung 3.918', 'B^{2}-AC>0', 'B^{2}-AC>0', 'Formale Gleichung 3.918 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1181, '3.919', 35, 'Gleichung 3.919', '\\sum_{i,j=1}^{d}a_{ij}(\\xi)\\frac{\\partial^{2}u}{\\partial \\xi_i\\partial \\xi_j}=f(\\xi)', '\\sum_{i,j=1}^{d}a_{ij}(\\xi)\\frac{\\partial^{2}u}{\\partial \\xi_i\\partial \\xi_j}=f(\\xi)', 'Formale Gleichung 3.919 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1182, '3.920', 35, 'Gleichung 3.920', '\\sum_{i,j=1}^{d}a_{ij}(\\xi)v_iv_j>0', '\\sum_{i,j=1}^{d}a_{ij}(\\xi)v_iv_j>0', 'Formale Gleichung 3.920 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1183, '3.921', 35, 'Gleichung 3.921', '\\Delta u=0', '\\Delta u=0', 'Formale Gleichung 3.921 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1184, '3.922', 35, 'Gleichung 3.922', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0', 'Formale Gleichung 3.922 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1185, '3.923', 35, 'Gleichung 3.923', '\\kappa>0', '\\kappa>0', 'Formale Gleichung 3.923 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1186, '3.924', 35, 'Gleichung 3.924', '\\frac{\\partial^{2}u}{\\partial t^{2}}-c^{2}\\Delta u=0', '\\frac{\\partial^{2}u}{\\partial t^{2}}-c^{2}\\Delta u=0', 'Formale Gleichung 3.924 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1187, '3.925', 35, 'Gleichung 3.925', 'c>0', 'c>0', 'Formale Gleichung 3.925 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1188, '3.926', 35, 'Gleichung 3.926', '\\Omega\\subseteq\\mathbb{R}^{d}', '\\Omega\\subseteq\\mathbb{R}^{d}', 'Formale Gleichung 3.926 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1189, '3.927', 35, 'Gleichung 3.927', '\\partial\\Omega', '\\partial\\Omega', 'Formale Gleichung 3.927 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1190, '3.928', 35, 'Gleichung 3.928', 'u(\\xi)=g(\\xi)\\qquad\\text{für }\\xi\\in\\partial\\Omega', 'u(\\xi)=g(\\xi)\\qquad\\text{für }\\xi\\in\\partial\\Omega', 'Formale Gleichung 3.928 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1191, '3.929', 35, 'Gleichung 3.929', '\\frac{\\partial u}{\\partial n}=g\\qquad\\text{auf }\\partial\\Omega', '\\frac{\\partial u}{\\partial n}=g\\qquad\\text{auf }\\partial\\Omega', 'Formale Gleichung 3.929 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1192, '3.930', 35, 'Gleichung 3.930', '\\frac{\\partial u}{\\partial n}=\\nabla u\\cdot n', '\\frac{\\partial u}{\\partial n}=\\nabla u\\cdot n', 'Formale Gleichung 3.930 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1193, '3.931', 35, 'Gleichung 3.931', '\\alpha u+\\beta\\frac{\\partial u}{\\partial n}=g\\qquad\\text{auf }\\partial\\Omega', '\\alpha u+\\beta\\frac{\\partial u}{\\partial n}=g\\qquad\\text{auf }\\partial\\Omega', 'Formale Gleichung 3.931 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1194, '3.932', 35, 'Gleichung 3.932', '\\beta=0', '\\beta=0', 'Formale Gleichung 3.932 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1195, '3.933', 35, 'Gleichung 3.933', '\\alpha=0', '\\alpha=0', 'Formale Gleichung 3.933 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1196, '3.934', 35, 'Gleichung 3.934', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=f', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=f', 'Formale Gleichung 3.934 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1197, '3.935', 35, 'Gleichung 3.935', 'u(0,\\xi)=u_0(\\xi)', 'u(0,\\xi)=u_0(\\xi)', 'Formale Gleichung 3.935 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1198, '3.936', 35, 'Gleichung 3.936', 'u(0,\\xi)=u_0(\\xi)', 'u(0,\\xi)=u_0(\\xi)', 'Formale Gleichung 3.936 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1199, '3.937', 35, 'Gleichung 3.937', '\\frac{\\partial u}{\\partial t}(0,\\xi)=v_0(\\xi)', '\\frac{\\partial u}{\\partial t}(0,\\xi)=v_0(\\xi)', 'Formale Gleichung 3.937 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1200, '3.938', 35, 'Gleichung 3.938', '\\text{partieller Differentialgleichung}', '\\text{partieller Differentialgleichung}', 'Formale Gleichung 3.938 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1201, '3.939', 35, 'Gleichung 3.939', '\\text{Anfangsbedingung}', '\\text{Anfangsbedingung}', 'Formale Gleichung 3.939 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1202, '3.940', 35, 'Gleichung 3.940', '\\text{Randbedingung}', '\\text{Randbedingung}', 'Formale Gleichung 3.940 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1203, '3.941', 35, 'Gleichung 3.941', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=f\\qquad\\text{in }(0,T)\\times\\Omega', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=f\\qquad\\text{in }(0,T)\\times\\Omega', 'Formale Gleichung 3.941 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1204, '3.942', 35, 'Gleichung 3.942', 'u(0,\\xi)=u_0(\\xi)\\qquad\\text{in }\\Omega', 'u(0,\\xi)=u_0(\\xi)\\qquad\\text{in }\\Omega', 'Formale Gleichung 3.942 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1205, '3.943', 35, 'Gleichung 3.943', 'u(t,\\xi)=g(t,\\xi)\\qquad\\text{auf }(0,T)\\times\\partial\\Omega', 'u(t,\\xi)=g(t,\\xi)\\qquad\\text{auf }(0,T)\\times\\partial\\Omega', 'Formale Gleichung 3.943 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1206, '3.944', 35, 'Gleichung 3.944', '\\varphi\\in C_c^\\infty(\\Omega)', '\\varphi\\in C_c^\\infty(\\Omega)', 'Formale Gleichung 3.944 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1207, '3.945', 35, 'Gleichung 3.945', '-\\Delta u=f\\qquad\\text{in }\\Omega', '-\\Delta u=f\\qquad\\text{in }\\Omega', 'Formale Gleichung 3.945 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1208, '3.946', 35, 'Gleichung 3.946', '\\int_{\\Omega}(-\\Delta u)\\varphi\\,\\mathrm{d}\\xi=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi', '\\int_{\\Omega}(-\\Delta u)\\varphi\\,\\mathrm{d}\\xi=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi', 'Formale Gleichung 3.946 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1209, '3.947', 35, 'Gleichung 3.947', '\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi-\\int_{\\partial\\Omega}\\frac{\\partial u}{\\partial n}\\varphi\\,\\mathrm{d}S=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi', '\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi-\\int_{\\partial\\Omega}\\frac{\\partial u}{\\partial n}\\varphi\\,\\mathrm{d}S=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi', 'Formale Gleichung 3.947 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1210, '3.948', 35, 'Gleichung 3.948', '\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi', '\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi', 'Formale Gleichung 3.948 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1211, '3.949', 35, 'Gleichung 3.949', 'u\\in H_0^1(\\Omega)', 'u\\in H_0^1(\\Omega)', 'Formale Gleichung 3.949 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1212, '3.950', 35, 'Gleichung 3.950', '\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi', '\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi', 'Formale Gleichung 3.950 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1213, '3.951', 35, 'Gleichung 3.951', '\\varphi\\in H_0^1(\\Omega)', '\\varphi\\in H_0^1(\\Omega)', 'Formale Gleichung 3.951 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1214, '3.952', 35, 'Gleichung 3.952', 'H^1(\\Omega)=\\left\\{u\\in L^2(\\Omega)\\;\\middle|\\;\\frac{\\partial u}{\\partial \\xi_i}\\in L^2(\\Omega)\\text{ für }i=1,\\ldots,d\\right\\}', 'H^1(\\Omega)=\\left\\{u\\in L^2(\\Omega)\\;\\middle|\\;\\frac{\\partial u}{\\partial \\xi_i}\\in L^2(\\Omega)\\text{ für }i=1,\\ldots,d\\right\\}', 'Formale Gleichung 3.952 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1215, '3.953', 35, 'Gleichung 3.953', '\\|u\\|_{H^1(\\Omega)}=\\left(\\|u\\|_{L^2(\\Omega)}^2+\\|\\nabla u\\|_{L^2(\\Omega)}^2\\right)^{1/2}', '\\|u\\|_{H^1(\\Omega)}=\\left(\\|u\\|_{L^2(\\Omega)}^2+\\|\\nabla u\\|_{L^2(\\Omega)}^2\\right)^{1/2}', 'Formale Gleichung 3.953 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1216, '3.954', 35, 'Gleichung 3.954', 'H_0^1(\\Omega)', 'H_0^1(\\Omega)', 'Formale Gleichung 3.954 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1217, '3.955', 35, 'Gleichung 3.955', 'a(u,\\varphi)=\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi', 'a(u,\\varphi)=\\int_{\\Omega}\\nabla u\\cdot\\nabla\\varphi\\,\\mathrm{d}\\xi', 'Formale Gleichung 3.955 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1218, '3.956', 35, 'Gleichung 3.956', '\\ell(\\varphi)=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi', '\\ell(\\varphi)=\\int_{\\Omega}f\\varphi\\,\\mathrm{d}\\xi', 'Formale Gleichung 3.956 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1219, '3.957', 35, 'Gleichung 3.957', 'u\\in H_0^1(\\Omega)', 'u\\in H_0^1(\\Omega)', 'Formale Gleichung 3.957 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1220, '3.958', 35, 'Gleichung 3.958', 'a(u,\\varphi)=\\ell(\\varphi)\\qquad\\text{für alle }\\varphi\\in H_0^1(\\Omega)', 'a(u,\\varphi)=\\ell(\\varphi)\\qquad\\text{für alle }\\varphi\\in H_0^1(\\Omega)', 'Formale Gleichung 3.958 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1221, '3.959', 35, 'Gleichung 3.959', 'a:V\\times V\\rightarrow\\mathbb{R}', 'a:V\\times V\\rightarrow\\mathbb{R}', 'Formale Gleichung 3.959 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1222, '3.960', 35, 'Gleichung 3.960', '|a(u,v)|\\leq C_a\\|u\\|_V\\|v\\|_V', '|a(u,v)|\\leq C_a\\|u\\|_V\\|v\\|_V', 'Formale Gleichung 3.960 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1223, '3.961', 35, 'Gleichung 3.961', 'a(v,v)\\geq\\alpha\\|v\\|_V^2', 'a(v,v)\\geq\\alpha\\|v\\|_V^2', 'Formale Gleichung 3.961 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1224, '3.962', 35, 'Gleichung 3.962', '\\alpha>0', '\\alpha>0', 'Formale Gleichung 3.962 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1225, '3.963', 35, 'Gleichung 3.963', '\\ell\\in V^\\ast', '\\ell\\in V^\\ast', 'Formale Gleichung 3.963 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1226, '3.964', 35, 'Gleichung 3.964', 'a(u,v)=\\ell(v)\\qquad\\text{für alle }v\\in V', 'a(u,v)=\\ell(v)\\qquad\\text{für alle }v\\in V', 'Formale Gleichung 3.964 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1227, '3.965', 35, 'Gleichung 3.965', '\\|u\\|_V\\leq\\frac{1}{\\alpha}\\|\\ell\\|_{V^\\ast}', '\\|u\\|_V\\leq\\frac{1}{\\alpha}\\|\\ell\\|_{V^\\ast}', 'Formale Gleichung 3.965 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1228, '3.966', 35, 'Gleichung 3.966', 'u(t,\\xi)', 'u(t,\\xi)', 'Formale Gleichung 3.966 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1229, '3.967', 35, 'Gleichung 3.967', 'q(t,\\xi)', 'q(t,\\xi)', 'Formale Gleichung 3.967 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1230, '3.968', 35, 'Gleichung 3.968', 'V\\subseteq\\Omega', 'V\\subseteq\\Omega', 'Formale Gleichung 3.968 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1231, '3.969', 35, 'Gleichung 3.969', '\\frac{\\mathrm{d}}{\\mathrm{d}t}\\int_Vu\\,\\mathrm{d}\\xi=-\\int_{\\partial V}q\\cdot n\\,\\mathrm{d}S+\\int_Vs\\,\\mathrm{d}\\xi', '\\frac{\\mathrm{d}}{\\mathrm{d}t}\\int_Vu\\,\\mathrm{d}\\xi=-\\int_{\\partial V}q\\cdot n\\,\\mathrm{d}S+\\int_Vs\\,\\mathrm{d}\\xi', 'Formale Gleichung 3.969 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1232, '3.970', 35, 'Gleichung 3.970', '\\int_{\\partial V}q\\cdot n\\,\\mathrm{d}S=\\int_V\\nabla\\cdot q\\,\\mathrm{d}\\xi', '\\int_{\\partial V}q\\cdot n\\,\\mathrm{d}S=\\int_V\\nabla\\cdot q\\,\\mathrm{d}\\xi', 'Formale Gleichung 3.970 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1233, '3.971', 35, 'Gleichung 3.971', '\\int_V\\left(\\frac{\\partial u}{\\partial t}+\\nabla\\cdot q-s\\right)\\,\\mathrm{d}\\xi=0', '\\int_V\\left(\\frac{\\partial u}{\\partial t}+\\nabla\\cdot q-s\\right)\\,\\mathrm{d}\\xi=0', 'Formale Gleichung 3.971 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1234, '3.972', 35, 'Gleichung 3.972', '\\frac{\\partial u}{\\partial t}+\\nabla\\cdot q=s', '\\frac{\\partial u}{\\partial t}+\\nabla\\cdot q=s', 'Formale Gleichung 3.972 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1235, '3.973', 35, 'Gleichung 3.973', '\\frac{\\partial u}{\\partial t}+\\nabla\\cdot q=s', '\\frac{\\partial u}{\\partial t}+\\nabla\\cdot q=s', 'Formale Gleichung 3.973 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1236, '3.974', 35, 'Gleichung 3.974', 's=0', 's=0', 'Formale Gleichung 3.974 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1237, '3.975', 35, 'Gleichung 3.975', 'q=-\\kappa\\nabla u', 'q=-\\kappa\\nabla u', 'Formale Gleichung 3.975 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1238, '3.976', 35, 'Gleichung 3.976', '\\frac{\\partial u}{\\partial t}+\\nabla\\cdot(-\\kappa\\nabla u)=s', '\\frac{\\partial u}{\\partial t}+\\nabla\\cdot(-\\kappa\\nabla u)=s', 'Formale Gleichung 3.976 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1239, '3.977', 35, 'Gleichung 3.977', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=s', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=s', 'Formale Gleichung 3.977 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1240, '3.978', 35, 'Gleichung 3.978', 'q=uv', 'q=uv', 'Formale Gleichung 3.978 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1241, '3.979', 35, 'Gleichung 3.979', '\\frac{\\partial u}{\\partial t}+\\nabla\\cdot(uv)=s', '\\frac{\\partial u}{\\partial t}+\\nabla\\cdot(uv)=s', 'Formale Gleichung 3.979 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1242, '3.980', 35, 'Gleichung 3.980', '\\nabla\\cdot v=0', '\\nabla\\cdot v=0', 'Formale Gleichung 3.980 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1243, '3.981', 35, 'Gleichung 3.981', '\\nabla\\cdot(uv)=v\\cdot\\nabla u', '\\nabla\\cdot(uv)=v\\cdot\\nabla u', 'Formale Gleichung 3.981 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1244, '3.982', 35, 'Gleichung 3.982', '\\frac{\\partial u}{\\partial t}+v\\cdot\\nabla u=s', '\\frac{\\partial u}{\\partial t}+v\\cdot\\nabla u=s', 'Formale Gleichung 3.982 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1245, '3.983', 35, 'Gleichung 3.983', 'q=uv-\\kappa\\nabla u', 'q=uv-\\kappa\\nabla u', 'Formale Gleichung 3.983 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1246, '3.984', 35, 'Gleichung 3.984', '\\frac{\\partial u}{\\partial t}+\\nabla\\cdot(uv)-\\nabla\\cdot(\\kappa\\nabla u)=s', '\\frac{\\partial u}{\\partial t}+\\nabla\\cdot(uv)-\\nabla\\cdot(\\kappa\\nabla u)=s', 'Formale Gleichung 3.984 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1247, '3.985', 35, 'Gleichung 3.985', '\\frac{\\partial u}{\\partial t}+v\\cdot\\nabla u-\\kappa\\Delta u=s', '\\frac{\\partial u}{\\partial t}+v\\cdot\\nabla u-\\kappa\\Delta u=s', 'Formale Gleichung 3.985 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1248, '3.986', 35, 'Gleichung 3.986', 'u=\\begin{pmatrix}u_1\\\\u_2\\\\\\vdots\\\\u_m\\ \\end{pmatrix}', 'u=\\begin{pmatrix}u_1\\\\u_2\\\\\\vdots\\\\u_m\\ \\end{pmatrix}', 'Formale Gleichung 3.986 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1249, '3.987', 35, 'Gleichung 3.987', '\\frac{\\partial u}{\\partial t}=D\\Delta u+R(u)', '\\frac{\\partial u}{\\partial t}=D\\Delta u+R(u)', 'Formale Gleichung 3.987 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1250, '3.988', 35, 'Gleichung 3.988', 'D=\\operatorname{diag}(D_1,D_2,\\ldots,D_m)', 'D=\\operatorname{diag}(D_1,D_2,\\ldots,D_m)', 'Formale Gleichung 3.988 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1251, '3.989', 35, 'Gleichung 3.989', 'R(u)=\\begin{pmatrix}R_1(u)\\\\R_2(u)\\\\\\vdots\\\\R_m(u)\\ \\end{pmatrix}', 'R(u)=\\begin{pmatrix}R_1(u)\\\\R_2(u)\\\\\\vdots\\\\R_m(u)\\ \\end{pmatrix}', 'Formale Gleichung 3.989 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1252, '3.990', 35, 'Gleichung 3.990', 'u(t,\\xi)=\\bar{u}(t)', 'u(t,\\xi)=\\bar{u}(t)', 'Formale Gleichung 3.990 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1253, '3.991', 35, 'Gleichung 3.991', '\\nabla u=0', '\\nabla u=0', 'Formale Gleichung 3.991 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1254, '3.992', 35, 'Gleichung 3.992', '\\Delta u=0', '\\Delta u=0', 'Formale Gleichung 3.992 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1255, '3.993', 35, 'Gleichung 3.993', '\\frac{\\mathrm{d}\\bar{u}}{\\mathrm{d}t}=R(\\bar{u})', '\\frac{\\mathrm{d}\\bar{u}}{\\mathrm{d}t}=R(\\bar{u})', 'Formale Gleichung 3.993 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1256, '3.994', 35, 'Gleichung 3.994', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0', 'Formale Gleichung 3.994 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1257, '3.995', 35, 'Gleichung 3.995', '\\int_{\\Omega}u\\frac{\\partial u}{\\partial t}\\,\\mathrm{d}\\xi-\\kappa\\int_{\\Omega}u\\Delta u\\,\\mathrm{d}\\xi=0', '\\int_{\\Omega}u\\frac{\\partial u}{\\partial t}\\,\\mathrm{d}\\xi-\\kappa\\int_{\\Omega}u\\Delta u\\,\\mathrm{d}\\xi=0', 'Formale Gleichung 3.995 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1258, '3.996', 35, 'Gleichung 3.996', '\\int_{\\Omega}u\\frac{\\partial u}{\\partial t}\\,\\mathrm{d}\\xi=\\frac{1}{2}\\frac{\\mathrm{d}}{\\mathrm{d}t}\\int_{\\Omega}u^2\\,\\mathrm{d}\\xi', '\\int_{\\Omega}u\\frac{\\partial u}{\\partial t}\\,\\mathrm{d}\\xi=\\frac{1}{2}\\frac{\\mathrm{d}}{\\mathrm{d}t}\\int_{\\Omega}u^2\\,\\mathrm{d}\\xi', 'Formale Gleichung 3.996 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1259, '3.997', 35, 'Gleichung 3.997', '-\\int_{\\Omega}u\\Delta u\\,\\mathrm{d}\\xi=\\int_{\\Omega}|\\nabla u|^2\\,\\mathrm{d}\\xi', '-\\int_{\\Omega}u\\Delta u\\,\\mathrm{d}\\xi=\\int_{\\Omega}|\\nabla u|^2\\,\\mathrm{d}\\xi', 'Formale Gleichung 3.997 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1260, '3.998', 35, 'Gleichung 3.998', '\\frac{1}{2}\\frac{\\mathrm{d}}{\\mathrm{d}t}\\|u(t)\\|_{L^2(\\Omega)}^2+\\kappa\\|\\nabla u(t)\\|_{L^2(\\Omega)}^2=0', '\\frac{1}{2}\\frac{\\mathrm{d}}{\\mathrm{d}t}\\|u(t)\\|_{L^2(\\Omega)}^2+\\kappa\\|\\nabla u(t)\\|_{L^2(\\Omega)}^2=0', 'Formale Gleichung 3.998 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1261, '3.999', 35, 'Gleichung 3.999', '\\frac{\\mathrm{d}}{\\mathrm{d}t}\\|u(t)\\|_{L^2(\\Omega)}^2\\leq0', '\\frac{\\mathrm{d}}{\\mathrm{d}t}\\|u(t)\\|_{L^2(\\Omega)}^2\\leq0', 'Formale Gleichung 3.999 aus Abschnitt 3.2.20.', 'other', 'adapted', 81, 'Im Abschnitt 3.2.20 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.20.', 'verified', 38),
(1358, '3.1049', 37, 'Gleichung 3.1049', '\\text{Gleichung 1049 aus Abschnitt 3.2.21}', '\\text{Gleichung 1049 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1049 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1359, '3.1050', 37, 'Gleichung 3.1050', '\\text{Gleichung 1050 aus Abschnitt 3.2.21}', '\\text{Gleichung 1050 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1050 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1360, '3.1051', 37, 'Gleichung 3.1051', '\\text{Gleichung 1051 aus Abschnitt 3.2.21}', '\\text{Gleichung 1051 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1051 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1361, '3.1052', 37, 'Gleichung 3.1052', '\\text{Gleichung 1052 aus Abschnitt 3.2.21}', '\\text{Gleichung 1052 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1052 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1362, '3.1053', 37, 'Gleichung 3.1053', '\\text{Gleichung 1053 aus Abschnitt 3.2.21}', '\\text{Gleichung 1053 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1053 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1363, '3.1054', 37, 'Gleichung 3.1054', '\\text{Gleichung 1054 aus Abschnitt 3.2.21}', '\\text{Gleichung 1054 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1054 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1364, '3.1055', 37, 'Gleichung 3.1055', '\\text{Gleichung 1055 aus Abschnitt 3.2.21}', '\\text{Gleichung 1055 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1055 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1365, '3.1056', 37, 'Gleichung 3.1056', '\\text{Gleichung 1056 aus Abschnitt 3.2.21}', '\\text{Gleichung 1056 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1056 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1366, '3.1057', 37, 'Gleichung 3.1057', '\\text{Gleichung 1057 aus Abschnitt 3.2.21}', '\\text{Gleichung 1057 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1057 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1367, '3.1058', 37, 'Gleichung 3.1058', '\\text{Gleichung 1058 aus Abschnitt 3.2.21}', '\\text{Gleichung 1058 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1058 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1368, '3.1059', 37, 'Gleichung 3.1059', '\\text{Gleichung 1059 aus Abschnitt 3.2.21}', '\\text{Gleichung 1059 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1059 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1369, '3.1060', 37, 'Gleichung 3.1060', '\\text{Gleichung 1060 aus Abschnitt 3.2.21}', '\\text{Gleichung 1060 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1060 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1370, '3.1061', 37, 'Gleichung 3.1061', '\\text{Gleichung 1061 aus Abschnitt 3.2.21}', '\\text{Gleichung 1061 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1061 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1371, '3.1062', 37, 'Gleichung 3.1062', '\\text{Gleichung 1062 aus Abschnitt 3.2.21}', '\\text{Gleichung 1062 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1062 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1372, '3.1063', 37, 'Gleichung 3.1063', '\\text{Gleichung 1063 aus Abschnitt 3.2.21}', '\\text{Gleichung 1063 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1063 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1373, '3.1064', 37, 'Gleichung 3.1064', '\\text{Gleichung 1064 aus Abschnitt 3.2.21}', '\\text{Gleichung 1064 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1064 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1374, '3.1065', 37, 'Gleichung 3.1065', '\\text{Gleichung 1065 aus Abschnitt 3.2.21}', '\\text{Gleichung 1065 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1065 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1375, '3.1066', 37, 'Gleichung 3.1066', '\\text{Gleichung 1066 aus Abschnitt 3.2.21}', '\\text{Gleichung 1066 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1066 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1376, '3.1067', 37, 'Gleichung 3.1067', '\\text{Gleichung 1067 aus Abschnitt 3.2.21}', '\\text{Gleichung 1067 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1067 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1377, '3.1068', 37, 'Gleichung 3.1068', '\\text{Gleichung 1068 aus Abschnitt 3.2.21}', '\\text{Gleichung 1068 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1068 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1378, '3.1069', 37, 'Gleichung 3.1069', '\\text{Gleichung 1069 aus Abschnitt 3.2.21}', '\\text{Gleichung 1069 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1069 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1379, '3.1070', 37, 'Gleichung 3.1070', '\\text{Gleichung 1070 aus Abschnitt 3.2.21}', '\\text{Gleichung 1070 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1070 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1380, '3.1071', 37, 'Gleichung 3.1071', '\\text{Gleichung 1071 aus Abschnitt 3.2.21}', '\\text{Gleichung 1071 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1071 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1381, '3.1072', 37, 'Gleichung 3.1072', '\\text{Gleichung 1072 aus Abschnitt 3.2.21}', '\\text{Gleichung 1072 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1072 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1382, '3.1073', 37, 'Gleichung 3.1073', '\\text{Gleichung 1073 aus Abschnitt 3.2.21}', '\\text{Gleichung 1073 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1073 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1383, '3.1074', 37, 'Gleichung 3.1074', '\\text{Gleichung 1074 aus Abschnitt 3.2.21}', '\\text{Gleichung 1074 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1074 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1384, '3.1075', 37, 'Gleichung 3.1075', '\\text{Gleichung 1075 aus Abschnitt 3.2.21}', '\\text{Gleichung 1075 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1075 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1385, '3.1076', 37, 'Gleichung 3.1076', '\\text{Gleichung 1076 aus Abschnitt 3.2.21}', '\\text{Gleichung 1076 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1076 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1386, '3.1077', 37, 'Gleichung 3.1077', '\\text{Gleichung 1077 aus Abschnitt 3.2.21}', '\\text{Gleichung 1077 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1077 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1387, '3.1078', 37, 'Gleichung 3.1078', '\\text{Gleichung 1078 aus Abschnitt 3.2.21}', '\\text{Gleichung 1078 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1078 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1388, '3.1079', 37, 'Gleichung 3.1079', '\\text{Gleichung 1079 aus Abschnitt 3.2.21}', '\\text{Gleichung 1079 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1079 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1389, '3.1080', 37, 'Gleichung 3.1080', '\\text{Gleichung 1080 aus Abschnitt 3.2.21}', '\\text{Gleichung 1080 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1080 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1390, '3.1081', 37, 'Gleichung 3.1081', '\\text{Gleichung 1081 aus Abschnitt 3.2.21}', '\\text{Gleichung 1081 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1081 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1391, '3.1082', 37, 'Gleichung 3.1082', '\\text{Gleichung 1082 aus Abschnitt 3.2.21}', '\\text{Gleichung 1082 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1082 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1392, '3.1083', 37, 'Gleichung 3.1083', '\\text{Gleichung 1083 aus Abschnitt 3.2.21}', '\\text{Gleichung 1083 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1083 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1393, '3.1084', 37, 'Gleichung 3.1084', '\\text{Gleichung 1084 aus Abschnitt 3.2.21}', '\\text{Gleichung 1084 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1084 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1394, '3.1085', 37, 'Gleichung 3.1085', '\\text{Gleichung 1085 aus Abschnitt 3.2.21}', '\\text{Gleichung 1085 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1085 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1395, '3.1086', 37, 'Gleichung 3.1086', '\\text{Gleichung 1086 aus Abschnitt 3.2.21}', '\\text{Gleichung 1086 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1086 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1396, '3.1087', 37, 'Gleichung 3.1087', '\\text{Gleichung 1087 aus Abschnitt 3.2.21}', '\\text{Gleichung 1087 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1087 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1397, '3.1088', 37, 'Gleichung 3.1088', '\\text{Gleichung 1088 aus Abschnitt 3.2.21}', '\\text{Gleichung 1088 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1088 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1398, '3.1089', 37, 'Gleichung 3.1089', '\\text{Gleichung 1089 aus Abschnitt 3.2.21}', '\\text{Gleichung 1089 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1089 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1399, '3.1090', 37, 'Gleichung 3.1090', '\\text{Gleichung 1090 aus Abschnitt 3.2.21}', '\\text{Gleichung 1090 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1090 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1400, '3.1091', 37, 'Gleichung 3.1091', '\\text{Gleichung 1091 aus Abschnitt 3.2.21}', '\\text{Gleichung 1091 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1091 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1401, '3.1092', 37, 'Gleichung 3.1092', '\\text{Gleichung 1092 aus Abschnitt 3.2.21}', '\\text{Gleichung 1092 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1092 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(1402, '3.1093', 37, 'Gleichung 3.1093', '\\text{Gleichung 1093 aus Abschnitt 3.2.21}', '\\text{Gleichung 1093 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1093 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1403, '3.1094', 37, 'Gleichung 3.1094', '\\text{Gleichung 1094 aus Abschnitt 3.2.21}', '\\text{Gleichung 1094 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1094 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1404, '3.1095', 37, 'Gleichung 3.1095', '\\text{Gleichung 1095 aus Abschnitt 3.2.21}', '\\text{Gleichung 1095 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1095 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1405, '3.1096', 37, 'Gleichung 3.1096', '\\text{Gleichung 1096 aus Abschnitt 3.2.21}', '\\text{Gleichung 1096 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1096 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1406, '3.1097', 37, 'Gleichung 3.1097', '\\text{Gleichung 1097 aus Abschnitt 3.2.21}', '\\text{Gleichung 1097 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1097 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1407, '3.1098', 37, 'Gleichung 3.1098', '\\text{Gleichung 1098 aus Abschnitt 3.2.21}', '\\text{Gleichung 1098 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1098 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1408, '3.1099', 37, 'Gleichung 3.1099', '\\text{Gleichung 1099 aus Abschnitt 3.2.21}', '\\text{Gleichung 1099 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1099 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1409, '3.1100', 37, 'Gleichung 3.1100', '\\text{Gleichung 1100 aus Abschnitt 3.2.21}', '\\text{Gleichung 1100 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1100 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1410, '3.1101', 37, 'Gleichung 3.1101', '\\text{Gleichung 1101 aus Abschnitt 3.2.21}', '\\text{Gleichung 1101 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1101 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1411, '3.1102', 37, 'Gleichung 3.1102', '\\text{Gleichung 1102 aus Abschnitt 3.2.21}', '\\text{Gleichung 1102 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1102 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1412, '3.1103', 37, 'Gleichung 3.1103', '\\text{Gleichung 1103 aus Abschnitt 3.2.21}', '\\text{Gleichung 1103 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1103 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1413, '3.1104', 37, 'Gleichung 3.1104', '\\text{Gleichung 1104 aus Abschnitt 3.2.21}', '\\text{Gleichung 1104 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1104 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1414, '3.1105', 37, 'Gleichung 3.1105', '\\text{Gleichung 1105 aus Abschnitt 3.2.21}', '\\text{Gleichung 1105 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1105 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1415, '3.1106', 37, 'Gleichung 3.1106', '\\text{Gleichung 1106 aus Abschnitt 3.2.21}', '\\text{Gleichung 1106 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1106 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1416, '3.1107', 37, 'Gleichung 3.1107', '\\text{Gleichung 1107 aus Abschnitt 3.2.21}', '\\text{Gleichung 1107 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1107 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1417, '3.1108', 37, 'Gleichung 3.1108', '\\text{Gleichung 1108 aus Abschnitt 3.2.21}', '\\text{Gleichung 1108 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1108 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1418, '3.1109', 37, 'Gleichung 3.1109', '\\text{Gleichung 1109 aus Abschnitt 3.2.21}', '\\text{Gleichung 1109 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1109 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1419, '3.1110', 37, 'Gleichung 3.1110', '\\text{Gleichung 1110 aus Abschnitt 3.2.21}', '\\text{Gleichung 1110 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1110 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1420, '3.1111', 37, 'Gleichung 3.1111', '\\text{Gleichung 1111 aus Abschnitt 3.2.21}', '\\text{Gleichung 1111 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1111 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1421, '3.1112', 37, 'Gleichung 3.1112', '\\text{Gleichung 1112 aus Abschnitt 3.2.21}', '\\text{Gleichung 1112 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1112 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1422, '3.1113', 37, 'Gleichung 3.1113', '\\text{Gleichung 1113 aus Abschnitt 3.2.21}', '\\text{Gleichung 1113 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1113 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1423, '3.1114', 37, 'Gleichung 3.1114', '\\text{Gleichung 1114 aus Abschnitt 3.2.21}', '\\text{Gleichung 1114 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1114 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1424, '3.1115', 37, 'Gleichung 3.1115', '\\text{Gleichung 1115 aus Abschnitt 3.2.21}', '\\text{Gleichung 1115 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1115 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1425, '3.1116', 37, 'Gleichung 3.1116', '\\text{Gleichung 1116 aus Abschnitt 3.2.21}', '\\text{Gleichung 1116 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1116 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1426, '3.1117', 37, 'Gleichung 3.1117', '\\text{Gleichung 1117 aus Abschnitt 3.2.21}', '\\text{Gleichung 1117 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1117 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1427, '3.1118', 37, 'Gleichung 3.1118', '\\text{Gleichung 1118 aus Abschnitt 3.2.21}', '\\text{Gleichung 1118 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1118 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1428, '3.1119', 37, 'Gleichung 3.1119', '\\text{Gleichung 1119 aus Abschnitt 3.2.21}', '\\text{Gleichung 1119 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1119 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1429, '3.1120', 37, 'Gleichung 3.1120', '\\text{Gleichung 1120 aus Abschnitt 3.2.21}', '\\text{Gleichung 1120 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1120 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1430, '3.1121', 37, 'Gleichung 3.1121', '\\text{Gleichung 1121 aus Abschnitt 3.2.21}', '\\text{Gleichung 1121 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1121 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1431, '3.1122', 37, 'Gleichung 3.1122', '\\text{Gleichung 1122 aus Abschnitt 3.2.21}', '\\text{Gleichung 1122 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1122 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1432, '3.1123', 37, 'Gleichung 3.1123', '\\text{Gleichung 1123 aus Abschnitt 3.2.21}', '\\text{Gleichung 1123 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1123 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1433, '3.1124', 37, 'Gleichung 3.1124', '\\text{Gleichung 1124 aus Abschnitt 3.2.21}', '\\text{Gleichung 1124 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1124 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1434, '3.1125', 37, 'Gleichung 3.1125', '\\text{Gleichung 1125 aus Abschnitt 3.2.21}', '\\text{Gleichung 1125 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1125 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1435, '3.1126', 37, 'Gleichung 3.1126', '\\text{Gleichung 1126 aus Abschnitt 3.2.21}', '\\text{Gleichung 1126 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1126 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1436, '3.1127', 37, 'Gleichung 3.1127', '\\text{Gleichung 1127 aus Abschnitt 3.2.21}', '\\text{Gleichung 1127 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1127 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1437, '3.1128', 37, 'Gleichung 3.1128', '\\text{Gleichung 1128 aus Abschnitt 3.2.21}', '\\text{Gleichung 1128 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1128 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1438, '3.1129', 37, 'Gleichung 3.1129', '\\text{Gleichung 1129 aus Abschnitt 3.2.21}', '\\text{Gleichung 1129 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1129 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1439, '3.1130', 37, 'Gleichung 3.1130', '\\text{Gleichung 1130 aus Abschnitt 3.2.21}', '\\text{Gleichung 1130 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1130 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1440, '3.1131', 37, 'Gleichung 3.1131', '\\text{Gleichung 1131 aus Abschnitt 3.2.21}', '\\text{Gleichung 1131 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1131 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1441, '3.1132', 37, 'Gleichung 3.1132', '\\text{Gleichung 1132 aus Abschnitt 3.2.21}', '\\text{Gleichung 1132 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1132 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1442, '3.1133', 37, 'Gleichung 3.1133', '\\text{Gleichung 1133 aus Abschnitt 3.2.21}', '\\text{Gleichung 1133 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1133 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1443, '3.1134', 37, 'Gleichung 3.1134', '\\text{Gleichung 1134 aus Abschnitt 3.2.21}', '\\text{Gleichung 1134 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1134 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1444, '3.1135', 37, 'Gleichung 3.1135', '\\text{Gleichung 1135 aus Abschnitt 3.2.21}', '\\text{Gleichung 1135 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1135 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1445, '3.1136', 37, 'Gleichung 3.1136', '\\text{Gleichung 1136 aus Abschnitt 3.2.21}', '\\text{Gleichung 1136 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1136 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1446, '3.1137', 37, 'Gleichung 3.1137', '\\text{Gleichung 1137 aus Abschnitt 3.2.21}', '\\text{Gleichung 1137 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1137 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1447, '3.1138', 37, 'Gleichung 3.1138', '\\text{Gleichung 1138 aus Abschnitt 3.2.21}', '\\text{Gleichung 1138 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1138 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1448, '3.1139', 37, 'Gleichung 3.1139', '\\text{Gleichung 1139 aus Abschnitt 3.2.21}', '\\text{Gleichung 1139 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1139 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1449, '3.1140', 37, 'Gleichung 3.1140', '\\text{Gleichung 1140 aus Abschnitt 3.2.21}', '\\text{Gleichung 1140 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1140 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1450, '3.1141', 37, 'Gleichung 3.1141', '\\text{Gleichung 1141 aus Abschnitt 3.2.21}', '\\text{Gleichung 1141 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1141 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1451, '3.1142', 37, 'Gleichung 3.1142', '\\text{Gleichung 1142 aus Abschnitt 3.2.21}', '\\text{Gleichung 1142 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1142 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1452, '3.1143', 37, 'Gleichung 3.1143', '\\text{Gleichung 1143 aus Abschnitt 3.2.21}', '\\text{Gleichung 1143 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1143 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1453, '3.1144', 37, 'Gleichung 3.1144', '\\text{Gleichung 1144 aus Abschnitt 3.2.21}', '\\text{Gleichung 1144 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1144 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1454, '3.1145', 37, 'Gleichung 3.1145', '\\text{Gleichung 1145 aus Abschnitt 3.2.21}', '\\text{Gleichung 1145 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1145 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1455, '3.1146', 37, 'Gleichung 3.1146', '\\text{Gleichung 1146 aus Abschnitt 3.2.21}', '\\text{Gleichung 1146 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1146 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1456, '3.1147', 37, 'Gleichung 3.1147', '\\text{Gleichung 1147 aus Abschnitt 3.2.21}', '\\text{Gleichung 1147 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1147 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1457, '3.1148', 37, 'Gleichung 3.1148', '\\text{Gleichung 1148 aus Abschnitt 3.2.21}', '\\text{Gleichung 1148 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1148 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1458, '3.1149', 37, 'Gleichung 3.1149', '\\text{Gleichung 1149 aus Abschnitt 3.2.21}', '\\text{Gleichung 1149 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1149 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1459, '3.1150', 37, 'Gleichung 3.1150', '\\text{Gleichung 1150 aus Abschnitt 3.2.21}', '\\text{Gleichung 1150 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1150 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1460, '3.1151', 37, 'Gleichung 3.1151', '\\text{Gleichung 1151 aus Abschnitt 3.2.21}', '\\text{Gleichung 1151 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1151 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1461, '3.1152', 37, 'Gleichung 3.1152', '\\text{Gleichung 1152 aus Abschnitt 3.2.21}', '\\text{Gleichung 1152 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1152 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1462, '3.1153', 37, 'Gleichung 3.1153', '\\text{Gleichung 1153 aus Abschnitt 3.2.21}', '\\text{Gleichung 1153 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1153 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1463, '3.1154', 37, 'Gleichung 3.1154', '\\text{Gleichung 1154 aus Abschnitt 3.2.21}', '\\text{Gleichung 1154 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1154 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1464, '3.1155', 37, 'Gleichung 3.1155', '\\text{Gleichung 1155 aus Abschnitt 3.2.21}', '\\text{Gleichung 1155 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1155 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1465, '3.1156', 37, 'Gleichung 3.1156', '\\text{Gleichung 1156 aus Abschnitt 3.2.21}', '\\text{Gleichung 1156 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1156 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1466, '3.1157', 37, 'Gleichung 3.1157', '\\text{Gleichung 1157 aus Abschnitt 3.2.21}', '\\text{Gleichung 1157 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1157 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1467, '3.1158', 37, 'Gleichung 3.1158', '\\text{Gleichung 1158 aus Abschnitt 3.2.21}', '\\text{Gleichung 1158 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1158 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1468, '3.1159', 37, 'Gleichung 3.1159', '\\text{Gleichung 1159 aus Abschnitt 3.2.21}', '\\text{Gleichung 1159 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1159 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1469, '3.1160', 37, 'Gleichung 3.1160', '\\text{Gleichung 1160 aus Abschnitt 3.2.21}', '\\text{Gleichung 1160 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1160 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1470, '3.1161', 37, 'Gleichung 3.1161', '\\text{Gleichung 1161 aus Abschnitt 3.2.21}', '\\text{Gleichung 1161 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1161 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1471, '3.1162', 37, 'Gleichung 3.1162', '\\text{Gleichung 1162 aus Abschnitt 3.2.21}', '\\text{Gleichung 1162 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1162 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1472, '3.1163', 37, 'Gleichung 3.1163', '\\text{Gleichung 1163 aus Abschnitt 3.2.21}', '\\text{Gleichung 1163 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1163 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1473, '3.1164', 37, 'Gleichung 3.1164', '\\text{Gleichung 1164 aus Abschnitt 3.2.21}', '\\text{Gleichung 1164 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1164 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1474, '3.1165', 37, 'Gleichung 3.1165', '\\text{Gleichung 1165 aus Abschnitt 3.2.21}', '\\text{Gleichung 1165 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1165 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1475, '3.1166', 37, 'Gleichung 3.1166', '\\text{Gleichung 1166 aus Abschnitt 3.2.21}', '\\text{Gleichung 1166 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1166 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1476, '3.1167', 37, 'Gleichung 3.1167', '\\text{Gleichung 1167 aus Abschnitt 3.2.21}', '\\text{Gleichung 1167 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1167 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1477, '3.1168', 37, 'Gleichung 3.1168', '\\text{Gleichung 1168 aus Abschnitt 3.2.21}', '\\text{Gleichung 1168 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1168 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1478, '3.1169', 37, 'Gleichung 3.1169', '\\text{Gleichung 1169 aus Abschnitt 3.2.21}', '\\text{Gleichung 1169 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1169 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1479, '3.1170', 37, 'Gleichung 3.1170', '\\text{Gleichung 1170 aus Abschnitt 3.2.21}', '\\text{Gleichung 1170 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1170 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1480, '3.1171', 37, 'Gleichung 3.1171', '\\text{Gleichung 1171 aus Abschnitt 3.2.21}', '\\text{Gleichung 1171 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1171 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1481, '3.1172', 37, 'Gleichung 3.1172', '\\text{Gleichung 1172 aus Abschnitt 3.2.21}', '\\text{Gleichung 1172 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1172 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1482, '3.1173', 37, 'Gleichung 3.1173', '\\text{Gleichung 1173 aus Abschnitt 3.2.21}', '\\text{Gleichung 1173 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1173 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1483, '3.1174', 37, 'Gleichung 3.1174', '\\text{Gleichung 1174 aus Abschnitt 3.2.21}', '\\text{Gleichung 1174 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1174 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1484, '3.1175', 37, 'Gleichung 3.1175', '\\text{Gleichung 1175 aus Abschnitt 3.2.21}', '\\text{Gleichung 1175 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1175 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1485, '3.1176', 37, 'Gleichung 3.1176', '\\text{Gleichung 1176 aus Abschnitt 3.2.21}', '\\text{Gleichung 1176 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1176 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1486, '3.1177', 37, 'Gleichung 3.1177', '\\text{Gleichung 1177 aus Abschnitt 3.2.21}', '\\text{Gleichung 1177 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1177 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1487, '3.1178', 37, 'Gleichung 3.1178', '\\text{Gleichung 1178 aus Abschnitt 3.2.21}', '\\text{Gleichung 1178 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1178 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1488, '3.1179', 37, 'Gleichung 3.1179', '\\text{Gleichung 1179 aus Abschnitt 3.2.21}', '\\text{Gleichung 1179 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1179 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1489, '3.1180', 37, 'Gleichung 3.1180', '\\text{Gleichung 1180 aus Abschnitt 3.2.21}', '\\text{Gleichung 1180 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1180 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1490, '3.1181', 37, 'Gleichung 3.1181', '\\text{Gleichung 1181 aus Abschnitt 3.2.21}', '\\text{Gleichung 1181 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1181 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1491, '3.1182', 37, 'Gleichung 3.1182', '\\text{Gleichung 1182 aus Abschnitt 3.2.21}', '\\text{Gleichung 1182 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1182 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1492, '3.1183', 37, 'Gleichung 3.1183', '\\text{Gleichung 1183 aus Abschnitt 3.2.21}', '\\text{Gleichung 1183 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1183 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1493, '3.1184', 37, 'Gleichung 3.1184', '\\text{Gleichung 1184 aus Abschnitt 3.2.21}', '\\text{Gleichung 1184 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1184 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1494, '3.1185', 37, 'Gleichung 3.1185', '\\text{Gleichung 1185 aus Abschnitt 3.2.21}', '\\text{Gleichung 1185 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1185 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1495, '3.1186', 37, 'Gleichung 3.1186', '\\text{Gleichung 1186 aus Abschnitt 3.2.21}', '\\text{Gleichung 1186 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1186 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1496, '3.1187', 37, 'Gleichung 3.1187', '\\text{Gleichung 1187 aus Abschnitt 3.2.21}', '\\text{Gleichung 1187 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1187 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1497, '3.1188', 37, 'Gleichung 3.1188', '\\text{Gleichung 1188 aus Abschnitt 3.2.21}', '\\text{Gleichung 1188 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1188 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1498, '3.1189', 37, 'Gleichung 3.1189', '\\text{Gleichung 1189 aus Abschnitt 3.2.21}', '\\text{Gleichung 1189 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1189 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1499, '3.1190', 37, 'Gleichung 3.1190', '\\text{Gleichung 1190 aus Abschnitt 3.2.21}', '\\text{Gleichung 1190 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1190 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1500, '3.1191', 37, 'Gleichung 3.1191', '\\text{Gleichung 1191 aus Abschnitt 3.2.21}', '\\text{Gleichung 1191 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1191 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1501, '3.1192', 37, 'Gleichung 3.1192', '\\text{Gleichung 1192 aus Abschnitt 3.2.21}', '\\text{Gleichung 1192 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1192 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1502, '3.1193', 37, 'Gleichung 3.1193', '\\text{Gleichung 1193 aus Abschnitt 3.2.21}', '\\text{Gleichung 1193 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1193 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1503, '3.1194', 37, 'Gleichung 3.1194', '\\text{Gleichung 1194 aus Abschnitt 3.2.21}', '\\text{Gleichung 1194 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1194 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1504, '3.1195', 37, 'Gleichung 3.1195', '\\text{Gleichung 1195 aus Abschnitt 3.2.21}', '\\text{Gleichung 1195 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1195 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1505, '3.1196', 37, 'Gleichung 3.1196', '\\text{Gleichung 1196 aus Abschnitt 3.2.21}', '\\text{Gleichung 1196 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1196 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1506, '3.1197', 37, 'Gleichung 3.1197', '\\text{Gleichung 1197 aus Abschnitt 3.2.21}', '\\text{Gleichung 1197 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1197 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1507, '3.1198', 37, 'Gleichung 3.1198', '\\text{Gleichung 1198 aus Abschnitt 3.2.21}', '\\text{Gleichung 1198 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1198 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1508, '3.1199', 37, 'Gleichung 3.1199', '\\text{Gleichung 1199 aus Abschnitt 3.2.21}', '\\text{Gleichung 1199 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1199 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1509, '3.1200', 37, 'Gleichung 3.1200', '\\text{Gleichung 1200 aus Abschnitt 3.2.21}', '\\text{Gleichung 1200 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1200 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1510, '3.1201', 37, 'Gleichung 3.1201', '\\text{Gleichung 1201 aus Abschnitt 3.2.21}', '\\text{Gleichung 1201 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1201 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1511, '3.1202', 37, 'Gleichung 3.1202', '\\text{Gleichung 1202 aus Abschnitt 3.2.21}', '\\text{Gleichung 1202 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1202 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1512, '3.1203', 37, 'Gleichung 3.1203', '\\text{Gleichung 1203 aus Abschnitt 3.2.21}', '\\text{Gleichung 1203 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1203 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1513, '3.1204', 37, 'Gleichung 3.1204', '\\text{Gleichung 1204 aus Abschnitt 3.2.21}', '\\text{Gleichung 1204 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1204 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1514, '3.1205', 37, 'Gleichung 3.1205', '\\text{Gleichung 1205 aus Abschnitt 3.2.21}', '\\text{Gleichung 1205 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1205 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1515, '3.1206', 37, 'Gleichung 3.1206', '\\text{Gleichung 1206 aus Abschnitt 3.2.21}', '\\text{Gleichung 1206 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1206 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1516, '3.1207', 37, 'Gleichung 3.1207', '\\text{Gleichung 1207 aus Abschnitt 3.2.21}', '\\text{Gleichung 1207 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1207 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1517, '3.1208', 37, 'Gleichung 3.1208', '\\text{Gleichung 1208 aus Abschnitt 3.2.21}', '\\text{Gleichung 1208 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1208 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1518, '3.1209', 37, 'Gleichung 3.1209', '\\text{Gleichung 1209 aus Abschnitt 3.2.21}', '\\text{Gleichung 1209 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1209 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1519, '3.1210', 37, 'Gleichung 3.1210', '\\text{Gleichung 1210 aus Abschnitt 3.2.21}', '\\text{Gleichung 1210 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1210 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1520, '3.1211', 37, 'Gleichung 3.1211', '\\text{Gleichung 1211 aus Abschnitt 3.2.21}', '\\text{Gleichung 1211 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1211 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1521, '3.1212', 37, 'Gleichung 3.1212', '\\text{Gleichung 1212 aus Abschnitt 3.2.21}', '\\text{Gleichung 1212 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1212 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1522, '3.1213', 37, 'Gleichung 3.1213', '\\text{Gleichung 1213 aus Abschnitt 3.2.21}', '\\text{Gleichung 1213 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1213 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1523, '3.1214', 37, 'Gleichung 3.1214', '\\text{Gleichung 1214 aus Abschnitt 3.2.21}', '\\text{Gleichung 1214 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1214 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1524, '3.1215', 37, 'Gleichung 3.1215', '\\text{Gleichung 1215 aus Abschnitt 3.2.21}', '\\text{Gleichung 1215 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1215 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1525, '3.1216', 37, 'Gleichung 3.1216', '\\text{Gleichung 1216 aus Abschnitt 3.2.21}', '\\text{Gleichung 1216 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1216 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1526, '3.1217', 37, 'Gleichung 3.1217', '\\text{Gleichung 1217 aus Abschnitt 3.2.21}', '\\text{Gleichung 1217 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1217 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1527, '3.1218', 37, 'Gleichung 3.1218', '\\text{Gleichung 1218 aus Abschnitt 3.2.21}', '\\text{Gleichung 1218 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1218 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1528, '3.1219', 37, 'Gleichung 3.1219', '\\text{Gleichung 1219 aus Abschnitt 3.2.21}', '\\text{Gleichung 1219 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1219 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1529, '3.1220', 37, 'Gleichung 3.1220', '\\text{Gleichung 1220 aus Abschnitt 3.2.21}', '\\text{Gleichung 1220 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1220 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1530, '3.1221', 37, 'Gleichung 3.1221', '\\text{Gleichung 1221 aus Abschnitt 3.2.21}', '\\text{Gleichung 1221 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1221 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1531, '3.1222', 37, 'Gleichung 3.1222', '\\text{Gleichung 1222 aus Abschnitt 3.2.21}', '\\text{Gleichung 1222 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1222 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1532, '3.1223', 37, 'Gleichung 3.1223', '\\text{Gleichung 1223 aus Abschnitt 3.2.21}', '\\text{Gleichung 1223 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1223 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1533, '3.1224', 37, 'Gleichung 3.1224', '\\text{Gleichung 1224 aus Abschnitt 3.2.21}', '\\text{Gleichung 1224 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1224 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1534, '3.1225', 37, 'Gleichung 3.1225', '\\text{Gleichung 1225 aus Abschnitt 3.2.21}', '\\text{Gleichung 1225 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1225 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1535, '3.1226', 37, 'Gleichung 3.1226', '\\text{Gleichung 1226 aus Abschnitt 3.2.21}', '\\text{Gleichung 1226 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1226 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1536, '3.1227', 37, 'Gleichung 3.1227', '\\text{Gleichung 1227 aus Abschnitt 3.2.21}', '\\text{Gleichung 1227 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1227 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1537, '3.1228', 37, 'Gleichung 3.1228', '\\text{Gleichung 1228 aus Abschnitt 3.2.21}', '\\text{Gleichung 1228 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1228 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1538, '3.1229', 37, 'Gleichung 3.1229', '\\text{Gleichung 1229 aus Abschnitt 3.2.21}', '\\text{Gleichung 1229 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1229 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1539, '3.1230', 37, 'Gleichung 3.1230', '\\text{Gleichung 1230 aus Abschnitt 3.2.21}', '\\text{Gleichung 1230 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1230 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1540, '3.1231', 37, 'Gleichung 3.1231', '\\text{Gleichung 1231 aus Abschnitt 3.2.21}', '\\text{Gleichung 1231 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1231 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1541, '3.1232', 37, 'Gleichung 3.1232', '\\text{Gleichung 1232 aus Abschnitt 3.2.21}', '\\text{Gleichung 1232 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1232 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1542, '3.1233', 37, 'Gleichung 3.1233', '\\text{Gleichung 1233 aus Abschnitt 3.2.21}', '\\text{Gleichung 1233 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1233 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1543, '3.1234', 37, 'Gleichung 3.1234', '\\text{Gleichung 1234 aus Abschnitt 3.2.21}', '\\text{Gleichung 1234 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1234 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1544, '3.1235', 37, 'Gleichung 3.1235', '\\text{Gleichung 1235 aus Abschnitt 3.2.21}', '\\text{Gleichung 1235 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1235 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1545, '3.1236', 37, 'Gleichung 3.1236', '\\text{Gleichung 1236 aus Abschnitt 3.2.21}', '\\text{Gleichung 1236 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1236 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1546, '3.1237', 37, 'Gleichung 3.1237', '\\text{Gleichung 1237 aus Abschnitt 3.2.21}', '\\text{Gleichung 1237 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1237 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1547, '3.1238', 37, 'Gleichung 3.1238', '\\text{Gleichung 1238 aus Abschnitt 3.2.21}', '\\text{Gleichung 1238 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1238 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1548, '3.1239', 37, 'Gleichung 3.1239', '\\text{Gleichung 1239 aus Abschnitt 3.2.21}', '\\text{Gleichung 1239 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1239 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1549, '3.1240', 37, 'Gleichung 3.1240', '\\text{Gleichung 1240 aus Abschnitt 3.2.21}', '\\text{Gleichung 1240 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1240 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1550, '3.1241', 37, 'Gleichung 3.1241', '\\text{Gleichung 1241 aus Abschnitt 3.2.21}', '\\text{Gleichung 1241 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1241 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1551, '3.1242', 37, 'Gleichung 3.1242', '\\text{Gleichung 1242 aus Abschnitt 3.2.21}', '\\text{Gleichung 1242 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1242 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1552, '3.1243', 37, 'Gleichung 3.1243', '\\text{Gleichung 1243 aus Abschnitt 3.2.21}', '\\text{Gleichung 1243 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1243 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(1553, '3.1244', 37, 'Gleichung 3.1244', '\\text{Gleichung 1244 aus Abschnitt 3.2.21}', '\\text{Gleichung 1244 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1244 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1554, '3.1245', 37, 'Gleichung 3.1245', '\\text{Gleichung 1245 aus Abschnitt 3.2.21}', '\\text{Gleichung 1245 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1245 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1555, '3.1246', 37, 'Gleichung 3.1246', '\\text{Gleichung 1246 aus Abschnitt 3.2.21}', '\\text{Gleichung 1246 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1246 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1556, '3.1247', 37, 'Gleichung 3.1247', '\\text{Gleichung 1247 aus Abschnitt 3.2.21}', '\\text{Gleichung 1247 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1247 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1557, '3.1248', 37, 'Gleichung 3.1248', '\\text{Gleichung 1248 aus Abschnitt 3.2.21}', '\\text{Gleichung 1248 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1248 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1558, '3.1249', 37, 'Gleichung 3.1249', '\\text{Gleichung 1249 aus Abschnitt 3.2.21}', '\\text{Gleichung 1249 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1249 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1559, '3.1250', 37, 'Gleichung 3.1250', '\\text{Gleichung 1250 aus Abschnitt 3.2.21}', '\\text{Gleichung 1250 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1250 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1560, '3.1251', 37, 'Gleichung 3.1251', '\\text{Gleichung 1251 aus Abschnitt 3.2.21}', '\\text{Gleichung 1251 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1251 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1561, '3.1252', 37, 'Gleichung 3.1252', '\\text{Gleichung 1252 aus Abschnitt 3.2.21}', '\\text{Gleichung 1252 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1252 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1562, '3.1253', 37, 'Gleichung 3.1253', '\\text{Gleichung 1253 aus Abschnitt 3.2.21}', '\\text{Gleichung 1253 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1253 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1563, '3.1254', 37, 'Gleichung 3.1254', '\\text{Gleichung 1254 aus Abschnitt 3.2.21}', '\\text{Gleichung 1254 aus Abschnitt 3.2.21}', 'Formale Gleichung 3.1254 aus Abschnitt 3.2.21.', 'other', 'adapted', 83, 'Im Abschnitt 3.2.21 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.21.', 'verified', 40),
(1613, '3.1255', 38, 'Gleichung 3.1255', '\\text{Gleichung 1255 aus Abschnitt 3.2.22}', '\\text{Gleichung 1255 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1255 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1614, '3.1256', 38, 'Gleichung 3.1256', '\\text{Gleichung 1256 aus Abschnitt 3.2.22}', '\\text{Gleichung 1256 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1256 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1615, '3.1257', 38, 'Gleichung 3.1257', '\\text{Gleichung 1257 aus Abschnitt 3.2.22}', '\\text{Gleichung 1257 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1257 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1616, '3.1258', 38, 'Gleichung 3.1258', '\\text{Gleichung 1258 aus Abschnitt 3.2.22}', '\\text{Gleichung 1258 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1258 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1617, '3.1259', 38, 'Gleichung 3.1259', '\\text{Gleichung 1259 aus Abschnitt 3.2.22}', '\\text{Gleichung 1259 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1259 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1618, '3.1260', 38, 'Gleichung 3.1260', '\\text{Gleichung 1260 aus Abschnitt 3.2.22}', '\\text{Gleichung 1260 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1260 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1619, '3.1261', 38, 'Gleichung 3.1261', '\\text{Gleichung 1261 aus Abschnitt 3.2.22}', '\\text{Gleichung 1261 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1261 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1620, '3.1262', 38, 'Gleichung 3.1262', '\\text{Gleichung 1262 aus Abschnitt 3.2.22}', '\\text{Gleichung 1262 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1262 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1621, '3.1263', 38, 'Gleichung 3.1263', '\\text{Gleichung 1263 aus Abschnitt 3.2.22}', '\\text{Gleichung 1263 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1263 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1622, '3.1264', 38, 'Gleichung 3.1264', '\\text{Gleichung 1264 aus Abschnitt 3.2.22}', '\\text{Gleichung 1264 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1264 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1623, '3.1265', 38, 'Gleichung 3.1265', '\\text{Gleichung 1265 aus Abschnitt 3.2.22}', '\\text{Gleichung 1265 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1265 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1624, '3.1266', 38, 'Gleichung 3.1266', '\\text{Gleichung 1266 aus Abschnitt 3.2.22}', '\\text{Gleichung 1266 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1266 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1625, '3.1267', 38, 'Gleichung 3.1267', '\\text{Gleichung 1267 aus Abschnitt 3.2.22}', '\\text{Gleichung 1267 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1267 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1626, '3.1268', 38, 'Gleichung 3.1268', '\\text{Gleichung 1268 aus Abschnitt 3.2.22}', '\\text{Gleichung 1268 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1268 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1627, '3.1269', 38, 'Gleichung 3.1269', '\\text{Gleichung 1269 aus Abschnitt 3.2.22}', '\\text{Gleichung 1269 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1269 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1628, '3.1270', 38, 'Gleichung 3.1270', '\\text{Gleichung 1270 aus Abschnitt 3.2.22}', '\\text{Gleichung 1270 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1270 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1629, '3.1271', 38, 'Gleichung 3.1271', '\\text{Gleichung 1271 aus Abschnitt 3.2.22}', '\\text{Gleichung 1271 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1271 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1630, '3.1272', 38, 'Gleichung 3.1272', '\\text{Gleichung 1272 aus Abschnitt 3.2.22}', '\\text{Gleichung 1272 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1272 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1631, '3.1273', 38, 'Gleichung 3.1273', '\\text{Gleichung 1273 aus Abschnitt 3.2.22}', '\\text{Gleichung 1273 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1273 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1632, '3.1274', 38, 'Gleichung 3.1274', '\\text{Gleichung 1274 aus Abschnitt 3.2.22}', '\\text{Gleichung 1274 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1274 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1633, '3.1275', 38, 'Gleichung 3.1275', '\\text{Gleichung 1275 aus Abschnitt 3.2.22}', '\\text{Gleichung 1275 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1275 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1634, '3.1276', 38, 'Gleichung 3.1276', '\\text{Gleichung 1276 aus Abschnitt 3.2.22}', '\\text{Gleichung 1276 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1276 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1635, '3.1277', 38, 'Gleichung 3.1277', '\\text{Gleichung 1277 aus Abschnitt 3.2.22}', '\\text{Gleichung 1277 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1277 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1636, '3.1278', 38, 'Gleichung 3.1278', '\\text{Gleichung 1278 aus Abschnitt 3.2.22}', '\\text{Gleichung 1278 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1278 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1637, '3.1279', 38, 'Gleichung 3.1279', '\\text{Gleichung 1279 aus Abschnitt 3.2.22}', '\\text{Gleichung 1279 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1279 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1638, '3.1280', 38, 'Gleichung 3.1280', '\\text{Gleichung 1280 aus Abschnitt 3.2.22}', '\\text{Gleichung 1280 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1280 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1639, '3.1281', 38, 'Gleichung 3.1281', '\\text{Gleichung 1281 aus Abschnitt 3.2.22}', '\\text{Gleichung 1281 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1281 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1640, '3.1282', 38, 'Gleichung 3.1282', '\\text{Gleichung 1282 aus Abschnitt 3.2.22}', '\\text{Gleichung 1282 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1282 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1641, '3.1283', 38, 'Gleichung 3.1283', '\\text{Gleichung 1283 aus Abschnitt 3.2.22}', '\\text{Gleichung 1283 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1283 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1642, '3.1284', 38, 'Gleichung 3.1284', '\\text{Gleichung 1284 aus Abschnitt 3.2.22}', '\\text{Gleichung 1284 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1284 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1643, '3.1285', 38, 'Gleichung 3.1285', '\\text{Gleichung 1285 aus Abschnitt 3.2.22}', '\\text{Gleichung 1285 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1285 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1644, '3.1286', 38, 'Gleichung 3.1286', '\\text{Gleichung 1286 aus Abschnitt 3.2.22}', '\\text{Gleichung 1286 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1286 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1645, '3.1287', 38, 'Gleichung 3.1287', '\\text{Gleichung 1287 aus Abschnitt 3.2.22}', '\\text{Gleichung 1287 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1287 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1646, '3.1288', 38, 'Gleichung 3.1288', '\\text{Gleichung 1288 aus Abschnitt 3.2.22}', '\\text{Gleichung 1288 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1288 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1647, '3.1289', 38, 'Gleichung 3.1289', '\\text{Gleichung 1289 aus Abschnitt 3.2.22}', '\\text{Gleichung 1289 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1289 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1648, '3.1290', 38, 'Gleichung 3.1290', '\\text{Gleichung 1290 aus Abschnitt 3.2.22}', '\\text{Gleichung 1290 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1290 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1649, '3.1291', 38, 'Gleichung 3.1291', '\\text{Gleichung 1291 aus Abschnitt 3.2.22}', '\\text{Gleichung 1291 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1291 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1650, '3.1292', 38, 'Gleichung 3.1292', '\\text{Gleichung 1292 aus Abschnitt 3.2.22}', '\\text{Gleichung 1292 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1292 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1651, '3.1293', 38, 'Gleichung 3.1293', '\\text{Gleichung 1293 aus Abschnitt 3.2.22}', '\\text{Gleichung 1293 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1293 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1652, '3.1294', 38, 'Gleichung 3.1294', '\\text{Gleichung 1294 aus Abschnitt 3.2.22}', '\\text{Gleichung 1294 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1294 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1653, '3.1295', 38, 'Gleichung 3.1295', '\\text{Gleichung 1295 aus Abschnitt 3.2.22}', '\\text{Gleichung 1295 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1295 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1654, '3.1296', 38, 'Gleichung 3.1296', '\\text{Gleichung 1296 aus Abschnitt 3.2.22}', '\\text{Gleichung 1296 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1296 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1655, '3.1297', 38, 'Gleichung 3.1297', '\\text{Gleichung 1297 aus Abschnitt 3.2.22}', '\\text{Gleichung 1297 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1297 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1656, '3.1298', 38, 'Gleichung 3.1298', '\\text{Gleichung 1298 aus Abschnitt 3.2.22}', '\\text{Gleichung 1298 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1298 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1657, '3.1299', 38, 'Gleichung 3.1299', '\\text{Gleichung 1299 aus Abschnitt 3.2.22}', '\\text{Gleichung 1299 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1299 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1658, '3.1300', 38, 'Gleichung 3.1300', '\\text{Gleichung 1300 aus Abschnitt 3.2.22}', '\\text{Gleichung 1300 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1300 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1659, '3.1301', 38, 'Gleichung 3.1301', '\\text{Gleichung 1301 aus Abschnitt 3.2.22}', '\\text{Gleichung 1301 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1301 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1660, '3.1302', 38, 'Gleichung 3.1302', '\\text{Gleichung 1302 aus Abschnitt 3.2.22}', '\\text{Gleichung 1302 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1302 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1661, '3.1303', 38, 'Gleichung 3.1303', '\\text{Gleichung 1303 aus Abschnitt 3.2.22}', '\\text{Gleichung 1303 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1303 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1662, '3.1304', 38, 'Gleichung 3.1304', '\\text{Gleichung 1304 aus Abschnitt 3.2.22}', '\\text{Gleichung 1304 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1304 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1663, '3.1305', 38, 'Gleichung 3.1305', '\\text{Gleichung 1305 aus Abschnitt 3.2.22}', '\\text{Gleichung 1305 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1305 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1664, '3.1306', 38, 'Gleichung 3.1306', '\\text{Gleichung 1306 aus Abschnitt 3.2.22}', '\\text{Gleichung 1306 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1306 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1665, '3.1307', 38, 'Gleichung 3.1307', '\\text{Gleichung 1307 aus Abschnitt 3.2.22}', '\\text{Gleichung 1307 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1307 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1666, '3.1308', 38, 'Gleichung 3.1308', '\\text{Gleichung 1308 aus Abschnitt 3.2.22}', '\\text{Gleichung 1308 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1308 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1667, '3.1309', 38, 'Gleichung 3.1309', '\\text{Gleichung 1309 aus Abschnitt 3.2.22}', '\\text{Gleichung 1309 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1309 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1668, '3.1310', 38, 'Gleichung 3.1310', '\\text{Gleichung 1310 aus Abschnitt 3.2.22}', '\\text{Gleichung 1310 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1310 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1669, '3.1311', 38, 'Gleichung 3.1311', '\\text{Gleichung 1311 aus Abschnitt 3.2.22}', '\\text{Gleichung 1311 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1311 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1670, '3.1312', 38, 'Gleichung 3.1312', '\\text{Gleichung 1312 aus Abschnitt 3.2.22}', '\\text{Gleichung 1312 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1312 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1671, '3.1313', 38, 'Gleichung 3.1313', '\\text{Gleichung 1313 aus Abschnitt 3.2.22}', '\\text{Gleichung 1313 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1313 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1672, '3.1314', 38, 'Gleichung 3.1314', '\\text{Gleichung 1314 aus Abschnitt 3.2.22}', '\\text{Gleichung 1314 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1314 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1673, '3.1315', 38, 'Gleichung 3.1315', '\\text{Gleichung 1315 aus Abschnitt 3.2.22}', '\\text{Gleichung 1315 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1315 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1674, '3.1316', 38, 'Gleichung 3.1316', '\\text{Gleichung 1316 aus Abschnitt 3.2.22}', '\\text{Gleichung 1316 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1316 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1675, '3.1317', 38, 'Gleichung 3.1317', '\\text{Gleichung 1317 aus Abschnitt 3.2.22}', '\\text{Gleichung 1317 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1317 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1676, '3.1318', 38, 'Gleichung 3.1318', '\\text{Gleichung 1318 aus Abschnitt 3.2.22}', '\\text{Gleichung 1318 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1318 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1677, '3.1319', 38, 'Gleichung 3.1319', '\\text{Gleichung 1319 aus Abschnitt 3.2.22}', '\\text{Gleichung 1319 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1319 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1678, '3.1320', 38, 'Gleichung 3.1320', '\\text{Gleichung 1320 aus Abschnitt 3.2.22}', '\\text{Gleichung 1320 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1320 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1679, '3.1321', 38, 'Gleichung 3.1321', '\\text{Gleichung 1321 aus Abschnitt 3.2.22}', '\\text{Gleichung 1321 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1321 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1680, '3.1322', 38, 'Gleichung 3.1322', '\\text{Gleichung 1322 aus Abschnitt 3.2.22}', '\\text{Gleichung 1322 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1322 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1681, '3.1323', 38, 'Gleichung 3.1323', '\\text{Gleichung 1323 aus Abschnitt 3.2.22}', '\\text{Gleichung 1323 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1323 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1682, '3.1324', 38, 'Gleichung 3.1324', '\\text{Gleichung 1324 aus Abschnitt 3.2.22}', '\\text{Gleichung 1324 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1324 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1683, '3.1325', 38, 'Gleichung 3.1325', '\\text{Gleichung 1325 aus Abschnitt 3.2.22}', '\\text{Gleichung 1325 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1325 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1684, '3.1326', 38, 'Gleichung 3.1326', '\\text{Gleichung 1326 aus Abschnitt 3.2.22}', '\\text{Gleichung 1326 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1326 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1685, '3.1327', 38, 'Gleichung 3.1327', '\\text{Gleichung 1327 aus Abschnitt 3.2.22}', '\\text{Gleichung 1327 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1327 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1686, '3.1328', 38, 'Gleichung 3.1328', '\\text{Gleichung 1328 aus Abschnitt 3.2.22}', '\\text{Gleichung 1328 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1328 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1687, '3.1329', 38, 'Gleichung 3.1329', '\\text{Gleichung 1329 aus Abschnitt 3.2.22}', '\\text{Gleichung 1329 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1329 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1688, '3.1330', 38, 'Gleichung 3.1330', '\\text{Gleichung 1330 aus Abschnitt 3.2.22}', '\\text{Gleichung 1330 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1330 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1689, '3.1331', 38, 'Gleichung 3.1331', '\\text{Gleichung 1331 aus Abschnitt 3.2.22}', '\\text{Gleichung 1331 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1331 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1690, '3.1332', 38, 'Gleichung 3.1332', '\\text{Gleichung 1332 aus Abschnitt 3.2.22}', '\\text{Gleichung 1332 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1332 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1691, '3.1333', 38, 'Gleichung 3.1333', '\\text{Gleichung 1333 aus Abschnitt 3.2.22}', '\\text{Gleichung 1333 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1333 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1692, '3.1334', 38, 'Gleichung 3.1334', '\\text{Gleichung 1334 aus Abschnitt 3.2.22}', '\\text{Gleichung 1334 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1334 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1693, '3.1335', 38, 'Gleichung 3.1335', '\\text{Gleichung 1335 aus Abschnitt 3.2.22}', '\\text{Gleichung 1335 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1335 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1694, '3.1336', 38, 'Gleichung 3.1336', '\\text{Gleichung 1336 aus Abschnitt 3.2.22}', '\\text{Gleichung 1336 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1336 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1695, '3.1337', 38, 'Gleichung 3.1337', '\\text{Gleichung 1337 aus Abschnitt 3.2.22}', '\\text{Gleichung 1337 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1337 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1696, '3.1338', 38, 'Gleichung 3.1338', '\\text{Gleichung 1338 aus Abschnitt 3.2.22}', '\\text{Gleichung 1338 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1338 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1697, '3.1339', 38, 'Gleichung 3.1339', '\\text{Gleichung 1339 aus Abschnitt 3.2.22}', '\\text{Gleichung 1339 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1339 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1698, '3.1340', 38, 'Gleichung 3.1340', '\\text{Gleichung 1340 aus Abschnitt 3.2.22}', '\\text{Gleichung 1340 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1340 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1699, '3.1341', 38, 'Gleichung 3.1341', '\\text{Gleichung 1341 aus Abschnitt 3.2.22}', '\\text{Gleichung 1341 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1341 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1700, '3.1342', 38, 'Gleichung 3.1342', '\\text{Gleichung 1342 aus Abschnitt 3.2.22}', '\\text{Gleichung 1342 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1342 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1701, '3.1343', 38, 'Gleichung 3.1343', '\\text{Gleichung 1343 aus Abschnitt 3.2.22}', '\\text{Gleichung 1343 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1343 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1702, '3.1344', 38, 'Gleichung 3.1344', '\\text{Gleichung 1344 aus Abschnitt 3.2.22}', '\\text{Gleichung 1344 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1344 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1703, '3.1345', 38, 'Gleichung 3.1345', '\\text{Gleichung 1345 aus Abschnitt 3.2.22}', '\\text{Gleichung 1345 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1345 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1704, '3.1346', 38, 'Gleichung 3.1346', '\\text{Gleichung 1346 aus Abschnitt 3.2.22}', '\\text{Gleichung 1346 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1346 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1705, '3.1347', 38, 'Gleichung 3.1347', '\\text{Gleichung 1347 aus Abschnitt 3.2.22}', '\\text{Gleichung 1347 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1347 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1706, '3.1348', 38, 'Gleichung 3.1348', '\\text{Gleichung 1348 aus Abschnitt 3.2.22}', '\\text{Gleichung 1348 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1348 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1707, '3.1349', 38, 'Gleichung 3.1349', '\\text{Gleichung 1349 aus Abschnitt 3.2.22}', '\\text{Gleichung 1349 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1349 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1708, '3.1350', 38, 'Gleichung 3.1350', '\\text{Gleichung 1350 aus Abschnitt 3.2.22}', '\\text{Gleichung 1350 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1350 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1709, '3.1351', 38, 'Gleichung 3.1351', '\\text{Gleichung 1351 aus Abschnitt 3.2.22}', '\\text{Gleichung 1351 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1351 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1710, '3.1352', 38, 'Gleichung 3.1352', '\\text{Gleichung 1352 aus Abschnitt 3.2.22}', '\\text{Gleichung 1352 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1352 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1711, '3.1353', 38, 'Gleichung 3.1353', '\\text{Gleichung 1353 aus Abschnitt 3.2.22}', '\\text{Gleichung 1353 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1353 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1712, '3.1354', 38, 'Gleichung 3.1354', '\\text{Gleichung 1354 aus Abschnitt 3.2.22}', '\\text{Gleichung 1354 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1354 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1713, '3.1355', 38, 'Gleichung 3.1355', '\\text{Gleichung 1355 aus Abschnitt 3.2.22}', '\\text{Gleichung 1355 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1355 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1714, '3.1356', 38, 'Gleichung 3.1356', '\\text{Gleichung 1356 aus Abschnitt 3.2.22}', '\\text{Gleichung 1356 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1356 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1715, '3.1357', 38, 'Gleichung 3.1357', '\\text{Gleichung 1357 aus Abschnitt 3.2.22}', '\\text{Gleichung 1357 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1357 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1716, '3.1358', 38, 'Gleichung 3.1358', '\\text{Gleichung 1358 aus Abschnitt 3.2.22}', '\\text{Gleichung 1358 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1358 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1717, '3.1359', 38, 'Gleichung 3.1359', '\\text{Gleichung 1359 aus Abschnitt 3.2.22}', '\\text{Gleichung 1359 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1359 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1718, '3.1360', 38, 'Gleichung 3.1360', '\\text{Gleichung 1360 aus Abschnitt 3.2.22}', '\\text{Gleichung 1360 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1360 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1719, '3.1361', 38, 'Gleichung 3.1361', '\\text{Gleichung 1361 aus Abschnitt 3.2.22}', '\\text{Gleichung 1361 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1361 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1720, '3.1362', 38, 'Gleichung 3.1362', '\\text{Gleichung 1362 aus Abschnitt 3.2.22}', '\\text{Gleichung 1362 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1362 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1721, '3.1363', 38, 'Gleichung 3.1363', '\\text{Gleichung 1363 aus Abschnitt 3.2.22}', '\\text{Gleichung 1363 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1363 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1722, '3.1364', 38, 'Gleichung 3.1364', '\\text{Gleichung 1364 aus Abschnitt 3.2.22}', '\\text{Gleichung 1364 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1364 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1723, '3.1365', 38, 'Gleichung 3.1365', '\\text{Gleichung 1365 aus Abschnitt 3.2.22}', '\\text{Gleichung 1365 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1365 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1724, '3.1366', 38, 'Gleichung 3.1366', '\\text{Gleichung 1366 aus Abschnitt 3.2.22}', '\\text{Gleichung 1366 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1366 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1725, '3.1367', 38, 'Gleichung 3.1367', '\\text{Gleichung 1367 aus Abschnitt 3.2.22}', '\\text{Gleichung 1367 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1367 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1726, '3.1368', 38, 'Gleichung 3.1368', '\\text{Gleichung 1368 aus Abschnitt 3.2.22}', '\\text{Gleichung 1368 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1368 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1727, '3.1369', 38, 'Gleichung 3.1369', '\\text{Gleichung 1369 aus Abschnitt 3.2.22}', '\\text{Gleichung 1369 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1369 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1728, '3.1370', 38, 'Gleichung 3.1370', '\\text{Gleichung 1370 aus Abschnitt 3.2.22}', '\\text{Gleichung 1370 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1370 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1729, '3.1371', 38, 'Gleichung 3.1371', '\\text{Gleichung 1371 aus Abschnitt 3.2.22}', '\\text{Gleichung 1371 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1371 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1730, '3.1372', 38, 'Gleichung 3.1372', '\\text{Gleichung 1372 aus Abschnitt 3.2.22}', '\\text{Gleichung 1372 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1372 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1731, '3.1373', 38, 'Gleichung 3.1373', '\\text{Gleichung 1373 aus Abschnitt 3.2.22}', '\\text{Gleichung 1373 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1373 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1732, '3.1374', 38, 'Gleichung 3.1374', '\\text{Gleichung 1374 aus Abschnitt 3.2.22}', '\\text{Gleichung 1374 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1374 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1733, '3.1375', 38, 'Gleichung 3.1375', '\\text{Gleichung 1375 aus Abschnitt 3.2.22}', '\\text{Gleichung 1375 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1375 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1734, '3.1376', 38, 'Gleichung 3.1376', '\\text{Gleichung 1376 aus Abschnitt 3.2.22}', '\\text{Gleichung 1376 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1376 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1735, '3.1377', 38, 'Gleichung 3.1377', '\\text{Gleichung 1377 aus Abschnitt 3.2.22}', '\\text{Gleichung 1377 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1377 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1736, '3.1378', 38, 'Gleichung 3.1378', '\\text{Gleichung 1378 aus Abschnitt 3.2.22}', '\\text{Gleichung 1378 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1378 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1737, '3.1379', 38, 'Gleichung 3.1379', '\\text{Gleichung 1379 aus Abschnitt 3.2.22}', '\\text{Gleichung 1379 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1379 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1738, '3.1380', 38, 'Gleichung 3.1380', '\\text{Gleichung 1380 aus Abschnitt 3.2.22}', '\\text{Gleichung 1380 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1380 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1739, '3.1381', 38, 'Gleichung 3.1381', '\\text{Gleichung 1381 aus Abschnitt 3.2.22}', '\\text{Gleichung 1381 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1381 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1740, '3.1382', 38, 'Gleichung 3.1382', '\\text{Gleichung 1382 aus Abschnitt 3.2.22}', '\\text{Gleichung 1382 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1382 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1741, '3.1383', 38, 'Gleichung 3.1383', '\\text{Gleichung 1383 aus Abschnitt 3.2.22}', '\\text{Gleichung 1383 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1383 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1742, '3.1384', 38, 'Gleichung 3.1384', '\\text{Gleichung 1384 aus Abschnitt 3.2.22}', '\\text{Gleichung 1384 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1384 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1743, '3.1385', 38, 'Gleichung 3.1385', '\\text{Gleichung 1385 aus Abschnitt 3.2.22}', '\\text{Gleichung 1385 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1385 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1744, '3.1386', 38, 'Gleichung 3.1386', '\\text{Gleichung 1386 aus Abschnitt 3.2.22}', '\\text{Gleichung 1386 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1386 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1745, '3.1387', 38, 'Gleichung 3.1387', '\\text{Gleichung 1387 aus Abschnitt 3.2.22}', '\\text{Gleichung 1387 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1387 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1746, '3.1388', 38, 'Gleichung 3.1388', '\\text{Gleichung 1388 aus Abschnitt 3.2.22}', '\\text{Gleichung 1388 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1388 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1747, '3.1389', 38, 'Gleichung 3.1389', '\\text{Gleichung 1389 aus Abschnitt 3.2.22}', '\\text{Gleichung 1389 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1389 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1748, '3.1390', 38, 'Gleichung 3.1390', '\\text{Gleichung 1390 aus Abschnitt 3.2.22}', '\\text{Gleichung 1390 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1390 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1749, '3.1391', 38, 'Gleichung 3.1391', '\\text{Gleichung 1391 aus Abschnitt 3.2.22}', '\\text{Gleichung 1391 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1391 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1750, '3.1392', 38, 'Gleichung 3.1392', '\\text{Gleichung 1392 aus Abschnitt 3.2.22}', '\\text{Gleichung 1392 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1392 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1751, '3.1393', 38, 'Gleichung 3.1393', '\\text{Gleichung 1393 aus Abschnitt 3.2.22}', '\\text{Gleichung 1393 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1393 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1752, '3.1394', 38, 'Gleichung 3.1394', '\\text{Gleichung 1394 aus Abschnitt 3.2.22}', '\\text{Gleichung 1394 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1394 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(1753, '3.1395', 38, 'Gleichung 3.1395', '\\text{Gleichung 1395 aus Abschnitt 3.2.22}', '\\text{Gleichung 1395 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1395 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1754, '3.1396', 38, 'Gleichung 3.1396', '\\text{Gleichung 1396 aus Abschnitt 3.2.22}', '\\text{Gleichung 1396 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1396 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1755, '3.1397', 38, 'Gleichung 3.1397', '\\text{Gleichung 1397 aus Abschnitt 3.2.22}', '\\text{Gleichung 1397 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1397 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1756, '3.1398', 38, 'Gleichung 3.1398', '\\text{Gleichung 1398 aus Abschnitt 3.2.22}', '\\text{Gleichung 1398 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1398 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1757, '3.1399', 38, 'Gleichung 3.1399', '\\text{Gleichung 1399 aus Abschnitt 3.2.22}', '\\text{Gleichung 1399 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1399 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1758, '3.1400', 38, 'Gleichung 3.1400', '\\text{Gleichung 1400 aus Abschnitt 3.2.22}', '\\text{Gleichung 1400 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1400 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1759, '3.1401', 38, 'Gleichung 3.1401', '\\text{Gleichung 1401 aus Abschnitt 3.2.22}', '\\text{Gleichung 1401 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1401 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1760, '3.1402', 38, 'Gleichung 3.1402', '\\text{Gleichung 1402 aus Abschnitt 3.2.22}', '\\text{Gleichung 1402 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1402 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1761, '3.1403', 38, 'Gleichung 3.1403', '\\text{Gleichung 1403 aus Abschnitt 3.2.22}', '\\text{Gleichung 1403 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1403 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1762, '3.1404', 38, 'Gleichung 3.1404', '\\text{Gleichung 1404 aus Abschnitt 3.2.22}', '\\text{Gleichung 1404 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1404 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1763, '3.1405', 38, 'Gleichung 3.1405', '\\text{Gleichung 1405 aus Abschnitt 3.2.22}', '\\text{Gleichung 1405 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1405 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1764, '3.1406', 38, 'Gleichung 3.1406', '\\text{Gleichung 1406 aus Abschnitt 3.2.22}', '\\text{Gleichung 1406 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1406 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1765, '3.1407', 38, 'Gleichung 3.1407', '\\text{Gleichung 1407 aus Abschnitt 3.2.22}', '\\text{Gleichung 1407 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1407 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1766, '3.1408', 38, 'Gleichung 3.1408', '\\text{Gleichung 1408 aus Abschnitt 3.2.22}', '\\text{Gleichung 1408 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1408 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1767, '3.1409', 38, 'Gleichung 3.1409', '\\text{Gleichung 1409 aus Abschnitt 3.2.22}', '\\text{Gleichung 1409 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1409 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1768, '3.1410', 38, 'Gleichung 3.1410', '\\text{Gleichung 1410 aus Abschnitt 3.2.22}', '\\text{Gleichung 1410 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1410 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1769, '3.1411', 38, 'Gleichung 3.1411', '\\text{Gleichung 1411 aus Abschnitt 3.2.22}', '\\text{Gleichung 1411 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1411 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1770, '3.1412', 38, 'Gleichung 3.1412', '\\text{Gleichung 1412 aus Abschnitt 3.2.22}', '\\text{Gleichung 1412 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1412 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1771, '3.1413', 38, 'Gleichung 3.1413', '\\text{Gleichung 1413 aus Abschnitt 3.2.22}', '\\text{Gleichung 1413 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1413 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1772, '3.1414', 38, 'Gleichung 3.1414', '\\text{Gleichung 1414 aus Abschnitt 3.2.22}', '\\text{Gleichung 1414 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1414 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1773, '3.1415', 38, 'Gleichung 3.1415', '\\text{Gleichung 1415 aus Abschnitt 3.2.22}', '\\text{Gleichung 1415 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1415 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1774, '3.1416', 38, 'Gleichung 3.1416', '\\text{Gleichung 1416 aus Abschnitt 3.2.22}', '\\text{Gleichung 1416 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1416 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1775, '3.1417', 38, 'Gleichung 3.1417', '\\text{Gleichung 1417 aus Abschnitt 3.2.22}', '\\text{Gleichung 1417 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1417 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1776, '3.1418', 38, 'Gleichung 3.1418', '\\text{Gleichung 1418 aus Abschnitt 3.2.22}', '\\text{Gleichung 1418 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1418 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1777, '3.1419', 38, 'Gleichung 3.1419', '\\text{Gleichung 1419 aus Abschnitt 3.2.22}', '\\text{Gleichung 1419 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1419 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1778, '3.1420', 38, 'Gleichung 3.1420', '\\text{Gleichung 1420 aus Abschnitt 3.2.22}', '\\text{Gleichung 1420 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1420 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1779, '3.1421', 38, 'Gleichung 3.1421', '\\text{Gleichung 1421 aus Abschnitt 3.2.22}', '\\text{Gleichung 1421 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1421 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1780, '3.1422', 38, 'Gleichung 3.1422', '\\text{Gleichung 1422 aus Abschnitt 3.2.22}', '\\text{Gleichung 1422 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1422 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1781, '3.1423', 38, 'Gleichung 3.1423', '\\text{Gleichung 1423 aus Abschnitt 3.2.22}', '\\text{Gleichung 1423 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1423 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1782, '3.1424', 38, 'Gleichung 3.1424', '\\text{Gleichung 1424 aus Abschnitt 3.2.22}', '\\text{Gleichung 1424 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1424 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1783, '3.1425', 38, 'Gleichung 3.1425', '\\text{Gleichung 1425 aus Abschnitt 3.2.22}', '\\text{Gleichung 1425 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1425 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1784, '3.1426', 38, 'Gleichung 3.1426', '\\text{Gleichung 1426 aus Abschnitt 3.2.22}', '\\text{Gleichung 1426 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1426 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1785, '3.1427', 38, 'Gleichung 3.1427', '\\text{Gleichung 1427 aus Abschnitt 3.2.22}', '\\text{Gleichung 1427 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1427 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1786, '3.1428', 38, 'Gleichung 3.1428', '\\text{Gleichung 1428 aus Abschnitt 3.2.22}', '\\text{Gleichung 1428 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1428 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1787, '3.1429', 38, 'Gleichung 3.1429', '\\text{Gleichung 1429 aus Abschnitt 3.2.22}', '\\text{Gleichung 1429 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1429 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1788, '3.1430', 38, 'Gleichung 3.1430', '\\text{Gleichung 1430 aus Abschnitt 3.2.22}', '\\text{Gleichung 1430 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1430 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1789, '3.1431', 38, 'Gleichung 3.1431', '\\text{Gleichung 1431 aus Abschnitt 3.2.22}', '\\text{Gleichung 1431 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1431 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1790, '3.1432', 38, 'Gleichung 3.1432', '\\text{Gleichung 1432 aus Abschnitt 3.2.22}', '\\text{Gleichung 1432 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1432 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1791, '3.1433', 38, 'Gleichung 3.1433', '\\text{Gleichung 1433 aus Abschnitt 3.2.22}', '\\text{Gleichung 1433 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1433 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1792, '3.1434', 38, 'Gleichung 3.1434', '\\text{Gleichung 1434 aus Abschnitt 3.2.22}', '\\text{Gleichung 1434 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1434 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1793, '3.1435', 38, 'Gleichung 3.1435', '\\text{Gleichung 1435 aus Abschnitt 3.2.22}', '\\text{Gleichung 1435 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1435 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1794, '3.1436', 38, 'Gleichung 3.1436', '\\text{Gleichung 1436 aus Abschnitt 3.2.22}', '\\text{Gleichung 1436 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1436 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1795, '3.1437', 38, 'Gleichung 3.1437', '\\text{Gleichung 1437 aus Abschnitt 3.2.22}', '\\text{Gleichung 1437 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1437 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1796, '3.1438', 38, 'Gleichung 3.1438', '\\text{Gleichung 1438 aus Abschnitt 3.2.22}', '\\text{Gleichung 1438 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1438 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1797, '3.1439', 38, 'Gleichung 3.1439', '\\text{Gleichung 1439 aus Abschnitt 3.2.22}', '\\text{Gleichung 1439 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1439 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1798, '3.1440', 38, 'Gleichung 3.1440', '\\text{Gleichung 1440 aus Abschnitt 3.2.22}', '\\text{Gleichung 1440 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1440 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1799, '3.1441', 38, 'Gleichung 3.1441', '\\text{Gleichung 1441 aus Abschnitt 3.2.22}', '\\text{Gleichung 1441 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1441 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1800, '3.1442', 38, 'Gleichung 3.1442', '\\text{Gleichung 1442 aus Abschnitt 3.2.22}', '\\text{Gleichung 1442 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1442 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1801, '3.1443', 38, 'Gleichung 3.1443', '\\text{Gleichung 1443 aus Abschnitt 3.2.22}', '\\text{Gleichung 1443 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1443 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1802, '3.1444', 38, 'Gleichung 3.1444', '\\text{Gleichung 1444 aus Abschnitt 3.2.22}', '\\text{Gleichung 1444 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1444 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1803, '3.1445', 38, 'Gleichung 3.1445', '\\text{Gleichung 1445 aus Abschnitt 3.2.22}', '\\text{Gleichung 1445 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1445 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1804, '3.1446', 38, 'Gleichung 3.1446', '\\text{Gleichung 1446 aus Abschnitt 3.2.22}', '\\text{Gleichung 1446 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1446 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1805, '3.1447', 38, 'Gleichung 3.1447', '\\text{Gleichung 1447 aus Abschnitt 3.2.22}', '\\text{Gleichung 1447 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1447 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1806, '3.1448', 38, 'Gleichung 3.1448', '\\text{Gleichung 1448 aus Abschnitt 3.2.22}', '\\text{Gleichung 1448 aus Abschnitt 3.2.22}', 'Formale Gleichung 3.1448 aus Abschnitt 3.2.22.', 'other', 'adapted', 84, 'Im Abschnitt 3.2.22 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.22.', 'verified', 41),
(1868, '3.1449', 39, 'Gleichung 3.1449', '\\text{Gleichung 1449 aus Abschnitt 3.2.23}', '\\text{Gleichung 1449 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1449 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1869, '3.1450', 39, 'Gleichung 3.1450', '\\text{Gleichung 1450 aus Abschnitt 3.2.23}', '\\text{Gleichung 1450 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1450 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1870, '3.1451', 39, 'Gleichung 3.1451', '\\text{Gleichung 1451 aus Abschnitt 3.2.23}', '\\text{Gleichung 1451 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1451 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1871, '3.1452', 39, 'Gleichung 3.1452', '\\text{Gleichung 1452 aus Abschnitt 3.2.23}', '\\text{Gleichung 1452 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1452 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1872, '3.1453', 39, 'Gleichung 3.1453', '\\text{Gleichung 1453 aus Abschnitt 3.2.23}', '\\text{Gleichung 1453 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1453 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1873, '3.1454', 39, 'Gleichung 3.1454', '\\text{Gleichung 1454 aus Abschnitt 3.2.23}', '\\text{Gleichung 1454 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1454 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1874, '3.1455', 39, 'Gleichung 3.1455', '\\text{Gleichung 1455 aus Abschnitt 3.2.23}', '\\text{Gleichung 1455 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1455 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1875, '3.1456', 39, 'Gleichung 3.1456', '\\text{Gleichung 1456 aus Abschnitt 3.2.23}', '\\text{Gleichung 1456 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1456 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1876, '3.1457', 39, 'Gleichung 3.1457', '\\text{Gleichung 1457 aus Abschnitt 3.2.23}', '\\text{Gleichung 1457 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1457 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1877, '3.1458', 39, 'Gleichung 3.1458', '\\text{Gleichung 1458 aus Abschnitt 3.2.23}', '\\text{Gleichung 1458 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1458 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1878, '3.1459', 39, 'Gleichung 3.1459', '\\text{Gleichung 1459 aus Abschnitt 3.2.23}', '\\text{Gleichung 1459 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1459 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1879, '3.1460', 39, 'Gleichung 3.1460', '\\text{Gleichung 1460 aus Abschnitt 3.2.23}', '\\text{Gleichung 1460 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1460 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1880, '3.1461', 39, 'Gleichung 3.1461', '\\text{Gleichung 1461 aus Abschnitt 3.2.23}', '\\text{Gleichung 1461 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1461 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1881, '3.1462', 39, 'Gleichung 3.1462', '\\text{Gleichung 1462 aus Abschnitt 3.2.23}', '\\text{Gleichung 1462 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1462 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1882, '3.1463', 39, 'Gleichung 3.1463', '\\text{Gleichung 1463 aus Abschnitt 3.2.23}', '\\text{Gleichung 1463 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1463 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1883, '3.1464', 39, 'Gleichung 3.1464', '\\text{Gleichung 1464 aus Abschnitt 3.2.23}', '\\text{Gleichung 1464 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1464 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1884, '3.1465', 39, 'Gleichung 3.1465', '\\text{Gleichung 1465 aus Abschnitt 3.2.23}', '\\text{Gleichung 1465 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1465 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1885, '3.1466', 39, 'Gleichung 3.1466', '\\text{Gleichung 1466 aus Abschnitt 3.2.23}', '\\text{Gleichung 1466 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1466 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1886, '3.1467', 39, 'Gleichung 3.1467', '\\text{Gleichung 1467 aus Abschnitt 3.2.23}', '\\text{Gleichung 1467 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1467 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1887, '3.1468', 39, 'Gleichung 3.1468', '\\text{Gleichung 1468 aus Abschnitt 3.2.23}', '\\text{Gleichung 1468 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1468 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1888, '3.1469', 39, 'Gleichung 3.1469', '\\text{Gleichung 1469 aus Abschnitt 3.2.23}', '\\text{Gleichung 1469 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1469 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1889, '3.1470', 39, 'Gleichung 3.1470', '\\text{Gleichung 1470 aus Abschnitt 3.2.23}', '\\text{Gleichung 1470 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1470 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1890, '3.1471', 39, 'Gleichung 3.1471', '\\text{Gleichung 1471 aus Abschnitt 3.2.23}', '\\text{Gleichung 1471 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1471 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1891, '3.1472', 39, 'Gleichung 3.1472', '\\text{Gleichung 1472 aus Abschnitt 3.2.23}', '\\text{Gleichung 1472 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1472 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1892, '3.1473', 39, 'Gleichung 3.1473', '\\text{Gleichung 1473 aus Abschnitt 3.2.23}', '\\text{Gleichung 1473 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1473 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1893, '3.1474', 39, 'Gleichung 3.1474', '\\text{Gleichung 1474 aus Abschnitt 3.2.23}', '\\text{Gleichung 1474 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1474 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1894, '3.1475', 39, 'Gleichung 3.1475', '\\text{Gleichung 1475 aus Abschnitt 3.2.23}', '\\text{Gleichung 1475 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1475 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1895, '3.1476', 39, 'Gleichung 3.1476', '\\text{Gleichung 1476 aus Abschnitt 3.2.23}', '\\text{Gleichung 1476 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1476 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1896, '3.1477', 39, 'Gleichung 3.1477', '\\text{Gleichung 1477 aus Abschnitt 3.2.23}', '\\text{Gleichung 1477 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1477 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1897, '3.1478', 39, 'Gleichung 3.1478', '\\text{Gleichung 1478 aus Abschnitt 3.2.23}', '\\text{Gleichung 1478 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1478 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1898, '3.1479', 39, 'Gleichung 3.1479', '\\text{Gleichung 1479 aus Abschnitt 3.2.23}', '\\text{Gleichung 1479 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1479 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1899, '3.1480', 39, 'Gleichung 3.1480', '\\text{Gleichung 1480 aus Abschnitt 3.2.23}', '\\text{Gleichung 1480 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1480 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1900, '3.1481', 39, 'Gleichung 3.1481', '\\text{Gleichung 1481 aus Abschnitt 3.2.23}', '\\text{Gleichung 1481 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1481 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1901, '3.1482', 39, 'Gleichung 3.1482', '\\text{Gleichung 1482 aus Abschnitt 3.2.23}', '\\text{Gleichung 1482 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1482 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1902, '3.1483', 39, 'Gleichung 3.1483', '\\text{Gleichung 1483 aus Abschnitt 3.2.23}', '\\text{Gleichung 1483 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1483 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1903, '3.1484', 39, 'Gleichung 3.1484', '\\text{Gleichung 1484 aus Abschnitt 3.2.23}', '\\text{Gleichung 1484 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1484 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1904, '3.1485', 39, 'Gleichung 3.1485', '\\text{Gleichung 1485 aus Abschnitt 3.2.23}', '\\text{Gleichung 1485 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1485 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1905, '3.1486', 39, 'Gleichung 3.1486', '\\text{Gleichung 1486 aus Abschnitt 3.2.23}', '\\text{Gleichung 1486 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1486 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1906, '3.1487', 39, 'Gleichung 3.1487', '\\text{Gleichung 1487 aus Abschnitt 3.2.23}', '\\text{Gleichung 1487 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1487 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1907, '3.1488', 39, 'Gleichung 3.1488', '\\text{Gleichung 1488 aus Abschnitt 3.2.23}', '\\text{Gleichung 1488 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1488 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1908, '3.1489', 39, 'Gleichung 3.1489', '\\text{Gleichung 1489 aus Abschnitt 3.2.23}', '\\text{Gleichung 1489 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1489 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1909, '3.1490', 39, 'Gleichung 3.1490', '\\text{Gleichung 1490 aus Abschnitt 3.2.23}', '\\text{Gleichung 1490 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1490 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1910, '3.1491', 39, 'Gleichung 3.1491', '\\text{Gleichung 1491 aus Abschnitt 3.2.23}', '\\text{Gleichung 1491 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1491 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1911, '3.1492', 39, 'Gleichung 3.1492', '\\text{Gleichung 1492 aus Abschnitt 3.2.23}', '\\text{Gleichung 1492 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1492 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1912, '3.1493', 39, 'Gleichung 3.1493', '\\text{Gleichung 1493 aus Abschnitt 3.2.23}', '\\text{Gleichung 1493 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1493 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1913, '3.1494', 39, 'Gleichung 3.1494', '\\text{Gleichung 1494 aus Abschnitt 3.2.23}', '\\text{Gleichung 1494 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1494 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1914, '3.1495', 39, 'Gleichung 3.1495', '\\text{Gleichung 1495 aus Abschnitt 3.2.23}', '\\text{Gleichung 1495 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1495 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1915, '3.1496', 39, 'Gleichung 3.1496', '\\text{Gleichung 1496 aus Abschnitt 3.2.23}', '\\text{Gleichung 1496 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1496 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1916, '3.1497', 39, 'Gleichung 3.1497', '\\text{Gleichung 1497 aus Abschnitt 3.2.23}', '\\text{Gleichung 1497 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1497 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1917, '3.1498', 39, 'Gleichung 3.1498', '\\text{Gleichung 1498 aus Abschnitt 3.2.23}', '\\text{Gleichung 1498 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1498 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1918, '3.1499', 39, 'Gleichung 3.1499', '\\text{Gleichung 1499 aus Abschnitt 3.2.23}', '\\text{Gleichung 1499 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1499 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1919, '3.1500', 39, 'Gleichung 3.1500', '\\text{Gleichung 1500 aus Abschnitt 3.2.23}', '\\text{Gleichung 1500 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1500 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1920, '3.1501', 39, 'Gleichung 3.1501', '\\text{Gleichung 1501 aus Abschnitt 3.2.23}', '\\text{Gleichung 1501 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1501 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1921, '3.1502', 39, 'Gleichung 3.1502', '\\text{Gleichung 1502 aus Abschnitt 3.2.23}', '\\text{Gleichung 1502 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1502 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1922, '3.1503', 39, 'Gleichung 3.1503', '\\text{Gleichung 1503 aus Abschnitt 3.2.23}', '\\text{Gleichung 1503 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1503 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1923, '3.1504', 39, 'Gleichung 3.1504', '\\text{Gleichung 1504 aus Abschnitt 3.2.23}', '\\text{Gleichung 1504 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1504 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1924, '3.1505', 39, 'Gleichung 3.1505', '\\text{Gleichung 1505 aus Abschnitt 3.2.23}', '\\text{Gleichung 1505 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1505 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1925, '3.1506', 39, 'Gleichung 3.1506', '\\text{Gleichung 1506 aus Abschnitt 3.2.23}', '\\text{Gleichung 1506 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1506 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1926, '3.1507', 39, 'Gleichung 3.1507', '\\text{Gleichung 1507 aus Abschnitt 3.2.23}', '\\text{Gleichung 1507 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1507 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1927, '3.1508', 39, 'Gleichung 3.1508', '\\text{Gleichung 1508 aus Abschnitt 3.2.23}', '\\text{Gleichung 1508 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1508 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1928, '3.1509', 39, 'Gleichung 3.1509', '\\text{Gleichung 1509 aus Abschnitt 3.2.23}', '\\text{Gleichung 1509 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1509 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1929, '3.1510', 39, 'Gleichung 3.1510', '\\text{Gleichung 1510 aus Abschnitt 3.2.23}', '\\text{Gleichung 1510 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1510 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1930, '3.1511', 39, 'Gleichung 3.1511', '\\text{Gleichung 1511 aus Abschnitt 3.2.23}', '\\text{Gleichung 1511 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1511 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1931, '3.1512', 39, 'Gleichung 3.1512', '\\text{Gleichung 1512 aus Abschnitt 3.2.23}', '\\text{Gleichung 1512 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1512 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1932, '3.1513', 39, 'Gleichung 3.1513', '\\text{Gleichung 1513 aus Abschnitt 3.2.23}', '\\text{Gleichung 1513 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1513 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1933, '3.1514', 39, 'Gleichung 3.1514', '\\text{Gleichung 1514 aus Abschnitt 3.2.23}', '\\text{Gleichung 1514 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1514 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1934, '3.1515', 39, 'Gleichung 3.1515', '\\text{Gleichung 1515 aus Abschnitt 3.2.23}', '\\text{Gleichung 1515 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1515 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1935, '3.1516', 39, 'Gleichung 3.1516', '\\text{Gleichung 1516 aus Abschnitt 3.2.23}', '\\text{Gleichung 1516 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1516 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1936, '3.1517', 39, 'Gleichung 3.1517', '\\text{Gleichung 1517 aus Abschnitt 3.2.23}', '\\text{Gleichung 1517 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1517 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1937, '3.1518', 39, 'Gleichung 3.1518', '\\text{Gleichung 1518 aus Abschnitt 3.2.23}', '\\text{Gleichung 1518 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1518 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1938, '3.1519', 39, 'Gleichung 3.1519', '\\text{Gleichung 1519 aus Abschnitt 3.2.23}', '\\text{Gleichung 1519 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1519 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1939, '3.1520', 39, 'Gleichung 3.1520', '\\text{Gleichung 1520 aus Abschnitt 3.2.23}', '\\text{Gleichung 1520 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1520 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1940, '3.1521', 39, 'Gleichung 3.1521', '\\text{Gleichung 1521 aus Abschnitt 3.2.23}', '\\text{Gleichung 1521 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1521 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1941, '3.1522', 39, 'Gleichung 3.1522', '\\text{Gleichung 1522 aus Abschnitt 3.2.23}', '\\text{Gleichung 1522 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1522 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1942, '3.1523', 39, 'Gleichung 3.1523', '\\text{Gleichung 1523 aus Abschnitt 3.2.23}', '\\text{Gleichung 1523 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1523 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1943, '3.1524', 39, 'Gleichung 3.1524', '\\text{Gleichung 1524 aus Abschnitt 3.2.23}', '\\text{Gleichung 1524 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1524 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1944, '3.1525', 39, 'Gleichung 3.1525', '\\text{Gleichung 1525 aus Abschnitt 3.2.23}', '\\text{Gleichung 1525 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1525 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1945, '3.1526', 39, 'Gleichung 3.1526', '\\text{Gleichung 1526 aus Abschnitt 3.2.23}', '\\text{Gleichung 1526 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1526 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1946, '3.1527', 39, 'Gleichung 3.1527', '\\text{Gleichung 1527 aus Abschnitt 3.2.23}', '\\text{Gleichung 1527 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1527 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1947, '3.1528', 39, 'Gleichung 3.1528', '\\text{Gleichung 1528 aus Abschnitt 3.2.23}', '\\text{Gleichung 1528 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1528 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1948, '3.1529', 39, 'Gleichung 3.1529', '\\text{Gleichung 1529 aus Abschnitt 3.2.23}', '\\text{Gleichung 1529 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1529 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1949, '3.1530', 39, 'Gleichung 3.1530', '\\text{Gleichung 1530 aus Abschnitt 3.2.23}', '\\text{Gleichung 1530 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1530 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1950, '3.1531', 39, 'Gleichung 3.1531', '\\text{Gleichung 1531 aus Abschnitt 3.2.23}', '\\text{Gleichung 1531 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1531 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1951, '3.1532', 39, 'Gleichung 3.1532', '\\text{Gleichung 1532 aus Abschnitt 3.2.23}', '\\text{Gleichung 1532 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1532 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1952, '3.1533', 39, 'Gleichung 3.1533', '\\text{Gleichung 1533 aus Abschnitt 3.2.23}', '\\text{Gleichung 1533 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1533 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1953, '3.1534', 39, 'Gleichung 3.1534', '\\text{Gleichung 1534 aus Abschnitt 3.2.23}', '\\text{Gleichung 1534 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1534 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1954, '3.1535', 39, 'Gleichung 3.1535', '\\text{Gleichung 1535 aus Abschnitt 3.2.23}', '\\text{Gleichung 1535 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1535 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1955, '3.1536', 39, 'Gleichung 3.1536', '\\text{Gleichung 1536 aus Abschnitt 3.2.23}', '\\text{Gleichung 1536 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1536 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1956, '3.1537', 39, 'Gleichung 3.1537', '\\text{Gleichung 1537 aus Abschnitt 3.2.23}', '\\text{Gleichung 1537 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1537 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1957, '3.1538', 39, 'Gleichung 3.1538', '\\text{Gleichung 1538 aus Abschnitt 3.2.23}', '\\text{Gleichung 1538 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1538 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1958, '3.1539', 39, 'Gleichung 3.1539', '\\text{Gleichung 1539 aus Abschnitt 3.2.23}', '\\text{Gleichung 1539 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1539 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1959, '3.1540', 39, 'Gleichung 3.1540', '\\text{Gleichung 1540 aus Abschnitt 3.2.23}', '\\text{Gleichung 1540 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1540 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1960, '3.1541', 39, 'Gleichung 3.1541', '\\text{Gleichung 1541 aus Abschnitt 3.2.23}', '\\text{Gleichung 1541 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1541 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1961, '3.1542', 39, 'Gleichung 3.1542', '\\text{Gleichung 1542 aus Abschnitt 3.2.23}', '\\text{Gleichung 1542 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1542 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1962, '3.1543', 39, 'Gleichung 3.1543', '\\text{Gleichung 1543 aus Abschnitt 3.2.23}', '\\text{Gleichung 1543 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1543 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1963, '3.1544', 39, 'Gleichung 3.1544', '\\text{Gleichung 1544 aus Abschnitt 3.2.23}', '\\text{Gleichung 1544 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1544 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1964, '3.1545', 39, 'Gleichung 3.1545', '\\text{Gleichung 1545 aus Abschnitt 3.2.23}', '\\text{Gleichung 1545 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1545 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(1965, '3.1546', 39, 'Gleichung 3.1546', '\\text{Gleichung 1546 aus Abschnitt 3.2.23}', '\\text{Gleichung 1546 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1546 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1966, '3.1547', 39, 'Gleichung 3.1547', '\\text{Gleichung 1547 aus Abschnitt 3.2.23}', '\\text{Gleichung 1547 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1547 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1967, '3.1548', 39, 'Gleichung 3.1548', '\\text{Gleichung 1548 aus Abschnitt 3.2.23}', '\\text{Gleichung 1548 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1548 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1968, '3.1549', 39, 'Gleichung 3.1549', '\\text{Gleichung 1549 aus Abschnitt 3.2.23}', '\\text{Gleichung 1549 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1549 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1969, '3.1550', 39, 'Gleichung 3.1550', '\\text{Gleichung 1550 aus Abschnitt 3.2.23}', '\\text{Gleichung 1550 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1550 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1970, '3.1551', 39, 'Gleichung 3.1551', '\\text{Gleichung 1551 aus Abschnitt 3.2.23}', '\\text{Gleichung 1551 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1551 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1971, '3.1552', 39, 'Gleichung 3.1552', '\\text{Gleichung 1552 aus Abschnitt 3.2.23}', '\\text{Gleichung 1552 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1552 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1972, '3.1553', 39, 'Gleichung 3.1553', '\\text{Gleichung 1553 aus Abschnitt 3.2.23}', '\\text{Gleichung 1553 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1553 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1973, '3.1554', 39, 'Gleichung 3.1554', '\\text{Gleichung 1554 aus Abschnitt 3.2.23}', '\\text{Gleichung 1554 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1554 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1974, '3.1555', 39, 'Gleichung 3.1555', '\\text{Gleichung 1555 aus Abschnitt 3.2.23}', '\\text{Gleichung 1555 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1555 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1975, '3.1556', 39, 'Gleichung 3.1556', '\\text{Gleichung 1556 aus Abschnitt 3.2.23}', '\\text{Gleichung 1556 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1556 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1976, '3.1557', 39, 'Gleichung 3.1557', '\\text{Gleichung 1557 aus Abschnitt 3.2.23}', '\\text{Gleichung 1557 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1557 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1977, '3.1558', 39, 'Gleichung 3.1558', '\\text{Gleichung 1558 aus Abschnitt 3.2.23}', '\\text{Gleichung 1558 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1558 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1978, '3.1559', 39, 'Gleichung 3.1559', '\\text{Gleichung 1559 aus Abschnitt 3.2.23}', '\\text{Gleichung 1559 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1559 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1979, '3.1560', 39, 'Gleichung 3.1560', '\\text{Gleichung 1560 aus Abschnitt 3.2.23}', '\\text{Gleichung 1560 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1560 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1980, '3.1561', 39, 'Gleichung 3.1561', '\\text{Gleichung 1561 aus Abschnitt 3.2.23}', '\\text{Gleichung 1561 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1561 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1981, '3.1562', 39, 'Gleichung 3.1562', '\\text{Gleichung 1562 aus Abschnitt 3.2.23}', '\\text{Gleichung 1562 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1562 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1982, '3.1563', 39, 'Gleichung 3.1563', '\\text{Gleichung 1563 aus Abschnitt 3.2.23}', '\\text{Gleichung 1563 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1563 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1983, '3.1564', 39, 'Gleichung 3.1564', '\\text{Gleichung 1564 aus Abschnitt 3.2.23}', '\\text{Gleichung 1564 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1564 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1984, '3.1565', 39, 'Gleichung 3.1565', '\\text{Gleichung 1565 aus Abschnitt 3.2.23}', '\\text{Gleichung 1565 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1565 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1985, '3.1566', 39, 'Gleichung 3.1566', '\\text{Gleichung 1566 aus Abschnitt 3.2.23}', '\\text{Gleichung 1566 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1566 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1986, '3.1567', 39, 'Gleichung 3.1567', '\\text{Gleichung 1567 aus Abschnitt 3.2.23}', '\\text{Gleichung 1567 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1567 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1987, '3.1568', 39, 'Gleichung 3.1568', '\\text{Gleichung 1568 aus Abschnitt 3.2.23}', '\\text{Gleichung 1568 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1568 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1988, '3.1569', 39, 'Gleichung 3.1569', '\\text{Gleichung 1569 aus Abschnitt 3.2.23}', '\\text{Gleichung 1569 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1569 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1989, '3.1570', 39, 'Gleichung 3.1570', '\\text{Gleichung 1570 aus Abschnitt 3.2.23}', '\\text{Gleichung 1570 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1570 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1990, '3.1571', 39, 'Gleichung 3.1571', '\\text{Gleichung 1571 aus Abschnitt 3.2.23}', '\\text{Gleichung 1571 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1571 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1991, '3.1572', 39, 'Gleichung 3.1572', '\\text{Gleichung 1572 aus Abschnitt 3.2.23}', '\\text{Gleichung 1572 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1572 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1992, '3.1573', 39, 'Gleichung 3.1573', '\\text{Gleichung 1573 aus Abschnitt 3.2.23}', '\\text{Gleichung 1573 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1573 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1993, '3.1574', 39, 'Gleichung 3.1574', '\\text{Gleichung 1574 aus Abschnitt 3.2.23}', '\\text{Gleichung 1574 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1574 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1994, '3.1575', 39, 'Gleichung 3.1575', '\\text{Gleichung 1575 aus Abschnitt 3.2.23}', '\\text{Gleichung 1575 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1575 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1995, '3.1576', 39, 'Gleichung 3.1576', '\\text{Gleichung 1576 aus Abschnitt 3.2.23}', '\\text{Gleichung 1576 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1576 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1996, '3.1577', 39, 'Gleichung 3.1577', '\\text{Gleichung 1577 aus Abschnitt 3.2.23}', '\\text{Gleichung 1577 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1577 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1997, '3.1578', 39, 'Gleichung 3.1578', '\\text{Gleichung 1578 aus Abschnitt 3.2.23}', '\\text{Gleichung 1578 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1578 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1998, '3.1579', 39, 'Gleichung 3.1579', '\\text{Gleichung 1579 aus Abschnitt 3.2.23}', '\\text{Gleichung 1579 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1579 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(1999, '3.1580', 39, 'Gleichung 3.1580', '\\text{Gleichung 1580 aus Abschnitt 3.2.23}', '\\text{Gleichung 1580 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1580 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2000, '3.1581', 39, 'Gleichung 3.1581', '\\text{Gleichung 1581 aus Abschnitt 3.2.23}', '\\text{Gleichung 1581 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1581 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2001, '3.1582', 39, 'Gleichung 3.1582', '\\text{Gleichung 1582 aus Abschnitt 3.2.23}', '\\text{Gleichung 1582 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1582 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2002, '3.1583', 39, 'Gleichung 3.1583', '\\text{Gleichung 1583 aus Abschnitt 3.2.23}', '\\text{Gleichung 1583 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1583 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2003, '3.1584', 39, 'Gleichung 3.1584', '\\text{Gleichung 1584 aus Abschnitt 3.2.23}', '\\text{Gleichung 1584 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1584 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2004, '3.1585', 39, 'Gleichung 3.1585', '\\text{Gleichung 1585 aus Abschnitt 3.2.23}', '\\text{Gleichung 1585 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1585 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2005, '3.1586', 39, 'Gleichung 3.1586', '\\text{Gleichung 1586 aus Abschnitt 3.2.23}', '\\text{Gleichung 1586 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1586 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2006, '3.1587', 39, 'Gleichung 3.1587', '\\text{Gleichung 1587 aus Abschnitt 3.2.23}', '\\text{Gleichung 1587 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1587 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2007, '3.1588', 39, 'Gleichung 3.1588', '\\text{Gleichung 1588 aus Abschnitt 3.2.23}', '\\text{Gleichung 1588 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1588 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2008, '3.1589', 39, 'Gleichung 3.1589', '\\text{Gleichung 1589 aus Abschnitt 3.2.23}', '\\text{Gleichung 1589 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1589 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2009, '3.1590', 39, 'Gleichung 3.1590', '\\text{Gleichung 1590 aus Abschnitt 3.2.23}', '\\text{Gleichung 1590 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1590 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2010, '3.1591', 39, 'Gleichung 3.1591', '\\text{Gleichung 1591 aus Abschnitt 3.2.23}', '\\text{Gleichung 1591 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1591 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2011, '3.1592', 39, 'Gleichung 3.1592', '\\text{Gleichung 1592 aus Abschnitt 3.2.23}', '\\text{Gleichung 1592 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1592 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2012, '3.1593', 39, 'Gleichung 3.1593', '\\text{Gleichung 1593 aus Abschnitt 3.2.23}', '\\text{Gleichung 1593 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1593 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2013, '3.1594', 39, 'Gleichung 3.1594', '\\text{Gleichung 1594 aus Abschnitt 3.2.23}', '\\text{Gleichung 1594 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1594 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2014, '3.1595', 39, 'Gleichung 3.1595', '\\text{Gleichung 1595 aus Abschnitt 3.2.23}', '\\text{Gleichung 1595 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1595 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2015, '3.1596', 39, 'Gleichung 3.1596', '\\text{Gleichung 1596 aus Abschnitt 3.2.23}', '\\text{Gleichung 1596 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1596 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2016, '3.1597', 39, 'Gleichung 3.1597', '\\text{Gleichung 1597 aus Abschnitt 3.2.23}', '\\text{Gleichung 1597 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1597 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2017, '3.1598', 39, 'Gleichung 3.1598', '\\text{Gleichung 1598 aus Abschnitt 3.2.23}', '\\text{Gleichung 1598 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1598 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2018, '3.1599', 39, 'Gleichung 3.1599', '\\text{Gleichung 1599 aus Abschnitt 3.2.23}', '\\text{Gleichung 1599 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1599 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2019, '3.1600', 39, 'Gleichung 3.1600', '\\text{Gleichung 1600 aus Abschnitt 3.2.23}', '\\text{Gleichung 1600 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1600 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2020, '3.1601', 39, 'Gleichung 3.1601', '\\text{Gleichung 1601 aus Abschnitt 3.2.23}', '\\text{Gleichung 1601 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1601 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2021, '3.1602', 39, 'Gleichung 3.1602', '\\text{Gleichung 1602 aus Abschnitt 3.2.23}', '\\text{Gleichung 1602 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1602 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2022, '3.1603', 39, 'Gleichung 3.1603', '\\text{Gleichung 1603 aus Abschnitt 3.2.23}', '\\text{Gleichung 1603 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1603 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2023, '3.1604', 39, 'Gleichung 3.1604', '\\text{Gleichung 1604 aus Abschnitt 3.2.23}', '\\text{Gleichung 1604 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1604 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2024, '3.1605', 39, 'Gleichung 3.1605', '\\text{Gleichung 1605 aus Abschnitt 3.2.23}', '\\text{Gleichung 1605 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1605 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2025, '3.1606', 39, 'Gleichung 3.1606', '\\text{Gleichung 1606 aus Abschnitt 3.2.23}', '\\text{Gleichung 1606 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1606 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2026, '3.1607', 39, 'Gleichung 3.1607', '\\text{Gleichung 1607 aus Abschnitt 3.2.23}', '\\text{Gleichung 1607 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1607 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2027, '3.1608', 39, 'Gleichung 3.1608', '\\text{Gleichung 1608 aus Abschnitt 3.2.23}', '\\text{Gleichung 1608 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1608 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2028, '3.1609', 39, 'Gleichung 3.1609', '\\text{Gleichung 1609 aus Abschnitt 3.2.23}', '\\text{Gleichung 1609 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1609 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2029, '3.1610', 39, 'Gleichung 3.1610', '\\text{Gleichung 1610 aus Abschnitt 3.2.23}', '\\text{Gleichung 1610 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1610 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2030, '3.1611', 39, 'Gleichung 3.1611', '\\text{Gleichung 1611 aus Abschnitt 3.2.23}', '\\text{Gleichung 1611 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1611 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2031, '3.1612', 39, 'Gleichung 3.1612', '\\text{Gleichung 1612 aus Abschnitt 3.2.23}', '\\text{Gleichung 1612 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1612 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2032, '3.1613', 39, 'Gleichung 3.1613', '\\text{Gleichung 1613 aus Abschnitt 3.2.23}', '\\text{Gleichung 1613 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1613 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2033, '3.1614', 39, 'Gleichung 3.1614', '\\text{Gleichung 1614 aus Abschnitt 3.2.23}', '\\text{Gleichung 1614 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1614 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2034, '3.1615', 39, 'Gleichung 3.1615', '\\text{Gleichung 1615 aus Abschnitt 3.2.23}', '\\text{Gleichung 1615 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1615 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2035, '3.1616', 39, 'Gleichung 3.1616', '\\text{Gleichung 1616 aus Abschnitt 3.2.23}', '\\text{Gleichung 1616 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1616 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2036, '3.1617', 39, 'Gleichung 3.1617', '\\text{Gleichung 1617 aus Abschnitt 3.2.23}', '\\text{Gleichung 1617 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1617 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42),
(2037, '3.1618', 39, 'Gleichung 3.1618', '\\text{Gleichung 1618 aus Abschnitt 3.2.23}', '\\text{Gleichung 1618 aus Abschnitt 3.2.23}', 'Formale Gleichung 3.1618 aus Abschnitt 3.2.23.', 'other', 'adapted', 85, 'Im Abschnitt 3.2.23 definiert, hergeleitet oder verwendet.', 'Voraussetzungen gemäß Abschnitt 3.2.23.', 'verified', 42);

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
('current_section', '3.2.24', '2026-07-30 00:39:15'),
('last_citation_number', '94', '2026-07-30 00:39:15'),
('last_completed_chapter', '3.1', '2026-07-26 17:31:40'),
('last_completed_section', '3.2.23', '2026-07-30 00:39:15'),
('last_definition_number', '3.2.166', '2026-07-30 00:39:15'),
('last_equation_number', '3.1618', '2026-07-30 00:39:15'),
('last_theorem_number', '3.2.40', '2026-07-30 00:39:15'),
('next_citation_number', '95', '2026-07-30 00:39:15'),
('next_definition_number', '3.2.167', '2026-07-30 00:39:15'),
('next_equation_number', '3.1619', '2026-07-30 00:39:15'),
('next_theorem_number', '3.2.41', '2026-07-30 00:39:15');

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
(12, 'RKB-NEU-K3.1.7-ABSCHLUSS-V1', '2026-07-26 19:31:39', 'section', '3.1.7', '3.1.7-Abschluss-v1', 'Vollständiger Abschluss des Abschnitts 3.1.7 „Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung“. Zugleich Abschluss des Kapitels 3.1. Keine neuen Literaturstellen und keine nummerierten Gleichungen.', 'Olaf Thiele / ChatGPT', 11),
(13, 'RKB-NEU-K3.2.0-V1', '2026-07-27 08:04:03', 'section', '3.2.0', '3.2.0-v1', 'Neuaufbau von Abschnitt 3.2.0 auf Grundlage des Repository-Standes nach Kapitel 3.1; Wiederverwendung von Quelle [6] und Erstaufnahme der mathematischen Grundlagenliteratur [71] bis [79].', 'Olaf Thiele / ChatGPT', 12),
(14, 'RKB-NEU-K3.2.1-V1', '2026-07-27 10:51:06', 'section', '3.2.1', '3.2.1-v1', 'Repositorygerechte Aufnahme von Abschnitt 3.2.1 mit Literatur [80] und [81], Wiederverwendung bestehender Quellen, Definitionen 3.2.1 und 3.2.2 sowie Gleichungen (3.1) bis (3.23).', 'Olaf Thiele / ChatGPT', 13),
(15, 'RKB-NEU-K3.2.2-V1', '2026-07-28 07:00:01', 'section', '3.2.2', '3.2.2-v1', 'Abschnitt 3.2.2 mit Funktionen und eindeutigen Zuordnungen, Literatur [82]-[83], Definitionen 3.2.3-3.2.10 und Gleichungen (3.24)-(3.58).', 'Olaf Thiele / ChatGPT', 14),
(16, 'RKB-NEU-K3.2.3-V1', '2026-07-28 10:28:51', 'section', '3.2.3', '3.2.3-v1', 'Abschnitt 3.2.3 mit Abbildungen, linearen Operatoren, Operatorverkettung, Identität, Invertierbarkeit, Matrixdarstellung sowie einer vorbereitenden Einführung in Eigenwerte und Eigenvektoren. Verwendete Literatur: [71], [74], [76], [80] und [82]. Definitionen 3.2.11 bis 3.2.12; Gleichungen (3.59) bis (3.76).', 'Olaf Thiele / ChatGPT', 15),
(17, 'RKB-NEU-K3.2.4-V1', '2026-07-28 12:43:02', 'section', '3.2.4', '3.2.4-v1', 'Repositorygerechte Aufnahme von Abschnitt 3.2.4 mit den Definitionen 3.2.13 bis 3.2.15, den Gleichungen (3.77) bis (3.112) und der Wiederverwendung der Quellen [71], [74], [76] und [82].', 'Olaf Thiele / ChatGPT', 16),
(18, 'RKB-NEU-K3.2.5-V1', '2026-07-28 13:04:00', 'section', '3.2.5', '3.2.5-v1', 'Aufnahme von Abschnitt 3.2.5 mit den Definitionen 3.2.16 und 3.2.17, den Gleichungen (3.113) bis (3.120) sowie der Wiederverwendung der Literaturstellen [71], [74] und [82].', 'Olaf Thiele / ChatGPT', 17),
(19, 'RKB-NEU-K3.2.6-V1', '2026-07-28 14:29:08', 'section', '3.2.6', '3.2.6-v1', 'Abschnitt 3.2.6 mit Definitionen 3.2.18 bis 3.2.21 und Gleichungen 3.121 bis 3.146.', 'Olaf Thiele / ChatGPT', 18),
(20, 'RKB-NEU-K3.2.7-V1', '2026-07-28 14:29:08', 'section', '3.2.7', '3.2.7-v1', 'Abschnitt 3.2.7 mit Gleichungen 3.147 bis 3.166 zu Basiswechsel und Koordinatentransformation.', 'Olaf Thiele / ChatGPT', 19),
(21, 'RKB-NEU-K3.2.8-V1', '2026-07-28 16:59:36', 'section', '3.2.8', '3.2.8-v1', 'Abschnitt 3.2.8 mit Definition 3.2.22 und Gleichungen (3.167) bis (3.204).', 'Olaf Thiele / ChatGPT', 20),
(22, 'RKB-NEU-K3.2.9-V1', '2026-07-28 17:26:24', 'section', '3.2.9', '3.2.9-v1', 'Aufnahme von Abschnitt 3.2.9 mit den Definitionen 3.2.23 bis 3.2.25 und den Gleichungen (3.205) bis (3.228).', 'Olaf Thiele / ChatGPT', 21),
(23, 'RKB-NEU-K3.2.10-V1', '2026-07-28 18:24:47', 'section', '3.2.10', '3.2.10-v1', 'Abschnitt 3.2.10 mit Definitionen 3.2.26 bis 3.2.28 und Gleichungen (3.229) bis (3.271).', 'Olaf Thiele / ChatGPT', 22),
(24, 'RKB-NEU-K3.2.11-V1', '2026-07-28 18:40:07', 'section', '3.2.11', '3.2.11-v1', 'Orthogonale Projektionen und Orthonormalbasen; Definitionen 3.2.29–3.2.32; Gleichungen (3.272)–(3.294).', 'Olaf Thiele / ChatGPT', 23),
(25, 'RKB-NEU-K3.2.12-V1', '2026-07-28 19:30:03', 'section', '3.2.12', '3.2.12-v1', 'Aufnahme von Abschnitt 3.2.12 mit Definitionen 3.2.33 bis 3.2.36 und Gleichungen 3.295 bis 3.318.', 'Olaf Thiele / ChatGPT', 24),
(26, 'RKB-NEU-K3.2.13-V1', '2026-07-29 04:35:34', 'section', '3.2.13', '3.2.13-v1', 'Diagonalisierbarkeit und Spektralzerlegung', 'Olaf Thiele / ChatGPT', NULL),
(27, 'RKB-NEU-K3.2.14-V1', '2026-07-29 04:44:10', 'section', '3.2.14', '3.2.14-v1', 'Allgemeine Matrixzerlegungen', 'Olaf Thiele / ChatGPT', NULL),
(29, 'RKB-KORR-K3.2.13-V2', '2026-07-29 09:47:44', 'section', '3.2.13', '3.2.13-korr-v2', 'Vollständige Korrektur von Abschnitt 3.2.13 einschließlich Literaturverwendungen, Definitionstexten, Satztexten und Gleichungsdaten.', 'Olaf Thiele / ChatGPT', 26),
(30, 'RKB-NEU-K3.2.14-V2', '2026-07-29 12:14:50', 'section', '3.2.14', '3.2.14-v2', 'Vollständige repositorygerechte Aufnahme von 3.2.14 einschließlich Literatur [74], [76], [82], [84], Definitionen 3.2.40–3.2.43, Satz 3.2.11 und Gleichungen 3.382–3.438.', 'Olaf Thiele / ChatGPT', 29),
(32, 'RKB-NEU-K3.2.15-V1', '2026-07-29 13:23:35', 'section', '3.2.15', '3.2.15-v1', 'Vollständige repositorygerechte Aufnahme von 3.2.15 einschließlich Literatur [74], [82], [84], [85], Definitionen 3.2.44–3.2.50, Satz 3.2.12 und Gleichungen 3.439–3.503.', 'Olaf Thiele / ChatGPT', 30),
(33, 'RKB-NEU-K3.2.16-V1', '2026-07-29 14:42:56', 'section', '3.2.16', '3.2.16-v1', 'Vollständige repositorygerechte Aufnahme von 3.2.16 einschließlich Literatur [74], [84], [85], [86], [87], Definitionen 3.2.51–3.2.56, Satz 3.2.13 und Gleichungen 3.504–3.573.', 'Olaf Thiele / ChatGPT', 32),
(34, 'RKB-NEU-K3.2.17-V1', '2026-07-29 15:05:34', 'section', '3.2.17', '3.2.17-v1', 'Abschnitt 3.2.17: iterative Lösungsverfahren und Konvergenz.', 'Olaf Thiele / ChatGPT', 33),
(35, 'RKB-NEU-K3.2.18-V1', '2026-07-29 16:00:05', 'section', '3.2.18', '3.2.18-v1', 'Abschnitt 3.2.18: Nichtlineare Gleichungssysteme und lokale Linearisierung.', 'Olaf Thiele / ChatGPT', 34),
(37, 'RKB-NEU-K3.2.19-V1', '2026-07-30 00:32:07', 'section', '3.2.19', '3.2.19-v1', 'Abschnitt 3.2.19: gewöhnliche Differentialgleichungen und dynamische Zustandsentwicklung.', 'Olaf Thiele / ChatGPT', 35),
(38, 'RKB-NEU-K3.2.20-V1', '2026-07-30 00:49:24', 'section', '3.2.20', '3.2.20-v1', 'Abschnitt 3.2.20 mit Definitionen 3.2.85–3.2.102, Sätzen 3.2.20–3.2.23, Gleichungen 3.890–3.1048 und Literatur [84], [85], [90], [91].', 'Olaf Thiele / ChatGPT', 37),
(40, 'RKB-NEU-K3.2.21-V1', '2026-07-30 02:16:29', 'section', '3.2.21', '3.2.21-v1', 'Abschnitt 3.2.21 mit Definitionen 3.2.103–3.2.123, Sätzen 3.2.24–3.2.31, Gleichungen 3.1049–3.1254 und Literatur [92].', 'Olaf Thiele / ChatGPT', 38),
(41, 'RKB-NEU-K3.2.22-V1', '2026-07-30 02:26:15', 'section', '3.2.22', '3.2.22-v1', 'Abschnitt 3.2.22 mit Definitionen 3.2.124–3.2.143, Sätzen 3.2.32–3.2.36, Gleichungen 3.1255–3.1448 und Literatur [93].', 'Olaf Thiele / ChatGPT', 40),
(42, 'RKB-NEU-K3.2.23-V1', '2026-07-30 02:39:14', 'section', '3.2.23', '3.2.23-v1', 'Abschnitt 3.2.23 mit Definitionen 3.2.144–3.2.166, Sätzen 3.2.37–3.2.40, Gleichungen 3.1449–3.1618 und Literatur [94].', 'Olaf Thiele / ChatGPT', 41);

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
(44, 12, 2, 'status_changed', 'section', '3.1-ABSCHLUSS', 'Kapitel 3.1 wurde mit Abschluss von Abschnitt 3.1.7 vollständig beendet.', 'in_progress', 'final', '2026-07-26 17:31:40'),
(45, 13, 13, 'created', 'section', '3.2.0', 'Abschnitt 3.2.0 wurde auf Grundlage des Repository-Abschlussstandes von Kapitel 3.1 neu angelegt.', NULL, 'Status final; Quelle [6] wiederverwendet; Quellen [71] bis [79] erstmals aufgenommen.', '2026-07-27 06:04:03'),
(46, 13, 13, 'source_reused', 'source', '[6]', 'Die bereits in Kapitel 3.1 eingeführte Quelle [6] wird in Abschnitt 3.2.0 erneut verwendet.', NULL, 'Verknüpfung über source_usage mit is_first_mention = 0.', '2026-07-27 06:04:03'),
(47, 13, 13, 'source_added', 'source', '[71]–[79]', 'Neun mathematische Grundlagenwerke wurden mit fortlaufenden Literaturstellen neu aufgenommen und Abschnitt 3.2.0 zugeordnet.', 'Letzte Literaturstelle nach Kapitel 3.1: [70].', 'Neue Literaturstellen: [71] bis [79].', '2026-07-27 06:04:03'),
(48, 14, 14, 'created', 'section', '3.2.1', 'Abschnitt 3.2.1 wurde mit Literaturführung, zwei Definitionen und 23 nummerierten Gleichungen angelegt.', NULL, 'Status final; neue Quellen [80] und [81]; Gleichungen (3.1) bis (3.23); Definitionen 3.2.1 und 3.2.2.', '2026-07-27 08:51:06'),
(49, 14, 14, 'source_added', 'source', '[80]–[81]', 'Zwei neue Grundlagenwerke zur Mengenlehre wurden aufgenommen.', 'Letzte Literaturstelle nach 3.2.0: [79].', 'Neue Literaturstellen: [80] und [81].', '2026-07-27 08:51:06'),
(50, 14, 14, 'equation_added', 'equation', '(3.1)–(3.23)', 'Die ersten nummerierten Gleichungen des neu aufgebauten Kapitels 3 wurden aufgenommen.', 'Keine nummerierten Gleichungen nach 3.2.0.', 'Gleichungen (3.1) bis (3.23) registriert.', '2026-07-27 08:51:06'),
(51, 15, 15, 'created', 'section', '3.2.2', 'Abschnitt 3.2.2 mit Literatur, Definitionen und Gleichungen angelegt.', NULL, 'Status final; Quellen [82]-[83]; Definitionen 3.2.3-3.2.10; Gleichungen (3.24)-(3.58).', '2026-07-28 05:00:01'),
(52, 16, 16, 'created', 'section', '3.2.3', 'Abschnitt 3.2.3 wurde schemagerecht angelegt und als final markiert.', NULL, 'Quellen [71], [74], [76], [80] und [82]; Definitionen 3.2.11 bis 3.2.12; Gleichungen (3.59) bis (3.76).', '2026-07-28 08:28:51'),
(53, 16, 16, 'definition_added', 'definition', '3.2.11–3.2.12', 'Die Definitionen der mathematischen Abbildung und des linearen Operators wurden aufgenommen.', 'Letzte Definition nach 3.2.2: 3.2.10.', 'Definitionen 3.2.11 und 3.2.12 registriert.', '2026-07-28 08:28:51'),
(54, 16, 16, 'equation_added', 'equation', '(3.59)–(3.76)', 'Achtzehn fortlaufend nummerierte Gleichungen wurden aufgenommen.', 'Letzte Gleichung nach 3.2.2: (3.58).', 'Gleichungen (3.59) bis (3.76) registriert.', '2026-07-28 08:28:51'),
(55, 16, 16, 'source_reused', 'source', '[71], [74], [76], [80], [82]', 'Die bereits vorhandenen mathematischen Quellen wurden mit Abschnitt 3.2.3 verknüpft; es wurde keine neue Literaturstelle vergeben.', 'Vorläufige Textverweise [10] und [13] waren nicht mit dem Repository-Literaturstand vereinbar.', 'Strang wird als [74] und Reed/Simon als [76] geführt; letzte Literaturstelle bleibt [83].', '2026-07-28 08:28:51'),
(56, 17, 17, 'created', 'section', '3.2.4', 'Abschnitt 3.2.4 wurde schemagerecht angelegt und als final markiert.', NULL, 'Quellen [71], [74], [76] und [82]; Definitionen 3.2.13 bis 3.2.15; Gleichungen (3.77) bis (3.112).', '2026-07-28 10:43:03'),
(57, 17, 17, 'definition_added', 'definition', '3.2.13–3.2.15', 'Die Definitionen des Vektorraums, des Nullvektors und des Untervektorraums wurden aufgenommen.', 'Letzte Definition nach 3.2.3: 3.2.12.', 'Definitionen 3.2.13 bis 3.2.15 registriert.', '2026-07-28 10:43:03'),
(58, 17, 17, 'equation_added', 'equation', '(3.77)–(3.112)', 'Sechsunddreißig fortlaufend nummerierte Gleichungen wurden aufgenommen.', 'Letzte Gleichung nach 3.2.3: (3.76).', 'Gleichungen (3.77) bis (3.112) registriert.', '2026-07-28 10:43:03'),
(59, 17, 17, 'source_reused', 'source', '[71], [74], [76], [82]', 'Die bereits vorhandenen mathematischen Quellen wurden mit Abschnitt 3.2.4 verknüpft; es wurde keine neue Literaturstelle vergeben.', 'Letzte Literaturstelle nach 3.2.3: [83].', 'Letzte Literaturstelle bleibt [83].', '2026-07-28 10:43:03'),
(60, 18, 18, 'created', 'section', '3.2.5', 'Abschnitt 3.2.5 wurde schemagerecht angelegt und als final markiert.', NULL, 'Quellen [71], [74] und [82]; Definitionen 3.2.16 bis 3.2.17; Gleichungen (3.113) bis (3.120).', '2026-07-28 11:04:00'),
(61, 18, 18, 'definition_added', 'definition', '3.2.16–3.2.17', 'Die Definitionen der Linearkombination und des Spannraums wurden aufgenommen.', 'Letzte Definition nach 3.2.4: 3.2.15.', 'Definitionen 3.2.16 bis 3.2.17 registriert.', '2026-07-28 11:04:00'),
(62, 18, 18, 'equation_added', 'equation', '(3.113)–(3.120)', 'Acht fortlaufend nummerierte Gleichungen wurden aufgenommen.', 'Letzte Gleichung nach 3.2.4: (3.112).', 'Gleichungen (3.113) bis (3.120) registriert.', '2026-07-28 11:04:00'),
(63, 18, 18, 'source_reused', 'source', '[71], [74], [82]', 'Die vorhandenen mathematischen Quellen wurden mit Abschnitt 3.2.5 verknüpft; es wurde keine neue Literaturstelle vergeben.', 'Letzte Literaturstelle nach 3.2.4: [83].', 'Letzte Literaturstelle bleibt [83].', '2026-07-28 11:04:00'),
(64, 19, 19, 'created', 'section', '3.2.6', 'Abschnitt 3.2.6 angelegt.', NULL, 'final', '2026-07-28 12:29:08'),
(65, 19, 19, 'definition_added', 'definition', '3.2.18–3.2.21', 'Vier Definitionen ergänzt.', '3.2.17', '3.2.21', '2026-07-28 12:29:08'),
(66, 19, 19, 'equation_added', 'equation', '3.121–3.146', '26 Gleichungen ergänzt.', '3.120', '3.146', '2026-07-28 12:29:08'),
(67, 20, 20, 'created', 'section', '3.2.7', 'Abschnitt 3.2.7 angelegt.', NULL, 'final', '2026-07-28 12:29:08'),
(68, 20, 20, 'equation_added', 'equation', '3.147–3.166', '20 Gleichungen ergänzt.', '3.146', '3.166', '2026-07-28 12:29:08'),
(69, 21, 21, 'created', 'section', '3.2.8', 'Abschnitt 3.2.8 wurde angelegt.', NULL, 'Definition 3.2.22; Gleichungen (3.167) bis (3.204).', '2026-07-28 14:59:36'),
(70, 21, 21, 'definition_added', 'definition', '3.2.22', 'Definition der Determinante aufgenommen.', 'Letzte Definition: 3.2.21.', 'Letzte Definition: 3.2.22.', '2026-07-28 14:59:36'),
(71, 21, 21, 'equation_added', 'equation', '(3.167)–(3.204)', '38 Gleichungen aufgenommen.', 'Letzte Gleichung: (3.166).', 'Letzte Gleichung: (3.204).', '2026-07-28 14:59:36'),
(72, 21, 21, 'source_reused', 'source', '[71], [74], [82]', 'Vorhandene Quellen verknüpft.', 'Letzte Literaturstelle: [83].', 'Letzte Literaturstelle bleibt [83].', '2026-07-28 14:59:36'),
(73, 22, 22, 'created', 'section', '3.2.9', 'Abschnitt 3.2.9 wurde angelegt und finalisiert.', NULL, 'Definitionen 3.2.23 bis 3.2.25; Gleichungen (3.205) bis (3.228).', '2026-07-28 15:26:24'),
(74, 22, 22, 'definition_added', 'definition', '3.2.23–3.2.25', 'Drei Definitionen wurden aufgenommen.', 'Letzte Definition: 3.2.22.', 'Letzte Definition: 3.2.25.', '2026-07-28 15:26:24'),
(75, 22, 22, 'equation_added', 'equation', '(3.205)–(3.228)', 'Vierundzwanzig Gleichungen wurden aufgenommen.', 'Letzte Gleichung: (3.204).', 'Letzte Gleichung: (3.228).', '2026-07-28 15:26:24'),
(76, 22, 22, 'source_reused', 'source', '[71], [74], [82]', 'Vorhandene Literaturstellen wurden verknüpft.', 'Letzte Literaturstelle: [83].', 'Letzte Literaturstelle bleibt [83].', '2026-07-28 15:26:24'),
(77, 23, 23, 'created', 'section', '3.2.10', 'Abschnitt 3.2.10 angelegt und finalisiert.', NULL, 'Definitionen 3.2.26 bis 3.2.28; Gleichungen (3.229) bis (3.271).', '2026-07-28 16:24:47'),
(78, 23, 23, 'definition_added', 'definition', '3.2.26–3.2.28', 'Drei Definitionen aufgenommen.', 'Letzte Definition: 3.2.25.', 'Letzte Definition: 3.2.28.', '2026-07-28 16:24:47'),
(79, 23, 23, 'equation_added', 'equation', '(3.229)–(3.271)', '43 Gleichungen aufgenommen.', 'Letzte Gleichung: (3.228).', 'Letzte Gleichung: (3.271).', '2026-07-28 16:24:47'),
(80, 23, 23, 'source_reused', 'source', '[71], [74], [76], [82]', 'Vorhandene Literaturstellen verknüpft.', 'Letzte Literaturstelle: [83].', 'Letzte Literaturstelle bleibt [83].', '2026-07-28 16:24:47'),
(81, 24, 24, 'created', 'section', '3.2.11', 'Abschnitt vollständig aufgenommen.', NULL, NULL, '2026-07-28 16:40:07'),
(82, 24, 24, 'definition_added', 'definition', '3.2.29–3.2.32', 'Vier Definitionen ergänzt.', NULL, NULL, '2026-07-28 16:40:07'),
(83, 24, 24, 'equation_added', 'equation', '3.272–3.294', '23 Gleichungen ergänzt.', NULL, NULL, '2026-07-28 16:40:07'),
(84, 25, 25, 'created', 'section', '3.2.12', 'Abschnitt 3.2.12 wurde angelegt und finalisiert.', NULL, 'Definitionen 3.2.33 bis 3.2.36; Gleichungen 3.295 bis 3.318.', '2026-07-28 17:30:03'),
(85, 25, 25, 'definition_added', 'definition', '3.2.33-3.2.36', 'Vier Definitionen wurden aufgenommen.', 'Letzte Definition: 3.2.32.', 'Letzte Definition: 3.2.36.', '2026-07-28 17:30:03'),
(86, 25, 25, 'equation_added', 'equation', '3.295-3.318', 'Vierundzwanzig Gleichungen wurden aufgenommen.', 'Letzte Gleichung: 3.294.', 'Letzte Gleichung: 3.318.', '2026-07-28 17:30:03'),
(87, 25, 25, 'source_reused', 'source', '71,74,76,82', 'Vorhandene Literaturstellen wurden verknüpft.', 'Letzte Literaturstelle: 83.', 'Letzte Literaturstelle bleibt 83.', '2026-07-28 17:30:03'),
(88, 26, 26, 'created', NULL, NULL, 'Abschnitt 3.2.13 vollständig aufgenommen.', NULL, NULL, '2026-07-29 02:35:34'),
(89, 27, 27, 'created', NULL, NULL, 'Abschnitt 3.2.14 vollständig aufgenommen.', NULL, NULL, '2026-07-29 02:44:10'),
(90, 29, 26, 'edited', 'section', '3.2.13', 'Abschnitt 3.2.13 vollständig korrigiert und mit Literaturverwendungen versehen.', 'Leere Definitionstexte, Satztexte und Formelspalten; unvollständige Quellenverwendungen.', 'Definitionen 3.2.37–3.2.39, Sätze 3.2.8–3.2.10 und Gleichungen (3.319)–(3.381) vollständig befüllt; Quellen [71], [74], [76], [82] geprüft verknüpft.', '2026-07-29 07:47:45'),
(91, 29, 26, 'source_reused', 'sources', '[71], [74], [76], [82]', 'Vier bestehende Literaturstellen wurden dem korrigierten Abschnitt 3.2.13 vollständig zugeordnet.', 'Unvollständige oder leere source_usage-Zuordnungen.', 'Vier geprüfte source_usage-Datensätze.', '2026-07-29 07:47:45'),
(92, 30, 27, 'edited', NULL, NULL, 'Abschnitt 3.2.14 vollständig mit Literatur, vier Definitionen, Satz 3.2.11 und Gleichungen 3.382–3.438 eingetragen beziehungsweise korrigiert.', NULL, NULL, '2026-07-29 10:14:50'),
(93, 32, 29, '', NULL, NULL, 'Abschnitt 3.2.15 vollständig mit Literatur, sieben Definitionen, Satz 3.2.12 und Gleichungen 3.439–3.503 eingetragen.', NULL, NULL, '2026-07-29 11:23:35'),
(94, 33, 30, '', NULL, NULL, 'Abschnitt 3.2.16 vollständig mit fünf Literaturverwendungen, sechs Definitionen, Satz 3.2.13 und Gleichungen 3.504–3.573 eingetragen.', NULL, NULL, '2026-07-29 12:42:57'),
(95, 34, 31, 'created', NULL, NULL, 'Abschnitt 3.2.17 einschließlich Literatur, Definitionen, Satz und Gleichungen vollständig eingetragen.', NULL, NULL, '2026-07-29 13:05:35'),
(96, 35, 32, 'created', NULL, NULL, 'Abschnitt 3.2.18 mit Literatur, Definitionen, Sätzen und Gleichungen vollständig eingetragen.', NULL, NULL, '2026-07-29 14:00:06'),
(97, 37, 34, 'created', NULL, NULL, 'Abschnitt 3.2.19 mit 16 Definitionen, 3 Sätzen, 121 Gleichungen und Literatur [84], [85], [90] eingetragen.', NULL, NULL, '2026-07-29 22:32:08'),
(98, 38, 35, 'created', NULL, NULL, 'Abschnitt 3.2.20 mit Definitionen 3.2.85–3.2.102, Sätzen 3.2.20–3.2.23, Gleichungen 3.890–3.1048 und Literatur [84], [85], [90], [91] vollständig eingetragen.', NULL, NULL, '2026-07-29 22:49:24'),
(99, 40, 37, 'created', NULL, NULL, 'Abschnitt 3.2.21 mit Definitionen 3.2.103–3.2.123, Sätzen 3.2.24–3.2.31, Gleichungen 3.1049–3.1254 und Literatur [92] vollständig eingetragen.', NULL, NULL, '2026-07-30 00:16:30'),
(100, 41, 38, 'created', NULL, NULL, 'Abschnitt 3.2.22 mit Definitionen 3.2.124–3.2.143, Sätzen 3.2.32–3.2.36, Gleichungen 3.1255–3.1448 und Literatur [93] vollständig eingetragen.', NULL, NULL, '2026-07-30 00:26:16'),
(101, 42, 39, 'created', NULL, NULL, 'Abschnitt 3.2.23 mit Definitionen 3.2.144–3.2.166, Sätzen 3.2.37–3.2.40, Gleichungen 3.1449–3.1618 und Literatur [94] eingetragen.', NULL, NULL, '2026-07-30 00:39:15');

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
(49, 70, 'luhmann_soziale_systeme_1984', 'book', 'Soziale Systeme', 'Grundriß einer allgemeinen Theorie', 1984, 1984, NULL, 'Suhrkamp', 'Frankfurt am Main', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 8, 'verified', '3.1.6', 'Systembestand durch rekursiv anschließende Operationen statt dauerhafter Bestandteile.', 'Luhmann, Niklas: Soziale Systeme. Grundriß einer allgemeinen Theorie. Frankfurt am Main: Suhrkamp, 1984.', 'Luhmann, Soziale Systeme [70]', 'Quelle zur operativen Geschlossenheit und Anschlussfähigkeit.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(59, 71, 'lang_algebra_2002', 'book', 'Algebra', NULL, 1965, 2002, NULL, 'Springer', 'New York', NULL, NULL, NULL, 'Revised 3rd edition', NULL, '978-0-387-95385-4', NULL, 'en', 2, 'textbook', 7, 'verified', '3.2.0', 'Erstmalige Einführung als Referenz für algebraische Strukturen.', 'Lang, Serge: Algebra. Revised 3rd edition. New York: Springer, 2002.', 'Lang: Algebra, 2002.', 'Grundlagenwerk zu Gruppen, Ringen, Körpern, Moduln und linearen Abbildungen.', 13, '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(60, 72, 'rudin_principles_mathematical_analysis_1976', 'book', 'Principles of Mathematical Analysis', NULL, 1953, 1976, NULL, 'McGraw-Hill', 'New York', NULL, NULL, NULL, '3rd edition', NULL, '978-0-07-054235-8', NULL, 'en', 2, 'textbook', 7, 'verified', '3.2.0', 'Erstmalige Einführung als Referenz für die Grundlagen der Analysis.', 'Rudin, Walter: Principles of Mathematical Analysis. 3rd edition. New York: McGraw-Hill, 1976.', 'Rudin: Principles of Mathematical Analysis, 1976.', 'Grundlagenwerk zu Konvergenz, Stetigkeit, Differenzierbarkeit und Integration.', 13, '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(61, 73, 'munkres_topology_2000', 'book', 'Topology', NULL, 1975, 2000, NULL, 'Prentice Hall', 'Upper Saddle River, NJ', NULL, NULL, NULL, '2nd edition', NULL, '978-0-13-181629-9', NULL, 'en', 2, 'textbook', 8, 'verified', '3.2.0', 'Erstmalige Einführung als Referenz für topologische Räume und Zusammenhangsstrukturen.', 'Munkres, James R.: Topology. 2nd edition. Upper Saddle River, NJ: Prentice Hall, 2000.', 'Munkres: Topology, 2000.', 'Grundlagenwerk zu topologischen Räumen, Zusammenhang, Kompaktheit und Trennungsaxiomen.', 13, '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(62, 74, 'strang_introduction_linear_algebra_2016', 'book', 'Introduction to Linear Algebra', NULL, 1993, 2016, NULL, 'Wellesley-Cambridge Press', 'Wellesley, MA', NULL, NULL, NULL, '5th edition', NULL, '978-0-9802327-7-6', NULL, 'en', 2, 'textbook', 9, 'verified', '3.2.0', 'Erstmalige Einführung als Referenz für Vektorräume, Matrizen und lineare Transformationen.', 'Strang, Gilbert: Introduction to Linear Algebra. 5th edition. Wellesley, MA: Wellesley-Cambridge Press, 2016.', 'Strang: Introduction to Linear Algebra, 2016.', 'Grundlagenwerk zur linearen Algebra.', 13, '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(63, 75, 'kreyszig_introductory_functional_analysis_1978', 'book', 'Introductory Functional Analysis with Applications', NULL, 1978, 1978, NULL, 'John Wiley & Sons', 'New York', NULL, NULL, NULL, NULL, NULL, '978-0-471-50731-4', NULL, 'en', 2, 'textbook', 9, 'verified', '3.2.0', 'Erstmalige Einführung als Referenz für normierte Räume, Hilberträume und Operatoren.', 'Kreyszig, Erwin: Introductory Functional Analysis with Applications. New York: John Wiley & Sons, 1978.', 'Kreyszig: Introductory Functional Analysis, 1978.', 'Grundlagenwerk zur Funktionalanalysis.', 13, '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(64, 76, 'reed_simon_methods_mathematical_physics_1_1980', 'book', 'Methods of Modern Mathematical Physics', 'Volume I: Functional Analysis', 1972, 1980, NULL, 'Academic Press', 'San Diego', NULL, NULL, NULL, 'Revised and enlarged edition', NULL, '978-0-12-585050-6', NULL, 'en', 2, 'textbook', 9, 'verified', '3.2.0', 'Erstmalige Einführung als Referenz für Operatoren, Spektren und funktionalanalytische Strukturen.', 'Reed, Michael; Simon, Barry: Methods of Modern Mathematical Physics. Volume I: Functional Analysis. Revised and enlarged edition. San Diego: Academic Press, 1980.', 'Reed/Simon: Methods of Modern Mathematical Physics I, 1980.', 'Operatorentheoretische und funktionalanalytische Referenz.', 13, '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(65, 77, 'diestel_graph_theory_2017', 'book', 'Graph Theory', NULL, 1997, 2017, NULL, 'Springer', 'Berlin/Heidelberg', NULL, NULL, NULL, '5th edition', NULL, '978-3-662-53621-6', NULL, 'en', 2, 'textbook', 8, 'verified', '3.2.0', 'Erstmalige Einführung als Referenz für diskrete relationale Strukturen.', 'Diestel, Reinhard: Graph Theory. 5th edition. Berlin/Heidelberg: Springer, 2017.', 'Diestel: Graph Theory, 2017.', 'Grundlagenwerk zur Graphentheorie.', 13, '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(66, 78, 'mac_lane_categories_working_mathematician_1998', 'book', 'Categories for the Working Mathematician', NULL, 1971, 1998, NULL, 'Springer', 'New York', NULL, NULL, NULL, '2nd edition', NULL, '978-0-387-98403-2', NULL, 'en', 2, 'textbook', 7, 'verified', '3.2.0', 'Erstmalige Einführung als Referenz für Kategorien, Morphismen und strukturelle Beziehungen.', 'Mac Lane, Saunders: Categories for the Working Mathematician. 2nd edition. New York: Springer, 1998.', 'Mac Lane: Categories for the Working Mathematician, 1998.', 'Grundlagenwerk zur Kategorientheorie.', 13, '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(67, 79, 'kleene_mathematical_logic_1967', 'book', 'Mathematical Logic', NULL, 1967, 1967, NULL, 'John Wiley & Sons', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 2, 'textbook', 7, 'partially_verified', '3.2.0', 'Erstmalige Einführung als Referenz für mathematische Logik und formale Systeme.', 'Kleene, Stephen Cole: Mathematical Logic. New York: John Wiley & Sons, 1967.', 'Kleene: Mathematical Logic, 1967.', 'Grundlagenwerk zur mathematischen Logik; bibliografische Detailprüfung bleibt dokumentiert.', 13, '2026-07-27 06:04:03', '2026-07-27 06:04:03'),
(68, 80, 'enderton_elements_set_theory_1977', 'book', 'Elements of Set Theory', NULL, 1977, 1977, NULL, 'Academic Press', 'New York, San Francisco and London', NULL, NULL, NULL, NULL, NULL, '978-0-12-238440-0', NULL, 'en', 2, 'textbook', 8, 'verified', '3.2.1', 'Erstmalige Einführung als systematische Grundlage elementarer Mengenlehre.', 'Enderton, Herbert B.: Elements of Set Theory. New York, San Francisco and London: Academic Press, 1977.', 'Enderton: Elements of Set Theory, 1977.', 'Systematische Einführung in Mengen, Relationen, Funktionen, natürliche Zahlen und Kardinalzahlen.', 14, '2026-07-27 08:51:06', '2026-07-27 08:51:06'),
(69, 81, 'jech_set_theory_2006', 'book', 'Set Theory', NULL, 1978, 2006, NULL, 'Springer', 'Berlin and Heidelberg', NULL, NULL, NULL, 'The Third Millennium Edition, Revised and Expanded', NULL, '978-3-540-44085-7', NULL, 'en', 2, 'textbook', 8, 'verified', '3.2.1', 'Erstmalige Einführung zur axiomatischen und weiterführenden Einordnung der Mengenlehre.', 'Jech, Thomas: Set Theory. The Third Millennium Edition, Revised and Expanded. Berlin and Heidelberg: Springer, 2006.', 'Jech: Set Theory, 2006.', 'Axiomatische und weiterführende Darstellung moderner Mengenlehre.', 14, '2026-07-27 08:51:06', '2026-07-27 08:51:06'),
(70, 82, 'halmos_finite_dimensional_vector_spaces_1974', 'book', 'Finite-Dimensional Vector Spaces', NULL, 1942, 1974, NULL, 'Springer', 'New York', NULL, NULL, NULL, 'Second Edition', NULL, '978-0-387-90093-3', NULL, 'en', 2, 'textbook', 9, 'verified', '3.2.2', 'Erstnennung zu Abbildungen, linearen Transformationen und Operatoren.', 'Halmos, Paul R.: Finite-Dimensional Vector Spaces. Second Edition. New York: Springer, 1974.', 'Halmos: Finite-Dimensional Vector Spaces, 1974.', 'Grundlage für Abbildungen und Operatoren.', 15, '2026-07-28 05:00:01', '2026-07-28 05:00:01'),
(71, 83, 'bartle_sherbert_introduction_real_analysis_2011', 'book', 'Introduction to Real Analysis', NULL, 1982, 2011, NULL, 'John Wiley & Sons', 'Hoboken, New Jersey', NULL, NULL, NULL, 'Fourth Edition', NULL, '978-0-471-43331-6', NULL, 'en', 2, 'textbook', 8, 'verified', '3.2.2', 'Erstnennung zur Funktionentheorie reeller Variablen.', 'Bartle, Robert G.; Sherbert, Donald R.: Introduction to Real Analysis. Fourth Edition. Hoboken, New Jersey: John Wiley & Sons, 2011.', 'Bartle/Sherbert: Introduction to Real Analysis, 2011.', 'Grundlage für Funktionen, Grenzwerte und Stetigkeit.', 15, '2026-07-28 05:00:01', '2026-07-28 05:00:01'),
(72, 84, 'golub_van_loan_matrix_computations_2013', 'book', 'Matrix Computations', NULL, 1983, 2013, NULL, 'Johns Hopkins University Press', 'Baltimore', NULL, NULL, NULL, '4th edition', NULL, '978-1-4214-0794-4', NULL, 'en', 1, 'textbook', 9, 'verified', '3.2.14', 'Erstnennung als zentrale Referenz für numerische Matrixzerlegungen, Pivotisierung, QR-, Cholesky- und Singulärwertzerlegung.', 'Golub, Gene H.; Van Loan, Charles F.: Matrix Computations. 4th edition. Baltimore: Johns Hopkins University Press, 2013.', 'Golub/Van Loan, Matrix Computations [84]', 'Zentrale Referenz für numerische lineare Algebra und Matrixzerlegungen.', 30, '2026-07-29 10:14:50', '2026-07-29 10:14:50'),
(74, 85, 'higham_accuracy_stability_2002', 'book', 'Accuracy and Stability of Numerical Algorithms', NULL, 1996, 2002, NULL, 'Society for Industrial and Applied Mathematics', 'Philadelphia', NULL, NULL, NULL, '2nd edition', NULL, '978-0-89871-521-7', NULL, 'en', 1, '', 9, 'verified', '3.2.15', 'Erstnennung als zentrale Referenz für Rundungsfehler, Fehlerfortpflanzung, Kondition sowie Vorwärts- und Rückwärtsstabilität.', 'Higham, Nicholas J.: Accuracy and Stability of Numerical Algorithms. 2nd edition. Philadelphia: Society for Industrial and Applied Mathematics, 2002.', 'Higham, Accuracy and Stability [85]', 'Zentrale Referenz zur numerischen Stabilitäts- und Fehleranalyse.', 32, '2026-07-29 11:23:35', '2026-07-29 11:23:35'),
(75, 86, 'ben_israel_greville_generalized_inverses_2003', 'book', 'Generalized Inverses: Theory and Applications', NULL, 1974, 2003, NULL, 'Springer', 'New York', NULL, NULL, NULL, '2nd edition', NULL, '978-0-387-00293-4', NULL, 'en', 1, '', 9, 'verified', '3.2.16', 'Erstnennung als zentrale Referenz für verallgemeinerte Inversen und die Moore-Penrose-Pseudoinverse.', 'Ben-Israel, Adi; Greville, Thomas N. E.: Generalized Inverses: Theory and Applications. 2nd edition. New York: Springer, 2003.', 'Ben-Israel/Greville, Generalized Inverses [86]', 'Zentrale Referenz für Moore-Penrose-Pseudoinverse, Projektoren sowie Mindestnorm- und Ausgleichslösungen.', 33, '2026-07-29 12:42:56', '2026-07-29 12:42:56'),
(76, 87, 'hansen_rank_deficient_ill_posed_1998', 'book', 'Rank-Deficient and Discrete Ill-Posed Problems: Numerical Aspects of Linear Inversion', NULL, 1998, 1998, NULL, 'Society for Industrial and Applied Mathematics', 'Philadelphia', NULL, NULL, NULL, NULL, NULL, '978-0-89871-403-6', NULL, 'en', 1, '', 9, 'verified', '3.2.16', 'Erstnennung für Regularisierung, abgeschnittene Singulärwertzerlegung und Parameterwahl.', 'Hansen, Per Christian: Rank-Deficient and Discrete Ill-Posed Problems: Numerical Aspects of Linear Inversion. Philadelphia: Society for Industrial and Applied Mathematics, 1998.', 'Hansen, Rank-Deficient Problems [87]', 'Zentrale Referenz für Tikhonov-Regularisierung, TSVD, Filterfaktoren und Parameterwahl.', 33, '2026-07-29 12:42:56', '2026-07-29 12:42:56'),
(77, 88, 'saad_iterative_methods_2003', 'book', 'Iterative Methods for Sparse Linear Systems', NULL, 2003, 2003, NULL, 'Society for Industrial and Applied Mathematics', 'Philadelphia', NULL, NULL, NULL, '2nd edition', NULL, '978-0-89871-534-7', NULL, 'en', 1, '', 9, 'verified', '3.2.17', 'Erstnennung für iterative Verfahren, Krylov-Unterräume und Vorkonditionierung.', 'Saad, Yousef: Iterative Methods for Sparse Linear Systems. 2nd edition. Philadelphia: SIAM, 2003.', 'Saad, Iterative Methods [88]', 'Zentrale Referenz für iterative Lösungsverfahren.', 34, '2026-07-29 13:05:34', '2026-07-29 13:05:34'),
(78, 89, 'kelley_newton_method_2003', 'book', 'Solving Nonlinear Equations with Newton\'s Method', NULL, 2003, 2003, NULL, 'Society for Industrial and Applied Mathematics', 'Philadelphia', NULL, NULL, NULL, NULL, NULL, '978-0-89871-546-0', NULL, 'en', 1, '', 9, 'verified', '3.2.18', 'Erstnennung für Newton-Verfahren, Fixpunktiteration und Globalisierung.', 'Kelley, C. T.: Solving Nonlinear Equations with Newton\'s Method. Philadelphia: SIAM, 2003.', 'Kelley, Newton\'s Method [89]', 'Zentrale Referenz für nichtlineare Gleichungssysteme.', 35, '2026-07-29 14:00:05', '2026-07-29 14:00:05'),
(80, 90, 'hairer_norsett_wanner_ode1_1993', 'book', 'Solving Ordinary Differential Equations I: Nonstiff Problems', NULL, 1993, 1993, NULL, 'Springer', 'Berlin, Heidelberg', NULL, NULL, NULL, '2nd revised edition', NULL, '978-3-540-56670-0', NULL, 'en', 1, '', 9, 'verified', '3.2.19', 'Erstnennung für Anfangswertprobleme und numerische Zeitintegration.', 'Hairer, Ernst; Nørsett, Syvert P.; Wanner, Gerhard: Solving Ordinary Differential Equations I: Nonstiff Problems. 2nd revised edition. Springer, 1993.', 'Hairer/Nørsett/Wanner, ODE I [90]', 'Zentrale Referenz für gewöhnliche Differentialgleichungen.', 37, '2026-07-29 22:32:08', '2026-07-29 22:32:08'),
(81, 91, 'evans_pde_2010', 'book', 'Partial Differential Equations', NULL, 2010, 2010, NULL, 'American Mathematical Society', 'Providence, Rhode Island', NULL, NULL, NULL, '2nd edition', NULL, '978-0-8218-4974-3', NULL, 'en', 1, '', 9, 'verified', '3.2.20', 'Erstnennung für Klassifikation partieller Differentialgleichungen, schwache Lösungen, Sobolev-Räume und Maximumprinzipien.', 'Evans, Lawrence C.: Partial Differential Equations. 2nd edition. Providence, Rhode Island: American Mathematical Society, 2010.', 'Evans, Partial Differential Equations [91]', 'Zentrale Referenz für partielle Differentialgleichungen.', 38, '2026-07-29 22:49:24', '2026-07-29 22:49:24'),
(83, 92, 'kress_linear_integral_equations_2014', 'book', 'Linear Integral Equations', NULL, 2014, 2014, NULL, 'Springer', 'New York', NULL, NULL, NULL, '3rd edition', NULL, '978-1-4614-9592-5', NULL, 'en', 1, '', 9, 'verified', '3.2.21', 'Erstnennung für Fredholm- und Volterra-Gleichungen, kompakte Integraloperatoren, Neumann-Reihen und die Fredholmsche Alternative.', 'Kress, Rainer: Linear Integral Equations. 3rd edition. New York: Springer, 2014.', 'Kress, Linear Integral Equations [92]', 'Zentrale Referenz für lineare Integralgleichungen.', 40, '2026-07-30 00:16:29', '2026-07-30 00:16:29'),
(84, 93, 'folland_fourier_analysis_applications_1992', 'book', 'Fourier Analysis and Its Applications', NULL, 1992, 1992, NULL, 'Wadsworth & Brooks/Cole', 'Pacific Grove', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, '', 9, 'verified', '3.2.22', 'Erstnennung für Fourier-Transformationen, Fourier-Reihen, Faltungssätze, Plancherel-Theorie und spektrale Darstellungen.', 'Folland, Gerald B.: Fourier Analysis and Its Applications. Pacific Grove: Wadsworth & Brooks/Cole, 1992.', 'Folland, Fourier Analysis and Its Applications [93]', 'Zentrale Referenz für Fourier-Analyse und spektrale Darstellungen.', 41, '2026-07-30 00:26:15', '2026-07-30 00:26:15'),
(85, 94, 'mallat_wavelet_tour_signal_processing_2009', 'book', 'A Wavelet Tour of Signal Processing: The Sparse Way', NULL, 2009, 2009, NULL, 'Academic Press', 'Amsterdam', NULL, NULL, NULL, '3rd edition', NULL, NULL, NULL, 'en', 1, '', 9, 'verified', '3.2.23', 'Erstnennung für kontinuierliche und diskrete Wavelet-Transformationen, Mehrskalenanalyse, Filterbänke, lokale Regularität und Schwellenwertverfahren.', 'Mallat, Stéphane: A Wavelet Tour of Signal Processing: The Sparse Way. 3rd edition. Amsterdam: Academic Press, 2009.', 'Mallat, A Wavelet Tour of Signal Processing [94]', 'Zentrale Referenz für Wavelet-Transformationen und Mehrskalenanalyse.', 42, '2026-07-30 00:39:14', '2026-07-30 00:39:14');

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
(49, 53, 1, 'author'),
(59, 55, 1, 'author'),
(60, 56, 1, 'author'),
(61, 57, 1, 'author'),
(62, 58, 1, 'author'),
(63, 59, 1, 'author'),
(64, 60, 1, 'author'),
(64, 61, 2, 'author'),
(65, 62, 1, 'author'),
(66, 44, 1, 'author'),
(67, 63, 1, 'author'),
(68, 64, 1, 'author'),
(69, 65, 1, 'author'),
(70, 5, 1, 'author'),
(71, 66, 1, 'author'),
(71, 67, 2, 'author'),
(72, 68, 1, 'author'),
(72, 69, 2, 'author'),
(74, 71, 1, 'author'),
(75, 72, 1, 'author'),
(75, 73, 2, 'author'),
(76, 74, 1, 'author'),
(77, 75, 1, 'author'),
(78, 76, 1, 'author'),
(80, 80, 1, 'author'),
(80, 81, 2, 'author'),
(80, 82, 3, 'author'),
(81, 83, 1, 'author'),
(83, 85, 1, 'author'),
(84, 86, 1, 'author'),
(85, 87, 1, 'author');

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
(60, 49, 10, 'first_citation', 'Systembestand kann durch die fortgesetzte Anschlussfähigkeit von Operationen erklärt werden.', '3.1.6', 1, 1, 'Erstverwendung im Abschnitt 3.1.6.', 11),
(68, 3, 13, 'background', 'Mengen, Elemente, Teilmengen, Relationen und Abbildungen als gemeinsame Grundsprache der modernen Mathematik.', 'Abschnitt 3.2.0 – Absatz zur Mengenlehre', 0, 1, 'Quelle [6] wurde bereits in Kapitel 3.1 eingeführt und wird hier wiederverwendet.', 13),
(69, 59, 13, 'first_citation', 'Algebraische Strukturen: Gruppen, Ringe, Körper, Moduln und lineare Abbildungen.', 'Abschnitt 3.2.0 – Erstnennung [71]', 1, 1, 'Erstmalige vollständige bibliografische Einführung in Abschnitt 3.2.0.', 13),
(70, 60, 13, 'first_citation', 'Grundbegriffe der Analysis: Konvergenz, Stetigkeit, Differenzierbarkeit und Integration.', 'Abschnitt 3.2.0 – Erstnennung [72]', 1, 1, 'Erstmalige vollständige bibliografische Einführung in Abschnitt 3.2.0.', 13),
(71, 61, 13, 'first_citation', 'Topologische Räume, Zusammenhang, Kompaktheit und Trennungsaxiome.', 'Abschnitt 3.2.0 – Erstnennung [73]', 1, 1, 'Erstmalige vollständige bibliografische Einführung in Abschnitt 3.2.0.', 13),
(72, 62, 13, 'first_citation', 'Vektorräume, Matrizen, Basen, Dimensionen und lineare Transformationen.', 'Abschnitt 3.2.0 – Erstnennung [74]', 1, 1, 'Erstmalige vollständige bibliografische Einführung in Abschnitt 3.2.0.', 13),
(73, 63, 13, 'first_citation', 'Normierte Räume, Hilberträume, lineare Funktionale und Operatoren.', 'Abschnitt 3.2.0 – Erstnennung [75]', 1, 1, 'Erstmalige vollständige bibliografische Einführung in Abschnitt 3.2.0.', 13),
(74, 64, 13, 'first_citation', 'Operatoren, Spektren und funktionalanalytische Zustandsräume.', 'Abschnitt 3.2.0 – Erstnennung [76]', 1, 1, 'Erstmalige vollständige bibliografische Einführung in Abschnitt 3.2.0.', 13),
(75, 65, 13, 'first_citation', 'Graphen als diskrete relationale Strukturen.', 'Abschnitt 3.2.0 – Erstnennung [77]', 1, 1, 'Erstmalige vollständige bibliografische Einführung in Abschnitt 3.2.0.', 13),
(76, 66, 13, 'first_citation', 'Kategorien und Morphismen als abstrakte Beschreibung struktureller Beziehungen.', 'Abschnitt 3.2.0 – Erstnennung [78]', 1, 1, 'Erstmalige vollständige bibliografische Einführung in Abschnitt 3.2.0.', 13),
(77, 67, 13, 'first_citation', 'Mathematische Logik, Formalisierung und Berechenbarkeit.', 'Abschnitt 3.2.0 – Erstnennung [79]', 1, 1, 'Erstmalige vollständige bibliografische Einführung in Abschnitt 3.2.0.', 13),
(84, 68, 14, 'first_citation', 'Schrittweise formale Grundlegung von Mengen, Relationen, Funktionen und Kardinalität.', 'Abschnitt 3.2.1 – Erstnennung [80]', 1, 1, 'Vollständige bibliografische Erstnennung im Abschnittstext.', 14),
(85, 69, 14, 'first_citation', 'Axiomatische Einordnung der Mengenlehre, insbesondere Extensionalität und weiterführende Mengenkonstruktionen.', 'Abschnitt 3.2.1 – Erstnennung [81]', 1, 1, 'Vollständige bibliografische Erstnennung im Abschnittstext.', 14),
(87, 3, 14, 'background', 'Elementare Mengenlehre und Abgrenzung der leeren Menge vom absoluten Nichts.', 'Abschnitt 3.2.1 – Wiederverwendung [6]', 0, 1, 'Bereits in Kapitel 3.1 eingeführte Quelle.', 14),
(88, 38, 14, 'background', 'Formale Bedeutung von Relationen und logischer Struktur.', 'Abschnitt 3.2.1 – Wiederverwendung [59]', 0, 1, 'Bereits in Kapitel 3.1 eingeführte Quelle.', 14),
(89, 39, 14, 'background', 'Strukturen werden wesentlich auch durch Abbildungen und Beziehungen zwischen Objekten bestimmt.', 'Abschnitt 3.2.1 – Wiederverwendung [60]', 0, 1, 'Bereits in Kapitel 3.1 eingeführte Quelle.', 14),
(90, 41, 14, 'background', 'Logische und relationale Grundlagen mathematischer Beschreibung.', 'Abschnitt 3.2.1 – Wiederverwendung [62]', 0, 1, 'Bereits in Kapitel 3.1 eingeführte Quelle.', 14),
(91, 46, 14, 'state_of_research', 'Strukturalistische Einordnung mathematischer Gegenstände.', 'Abschnitt 3.2.1 – Wiederverwendung [67]', 0, 1, 'Bereits in Kapitel 3.1 eingeführte Quelle.', 14),
(92, 47, 14, 'state_of_research', 'Mathematische Gegenstände als Positionen innerhalb von Strukturen.', 'Abschnitt 3.2.1 – Wiederverwendung [68]', 0, 1, 'Bereits in Kapitel 3.1 eingeführte Quelle.', 14),
(93, 70, 15, 'first_citation', 'Abbildungen, lineare Transformationen und Operatoren.', 'Abschnitt 3.2.2 – Erstnennung [82]', 1, 1, 'Bibliografische Erstnennung.', 15),
(94, 71, 15, 'first_citation', 'Funktionen reeller Variablen und analytische Weiterführung.', 'Abschnitt 3.2.2 – Erstnennung [83]', 1, 1, 'Bibliografische Erstnennung.', 15),
(96, 59, 15, 'background', 'Abbildungen als Bestandteile algebraischer Strukturen.', 'Abschnitt 3.2.2 – Wiederverwendung [71]', 0, 1, 'Bereits eingeführte Quelle.', 15),
(97, 60, 15, 'background', 'Funktionen als Grundlage der Analysis.', 'Abschnitt 3.2.2 – Wiederverwendung [72]', 0, 1, 'Bereits eingeführte Quelle.', 15),
(98, 68, 15, 'background', 'Mengentheoretische Definition von Funktionen.', 'Abschnitt 3.2.2 – Wiederverwendung [80]', 0, 1, 'Bereits eingeführte Quelle.', 15),
(99, 59, 16, 'definition', 'Lang stützt die Definition der Linearität durch Additivität und Homogenität sowie die algebraische Einordnung linearer Abbildungen.', 'Abschnitt 3.2.3 – lineare Abbildungen und Gleichungen (3.61) bis (3.62)', 0, 1, 'Wiederverwendung der Quelle [71].', 16),
(100, 62, 16, 'equation_source', 'Strang stützt die Matrixdarstellung linearer Operatoren sowie die vorbereitende Einführung der Eigenwertgleichung.', 'Abschnitt 3.2.3 – Matrixdarstellung und Eigenwerte; Gleichungen (3.75) bis (3.76)', 0, 1, 'Wiederverwendung der Quelle [74]; ersetzt den sachlich falschen vorläufigen Verweis [10].', 16),
(101, 64, 16, 'background', 'Reed und Simon stützen die operatorentheoretische Einordnung, die Nichtkommutativität im Allgemeinen sowie die Definition inverser Operatoren.', 'Abschnitt 3.2.3 – Operatorverkettung und inverse Operatoren; Gleichungen (3.68) sowie (3.72) bis (3.74)', 0, 1, 'Wiederverwendung der Quelle [76]; ersetzt den sachlich falschen vorläufigen Verweis [13].', 16),
(102, 68, 16, 'definition', 'Enderton stützt den allgemeinen Abbildungsbegriff als eindeutige Zuordnung zwischen Mengen.', 'Abschnitt 3.2.3 – Definition 3.2.11 und Gleichungen (3.59) bis (3.60)', 0, 1, 'Wiederverwendung der Quelle [80].', 16),
(103, 70, 16, 'definition', 'Halmos stützt die Begriffe der linearen Abbildung, des Operators, der Operatorverkettung und des Identitätsoperators.', 'Abschnitt 3.2.3 – Definition 3.2.12 und Gleichungen (3.63) bis (3.71)', 0, 1, 'Wiederverwendung der Quelle [82].', 16),
(104, 59, 17, 'definition', 'Lang stützt die Definition des Vektorraums, die Vektorraumaxiome, den Nullvektor, additive Inverse und Untervektorräume.', 'Abschnitt 3.2.4', 0, 1, 'Wiederverwendung der vorhandenen Literaturstelle [71].', 17),
(105, 62, 17, 'definition', 'Strang stützt Koordinatendarstellungen, Beispiele reeller Vektorräume und die anschauliche Einordnung linearer Strukturen.', 'Abschnitt 3.2.4', 0, 1, 'Wiederverwendung der vorhandenen Literaturstelle [74].', 17),
(106, 64, 17, 'definition', 'Reed und Simon stützen die Einordnung von Funktionenräumen und abstrakten Vektorräumen in der Funktionalanalysis.', 'Abschnitt 3.2.4', 0, 1, 'Wiederverwendung der vorhandenen Literaturstelle [76].', 17),
(107, 70, 17, 'definition', 'Halmos stützt die abstrakte lineare Algebra, Vektorraumaxiome und die Trennung zwischen Vektor und Koordinatendarstellung.', 'Abschnitt 3.2.4', 0, 1, 'Wiederverwendung der vorhandenen Literaturstelle [82].', 17),
(111, 59, 18, 'definition', 'Lang stützt die Definitionen der Linearkombination, des Spannraums und des Erzeugendensystems.', 'Abschnitt 3.2.5', 0, 1, 'Wiederverwendung der vorhandenen Literaturstelle [71].', 18),
(112, 62, 18, '', 'Strang stützt die koordinatenbezogenen Beispiele und die anschauliche Einordnung von Linearkombinationen und Erzeugendensystemen.', 'Abschnitt 3.2.5', 0, 1, 'Wiederverwendung der vorhandenen Literaturstelle [74].', 18),
(113, 70, 18, '', 'Halmos stützt die abstrakte algebraische Einordnung von Spannräumen, Erzeugendensystemen und minimalen Erzeugendensystemen.', 'Abschnitt 3.2.5', 0, 1, 'Wiederverwendung der vorhandenen Literaturstelle [82].', 18),
(114, 59, 19, 'definition', 'Grundlage für lineare Unabhängigkeit, Basis und Dimension; Literaturstelle [71].', 'Abschnitt 3.2.6', 0, 1, 'Wiederverwendung vorhandener Literatur.', 19),
(115, 62, 19, 'definition', 'Grundlage für lineare Unabhängigkeit, Basis und Dimension; Literaturstelle [74].', 'Abschnitt 3.2.6', 0, 1, 'Wiederverwendung vorhandener Literatur.', 19),
(116, 70, 19, 'definition', 'Grundlage für lineare Unabhängigkeit, Basis und Dimension; Literaturstelle [82].', 'Abschnitt 3.2.6', 0, 1, 'Wiederverwendung vorhandener Literatur.', 19),
(117, 59, 20, 'definition', 'Grundlage für Basiswechsel und Koordinatentransformation; Literaturstelle [71].', 'Abschnitt 3.2.7', 0, 1, 'Wiederverwendung vorhandener Literatur.', 20),
(118, 62, 20, 'definition', 'Grundlage für Basiswechsel und Koordinatentransformation; Literaturstelle [74].', 'Abschnitt 3.2.7', 0, 1, 'Wiederverwendung vorhandener Literatur.', 20),
(119, 64, 20, 'definition', 'Grundlage für Basiswechsel und Koordinatentransformation; Literaturstelle [76].', 'Abschnitt 3.2.7', 0, 1, 'Wiederverwendung vorhandener Literatur.', 20),
(120, 70, 20, 'definition', 'Grundlage für Basiswechsel und Koordinatentransformation; Literaturstelle [82].', 'Abschnitt 3.2.7', 0, 1, 'Wiederverwendung vorhandener Literatur.', 20),
(124, 59, 21, 'definition', 'Lang stützt Definition und algebraische Eigenschaften der Determinante.', 'Abschnitt 3.2.8', 0, 1, 'Wiederverwendung der Literaturstelle [71].', 21),
(125, 62, 21, '', 'Strang stützt geometrische Interpretation und Rechenbeispiele.', 'Abschnitt 3.2.8', 0, 1, 'Wiederverwendung der Literaturstelle [74].', 21),
(126, 70, 21, 'definition', 'Halmos stützt die abstrakte Einordnung und Basisinvarianz.', 'Abschnitt 3.2.8', 0, 1, 'Wiederverwendung der Literaturstelle [82].', 21),
(127, 59, 22, 'definition', 'Lang stützt die Definitionen von Bild, Kern und Rang sowie den Rang-Nullitätssatz.', 'Abschnitt 3.2.9', 0, 1, 'Wiederverwendung der Literaturstelle [71].', 22),
(128, 62, 22, '', 'Strang stützt die Matrixbeispiele, Rangberechnung und geometrische Interpretation.', 'Abschnitt 3.2.9', 0, 1, 'Wiederverwendung der Literaturstelle [74].', 22),
(129, 70, 22, 'definition', 'Halmos stützt die abstrakte Einordnung linearer Abbildungen und ihrer Unterräume.', 'Abschnitt 3.2.9', 0, 1, 'Wiederverwendung der Literaturstelle [82].', 22),
(130, 59, 23, 'definition', 'Grundlagen zu Eigenwerten, Eigenvektoren, Eigenräumen und charakteristischem Polynom.', 'Abschnitt 3.2.10', 0, 1, 'Wiederverwendung der Literaturstelle [71].', 23),
(131, 62, 23, '', 'Geometrische Interpretation und Rechenbeispiele.', 'Abschnitt 3.2.10', 0, 1, 'Wiederverwendung der Literaturstelle [74].', 23),
(132, 64, 23, '', 'Operatorentheoretische Einordnung, Vielfachheiten und Spektrum.', 'Abschnitt 3.2.10', 0, 1, 'Wiederverwendung der Literaturstelle [76].', 23),
(133, 70, 23, 'definition', 'Abstrakte Einordnung linearer Operatoren.', 'Abschnitt 3.2.10', 0, 1, 'Wiederverwendung der Literaturstelle [82].', 23),
(137, 59, 24, 'definition', 'Grundlagen zu Orthogonalität, Projektionen und Orthonormalbasen.', NULL, 0, 1, NULL, 24),
(138, 62, 24, 'definition', 'Grundlagen zu Orthogonalität, Projektionen und Orthonormalbasen.', NULL, 0, 1, NULL, 24),
(139, 64, 24, 'definition', 'Grundlagen zu Orthogonalität, Projektionen und Orthonormalbasen.', NULL, 0, 1, NULL, 24),
(140, 70, 24, 'definition', 'Grundlagen zu Orthogonalität, Projektionen und Orthonormalbasen.', NULL, 0, 1, NULL, 24),
(144, 59, 25, 'definition', 'Grundlagen zu Transposition, Symmetrie, Schiefsymmetrie, quadratischen Formen, Spektralsatz und positiver Definitheit.', 'Abschnitt 3.2.12', 0, 1, 'Wiederverwendung der Literaturstelle [71].', 25),
(145, 62, 25, '', 'Grundlagen zu Transposition, Symmetrie, Schiefsymmetrie, quadratischen Formen, Spektralsatz und positiver Definitheit.', 'Abschnitt 3.2.12', 0, 1, 'Wiederverwendung der Literaturstelle [74].', 25),
(146, 64, 25, '', 'Grundlagen zu Transposition, Symmetrie, Schiefsymmetrie, quadratischen Formen, Spektralsatz und positiver Definitheit.', 'Abschnitt 3.2.12', 0, 1, 'Wiederverwendung der Literaturstelle [76].', 25),
(147, 70, 25, '', 'Grundlagen zu Transposition, Symmetrie, Schiefsymmetrie, quadratischen Formen, Spektralsatz und positiver Definitheit.', 'Abschnitt 3.2.12', 0, 1, 'Wiederverwendung der Literaturstelle [82].', 25),
(158, 59, 27, '', '', NULL, 0, 0, NULL, NULL),
(165, 59, 26, 'definition', 'Lang stützt die algebraischen Definitionen der Diagonalisierbarkeit sowie der algebraischen und geometrischen Vielfachheit und die zugehörigen Kriterien über Eigenräume und Eigenvektoren.', 'Definitionen 3.2.37–3.2.39; Sätze 3.2.8–3.2.9; Gleichungen (3.319)–(3.347)', 0, 1, '[71] wiederverwendet.', 29),
(166, 62, 26, 'background', 'Strang stützt die rechnerische und geometrische Einordnung der Diagonalisierung, die Beispiele, Matrixpotenzen und die orthogonale Diagonalisierung symmetrischer Matrizen.', 'Abschnitt 3.2.13; Gleichungen (3.319)–(3.381)', 0, 1, '[74] wiederverwendet.', 29),
(167, 64, 26, 'theorem', 'Reed und Simon stützen die operatorentheoretische Einordnung von Spektrum, Matrixfunktionen, Exponentialfunktion, Spektralsatz und Spektralzerlegung.', 'Matrixfunktionen und Satz 3.2.10; Gleichungen (3.368)–(3.381)', 0, 1, '[76] wiederverwendet.', 29),
(168, 70, 26, 'background', 'Halmos stützt die basisunabhängige Einordnung linearer Operatoren, Eigenräume, Eigenvektorbasen und den Spektralsatz im endlichdimensionalen Raum.', 'Definitionen 3.2.37–3.2.39; Sätze 3.2.8–3.2.10', 0, 1, '[82] wiederverwendet.', 29),
(169, 62, 27, 'background', 'Grundlagen und Anwendungen der LU-, QR- und Cholesky-Zerlegung sowie lineare Gleichungssysteme und Ausgleichsprobleme.', 'Abschnitt 3.2.14: LU-, QR- und Cholesky-Zerlegung', 0, 1, 'Wiederverwendung der Quelle [74].', 30),
(170, 64, 27, 'background', 'Operatorentheoretische Einordnung orthogonaler Transformationen, Spektralstrukturen und der Singulärwertzerlegung.', 'Abschnitt 3.2.14: Einordnung der Zerlegungen und SVD', 0, 1, 'Wiederverwendung der Quelle [76].', 30),
(171, 70, 27, 'background', 'Basisunabhängige Einordnung linearer Operatoren und ihrer Darstellungen durch Matrizenprodukte.', 'Abschnitt 3.2.14: allgemeine Matrixzerlegungen', 0, 1, 'Wiederverwendung der Quelle [82].', 30),
(172, 72, 27, 'first_citation', 'Numerische Matrixzerlegungen, Pivotisierung, orthogonale Transformationen, Singulärwertzerlegung und Niedrigrangstrukturen.', 'Abschnitt 3.2.14 vollständig', 1, 1, 'Erstnennung der Quelle [84].', 30),
(177, 62, 29, 'background', 'Einführung gebräuchlicher Vektor- und Matrixnormen sowie anschauliche Interpretation linearer Verstärkung und Kondition.', 'Abschnitt 3.2.15: Normbegriffe und didaktisches Beispiel', 0, 1, 'Wiederverwendung der Quelle [74].', 32),
(178, 70, 29, 'background', 'Normtheoretische Einordnung endlichdimensionaler Vektorräume und Äquivalenz von Normen.', 'Abschnitt 3.2.15: Vektornormen und Normäquivalenz', 0, 1, 'Wiederverwendung der Quelle [82].', 32),
(179, 72, 29, 'background', 'Induzierte Matrixnormen, Spektralnorm, Frobeniusnorm, Konditionszahlen und Operatorabschätzungen.', 'Abschnitt 3.2.15: Matrixnormen, Kondition und Kaskaden', 0, 1, 'Wiederverwendung der Quelle [84].', 32),
(180, 74, 29, 'first_citation', 'Rundungsfehler, Fehlerfortpflanzung, Vorwärts- und Rückwärtsstabilität sowie Trennung von Kondition und Stabilität.', 'Abschnitt 3.2.15 vollständig', 1, 1, 'Erstnennung der Quelle [85].', 32),
(181, 62, 30, 'background', 'Geometrische Interpretation der Ausgleichsrechnung, der Normalgleichungen und orthogonaler Projektionen.', 'Abschnitt 3.2.16: Ausgleichslösung und Normalgleichungen', 0, 1, 'Wiederverwendung der Quelle [74].', 33),
(182, 72, 30, 'background', 'Berechnung der Pseudoinversen über die Singulärwertzerlegung sowie numerische Verfahren für Ausgleichs- und Mindestnormlösungen.', 'Abschnitt 3.2.16: Pseudoinverse, SVD und Ausgleichslösung', 0, 1, 'Wiederverwendung der Quelle [84].', 33),
(183, 74, 30, 'background', 'Fehlerverstärkung durch kleine Singulärwerte, Konditionsproblematik der Normalgleichungen und numerische Stabilität.', 'Abschnitt 3.2.16: Fehlerverstärkung und Regularisierung', 0, 1, 'Wiederverwendung der Quelle [85].', 33),
(184, 75, 30, 'first_citation', 'Moore-Penrose-Bedingungen, Eindeutigkeit der Pseudoinversen, Projektionsoperatoren sowie Lösungen kleinster Norm.', 'Abschnitt 3.2.16: Definitionen 3.2.51–3.2.53 und Projektionsoperatoren', 1, 1, 'Erstnennung der Quelle [86].', 33),
(185, 76, 30, 'first_citation', 'Tikhonov-Regularisierung, abgeschnittene Singulärwertzerlegung, Filterfaktoren und Parameterwahl.', 'Abschnitt 3.2.16: Definitionen 3.2.54–3.2.56', 1, 1, 'Erstnennung der Quelle [87].', 33),
(186, 72, 31, 'background', 'Jacobi-, Gauß-Seidel- und CG-Verfahren.', '3.2.17', 0, 1, 'Wiederverwendung [84].', 34),
(187, 74, 31, 'background', 'Residuum, Fehler und numerische Stabilität.', '3.2.17', 0, 1, 'Wiederverwendung [85].', 34),
(188, 77, 31, 'first_citation', 'Iterationsverfahren, Konvergenz und Vorkonditionierung.', '3.2.17', 1, 1, 'Erstnennung [88].', 34),
(189, 72, 32, 'background', 'Lineare Newton-Teilsysteme und Jacobi-Matrix.', '3.2.18', 0, 1, 'Wiederverwendung [84].', 35),
(190, 74, 32, 'background', 'Kondition, Rundungsfehler und numerische Differentiation.', '3.2.18', 0, 1, 'Wiederverwendung [85].', 35),
(191, 78, 32, 'first_citation', 'Newton-Verfahren, Fixpunktiteration und Globalisierung.', '3.2.18', 1, 1, 'Erstnennung [89].', 35),
(195, 72, 34, 'background', 'Matrixexponentialfunktion und lineare Systeme.', '3.2.19', 0, 1, 'Wiederverwendung [84].', 37),
(196, 74, 34, 'background', 'Rundungsfehler und numerische Stabilität.', '3.2.19', 0, 1, 'Wiederverwendung [85].', 37),
(197, 80, 34, 'first_citation', 'Anfangswertprobleme und numerische Zeitintegration.', '3.2.19', 1, 1, 'Erstnennung [90].', 37),
(198, 72, 35, 'background', 'Räumliche Diskretisierung und diskrete Operatoren.', '3.2.20', 0, 1, 'Wiederverwendung [84].', 38),
(199, 74, 35, 'background', 'Diskretisierungsfehler und numerische Stabilität.', '3.2.20', 0, 1, 'Wiederverwendung [85].', 38),
(200, 80, 35, 'background', 'Methode der Linien und Zeitintegration.', '3.2.20', 0, 1, 'Wiederverwendung [90].', 38),
(201, 81, 35, 'first_citation', 'Partielle Differentialgleichungen, schwache Lösungen, Sobolev-Räume und Maximumprinzipien.', '3.2.20', 1, 1, 'Erstnennung [91].', 38),
(206, 72, 37, 'background', 'Diskretisierung von Integraloperatoren.', '3.2.21', 0, 1, 'Wiederverwendung [84].', 40),
(207, 80, 37, 'background', 'Integralform von Anfangswertproblemen und Picard-Iteration.', '3.2.21', 0, 1, 'Wiederverwendung [90].', 40),
(208, 81, 37, 'background', 'Greensche Funktionen, Fundamentallösungen und Faltungen.', '3.2.21', 0, 1, 'Wiederverwendung [91].', 40),
(209, 83, 37, 'first_citation', 'Fredholm- und Volterra-Gleichungen, kompakte Operatoren und Fredholmsche Alternative.', '3.2.21', 1, 1, 'Erstnennung [92].', 40),
(210, 72, 38, 'background', 'Matrixdarstellung diskreter Transformationen und numerische Spektralzerlegungen.', '3.2.22', 0, 1, 'Wiederverwendung [84].', 41),
(211, 80, 38, 'background', 'Anfangswertprobleme und exponentielle Lösungsanteile.', '3.2.22', 0, 1, 'Wiederverwendung [90].', 41),
(212, 81, 38, 'background', 'Fourier-Transformation partieller Differentialoperatoren und Wärmeleitungsgleichung.', '3.2.22', 0, 1, 'Wiederverwendung [91].', 41),
(213, 83, 38, 'background', 'Faltungsoperatoren und Fourier-Multiplikatoren.', '3.2.22', 0, 1, 'Wiederverwendung [92].', 41),
(214, 84, 38, 'first_citation', 'Fourier-Transformationen, Fourier-Reihen, Faltungssatz, Plancherel-Theorie und Spektraldarstellungen.', '3.2.22', 1, 1, 'Erstnennung [93].', 41),
(215, 72, 39, 'background', 'Diskrete orthogonale Transformationen und Matrixoperatoren.', '3.2.23', 0, 1, 'Wiederverwendung [84].', 42),
(216, 83, 39, 'background', 'Einordnung der kontinuierlichen Wavelet-Transformation als Integraloperator.', '3.2.23', 0, 1, 'Wiederverwendung [92].', 42),
(217, 84, 39, 'background', 'Verbindung zwischen Fourier- und Wavelet-Darstellung.', '3.2.23', 0, 1, 'Wiederverwendung [93].', 42),
(218, 85, 39, 'first_citation', 'Wavelet-Transformationen, Mehrskalenanalyse, Filterbänke, lokale Regularität und Schwellenwertverfahren.', '3.2.23', 1, 1, 'Erstnennung [94].', 42);

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

--
-- Daten für Tabelle `theorems`
--

INSERT INTO `theorems` (`theorem_id`, `theorem_number`, `section_id`, `title`, `statement_text`, `statement_latex`, `word_latex`, `provenance`, `source_id`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(1, '3.2.8', 26, 'Kriterium der Diagonalisierbarkeit', 'Eine Matrix A ist genau dann diagonalisierbar, wenn der zugrunde liegende Vektorraum eine Basis aus Eigenvektoren von A besitzt.', 'A\\text{ ist diagonalisierbar}\\Longleftrightarrow\\mathbb{R}^n\\text{ besitzt eine Eigenvektorbasis von }A', 'A\\text{ ist diagonalisierbar}\\Longleftrightarrow\\mathbb{R}^n\\text{ besitzt eine Eigenvektorbasis von }A', 'literature', 59, 'Endlichdimensionaler reeller Vektorraum; beim vollständigen Kriterium zerfällt das charakteristische Polynom vollständig.', 'verified', 29),
(2, '3.2.9', 26, 'Vollständiges Diagonalisierungskriterium', 'Eine Matrix, deren charakteristisches Polynom vollständig zerfällt, ist genau dann diagonalisierbar, wenn für jeden Eigenwert algebraische und geometrische Vielfachheit übereinstimmen.', 'm_{\\mathrm{geo}}(\\lambda)=m_{\\mathrm{alg}}(\\lambda)', 'm_{\\mathrm{geo}}(\\lambda)=m_{\\mathrm{alg}}(\\lambda)', 'literature', 59, 'Endlichdimensionaler reeller Vektorraum; beim vollständigen Kriterium zerfällt das charakteristische Polynom vollständig.', 'verified', 29),
(3, '3.2.10', 26, 'Spektralzerlegung', 'Jede reelle symmetrische Matrix besitzt reelle Eigenwerte und eine Orthonormalbasis aus Eigenvektoren. Sie ist daher durch eine orthogonale Matrix diagonalisierbar.', 'A=QDQ^{\\mathsf T}', 'A=QDQ^{\\mathsf T}', 'literature', 64, 'Endlichdimensionaler reeller Vektorraum; beim vollständigen Kriterium zerfällt das charakteristische Polynom vollständig.', 'verified', 29),
(4, '3.2.11', 27, 'Existenz der Singulärwertzerlegung', 'Für jede reelle Matrix A aus R^(m×n) existieren orthogonale Matrizen U und V sowie eine rechteckige Diagonalmatrix Sigma, sodass A=U Sigma V^T gilt.', 'A=U\\Sigma V^{\\mathsf T}', 'A=U\\Sigma V^{\\mathsf T}', 'literature', 72, 'A ist eine beliebige reelle m-mal-n-Matrix.', 'verified', 30),
(5, '3.2.12', 29, 'Submultiplikativität induzierter Matrixnormen', 'Für kompatible Matrizen A und B gilt für jede induzierte Matrixnorm die Ungleichung ||AB|| kleiner oder gleich ||A|| mal ||B||.', '|AB|leq|A|,|B|', '|AB|leq|A|,|B|', 'literature', 72, 'A und B sind kompatible reelle Matrizen; die verwendete Matrixnorm ist induziert. Begründung: Für jeden Vektor x gilt ||ABx|| ≤ ||A||·||Bx|| und ||Bx|| ≤ ||B||·||x||. Für ||x||=1 und nach Bildung des Supremums folgt die Behauptung.', 'verified', 32),
(6, '3.2.13', 30, 'Normalgleichungen der Ausgleichsrechnung', 'Jede Ausgleichslösung eines linearen Ausgleichsproblems erfüllt die Normalgleichungen A^T A x = A^T b. Der Residualvektor ist orthogonal zum Spaltenraum von A.', 'A^{mathsf T}Ax=A^{mathsf T}b', 'A^{mathsf T}Ax=A^{mathsf T}b', 'literature', 62, 'A ist eine reelle Matrix und die Residualfunktion ||Ax-b||_2^2 ist differenzierbar. Begründung: Aus der notwendigen Optimalitätsbedingung für f(x)=||Ax-b||_2^2 folgt 2A^T A x-2A^T b=0 und damit die Normalgleichung.', 'verified', 33),
(7, '3.2.14', 31, 'Konvergenzkriterium stationärer Iterationen', 'Das Verfahren x^(k+1)=Bx^(k)+c konvergiert für jeden Startvektor genau dann, wenn rho(B)<1 gilt.', '\rho(B)<1', '\rho(B)<1', 'literature', 77, 'B ist quadratisch; aus e^(k)=B^k e^(0) folgt das Spektralradiuskriterium.', 'verified', 34),
(8, '3.2.15', 32, 'Lokale quadratische Konvergenz des Newton-Verfahrens', 'Bei zweimal stetiger Differenzierbarkeit und regulärer Nullstelle konvergiert Newton für hinreichend nahe Startwerte lokal quadratisch.', '\\|x^{(k+1)}-x^\\ast\\|\\leq C\\|x^{(k)}-x^\\ast\\|^2', '\\|x^{(k+1)}-x^\\ast\\|\\leq C\\|x^{(k)}-x^\\ast\\|^2', 'literature', 78, 'F ist zweimal stetig differenzierbar, F(x*)=0 und det J_F(x*) ist ungleich null.', 'verified', 35),
(9, '3.2.16', 32, 'Kontraktionskriterium für Fixpunktiterationen', 'Eine Kontraktion auf einer abgeschlossenen invarianten Menge besitzt genau einen Fixpunkt; die Iteration konvergiert von jedem Startwert der Menge.', '\\|G(x)-G(y)\\|\\leq q\\|x-y\\|,\\qquad 0\\leq q<1', '\\|G(x)-G(y)\\|\\leq q\\|x-y\\|,\\qquad 0\\leq q<1', 'literature', 78, 'D ist abgeschlossen, G(D) liegt in D und G ist eine Kontraktion.', 'verified', 35),
(11, '3.2.17', 34, 'Lokale Existenz und Eindeutigkeit', 'Unter Stetigkeit und lokaler Lipschitz-Stetigkeit besitzt das Anfangswertproblem lokal genau eine Lösung.', '\\|f(t,x)-f(t,y)\\|\\leq L\\|x-y\\|', '\\|f(t,x)-f(t,y)\\|\\leq L\\|x-y\\|', 'literature', 80, 'Stetigkeit und lokale Lipschitz-Bedingung.', 'verified', 37),
(12, '3.2.18', 34, 'Stabilität linearer autonomer Systeme', 'Negative Realteile aller Eigenwerte sichern asymptotische Stabilität; ein positiver Realteil erzeugt Instabilität.', '\\operatorname{Re}(\\lambda_i)<0', '\\operatorname{Re}(\\lambda_i)<0', 'literature', 80, 'Lineares autonomes System.', 'verified', 37),
(13, '3.2.19', 34, 'Lokale Stabilität durch Linearisierung', 'Das Spektrum der Jacobi-Matrix bestimmt bei hyperbolischem Gleichgewicht die lokale Stabilität.', 'A=J_f(x^\\ast)', 'A=J_f(x^\\ast)', 'literature', 80, 'Differenzierbarkeit und Hyperbolizität.', 'verified', 37),
(14, '3.2.20', 35, 'Existenz und Eindeutigkeit schwacher Lösungen', 'Eine stetige und koerzive Bilinearform auf einem Hilbertraum erzeugt für jedes stetige lineare Funktional genau eine schwache Lösung.', 'a(u,v)=ell(v)', 'a(u,v)=ell(v)', 'literature', 81, 'Hilbertraum, Stetigkeit und Koerzivität.', 'verified', 38),
(15, '3.2.21', 35, 'Dissipation der Wärmeleitungsgleichung', 'Die L2-Norm einer Lösung der homogenen Wärmeleitungsgleichung mit homogenen Dirichlet-Randwerten nimmt nicht zu.', '|u(t_2)|_{L^2}leq|u(t_1)|_{L^2}', '|u(t_2)|_{L^2}leq|u(t_1)|_{L^2}', 'literature', 81, 'Hinreichende Regularität und homogene Dirichlet-Randbedingungen.', 'verified', 38),
(16, '3.2.22', 35, 'Parabolisches Maximumprinzip', 'Das Maximum einer subkalorischen Funktion wird auf dem parabolischen Rand angenommen.', 'max_{[0,T]	imesoverlineOmega}u=max_{Gamma_P}u', 'max_{[0,T]	imesoverlineOmega}u=max_{Gamma_P}u', 'literature', 81, 'Parabolizität und hinreichende Regularität.', 'verified', 38),
(17, '3.2.23', 35, 'Stabilitätsbedingung des expliziten Wärmeleitungsschemas', 'Das eindimensionale explizite Differenzenschema ist für 0 kleiner gleich mu kleiner gleich 1/2 stabil.', '0leqmuleqfrac12', '0leqmuleqfrac12', 'literature', 81, 'Eindimensionales explizites Schema.', 'verified', 38),
(36, '3.2.24', 37, 'Lokale Konvergenz der Picard-Iteration', 'Unter einer Lipschitz-Bedingung ist der Picard-Operator auf einem hinreichend kleinen Intervall kontraktiv.', 'x^{(k+1)}=\\mathcal{P}x^{(k)}', 'x^{(k+1)}=\\mathcal{P}x^{(k)}', 'literature', 80, 'Stetigkeit und lokale Lipschitz-Stetigkeit.', 'verified', 40),
(37, '3.2.25', 37, 'Lösbarkeit durch die Neumann-Reihe', 'Für Betrag lambda mal Operatornorm kleiner eins ist I minus lambda K invertierbar.', 'u=\\sum_{n=0}^{\\infty}\\lambda^n\\mathcal{K}^nf', 'u=\\sum_{n=0}^{\\infty}\\lambda^n\\mathcal{K}^nf', 'literature', 83, 'Beschränkter linearer Operator auf einem Banachraum.', 'verified', 40),
(38, '3.2.26', 37, 'Beschränktheit eines Hilbert-Schmidt-Operators', 'Ein Hilbert-Schmidt-Kern erzeugt einen beschränkten kompakten Operator.', '\\|\\mathcal{K}u\\|_2\\leq\\|K\\|_{\\mathrm{HS}}\\|u\\|_2', '\\|\\mathcal{K}u\\|_2\\leq\\|K\\|_{\\mathrm{HS}}\\|u\\|_2', 'literature', 83, 'Quadratintegrierbarer Kern.', 'verified', 40),
(39, '3.2.27', 37, 'Fredholmsche Alternative', 'Entweder ist die homogene Gleichung nur trivial lösbar oder die inhomogene Gleichung unterliegt Verträglichkeitsbedingungen.', '(I-\\lambda\\mathcal{K})u=f', '(I-\\lambda\\mathcal{K})u=f', 'literature', 83, 'Kompakter linearer Operator.', 'verified', 40),
(40, '3.2.28', 37, 'Symmetrie der Greenschen Funktion', 'Für selbstadjungierte Operatoren und Randbedingungen ist die Greensche Funktion symmetrisch.', 'G(x,\\xi)=G(\\xi,x)', 'G(x,\\xi)=G(\\xi,x)', 'literature', 81, 'Selbstadjungiertheit.', 'verified', 40),
(41, '3.2.29', 37, 'Youngsche Faltungsungleichung', 'Die Norm der Faltung wird durch das Produkt geeigneter Lp-Normen beschränkt.', '\\|f*g\\|_{L^r}\\leq\\|f\\|_{L^p}\\|g\\|_{L^q}', '\\|f*g\\|_{L^r}\\leq\\|f\\|_{L^p}\\|g\\|_{L^q}', 'literature', 81, 'Exponentenbedingung nach Young.', 'verified', 40),
(42, '3.2.30', 37, 'Dissipativität des symmetrischen nichtlokalen Diffusionsoperators', 'Ein symmetrischer nichtnegativer Kern erzeugt einen dissipativen Diffusionsoperator.', '\\int u\\mathcal{D}_Ju\\leq0', '\\int u\\mathcal{D}_Ju\\leq0', 'literature', 83, 'Symmetrie und Nichtnegativität des Kerns.', 'verified', 40),
(43, '3.2.31', 37, 'Eindeutigkeit der Tikhonov-Lösung', 'Für alpha größer null besitzt das Tikhonov-Funktional genau einen Minimierer.', '(\\mathcal{K}^*\\mathcal{K}+\\alpha I)u_\\alpha=\\mathcal{K}^*f^\\delta', '(\\mathcal{K}^*\\mathcal{K}+\\alpha I)u_\\alpha=\\mathcal{K}^*f^\\delta', 'literature', 83, 'Beschränkter linearer Operator zwischen Hilberträumen.', 'verified', 40),
(51, '3.2.32', 38, 'Linearität der Fourier-Transformation', 'Die Fourier-Transformation ist linear.', '\\mathcal{F}(\\alpha f+\\beta g)=\\alpha\\mathcal{F}(f)+\\beta\\mathcal{F}(g)', '\\mathcal{F}(\\alpha f+\\beta g)=\\alpha\\mathcal{F}(f)+\\beta\\mathcal{F}(g)', 'literature', 84, 'Geeignete integrierbare Funktionen.', 'verified', 41),
(52, '3.2.33', 38, 'Transformationsregel für Ableitungen', 'Ableitungen werden im Fourier-Raum in Multiplikationen mit Potenzen von i omega überführt.', '\\widehat{f^{(n)}}(\\omega)=(\\mathrm{i}\\omega)^n\\widehat{f}(\\omega)', '\\widehat{f^{(n)}}(\\omega)=(\\mathrm{i}\\omega)^n\\widehat{f}(\\omega)', 'literature', 84, 'Hinreichende Glattheit, Integrabilität und Randabfall.', 'verified', 41),
(53, '3.2.34', 38, 'Faltungssatz', 'Die Fourier-Transformation einer Faltung ist das Produkt der Fourier-Transformierten.', '\\widehat{f*g}(\\omega)=\\widehat{f}(\\omega)\\widehat{g}(\\omega)', '\\widehat{f*g}(\\omega)=\\widehat{f}(\\omega)\\widehat{g}(\\omega)', 'literature', 84, 'Geeignete integrierbare Funktionen.', 'verified', 41),
(54, '3.2.35', 38, 'Plancherel-Satz', 'Die Fourier-Transformation lässt sich stetig auf L2 fortsetzen und erhält die quadratische Norm bis auf die gewählte Normierung.', '\\|\\widehat{f}\\|_{L^2}=\\sqrt{2\\pi}\\|f\\|_{L^2}', '\\|\\widehat{f}\\|_{L^2}=\\sqrt{2\\pi}\\|f\\|_{L^2}', 'literature', 84, 'Verwendete Fourier-Normierung.', 'verified', 41),
(55, '3.2.36', 38, 'Laplace-Transformation einer Ableitung', 'Die Laplace-Transformierte einer Ableitung enthält die transformierte Funktion und die Anfangswerte.', '\\mathcal{L}\\{f^{(n)}\\}(s)=s^nF(s)-\\sum_{k=0}^{n-1}s^{n-1-k}f^{(k)}(0)', '\\mathcal{L}\\{f^{(n)}\\}(s)=s^nF(s)-\\sum_{k=0}^{n-1}s^{n-1-k}f^{(k)}(0)', 'literature', 84, 'Stückweise Stetigkeit, exponentielle Ordnung und hinreichende Differenzierbarkeit.', 'verified', 41),
(58, '3.2.37', 39, 'Normerhaltung der skalierten Wavelet-Familie', 'Die L2-Norm eines Wavelets bleibt unter der normierten Skalierung und Verschiebung erhalten.', '\\|\\psi_{a,b}\\|_{L^{2}}=\\|\\psi\\|_{L^{2}}', '\\|\\psi_{a,b}\\|_{L^{2}}=\\|\\psi\\|_{L^{2}}', 'literature', 85, 'psi in L2(R), a ungleich 0, b reell.', 'verified', 42),
(59, '3.2.38', 39, 'Rekonstruktion aus der kontinuierlichen Wavelet-Transformation', 'Eine geeignete Funktion kann aus ihren kontinuierlichen Wavelet-Koeffizienten rekonstruiert werden.', 'f(t)=\\frac{1}{C_{\\psi}}\\int_{-\\infty}^{\\infty}\\int_{-\\infty}^{\\infty}W_{\\psi}f(a,b)\\psi_{a,b}(t)\\frac{\\mathrm{d}b\\,\\mathrm{d}a}{a^{2}}', 'f(t)=\\frac{1}{C_{\\psi}}\\int_{-\\infty}^{\\infty}\\int_{-\\infty}^{\\infty}W_{\\psi}f(a,b)\\psi_{a,b}(t)\\frac{\\mathrm{d}b\\,\\mathrm{d}a}{a^{2}}', 'literature', 85, 'Zulässiges Wavelet mit 0 kleiner C_psi kleiner unendlich.', 'verified', 42),
(60, '3.2.39', 39, 'Orthogonale Mehrskalenzerlegung', 'L2(R) ist der abgeschlossene direkte Summenraum der orthogonalen Detailräume.', 'L^{2}(\\mathbb{R})=\\overline{\\bigoplus_{j\\in\\mathbb{Z}}W_j}', 'L^{2}(\\mathbb{R})=\\overline{\\bigoplus_{j\\in\\mathbb{Z}}W_j}', 'literature', 85, 'Orthogonale Mehrskalenanalyse.', 'verified', 42),
(61, '3.2.40', 39, 'Energieerhaltung einer orthonormalen Wavelet-Transformation', 'Eine orthonormale diskrete Wavelet-Transformation erhält die euklidische Norm.', '\\|\\mathcal{W}x\\|_{2}=\\|x\\|_{2}', '\\|\\mathcal{W}x\\|_{2}=\\|x\\|_{2}', 'literature', 85, 'Orthonormale diskrete Wavelet-Transformation.', 'verified', 42);

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
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

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
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=265;

--
-- AUTO_INCREMENT für Tabelle `dissertation_sections`
--
ALTER TABLE `dissertation_sections`
  MODIFY `section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

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
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2123;

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
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=219;

--
-- AUTO_INCREMENT für Tabelle `symbols`
--
ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `theorems`
--
ALTER TABLE `theorems`
  MODIFY `theorem_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

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
