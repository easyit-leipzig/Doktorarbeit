-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 29. Jul 2026 um 04:44
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
(67, 'Sherbert', 'Donald R.', 'Sherbert, Donald R.', NULL, NULL, NULL, 'Mitautor der Quelle [83].');

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
(37, '3.2.37', 26, 'Diagonalisierbare Matrix', '', NULL, NULL, 'original', NULL, NULL, NULL, 'draft', NULL),
(38, '3.2.38', 26, 'Algebraische Vielfachheit', '', NULL, NULL, 'original', NULL, NULL, NULL, 'draft', NULL),
(39, '3.2.39', 26, 'Geometrische Vielfachheit', '', NULL, NULL, 'original', NULL, NULL, NULL, 'draft', NULL),
(40, '3.2.40', 27, 'Matrixzerlegung', '', NULL, NULL, 'original', NULL, NULL, NULL, 'draft', NULL);

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
(26, 12, '3.2.13', 'Diagonalisierbarkeit und Spektralzerlegung', 3, 3.2130, 'final', 0, 'Diagonalisierbarkeit, Spektralzerlegung und Matrixfunktionen', '2026-07-29 02:35:34', '2026-07-29 02:35:34'),
(27, 12, '3.2.14', 'Allgemeine Matrixzerlegungen', 3, 3.2140, 'final', 0, 'LU-, QR-, Cholesky- und Singulärwertzerlegung', '2026-07-29 02:44:10', '2026-07-29 02:44:10');

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
(319, '3.319', 26, 'Diagonalisierbare Matrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(320, '3.320', 26, 'Definition der Diagonalisierung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(321, '3.321', 26, 'Äquivalente Darstellung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(322, '3.322', 26, 'Transformationsmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(323, '3.323', 26, 'Eigenvektoren', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(324, '3.324', 26, 'Matrix P', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(325, '3.325', 26, 'Diagonalmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(326, '3.326', 26, 'Eigenwertgleichung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(327, '3.327', 26, 'Matrixdarstellung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(328, '3.328', 26, 'Diagonalisierung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(329, '3.329', 26, 'Quadratische Matrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(330, '3.330', 26, 'Diagonalisierungskriterium', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(331, '3.331', 26, 'Eigenraum', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(332, '3.332', 26, 'Eigenwert', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(333, '3.333', 26, 'Anzahl Eigenwerte', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(334, '3.334', 26, 'Verschiedene Eigenwerte', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(335, '3.335', 26, 'Hinreichende Bedingung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(336, '3.336', 26, 'Algebraische Vielfachheit', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(337, '3.337', 26, 'Charakteristisches Polynom', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(338, '3.338', 26, 'Beispiel Polynom', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(339, '3.339', 26, 'Eigenwert', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(340, '3.340', 26, 'Algebraische Vielfachheit', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(341, '3.341', 26, 'Geometrische Vielfachheit', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(342, '3.342', 26, 'Eigenraumgleichung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(343, '3.343', 26, 'Ungleichung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(344, '3.344', 26, 'Kriterium', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(345, '3.345', 26, 'Transformationsmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(346, '3.346', 26, 'Diagonalisierung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(347, '3.347', 26, 'Nicht diagonalisierbar', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(348, '3.348', 26, 'Beispiel Matrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(349, '3.349', 26, 'Eigenwerte', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(350, '3.350', 26, 'Einheitsmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(351, '3.351', 26, 'Identität', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(352, '3.352', 26, 'Jordan-Beispiel', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(353, '3.353', 26, 'Charakteristisches Polynom', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(354, '3.354', 26, 'Eigenwert', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(355, '3.355', 26, 'Algebraische Vielfachheit', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(356, '3.356', 26, 'Eigenraum', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(357, '3.357', 26, 'Matrix A-I', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(358, '3.358', 26, 'Lösung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(359, '3.359', 26, 'Dimension', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(360, '3.360', 26, 'Vergleich', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(361, '3.361', 26, 'Matrixpotenz', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(362, '3.362', 26, 'Quadrat', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(363, '3.363', 26, 'Inverse', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(364, '3.364', 26, 'Vereinfachung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(365, '3.365', 26, 'Allgemeine Potenz', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(366, '3.366', 26, 'Diagonalmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(367, '3.367', 26, 'Potenz der Diagonalmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(368, '3.368', 26, 'Matrixfunktion', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(369, '3.369', 26, 'Funktion', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(370, '3.370', 26, 'Definition Matrixfunktion', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(371, '3.371', 26, 'Funktion der Diagonalmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(372, '3.372', 26, 'Matrixexponentialfunktion', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(373, '3.373', 26, 'Exponentialfunktion', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(374, '3.374', 26, 'Exponentialfunktion Diagonalmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(375, '3.375', 26, 'Orthogonale Matrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(376, '3.376', 26, 'Inverse', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(377, '3.377', 26, 'Spektralsatz', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(378, '3.378', 26, 'Eigenvektoren', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(379, '3.379', 26, 'Spektralzerlegung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(380, '3.380', 26, 'Projektionsoperator', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(381, '3.381', 26, 'Darstellung als Projektionssumme', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(382, '3.382', 27, 'Allgemeine Matrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(383, '3.383', 27, 'Definition Matrixzerlegung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(384, '3.384', 27, 'Faktoren der Zerlegung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(385, '3.385', 27, 'Allgemeine Produktdarstellung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(386, '3.386', 27, 'LU-Zerlegung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(387, '3.387', 27, 'Untere Dreiecksmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(388, '3.388', 27, 'Obere Dreiecksmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(389, '3.389', 27, 'Beispielmatrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(390, '3.390', 27, 'Matrix L', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(391, '3.391', 27, 'Matrix U', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(392, '3.392', 27, 'Produkt LU', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(393, '3.393', 27, 'QR-Zerlegung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(394, '3.394', 27, 'Orthogonale Matrix', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(395, '3.395', 27, 'Orthogonalitätsbedingung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(396, '3.396', 27, 'Matrix R', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(397, '3.397', 27, 'Cholesky-Zerlegung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(398, '3.398', 27, 'Matrix L', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(399, '3.399', 27, 'Singulärwertzerlegung', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(400, '3.400', 27, 'Matrix U', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(401, '3.401', 27, 'Matrix V', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(402, '3.402', 27, 'Matrix Sigma', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(403, '3.403', 27, 'Singulärwerte', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL),
(404, '3.404', 27, 'Nichtnegative Singulärwerte', '', '', '', 'other', 'original', NULL, NULL, NULL, 'draft', NULL);

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
('current_section', '3.2.15', '2026-07-29 02:44:10'),
('last_citation_number', '83', '2026-07-28 09:41:13'),
('last_completed_chapter', '3.1', '2026-07-26 17:31:40'),
('last_completed_section', '3.2.14', '2026-07-29 02:44:10'),
('last_definition_number', '3.2.40', '2026-07-29 02:44:10'),
('last_equation_number', '3.404', '2026-07-29 02:44:10'),
('next_citation_number', '84', '2026-07-28 09:41:13'),
('next_definition_number', '3.2.41', '2026-07-29 02:44:10'),
('next_equation_number', '3.405', '2026-07-29 02:44:10');

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
(27, 'RKB-NEU-K3.2.14-V1', '2026-07-29 04:44:10', 'section', '3.2.14', '3.2.14-v1', 'Allgemeine Matrixzerlegungen', 'Olaf Thiele / ChatGPT', NULL);

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
(89, 27, 27, 'created', NULL, NULL, 'Abschnitt 3.2.14 vollständig aufgenommen.', NULL, NULL, '2026-07-29 02:44:10');

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
(71, 83, 'bartle_sherbert_introduction_real_analysis_2011', 'book', 'Introduction to Real Analysis', NULL, 1982, 2011, NULL, 'John Wiley & Sons', 'Hoboken, New Jersey', NULL, NULL, NULL, 'Fourth Edition', NULL, '978-0-471-43331-6', NULL, 'en', 2, 'textbook', 8, 'verified', '3.2.2', 'Erstnennung zur Funktionentheorie reeller Variablen.', 'Bartle, Robert G.; Sherbert, Donald R.: Introduction to Real Analysis. Fourth Edition. Hoboken, New Jersey: John Wiley & Sons, 2011.', 'Bartle/Sherbert: Introduction to Real Analysis, 2011.', 'Grundlage für Funktionen, Grenzwerte und Stetigkeit.', 15, '2026-07-28 05:00:01', '2026-07-28 05:00:01');

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
(71, 67, 2, 'author');

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
(151, 59, 26, '', '', NULL, 0, 0, NULL, NULL),
(152, 62, 26, '', '', NULL, 0, 0, NULL, NULL),
(153, 64, 26, '', '', NULL, 0, 0, NULL, NULL),
(154, 70, 26, '', '', NULL, 0, 0, NULL, NULL),
(158, 59, 27, '', '', NULL, 0, 0, NULL, NULL),
(159, 62, 27, '', '', NULL, 0, 0, NULL, NULL),
(160, 64, 27, '', '', NULL, 0, 0, NULL, NULL),
(161, 70, 27, '', '', NULL, 0, 0, NULL, NULL);

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
(1, '3.2.8', 26, 'Kriterium der Diagonalisierbarkeit', '', NULL, NULL, 'literature', NULL, NULL, 'draft', NULL),
(2, '3.2.9', 26, 'Vollständiges Diagonalisierungskriterium', '', NULL, NULL, 'literature', NULL, NULL, 'draft', NULL),
(3, '3.2.10', 26, 'Spektralzerlegung', '', NULL, NULL, 'literature', NULL, NULL, 'draft', NULL);

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
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

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
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT für Tabelle `dissertation_sections`
--
ALTER TABLE `dissertation_sections`
  MODIFY `section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

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
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=405;

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
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=165;

--
-- AUTO_INCREMENT für Tabelle `symbols`
--
ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `theorems`
--
ALTER TABLE `theorems`
  MODIFY `theorem_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
