-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 18. Jul 2026 um 13:40
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
(74, 'Tarski', 'Alfred', 'Tarski, Alfred', NULL, 1901, 1983, 'Autor der Quelle [75].'),
(75, 'Mac Lane', 'Saunders', 'Mac Lane, Saunders', NULL, 1909, 2005, 'Mathematiker; für Abschnitt 3.1.5 registriert.'),
(76, 'Eilenberg', 'Samuel', 'Eilenberg, Samuel', NULL, 1913, 1998, 'Mathematiker; für Abschnitt 3.1.5 registriert.'),
(77, 'Frege', 'Gottlob', 'Frege, Gottlob', NULL, 1848, 1925, 'Logiker und Mathematiker; für Abschnitt 3.1.6 registriert.'),
(78, 'von Bertalanffy', 'Ludwig', 'von Bertalanffy, Ludwig', NULL, 1901, 1972, 'Biologe und Systemtheoretiker; für Abschnitt 3.1.6 registriert.'),
(79, 'Wiener', 'Norbert', 'Wiener, Norbert', NULL, 1894, 1964, 'Mathematiker und Begründer der Kybernetik.'),
(80, 'Ashby', 'W. Ross', 'Ashby, W. Ross', NULL, 1903, 1972, 'Psychiater und Kybernetiker; für Abschnitt 3.1.6 registriert.'),
(81, 'Resnik', 'Michael D.', 'Resnik, Michael D.', NULL, 1938, NULL, 'Philosoph der Mathematik; für Abschnitt 3.1.6 registriert.'),
(82, 'Shapiro', 'Stewart', 'Shapiro, Stewart', NULL, 1951, NULL, 'Philosoph der Mathematik; für Abschnitt 3.1.6 registriert.'),
(83, 'von Foerster', 'Heinz', 'von Foerster, Heinz', NULL, 1911, 2002, 'Kybernetiker; für Abschnitt 3.1.6 registriert.'),
(84, 'Luhmann', 'Niklas', 'Luhmann, Niklas', NULL, 1927, 1998, 'Soziologe und Systemtheoretiker; für Abschnitt 3.1.6 registriert.'),
(85, 'Cantor', 'Georg', 'Cantor, Georg', NULL, 1845, 1918, 'Begründer der transfiniten Mengenlehre; Quelle [66].'),
(86, 'Zermelo', 'Ernst', 'Zermelo, Ernst', NULL, 1871, 1953, 'Begründer der axiomatischen Mengenlehre; Quelle [68].'),
(87, 'Fraenkel', 'Abraham A.', 'Fraenkel, Abraham A.', NULL, 1891, 1965, 'Mitbegründer der Zermelo-Fraenkel-Mengenlehre; Quelle [69].'),
(88, 'Skolem', 'Thoralf', 'Skolem, Thoralf', NULL, 1887, 1963, 'Beiträge zur Formalisierung der axiomatischen Mengenlehre; Quelle [70].'),
(89, 'Kuratowski', 'Kazimierz', 'Kuratowski, Kazimierz', NULL, 1896, 1980, 'Mengentheoretische Darstellung geordneter Paare; Quelle [71].'),
(90, 'Bourbaki', 'Nicolas', 'Bourbaki, Nicolas', NULL, NULL, NULL, 'Autorenkollektiv; strukturelle mengentheoretische Grundlegung; Quelle [72].'),
(91, 'Peirce', 'Charles Sanders', 'Peirce, Charles Sanders', NULL, 1839, 1914, 'Autor der Quelle [73].'),
(92, 'Schröder', 'Ernst', 'Schröder, Ernst', NULL, 1841, 1902, 'Autor der Quelle [74].'),
(94, 'Noether', 'Emmy', 'Noether, Emmy', NULL, 1882, 1935, 'Autorin der Quelle [76].'),
(95, 'van der Waerden', 'Bartel Leendert', 'van der Waerden, Bartel Leendert', NULL, 1903, 1996, 'Autor der Quelle [77].'),
(96, 'Galois', 'Évariste', 'Galois, Évariste', NULL, 1811, 1832, 'Autor der Quelle [78].'),
(97, 'Euler', 'Leonhard', 'Euler, Leonhard', NULL, 1707, 1783, 'Autor der Quelle [79].'),
(98, 'Diestel', 'Reinhard', 'Diestel, Reinhard', NULL, 1959, NULL, 'Autor der Quelle [80].'),
(99, 'Newman', 'Mark', 'Newman, Mark', NULL, 1968, NULL, 'Autor der Quelle [81].'),
(100, 'Barabási', 'Albert-László', 'Barabási, Albert-László', NULL, 1967, NULL, 'Autor der Quelle [82].'),
(101, 'Dirichlet', 'Peter Gustav Lejeune', 'Dirichlet, Peter Gustav Lejeune', NULL, 1805, 1859, 'Autor der Quelle [84].'),
(106, 'Grassmann', 'Hermann', 'Grassmann, Hermann', NULL, 1809, 1877, 'Autor der Quelle [85].'),
(107, 'Peano', 'Giuseppe', 'Peano, Giuseppe', NULL, 1858, 1932, 'Autor der Quelle [86].'),
(108, 'Sylvester', 'James Joseph', 'Sylvester, James Joseph', NULL, 1814, 1897, 'Autor der Quelle [88].'),
(109, 'Cayley', 'Arthur', 'Cayley, Arthur', NULL, 1821, 1895, 'Autor der Quelle [89].'),
(110, 'Halmos', 'Paul Richard', 'Halmos, Paul Richard', NULL, 1916, 2006, 'Autor der Quelle [90].');

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
(1, '3.2.1', 13, 'Menge und Elementbeziehung', 'Eine Menge M ist innerhalb der Mengenlehre ein mathematischer Träger, für dessen mögliche Gegenstände x bestimmt ist, ob x Element von M ist oder nicht. Die Elementbeziehung wird durch x ∈ M, ihre Negation durch x ∉ M bezeichnet.', 'x in M,qquad x \notin M', 'x in M,qquad x \notin M', 'adapted', 71, 'Es wird ein axiomatischer mengentheoretischer Rahmen vorausgesetzt.', 'Die Definition beschreibt die formale Träger- und Zugehörigkeitsstruktur, nicht die funktionale Genese von Elementen.', 'checked', 10),
(2, '3.2.2', 13, 'Teilmenge', 'Eine Menge A heißt Teilmenge einer Menge B, wenn jedes Element von A zugleich Element von B ist.', 'Asubseteq B iff forall x,(xin A\rightarrow xin B)', 'Asubseteq B iff forall x,(xin A\rightarrow xin B)', 'adapted', 71, 'A und B sind Mengen innerhalb desselben axiomatischen Rahmens.', 'Die Teilmengenrelation bildet eine Ordnungsstruktur auf der Potenzmenge.', 'checked', 10),
(3, '3.2.3', 13, 'Potenzmenge', 'Die Potenzmenge einer Menge M ist die Menge sämtlicher Teilmengen von M.', 'mathcal{P}(M)={Amid Asubseteq M}', 'mathcal{P}(M)={Amid Asubseteq M}', 'adapted', 66, 'M ist eine Menge und die Potenzmengenbildung ist im verwendeten Axiomensystem zugelassen.', 'Die Potenzmenge hebt die Beschreibung von Elementen auf die Ebene möglicher Teilmengen.', 'checked', 10),
(4, '3.2.4', 14, 'Binäre Relation', 'Eine binäre Relation R zwischen den Mengen A und B ist eine Teilmenge des kartesischen Produkts A×B. Für a∈A und b∈B gilt aRb genau dann, wenn (a,b)∈R.', 'R\\subseteq A\\times B,\\qquad aRb\\iff(a,b)\\in R', 'R\\subseteq A\\times B,\\qquad aRb\\iff(a,b)\\in R', 'adapted', 75, 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.', 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.', 'checked', 11),
(5, '3.2.5', 14, 'Relation auf einer Menge', 'Eine binäre Relation R auf einer Menge M ist eine Teilmenge von M×M.', 'R\\subseteq M\\times M', 'R\\subseteq M\\times M', 'adapted', 75, 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.', 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.', 'checked', 11),
(6, '3.2.6', 14, 'n-stellige Relation', 'Für Mengen A_1 bis A_n ist eine n-stellige Relation R eine Teilmenge des kartesischen Produkts A_1×…×A_n.', 'R\\subseteq A_1\\times A_2\\times\\cdots\\times A_n', 'R\\subseteq A_1\\times A_2\\times\\cdots\\times A_n', 'adapted', 73, 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.', 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.', 'checked', 11),
(7, '3.2.7', 14, 'Reflexivität', 'Eine Relation R auf M heißt reflexiv, wenn jedes Element zu sich selbst in Relation steht; sie heißt irreflexiv, wenn kein Element zu sich selbst in Relation steht.', '\\forall x\\in M:\\;xRx', '\\forall x\\in M:\\;xRx', 'adapted', 75, 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.', 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.', 'checked', 11),
(8, '3.2.8', 14, 'Symmetrie und Antisymmetrie', 'Eine Relation R auf M heißt symmetrisch, wenn aus xRy stets yRx folgt. Sie heißt antisymmetrisch, wenn aus xRy und yRx die Gleichheit x=y folgt.', '\\forall x,y\\in M:\\;xRy\\rightarrow yRx', '\\forall x,y\\in M:\\;xRy\\rightarrow yRx', 'adapted', 75, 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.', 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.', 'checked', 11),
(9, '3.2.9', 14, 'Transitivität', 'Eine Relation R auf M heißt transitiv, wenn aus xRy und yRz stets xRz folgt.', '\\forall x,y,z\\in M:\\;(xRy\\land yRz)\\rightarrow xRz', '\\forall x,y,z\\in M:\\;(xRy\\land yRz)\\rightarrow xRz', 'adapted', 75, 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.', 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.', 'checked', 11),
(10, '3.2.10', 14, 'Äquivalenzrelation', 'Eine Relation auf M heißt Äquivalenzrelation, wenn sie reflexiv, symmetrisch und transitiv ist.', '\\sim\\;\\text{ist reflexiv, symmetrisch und transitiv}', '\\sim\\;\\text{ist reflexiv, symmetrisch und transitiv}', 'adapted', 71, 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.', 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.', 'checked', 11),
(11, '3.2.11', 14, 'Partielle Ordnung', 'Eine Relation auf M heißt partielle Ordnung, wenn sie reflexiv, antisymmetrisch und transitiv ist.', '\\preceq\\;\\text{ist reflexiv, antisymmetrisch und transitiv}', '\\preceq\\;\\text{ist reflexiv, antisymmetrisch und transitiv}', 'adapted', 71, 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.', 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.', 'checked', 11),
(12, '3.2.12', 14, 'Umkehrrelation', 'Für R⊆A×B ist die Umkehrrelation R^{-1}⊆B×A durch Vertauschung aller geordneten Paare definiert.', 'R^{-1}=\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\}', 'R^{-1}=\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\}', 'adapted', 75, 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.', 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.', 'checked', 11),
(13, '3.2.13', 14, 'Relationale Komposition', 'Für R⊆A×B und S⊆B×C enthält S∘R genau diejenigen Paare (a,c), für die ein vermittelndes b∈B mit aRb und bSc existiert.', 'S\\circ R=\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\;aRb\\land bSc\\}', 'S\\circ R=\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\;aRb\\land bSc\\}', 'adapted', 75, 'Die beteiligten Trägermengen und kartesischen Produkte sind bereits bestimmt.', 'Literaturgestützte Rekonstruktion des etablierten mathematischen Relationsbegriffs.', 'checked', 11),
(14, '3.2.14', 15, 'Algebraische Verknüpfung', 'Sei M eine Menge. Eine zweistellige Verknüpfung auf M ist eine Abbildung von M×M nach M, die jedem geordneten Paar (a,b) genau ein Element a∗b aus M zuordnet.', 'ast:M	imes M\rightarrow M', 'ast:M	imes M\rightarrow M', 'adapted', 77, 'M ist eine nichtleere Menge.', 'Die Definition beschreibt eine innere zweistellige Operation.', 'checked', 12),
(15, '3.2.15', 15, 'Abgeschlossenheit', 'Eine Verknüpfung ∗ heißt auf M abgeschlossen, wenn für alle a,b aus M auch a∗b wieder Element von M ist.', 'forall a,bin M:;aast bin M', 'forall a,bin M:;aast bin M', 'adapted', 77, 'Auf M ist eine zweistellige Verknüpfung definiert.', 'Die Abgeschlossenheit hält sämtliche Operationsergebnisse im Trägerbereich.', 'checked', 12),
(16, '3.2.16', 15, 'Assoziativität', 'Eine Verknüpfung ∗ heißt assoziativ, wenn für alle a,b,c aus M die Gleichheit (a∗b)∗c=a∗(b∗c) gilt.', '(aast b)ast c=aast(bast c)', '(aast b)ast c=aast(bast c)', 'adapted', 77, 'Auf M ist eine abgeschlossene zweistellige Verknüpfung definiert.', 'Die Klammerung längerer Verknüpfungsfolgen verändert das Ergebnis nicht.', 'checked', 12),
(17, '3.2.17', 15, 'Neutrales Element', 'Ein Element e aus M heißt neutrales Element bezüglich ∗, wenn e∗a=a∗e=a für alle a aus M gilt.', 'east a=aast e=a', 'east a=aast e=a', 'adapted', 77, 'Auf M ist eine zweistellige Verknüpfung definiert.', 'Das neutrale Element lässt jedes andere Element bei der Verknüpfung unverändert.', 'checked', 12),
(18, '3.2.18', 15, 'Inverses Element', 'Zu a aus M heißt a^{-1} invers, wenn a∗a^{-1}=a^{-1}∗a=e gilt.', 'aast a^{-1}=a^{-1}ast a=e', 'aast a^{-1}=a^{-1}ast a=e', 'adapted', 77, 'Ein neutrales Element e ist bestimmt.', 'Das inverse Element hebt die Wirkung eines Elements bezüglich der Verknüpfung auf.', 'checked', 12),
(19, '3.2.19', 15, 'Gruppe', 'Ein Paar (M,∗) heißt Gruppe, wenn die Verknüpfung abgeschlossen und assoziativ ist, ein neutrales Element existiert und jedes Element ein Inverses besitzt. Gilt zusätzlich a∗b=b∗a, heißt die Gruppe abelsch.', '(M,ast)', '(M,ast)', 'adapted', 77, 'M ist eine nichtleere Menge mit innerer zweistelliger Verknüpfung.', 'Gruppen abstrahieren invertierbare Operationen und Symmetrien.', 'checked', 12),
(20, '3.2.20', 15, 'Ring', 'Ein Ring ist eine Menge R mit zwei Verknüpfungen + und ·, sodass (R,+) eine abelsche Gruppe bildet, die Multiplikation assoziativ ist und beide Operationen durch die Distributivgesetze verbunden sind.', 'acdot(b+c)=acdot b+acdot c', 'acdot(b+c)=acdot b+acdot c', 'adapted', 77, 'Auf R sind Addition und Multiplikation definiert.', 'Die Definition folgt der im Abschnitt verwendeten vereinfachten Ringfassung.', 'checked', 12),
(21, '3.2.21', 15, 'Körper', 'Ein Körper ist ein Ring, in dem jedes von Null verschiedene Element ein multiplikatives Inverses besitzt.', 'acdot a^{-1}=1', 'acdot a^{-1}=1', 'adapted', 77, 'a ist ein von Null verschiedenes Ringelement.', 'Körper ermöglichen die vier elementaren arithmetischen Operationen unter den üblichen Einschränkungen.', 'checked', 12),
(22, '3.2.22', 16, 'Graph', 'Ein Graph ist ein geordnetes Paar G=(V,E), wobei V die Knotenmenge und E die Kantenmenge bezeichnet.', 'G=(V,E)', 'G=(V,E)', 'adapted', 80, 'V und E sind Mengen.', 'Grunddefinition eines Graphen.', 'checked', 13),
(23, '3.2.23', 16, 'Gerichteter Graph', 'Ein gerichteter Graph ist ein Paar G=(V,E) mit E⊆V×V.', 'E\\subseteq V\\times V', 'E\\subseteq V\\times V', 'adapted', 80, 'V ist eine Knotenmenge.', 'Gerichtete Kanten sind geordnete Paare.', 'checked', 13),
(24, '3.2.24', 16, 'Knotengrad', 'Der Grad eines Knotens ist die Anzahl seiner unmittelbaren Nachbarn; in gerichteten Graphen werden Eingangs- und Ausgangsgrad unterschieden.', '\\deg(v)=\\left|\\left\\{u\\in V\\mid\\{u,v\\}\\in E\\right\\}\\right|', '\\deg(v)=\\left|\\left\\{u\\in V\\mid\\{u,v\\}\\in E\\right\\}\\right|', 'adapted', 80, 'G=(V,E) und v∈V.', 'Lokales Vernetzungsmaß.', 'checked', 13),
(25, '3.2.25', 16, 'Adjazenzmatrix', 'Die Adjazenzmatrix A_G=(a_ij) bildet die Kantenstruktur eines endlichen Graphen binär ab.', '\\mathbf{A}_G=(a_{ij})\\in\\{0,1\\}^{n\\times n}', '\\mathbf{A}_G=(a_{ij})\\in\\{0,1\\}^{n\\times n}', 'adapted', 81, 'V ist endlich und geordnet.', 'Matrixdarstellung der Kantenstruktur.', 'checked', 13),
(26, '3.2.26', 16, 'Kantenzug und Pfad', 'Ein Kantenzug ist eine Folge benachbarter Knoten. Ein Pfad ist ein Kantenzug ohne mehrfach vorkommende Knoten.', 'W=(v_0,v_1,\\ldots,v_k)', 'W=(v_0,v_1,\\ldots,v_k)', 'adapted', 80, 'Die Kantenfolge ist zulässig.', 'Grundlage für Erreichbarkeit und Distanz.', 'checked', 13),
(27, '3.2.27', 16, 'Zusammenhang', 'Ein Graph heißt zusammenhängend, wenn zwischen je zwei Knoten ein Pfad existiert.', '\\forall u,v\\in V\\;\\exists P_{uv}', '\\forall u,v\\in V\\;\\exists P_{uv}', 'adapted', 80, 'G=(V,E).', 'Globale Erreichbarkeitseigenschaft.', 'checked', 13),
(28, '3.2.28', 16, 'Graphendistanz', 'Die Distanz d_G(u,v) ist die minimale Länge eines Pfades von u nach v.', 'd_G(u,v)=\\min\\left\\{\\ell(P)\\mid P\\text{ ist ein Pfad von }u\\text{ nach }v\\right\\}', 'd_G(u,v)=\\min\\left\\{\\ell(P)\\mid P\\text{ ist ein Pfad von }u\\text{ nach }v\\right\\}', 'adapted', 80, 'Zwischen u und v existiert ein Pfad.', 'Strukturelle Entfernung.', 'checked', 13),
(29, '3.2.29', 16, 'Zyklus', 'Ein Zyklus ist ein geschlossener Pfad mit paarweise verschiedenen inneren Knoten.', 'C=(v_0,v_1,\\ldots,v_{k-1},v_0)', 'C=(v_0,v_1,\\ldots,v_{k-1},v_0)', 'adapted', 80, 'Die Kantenfolge ist geschlossen.', 'Geschlossene Verbindungsfolge.', 'checked', 13),
(30, '3.2.30', 16, 'Baum', 'Ein Baum ist ein zusammenhängender ungerichteter Graph ohne Zyklen.', '|E|=|V|-1', '|E|=|V|-1', 'adapted', 80, 'Der Graph ist endlich, ungerichtet und azyklisch.', 'Für endliche Bäume gilt |E|=|V|-1.', 'checked', 13),
(31, '3.2.31', 16, 'Gewichteter Graph', 'Ein gewichteter Graph ist ein Tripel G=(V,E,w) mit einer Gewichtsfunktion w:E→R.', 'w:E\\rightarrow\\mathbb{R}', 'w:E\\rightarrow\\mathbb{R}', 'adapted', 81, 'G=(V,E).', 'Kanten erhalten quantitative Werte.', 'checked', 13),
(32, '3.2.32', 17, 'Funktion', 'Eine Funktion f:A→B ist eine Relation f⊆A×B, die jedem Element a∈A genau ein Element b∈B zuordnet.', 'f:A\rightarrow B,qquadforall ain A;exists!,bin B:(a,b)in f', 'f:A\rightarrow B,qquadforall ain A;exists!,bin B:(a,b)in f', 'adapted', 71, 'A und B sind Mengen.', 'Mengentheoretische Definition einer eindeutigen Zuordnung.', 'checked', 14),
(33, '3.2.33', 17, 'Bildmenge', 'Die Bildmenge f(A) besteht aus allen Elementen des Zielbereichs, die von mindestens einem Element des Definitionsbereichs angenommen werden.', 'f(A)={f(a)mid ain A}', 'f(A)={f(a)mid ain A}', 'adapted', 71, 'f:A→B ist eine Funktion.', 'Die Bildmenge ist im Allgemeinen nur eine Teilmenge des Zielbereichs.', 'checked', 14),
(34, '3.2.34', 17, 'Injektivität', 'Eine Funktion ist injektiv, wenn gleiche Funktionswerte nur von gleichen Argumenten erzeugt werden.', 'f(a_1)=f(a_2)Longrightarrow a_1=a_2', 'f(a_1)=f(a_2)Longrightarrow a_1=a_2', 'adapted', 71, 'f:A→B ist eine Funktion.', 'Verschiedene Elemente des Definitionsbereichs besitzen verschiedene Bilder.', 'checked', 14),
(35, '3.2.35', 17, 'Surjektivität', 'Eine Funktion ist surjektiv, wenn jedes Element des Zielbereichs mindestens ein Urbild besitzt.', 'forall bin B;exists ain A:f(a)=b', 'forall bin B;exists ain A:f(a)=b', 'adapted', 71, 'f:A→B ist eine Funktion.', 'Für eine surjektive Funktion gilt f(A)=B.', 'checked', 14),
(36, '3.2.36', 17, 'Bijektivität', 'Eine Funktion ist bijektiv, wenn sie zugleich injektiv und surjektiv ist.', 'f	ext{ bijektiv}Longleftrightarrow f	ext{ injektiv und surjektiv}', 'f	ext{ bijektiv}Longleftrightarrow f	ext{ injektiv und surjektiv}', 'adapted', 71, 'f:A→B ist eine Funktion.', 'Bijektivität ist die Voraussetzung für eine eindeutige Umkehrfunktion.', 'checked', 14),
(37, '3.2.37', 17, 'Funktionskomposition', 'Für f:A→B und g:B→C ist die Komposition g∘f:A→C durch (g∘f)(a)=g(f(a)) definiert.', '(gcirc f)(a)=g(f(a))', '(gcirc f)(a)=g(f(a))', 'adapted', 71, 'Der Zielbereich von f entspricht dem Definitionsbereich von g.', 'Die Komposition beschreibt eine Folge eindeutiger Transformationen.', 'checked', 14),
(38, '3.2.38', 17, 'Identitätsabbildung', 'Die Identitätsabbildung id_A:A→A ordnet jedem Element a∈A sich selbst zu.', 'operatorname{id}_A(a)=a', 'operatorname{id}_A(a)=a', 'adapted', 71, 'A ist eine Menge.', 'Die Identität wirkt bezüglich der Funktionskomposition neutral.', 'checked', 14),
(51, '3.2.39', 18, 'Vektorraum', 'Ein Vektorraum über einem Körper K ist eine Menge V mit einer Vektoraddition und einer Skalarmultiplikation, welche die acht Vektorraumaxiome erfüllen.', '+:V	imes V\rightarrow V,qquadcdot:K	imes V\rightarrow V', '+:V	imes V\rightarrow V,qquadcdot:K	imes V\rightarrow V', 'adapted', 93, 'K ist ein Körper; V ist eine nichtleere Menge.', 'Die Definition umfasst Abgeschlossenheit, Assoziativität und Kommutativität der Addition, Nullvektor, additive Inverse, beide Distributivgesetze, Verträglichkeit der Skalarmultiplikation und Einheitswirkung.', 'checked', 17),
(52, '3.2.40', 18, 'Linearkombination', 'Eine Linearkombination der Vektoren v_1 bis v_n ist eine endliche Summe skalarer Vielfacher dieser Vektoren.', 'sum_{i=1}^{n}lambda_i v_i', 'sum_{i=1}^{n}lambda_i v_i', 'adapted', 93, 'v_i∈V und λ_i∈K.', 'Linearkombinationen verbinden Vektoraddition und Skalarmultiplikation.', 'checked', 17),
(53, '3.2.41', 18, 'Linearer Spann', 'Der lineare Spann einer Teilmenge M eines Vektorraums ist die Menge aller endlichen Linearkombinationen von Elementen aus M.', 'operatorname{span}(M)=left{sum_{i=1}^{n}lambda_i v_imid v_iin M\right}', 'operatorname{span}(M)=left{sum_{i=1}^{n}lambda_i v_imid v_iin M\right}', 'adapted', 93, 'M⊆V.', 'Der Spann ist der kleinste Untervektorraum, der M enthält.', 'checked', 17),
(54, '3.2.42', 18, 'Lineare Unabhängigkeit', 'Vektoren v_1 bis v_n heißen linear unabhängig, wenn nur die triviale Linearkombination den Nullvektor ergibt.', 'sum_{i=1}^{n}lambda_i v_i=0Longrightarrowlambda_i=0quad(i=1,ldots,n)', 'sum_{i=1}^{n}lambda_i v_i=0Longrightarrowlambda_i=0quad(i=1,ldots,n)', 'adapted', 93, 'v_i∈V und λ_i∈K.', 'Keiner der Vektoren kann als Linearkombination der übrigen dargestellt werden.', 'checked', 17),
(55, '3.2.43', 18, 'Basis', 'Eine Basis eines Vektorraums ist eine linear unabhängige Menge, deren linearer Spann den gesamten Vektorraum erzeugt.', 'V=operatorname{span}{e_1,ldots,e_n}', 'V=operatorname{span}{e_1,ldots,e_n}', 'adapted', 93, 'V ist endlichdimensional, sofern eine endliche Basis betrachtet wird.', 'Jeder Vektor besitzt bezüglich einer Basis eine eindeutige Koordinatendarstellung.', 'checked', 17),
(56, '3.2.44', 18, 'Dimension', 'Die Dimension eines endlichdimensionalen Vektorraums ist die Anzahl der Elemente einer Basis.', 'dim(V)=n', 'dim(V)=n', 'adapted', 93, 'V besitzt eine endliche Basis.', 'Alle Basen eines endlichdimensionalen Vektorraums besitzen dieselbe Anzahl von Elementen.', 'checked', 17),
(57, '3.2.45', 19, 'Lineare Abbildung', 'Eine Abbildung T von V nach W heißt linear, wenn sie Vektoraddition und Skalarmultiplikation erhält.', 'T:V\rightarrow W,quad T(u+v)=T(u)+T(v),quad T(lambda v)=lambda T(v)', 'T:V\rightarrow W,quad T(u+v)=T(u)+T(v),quad T(lambda v)=lambda T(v)', 'adapted', 96, 'V und W sind Vektorräume über demselben Körper K.', 'Additivität und Homogenität können zur Erhaltung beliebiger Linearkombinationen zusammengefasst werden.', 'checked', 18),
(58, '3.2.46', 19, 'Kern einer linearen Abbildung', 'Der Kern einer linearen Abbildung ist die Menge aller Vektoren des Ausgangsraums, die auf den Nullvektor des Zielraums abgebildet werden.', 'ker(T)=left{vin Vmid T(v)=0_W\right}', 'ker(T)=left{vin Vmid T(v)=0_W\right}', 'adapted', 96, 'T:V→W ist linear.', 'Der Kern beschreibt die unter der Abbildung ausgelöschten Richtungen.', 'checked', 18),
(59, '3.2.47', 19, 'Bild einer linearen Abbildung', 'Das Bild einer linearen Abbildung enthält alle durch die Abbildung erreichbaren Vektoren des Zielraums.', 'operatorname{im}(T)=left{T(v)mid vin V\right}', 'operatorname{im}(T)=left{T(v)mid vin V\right}', 'adapted', 96, 'T:V→W ist linear.', 'Das Bild ist ein Untervektorraum des Zielraums.', 'checked', 18),
(60, '3.2.48', 19, 'Rang und Nullität', 'Der Rang einer linearen Abbildung ist die Dimension ihres Bildes; ihre Nullität ist die Dimension ihres Kerns.', 'operatorname{rang}(T)=dim(operatorname{im}(T)),quadoperatorname{null}(T)=dim(ker(T))', 'operatorname{rang}(T)=dim(operatorname{im}(T)),quadoperatorname{null}(T)=dim(ker(T))', 'adapted', 96, 'Kern und Bild sind endlichdimensional.', 'Rang und Nullität zerlegen im Dimensionssatz die Dimension des Ausgangsraums.', 'checked', 18),
(61, '3.2.49', 19, 'Darstellungsmatrix einer linearen Abbildung', 'Die Darstellungsmatrix einer linearen Abbildung enthält spaltenweise die Koordinaten der Bilder der Basisvektoren des Ausgangsraums bezüglich einer Basis des Zielraums.', '[T]_{Cleftarrow B}=(a_{ij})', '[T]_{Cleftarrow B}=(a_{ij})', 'adapted', 96, 'B ist eine Basis von V und C eine Basis von W.', 'Die Matrix hängt von den gewählten Basen ab, die lineare Abbildung selbst nicht.', 'checked', 18),
(62, '3.2.50', 19, 'Linearer Operator', 'Ein linearer Operator ist eine lineare Abbildung eines Vektorraums in sich selbst.', 'T:V\rightarrow V', 'T:V\rightarrow V', 'adapted', 96, 'V ist ein Vektorraum.', 'Ausgangsraum und Zielraum stimmen überein.', 'checked', 18),
(63, '3.2.51', 19, 'Invertierbarer linearer Operator', 'Ein linearer Operator heißt invertierbar, wenn ein linearer inverser Operator existiert, dessen beidseitige Komposition mit T die Identität ergibt.', 'T^{-1}circ T=Tcirc T^{-1}=operatorname{id}_V', 'T^{-1}circ T=Tcirc T^{-1}=operatorname{id}_V', 'adapted', 96, 'T:V→V ist linear.', 'Invertierbarkeit ermöglicht die eindeutige Rekonstruktion des Ausgangsvektors.', 'checked', 18);

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
(7, 2, '3.1.4', 'Erkenntnistheoretische Grundlagen', 3, 3.1400, 'final', 0, 'Erkenntnistheoretische Abgrenzung von Konstruktion, Modell, Interpretation, empirischer Geltung und Ontologie.', '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(8, 2, '3.1.5', 'Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem', 3, 3.1500, 'final', 1, 'Festlegung der methodologischen Arbeitsregeln des FRZK: schrittweiser Aufbau, Vermeidung verdeckter Voraussetzungen, Trennung von mathematischer Konstruktion und empirischer Interpretation, Strukturerhaltung, Modularisierung, Versionierung und Vorrang der mathematischen Rekonstruktion.', '2026-07-17 15:19:42', '2026-07-17 15:19:42'),
(9, 2, '3.1.6', 'Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft', 3, 3.1600, 'final', 1, 'Begründung des methodischen Übergangs von vorausgesetzten Objekten zu funktionaler Wirksamkeit, relationaler Bestimmung, Prozessualität, Rekursivität und funktionaler Stabilisierung.', '2026-07-18 04:49:51', '2026-07-18 04:49:51'),
(10, 2, '3.1.7', 'Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung', 3, 3.1700, 'final', 1, 'Zusammenführung des Forschungsstandes.', '2026-07-18 04:55:37', '2026-07-18 04:55:37'),
(11, 1, '3.2', 'Mathematische Grundlagen', 3, 3.2000, 'review', 0, 'Mathematische Brücke zwischen den wissenschaftstheoretischen Grundlagen aus Kapitel 3.1 und der axiomatischen Grundlegung in Kapitel 3.3. Der Abschnitt rekonstruiert den etablierten mathematischen Forschungsstand, ohne die eigene FRZK-Mathematik vorwegzunehmen.', '2026-07-18 05:28:52', '2026-07-18 05:28:52'),
(12, 11, '3.2.0', 'Einleitung', 3, 3.2001, 'final', 0, 'Die Einleitung bestimmt Kapitel 3.2 als mathematischen Forschungsstandsabschnitt. Sie erläutert den Übergang von der wissenschaftstheoretischen Grundlegung zu den etablierten mathematischen Strukturbegriffen und macht sichtbar, dass mathematische Theorien Mengen, Relationen, Funktionen, Operatoren, Zustandsräume und weitere Strukturen regelmäßig bereits voraussetzen. Die eigene FRZK-Axiomatik und mathematische Rekonstruktion bleiben den Kapiteln 3.3 und 3.4 vorbehalten.', '2026-07-18 05:28:53', '2026-07-18 05:28:53'),
(13, 11, '3.2.1', 'Mengen als Grundlage mathematischer Modellbildung', 3, 3.2100, 'final', 0, 'Der Abschnitt rekonstruiert die Mengenlehre als formale Trägerstruktur moderner Mathematik. Behandelt werden Elementbeziehung, Extensionalität, Teilmengen, Potenzmengen, Cantors Satz, geordnete Paare und kartesische Produkte. Die Leistungsfähigkeit der Mengenlehre wird von der weiterführenden Frage nach Entstehung, Auswahl und funktionaler Wirksamkeit mathematischer Strukturen abgegrenzt.', '2026-07-18 06:03:45', '2026-07-18 06:03:45'),
(14, 11, '3.2.2', 'Relationen als Beschreibung mathematischer Zusammenhänge', 3, 3.2200, 'final', 0, 'Der Abschnitt rekonstruiert Relationen als Auswahl geordneter Tupel aus kartesischen Produkten. Behandelt werden Relationseigenschaften, Äquivalenzen, Ordnungen, Umkehrung, Komposition, Hüllen und Matrixdarstellungen. Die Darstellung bleibt Forschungsstand und nimmt keine FRZK-Axiomatik vorweg.', '2026-07-18 06:16:56', '2026-07-18 06:16:56'),
(15, 11, '3.2.3', 'Algebraische Strukturen als Träger mathematischer Operationen', 3, 3.2300, 'final', 0, 'Der Abschnitt rekonstruiert algebraische Strukturen als Mengen mit inneren Verknüpfungen. Behandelt werden Abgeschlossenheit, Assoziativität, neutrales und inverses Element sowie Gruppen, Ringe und Körper. Die Darstellung bleibt mathematischer Forschungsstand und bereitet den späteren Übergang zu funktionalen Operationen vor.', '2026-07-18 06:51:13', '2026-07-18 06:51:13'),
(16, 11, '3.2.4', 'Graphen und Netzwerke als Darstellung relationaler Gesamtstrukturen', 3, 3.2400, 'final', 0, 'Der Abschnitt rekonstruiert Graphen als relationale Gesamtstrukturen und behandelt gerichtete sowie ungerichtete Graphen, Grade, Adjazenzmatrizen, Pfade, Zusammenhang, Distanz, Zyklen, Bäume, gewichtete Graphen, Gradverteilungen, Clusterkoeffizienten und Gradzentralität.', '2026-07-18 07:43:11', '2026-07-18 07:43:11'),
(17, 11, '3.2.5', 'Funktionen und Abbildungen als formale Beschreibung eindeutiger Zuordnungen', 3, 3.2500, 'final', 0, 'Der Abschnitt rekonstruiert Funktionen als eindeutige Relationen zwischen Mengen. Behandelt werden Definitions- und Zielbereich, Bildmenge, Injektivität, Surjektivität, Bijektivität, Umkehrfunktion, Komposition und Identitätsabbildung. Die Darstellung bleibt mathematischer Forschungsstand.', '2026-07-18 08:59:33', '2026-07-18 08:59:33'),
(18, 11, '3.2.6', 'Vektorräume als mathematische Beschreibung linearer Zustandsräume', 3, 3.2600, 'final', 0, 'Der Abschnitt führt Vektorräume über die Vektoraddition und Skalarmultiplikation ein. Behandelt werden die acht Vektorraumaxiome, Nullvektor und additives Inverses, Linearkombination, linearer Spann, lineare Unabhängigkeit, Basis und Dimension.', '2026-07-18 11:15:45', '2026-07-18 11:15:45'),
(19, 11, '3.2.7', 'Lineare Abbildungen, Matrizen und Operatoren', 3, 3.2700, 'final', 0, 'Der Abschnitt behandelt lineare Abbildungen, Kern, Bild, Rang, Nullität, Darstellungsmatrizen, lineare Operatoren, Komposition und Invertierbarkeit.', '2026-07-18 11:39:48', '2026-07-18 11:39:48');

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
(1, '3.149', 13, 'Elementbeziehung', 'x in M', 'x in M', 'x ist Element der Menge M.', 'definition', 'adapted', 71, NULL, 'M ist eine Menge; x ist ein möglicher Gegenstand der Elementbeziehung.', 'checked', 10),
(2, '3.150', 13, 'Negierte Elementbeziehung', 'x \notin M', 'x \notin M', 'x ist kein Element der Menge M.', 'definition', 'adapted', 71, NULL, 'M ist eine Menge; x ist ein möglicher Gegenstand der Elementbeziehung.', 'checked', 10),
(3, '3.151', 13, 'Extensionalitätsprinzip', 'A=B iff forall x,(xin A leftrightarrow xin B)', 'A=B iff forall x,(xin A leftrightarrow xin B)', 'Zwei Mengen sind genau dann gleich, wenn sie dieselben Elemente besitzen.', 'axiom', 'literature', 67, 'Formale Darstellung des Extensionalitätsaxioms.', 'A und B sind Mengen im zugrunde gelegten Axiomensystem.', 'checked', 10),
(4, '3.152', 13, 'Teilmengenrelation', 'Asubseteq B iff forall x,(xin A\rightarrow xin B)', 'Asubseteq B iff forall x,(xin A\rightarrow xin B)', 'A ist genau dann Teilmenge von B, wenn jedes Element von A auch Element von B ist.', 'definition', 'adapted', 71, NULL, 'A und B sind Mengen.', 'checked', 10),
(5, '3.153', 13, 'Potenzmenge', 'mathcal{P}(M)={Amid Asubseteq M}', 'mathcal{P}(M)={Amid Asubseteq M}', 'Die Potenzmenge von M besteht aus sämtlichen Teilmengen von M.', 'definition', 'adapted', 66, NULL, 'M ist eine Menge.', 'checked', 10),
(6, '3.154', 13, 'Mächtigkeit der Potenzmenge', '|M|<|mathcal{P}(M)|', '|M|<|mathcal{P}(M)|', 'Die Potenzmenge besitzt eine strikt größere Mächtigkeit als die Ausgangsmenge.', 'theorem', 'literature', 66, 'Folgerung aus Cantors Diagonalargument.', 'Die Mächtigkeit wird über Bijektionen beziehungsweise Injektionen verglichen.', 'checked', 10),
(7, '3.155', 13, 'Diagonalmenge', 'D={xin Mmid x\notin f(x)}', 'D={xin Mmid x\notin f(x)}', 'D enthält genau diejenigen Elemente x aus M, die nicht Element ihres Bildes f(x) sind.', 'derived', 'adapted', 66, 'Konstruktion innerhalb des Widerspruchsbeweises zu Cantors Satz.', 'Es wird vorübergehend eine surjektive Abbildung f von M nach P(M) angenommen.', 'checked', 10),
(8, '3.156', 13, 'Widerspruch des Diagonalarguments', 'din D iff d\notin f(d) iff d\notin D', 'din D iff d\notin f(d) iff d\notin D', 'Für das Element d mit f(d)=D entsteht der Widerspruch, dass d genau dann Element von D ist, wenn d nicht Element von D ist.', 'derived', 'adapted', 66, 'Aus der Definition der Diagonalmenge und der angenommenen Surjektivität.', 'f(d)=D.', 'checked', 10),
(9, '3.157', 13, 'Kuratowski-Paar', '(a,b)={{a},{a,b}}', '(a,b)={{a},{a,b}}', 'Das geordnete Paar wird ausschließlich durch Mengen konstruiert.', 'definition', 'literature', 70, NULL, 'a und b sind beliebige mengentheoretisch darstellbare Gegenstände.', 'checked', 10),
(10, '3.158', 13, 'Kartesisches Produkt', 'A	imes B={(a,b)mid ain Aland bin B}', 'A	imes B={(a,b)mid ain Aland bin B}', 'Das kartesische Produkt enthält sämtliche geordneten Paare mit erster Komponente aus A und zweiter Komponente aus B.', 'definition', 'adapted', 71, NULL, 'A und B sind Mengen; geordnete Paare sind definiert.', 'checked', 10),
(11, '3.159', 14, 'Binäre Relation', 'R\\subseteq A\\times B', 'R\\subseteq A\\times B', 'Formale Darstellung: Binäre Relation.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(12, '3.160', 14, 'Relationsschreibweise', 'aRb \\iff (a,b)\\in R', 'aRb \\iff (a,b)\\in R', 'Formale Darstellung: Relationsschreibweise.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(13, '3.161', 14, 'Relation auf einer Menge', 'R\\subseteq M\\times M', 'R\\subseteq M\\times M', 'Formale Darstellung: Relation auf einer Menge.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(14, '3.162', 14, 'n-stellige Relation', 'R\\subseteq A_1\\times A_2\\times\\cdots\\times A_n', 'R\\subseteq A_1\\times A_2\\times\\cdots\\times A_n', 'Formale Darstellung: n-stellige Relation.', 'definition', 'adapted', 73, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(15, '3.163', 14, 'Tupelzugehörigkeit', '(a_1,a_2,\\ldots,a_n)\\in R', '(a_1,a_2,\\ldots,a_n)\\in R', 'Formale Darstellung: Tupelzugehörigkeit.', 'definition', 'adapted', 73, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(16, '3.164', 14, 'Reflexivität', '\\forall x\\in M:\\;xRx', '\\forall x\\in M:\\;xRx', 'Formale Darstellung: Reflexivität.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(17, '3.165', 14, 'Irreflexivität', '\\forall x\\in M:\\;\\neg(xRx)', '\\forall x\\in M:\\;\\neg(xRx)', 'Formale Darstellung: Irreflexivität.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(18, '3.166', 14, 'Diagonale', '\\Delta_M=\\{(x,x)\\mid x\\in M\\}', '\\Delta_M=\\{(x,x)\\mid x\\in M\\}', 'Formale Darstellung: Diagonale.', 'definition', 'adapted', 71, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(19, '3.167', 14, 'Reflexivität über die Diagonale', '\\Delta_M\\subseteq R', '\\Delta_M\\subseteq R', 'Formale Darstellung: Reflexivität über die Diagonale.', 'theorem', 'adapted', 71, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(20, '3.168', 14, 'Symmetrie', '\\forall x,y\\in M:\\;xRy\\rightarrow yRx', '\\forall x,y\\in M:\\;xRy\\rightarrow yRx', 'Formale Darstellung: Symmetrie.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(21, '3.169', 14, 'Antisymmetrie', '\\forall x,y\\in M:\\;(xRy\\land yRx)\\rightarrow x=y', '\\forall x,y\\in M:\\;(xRy\\land yRx)\\rightarrow x=y', 'Formale Darstellung: Antisymmetrie.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(22, '3.170', 14, 'Transitivität', '\\forall x,y,z\\in M:\\;(xRy\\land yRz)\\rightarrow xRz', '\\forall x,y,z\\in M:\\;(xRy\\land yRz)\\rightarrow xRz', 'Formale Darstellung: Transitivität.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(23, '3.171', 14, 'Äquivalenzrelation', '\\begin{aligned}&\\forall x\\in M:\\;x\\sim x,\\\\&\\forall x,y\\in M:\\;x\\sim y\\rightarrow y\\sim x,\\\\&\\forall x,y,z\\in M:\\;(x\\sim y\\land y\\sim z)\\rightarrow x\\sim z.\\end{aligned}', '\\begin{aligned}&\\forall x\\in M:\\;x\\sim x,\\\\&\\forall x,y\\in M:\\;x\\sim y\\rightarrow y\\sim x,\\\\&\\forall x,y,z\\in M:\\;(x\\sim y\\land y\\sim z)\\rightarrow x\\sim z.\\end{aligned}', 'Formale Darstellung: Äquivalenzrelation.', 'definition', 'adapted', 71, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(24, '3.172', 14, 'Äquivalenzklasse', '[x]_{\\sim}=\\{y\\in M\\mid y\\sim x\\}', '[x]_{\\sim}=\\{y\\in M\\mid y\\sim x\\}', 'Formale Darstellung: Äquivalenzklasse.', 'definition', 'adapted', 71, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(25, '3.173', 14, 'Quotientenmenge', 'M/{\\sim}=\\{[x]_{\\sim}\\mid x\\in M\\}', 'M/{\\sim}=\\{[x]_{\\sim}\\mid x\\in M\\}', 'Formale Darstellung: Quotientenmenge.', 'definition', 'adapted', 71, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(26, '3.174', 14, 'Von einer Partition induzierte Äquivalenz', 'x\\sim_{\\mathcal{C}}y\\iff\\exists C\\in\\mathcal{C}:\\;x\\in C\\land y\\in C', 'x\\sim_{\\mathcal{C}}y\\iff\\exists C\\in\\mathcal{C}:\\;x\\in C\\land y\\in C', 'Formale Darstellung: Von einer Partition induzierte Äquivalenz.', 'derived', 'adapted', 71, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(27, '3.175', 14, 'Partielle Ordnung', '\\begin{aligned}&\\forall x\\in M:\\;x\\preceq x,\\\\&\\forall x,y\\in M:\\;(x\\preceq y\\land y\\preceq x)\\rightarrow x=y,\\\\&\\forall x,y,z\\in M:\\;(x\\preceq y\\land y\\preceq z)\\rightarrow x\\preceq z.\\end{aligned}', '\\begin{aligned}&\\forall x\\in M:\\;x\\preceq x,\\\\&\\forall x,y\\in M:\\;(x\\preceq y\\land y\\preceq x)\\rightarrow x=y,\\\\&\\forall x,y,z\\in M:\\;(x\\preceq y\\land y\\preceq z)\\rightarrow x\\preceq z.\\end{aligned}', 'Formale Darstellung: Partielle Ordnung.', 'definition', 'adapted', 71, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(28, '3.176', 14, 'Partiell geordnete Menge', '(M,\\preceq)', '(M,\\preceq)', 'Formale Darstellung: Partiell geordnete Menge.', 'definition', 'adapted', 71, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(29, '3.177', 14, 'Totale Vergleichbarkeit', '\\forall x,y\\in M:\\;x\\preceq y\\lor y\\preceq x', '\\forall x,y\\in M:\\;x\\preceq y\\lor y\\preceq x', 'Formale Darstellung: Totale Vergleichbarkeit.', 'definition', 'adapted', 71, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(30, '3.178', 14, 'Umkehrrelation', 'R^{-1}=\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\}', 'R^{-1}=\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\}', 'Formale Darstellung: Umkehrrelation.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(31, '3.179', 14, 'Umkehrrelation in Infixnotation', 'bR^{-1}a\\iff aRb', 'bR^{-1}a\\iff aRb', 'Formale Darstellung: Umkehrrelation in Infixnotation.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(32, '3.180', 14, 'Symmetriekriterium', 'R^{-1}=R', 'R^{-1}=R', 'Formale Darstellung: Symmetriekriterium.', 'theorem', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(33, '3.181', 14, 'Relationale Komposition', 'S\\circ R=\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\;aRb\\land bSc\\}', 'S\\circ R=\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\;aRb\\land bSc\\}', 'Formale Darstellung: Relationale Komposition.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(34, '3.182', 14, 'Assoziativität der Komposition', 'T\\circ(S\\circ R)=(T\\circ S)\\circ R', 'T\\circ(S\\circ R)=(T\\circ S)\\circ R', 'Formale Darstellung: Assoziativität der Komposition.', 'theorem', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(35, '3.183', 14, 'Elementweiser Nachweis der Assoziativität', '\\begin{aligned}(a,d)\\in T\\circ(S\\circ R)&\\iff\\exists c\\in C:\\bigl((a,c)\\in S\\circ R\\land(c,d)\\in T\\bigr)\\\\&\\iff\\exists b\\in B\\;\\exists c\\in C:\\bigl((a,b)\\in R\\land(b,c)\\in S\\land(c,d)\\in T\\bigr)\\\\&\\iff\\exists b\\in B:\\bigl((a,b)\\in R\\land(b,d)\\in T\\circ S\\bigr)\\\\&\\iff(a,d)\\in(T\\circ S)\\circ R.\\end{aligned}', '\\begin{aligned}(a,d)\\in T\\circ(S\\circ R)&\\iff\\exists c\\in C:\\bigl((a,c)\\in S\\circ R\\land(c,d)\\in T\\bigr)\\\\&\\iff\\exists b\\in B\\;\\exists c\\in C:\\bigl((a,b)\\in R\\land(b,c)\\in S\\land(c,d)\\in T\\bigr)\\\\&\\iff\\exists b\\in B:\\bigl((a,b)\\in R\\land(b,d)\\in T\\circ S\\bigr)\\\\&\\iff(a,d)\\in(T\\circ S)\\circ R.\\end{aligned}', 'Formale Darstellung: Elementweiser Nachweis der Assoziativität.', 'derived', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(36, '3.184', 14, 'Nichtkommutativität im Allgemeinen', 'S\\circ R\\neq R\\circ S', 'S\\circ R\\neq R\\circ S', 'Formale Darstellung: Nichtkommutativität im Allgemeinen.', 'other', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(37, '3.185', 14, 'Erste Relationspotenz', 'R^1=R', 'R^1=R', 'Formale Darstellung: Erste Relationspotenz.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(38, '3.186', 14, 'Rekursive Relationspotenz', 'R^{n+1}=R\\circ R^n', 'R^{n+1}=R\\circ R^n', 'Formale Darstellung: Rekursive Relationspotenz.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(39, '3.187', 14, 'Transitive Hülle', 'R^{+}=\\bigcup_{n=1}^{\\infty}R^n', 'R^{+}=\\bigcup_{n=1}^{\\infty}R^n', 'Formale Darstellung: Transitive Hülle.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(40, '3.188', 14, 'Reflexiv-transitive Hülle', 'R^{*}=\\Delta_M\\cup R^{+}', 'R^{*}=\\Delta_M\\cup R^{+}', 'Formale Darstellung: Reflexiv-transitive Hülle.', 'definition', 'adapted', 75, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(41, '3.189', 14, 'Endliche Trägermengen', 'A=\\{a_1,\\ldots,a_m\\},\\qquad B=\\{b_1,\\ldots,b_n\\}', 'A=\\{a_1,\\ldots,a_m\\},\\qquad B=\\{b_1,\\ldots,b_n\\}', 'Formale Darstellung: Endliche Trägermengen.', 'schema', 'adapted', 71, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(42, '3.190', 14, 'Relationsmatrix', '\\mathbf{M}_R=(r_{ij})', '\\mathbf{M}_R=(r_{ij})', 'Formale Darstellung: Relationsmatrix.', 'definition', 'adapted', 74, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(43, '3.191', 14, 'Einträge der Relationsmatrix', 'r_{ij}=\\begin{cases}1,&(a_i,b_j)\\in R,\\\\0,&(a_i,b_j)\\notin R\\end{cases}', 'r_{ij}=\\begin{cases}1,&(a_i,b_j)\\in R,\\\\0,&(a_i,b_j)\\notin R\\end{cases}', 'Formale Darstellung: Einträge der Relationsmatrix.', 'definition', 'adapted', 74, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(44, '3.192', 14, 'Boolesche Matrixkomposition', '(\\mathbf{M}_{S\\circ R})_{ik}=\\bigvee_{j=1}^{n}\\left((\\mathbf{M}_R)_{ij}\\land(\\mathbf{M}_S)_{jk}\\right)', '(\\mathbf{M}_{S\\circ R})_{ik}=\\bigvee_{j=1}^{n}\\left((\\mathbf{M}_R)_{ij}\\land(\\mathbf{M}_S)_{jk}\\right)', 'Formale Darstellung: Boolesche Matrixkomposition.', 'derived', 'adapted', 74, NULL, 'Die in Abschnitt 3.2.1 eingeführten Mengen, kartesischen Produkte und geordneten Tupel werden vorausgesetzt.', 'checked', 11),
(45, '3.193', 15, 'Zweistellige innere Verknüpfung', 'ast:M	imes M\rightarrow M', 'ast:M	imes M\rightarrow M', 'Eine zweistellige innere Verknüpfung ordnet jedem Paar aus M×M ein Element aus M zu.', 'definition', 'adapted', 77, NULL, 'M ist eine Menge.', 'checked', 12),
(46, '3.194', 15, 'Ergebnis einer Verknüpfung', 'aast bin M', 'aast bin M', 'Das Ergebnis der Verknüpfung zweier Elemente aus M liegt wieder in M.', 'definition', 'adapted', 77, NULL, 'a und b sind Elemente von M.', 'checked', 12),
(47, '3.195', 15, 'Abgeschlossenheit', 'forall a,bin M:;aast bin M', 'forall a,bin M:;aast bin M', 'Die Verknüpfung ist auf M abgeschlossen.', 'definition', 'adapted', 77, NULL, 'Auf M ist eine zweistellige Verknüpfung definiert.', 'checked', 12),
(48, '3.196', 15, 'Assoziativität', '(aast b)ast c=aast(bast c)', '(aast b)ast c=aast(bast c)', 'Die Klammerung einer dreifachen Verknüpfung verändert das Ergebnis nicht.', 'definition', 'adapted', 77, NULL, 'a,b,c sind Elemente von M.', 'checked', 12),
(49, '3.197', 15, 'Neutrales Element', 'east a=aast e=a', 'east a=aast e=a', 'Das neutrale Element e lässt jedes Element a unverändert.', 'definition', 'adapted', 77, NULL, 'e und a sind Elemente von M.', 'checked', 12),
(50, '3.198', 15, 'Inverses Element', 'aast a^{-1}=a^{-1}ast a=e', 'aast a^{-1}=a^{-1}ast a=e', 'Das inverse Element führt bei beidseitiger Verknüpfung zum neutralen Element.', 'definition', 'adapted', 77, NULL, 'e ist das neutrale Element.', 'checked', 12),
(51, '3.199', 15, 'Gruppe als geordnetes Paar', '(M,ast)', '(M,ast)', 'Eine Gruppe wird als Menge zusammen mit ihrer Verknüpfung dargestellt.', 'definition', 'adapted', 77, NULL, 'Die Gruppenaxiome sind erfüllt.', 'checked', 12),
(52, '3.200', 15, 'Kommutativität', 'aast b=bast a', 'aast b=bast a', 'Die Reihenfolge der verknüpften Elemente verändert das Ergebnis nicht.', 'definition', 'adapted', 77, NULL, 'a und b sind Elemente einer abelschen Gruppe.', 'checked', 12),
(53, '3.201', 15, 'Distributivgesetz', 'acdot(b+c)=acdot b+acdot c', 'acdot(b+c)=acdot b+acdot c', 'Die Multiplikation verteilt sich über die Addition.', 'axiom', 'adapted', 77, NULL, 'a,b,c sind Elemente eines Rings.', 'checked', 12),
(54, '3.202', 15, 'Multiplikatives Inverses im Körper', 'acdot a^{-1}=1', 'acdot a^{-1}=1', 'Jedes von Null verschiedene Körperelement besitzt ein multiplikatives Inverses.', 'axiom', 'adapted', 77, NULL, 'a ist von Null verschieden.', 'checked', 12),
(55, '3.203', 16, 'Graph als geordnetes Paar', 'G=(V,E)', 'G=(V,E)', 'Graph aus Knoten- und Kantenmenge.', 'definition', 'adapted', 80, NULL, 'V und E sind Mengen.', 'checked', 13),
(56, '3.204', 16, 'Kantenmenge eines einfachen ungerichteten Graphen', 'E\\subseteq\\left\\{\\{u,v\\}\\mid u,v\\in V,\\;u\\neq v\\right\\}', 'E\\subseteq\\left\\{\\{u,v\\}\\mid u,v\\in V,\\;u\\neq v\\right\\}', 'Ungerichtete Kanten als zweielementige Teilmengen.', 'definition', 'adapted', 80, NULL, 'Graph ist einfach und ungerichtet.', 'checked', 13),
(57, '3.205', 16, 'Gerichteter Graph', 'G=(V,E)', 'G=(V,E)', 'Gerichteter Graph als Paar.', 'definition', 'adapted', 80, NULL, 'E enthält geordnete Paare.', 'checked', 13),
(58, '3.206', 16, 'Kantenmenge eines gerichteten Graphen', 'E\\subseteq V\\times V', 'E\\subseteq V\\times V', 'Gerichtete Kanten sind geordnete Knotenpaare.', 'definition', 'adapted', 80, NULL, 'V ist die Knotenmenge.', 'checked', 13),
(59, '3.207', 16, 'Gerichtete Kante', '(u,v)\\in E', '(u,v)\\in E', 'Kante von u nach v.', 'definition', 'adapted', 80, NULL, 'u,v∈V.', 'checked', 13),
(60, '3.208', 16, 'Fehlende Umkehrkante', '(v,u)\\notin E', '(v,u)\\notin E', 'Keine notwendige Gegenkante.', '', 'adapted', 75, NULL, 'Graph ist nicht symmetrisch.', 'checked', 13),
(61, '3.209', 16, 'Grad eines Knotens', '\\deg(v)=\\left|\\left\\{u\\in V\\mid\\{u,v\\}\\in E\\right\\}\\right|', '\\deg(v)=\\left|\\left\\{u\\in V\\mid\\{u,v\\}\\in E\\right\\}\\right|', 'Anzahl unmittelbarer Nachbarn.', 'definition', 'adapted', 80, NULL, 'G ist ungerichtet.', 'checked', 13),
(62, '3.210', 16, 'Eingangsgrad', '\\deg^{-}(v)=\\left|\\left\\{u\\in V\\mid(u,v)\\in E\\right\\}\\right|', '\\deg^{-}(v)=\\left|\\left\\{u\\in V\\mid(u,v)\\in E\\right\\}\\right|', 'Zahl eingehender Kanten.', 'definition', 'adapted', 80, NULL, 'G ist gerichtet.', 'checked', 13),
(63, '3.211', 16, 'Ausgangsgrad', '\\deg^{+}(v)=\\left|\\left\\{w\\in V\\mid(v,w)\\in E\\right\\}\\right|', '\\deg^{+}(v)=\\left|\\left\\{w\\in V\\mid(v,w)\\in E\\right\\}\\right|', 'Zahl ausgehender Kanten.', 'definition', 'adapted', 80, NULL, 'G ist gerichtet.', 'checked', 13),
(64, '3.212', 16, 'Handschlaglemma', '\\sum_{v\\in V}\\deg(v)=2|E|', '\\sum_{v\\in V}\\deg(v)=2|E|', 'Summe der Grade ist doppelte Kantenzahl.', 'theorem', 'literature', 80, 'Jede Kante wird zweimal gezählt.', 'G ist endlich und ungerichtet.', 'checked', 13),
(65, '3.213', 16, 'Geordnete endliche Knotenmenge', 'V=\\{v_1,v_2,\\ldots,v_n\\}', 'V=\\{v_1,v_2,\\ldots,v_n\\}', 'Endliche geordnete Knotenmenge.', 'schema', 'adapted', 71, NULL, 'V ist endlich.', 'checked', 13),
(66, '3.214', 16, 'Adjazenzmatrix', '\\mathbf{A}_G=(a_{ij})\\in\\{0,1\\}^{n\\times n}', '\\mathbf{A}_G=(a_{ij})\\in\\{0,1\\}^{n\\times n}', 'Binäre Matrixdarstellung.', 'definition', 'adapted', 81, NULL, 'V besitzt n Knoten.', 'checked', 13),
(67, '3.215', 16, 'Einträge der Adjazenzmatrix', 'a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&(v_i,v_j)\\notin E.\\end{cases}', 'a_{ij}=\\begin{cases}1,&(v_i,v_j)\\in E,\\\\0,&(v_i,v_j)\\notin E.\\end{cases}', 'Binäre Kantenkodierung.', 'definition', 'adapted', 81, NULL, 'G ist endlich.', 'checked', 13),
(68, '3.216', 16, 'Symmetrie der Adjazenzmatrix', '\\mathbf{A}_G^{\\mathsf T}=\\mathbf{A}_G', '\\mathbf{A}_G^{\\mathsf T}=\\mathbf{A}_G', 'Symmetrische Matrix bei ungerichtetem Graphen.', 'theorem', 'adapted', 81, NULL, 'G ist ungerichtet.', 'checked', 13),
(69, '3.217', 16, 'Potenz der Adjazenzmatrix', '\\left(\\mathbf{A}_G^k\\right)_{ij}', '\\left(\\mathbf{A}_G^k\\right)_{ij}', 'Zahl der Kantenzüge der Länge k.', 'derived', 'adapted', 81, 'Matrixmultiplikation über natürlichen Zahlen.', 'k>0.', 'checked', 13),
(70, '3.218', 16, 'Kantenzug', 'W=(v_0,v_1,\\ldots,v_k)', 'W=(v_0,v_1,\\ldots,v_k)', 'Folge benachbarter Knoten.', 'definition', 'adapted', 80, NULL, 'Kantenfolge ist zulässig.', 'checked', 13),
(71, '3.219', 16, 'Kantenbedingung eines Kantenzugs', '(v_{i-1},v_i)\\in E\\qquad\\text{für alle }i\\in\\{1,\\ldots,k\\}', '(v_{i-1},v_i)\\in E\\qquad\\text{für alle }i\\in\\{1,\\ldots,k\\}', 'Benachbarungsbedingung.', 'definition', 'adapted', 80, NULL, 'Orientierung wird beachtet.', 'checked', 13),
(72, '3.220', 16, 'Zusammenhang', '\\forall u,v\\in V\\;\\exists P_{uv}', '\\forall u,v\\in V\\;\\exists P_{uv}', 'Pfad zwischen je zwei Knoten.', 'definition', 'adapted', 80, NULL, 'G ist ungerichtet.', 'checked', 13),
(73, '3.221', 16, 'Starker Zusammenhang', '\\forall u,v\\in V:\\;u\\leadsto v', '\\forall u,v\\in V:\\;u\\leadsto v', 'Jeder Knoten ist von jedem anderen erreichbar.', 'definition', 'adapted', 80, NULL, 'G ist gerichtet.', 'checked', 13),
(74, '3.222', 16, 'Graphendistanz', 'd_G(u,v)=\\min\\left\\{\\ell(P)\\mid P\\text{ ist ein Pfad von }u\\text{ nach }v\\right\\}', 'd_G(u,v)=\\min\\left\\{\\ell(P)\\mid P\\text{ ist ein Pfad von }u\\text{ nach }v\\right\\}', 'Länge eines kürzesten Pfades.', 'definition', 'adapted', 80, NULL, 'Pfad existiert.', 'checked', 13),
(75, '3.223', 16, 'Zyklus', 'C=(v_0,v_1,\\ldots,v_{k-1},v_0)', 'C=(v_0,v_1,\\ldots,v_{k-1},v_0)', 'Geschlossener Pfad.', 'definition', 'adapted', 80, NULL, 'Innere Knoten sind verschieden.', 'checked', 13),
(76, '3.224', 16, 'Kantenanzahl eines endlichen Baumes', '|E|=|V|-1', '|E|=|V|-1', 'Kanten-Knoten-Beziehung eines Baumes.', 'theorem', 'literature', 80, NULL, 'T ist ein endlicher Baum.', 'checked', 13),
(77, '3.225', 16, 'Gewichteter Graph', 'G=(V,E,w)', 'G=(V,E,w)', 'Graph mit Gewichtsfunktion.', 'definition', 'adapted', 81, NULL, 'G ist ein Graph.', 'checked', 13),
(78, '3.226', 16, 'Gewichtsfunktion', 'w:E\\rightarrow\\mathbb{R}', 'w:E\\rightarrow\\mathbb{R}', 'Reelles Gewicht je Kante.', 'definition', 'adapted', 81, NULL, 'E ist die Kantenmenge.', 'checked', 13),
(79, '3.227', 16, 'Gewichtete Pfadlänge', 'L_w(P)=\\sum_{e\\in P}w(e)', 'L_w(P)=\\sum_{e\\in P}w(e)', 'Summe der Kantengewichte.', 'definition', 'adapted', 81, NULL, 'P ist ein Pfad.', 'checked', 13),
(80, '3.228', 16, 'Gewichtete Distanz', 'd_w(u,v)=\\min_{P:u\\leadsto v}L_w(P)', 'd_w(u,v)=\\min_{P:u\\leadsto v}L_w(P)', 'Minimale gewichtete Pfadlänge.', 'definition', 'adapted', 81, NULL, 'Pfad existiert.', 'checked', 13),
(81, '3.229', 16, 'Gradverteilung', 'P(k)=\\frac{\\left|\\left\\{v\\in V\\mid\\deg(v)=k\\right\\}\\right|}{|V|}', 'P(k)=\\frac{\\left|\\left\\{v\\in V\\mid\\deg(v)=k\\right\\}\\right|}{|V|}', 'Anteil der Knoten mit Grad k.', 'definition', 'adapted', 82, NULL, 'V ist endlich.', 'checked', 13),
(82, '3.230', 16, 'Lokaler Clusterkoeffizient', 'C(v)=\\frac{2e_v}{k_v(k_v-1)}', 'C(v)=\\frac{2e_v}{k_v(k_v-1)}', 'Lokale Nachbarschaftsverdichtung.', 'definition', 'adapted', 81, NULL, 'k_v>=2.', 'checked', 13),
(83, '3.231', 16, 'Normierte Gradzentralität', 'C_D(v)=\\frac{\\deg(v)}{|V|-1}', 'C_D(v)=\\frac{\\deg(v)}{|V|-1}', 'Normierter Knotengrad.', 'definition', 'adapted', 81, NULL, '|V|>1.', 'checked', 13),
(84, '3.232', 17, 'Funktion zwischen zwei Mengen', 'f:A\rightarrow B', 'f:A\rightarrow B', 'Die Funktion f bildet Elemente aus A in den Zielbereich B ab.', 'definition', 'adapted', 71, NULL, 'A und B sind Mengen.', 'checked', 14),
(85, '3.233', 17, 'Funktion als Relation', 'fsubseteq A	imes B', 'fsubseteq A	imes B', 'Eine Funktion ist eine Teilmenge des kartesischen Produkts.', 'definition', 'adapted', 71, NULL, 'A und B sind Mengen.', 'checked', 14),
(86, '3.234', 17, 'Eindeutigkeitsbedingung', 'forall ain A;exists!,bin B:(a,b)in f', 'forall ain A;exists!,bin B:(a,b)in f', 'Jedem Element aus A wird genau ein Element aus B zugeordnet.', 'definition', 'adapted', 71, NULL, 'f ist eine funktionale Relation.', 'checked', 14),
(87, '3.235', 17, 'Bildmenge', 'f(A)={f(a)mid ain A}', 'f(A)={f(a)mid ain A}', 'Die Bildmenge enthält alle tatsächlich angenommenen Funktionswerte.', 'definition', 'adapted', 71, NULL, 'f:A→B ist eine Funktion.', 'checked', 14),
(88, '3.236', 17, 'Bildmenge als Teilmenge', 'f(A)subseteq B', 'f(A)subseteq B', 'Die Bildmenge liegt innerhalb des Zielbereichs.', 'definition', 'adapted', 71, NULL, 'f:A→B ist eine Funktion.', 'checked', 14),
(89, '3.237', 17, 'Injektivität', 'f(a_1)=f(a_2)Longrightarrow a_1=a_2', 'f(a_1)=f(a_2)Longrightarrow a_1=a_2', 'Gleiche Bilder setzen bei einer injektiven Funktion gleiche Argumente voraus.', 'definition', 'adapted', 71, NULL, 'a_1,a_2∈A.', 'checked', 14),
(90, '3.238', 17, 'Surjektivität', 'forall bin B;exists ain A:f(a)=b', 'forall bin B;exists ain A:f(a)=b', 'Jedes Element des Zielbereichs wird von mindestens einem Argument getroffen.', 'definition', 'adapted', 71, NULL, 'f:A→B ist eine Funktion.', 'checked', 14),
(91, '3.239', 17, 'Umkehrfunktion', 'f^{-1}:B\rightarrow A', 'f^{-1}:B\rightarrow A', 'Die Umkehrfunktion bildet Zielwerte auf ihre eindeutigen Urbilder ab.', 'definition', 'adapted', 71, NULL, 'f ist bijektiv.', 'checked', 14),
(92, '3.240', 17, 'Linke Umkehridentität', 'f^{-1}(f(a))=a', 'f^{-1}(f(a))=a', 'Die Umkehrfunktion hebt die Wirkung von f auf Elementen aus A auf.', 'theorem', 'adapted', 71, NULL, 'f ist bijektiv und a∈A.', 'checked', 14),
(93, '3.241', 17, 'Rechte Umkehridentität', 'f(f^{-1}(b))=b', 'f(f^{-1}(b))=b', 'Die Funktion hebt die Wirkung ihrer Umkehrfunktion auf Elementen aus B auf.', 'theorem', 'adapted', 71, NULL, 'f ist bijektiv und b∈B.', 'checked', 14),
(94, '3.242', 17, 'Komposition zweier Funktionen', 'gcirc f:A\rightarrow C', 'gcirc f:A\rightarrow C', 'Die Komposition bildet A über B nach C ab.', 'definition', 'adapted', 71, NULL, 'f:A→B und g:B→C.', 'checked', 14),
(95, '3.243', 17, 'Auswertung einer Funktionskomposition', '(gcirc f)(a)=g(f(a))', '(gcirc f)(a)=g(f(a))', 'Zuerst wird f und anschließend g ausgewertet.', 'definition', 'adapted', 71, NULL, 'a∈A.', 'checked', 14),
(96, '3.244', 17, 'Assoziativität der Funktionskomposition', 'hcirc(gcirc f)=(hcirc g)circ f', 'hcirc(gcirc f)=(hcirc g)circ f', 'Die Klammerung kompatibler Funktionskompositionen verändert das Ergebnis nicht.', 'theorem', 'literature', 71, 'Beide Seiten liefern für jedes a∈A den Wert h(g(f(a))).', 'f:A→B, g:B→C und h:C→D.', 'checked', 14),
(97, '3.245', 17, 'Identitätsabbildung', 'operatorname{id}_A(a)=a', 'operatorname{id}_A(a)=a', 'Die Identitätsabbildung lässt jedes Element unverändert.', 'definition', 'adapted', 71, NULL, 'a∈A.', 'checked', 14),
(98, '3.246', 17, 'Neutralität der Identitätsabbildung', 'fcircoperatorname{id}_A=f=operatorname{id}_Bcirc f', 'fcircoperatorname{id}_A=f=operatorname{id}_Bcirc f', 'Die Identität ist das neutrale Element der Funktionskomposition.', 'theorem', 'adapted', 71, NULL, 'f:A→B ist eine Funktion.', 'checked', 14),
(137, '3.247', 18, 'Vektoraddition', '+:V	imes V\rightarrow V', '+:V	imes V\rightarrow V', 'Die Vektoraddition ordnet zwei Vektoren einen Vektor desselben Raumes zu.', 'definition', 'adapted', 93, NULL, 'V ist die Trägermenge des Vektorraums.', 'checked', 17),
(138, '3.248', 18, 'Skalarmultiplikation', 'cdot:K	imes V\rightarrow V', 'cdot:K	imes V\rightarrow V', 'Die Skalarmultiplikation ordnet einem Skalar und einem Vektor einen Vektor zu.', 'definition', 'adapted', 93, NULL, 'K ist ein Körper und V ein Vektorraum über K.', 'checked', 17),
(139, '3.249', 18, 'Assoziativität der Vektoraddition', '(u+v)+w=u+(v+w)', '(u+v)+w=u+(v+w)', 'Die Klammerung dreier Vektoradditionen verändert das Ergebnis nicht.', 'axiom', 'adapted', 93, NULL, 'u,v,w∈V.', 'checked', 17),
(140, '3.250', 18, 'Kommutativität der Vektoraddition', 'u+v=v+u', 'u+v=v+u', 'Die Reihenfolge der Summanden verändert die Vektorsumme nicht.', 'axiom', 'adapted', 93, NULL, 'u,v∈V.', 'checked', 17),
(141, '3.251', 18, 'Neutrales Element der Vektoraddition', 'v+0=v', 'v+0=v', 'Die Addition des Nullvektors lässt einen Vektor unverändert.', 'axiom', 'adapted', 93, NULL, 'v∈V und 0 ist der Nullvektor.', 'checked', 17),
(142, '3.252', 18, 'Additives Inverses', 'v+(-v)=0', 'v+(-v)=0', 'Ein Vektor und sein additives Inverses ergeben den Nullvektor.', 'axiom', 'adapted', 93, NULL, 'v∈V.', 'checked', 17),
(143, '3.253', 18, 'Distributivität über der Vektoraddition', 'lambda(u+v)=lambda u+lambda v', 'lambda(u+v)=lambda u+lambda v', 'Die Skalarmultiplikation verteilt sich über die Vektoraddition.', 'axiom', 'adapted', 93, NULL, 'λ∈K und u,v∈V.', 'checked', 17),
(144, '3.254', 18, 'Distributivität über der Skalaraddition', '(lambda+mu)v=lambda v+mu v', '(lambda+mu)v=lambda v+mu v', 'Die Multiplikation einer Skalarsumme mit einem Vektor verteilt sich auf die Summanden.', 'axiom', 'adapted', 93, NULL, 'λ,μ∈K und v∈V.', 'checked', 17),
(145, '3.255', 18, 'Verträglichkeit der Skalarmultiplikation', '(lambdamu)v=lambda(mu v)', '(lambdamu)v=lambda(mu v)', 'Die skalare Multiplikation ist mit der Körpermultiplikation verträglich.', 'axiom', 'adapted', 93, NULL, 'λ,μ∈K und v∈V.', 'checked', 17),
(146, '3.256', 18, 'Einheitswirkung', '1v=v', '1v=v', 'Das multiplikative Einselement des Körpers lässt jeden Vektor unverändert.', 'axiom', 'adapted', 93, NULL, '1 ist das Einselement von K und v∈V.', 'checked', 17),
(147, '3.257', 18, 'Eindeutigkeit des Nullvektors', '0_1=0_1+0_2=0_2', '0_1=0_1+0_2=0_2', 'Zwei angenommene neutrale Elemente müssen identisch sein.', '', 'adapted', 93, 'Verwendung der Neutralität von 0_1 und 0_2.', '0_1 und 0_2 sind additive neutrale Elemente.', 'checked', 17),
(148, '3.258', 18, 'Eindeutigkeit des additiven Inversen', 'x=x+0=x+(v+y)=(x+v)+y=0+y=y', 'x=x+0=x+(v+y)=(x+v)+y=0+y=y', 'Zwei additive Inverse desselben Vektors sind identisch.', '', 'adapted', 93, 'Verwendung von Neutralität, Assoziativität und der Inverseneigenschaft.', 'x und y sind additive Inverse von v.', 'checked', 17),
(149, '3.259', 18, 'Multiplikation eines Vektors mit dem Nullskalar', '0v=0', '0v=0', 'Die Multiplikation eines Vektors mit dem Nullskalar ergibt den Nullvektor.', '', 'adapted', 93, 'Aus 0v=(0+0)v=0v+0v folgt durch Addition des inversen Vektors 0v=0.', 'v∈V.', 'checked', 17),
(150, '3.260', 18, 'Multiplikation mit minus eins', '(-1)v=-v', '(-1)v=-v', 'Die Multiplikation mit minus eins ergibt das additive Inverse.', '', 'adapted', 93, 'Aus v+(-1)v=(1+(-1))v=0v=0 folgt die Behauptung.', 'v∈V.', 'checked', 17),
(151, '3.261', 18, 'Allgemeine Linearkombination', 'sum_{i=1}^{n}lambda_i v_i', 'sum_{i=1}^{n}lambda_i v_i', 'Eine endliche Summe skalarer Vielfacher von Vektoren.', 'definition', 'adapted', 93, NULL, 'λ_i∈K und v_i∈V.', 'checked', 17),
(152, '3.262', 18, 'Linearer Spann', 'operatorname{span}(M)=left{sum_{i=1}^{n}lambda_i v_imid v_iin M\right}', 'operatorname{span}(M)=left{sum_{i=1}^{n}lambda_i v_imid v_iin M\right}', 'Der Spann enthält alle endlichen Linearkombinationen von Vektoren aus M.', 'definition', 'adapted', 93, NULL, 'M⊆V.', 'checked', 17),
(153, '3.263', 18, 'Kriterium linearer Unabhängigkeit', 'sum_{i=1}^{n}lambda_i v_i=0Longrightarrowlambda_i=0quad(i=1,ldots,n)', 'sum_{i=1}^{n}lambda_i v_i=0Longrightarrowlambda_i=0quad(i=1,ldots,n)', 'Nur die triviale Koeffizientenwahl erzeugt den Nullvektor.', 'definition', 'adapted', 93, NULL, 'v_1,…,v_n∈V.', 'checked', 17),
(154, '3.264', 18, 'Basisdarstellung eines Vektors', 'v=sum_{i=1}^{n}lambda_i e_i', 'v=sum_{i=1}^{n}lambda_i e_i', 'Jeder Vektor besitzt bezüglich einer Basis eine eindeutige Koordinatendarstellung.', 'definition', 'adapted', 93, NULL, 'e_1,…,e_n bilden eine Basis von V.', 'checked', 17),
(155, '3.265', 18, 'Dimension eines Vektorraums', 'dim(V)=n', 'dim(V)=n', 'Die Dimension entspricht der Anzahl der Elemente einer endlichen Basis.', 'definition', 'adapted', 93, NULL, 'V ist endlichdimensional.', 'checked', 17),
(156, '3.266', 19, 'Abbildung zwischen Vektorräumen', 'T:V\rightarrow W', 'T:V\rightarrow W', 'Eine Abbildung vom Vektorraum V in den Vektorraum W.', 'definition', 'adapted', 96, NULL, 'V und W sind Vektorräume über demselben Körper.', 'checked', 18),
(157, '3.267', 19, 'Additivität', 'T(u+v)=T(u)+T(v)', 'T(u+v)=T(u)+T(v)', 'Eine lineare Abbildung erhält die Vektoraddition.', 'axiom', 'adapted', 96, NULL, 'u,v∈V.', 'checked', 18),
(158, '3.268', 19, 'Homogenität', 'T(lambda v)=lambda T(v)', 'T(lambda v)=lambda T(v)', 'Eine lineare Abbildung erhält die Skalarmultiplikation.', 'axiom', 'adapted', 96, NULL, 'λ∈K und v∈V.', 'checked', 18),
(159, '3.269', 19, 'Erhaltung von Linearkombinationen', 'T(lambda u+mu v)=lambda T(u)+mu T(v)', 'T(lambda u+mu v)=lambda T(u)+mu T(v)', 'Zusammenfassung von Additivität und Homogenität.', '', 'adapted', 96, 'Folgt durch Anwendung von Additivität und Homogenität.', 'λ,μ∈K und u,v∈V.', 'checked', 18),
(160, '3.270', 19, 'Erhaltung des Nullvektors', 'T(0_V)=0_W', 'T(0_V)=0_W', 'Der Nullvektor des Ausgangsraums wird auf den Nullvektor des Zielraums abgebildet.', 'theorem', 'adapted', 96, NULL, 'T ist linear.', 'checked', 18),
(161, '3.271', 19, 'Beweiskette zur Nullvektorerhaltung', 'T(0_V)=T(0_Kv)=0_KT(v)=0_W', 'T(0_V)=T(0_Kv)=0_KT(v)=0_W', 'Beweiskette unter Verwendung der Homogenität.', '', 'adapted', 96, 'Es gilt 0_V=0_Kv.', 'v∈V.', 'checked', 18),
(162, '3.272', 19, 'Kern einer linearen Abbildung', 'ker(T)=left{vin Vmid T(v)=0_W\right}', 'ker(T)=left{vin Vmid T(v)=0_W\right}', 'Menge aller Vektoren, die auf den Nullvektor abgebildet werden.', 'definition', 'adapted', 96, NULL, 'T:V→W ist linear.', 'checked', 18),
(163, '3.273', 19, 'Bild einer linearen Abbildung', 'operatorname{im}(T)=left{T(v)mid vin V\right}', 'operatorname{im}(T)=left{T(v)mid vin V\right}', 'Menge aller durch T erreichbaren Zielvektoren.', 'definition', 'adapted', 96, NULL, 'T:V→W ist linear.', 'checked', 18),
(164, '3.274', 19, 'Kern als Untervektorraum', 'ker(T)leq V', 'ker(T)leq V', 'Der Kern ist ein Untervektorraum des Ausgangsraums.', 'theorem', 'adapted', 96, NULL, 'T:V→W ist linear.', 'checked', 18),
(165, '3.275', 19, 'Bild als Untervektorraum', 'operatorname{im}(T)leq W', 'operatorname{im}(T)leq W', 'Das Bild ist ein Untervektorraum des Zielraums.', 'theorem', 'adapted', 96, NULL, 'T:V→W ist linear.', 'checked', 18),
(166, '3.276', 19, 'Abgeschlossenheit des Kerns', 'T(lambda u+mu v)=lambda T(u)+mu T(v)=0_W', 'T(lambda u+mu v)=lambda T(u)+mu T(v)=0_W', 'Jede Linearkombination zweier Kernelemente liegt erneut im Kern.', '', 'adapted', 96, NULL, 'u,v∈ker(T).', 'checked', 18),
(167, '3.277', 19, 'Abgeschlossenheit des Bildes', 'lambda x+mu y=lambda T(u)+mu T(v)=T(lambda u+mu v)', 'lambda x+mu y=lambda T(u)+mu T(v)=T(lambda u+mu v)', 'Jede Linearkombination zweier Bildelemente liegt erneut im Bild.', '', 'adapted', 96, NULL, 'x=T(u), y=T(v).', 'checked', 18),
(168, '3.278', 19, 'Rang', 'operatorname{rang}(T)=dimigl(operatorname{im}(T)igr)', 'operatorname{rang}(T)=dimigl(operatorname{im}(T)igr)', 'Der Rang ist die Dimension des Bildes.', 'definition', 'adapted', 96, NULL, 'Das Bild ist endlichdimensional.', 'checked', 18),
(169, '3.279', 19, 'Nullität', 'operatorname{null}(T)=dimigl(ker(T)igr)', 'operatorname{null}(T)=dimigl(ker(T)igr)', 'Die Nullität ist die Dimension des Kerns.', 'definition', 'adapted', 96, NULL, 'Der Kern ist endlichdimensional.', 'checked', 18),
(170, '3.280', 19, 'Dimensionssatz', 'dim(V)=operatorname{rang}(T)+operatorname{null}(T)', 'dim(V)=operatorname{rang}(T)+operatorname{null}(T)', 'Zerlegung der Dimension des Ausgangsraums in Rang und Nullität.', 'theorem', 'adapted', 96, NULL, 'V ist endlichdimensional.', 'checked', 18),
(171, '3.281', 19, 'Bild eines Basisvektors', 'T(e_j)=sum_{i=1}^{m}a_{ij}f_i', 'T(e_j)=sum_{i=1}^{m}a_{ij}f_i', 'Darstellung des Bildes eines Basisvektors bezüglich der Zielbasis.', 'definition', 'adapted', 96, NULL, 'B=(e_1,…,e_n), C=(f_1,…,f_m).', 'checked', 18),
(172, '3.282', 19, 'Darstellungsmatrix', '[T]_{Cleftarrow B}=egin{pmatrix}a_{11}&cdots&a_{1n}\\vdots&ddots&vdots\\a_{m1}&cdots&a_{mn}end{pmatrix}', '[T]_{Cleftarrow B}=egin{pmatrix}a_{11}&cdots&a_{1n}\\vdots&ddots&vdots\\a_{m1}&cdots&a_{mn}end{pmatrix}', 'Matrixdarstellung der linearen Abbildung bezüglich der Basen B und C.', 'definition', 'adapted', 96, NULL, 'Die Spalten enthalten die Koordinaten der Bilder der Basisvektoren.', 'checked', 18),
(173, '3.283', 19, 'Koordinatenwirkung der Darstellungsmatrix', '[T(v)]_C=[T]_{Cleftarrow B}[v]_B', '[T(v)]_C=[T]_{Cleftarrow B}[v]_B', 'Die Wirkung der linearen Abbildung wird in Koordinaten durch Matrixmultiplikation dargestellt.', '', 'adapted', 96, NULL, 'B und C sind fest gewählte Basen.', 'checked', 18),
(174, '3.284', 19, 'Linearer Operator', 'T:V\rightarrow V', 'T:V\rightarrow V', 'Ein linearer Operator bildet einen Vektorraum in sich selbst ab.', 'definition', 'adapted', 96, NULL, 'V ist ein Vektorraum.', 'checked', 18),
(175, '3.285', 19, 'Komposition linearer Abbildungen', 'Scirc T:V\rightarrow X', 'Scirc T:V\rightarrow X', 'Die Hintereinanderausführung zweier linearer Abbildungen ist wieder linear.', 'definition', 'adapted', 96, NULL, 'T:V→W und S:W→X.', 'checked', 18),
(176, '3.286', 19, 'Matrix der Komposition', '[Scirc T]=[S][T]', '[Scirc T]=[S][T]', 'Die Matrix der Komposition ist das Produkt der Darstellungsmatrizen.', '', 'adapted', 96, NULL, 'Kompatible Basen und Matrixdimensionen.', 'checked', 18),
(177, '3.287', 19, 'Nichtkommutativität der Operatorreihenfolge', 'Scirc T\neq Tcirc S', 'Scirc T\neq Tcirc S', 'Die Reihenfolge zweier Transformationen ist im Allgemeinen relevant.', '', 'adapted', 96, NULL, 'Beide Kompositionen sind definiert.', 'checked', 18),
(178, '3.288', 19, 'Invertierbarer Operator', 'T^{-1}circ T=Tcirc T^{-1}=operatorname{id}_V', 'T^{-1}circ T=Tcirc T^{-1}=operatorname{id}_V', 'Definition eines beidseitig invertierbaren linearen Operators.', 'definition', 'adapted', 96, NULL, 'T und T^{-1} sind lineare Operatoren auf V.', 'checked', 18),
(179, '3.289', 19, 'Invertierbarkeit', 'T	ext{ ist invertierbar}', 'T	ext{ ist invertierbar}', 'Erste Bedingung der Äquivalenzcharakterisierung.', 'theorem', 'adapted', 96, NULL, 'T:V→V, V endlichdimensional.', 'checked', 18),
(180, '3.290', 19, 'Trivialer Kern', 'ker(T)={0}', 'ker(T)={0}', 'Zweite Bedingung der Äquivalenzcharakterisierung.', 'theorem', 'adapted', 96, NULL, 'T:V→V, V endlichdimensional.', 'checked', 18),
(181, '3.291', 19, 'Volles Bild', 'operatorname{im}(T)=V', 'operatorname{im}(T)=V', 'Dritte Bedingung der Äquivalenzcharakterisierung.', 'theorem', 'adapted', 96, NULL, 'T:V→V, V endlichdimensional.', 'checked', 18),
(182, '3.292', 19, 'Voller Rang', 'operatorname{rang}(T)=dim(V)', 'operatorname{rang}(T)=dim(V)', 'Vierte Bedingung der Äquivalenzcharakterisierung.', 'theorem', 'adapted', 96, NULL, 'T:V→V, V endlichdimensional.', 'checked', 18);

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

--
-- Daten für Tabelle `equation_symbols`
--

INSERT INTO `equation_symbols` (`equation_symbol_id`, `equation_id`, `symbol_latex`, `symbol_name`, `definition_text`, `unit_text`, `domain_text`, `symbol_order`) VALUES
(1, 1, 'x', 'Element x', 'Möglicher Gegenstand der Elementbeziehung.', NULL, 'Beliebiges mengentheoretisches Objekt', 1),
(2, 1, 'M', 'Menge M', 'Mengentheoretischer Träger.', NULL, 'Menge', 2),
(3, 1, 'in', 'Elementrelation', 'Bezeichnet die Zugehörigkeit eines Elements zu einer Menge.', NULL, 'Binäre Relation', 3),
(4, 2, 'x', 'Element x', 'Möglicher Gegenstand der negierten Elementbeziehung.', NULL, 'Beliebiges mengentheoretisches Objekt', 1),
(5, 2, 'M', 'Menge M', 'Mengentheoretischer Träger.', NULL, 'Menge', 2),
(6, 2, '\notin', 'Negierte Elementrelation', 'Bezeichnet die Nichtzugehörigkeit eines Gegenstands zu einer Menge.', NULL, 'Negierte binäre Relation', 3),
(7, 3, 'A', 'Menge A', 'Erste der auf Gleichheit geprüften Mengen.', NULL, 'Menge', 1),
(8, 3, 'B', 'Menge B', 'Zweite der auf Gleichheit geprüften Mengen.', NULL, 'Menge', 2),
(9, 3, 'x', 'Elementvariable', 'Beliebiges Element, über das quantifiziert wird.', NULL, 'Beliebiges mengentheoretisches Objekt', 3),
(10, 4, 'A', 'Teilmenge A', 'Menge, deren Elemente auf Zugehörigkeit zu B geprüft werden.', NULL, 'Menge', 1),
(11, 4, 'B', 'Obermenge B', 'Menge, die alle Elemente von A enthält.', NULL, 'Menge', 2),
(12, 4, 'subseteq', 'Teilmengenrelation', 'Bezeichnet die inklusive Teilmengenbeziehung.', NULL, 'Binäre Relation auf Mengen', 3),
(13, 5, 'mathcal{P}(M)', 'Potenzmenge von M', 'Menge sämtlicher Teilmengen von M.', NULL, 'Menge von Mengen', 1),
(14, 5, 'A', 'Teilmenge A', 'Beliebige Teilmenge der Ausgangsmenge M.', NULL, 'Teilmenge von M', 2),
(15, 6, '|M|', 'Mächtigkeit von M', 'Kardinalität der Ausgangsmenge M.', NULL, 'Kardinalzahl', 1),
(16, 6, '|mathcal{P}(M)|', 'Mächtigkeit der Potenzmenge', 'Kardinalität der Potenzmenge von M.', NULL, 'Kardinalzahl', 2),
(17, 7, 'D', 'Diagonalmenge', 'Menge der Elemente, die nicht in ihrem jeweiligen Bild unter f enthalten sind.', NULL, 'Teilmenge von M', 1),
(18, 7, 'f', 'Abbildung f', 'Im Widerspruchsbeweis angenommene Abbildung von M nach P(M).', NULL, 'Abbildung M nach P(M)', 2),
(19, 8, 'd', 'Diagonalmenge', 'Im Beweis konstruierte Teilmenge von M.', NULL, 'Teilmenge von M', 2),
(20, 9, '(a,b)', 'Geordnetes Paar', 'Geordnetes Paar mit erster Komponente a und zweiter Komponente b.', NULL, 'Mengentheoretisch konstruiertes Paar', 1),
(21, 9, 'a', 'Erste Komponente', 'Erstes Element des geordneten Paares.', NULL, 'Beliebiges mengentheoretisches Objekt', 2),
(22, 9, 'b', 'Zweite Komponente', 'Zweites Element des geordneten Paares.', NULL, 'Beliebiges mengentheoretisches Objekt', 3),
(23, 10, 'A	imes B', 'Kartesisches Produkt', 'Menge sämtlicher geordneter Paare aus A und B.', NULL, 'Menge geordneter Paare', 1),
(24, 10, '(a,b)', 'Geordnetes Paar', 'Paar mit a aus A und b aus B.', NULL, 'Element von A×B', 2),
(26, 11, 'R', 'Relation R', 'Ausgewählte Teilmenge eines kartesischen Produkts.', NULL, 'Relationentheorie', 1),
(27, 11, 'A\\times B', 'Kartesisches Produkt', 'Menge aller geordneten Paare aus A und B.', NULL, 'Relationentheorie', 2),
(28, 18, '\\Delta_M', 'Diagonale von M', 'Menge aller Paare (x,x) mit x aus M.', NULL, 'Relationentheorie', 1),
(29, 23, '\\sim', 'Äquivalenzrelation', 'Reflexive, symmetrische und transitive Relation.', NULL, 'Relationentheorie', 1),
(30, 24, '[x]_{\\sim}', 'Äquivalenzklasse', 'Klasse aller zu x äquivalenten Elemente.', NULL, 'Relationentheorie', 1),
(31, 25, 'M/{\\sim}', 'Quotientenmenge', 'Menge sämtlicher Äquivalenzklassen.', NULL, 'Relationentheorie', 1),
(32, 27, '\\preceq', 'Partielle Ordnung', 'Reflexive, antisymmetrische und transitive Relation.', NULL, 'Relationentheorie', 1),
(33, 30, 'R^{-1}', 'Umkehrrelation', 'Relation mit vertauschter Paarreihenfolge.', NULL, 'Relationentheorie', 1),
(34, 33, 'S\\circ R', 'Relationale Komposition', 'Über ein Zwischenelement vermittelte Verkettung von R und S.', NULL, 'Relationentheorie', 1),
(35, 39, 'R^{+}', 'Transitive Hülle', 'Vereinigung aller positiven Relationspotenzen.', NULL, 'Relationentheorie', 1),
(36, 40, 'R^{*}', 'Reflexiv-transitive Hülle', 'Transitive Hülle einschließlich Identitätsrelation.', NULL, 'Relationentheorie', 1),
(37, 42, '\\mathbf{M}_R', 'Relationsmatrix', 'Binäre Matrixdarstellung einer endlichen Relation.', NULL, 'Relationentheorie', 1),
(38, 44, '\\bigvee', 'Boolesche Disjunktion', 'Boolesche Addition bei der Matrixkomposition.', NULL, 'Relationentheorie', 1),
(39, 44, '\\land', 'Boolesche Konjunktion', 'Boolesche Multiplikation bei der Matrixkomposition.', NULL, 'Relationentheorie', 2),
(40, 45, 'ast', 'Verknüpfung', 'Zweistellige innere Operation auf M.', NULL, 'M×M nach M', 1),
(41, 45, 'M', 'Trägermenge', 'Menge, auf der die Verknüpfung definiert ist.', NULL, 'Menge', 2),
(42, 46, 'a', 'Erstes Element', 'Erster Operand der Verknüpfung.', NULL, 'Element von M', 1),
(43, 46, 'b', 'Zweites Element', 'Zweiter Operand der Verknüpfung.', NULL, 'Element von M', 2),
(44, 47, 'forall', 'Allquantor', 'Die Aussage gilt für alle Elemente a und b aus M.', NULL, 'Logischer Operator', 1),
(45, 48, 'c', 'Drittes Element', 'Drittes Element der assoziativen Verknüpfungsfolge.', NULL, 'Element von M', 1),
(46, 49, 'e', 'Neutrales Element', 'Element, das jedes andere Element bei der Verknüpfung unverändert lässt.', NULL, 'Element von M', 1),
(47, 50, 'a^{-1}', 'Inverses Element', 'Element, das mit a zum neutralen Element verknüpft wird.', NULL, 'Element von M', 1),
(48, 51, '(M,ast)', 'Algebraische Struktur', 'Trägermenge zusammen mit ihrer Verknüpfung.', NULL, 'Geordnetes Paar', 1),
(49, 52, 'ast', 'Kommutative Verknüpfung', 'Verknüpfung, deren Ergebnis unabhängig von der Reihenfolge ist.', NULL, 'Binäre Operation', 1),
(50, 53, '+', 'Addition', 'Additive Ringverknüpfung.', NULL, 'Binäre Operation auf R', 1),
(51, 53, 'cdot', 'Multiplikation', 'Multiplikative Ringverknüpfung.', NULL, 'Binäre Operation auf R', 2),
(52, 54, '1', 'Multiplikativ neutrales Element', 'Neutrales Element der Multiplikation.', NULL, 'Element des Körpers', 1),
(53, 54, 'a^{-1}', 'Multiplikatives Inverses', 'Inverses des von Null verschiedenen Elements a.', NULL, 'Element des Körpers', 2),
(54, 84, 'f', 'Funktion', 'Eindeutige Zuordnung von A nach B.', NULL, 'Abbildung', 1),
(55, 84, 'A', 'Definitionsbereich', 'Menge aller zulässigen Argumente.', NULL, 'Menge', 2),
(56, 84, 'B', 'Zielbereich', 'Menge aller zulässigen Funktionswerte.', NULL, 'Menge', 3),
(57, 86, 'exists!', 'Eindeutiger Existenzquantor', 'Es existiert genau ein Element mit der angegebenen Eigenschaft.', NULL, 'Logischer Operator', 1),
(58, 87, 'f(A)', 'Bildmenge', 'Menge aller von f tatsächlich angenommenen Werte.', NULL, 'Teilmenge von B', 1),
(59, 89, 'a_1', 'Erstes Argument', 'Element des Definitionsbereichs.', NULL, 'Element von A', 1),
(60, 89, 'a_2', 'Zweites Argument', 'Element des Definitionsbereichs.', NULL, 'Element von A', 2),
(61, 90, 'b', 'Zielwert', 'Beliebiges Element des Zielbereichs.', NULL, 'Element von B', 1),
(62, 91, 'f^{-1}', 'Umkehrfunktion', 'Eindeutige inverse Abbildung zu f.', NULL, 'Abbildung B→A', 1),
(63, 94, 'gcirc f', 'Funktionskomposition', 'Verkettung der Funktionen f und g.', NULL, 'Abbildung A→C', 1),
(64, 97, 'operatorname{id}_A', 'Identitätsabbildung', 'Abbildung, die jedes Element auf sich selbst abbildet.', NULL, 'Abbildung A→A', 1),
(101, 137, 'V', 'Vektorraum', 'Trägermenge der Vektoren.', NULL, 'Menge', 1),
(102, 137, '+', 'Vektoraddition', 'Innere zweistellige Verknüpfung auf V.', NULL, 'V×V→V', 2),
(103, 138, 'K', 'Skalarkörper', 'Körper, über dem der Vektorraum definiert ist.', NULL, 'Körper', 1),
(104, 138, 'cdot', 'Skalarmultiplikation', 'Äußere Verknüpfung zwischen Skalaren und Vektoren.', NULL, 'K×V→V', 2),
(105, 139, 'u', 'Erster Vektor', 'Beliebiger Vektor des Vektorraums.', NULL, 'Element von V', 1),
(106, 139, 'v', 'Zweiter Vektor', 'Beliebiger Vektor des Vektorraums.', NULL, 'Element von V', 2),
(107, 139, 'w', 'Dritter Vektor', 'Beliebiger Vektor des Vektorraums.', NULL, 'Element von V', 3),
(108, 141, '0', 'Nullvektor', 'Additives neutrales Element des Vektorraums.', NULL, 'Element von V', 1),
(109, 143, 'lambda', 'Skalar', 'Beliebiges Element des Skalarkörpers.', NULL, 'Element von K', 1),
(110, 149, '0', 'Nullskalar oder Nullvektor', 'Links bezeichnet 0 den Nullskalar, rechts den Nullvektor; die Bedeutung folgt aus dem Kontext.', NULL, 'K beziehungsweise V', 1),
(111, 151, 'lambda_i', 'Koeffizient', 'Skalarer Koeffizient der Linearkombination.', NULL, 'Element von K', 1),
(112, 151, 'v_i', 'Vektor der Linearkombination', 'Vektor, der skalar gewichtet wird.', NULL, 'Element von V', 2),
(113, 152, 'M', 'Erzeugermenge', 'Teilmenge des Vektorraums, deren Linearkombinationen betrachtet werden.', NULL, 'Teilmenge von V', 1),
(114, 152, 'operatorname{span}(M)', 'Linearer Spann', 'Kleinster Untervektorraum, der M enthält.', NULL, 'Untervektorraum von V', 2),
(115, 153, 'lambda_i=0', 'Triviale Koeffizientenwahl', 'Alle Koeffizienten der Linearkombination sind Null.', NULL, 'Elemente von K', 1),
(116, 154, 'e_i', 'Basisvektor', 'Element einer Basis von V.', NULL, 'Element von V', 1),
(117, 155, 'dim(V)', 'Dimension', 'Anzahl der Elemente einer Basis eines endlichdimensionalen Vektorraums.', NULL, 'Natürliche Zahl', 1),
(118, 155, 'n', 'Dimensionszahl', 'Endliche Anzahl der Basisvektoren.', NULL, 'Natürliche Zahl', 2),
(119, 156, 'T', 'Lineare Abbildung', 'Abbildung, die Addition und Skalarmultiplikation erhält.', NULL, 'V→W', 1),
(120, 156, 'V', 'Ausgangsraum', 'Vektorraum, aus dem die Argumente stammen.', NULL, 'Vektorraum über K', 2),
(121, 156, 'W', 'Zielraum', 'Vektorraum, in den abgebildet wird.', NULL, 'Vektorraum über K', 3),
(122, 160, '0_V', 'Nullvektor des Ausgangsraums', 'Additives neutrales Element von V.', NULL, 'Element von V', 1),
(123, 160, '0_W', 'Nullvektor des Zielraums', 'Additives neutrales Element von W.', NULL, 'Element von W', 2),
(124, 162, 'ker(T)', 'Kern', 'Menge aller auf 0_W abgebildeten Vektoren.', NULL, 'Untervektorraum von V', 1),
(125, 163, 'operatorname{im}(T)', 'Bild', 'Menge aller erreichbaren Vektoren des Zielraums.', NULL, 'Untervektorraum von W', 1),
(126, 168, 'operatorname{rang}(T)', 'Rang', 'Dimension des Bildes der linearen Abbildung.', NULL, 'Nichtnegative ganze Zahl', 1),
(127, 169, 'operatorname{null}(T)', 'Nullität', 'Dimension des Kerns der linearen Abbildung.', NULL, 'Nichtnegative ganze Zahl', 1),
(128, 171, 'e_j', 'Basisvektor des Ausgangsraums', 'j-ter Basisvektor der Basis B.', NULL, 'Element von V', 1),
(129, 171, 'f_i', 'Basisvektor des Zielraums', 'i-ter Basisvektor der Basis C.', NULL, 'Element von W', 2),
(130, 171, 'a_{ij}', 'Matrixkoeffizient', 'i-te Koordinate des Bildes von e_j.', NULL, 'Element von K', 3),
(131, 172, '[T]_{Cleftarrow B}', 'Darstellungsmatrix', 'Matrix von T bezüglich der Ausgangsbasis B und Zielbasis C.', NULL, 'K^{m×n}', 1),
(132, 173, '[v]_B', 'Koordinatenvektor', 'Koordinaten von v bezüglich der Basis B.', NULL, 'K^n', 1),
(133, 173, '[T(v)]_C', 'Bildkoordinaten', 'Koordinaten des Bildvektors bezüglich der Basis C.', NULL, 'K^m', 2),
(134, 174, 'T', 'Linearer Operator', 'Lineare Selbstabbildung eines Vektorraums.', NULL, 'V→V', 1),
(135, 178, 'T^{-1}', 'Inverser Operator', 'Beidseitige inverse Abbildung von T.', NULL, 'V→V', 1),
(136, 178, 'operatorname{id}_V', 'Identitätsoperator', 'Operator, der jeden Vektor unverändert lässt.', NULL, 'V→V', 2);

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

--
-- Daten für Tabelle `proofs`
--

INSERT INTO `proofs` (`proof_id`, `proof_number`, `section_id`, `theorem_id`, `lemma_id`, `corollary_id`, `title`, `proof_text`, `proof_latex`, `proof_method`, `provenance`, `source_id`, `validation_status`, `created_revision_id`) VALUES
(1, '3.2.1-P', 13, 1, NULL, NULL, 'Diagonalbeweis zu Cantors Satz', 'Angenommen, es existiere eine surjektive Abbildung f von M auf P(M). Es sei D die Menge aller x aus M, für die x nicht Element von f(x) ist. Wegen D ⊆ M gilt D ∈ P(M). Aus der angenommenen Surjektivität folgt ein d ∈ M mit f(d)=D. Dann gilt d ∈ D genau dann, wenn d ∉ f(d), also genau dann, wenn d ∉ D. Dieser Widerspruch widerlegt die angenommene Surjektivität.', 'D={xin Mmid x\notin f(x)},qquad din Diff d\notin f(d)iff d\notin D', 'contradiction', 'adapted', 66, 'checked', 10),
(2, '3.2.2-P', 14, 2, NULL, NULL, 'Beweis der Korrespondenz zwischen Äquivalenzrelationen und Partitionen', 'Die Äquivalenzklassen überdecken wegen der Reflexivität die gesamte Menge. Schneiden sich zwei Klassen, folgen aus Symmetrie und Transitivität ihre Gleichheit; sie sind daher identisch oder disjunkt. Umgekehrt definiert die gemeinsame Zugehörigkeit zu genau einem Block einer Partition eine reflexive, symmetrische und transitive Relation.', 'xsim_{mathcal C}yiffexists Cinmathcal C:;xin Cland yin C', 'equivalence', 'adapted', 71, 'checked', 11),
(3, '3.2.3-P', 14, 3, NULL, NULL, 'Beweis der Assoziativität relationaler Komposition', 'Die elementweise Auflösung beider Kompositionen führt jeweils auf dieselbe Existenzbedingung: Es existieren b und c mit (a,b)∈R, (b,c)∈S und (c,d)∈T. Daher sind beide Relationen extensional gleich.', '(a,d)in Tcirc(Scirc R)iffexists bexists c:;(a,b)in Rland(b,c)in Sland(c,d)in Tiff(a,d)in(Tcirc S)circ R', 'direct', 'adapted', 75, 'checked', 11),
(4, '3.2.4-P', 16, 4, NULL, NULL, 'Beweis des Handschlaglemmas', 'Jede ungerichtete Kante besitzt zwei Endknoten und wird in der Summe der Knotengrade genau zweimal gezählt.', '\\sum_{v\\in V}\\deg(v)=2|E|', '', 'literature', 80, 'checked', 13),
(5, '3.2.5-P', 16, 5, NULL, NULL, 'Beweis der Eindeutigkeit der Pfade in einem Baum', 'Der Zusammenhang sichert die Existenz eines Pfades. Zwei verschiedene Pfade zwischen denselben Knoten würden einen Zyklus erzeugen und damit der Azyklizität widersprechen.', '\\forall u,v\\in V,\\;u\\neq v:\\;\\exists!\\,P_{uv}', 'contradiction', 'literature', 80, 'checked', 13),
(6, '3.2.6-P', 17, 6, NULL, NULL, 'Beweis zur Existenz der Umkehrfunktion', 'Ist f bijektiv, besitzt jedes b∈B genau ein Urbild a∈A. Die Zuordnung b↦a ist daher eindeutig und definiert f^{-1}. Existiert umgekehrt f^{-1}, kann kein b ohne Urbild bleiben und kein b zwei verschiedene Urbilder besitzen. Somit ist f surjektiv und injektiv, also bijektiv.', 'f^{-1}	ext{ existiert}Longleftrightarrow f	ext{ ist bijektiv}', 'equivalence', 'adapted', 71, 'checked', 14),
(7, '3.2.7-P', 17, 7, NULL, NULL, 'Beweis der Assoziativität der Funktionskomposition', 'Für jedes a∈A gilt [h∘(g∘f)](a)=h(g(f(a)))=[(h∘g)∘f](a). Da beide Kompositionen für jedes Argument denselben Wert liefern, sind sie als Funktionen identisch.', '[hcirc(gcirc f)](a)=h(g(f(a)))=[(hcirc g)circ f](a)', 'direct', 'adapted', 71, 'checked', 14),
(8, '3.2.8-P', 18, 12, NULL, NULL, 'Beweis der Eindeutigkeit des Nullvektors', 'Seien 0_1 und 0_2 zwei additive neutrale Elemente. Wegen der Neutralität von 0_2 gilt 0_1=0_1+0_2. Wegen der Neutralität von 0_1 gilt zugleich 0_1+0_2=0_2. Daher ist 0_1=0_2.', '0_1=0_1+0_2=0_2', 'direct', 'adapted', 93, 'checked', 17),
(9, '3.2.9-P', 18, 13, NULL, NULL, 'Beweis der Eindeutigkeit des inversen Vektors', 'Seien x und y zwei additive Inverse desselben Vektors v. Dann folgt x=x+0=x+(v+y)=(x+v)+y=0+y=y. Somit stimmen beide inversen Vektoren überein.', 'x=x+0=x+(v+y)=(x+v)+y=0+y=y', 'direct', 'adapted', 93, 'checked', 17),
(10, '3.2.10-P', 19, 14, NULL, NULL, 'Beweis der Erhaltung des Nullvektors', 'Für jeden Vektor v gilt 0_V=0_Kv. Aus der Homogenität folgt T(0_V)=T(0_Kv)=0_KT(v)=0_W.', 'T(0_V)=T(0_Kv)=0_KT(v)=0_W', 'direct', 'adapted', 96, 'checked', 18),
(11, '3.2.11-P', 19, 15, NULL, NULL, 'Beweis der Untervektorraumeigenschaft von Kern und Bild', 'Der Nullvektor liegt im Kern. Jede Linearkombination zweier Kernelemente wird erneut auf den Nullvektor abgebildet. Für zwei Bildelemente x=T(u) und y=T(v) ist jede Linearkombination λx+μy gleich T(λu+μv) und liegt daher wieder im Bild.', 'T(lambda u+mu v)=lambda T(u)+mu T(v)=0_W,quadlambda x+mu y=T(lambda u+mu v)', 'direct', 'adapted', 96, 'checked', 18);

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
('next_citation_number', '91', '2026-07-18 11:39:48');

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
(5, 'RKB-NEU-K3.1.4-V1', '2026-07-17 13:19:14', 'section', '3.1.4', '1.0', 'Vollständige Neufassung von Abschnitt 3.1.4. Wiederverwendung von [13], [18], [22] und Aufnahme von [41] bis [55].', 'Olaf Thiele / ChatGPT', 4),
(6, 'RKB-NEU-K3.1.5-V1', '2026-07-17 17:19:42', 'section', '3.1.5', '1.0', 'Vollständige Neufassung von Abschnitt 3.1.5 Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem. Aufnahme der neuen Quellen [56] und [57].', 'Olaf Thiele / ChatGPT', 5),
(7, 'RKB-NEU-K3.1.6-V1', '2026-07-18 06:49:51', 'section', '3.1.6', '1.0', 'Neufassung von Abschnitt 3.1.6 Funktion statt Objekt. Wiederverwendung von [16], [18], [56], [57] und Aufnahme der Quellen [58] bis [65].', 'Olaf Thiele / ChatGPT', 6),
(8, 'RKB-NEU-K3.1.7-V1', '2026-07-18 06:55:37', 'section', '3.1.7', '1.0', 'Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung.', 'Olaf Thiele / ChatGPT', 7),
(9, 'RKB-NEU-K3.2.0-V1', '2026-07-18 07:30:00', 'section', '3.2.0', '1.0', 'Neuanlage von Kapitel 3.2 Mathematische Grundlagen und Abschluss von Abschnitt 3.2.0 Einleitung. Der Abschnitt legt Funktion, Abgrenzung, wissenschaftliche Zielsetzung und Aufbau des mathematischen Forschungsstands fest. Es werden keine neuen Quellen, Gleichungen, Definitionen oder FRZK-spezifischen mathematischen Objekte eingeführt.', 'Olaf Thiele / ChatGPT', 8),
(10, 'RKB-NEU-K3.2.1-V1', '2026-07-18 08:03:45', 'section', '3.2.1', '1.0', 'Abschluss von Abschnitt 3.2.1 Mengen als Grundlage mathematischer Modellbildung. Registriert werden die Quellen [66] bis [72], drei Definitionen, das Extensionalitätsprinzip, Cantors Satz einschließlich Widerspruchsbeweis sowie die Gleichungen (3.149) bis (3.158). Der Abschnitt bleibt Forschungsstand und enthält keine eigenständige FRZK-Axiomatik.', 'Olaf Thiele / ChatGPT', 9),
(11, 'RKB-NEU-K3.2.2-V1', '2026-07-18 08:16:56', 'section', '3.2.2', '1.0', 'Abschluss von Abschnitt 3.2.2 Relationen als Beschreibung mathematischer Zusammenhänge. Aufnahme der Quellen [73] bis [75], Wiederverwendung von [72], Registrierung der Definitionen 3.2.4 bis 3.2.13, der Sätze 3.2.2 und 3.2.3, der zugehörigen Beweise sowie der Gleichungen (3.159) bis (3.192).', 'Olaf Thiele / ChatGPT', 10),
(12, 'RKB-NEU-K3.2.3-V1', '2026-07-18 08:51:13', 'section', '3.2.3', '1.0', 'Abschluss von Abschnitt 3.2.3 Algebraische Strukturen als Träger mathematischer Operationen. Registriert werden die Quellen [76] bis [78], die Wiederverwendung von [72], die Definitionen 3.2.14 bis 3.2.21 sowie die Gleichungen (3.193) bis (3.202). Der Abschnitt bleibt Forschungsstand und enthält keine eigenständige FRZK-Axiomatik.', 'Olaf Thiele / ChatGPT', 11),
(13, 'RKB-NEU-K3.2.4-V1', '2026-07-18 09:43:11', 'section', '3.2.4', '1.0', 'Abschluss von Abschnitt 3.2.4 Graphen und Netzwerke als Darstellung relationaler Gesamtstrukturen. Aufnahme der Quellen [79] bis [82], Wiederverwendung von [72] und [75], Registrierung der Definitionen 3.2.22 bis 3.2.31, der Sätze 3.2.4 und 3.2.5, der Beweise sowie der Gleichungen (3.203) bis (3.231).', 'Olaf Thiele / ChatGPT', 12),
(14, 'RKB-NEU-K3.2.5-V1', '2026-07-18 10:59:33', 'section', '3.2.5', '1.0', 'Abschluss von Abschnitt 3.2.5. Registriert werden die Quellen [83] und [84], die Wiederverwendung von [72], die Definitionen 3.2.32 bis 3.2.38, die Sätze 3.2.6 und 3.2.7 mit Beweisen sowie die Gleichungen (3.232) bis (3.246).', 'Olaf Thiele / ChatGPT', 13),
(17, 'RKB-NEU-K3.2.6-V1', '2026-07-18 13:15:45', 'section', '3.2.6', '1.0', 'Abschluss von Abschnitt 3.2.6. Registriert werden die Quellen [85] bis [87], die Definitionen 3.2.39 bis 3.2.44, die Sätze 3.2.8 und 3.2.9 mit Beweisen sowie die Gleichungen (3.247) bis (3.265).', 'Olaf Thiele / ChatGPT', 14),
(18, 'RKB-NEU-K3.2.7-V1', '2026-07-18 13:39:48', 'section', '3.2.7', '1.0', 'Abschluss von Abschnitt 3.2.7: Quellen [88] bis [90], Definitionen 3.2.45 bis 3.2.51, Sätze 3.2.10 bis 3.2.13, zwei Beweise und Gleichungen (3.266) bis (3.292).', 'Olaf Thiele / ChatGPT', 17);

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
(1, 9, 'K3.2.0-SECTION-EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.0 muss genau einmal im Repository vorhanden sein.', '2026-07-18 05:28:53'),
(2, 9, 'K3.2.0-PARENT', 'passed', '11', '11', 'Abschnitt 3.2.0 muss dem Hauptabschnitt 3.2 untergeordnet sein.', '2026-07-18 05:28:53'),
(3, 9, 'K3.2.0-STATUS', 'passed', 'final', 'final', 'Der abgeschlossene Einleitungsabschnitt muss den Status final besitzen.', '2026-07-18 05:28:53'),
(4, 9, 'K3.2.0-NO-NEW-SOURCES', 'passed', '0', '0', 'Für 3.2.0 wurden planmäßig keine neuen Quellenverwendungen registriert.', '2026-07-18 05:28:53'),
(5, 9, 'K3.2.0-NO-EQUATIONS', 'passed', '0', '0', 'Die Einleitung enthält planmäßig keine registrierungspflichtige Gleichung.', '2026-07-18 05:28:53'),
(6, 9, 'K3.2.0-PARENT-REVISION', 'passed', '8', '8', 'Die Revision von 3.2.0 muss unmittelbar auf dem Abschluss von 3.1.7 aufbauen.', '2026-07-18 05:28:53'),
(7, 9, 'K3.2.0-NEXT-CITATION', 'passed', '>=66', '66', 'Die nächste freie Literaturziffer darf durch 3.2.0 nicht zurückgesetzt werden.', '2026-07-18 05:28:53'),
(8, 10, 'K3.2.1-SECTION-EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.1 muss genau einmal vorhanden sein.', '2026-07-18 06:03:45'),
(9, 10, 'K3.2.1-SOURCES', 'failed', '7', '6', 'Abschnitt 3.2.1 muss die sieben neuen Quellen [66] bis [72] verwenden.', '2026-07-18 06:03:45'),
(10, 10, 'K3.2.1-DEFINITIONS', 'passed', '3', '3', 'Abschnitt 3.2.1 muss drei Definitionen enthalten.', '2026-07-18 06:03:45'),
(11, 10, 'K3.2.1-THEOREM', 'passed', '1', '1', 'Cantors Satz muss genau einmal als Satz 3.2.1 registriert sein.', '2026-07-18 06:03:45'),
(12, 10, 'K3.2.1-PROOF', 'passed', '1', '1', 'Der Widerspruchsbeweis zu Cantors Satz muss genau einmal registriert sein.', '2026-07-18 06:03:45'),
(13, 10, 'K3.2.1-EQUATIONS', 'passed', '10', '10', 'Die Gleichungen (3.149) bis (3.158) müssen vollständig registriert sein.', '2026-07-18 06:03:45'),
(14, 10, 'K3.2.1-WORD-LATEX', 'passed', '10', '10', 'Für alle zehn Gleichungen muss eine Word-LaTeX-Repräsentation vorhanden sein.', '2026-07-18 06:03:45'),
(15, 10, 'K3.2.1-PARENT-REVISION', 'passed', '9', '9', 'Die Revision 3.2.1 muss unmittelbar auf der Abschlussrevision 3.2.0 aufbauen.', '2026-07-18 06:03:45'),
(16, 10, 'K3.2.1-NEXT-CITATION', 'passed', '>=73', '73', 'Nach den Quellen [66] bis [72] muss die nächste freie Literaturziffer mindestens [73] sein.', '2026-07-18 06:03:45'),
(17, 11, 'K3.2.2-SECTION', 'passed', '1', '1', 'Abschnitt 3.2.2 muss genau einmal vorhanden sein.', '2026-07-18 06:16:56'),
(18, 11, 'K3.2.2-NEW-SOURCES', 'passed', '3', '3', 'Die neuen Quellen [73] bis [75] müssen vollständig vorhanden sein.', '2026-07-18 06:16:56'),
(19, 11, 'K3.2.2-SOURCE-USAGE', 'passed', '4', '4', 'Die Quellen [72] bis [75] müssen mit Abschnitt 3.2.2 verknüpft sein.', '2026-07-18 06:16:56'),
(20, 11, 'K3.2.2-DEFINITIONS', 'passed', '10', '10', 'Die Definitionen 3.2.4 bis 3.2.13 müssen vollständig registriert sein.', '2026-07-18 06:16:56'),
(21, 11, 'K3.2.2-THEOREMS', 'passed', '2', '2', 'Die Sätze 3.2.2 und 3.2.3 müssen vollständig registriert sein.', '2026-07-18 06:16:56'),
(22, 11, 'K3.2.2-PROOFS', 'passed', '2', '2', 'Zu den Sätzen 3.2.2 und 3.2.3 müssen zwei Beweise vorhanden sein.', '2026-07-18 06:16:56'),
(23, 11, 'K3.2.2-EQUATIONS', 'passed', '34', '34', 'Die Gleichungen (3.159) bis (3.192) müssen vollständig registriert sein.', '2026-07-18 06:16:56'),
(24, 11, 'K3.2.2-WORD-LATEX', 'passed', '34', '34', 'Für alle Gleichungen muss Word-LaTeX vorhanden sein.', '2026-07-18 06:16:56'),
(25, 11, 'K3.2.2-PARENT-REVISION', 'passed', '10', '10', 'Die Revision 3.2.2 muss unmittelbar auf 3.2.1 aufbauen.', '2026-07-18 06:16:56'),
(26, 11, 'K3.2.2-NEXT-CITATION', 'passed', '>=76', '76', 'Nach [75] muss die nächste freie Literaturziffer mindestens [76] sein.', '2026-07-18 06:16:56'),
(27, 12, 'K3.2.3-SECTION', 'passed', '1', '1', 'Abschnitt 3.2.3 muss genau einmal vorhanden sein.', '2026-07-18 06:51:13'),
(28, 12, 'K3.2.3-NEW-SOURCES', 'passed', '3', '3', 'Die neuen Quellen [76] bis [78] müssen vollständig vorhanden sein.', '2026-07-18 06:51:13'),
(29, 12, 'K3.2.3-SOURCE-USAGE', 'passed', '4', '4', 'Die Quellen [72] sowie [76] bis [78] müssen mit Abschnitt 3.2.3 verknüpft sein.', '2026-07-18 06:51:13'),
(30, 12, 'K3.2.3-DEFINITIONS', 'passed', '8', '8', 'Die Definitionen 3.2.14 bis 3.2.21 müssen vollständig registriert sein.', '2026-07-18 06:51:13'),
(31, 12, 'K3.2.3-EQUATIONS', 'passed', '10', '10', 'Die Gleichungen (3.193) bis (3.202) müssen vollständig registriert sein.', '2026-07-18 06:51:13'),
(32, 12, 'K3.2.3-WORD-LATEX', 'passed', '10', '10', 'Für alle zehn Gleichungen muss eine Word-LaTeX-Repräsentation vorhanden sein.', '2026-07-18 06:51:13'),
(33, 12, 'K3.2.3-PARENT-REVISION', 'passed', '11', '11', 'Die Revision 3.2.3 muss unmittelbar auf der Revision 3.2.2 aufbauen.', '2026-07-18 06:51:13'),
(34, 12, 'K3.2.3-NEXT-CITATION', 'passed', '>=79', '79', 'Nach Quelle [78] muss die nächste freie Literaturziffer mindestens [79] sein.', '2026-07-18 06:51:13'),
(35, 13, 'K3.2.4-SECTION', 'passed', '1', '1', 'Abschnitt 3.2.4 muss genau einmal vorhanden sein.', '2026-07-18 07:43:11'),
(36, 13, 'K3.2.4-NEW-SOURCES', 'passed', '4', '4', 'Die Quellen [79] bis [82] müssen vorhanden sein.', '2026-07-18 07:43:11'),
(37, 13, 'K3.2.4-DEFINITIONS', 'passed', '10', '10', 'Die Definitionen 3.2.22 bis 3.2.31 müssen vorhanden sein.', '2026-07-18 07:43:11'),
(38, 13, 'K3.2.4-THEOREMS', 'passed', '2', '2', 'Die Sätze 3.2.4 und 3.2.5 müssen vorhanden sein.', '2026-07-18 07:43:11'),
(39, 13, 'K3.2.4-PROOFS', 'passed', '2', '2', 'Zwei Beweise müssen vorhanden sein.', '2026-07-18 07:43:11'),
(40, 13, 'K3.2.4-EQUATIONS', 'passed', '29', '29', 'Die Gleichungen (3.203) bis (3.231) müssen vorhanden sein.', '2026-07-18 07:43:11'),
(41, 13, 'K3.2.4-WORD-LATEX', 'passed', '29', '29', 'Für alle Gleichungen muss Word-LaTeX vorhanden sein.', '2026-07-18 07:43:11'),
(42, 13, 'K3.2.4-NEXT-CITATION', 'passed', '>=83', '83', 'Die nächste freie Literaturziffer muss mindestens [83] sein.', '2026-07-18 07:43:11'),
(43, 14, 'K3.2.5-SECTION', 'passed', '1', '1', 'Abschnitt 3.2.5 muss genau einmal vorhanden sein.', '2026-07-18 08:59:33'),
(44, 14, 'K3.2.5-NEW-SOURCES', 'passed', '2', '2', 'Die Quellen [83] und [84] müssen vollständig vorhanden sein.', '2026-07-18 08:59:33'),
(45, 14, 'K3.2.5-SOURCE-USAGE', 'passed', '3', '3', 'Die Quellen [72], [83] und [84] müssen mit Abschnitt 3.2.5 verknüpft sein.', '2026-07-18 08:59:33'),
(46, 14, 'K3.2.5-DEFINITIONS', 'passed', '7', '7', 'Die Definitionen 3.2.32 bis 3.2.38 müssen vollständig registriert sein.', '2026-07-18 08:59:33'),
(47, 14, 'K3.2.5-THEOREMS', 'passed', '2', '2', 'Die Sätze 3.2.6 und 3.2.7 müssen vollständig registriert sein.', '2026-07-18 08:59:33'),
(48, 14, 'K3.2.5-PROOFS', 'passed', '2', '2', 'Zu den Sätzen müssen zwei Beweise vorhanden sein.', '2026-07-18 08:59:33'),
(49, 14, 'K3.2.5-EQUATIONS', 'passed', '15', '15', 'Die Gleichungen (3.232) bis (3.246) müssen vollständig registriert sein.', '2026-07-18 08:59:33'),
(50, 14, 'K3.2.5-WORD-LATEX', 'passed', '15', '15', 'Für alle Gleichungen muss Word-LaTeX vorhanden sein.', '2026-07-18 08:59:33'),
(51, 14, 'K3.2.5-PARENT-REVISION', 'passed', '13', '13', 'Die Revision 3.2.5 muss unmittelbar auf der Revision 3.2.4 aufbauen.', '2026-07-18 08:59:33'),
(52, 14, 'K3.2.5-NEXT-CITATION', 'passed', '>=85', '85', 'Nach Quelle [84] muss die nächste freie Literaturziffer mindestens [85] sein.', '2026-07-18 08:59:33'),
(53, 17, 'K3.2.6-SECTION', 'passed', '1', '1', 'Abschnitt 3.2.6 muss genau einmal vorhanden sein.', '2026-07-18 11:15:45'),
(54, 17, 'K3.2.6-NEW-SOURCES', 'passed', '3', '3', 'Die Quellen [85], [86] und [87] müssen vollständig vorhanden sein.', '2026-07-18 11:15:45'),
(55, 17, 'K3.2.6-SOURCE-USAGE', 'passed', '3', '3', 'Die Quellen [85] bis [87] müssen mit Abschnitt 3.2.6 verknüpft sein.', '2026-07-18 11:15:45'),
(56, 17, 'K3.2.6-DEFINITIONS', 'passed', '6', '6', 'Die Definitionen 3.2.39 bis 3.2.44 müssen vollständig registriert sein.', '2026-07-18 11:15:45'),
(57, 17, 'K3.2.6-THEOREMS', 'passed', '2', '2', 'Die Sätze 3.2.8 und 3.2.9 müssen vollständig registriert sein.', '2026-07-18 11:15:45'),
(58, 17, 'K3.2.6-PROOFS', 'passed', '2', '2', 'Zu den Sätzen müssen zwei Beweise vorhanden sein.', '2026-07-18 11:15:45'),
(59, 17, 'K3.2.6-EQUATIONS', 'passed', '19', '19', 'Die Gleichungen (3.247) bis (3.265) müssen vollständig registriert sein.', '2026-07-18 11:15:45'),
(60, 17, 'K3.2.6-WORD-LATEX', 'passed', '19', '19', 'Für alle Gleichungen muss Word-LaTeX vorhanden sein.', '2026-07-18 11:15:45'),
(61, 17, 'K3.2.6-PARENT-REVISION', 'passed', '14', '14', 'Die Revision 3.2.6 muss unmittelbar auf der Revision 3.2.5 aufbauen.', '2026-07-18 11:15:45'),
(62, 17, 'K3.2.6-NEXT-CITATION', 'passed', '>=88', '88', 'Nach Quelle [87] muss die nächste freie Literaturziffer mindestens [88] sein.', '2026-07-18 11:15:45'),
(63, 18, 'K3.2.7-SECTION', 'passed', '1', '1', 'Abschnitt 3.2.7 muss genau einmal vorhanden sein.', '2026-07-18 11:39:48'),
(64, 18, 'K3.2.7-SOURCES', 'passed', '3', '3', 'Die Quellen [88] bis [90] müssen vollständig vorhanden sein.', '2026-07-18 11:39:48'),
(65, 18, 'K3.2.7-SOURCE-USAGE', 'passed', '3', '3', 'Die drei neuen Quellen müssen mit Abschnitt 3.2.7 verknüpft sein.', '2026-07-18 11:39:48'),
(66, 18, 'K3.2.7-DEFINITIONS', 'passed', '7', '7', 'Die Definitionen 3.2.45 bis 3.2.51 müssen vollständig vorhanden sein.', '2026-07-18 11:39:48'),
(67, 18, 'K3.2.7-THEOREMS', 'passed', '4', '4', 'Die Sätze 3.2.10 bis 3.2.13 müssen vollständig vorhanden sein.', '2026-07-18 11:39:48'),
(68, 18, 'K3.2.7-PROOFS', 'passed', '2', '2', 'Die Beweise 3.2.10-P und 3.2.11-P müssen vorhanden sein.', '2026-07-18 11:39:48'),
(69, 18, 'K3.2.7-EQUATIONS', 'passed', '27', '27', 'Die Gleichungen (3.266) bis (3.292) müssen vollständig vorhanden sein.', '2026-07-18 11:39:48'),
(70, 18, 'K3.2.7-WORD-LATEX', 'passed', '27', '27', 'Für alle Gleichungen muss Word-LaTeX vorhanden sein.', '2026-07-18 11:39:48'),
(71, 18, 'K3.2.7-PARENT-REVISION', 'passed', '17', '17', 'Die Revision muss unmittelbar auf RKB-NEU-K3.2.6-V1 aufbauen.', '2026-07-18 11:39:48'),
(72, 18, 'K3.2.7-NEXT-CITATION', 'passed', '>=91', '91', 'Nach Quelle [90] muss die nächste freie Literaturziffer mindestens [91] sein.', '2026-07-18 11:39:48');

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
(22, 5, 7, 'status_changed', 'section', '3.1.4', 'Bearbeitungsstatus auf final gesetzt.', 'draft', 'final', '2026-07-17 11:19:14'),
(23, 6, 8, 'created', 'section', '3.1.5', 'Abschnitt 3.1.5 vollständig neu erstellt.', NULL, 'Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem', '2026-07-17 15:19:42'),
(24, 6, 8, 'source_added', 'source', '[56]–[57]', 'Zwei neue methodologische und mathematische Grundlagenquellen wurden aufgenommen.', NULL, 'Mac Lane [56]; Eilenberg und Mac Lane [57]', '2026-07-17 15:19:42'),
(25, 6, 8, 'other', 'methodological_framework', 'FRZK-Arbeitsregeln', 'Methodologische Regeln für den weiteren Aufbau des FRZK wurden explizit dokumentiert.', NULL, 'Schrittweiser Aufbau; keine verdeckten Voraussetzungen; Strukturerhaltung; Trennung von Konstruktion und Interpretation; Modularisierung; Reproduzierbarkeit; Vorrang der mathematischen Rekonstruktion', '2026-07-17 15:19:42'),
(26, 6, 8, 'status_changed', 'section', '3.1.5', 'Bearbeitungsstatus auf final gesetzt.', 'draft', 'final', '2026-07-17 15:19:42'),
(27, 7, 9, 'created', 'section', '3.1.6', 'Abschnitt 3.1.6 vollständig neu erstellt.', NULL, 'Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft', '2026-07-18 04:49:51'),
(28, 7, 9, 'source_reused', 'source', '[16], [18], [56], [57]', 'Vier vorhandene Quellen wurden mit unveränderten Literaturzahlen wiederverwendet.', NULL, 'Whitehead [16]; Cassirer [18]; Mac Lane [56]; Eilenberg und Mac Lane [57]', '2026-07-18 04:49:51'),
(29, 7, 9, 'source_added', 'source', '[58]–[65]', 'Acht neue Quellen wurden aufgenommen.', NULL, 'Frege [58] bis Luhmann [65]', '2026-07-18 04:49:51'),
(30, 7, 9, 'other', 'conceptual_result', 'funktionaler Paradigmenwechsel', 'Objekte werden nicht als primitive Einheiten vorausgesetzt, sondern als mögliche kohärente funktionale Stabilisierung rekonstruiert.', NULL, 'Funktionalität als relational, prozessual und rekursiv; Objektstabilität als Sonderfall funktionaler Kohärenz', '2026-07-18 04:49:51'),
(31, 7, 9, 'other', 'research_gap', 'Grenze bestehender Funktionsbeschreibungen', 'Die Forschungslücke wurde als fehlende Rekonstruktion der Entstehung von Unterscheidbarkeit, Relation, Zustand und Ordnung aus minimaler funktionaler Organisation bestimmt.', NULL, 'Bestehende Ansätze setzen Mengen, Zustände, Systeme, Objekte, Morphismen oder Strukturen bereits voraus.', '2026-07-18 04:49:51'),
(32, 7, 9, 'status_changed', 'section', '3.1.6', 'Bearbeitungsstatus auf final gesetzt.', 'draft', 'final', '2026-07-18 04:49:51'),
(33, 8, 10, 'created', 'section', '3.1.7', 'Abschnitt neu erstellt.', NULL, 'Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung', '2026-07-18 04:55:37'),
(34, 8, 10, 'status_changed', 'section', '3.1.7', 'Status final.', 'draft', 'final', '2026-07-18 04:55:37'),
(35, 9, 11, 'created', 'section', '3.2', 'Hauptabschnitt 3.2 Mathematische Grundlagen wurde als mathematischer Forschungsstandsabschnitt angelegt.', NULL, 'status=review; is_original_contribution=0', '2026-07-18 05:28:53'),
(36, 9, 12, 'created', 'section', '3.2.0', 'Abschnitt 3.2.0 Einleitung wurde vollständig neu angelegt und als abgeschlossen markiert.', NULL, 'status=final; keine neuen Quellen oder Gleichungen', '2026-07-18 05:28:53'),
(37, 10, 13, 'created', 'section', '3.2.1', 'Abschnitt 3.2.1 wurde als mathematischer Forschungsstandsabschnitt vollständig angelegt und abgeschlossen.', NULL, 'status=final; keine FRZK-Eigenaxiomatik', '2026-07-18 06:03:45'),
(38, 10, 13, 'source_added', 'sources', '[66]-[72]', 'Sieben neue Quellen zur Entwicklung, Axiomatisierung und strukturalen Verwendung der Mengenlehre wurden aufgenommen.', 'next_citation_number=66', 'next_citation_number=73', '2026-07-18 06:03:45'),
(39, 10, 13, 'definition_added', 'definitions', '3.2.1-3.2.3', 'Definitionen von Menge und Elementbeziehung, Teilmenge und Potenzmenge wurden registriert.', NULL, '3 Definitionen', '2026-07-18 06:03:45'),
(40, 10, 13, 'statement_added', 'theorem', 'Satz 3.2.1', 'Cantors Satz wurde einschließlich des zugehörigen Diagonalbeweises registriert.', NULL, 'theorem=checked; proof=checked', '2026-07-18 06:03:45'),
(41, 10, 13, 'equation_added', 'equations', '(3.149)-(3.158)', 'Zehn Gleichungen einschließlich Word-LaTeX-Repräsentationen und Symbolzuordnungen wurden aufgenommen.', NULL, '10 Gleichungen', '2026-07-18 06:03:45'),
(42, 11, 14, 'created', 'section', '3.2.2', 'Abschnitt 3.2.2 wurde vollständig angelegt und repositoryseitig abgeschlossen.', NULL, 'status=final; Forschungsstand ohne FRZK-Eigenaxiomatik', '2026-07-18 06:16:56'),
(43, 11, 14, 'source_added', 'sources', '[73]-[75]', 'Drei neue Primärquellen zur Relationslogik und zum Relationskalkül wurden aufgenommen.', 'next_citation_number=73', 'next_citation_number=76', '2026-07-18 06:16:56'),
(44, 11, 14, 'source_reused', 'source', '[72]', 'Bourbaki wurde für mengentheoretische Relationen, Äquivalenzklassen, Quotientenmengen und Ordnungen wiederverwendet.', NULL, 'source_usage registriert', '2026-07-18 06:16:56'),
(45, 11, 14, 'definition_added', 'definitions', '3.2.4-3.2.13', 'Zehn Definitionen der Relationentheorie wurden registriert.', NULL, '10 Definitionen', '2026-07-18 06:16:56'),
(46, 11, 14, 'statement_added', 'theorems', '3.2.2-3.2.3', 'Die Sätze zur Korrespondenz von Äquivalenzrelationen und Partitionen sowie zur Assoziativität der relationalen Komposition wurden registriert.', NULL, '2 Sätze', '2026-07-18 06:16:56'),
(47, 11, 14, 'proof_added', 'proofs', '3.2.2-P;3.2.3-P', 'Zu beiden Sätzen wurden vollständige Beweisdatensätze aufgenommen.', NULL, '2 Beweise', '2026-07-18 06:16:56'),
(48, 11, 14, 'equation_added', 'equations', '(3.159)-(3.192)', 'Vierunddreißig Gleichungen einschließlich Word-LaTeX wurden registriert.', NULL, '34 Gleichungen', '2026-07-18 06:16:56'),
(49, 12, 15, 'created', 'section', '3.2.3', 'Abschnitt 3.2.3 wurde vollständig angelegt und repositoryseitig abgeschlossen.', NULL, 'status=final; Forschungsstand ohne FRZK-Eigenaxiomatik', '2026-07-18 06:51:13'),
(50, 12, 15, 'source_added', 'sources', '[76]-[78]', 'Drei historische Quellen zur Entwicklung der modernen Algebra und Gruppentheorie wurden aufgenommen.', 'next_citation_number=76', 'next_citation_number=79', '2026-07-18 06:51:13'),
(51, 12, 15, 'source_reused', 'source', '[72]', 'Bourbaki wurde zur strukturellen Einordnung algebraischer Verknüpfungen erneut verwendet.', NULL, 'source_usage registriert', '2026-07-18 06:51:13'),
(52, 12, 15, 'definition_added', 'definitions', '3.2.14-3.2.21', 'Acht Definitionen zu algebraischen Verknüpfungen, Gruppen, Ringen und Körpern wurden registriert.', NULL, '8 Definitionen', '2026-07-18 06:51:13'),
(53, 12, 15, 'equation_added', 'equations', '(3.193)-(3.202)', 'Zehn Gleichungen einschließlich Word-LaTeX und Symbolzuordnungen wurden aufgenommen.', NULL, '10 Gleichungen', '2026-07-18 06:51:13'),
(54, 13, 16, 'created', 'section', '3.2.4', 'Abschnitt 3.2.4 vollständig angelegt.', NULL, 'status=final', '2026-07-18 07:43:11'),
(55, 13, 16, 'source_added', 'sources', '[79]-[82]', 'Vier neue Quellen aufgenommen.', 'next_citation_number=79', 'next_citation_number=83', '2026-07-18 07:43:11'),
(56, 13, 16, 'definition_added', 'definitions', '3.2.22-3.2.31', 'Zehn Definitionen registriert.', NULL, '10 Definitionen', '2026-07-18 07:43:11'),
(57, 13, 16, 'statement_added', 'theorems', '3.2.4-3.2.5', 'Zwei Sätze registriert.', NULL, '2 Sätze', '2026-07-18 07:43:11'),
(58, 13, 16, 'proof_added', 'proofs', '3.2.4-P;3.2.5-P', 'Zwei Beweise registriert.', NULL, '2 Beweise', '2026-07-18 07:43:11'),
(59, 13, 16, 'equation_added', 'equations', '(3.203)-(3.231)', '29 Gleichungen registriert.', NULL, '29 Gleichungen', '2026-07-18 07:43:11'),
(60, 14, 17, 'created', 'section', '3.2.5', 'Abschnitt 3.2.5 wurde vollständig angelegt und repositoryseitig abgeschlossen.', NULL, 'status=final', '2026-07-18 08:59:33'),
(61, 14, 17, 'source_added', 'sources', '[83]-[84]', 'Zwei historische Quellen zur Entwicklung des Funktionsbegriffs wurden aufgenommen.', 'next_citation_number=83', 'next_citation_number=85', '2026-07-18 08:59:33'),
(62, 14, 17, 'source_reused', 'source', '[72]', 'Bourbaki wurde für die mengentheoretische Definition von Funktionen wiederverwendet.', NULL, 'source_usage registriert', '2026-07-18 08:59:33'),
(63, 14, 17, 'definition_added', 'definitions', '3.2.32-3.2.38', 'Sieben Definitionen zu Funktionen, Bildmengen, Abbildungseigenschaften, Komposition und Identität wurden registriert.', NULL, '7 Definitionen', '2026-07-18 08:59:33'),
(64, 14, 17, 'statement_added', 'theorems', '3.2.6-3.2.7', 'Zwei Sätze zur Umkehrfunktion und zur Assoziativität der Komposition wurden registriert.', NULL, '2 Sätze', '2026-07-18 08:59:33'),
(65, 14, 17, 'proof_added', 'proofs', '3.2.6-P;3.2.7-P', 'Zu beiden Sätzen wurden Beweise aufgenommen.', NULL, '2 Beweise', '2026-07-18 08:59:33'),
(66, 14, 17, 'equation_added', 'equations', '(3.232)-(3.246)', 'Fünfzehn Gleichungen einschließlich Word-LaTeX wurden aufgenommen.', NULL, '15 Gleichungen', '2026-07-18 08:59:33'),
(75, 17, 18, 'created', 'section', '3.2.6', 'Abschnitt 3.2.6 wurde vollständig angelegt und repositoryseitig abgeschlossen.', NULL, 'status=final', '2026-07-18 11:15:45'),
(76, 17, 18, 'source_added', 'sources', '[85]-[87]', 'Drei Quellen zur historischen und modernen Entwicklung des Vektorraumbegriffs wurden aufgenommen.', 'next_citation_number=85', 'next_citation_number=88', '2026-07-18 11:15:45'),
(77, 17, 18, 'definition_added', 'definitions', '3.2.39-3.2.44', 'Sechs Definitionen zu Vektorraum, Linearkombination, Spann, linearer Unabhängigkeit, Basis und Dimension wurden registriert.', NULL, '6 Definitionen', '2026-07-18 11:15:45'),
(78, 17, 18, 'statement_added', 'theorems', '3.2.8-3.2.9', 'Zwei Sätze zur Eindeutigkeit des Nullvektors und des additiven Inversen wurden registriert.', NULL, '2 Sätze', '2026-07-18 11:15:45'),
(79, 17, 18, 'proof_added', 'proofs', '3.2.8-P;3.2.9-P', 'Zu beiden Sätzen wurden direkte Beweise aufgenommen.', NULL, '2 Beweise', '2026-07-18 11:15:45'),
(80, 17, 18, 'equation_added', 'equations', '(3.247)-(3.265)', 'Neunzehn Gleichungen einschließlich Word-LaTeX wurden aufgenommen.', NULL, '19 Gleichungen', '2026-07-18 11:15:45'),
(81, 18, 19, 'created', 'section', '3.2.7', 'Abschnitt 3.2.7 wurde vollständig im Repository registriert.', NULL, 'status=final', '2026-07-18 11:39:48'),
(82, 18, 19, 'source_added', 'sources', '[88]-[90]', 'Drei Quellen zur Geschichte der Matrizen und zu linearen Transformationen wurden aufgenommen.', 'next_citation_number=88', 'next_citation_number=91', '2026-07-18 11:39:48'),
(83, 18, 19, 'definition_added', 'definitions', '3.2.45-3.2.51', 'Sieben Definitionen wurden registriert.', NULL, '7 Definitionen', '2026-07-18 11:39:48'),
(84, 18, 19, 'statement_added', 'theorems', '3.2.10-3.2.13', 'Vier Sätze wurden registriert.', NULL, '4 Sätze', '2026-07-18 11:39:48'),
(85, 18, 19, 'proof_added', 'proofs', '3.2.10-P;3.2.11-P', 'Zwei direkte Beweise wurden registriert.', NULL, '2 Beweise', '2026-07-18 11:39:48'),
(86, 18, 19, 'equation_added', 'equations', '(3.266)-(3.292)', 'Siebenundzwanzig Gleichungen einschließlich Word-LaTeX wurden aufgenommen.', NULL, '27 Gleichungen', '2026-07-18 11:39:48');

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
(15, 15, 'russell_principles_mathematics_1903', 'book', 'The Principles of Mathematics', NULL, 1903, 1903, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 7, 'partially_verified', '3.2.1', 'Erstnennung zur Grundlagenkrise der naiven Mengenbildung, zur Russellschen Antinomie und zur Typentheorie.', 'Russell, Bertrand (1903): The Principles of Mathematics. Cambridge: Cambridge University Press.', 'Russell (1903)', 'Historische Primärquelle zur Logik und zu den Grundlagen der Mathematik.', 10, '2026-07-17 07:17:37', '2026-07-18 06:03:45'),
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
(55, 55, 'tarski_concept_truth_formalized_languages_1956', 'book_chapter', 'The Concept of Truth in Formalized Languages', NULL, 1933, 1956, NULL, 'Clarendon Press', 'Oxford', NULL, NULL, '152–278', NULL, NULL, NULL, NULL, 'en', 1, 'historical', 9, 'verified', '3.1.4', 'Semantische Wahrheitstheorie und Trennung von Objekt- und Metasprache.', 'Tarski, Alfred: The Concept of Truth in Formalized Languages. In: Tarski, Alfred: Logic, Semantics, Metamathematics. Oxford: Clarendon Press, 1956, S. 152–278; polnische Erstveröffentlichung 1933.', 'Tarski (1956) [55]', 'Quelle der erkenntnistheoretischen Grundlegung von Abschnitt 3.1.4.', 5, '2026-07-17 11:19:14', '2026-07-17 11:19:14'),
(56, 56, 'mac_lane_mathematics_form_function_1986', 'book', 'Mathematics: Form and Function', NULL, 1986, 1986, NULL, 'Springer', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 9, 'verified', '3.1.5', 'Erstnennung zur strukturorientierten Auffassung mathematischer Theorien und zur funktionalen Bestimmung mathematischer Objekte.', 'Mac Lane, Saunders: Mathematics: Form and Function. New York: Springer, 1986.', 'Mac Lane (1986) [56]', 'Methodologische Grundlage für die relationale und strukturorientierte Entwicklung des FRZK.', 6, '2026-07-17 15:19:42', '2026-07-17 15:19:42'),
(57, 57, 'eilenberg_mac_lane_natural_equivalences_1945', 'journal_article', 'General Theory of Natural Equivalences', NULL, 1945, 1945, 'Transactions of the American Mathematical Society', NULL, NULL, '58', NULL, '231–294', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.5', 'Erstnennung zur kategorialen Untersuchung strukturerhaltender Abbildungen und natürlicher Äquivalenzen.', 'Eilenberg, Samuel; Mac Lane, Saunders: General Theory of Natural Equivalences. In: Transactions of the American Mathematical Society, Band 58, 1945, S. 231–294.', 'Eilenberg und Mac Lane (1945) [57]', 'Primärquelle zur Entstehung der Kategorientheorie und zum methodischen Vorrang strukturerhaltender Abbildungen.', 6, '2026-07-17 15:19:42', '2026-07-17 15:19:42'),
(58, 58, 'frege_grundlagen_arithmetik_1884', 'book', 'Die Grundlagen der Arithmetik', 'Eine logisch mathematische Untersuchung über den Begriff der Zahl', 1884, 1884, NULL, 'Wilhelm Koebner', 'Breslau', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 9, 'verified', '3.1.6', 'Erstnennung zur logischen und funktionalen Bestimmung mathematischer Begriffe.', 'Frege, Gottlob: Die Grundlagen der Arithmetik. Eine logisch mathematische Untersuchung über den Begriff der Zahl. Breslau: Wilhelm Koebner, 1884.', 'Frege (1884) [58]', 'Grundlagenquelle zur Abkehr von rein anschaulichen Objektvorstellungen.', 7, '2026-07-18 04:49:51', '2026-07-18 04:49:51'),
(59, 59, 'bertalanffy_general_system_theory_1968', 'book', 'General System Theory', 'Foundations, Development, Applications', 1968, 1968, NULL, 'George Braziller', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.6', 'Erstnennung zur Bestimmung von Systemen als organisierte Ganzheiten miteinander wechselwirkender Bestandteile.', 'von Bertalanffy, Ludwig: General System Theory. Foundations, Development, Applications. New York: George Braziller, 1968.', 'von Bertalanffy (1968) [59]', 'Systemtheoretische Grundlage für relationale Organisation und emergente Systemeigenschaften.', 7, '2026-07-18 04:49:51', '2026-07-18 04:49:51'),
(60, 60, 'wiener_cybernetics_1948', 'book', 'Cybernetics or Control and Communication in the Animal and the Machine', NULL, 1948, 1948, NULL, 'Hermann & Cie / MIT Press', 'Paris / Cambridge, MA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.6', 'Erstnennung zu Steuerung, Kommunikation, Rückkopplung und rekursiver funktionaler Organisation.', 'Wiener, Norbert: Cybernetics or Control and Communication in the Animal and the Machine. Paris: Hermann & Cie; Cambridge, MA: MIT Press, 1948.', 'Wiener (1948) [60]', 'Primärquelle zur Kybernetik und zu funktionalen Rückkopplungszusammenhängen.', 7, '2026-07-18 04:49:51', '2026-07-18 04:49:51'),
(61, 61, 'ashby_introduction_cybernetics_1956', 'book', 'An Introduction to Cybernetics', NULL, 1956, 1956, NULL, 'Chapman & Hall', 'London', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 10, 'verified', '3.1.6', 'Erstnennung zur formalen Beschreibung von Zuständen, Zustandsübergängen und Regelungsprozessen.', 'Ashby, W. Ross: An Introduction to Cybernetics. London: Chapman & Hall, 1956.', 'Ashby (1956) [61]', 'Grundlage für die spätere Rekonstruktion funktionaler Zustandsübergänge.', 7, '2026-07-18 04:49:51', '2026-07-18 04:49:51'),
(62, 62, 'resnik_mathematics_science_patterns_1997', 'book', 'Mathematics as a Science of Patterns', NULL, 1997, 1997, NULL, 'Clarendon Press', 'Oxford', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 9, 'verified', '3.1.6', 'Erstnennung zur strukturalistischen Auffassung mathematischer Gegenstände als Positionen in Mustern.', 'Resnik, Michael D.: Mathematics as a Science of Patterns. Oxford: Clarendon Press, 1997.', 'Resnik (1997) [62]', 'Quelle zum mathematischen Strukturalismus.', 7, '2026-07-18 04:49:51', '2026-07-18 04:49:51'),
(63, 63, 'shapiro_philosophy_mathematics_structure_ontology_1997', 'book', 'Philosophy of Mathematics', 'Structure and Ontology', 1997, 1997, NULL, 'Oxford University Press', 'New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'secondary', 9, 'verified', '3.1.6', 'Erstnennung zur Identifikation mathematischer Gegenstände als Stellen innerhalb von Strukturen.', 'Shapiro, Stewart: Philosophy of Mathematics. Structure and Ontology. New York: Oxford University Press, 1997.', 'Shapiro (1997) [63]', 'Quelle zur ontologischen und mathematischen Strukturalismusdebatte.', 7, '2026-07-18 04:49:51', '2026-07-18 04:49:51'),
(64, 64, 'von_foerster_observing_systems_1981', 'book', 'Observing Systems', NULL, 1981, 1981, NULL, 'Intersystems Publications', 'Seaside, CA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.1.6', 'Erstnennung zur Kybernetik zweiter Ordnung und zur Einbeziehung des Beobachters in rekursive Beschreibungszusammenhänge.', 'von Foerster, Heinz: Observing Systems. Seaside, CA: Intersystems Publications, 1981.', 'von Foerster (1981) [64]', 'Grundlage zur Reflexion beobachterabhängiger Unterscheidungs- und Beschreibungsoperationen.', 7, '2026-07-18 04:49:51', '2026-07-18 04:49:51'),
(65, 65, 'luhmann_soziale_systeme_1984', 'book', 'Soziale Systeme', 'Grundriß einer allgemeinen Theorie', 1984, 1984, NULL, 'Suhrkamp', 'Frankfurt am Main', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 8, 'verified', '3.1.6', 'Erstnennung zur rekursiven Anschlussfähigkeit von Operationen und zur funktionalen Stabilisierung von Systemen.', 'Luhmann, Niklas: Soziale Systeme. Grundriß einer allgemeinen Theorie. Frankfurt am Main: Suhrkamp, 1984.', 'Luhmann (1984) [65]', 'Systemtheoretische Vergleichsquelle; keine vollständige Übernahme der Theorie sozialer Systeme.', 7, '2026-07-18 04:49:51', '2026-07-18 04:49:51'),
(66, 66, 'cantor_beitraege_transfinite_mengenlehre_1895_1897', 'journal_article', 'Beiträge zur Begründung der transfiniten Mengenlehre', 'Erster und zweiter Artikel', 1895, 1897, 'Mathematische Annalen', NULL, NULL, '46; 49', NULL, '481–512; 207–246', NULL, NULL, NULL, NULL, 'de', 1, 'primary', 8, 'partially_verified', '3.2.1', 'Erstnennung zur Entwicklung der transfiniten Mengenlehre, zur Mächtigkeit unendlicher Mengen und zu Cantors Satz.', 'Cantor, Georg (1895/1897): Beiträge zur Begründung der transfiniten Mengenlehre. In: Mathematische Annalen 46, S. 481–512, und 49, S. 207–246.', 'Cantor (1895/1897)', 'Historische Primärquelle. Die beiden zusammengehörigen Artikel werden unter einer Literaturziffer geführt.', 10, '2026-07-18 06:03:45', '2026-07-18 06:03:45'),
(67, 68, 'zermelo_grundlagen_mengenlehre_1908', 'journal_article', 'Untersuchungen über die Grundlagen der Mengenlehre I', NULL, 1908, 1908, 'Mathematische Annalen', NULL, NULL, '65', NULL, '261–281', NULL, NULL, NULL, NULL, 'de', 1, 'primary', 9, 'partially_verified', '3.2.1', 'Erstnennung zur axiomatischen Begrenzung der Mengenbildung und zur Vermeidung mengentheoretischer Antinomien.', 'Zermelo, Ernst (1908): Untersuchungen über die Grundlagen der Mengenlehre I. In: Mathematische Annalen 65, S. 261–281.', 'Zermelo (1908)', 'Historische Primärquelle zur axiomatischen Mengenlehre.', 10, '2026-07-18 06:03:45', '2026-07-18 06:03:45'),
(68, 69, 'fraenkel_grundlagen_cantor_zermelo_1922', 'journal_article', 'Zu den Grundlagen der Cantor-Zermeloschen Mengenlehre', NULL, 1922, 1922, 'Mathematische Annalen', NULL, NULL, '86', NULL, '230–237', NULL, NULL, NULL, NULL, 'de', 1, 'primary', 8, 'partially_verified', '3.2.1', 'Erstnennung zur Weiterentwicklung des Zermeloschen Axiomensystems und zum Ersetzungsprinzip.', 'Fraenkel, Abraham A. (1922): Zu den Grundlagen der Cantor-Zermeloschen Mengenlehre. In: Mathematische Annalen 86, S. 230–237.', 'Fraenkel (1922)', 'Historische Primärquelle zur Weiterentwicklung der axiomatischen Mengenlehre.', 10, '2026-07-18 06:03:45', '2026-07-18 06:03:45'),
(69, 70, 'skolem_axiomatische_mengenlehre_1923', 'conference_paper', 'Einige Bemerkungen zur axiomatischen Begründung der Mengenlehre', NULL, 1922, 1923, NULL, NULL, 'Helsinki', NULL, NULL, '217–232', NULL, NULL, NULL, NULL, 'de', 1, 'primary', 8, 'partially_verified', '3.2.1', 'Erstnennung zur Formalisierung der Mengenlehre in einer Sprache erster Stufe.', 'Skolem, Thoralf (1923): Einige Bemerkungen zur axiomatischen Begründung der Mengenlehre. In: Matematikerkongressen i Helsingfors den 4–7 Juli 1922. Den femte skandinaviska matematikerkongressen, S. 217–232.', 'Skolem (1923)', 'Kongressbeitrag von 1922, veröffentlicht 1923.', 10, '2026-07-18 06:03:45', '2026-07-18 06:03:45'),
(70, 71, 'kuratowski_ordre_theorie_ensembles_1921', 'journal_article', 'Sur la notion de l’ordre dans la théorie des ensembles', NULL, 1921, 1921, 'Fundamenta Mathematicae', NULL, NULL, '2', NULL, '161–171', NULL, NULL, NULL, NULL, 'fr', 1, 'primary', 8, 'partially_verified', '3.2.1', 'Erstnennung zur rein mengentheoretischen Konstruktion geordneter Paare.', 'Kuratowski, Kazimierz (1921): Sur la notion de l’ordre dans la théorie des ensembles. In: Fundamenta Mathematicae 2, S. 161–171.', 'Kuratowski (1921)', 'Historische Primärquelle zur mengentheoretischen Darstellung geordneter Paare.', 10, '2026-07-18 06:03:45', '2026-07-18 06:03:45'),
(71, 72, 'bourbaki_theory_sets_2004', 'book', 'Theory of Sets', 'Elements of Mathematics', 1954, 2004, NULL, 'Springer', 'Berlin, Heidelberg', NULL, NULL, NULL, 'English edition', NULL, NULL, NULL, 'en', 2, 'reference', 8, 'partially_verified', '3.2.1', 'Erstnennung zur strukturalen Darstellung mathematischer Theorien auf mengentheoretischen Grundmengen.', 'Bourbaki, Nicolas (2004): Theory of Sets. Berlin, Heidelberg: Springer. Französische Originalausgabe: Théorie des ensembles. Paris: Hermann, 1954–1957.', 'Bourbaki (2004)', 'Referenzwerk zur mengentheoretischen und strukturalen Grundlegung.', 10, '2026-07-18 06:03:45', '2026-07-18 06:03:45'),
(73, 73, 'peirce_logic_relatives_1870', 'journal_article', 'Description of a Notation for the Logic of Relatives, Resulting from an Amplification of the Conceptions of Boole’s Calculus of Logic', NULL, 1870, 1870, 'Memoirs of the American Academy of Arts and Sciences', NULL, NULL, '9', NULL, '317–378', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 8, 'partially_verified', '3.2.2', 'Erstnennung in Abschnitt 3.2.2.', 'Peirce, Charles Sanders (1870): Description of a Notation for the Logic of Relatives, Resulting from an Amplification of the Conceptions of Boole’s Calculus of Logic. In: Memoirs of the American Academy of Arts and Sciences, New Series 9, S. 317–378.', 'Peirce (1870)', 'Historische Primärquelle zur Erweiterung der Booleschen Logik um einen Kalkül mehrstelliger Relationen.', 11, '2026-07-18 06:16:56', '2026-07-18 06:16:56'),
(74, 74, 'schroeder_algebra_logik_relative_1895', 'book', 'Vorlesungen über die Algebra der Logik (Exakte Logik)', NULL, 1895, 1895, NULL, 'B. G. Teubner', 'Leipzig', '3', NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 8, 'partially_verified', '3.2.2', 'Erstnennung in Abschnitt 3.2.2.', 'Schröder, Ernst (1895): Vorlesungen über die Algebra der Logik (Exakte Logik). Band 3: Algebra und Logik der Relative. Leipzig: B. G. Teubner.', 'Schröder (1895)', 'Historische Primärquelle zur algebraischen Behandlung von Relationen.', 11, '2026-07-18 06:16:56', '2026-07-18 06:16:56'),
(75, 75, 'tarski_calculus_relations_1941', 'journal_article', 'On the Calculus of Relations', NULL, 1941, 1941, 'The Journal of Symbolic Logic', NULL, NULL, '6', '3', '73–89', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 8, 'partially_verified', '3.2.2', 'Erstnennung in Abschnitt 3.2.2.', 'Tarski, Alfred (1941): On the Calculus of Relations. In: The Journal of Symbolic Logic 6(3), S. 73–89.', 'Tarski (1941)', 'Primärquelle zur modernen axiomatischen und algebraischen Fassung des Relationskalküls.', 11, '2026-07-18 06:16:56', '2026-07-18 06:16:56'),
(76, 76, 'noether_abstrakter_aufbau_idealtheorie_1927', 'journal_article', 'Abstrakter Aufbau der Idealtheorie in algebraischen Zahl- und Funktionenkörpern', NULL, 1927, 1927, 'Mathematische Annalen', NULL, NULL, '96', NULL, '26–61', NULL, NULL, NULL, NULL, 'de', 1, 'primary', 8, 'partially_verified', '3.2.3', 'Erstnennung zur strukturellen und axiomatischen Entwicklung der modernen Algebra.', 'Noether, Emmy (1927): Abstrakter Aufbau der Idealtheorie in algebraischen Zahl- und Funktionenkörpern. In: Mathematische Annalen 96, S. 26–61.', 'Noether (1927)', 'Historische Primärquelle zur strukturellen Algebra und Idealtheorie.', 12, '2026-07-18 06:51:13', '2026-07-18 06:51:13'),
(77, 77, 'van_der_waerden_moderne_algebra_1930_1931', 'book', 'Moderne Algebra', NULL, 1930, 1931, NULL, 'Springer', 'Berlin', '1–2', NULL, NULL, 'Erstausgabe', NULL, NULL, NULL, 'de', 1, 'primary', 8, 'partially_verified', '3.2.3', 'Erstnennung zur systematischen axiomatischen Darstellung algebraischer Strukturen.', 'van der Waerden, Bartel Leendert (1930–1931): Moderne Algebra. Band 1 und 2. Berlin: Springer.', 'van der Waerden (1930–1931)', 'Grundlegendes Werk zur modernen abstrakten Algebra.', 12, '2026-07-18 06:51:13', '2026-07-18 06:51:13'),
(78, 78, 'galois_oeuvres_mathematiques_1846', 'book', 'Œuvres Mathématiques', NULL, 1832, 1846, NULL, NULL, 'Paris', NULL, NULL, NULL, 'Posthume Veröffentlichung', NULL, NULL, NULL, 'fr', 1, 'primary', 7, 'partially_verified', '3.2.3', 'Erstnennung zur historischen Entstehung der Gruppentheorie aus der Untersuchung algebraischer Gleichungen.', 'Galois, Évariste (1846): Œuvres Mathématiques. Posthum veröffentlicht.', 'Galois (1846)', 'Historische Primärquelle zur Entstehung der Gruppentheorie.', 12, '2026-07-18 06:51:13', '2026-07-18 06:51:13'),
(79, 79, 'euler_solutio_geometriam_situs_1741', 'journal_article', 'Solutio problematis ad geometriam situs pertinentis', NULL, 1736, 1741, 'Commentarii Academiae Scientiarum Imperialis Petropolitanae', NULL, 'Petropoli', '8', NULL, '128–140', NULL, NULL, NULL, NULL, 'la', 1, 'primary', 9, 'verified', '3.2.4', 'Erstnennung zur historischen Entstehung der Graphentheorie.', 'Euler, Leonhard (1741): Solutio problematis ad geometriam situs pertinentis. In: Commentarii Academiae Scientiarum Imperialis Petropolitanae 8, S. 128–140.', 'Euler (1741)', 'Historische Primärquelle zur frühen Graphentheorie.', 13, '2026-07-18 07:43:11', '2026-07-18 07:43:11'),
(80, 80, 'diestel_graph_theory_2017', 'book', 'Graph Theory', NULL, 1997, 2017, NULL, 'Springer', 'Berlin/Heidelberg', NULL, NULL, NULL, '5. Auflage', NULL, NULL, NULL, 'en', 1, 'secondary', 10, 'verified', '3.2.4', 'Erstnennung zur modernen Graphentheorie.', 'Diestel, Reinhard (2017): Graph Theory. 5. Auflage. Berlin/Heidelberg: Springer.', 'Diestel (2017)', 'Standardwerk der modernen Graphentheorie.', 13, '2026-07-18 07:43:11', '2026-07-18 07:43:11');
INSERT INTO `sources` (`source_id`, `citation_number`, `source_key`, `source_type`, `title`, `subtitle`, `year_original`, `year_edition`, `journal`, `publisher`, `place`, `volume`, `issue`, `pages`, `edition`, `doi`, `isbn`, `url`, `language_code`, `priority`, `evidence_type`, `frzk_relevance`, `verification_status`, `first_citation_section_code`, `first_citation_note`, `full_citation_text`, `short_citation_text`, `notes`, `created_revision_id`, `created_at`, `updated_at`) VALUES
(81, 81, 'newman_networks_2018', 'book', 'Networks', NULL, 2010, 2018, NULL, 'Oxford University Press', 'Oxford', NULL, NULL, NULL, '2. Auflage', NULL, NULL, NULL, 'en', 1, 'secondary', 10, 'verified', '3.2.4', 'Erstnennung zur Netzwerkwissenschaft.', 'Newman, Mark (2018): Networks. 2. Auflage. Oxford: Oxford University Press.', 'Newman (2018)', 'Grundlegendes Werk zu komplexen Netzwerken und Netzwerkmaßen.', 13, '2026-07-18 07:43:11', '2026-07-18 07:43:11'),
(82, 82, 'barabasi_network_science_2016', 'book', 'Network Science', NULL, 2016, 2016, NULL, 'Cambridge University Press', 'Cambridge', NULL, NULL, NULL, '1. Auflage', NULL, NULL, NULL, 'en', 1, 'secondary', 10, 'verified', '3.2.4', 'Erstnennung zu Gradverteilungen und skalenfreien Netzwerken.', 'Barabási, Albert-László (2016): Network Science. Cambridge: Cambridge University Press.', 'Barabási (2016)', 'Grundlegendes Werk zu komplexen Netzwerken.', 13, '2026-07-18 07:43:11', '2026-07-18 07:43:11'),
(83, 83, 'euler_introductio_analysin_infinitorum_1748', 'historical_work', 'Introductio in analysin infinitorum', NULL, 1748, 1748, NULL, 'Marc-Michel Bousquet', 'Lausanne', NULL, NULL, NULL, 'Erstausgabe', NULL, NULL, NULL, 'la', 1, 'historical', 8, 'verified', '3.2.5', 'Erstnennung zur historischen Entwicklung des Funktionsbegriffs.', 'Euler, Leonhard (1748): Introductio in analysin infinitorum. Lausanne: Marc-Michel Bousquet.', 'Euler (1748)', 'Historische Primärquelle zum frühen analytischen Funktionsbegriff.', 14, '2026-07-18 08:59:33', '2026-07-18 08:59:33'),
(84, 84, 'dirichlet_darstellung_willkuerlicher_funktionen_1829', 'historical_work', 'Über die Darstellung ganz willkürlicher Funktionen durch Sinus- und Cosinusreihen', NULL, 1829, 1829, NULL, NULL, 'Berlin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'historical', 9, 'partially_verified', '3.2.5', 'Erstnennung zur Loslösung des Funktionsbegriffs von einer konkreten analytischen Formel.', 'Dirichlet, Peter Gustav Lejeune (1829): Über die Darstellung ganz willkürlicher Funktionen durch Sinus- und Cosinusreihen. Berlin.', 'Dirichlet (1829)', 'Historische Primärquelle zum allgemeinen Zuordnungsbegriff.', 14, '2026-07-18 08:59:33', '2026-07-18 08:59:33'),
(91, 85, 'grassmann_lineale_ausdehnungslehre_1844', 'book', 'Die lineale Ausdehnungslehre', 'Ein neuer Zweig der Mathematik', 1844, 1844, NULL, 'Otto Wigand', 'Leipzig', NULL, NULL, NULL, 'Erstausgabe', NULL, NULL, NULL, 'de', 1, 'historical', 9, 'verified', '3.2.6', 'Erstnennung zur historischen Entwicklung einer allgemeinen Algebra gerichteter Größen.', 'Grassmann, Hermann (1844): Die lineale Ausdehnungslehre. Ein neuer Zweig der Mathematik. Leipzig: Otto Wigand.', 'Grassmann (1844)', 'Historische Primärquelle zur Entwicklung des abstrakten Vektorbegriffs.', 17, '2026-07-18 11:15:45', '2026-07-18 11:15:45'),
(92, 86, 'peano_calcolo_geometrico_1888', 'book', 'Calcolo geometrico', 'Secondo l\'Ausdehnungslehre di H. Grassmann preceduto dalle operazioni della logica deduttiva', 1888, 1888, NULL, 'Fratelli Bocca', 'Turin', NULL, NULL, NULL, 'Erstausgabe', NULL, NULL, NULL, 'it', 1, 'historical', 9, 'verified', '3.2.6', 'Erstnennung zur axiomatischen und symbolischen Formulierung linearer Räume.', 'Peano, Giuseppe (1888): Calcolo geometrico secondo l\'Ausdehnungslehre di H. Grassmann preceduto dalle operazioni della logica deduttiva. Turin: Fratelli Bocca.', 'Peano (1888)', 'Historische Primärquelle zur Axiomatisierung geometrischer und linearer Strukturen.', 17, '2026-07-18 11:15:45', '2026-07-18 11:15:45'),
(93, 87, 'bourbaki_algebre_1947', 'book', 'Algèbre', NULL, 1947, 1947, NULL, 'Hermann', 'Paris', NULL, NULL, NULL, 'Erstausgabe', NULL, NULL, NULL, 'fr', 1, '', 10, 'verified', '3.2.6', 'Erstnennung als moderne systematische Darstellung algebraischer und linearer Strukturen.', 'Bourbaki, Nicolas (1947): Algèbre. Paris: Hermann.', 'Bourbaki (1947)', 'Grundlagenquelle für die moderne abstrakte Definition von Vektorräumen.', 17, '2026-07-18 11:15:45', '2026-07-18 11:15:45'),
(94, 88, 'sylvester_additions_matrix_1850', 'journal_article', 'Additions to the Articles in the September Number of This Journal, \'On a New Class of Theorems,\' and on Pascal\'s Theorem', NULL, 1850, 1850, 'The London, Edinburgh, and Dublin Philosophical Magazine and Journal of Science', NULL, NULL, '37', NULL, '363-370', NULL, NULL, NULL, NULL, 'en', 1, 'primary', 8, 'verified', '3.2.7', 'Historische Erstnennung des Matrixbegriffs.', 'Sylvester, James Joseph (1850): Additions to the Articles in the September Number of This Journal, \'On a New Class of Theorems,\' and on Pascal\'s Theorem. In: The London, Edinburgh, and Dublin Philosophical Magazine and Journal of Science, Series 3, Band 37, S. 363-370.', 'Sylvester (1850)', 'Historische Primärquelle zur Entstehung des Matrixbegriffs.', 18, '2026-07-18 11:39:48', '2026-07-18 11:39:48'),
(95, 89, 'cayley_memoir_matrices_1858', 'journal_article', 'A Memoir on the Theory of Matrices', NULL, 1858, 1858, 'Philosophical Transactions of the Royal Society of London', NULL, NULL, '148', NULL, '17-37', NULL, '10.1098/rstl.1858.0002', NULL, NULL, 'en', 1, 'primary', 9, 'verified', '3.2.7', 'Historische Entwicklung einer eigenständigen Matrizentheorie.', 'Cayley, Arthur (1858): A Memoir on the Theory of Matrices. In: Philosophical Transactions of the Royal Society of London, Band 148, S. 17-37.', 'Cayley (1858)', 'Historische Primärquelle zur Theorie der Matrizen.', 18, '2026-07-18 11:39:48', '2026-07-18 11:39:48'),
(96, 90, 'halmos_finite_dimensional_vector_spaces_1942', 'book', 'Finite-Dimensional Vector Spaces', NULL, 1942, 1942, NULL, 'Princeton University Press', 'Princeton', NULL, NULL, NULL, 'First edition', NULL, NULL, NULL, 'en', 1, 'reference', 10, 'verified', '3.2.7', 'Systematische Grundlage für endlichdimensionale Vektorräume und lineare Transformationen.', 'Halmos, Paul Richard (1942): Finite-Dimensional Vector Spaces. Princeton: Princeton University Press.', 'Halmos (1942)', 'Grundlagenquelle für lineare Abbildungen, Kern, Bild, Rang und Operatoren.', 18, '2026-07-18 11:39:48', '2026-07-18 11:39:48');

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
(55, 74, 1, 'author'),
(56, 75, 1, 'author'),
(57, 76, 1, 'author'),
(57, 75, 2, 'author'),
(58, 77, 1, 'author'),
(59, 78, 1, 'author'),
(60, 79, 1, 'author'),
(61, 80, 1, 'author'),
(62, 81, 1, 'author'),
(63, 82, 1, 'author'),
(64, 83, 1, 'author'),
(65, 84, 1, 'author'),
(66, 85, 1, 'author'),
(67, 86, 1, 'author'),
(68, 87, 1, 'author'),
(69, 88, 1, 'author'),
(70, 89, 1, 'author'),
(71, 90, 1, 'author'),
(73, 91, 1, 'author'),
(74, 92, 1, 'author'),
(75, 74, 1, 'author'),
(76, 94, 1, 'author'),
(77, 95, 1, 'author'),
(78, 96, 1, 'author'),
(79, 97, 1, 'author'),
(80, 98, 1, 'author'),
(81, 99, 1, 'author'),
(82, 100, 1, 'author'),
(83, 97, 1, 'author'),
(84, 101, 1, 'author'),
(91, 106, 1, 'author'),
(92, 107, 1, 'author'),
(93, 90, 1, 'author'),
(94, 108, 1, 'author'),
(95, 109, 1, 'author'),
(96, 110, 1, 'author');

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
(62, 55, 7, 'first_citation', 'Semantische Wahrheitstheorie und Trennung von Objekt- und Metasprache.', 'Abschnitt 3.1.4', 1, 1, 'Erstnennung als Quelle [55].', 5),
(63, 56, 8, 'first_citation', 'Mathematische Theorien werden methodisch durch Formen, Funktionen und Beziehungen zwischen Objekten bestimmt; dies stützt die strukturorientierte Identifikation funktionaler Zustände.', 'Abschnitt 3.1.5', 1, 1, 'Erstnennung als Quelle [56].', 6),
(64, 57, 8, 'first_citation', 'Strukturerhaltende Abbildungen und natürliche Äquivalenzen bilden eine methodische Grundlage für die Untersuchung von Transformationen, ohne das FRZK selbst kategorial zu definieren.', 'Abschnitt 3.1.5', 1, 1, 'Erstnennung als Quelle [57].', 6),
(65, 18, 9, 'background', 'Übergang vom Substanzbegriff zur funktionalen und relationalen Bestimmung wissenschaftlicher Gegenstände.', 'Abschnitt 3.1.6', 0, 1, 'Wiederverwendung von Cassirer [18].', 7),
(66, 16, 9, 'background', 'Prozessontologischer Vorrang von Ereignissen, Relationen und Werden gegenüber dauerhaft vorausgesetzten Substanzen.', 'Abschnitt 3.1.6', 0, 1, 'Wiederverwendung von Whitehead [16].', 7),
(67, 57, 9, 'method', 'Strukturerhaltende Abbildungen und natürliche Äquivalenzen als Orientierung für transformationsbezogene mathematische Beschreibungen.', 'Abschnitt 3.1.6', 0, 1, 'Wiederverwendung von Eilenberg und Mac Lane [57].', 7),
(68, 56, 9, 'method', 'Mathematik als Untersuchung von Formen, Funktionen, Beziehungen und Transformationen.', 'Abschnitt 3.1.6', 0, 1, 'Wiederverwendung von Mac Lane [56].', 7),
(69, 58, 9, 'first_citation', 'Logische und funktionale Bestimmung mathematischer Begriffe ohne notwendige Rückführung auf anschauliche Objekte.', 'Abschnitt 3.1.6', 1, 1, 'Erstnennung als Quelle [58].', 7),
(70, 59, 9, 'first_citation', 'Systeme als organisierte Ganzheiten, deren Eigenschaften durch Wechselwirkungen und Beziehungsorganisation mitbestimmt werden.', 'Abschnitt 3.1.6', 1, 1, 'Erstnennung als Quelle [59].', 7),
(71, 60, 9, 'first_citation', 'Steuerung, Kommunikation und Rückkopplung als rekursive funktionale Organisationsprinzipien.', 'Abschnitt 3.1.6', 1, 1, 'Erstnennung als Quelle [60].', 7),
(72, 61, 9, 'first_citation', 'Beschreibung von Systementwicklung durch Zustände, Zustandsübergänge und Regelungsprozesse.', 'Abschnitt 3.1.6', 1, 1, 'Erstnennung als Quelle [61].', 7),
(73, 62, 9, 'first_citation', 'Mathematische Gegenstände werden durch Positionen innerhalb von Mustern und Strukturen bestimmt.', 'Abschnitt 3.1.6', 1, 1, 'Erstnennung als Quelle [62].', 7),
(74, 63, 9, 'first_citation', 'Mathematische Objekte als Stellen in Strukturen, deren Identität relational festgelegt ist.', 'Abschnitt 3.1.6', 1, 1, 'Erstnennung als Quelle [63].', 7),
(75, 64, 9, 'first_citation', 'Beobachter und beschreibende Systeme als Bestandteile rekursiver Beobachtungs- und Rückkopplungszusammenhänge.', 'Abschnitt 3.1.6', 1, 1, 'Erstnennung als Quelle [64].', 7),
(76, 65, 9, 'first_citation', 'Systemstabilität durch rekursive Anschlussfähigkeit von Operationen statt allein durch dauerhafte materielle Bestandteile.', 'Abschnitt 3.1.6', 1, 1, 'Erstnennung als Quelle [65].', 7),
(77, 1, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(78, 2, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(79, 3, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(80, 5, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(81, 16, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(82, 18, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(83, 56, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(84, 57, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(85, 58, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(86, 59, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(87, 60, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(88, 61, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(89, 62, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(90, 63, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(91, 64, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(92, 65, 10, 'background', 'Wiederverwendung im Forschungsstand.', 'Abschnitt 3.1.7', 0, 1, 'Bereits vorhandene Quelle.', 8),
(108, 66, 13, 'first_citation', 'Entwicklung der transfiniten Mengenlehre, Unterscheidung unendlicher Mächtigkeiten und Grundlage von Cantors Satz.', 'Abschnitt 3.2.1: historische Entwicklung und Cantors Satz', 1, 1, 'Erstnennung als Quelle [66].', 10),
(109, 15, 13, 'first_citation', 'Grundlagenkrise der uneingeschränkten Mengenbildung, Russellsche Antinomie und typentheoretische Reaktion.', 'Abschnitt 3.2.1: Übergang von naiver zu axiomatischer Mengenlehre', 1, 1, 'Erstnennung als Quelle [67].', 10),
(110, 67, 13, 'first_citation', 'Axiomatische Begrenzung der Mengenbildung und systematische Vermeidung der bekannten Antinomien.', 'Abschnitt 3.2.1: Zermelos Axiomatisierung', 1, 1, 'Erstnennung als Quelle [68].', 10),
(111, 68, 13, 'first_citation', 'Weiterentwicklung des Zermeloschen Systems und Präzisierung des Ersetzungsprinzips.', 'Abschnitt 3.2.1: Entwicklung zur Zermelo-Fraenkel-Mengenlehre', 1, 1, 'Erstnennung als Quelle [69].', 10),
(112, 69, 13, 'first_citation', 'Einordnung der axiomatischen Mengenlehre in eine formale Sprache erster Stufe.', 'Abschnitt 3.2.1: Formalisierung der Mengenlehre', 1, 1, 'Erstnennung als Quelle [70].', 10),
(113, 70, 13, 'first_citation', 'Mengentheoretische Konstruktion des geordneten Paares als Grundlage kartesischer Produkte und Relationen.', 'Abschnitt 3.2.1: geordnetes Paar und kartesisches Produkt', 1, 1, 'Erstnennung als Quelle [71].', 10),
(114, 71, 13, 'first_citation', 'Strukturale Darstellung mathematischer Theorien auf mengentheoretischen Grundmengen.', 'Abschnitt 3.2.1: Mengen als Träger weiterführender mathematischer Strukturen', 1, 1, 'Erstnennung als Quelle [72].', 10),
(115, 73, 14, 'first_citation', 'Historische Entwicklung eines Kalküls relativer Terme und mehrstelliger Relationen.', 'Historische Entwicklung der Relationslogik', 1, 1, 'Erstnennung als Quelle [73].', 11),
(116, 74, 14, 'first_citation', 'Algebraische Behandlung von Relationen und Übergang zu operativen Relationskalkülen.', 'Historische Entwicklung und Matrixdarstellung', 1, 1, 'Erstnennung als Quelle [74].', 11),
(117, 75, 14, 'first_citation', 'Moderne axiomatische und algebraische Fassung des Relationskalküls einschließlich Umkehrung und Komposition.', 'Definitionen, Relationseigenschaften und Komposition', 1, 1, 'Erstnennung als Quelle [75].', 11),
(118, 71, 14, 'background', 'Mengentheoretische Definition von Relationen, Äquivalenzstrukturen, Quotientenmengen und Ordnungen.', 'Grundbegriffe und strukturelle Einordnung', 0, 1, 'Wiederverwendung der Quelle [72].', 11),
(119, 76, 15, 'first_citation', 'Strukturelle und axiomatische Neuorientierung der Algebra durch Emmy Noether.', 'Abschnitt 3.2.3: historische Entwicklung der modernen Algebra', 1, 1, 'Erstnennung als Quelle [76].', 12),
(120, 77, 15, 'first_citation', 'Systematische axiomatische Darstellung von Gruppen, Ringen und Körpern.', 'Abschnitt 3.2.3: abstrakte algebraische Strukturen', 1, 1, 'Erstnennung als Quelle [77].', 12),
(121, 78, 15, 'first_citation', 'Historische Entstehung des Gruppenbegriffs aus der Theorie algebraischer Gleichungen.', 'Abschnitt 3.2.3: Gruppenbegriff und historische Einordnung', 1, 1, 'Erstnennung als Quelle [78].', 12),
(122, 71, 15, 'background', 'Mengentheoretische und strukturelle Grundlegung algebraischer Verknüpfungen und Strukturen.', 'Abschnitt 3.2.3: Definitionen und strukturelle Einordnung', 0, 1, 'Wiederverwendung der Quelle [72].', 12),
(123, 79, 16, 'first_citation', 'Historische Entstehung der Graphentheorie am Königsberger Brückenproblem.', 'Historische Einleitung', 1, 1, 'Erstnennung als Quelle [79].', 13),
(124, 80, 16, 'first_citation', 'Definitionen und Sätze der modernen Graphentheorie.', 'Graphentheoretische Grundbegriffe', 1, 1, 'Erstnennung als Quelle [80].', 13),
(125, 81, 16, 'first_citation', 'Statistische Beschreibung komplexer Netzwerke und Netzwerkmaße.', 'Netzwerkwissenschaft', 1, 1, 'Erstnennung als Quelle [81].', 13),
(126, 82, 16, 'first_citation', 'Gradverteilungen und skalenfreie Netzwerkstrukturen.', 'Gradverteilung', 1, 1, 'Erstnennung als Quelle [82].', 13),
(127, 71, 16, 'background', 'Mengentheoretische Darstellung von Knoten- und Kantenmengen.', 'Grunddefinitionen', 0, 1, 'Wiederverwendung der Quelle [72].', 13),
(128, 75, 16, 'background', 'Verbindung gerichteter Graphen mit binären Relationen.', 'Gerichtete Graphen', 0, 1, 'Wiederverwendung der Quelle [75].', 13),
(129, 83, 17, 'first_citation', 'Historische Einordnung des frühen analytischen Funktionsbegriffs.', 'Abschnitt 3.2.5, historische Einführung', 1, 1, 'Erstnennung als Quelle [83].', 14),
(130, 84, 17, 'first_citation', 'Historische Verallgemeinerung des Funktionsbegriffs zu einer eindeutigen Zuordnung.', 'Abschnitt 3.2.5, historische Einführung', 1, 1, 'Erstnennung als Quelle [84].', 14),
(131, 71, 17, 'definition', 'Mengentheoretische Definition von Funktionen als eindeutige Relationen zwischen Mengen.', 'Abschnitt 3.2.5, Definitionen 3.2.32 bis 3.2.38', 0, 1, 'Wiederverwendung der Quelle [72].', 14),
(138, 91, 18, 'first_citation', 'Historische Einführung einer allgemeinen Algebra gerichteter Größen.', 'Abschnitt 3.2.6, historische Einführung', 1, 1, 'Erstnennung als Quelle [85].', 17),
(139, 92, 18, 'first_citation', 'Historische Einordnung der axiomatischen Formulierung linearer Räume.', 'Abschnitt 3.2.6, historische Einführung', 1, 1, 'Erstnennung als Quelle [86].', 17),
(140, 93, 18, 'first_citation', 'Moderne systematische Definition von Vektorräumen, Basen und Dimensionen.', 'Abschnitt 3.2.6, Definitionen 3.2.39 bis 3.2.44', 1, 1, 'Erstnennung als Quelle [87].', 17),
(141, 94, 19, 'first_citation', 'Historische Einführung des Begriffs Matrix.', 'Abschnitt 3.2.7, historische Einleitung', 1, 1, 'Erstnennung als Quelle [88].', 18),
(142, 95, 19, 'first_citation', 'Historische Entwicklung der Matrizentheorie und Matrixmultiplikation.', 'Abschnitt 3.2.7, historische Einleitung', 1, 1, 'Erstnennung als Quelle [89].', 18),
(143, 96, 19, 'first_citation', 'Systematische Behandlung linearer Transformationen in endlichdimensionalen Vektorräumen.', 'Abschnitt 3.2.7, Definitionen und Sätze', 1, 1, 'Erstnennung als Quelle [90].', 18);

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
(1, '3.2.1', 13, 'Cantors Satz', 'Für keine Menge M existiert eine surjektive Abbildung von M auf ihre Potenzmenge P(M). Folglich besitzt P(M) eine strikt größere Mächtigkeit als M.', '\nexists f:M	omathcal{P}(M)	ext{ surjektiv};qquad |M|<|mathcal{P}(M)|', '\nexists f:M	omathcal{P}(M)	ext{ surjektiv};qquad |M|<|mathcal{P}(M)|', 'literature', 66, 'Es gelten die üblichen Begriffe von Abbildung, Surjektivität, Teilmenge und Mächtigkeit.', 'checked', 10),
(2, '3.2.2', 14, 'Äquivalenzrelationen und Partitionen', 'Jede Äquivalenzrelation auf einer Menge M erzeugt eine Partition von M. Umgekehrt bestimmt jede Partition von M eine Äquivalenzrelation.', 'sim;longleftrightarrow;mathcal{C}', 'sim;longleftrightarrow;mathcal{C}', 'adapted', 71, 'Die Begriffe Äquivalenzrelation, Äquivalenzklasse und Partition sind definiert.', 'checked', 11),
(3, '3.2.3', 14, 'Assoziativität der relationalen Komposition', 'Für Relationen R⊆A×B, S⊆B×C und T⊆C×D gilt T∘(S∘R)=(T∘S)∘R.', 'Tcirc(Scirc R)=(Tcirc S)circ R', 'Tcirc(Scirc R)=(Tcirc S)circ R', 'literature', 75, 'Die beteiligten Relationen besitzen kompatible Definitions- und Zielmengen.', 'checked', 11),
(4, '3.2.4', 16, 'Handschlaglemma', 'Für jeden endlichen ungerichteten Graphen ist die Summe aller Knotengrade gleich dem Doppelten der Kantenzahl.', '\\sum_{v\\in V}\\deg(v)=2|E|', '\\sum_{v\\in V}\\deg(v)=2|E|', 'literature', 80, 'G ist endlich und ungerichtet.', 'checked', 13),
(5, '3.2.5', 16, 'Eindeutigkeit der Pfade in einem Baum', 'In einem Baum existiert zwischen je zwei verschiedenen Knoten genau ein Pfad.', '\\forall u,v\\in V,\\;u\\neq v:\\;\\exists!\\,P_{uv}', '\\forall u,v\\in V,\\;u\\neq v:\\;\\exists!\\,P_{uv}', 'literature', 80, 'T=(V,E) ist ein Baum.', 'checked', 13),
(6, '3.2.6', 17, 'Existenz der Umkehrfunktion', 'Eine Funktion besitzt genau dann eine Umkehrfunktion, wenn sie bijektiv ist.', 'f^{-1}	ext{ existiert}Longleftrightarrow f	ext{ ist bijektiv}', 'f^{-1}	ext{ existiert}Longleftrightarrow f	ext{ ist bijektiv}', 'literature', 71, 'f:A→B ist eine Funktion.', 'checked', 14),
(7, '3.2.7', 17, 'Assoziativität der Funktionskomposition', 'Für kompatibel definierte Funktionen f, g und h gilt h∘(g∘f)=(h∘g)∘f.', 'hcirc(gcirc f)=(hcirc g)circ f', 'hcirc(gcirc f)=(hcirc g)circ f', 'literature', 71, 'f:A→B, g:B→C und h:C→D sind Funktionen.', 'checked', 14),
(12, '3.2.8', 18, 'Eindeutigkeit des Nullvektors', 'In jedem Vektorraum existiert genau ein additives neutrales Element.', 'exists!,0in V;forall vin V:v+0=v', 'exists!,0in V;forall vin V:v+0=v', 'literature', 93, 'V ist ein Vektorraum.', 'checked', 17),
(13, '3.2.9', 18, 'Eindeutigkeit des inversen Vektors', 'Zu jedem Vektor eines Vektorraums existiert genau ein additives Inverses.', 'forall vin V;exists!,(-v)in V:v+(-v)=0', 'forall vin V;exists!,(-v)in V:v+(-v)=0', 'literature', 93, 'V ist ein Vektorraum.', 'checked', 17),
(14, '3.2.10', 19, 'Erhaltung des Nullvektors', 'Jede lineare Abbildung bildet den Nullvektor des Ausgangsraums auf den Nullvektor des Zielraums ab.', 'T(0_V)=0_W', 'T(0_V)=0_W', 'literature', 96, 'T:V→W ist linear.', 'checked', 18),
(15, '3.2.11', 19, 'Kern und Bild als Untervektorräume', 'Der Kern einer linearen Abbildung ist ein Untervektorraum des Ausgangsraums, und ihr Bild ist ein Untervektorraum des Zielraums.', 'ker(T)leq V,quadoperatorname{im}(T)leq W', 'ker(T)leq V,quadoperatorname{im}(T)leq W', 'literature', 96, 'T:V→W ist linear.', 'checked', 18),
(16, '3.2.12', 19, 'Dimensionssatz', 'Für eine lineare Abbildung mit endlichdimensionalem Ausgangsraum ist dessen Dimension gleich der Summe aus Rang und Nullität.', 'dim(V)=operatorname{rang}(T)+operatorname{null}(T)', 'dim(V)=operatorname{rang}(T)+operatorname{null}(T)', 'literature', 96, 'V ist endlichdimensional und T:V→W linear.', 'checked', 18),
(17, '3.2.13', 19, 'Charakterisierung der Invertierbarkeit', 'Für einen linearen Operator auf einem endlichdimensionalen Vektorraum sind Invertierbarkeit, trivialer Kern, Surjektivität und voller Rang äquivalent.', 'T	ext{ invertierbar}Longleftrightarrowker(T)={0}Longleftrightarrowoperatorname{im}(T)=VLongleftrightarrowoperatorname{rang}(T)=dim(V)', 'T	ext{ invertierbar}Longleftrightarrowker(T)={0}Longleftrightarrowoperatorname{im}(T)=VLongleftrightarrowoperatorname{rang}(T)=dim(V)', 'literature', 96, 'T:V→V ist linear und V endlichdimensional.', 'checked', 18);

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
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

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
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT für Tabelle `dissertation_sections`
--
ALTER TABLE `dissertation_sections`
  MODIFY `section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

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
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;

--
-- AUTO_INCREMENT für Tabelle `equation_dependencies`
--
ALTER TABLE `equation_dependencies`
  MODIFY `dependency_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `equation_symbols`
--
ALTER TABLE `equation_symbols`
  MODIFY `equation_symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

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
  MODIFY `proof_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT für Tabelle `symbols`
--
ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `theorems`
--
ALTER TABLE `theorems`
  MODIFY `theorem_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
