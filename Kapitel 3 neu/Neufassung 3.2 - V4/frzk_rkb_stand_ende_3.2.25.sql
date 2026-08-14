-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 14. Aug 2026 um 20:41
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
(1, 'Newton', 'Isaac', 'isaac newton', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(2, 'Einstein', 'Albert', 'albert einstein', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(3, 'Rovelli', 'Carlo', 'carlo rovelli', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(4, 'Parmenides', NULL, 'parmenides', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(5, 'Weinberg', 'Steven', 'steven weinberg', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(6, 'Halmos', 'Paul R.', 'paul r. halmos', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(7, 'Platon', NULL, 'platon', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(8, 'Aristoteles', NULL, 'aristoteles', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(9, 'Plotin', NULL, 'plotin', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(10, 'von Kues', 'Nikolaus', 'nikolaus von kues', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(11, 'de Spinoza', 'Baruch', 'baruch de spinoza', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(12, 'Leibniz', 'Gottfried Wilhelm', 'gottfried wilhelm leibniz', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(13, 'Clarke', 'Samuel', 'samuel clarke', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(14, 'Kant', 'Immanuel', 'immanuel kant', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(15, 'Hegel', 'Georg Wilhelm Friedrich', 'georg wilhelm friedrich hegel', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(16, 'Russell', 'Bertrand', 'bertrand russell', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(17, 'Whitehead', 'Alfred North', 'alfred north whitehead', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(18, 'Husserl', 'Edmund', 'edmund husserl', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(19, 'Cassirer', 'Ernst', 'ernst cassirer', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(20, 'Heidegger', 'Martin', 'martin heidegger', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(21, 'Wittgenstein', 'Ludwig', 'ludwig wittgenstein', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(22, 'Carnap', 'Rudolf', 'rudolf carnap', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(23, 'Spencer-Brown', 'George', 'george spencer-brown', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(24, 'Floridi', 'Luciano', 'luciano floridi', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(25, 'Bitbol', 'Michel', 'michel bitbol', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(26, 'Mach', 'Ernst', 'ernst mach', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(27, 'Minkowski', 'Hermann', 'hermann minkowski', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(28, 'Weyl', 'Hermann', 'hermann weyl', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(29, 'Wald', 'Robert M.', 'robert m. wald', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(30, 'Hawking', 'Stephen W.', 'stephen w. hawking', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(31, 'Ellis', 'George F. R.', 'george f. r. ellis', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(32, 'von Neumann', 'John', 'john von neumann', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(33, 'Dirac', 'Paul A. M.', 'paul a. m. dirac', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(34, 'DeWitt', 'Bryce S.', 'bryce s. dewitt', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(35, 'Kiefer', 'Claus', 'claus kiefer', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(36, 'Bombelli', 'Luca', 'luca bombelli', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(37, 'Lee', 'Joohan', 'joohan lee', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(38, 'Meyer', 'David', 'david meyer', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(39, 'Sorkin', 'Rafael D.', 'rafael d. sorkin', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(40, 'Jacobson', 'Ted', 'ted jacobson', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(41, 'Ryu', 'Shinsei', 'shinsei ryu', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(42, 'Takayanagi', 'Tadashi', 'tadashi takayanagi', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(43, 'Van Raamsdonk', 'Mark', 'mark van raamsdonk', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(44, 'Verlinde', 'Erik', 'erik verlinde', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(45, 'von Helmholtz', 'Hermann', 'hermann von helmholtz', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(46, 'Hanson', 'Norwood Russell', 'norwood russell hanson', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(47, 'Kuhn', 'Thomas S.', 'thomas s. kuhn', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(48, 'Popper', 'Karl R.', 'karl r. popper', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(49, 'Lakatos', 'Imre', 'imre lakatos', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(50, 'Quine', 'Willard Van Orman', 'willard van orman quine', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(51, 'Duhem', 'Pierre', 'pierre duhem', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(52, 'van Fraassen', 'Bas C.', 'bas c. van fraassen', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(53, 'Worrall', 'John', 'john worrall', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(54, 'Ladyman', 'James', 'james ladyman', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(55, 'French', 'Steven', 'steven french', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(56, 'Hesse', 'Mary B.', 'mary b. hesse', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(57, 'Giere', 'Ronald N.', 'ronald n. giere', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(58, 'Suppes', 'Patrick', 'patrick suppes', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(59, 'Tarski', 'Alfred', 'alfred tarski', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(60, 'Boole', 'George', 'george boole', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(61, 'Peano', 'Giuseppe', 'giuseppe peano', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(62, 'Hilbert', 'David', 'david hilbert', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(63, 'Cantor', 'Georg', 'georg cantor', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(64, 'Lane', 'Saunders Mac', 'saunders mac lane', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(65, 'Eilenberg', 'Samuel', 'samuel eilenberg', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(66, 'Frege', 'Gottlob', 'gottlob frege', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(67, 'von Bertalanffy', 'Ludwig', 'ludwig von bertalanffy', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(68, 'Wiener', 'Norbert', 'norbert wiener', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(69, 'Ashby', 'W. Ross', 'w. ross ashby', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(70, 'Resnik', 'Michael D.', 'michael d. resnik', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(71, 'Shapiro', 'Stewart', 'stewart shapiro', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(72, 'von Foerster', 'Heinz', 'heinz von foerster', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(73, 'Luhmann', 'Niklas', 'niklas luhmann', NULL, NULL, NULL, 'Aus bibliografischer Angabe Kapitel 3.1 übernommen'),
(74, 'Enderton', 'Herbert B.', 'Enderton, Herbert B.', NULL, NULL, NULL, 'Autor der in Abschnitt 3.2.1 erstmals verwendeten Quelle [71].'),
(75, 'Strang', 'Gilbert', 'Strang, Gilbert', NULL, NULL, NULL, 'Autor der Literaturquelle [72].'),
(76, 'Conway', 'John B.', 'Conway, John B.', NULL, NULL, NULL, 'Autor der Quelle [73].'),
(77, 'Munkres', 'James R.', 'Munkres, James R.', NULL, NULL, NULL, 'Autor der Quelle [74].'),
(78, 'Teschl', 'Gerald', 'Teschl, Gerald', NULL, NULL, NULL, 'Autor der Literaturquelle [76].'),
(79, 'Evans', 'Lawrence C.', 'Evans, Lawrence C.', NULL, NULL, NULL, 'Autor der Literaturquelle [77].'),
(80, 'Lee', 'John M.', 'Lee, John M.', NULL, NULL, NULL, 'Autor der Literaturquelle [78].'),
(81, 'O\'Neill', 'Barrett', 'O\'Neill, Barrett', NULL, NULL, NULL, 'Autor der Literaturquelle [79].');

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
(1, '3.2.1', 24, 'Menge, Element und Zugehörigkeit', 'Eine Menge wird in diesem Abschnitt als formal bestimmter Objektbereich verwendet. Für ein mathematisches Objekt x und eine Menge M bezeichnet x∈M die Zugehörigkeit und x∉M die Nichtzugehörigkeit.', 'x\\in M,\\qquad x\\notin M', 'x\\in M,\\qquad x\\notin M', 'literature', NULL, NULL, 'Etablierte mengentheoretische Grundnotation; keine ontologische FRZK-Setzung.', 'verified', 3),
(2, '3.2.2', 24, 'Teilmenge', 'Eine Menge A ist genau dann Teilmenge einer Menge B, wenn jedes Element von A zugleich Element von B ist.', 'A\\subseteq B\\quad\\Longleftrightarrow\\quad\\forall x\\bigl(x\\in A\\Rightarrow x\\in B\\bigr)', 'A\\subseteq B\\quad\\Longleftrightarrow\\quad\\forall x\\bigl(x\\in A\\Rightarrow x\\in B\\bigr)', 'literature', 71, 'A und B sind Mengen.', 'Definition entspricht Gleichung 3.1.', 'verified', 3),
(3, '3.2.3', 24, 'Binäre Relation', 'Eine binäre Relation R zwischen den Mengen A und B ist eine Teilmenge ihres kartesischen Produkts A×B.', 'R\\subseteq A\\times B', 'R\\subseteq A\\times B', 'literature', 71, 'A und B sind Mengen.', 'Definition entspricht Gleichung 3.8; Enderton, S. 40.', 'verified', 3),
(4, '3.2.4', 24, 'Äquivalenzrelation', 'Eine Relation auf A heißt Äquivalenzrelation, wenn sie reflexiv, symmetrisch und transitiv ist.', 'R\\text{ ist Äquivalenzrelation}\\quad\\Longleftrightarrow\\quad R\\text{ ist reflexiv, symmetrisch und transitiv}', 'R\\text{ ist Äquivalenzrelation}\\quad\\Longleftrightarrow\\quad R\\text{ ist reflexiv, symmetrisch und transitiv}', 'literature', 71, 'R ist eine binäre Relation auf A.', 'Definition entspricht Gleichung 3.12; Enderton, S. 56.', 'verified', 3),
(5, '3.2.5', 24, 'Partielle Ordnung', 'Eine Relation auf A heißt in der hier verwendeten schwachen Ordnungsnotation partielle Ordnung, wenn sie reflexiv, antisymmetrisch und transitiv ist.', 'R\\text{ ist partielle Ordnung}\\quad\\Longleftrightarrow\\quad R\\text{ ist reflexiv, antisymmetrisch und transitiv}', 'R\\text{ ist partielle Ordnung}\\quad\\Longleftrightarrow\\quad R\\text{ ist reflexiv, antisymmetrisch und transitiv}', 'literature', 71, 'R ist eine binäre Relation auf A; verwendet wird die schwache Ordnungsnotation.', 'Enderton diskutiert die weak-order-Konvention ausdrücklich in Kapitel 7, S. 170.', 'verified', 3),
(6, '3.2.6', 26, 'Funktion', 'Eine Funktion f von A nach B ist eine Relation, die jedem Element des Definitionsbereichs A genau ein Element des Zielbereichs B zuordnet.', 'f\\subseteq A\\times B,\\qquad\\forall x\\in A\\;\\exists !\\,y\\in B:\\;(x,y)\\in f', 'f\\subseteq A\\times B,\\qquad\\forall x\\in A\\;\\exists !\\,y\\in B:\\;(x,y)\\in f', 'literature', 71, 'A und B sind Mengen.', 'Entspricht Gleichung 3.14; etablierter mengentheoretischer Funktionsbegriff.', 'verified', 4),
(7, '3.2.7', 26, 'Bild einer Funktion', 'Das Bild einer Funktion enthält genau diejenigen Elemente des Zielbereichs, die als Funktionswert mindestens eines Elements des Definitionsbereichs auftreten.', '\\operatorname{Bild}(f)=\\{y\\in B\\mid\\exists x\\in A:\\;y=f(x)\\}', '\\operatorname{Bild}(f)=\\{y\\in B\\mid\\exists x\\in A:\\;y=f(x)\\}', 'literature', 71, 'f ist eine Funktion von A nach B.', 'Entspricht Gleichung 3.15.', 'verified', 4),
(8, '3.2.8', 26, 'Injektive Funktion', 'Eine Funktion ist injektiv, wenn gleiche Funktionswerte nur von gleichen Ausgangselementen stammen können.', '\\forall x_1,x_2\\in A:\\quad f(x_1)=f(x_2)\\Rightarrow x_1=x_2', '\\forall x_1,x_2\\in A:\\quad f(x_1)=f(x_2)\\Rightarrow x_1=x_2', 'literature', 71, 'f ist eine Funktion von A nach B.', 'Entspricht Gleichung 3.18; Enderton behandelt diese Eigenschaft als one-to-one.', 'verified', 4),
(9, '3.2.9', 26, 'Surjektive Funktion', 'Eine Funktion ist surjektiv, wenn jedes Element des festgelegten Zielbereichs Funktionswert mindestens eines Elements des Definitionsbereichs ist.', '\\forall y\\in B\\;\\exists x\\in A:\\quad f(x)=y', '\\forall y\\in B\\;\\exists x\\in A:\\quad f(x)=y', 'literature', 71, 'f ist eine Funktion von A nach B.', 'Entspricht Gleichung 3.19; Surjektivität hängt vom festgelegten Zielbereich ab.', 'verified', 4),
(10, '3.2.10', 26, 'Bijektive Funktion', 'Eine Funktion ist bijektiv, wenn sie zugleich injektiv und surjektiv ist.', 'f\\text{ bijektiv}\\quad\\Longleftrightarrow\\quad f\\text{ injektiv}\\land f\\text{ surjektiv}', 'f\\text{ bijektiv}\\quad\\Longleftrightarrow\\quad f\\text{ injektiv}\\land f\\text{ surjektiv}', 'literature', 71, 'f ist eine Funktion von A nach B.', 'Entspricht Gleichung 3.20.', 'verified', 4),
(11, '3.2.11', 26, 'Umkehrfunktion', 'Ist f von A nach B bijektiv, so existiert eine eindeutige Umkehrfunktion von B nach A, welche die Hinabbildung beidseitig rückgängig macht.', 'f^{-1}(f(x))=x\\quad\\text{und}\\quad f(f^{-1}(y))=y', 'f^{-1}(f(x))=x\\quad\\text{und}\\quad f(f^{-1}(y))=y', 'literature', 71, 'f ist bijektiv.', 'Entspricht Gleichung 3.21.', 'verified', 4),
(12, '3.2.12', 26, 'Identische Funktion', 'Die identische Funktion auf A ordnet jedem Element von A sich selbst zu.', '\\operatorname{id}_A:A\\to A,\\qquad\\operatorname{id}_A(x)=x', '\\operatorname{id}_A:A\\to A,\\qquad\\operatorname{id}_A(x)=x', 'literature', 71, 'A ist eine Menge.', 'Entspricht Gleichung 3.22.', 'verified', 4),
(13, '3.2.13', 27, 'Vektorraum', 'Sei K ein Körper und V eine nichtleere Menge. Ein Vektorraum V über K besitzt eine Vektoraddition V×V→V und eine Skalarmultiplikation K×V→V, welche die Vektorraumaxiome erfüllen.', '+:V\\times V\\longrightarrow V,\\qquad\\cdot:\\mathbb{K}\\times V\\longrightarrow V', '+:V\\times V\\longrightarrow V,\\qquad\\cdot:\\mathbb{K}\\times V\\longrightarrow V', 'literature', 72, 'K ist ein Körper; V ist nichtleer; Addition und Skalarmultiplikation erfüllen die in Gleichung 3.27 aufgeführten Vektorraumaxiome.', 'Formale Operationssignaturen in Gleichung 3.26; Axiome in Gleichung 3.27.', 'verified', 5),
(14, '3.2.14', 27, 'Nullvektor', 'Der Nullvektor 0_V ist das eindeutig bestimmte neutrale Element der Vektoraddition: Für jeden Vektor u aus V gilt u+0_V=u.', 'u+0_V=u\\qquad\\text{für alle }u\\in V', 'u+0_V=u\\qquad\\text{für alle }u\\in V', 'literature', 72, 'V ist ein Vektorraum.', 'Entspricht Gleichung 3.28.', 'verified', 5),
(15, '3.2.15', 27, 'Untervektorraum', 'Eine nichtleere Teilmenge U eines Vektorraums V heißt Untervektorraum, wenn sie unter den Vektorraumoperationen abgeschlossen ist; insbesondere liegt für u,v aus U und Skalare alpha,beta aus K jede Linearkombination alpha u + beta v wieder in U.', 'u,v\\in U,\\ \\alpha,\\beta\\in\\mathbb K\\quad\\Longrightarrow\\quad\\alpha u+\\beta v\\in U', 'u,v\\in U,\\ \\alpha,\\beta\\in\\mathbb K\\quad\\Longrightarrow\\quad\\alpha u+\\beta v\\in U', 'literature', 72, 'U ist eine nichtleere Teilmenge eines Vektorraums V über K.', 'Entspricht Gleichung 3.31.', 'verified', 5),
(16, '3.2.16', 28, 'Linearkombination', 'Seien v_1 bis v_n Vektoren eines Vektorraums V über einem Körper K und alpha_1 bis alpha_n Skalare aus K. Jeder Vektor der Form Summe alpha_i v_i heißt Linearkombination der Vektoren v_1 bis v_n.', 'v=alpha_1v_1+alpha_2v_2+cdots+alpha_nv_n=sum_{i=1}^{n}alpha_i v_i', 'v=alpha_1v_1+alpha_2v_2+cdots+alpha_nv_n=sum_{i=1}^{n}alpha_i v_i', 'literature', 72, 'v_1,...,v_n liegen in V; alpha_1,...,alpha_n liegen im Skalarkörper K.', 'Entspricht Gleichung 3.33.', 'verified', 6),
(17, '3.2.17', 28, 'Spannraum', 'Der Spannraum der Vektoren v_1 bis v_n ist die Menge aller Linearkombinationen dieser Vektoren mit Koeffizienten aus dem Skalarkörper K.', 'operatorname{span}(v_1,ldots,v_n)=left{sum_{i=1}^{n}alpha_i v_i;middle|;alpha_iinmathbb K\right}', 'operatorname{span}(v_1,ldots,v_n)=left{sum_{i=1}^{n}alpha_i v_i;middle|;alpha_iinmathbb K\right}', 'literature', 72, 'v_1,...,v_n liegen in einem Vektorraum V über K.', 'Entspricht Gleichung 3.34.', 'verified', 6),
(18, '3.2.18', 28, 'Erzeugendensystem', 'Eine Menge von Vektoren ist ein Erzeugendensystem des Vektorraums V, wenn ihr Spannraum mit V übereinstimmt.', 'operatorname{span}(v_1,ldots,v_n)=V', 'operatorname{span}(v_1,ldots,v_n)=V', 'literature', 72, 'v_1,...,v_n liegen in V.', 'Entspricht Gleichung 3.38.', 'verified', 6),
(19, '3.2.19', 28, 'Spann einer allgemeinen Teilmenge', 'Für eine Teilmenge S eines Vektorraums V ist span(S) die Menge aller endlichen Linearkombinationen von Elementen aus S.', 'operatorname{span}(S)=left{sum_{i=1}^{n}alpha_i v_i;middle|;ninmathbb N,;v_iin S,;alpha_iinmathbb K\right}', 'operatorname{span}(S)=left{sum_{i=1}^{n}alpha_i v_i;middle|;ninmathbb N,;v_iin S,;alpha_iinmathbb K\right}', 'literature', 72, 'S ist eine Teilmenge eines Vektorraums V über K.', 'Entspricht Gleichung 3.43; jede einzelne Linearkombination enthält nur endlich viele Vektoren.', 'verified', 6),
(20, '3.2.20', 29, 'Lineare Unabhängigkeit', 'Die Vektoren v_1 bis v_n eines Vektorraums V über dem Körper K heißen linear unabhängig, wenn aus einer Linearkombination, die den Nullvektor ergibt, folgt, dass sämtliche Koeffizienten gleich dem skalaren Nullelement sind.', 'sum_{i=1}^{n}alpha_i v_i=0_VquadLongrightarrowquadalpha_1=alpha_2=cdots=alpha_n=0_{mathbb K}', 'sum_{i=1}^{n}alpha_i v_i=0_VquadLongrightarrowquadalpha_1=alpha_2=cdots=alpha_n=0_{mathbb K}', 'literature', 72, 'v_1,...,v_n liegen in einem Vektorraum V über K; alpha_i liegen in K.', 'Entspricht Gleichung 3.45.', 'verified', 7),
(21, '3.2.21', 29, 'Basis', 'Eine Menge B={b_1,...,b_n} ist eine Basis des Vektorraums V, wenn ihre Elemente linear unabhängig sind und zugleich den gesamten Vektorraum aufspannen.', 'mathcal B	ext{ ist Basis von }VquadLongleftrightarrowquadegin{cases}b_1,ldots,b_n	ext{ sind linear unabhängig},\\operatorname{span}(b_1,ldots,b_n)=V.end{cases}', 'mathcal B	ext{ ist Basis von }VquadLongleftrightarrowquadegin{cases}b_1,ldots,b_n	ext{ sind linear unabhängig},\\operatorname{span}(b_1,ldots,b_n)=V.end{cases}', 'literature', 72, 'b_1,...,b_n liegen in V.', 'Entspricht Gleichung 3.48.', 'verified', 7),
(22, '3.2.22', 29, 'Dimension eines endlichdimensionalen Vektorraums', 'Besitzt ein Vektorraum V eine Basis mit n Elementen, so ist seine algebraische Dimension gleich n.', 'dim(V)=n', 'dim(V)=n', 'literature', 72, 'V ist endlichdimensional und besitzt eine Basis mit n Elementen.', 'Entspricht Gleichung 3.53.', 'verified', 7),
(23, '3.2.23', 30, 'Lineare Abbildung', 'Seien V und W Vektorräume über demselben Körper K. Eine Abbildung T von V nach W heißt linear, wenn sie Vektoraddition und Skalarmultiplikation erhält.', 'T(u+v)=T(u)+T(v),\\qquad T(\\alpha u)=\\alpha T(u)', 'T(u+v)=T(u)+T(v),\\qquad T(\\alpha u)=\\alpha T(u)', 'literature', 72, 'V und W sind Vektorräume über demselben Körper K; u,v liegen in V und alpha liegt in K.', 'Entspricht Gleichung 3.58.', 'verified', 8),
(24, '3.2.24', 30, 'Kern einer linearen Abbildung', 'Der Kern einer linearen Abbildung T:V nach W ist die Menge aller Vektoren aus V, die auf den Nullvektor von W abgebildet werden.', '\\ker(T)=\\{v\\in V\\mid T(v)=0_W\\}', '\\ker(T)=\\{v\\in V\\mid T(v)=0_W\\}', 'literature', 72, 'T ist eine lineare Abbildung von V nach W.', 'Entspricht Gleichung 3.63.', 'verified', 8),
(25, '3.2.25', 30, 'Bildraum einer linearen Abbildung', 'Der Bildraum einer linearen Abbildung T:V nach W besteht aus allen Vektoren in W, die als T(v) für mindestens einen Vektor v aus V auftreten.', '\\operatorname{im}(T)=\\{T(v)\\mid v\\in V\\}', '\\operatorname{im}(T)=\\{T(v)\\mid v\\in V\\}', 'literature', 72, 'T ist eine lineare Abbildung von V nach W.', 'Entspricht Gleichung 3.67.', 'verified', 8),
(26, '3.2.26', 30, 'Rang und Nullität', 'Für eine lineare Abbildung zwischen endlichdimensionalen Vektorräumen ist der Rang die Dimension des Bildraums und die Nullität die Dimension des Kerns.', '\\operatorname{rang}(T)=\\dim\\bigl(\\operatorname{im}(T)\\bigr),\\qquad\\operatorname{null}(T)=\\dim\\bigl(\\ker(T)\\bigr)', '\\operatorname{rang}(T)=\\dim\\bigl(\\operatorname{im}(T)\\bigr),\\qquad\\operatorname{null}(T)=\\dim\\bigl(\\ker(T)\\bigr)', 'literature', 72, 'T ist linear; die für Rang und Nullität betrachteten Unterräume sind endlichdimensional.', 'Entspricht Gleichung 3.69.', 'verified', 8),
(27, '3.2.27', 30, 'Linearer Operator', 'Eine lineare Abbildung eines Vektorraums V in sich selbst wird als linearer Operator auf V bezeichnet.', 'T:V\\longrightarrow V', 'T:V\\longrightarrow V', 'literature', 72, 'V ist ein Vektorraum und T ist linear.', 'Entspricht Gleichung 3.72.', 'verified', 8),
(28, '3.2.28', 31, 'Norm', 'Eine Norm auf einem reellen oder komplexen Vektorraum ordnet jedem Vektor eine nichtnegative reelle Zahl zu und erfüllt Definitheit, absolute Homogenität und Dreiecksungleichung.', '\\begin{aligned}\\|v\\|&\\geq 0,\\\\\\|v\\|=0&\\quad\\Longleftrightarrow\\quad v=0_V,\\\\\\|\\alpha v\\|&=|\\alpha|\\,\\|v\\|,\\\\\\|u+v\\|&\\leq\\|u\\|+\\|v\\|.\\end{aligned}', '\\begin{aligned}\\|v\\|&\\geq 0,\\\\\\|v\\|=0&\\quad\\Longleftrightarrow\\quad v=0_V,\\\\\\|\\alpha v\\|&=|\\alpha|\\,\\|v\\|,\\\\\\|u+v\\|&\\leq\\|u\\|+\\|v\\|.\\end{aligned}', 'literature', 73, 'V ist ein reeller oder komplexer Vektorraum; u,v liegen in V und alpha ist ein Skalar.', 'Entspricht Gleichung 3.81.', 'verified', 9),
(29, '3.2.29', 31, 'Normierter Vektorraum', 'Ein Vektorraum V zusammen mit einer auf V definierten Norm bildet einen normierten Vektorraum.', '(V,\\|\\cdot\\|)', '(V,\\|\\cdot\\|)', 'literature', 73, 'V ist ein Vektorraum und ||.|| ist eine Norm auf V.', 'Entspricht Gleichung 3.82.', 'verified', 9),
(30, '3.2.30', 31, 'Metrik', 'Eine Metrik auf einer nichtleeren Menge X ordnet jedem Paar von Elementen einen nichtnegativen reellen Abstand zu und erfüllt Definitheit, Symmetrie und Dreiecksungleichung.', '\\begin{aligned}d(x,y)&\\geq0,\\\\d(x,y)=0&\\quad\\Longleftrightarrow\\quad x=y,\\\\d(x,y)&=d(y,x),\\\\d(x,z)&\\leq d(x,y)+d(y,z).\\end{aligned}', '\\begin{aligned}d(x,y)&\\geq0,\\\\d(x,y)=0&\\quad\\Longleftrightarrow\\quad x=y,\\\\d(x,y)&=d(y,x),\\\\d(x,z)&\\leq d(x,y)+d(y,z).\\end{aligned}', 'literature', 73, 'X ist eine nichtleere Menge; x,y,z liegen in X.', 'Entspricht Gleichung 3.84.', 'verified', 9),
(31, '3.2.31', 31, 'Skalarprodukt', 'Ein Skalarprodukt auf einem reellen oder komplexen Vektorraum ist eine sesquilineare beziehungsweise im reellen Fall bilineare positive definite Form. Verwendet wird die Konvention: linear im ersten Argument und konjugiert linear im zweiten.', '\\begin{aligned}\\langle\\alpha u+\\beta v,w\\rangle&=\\alpha\\langle u,w\\rangle+\\beta\\langle v,w\\rangle,\\\\\\langle u,v\\rangle&=\\overline{\\langle v,u\\rangle},\\\\\\langle v,v\\rangle&\\geq0,\\\\\\langle v,v\\rangle=0&\\quad\\Longleftrightarrow\\quad v=0_V.\\end{aligned}', '\\begin{aligned}\\langle\\alpha u+\\beta v,w\\rangle&=\\alpha\\langle u,w\\rangle+\\beta\\langle v,w\\rangle,\\\\\\langle u,v\\rangle&=\\overline{\\langle v,u\\rangle},\\\\\\langle v,v\\rangle&\\geq0,\\\\\\langle v,v\\rangle=0&\\quad\\Longleftrightarrow\\quad v=0_V.\\end{aligned}', 'literature', 73, 'V ist ein reeller oder komplexer Vektorraum.', 'Entspricht Gleichung 3.86.', 'verified', 9),
(32, '3.2.32', 31, 'Orthogonalität', 'Zwei Vektoren eines Skalarproduktraums heißen orthogonal, wenn ihr Skalarprodukt gleich null ist.', 'u\\perp v\\quad\\Longleftrightarrow\\quad\\langle u,v\\rangle=0', 'u\\perp v\\quad\\Longleftrightarrow\\quad\\langle u,v\\rangle=0', 'literature', 73, 'u und v liegen in einem Skalarproduktraum.', 'Entspricht Gleichung 3.89.', 'verified', 9),
(33, '3.2.33', 31, 'Orthonormales System', 'Eine Familie von Vektoren ist orthonormal, wenn jeder Vektor Norm eins besitzt und verschiedene Vektoren paarweise orthogonal sind.', '\\langle e_i,e_j\\rangle=\\delta_{ij}', '\\langle e_i,e_j\\rangle=\\delta_{ij}', 'literature', 73, 'Die Vektoren e_i liegen in einem Skalarproduktraum.', 'Entspricht Gleichungen 3.92 und 3.93.', 'verified', 9),
(34, '3.2.34', 31, 'Orthogonale Projektion auf eine Richtung', 'Die orthogonale Projektion eines Vektors u auf die von einem von null verschiedenen Vektor v erzeugte Richtung ist das skalare Vielfache von v, dessen Koeffizient durch den Quotienten aus dem Skalarprodukt von u und v und dem Skalarprodukt von v mit sich selbst gegeben ist.', '\\operatorname{proj}_{v}(u)=\\frac{\\langle u,v\\rangle}{\\langle v,v\\rangle}\\,v', '\\operatorname{proj}_{v}(u)=\\frac{\\langle u,v\\rangle}{\\langle v,v\\rangle}\\,v', 'literature', 73, 'u und v liegen in einem Skalarproduktraum und v ist ungleich 0_V.', 'Entspricht Gleichung 3.95.', 'verified', 9),
(35, '3.2.35', 32, 'Topologie und topologischer Raum', 'Eine Topologie tau auf einer Menge X ist eine Familie von Teilmengen von X, welche die leere Menge und X enthält, unter beliebigen Vereinigungen abgeschlossen ist und unter endlichen Durchschnitten abgeschlossen ist. Das Paar (X,tau) heißt topologischer Raum.', '\\begin{aligned}\\varnothing&\\in\\tau,\\qquad X\\in\\tau,\\\\\\{U_i\\}_{i\\in I}\\subseteq\\tau&\\Longrightarrow\\bigcup_{i\\in I}U_i\\in\\tau,\\\\U_1,\\ldots,U_n\\in\\tau&\\Longrightarrow\\bigcap_{k=1}^{n}U_k\\in\\tau.\\end{aligned}', '\\begin{aligned}\\varnothing&\\in\\tau,\\qquad X\\in\\tau,\\\\\\{U_i\\}_{i\\in I}\\subseteq\\tau&\\Longrightarrow\\bigcup_{i\\in I}U_i\\in\\tau,\\\\U_1,\\ldots,U_n\\in\\tau&\\Longrightarrow\\bigcap_{k=1}^{n}U_k\\in\\tau.\\end{aligned}', 'literature', 74, 'X ist eine Menge und tau ist eine Teilmenge der Potenzmenge von X.', 'Entspricht den Gleichungen 3.98 bis 3.100; Grundlage §12.', 'verified', 10),
(36, '3.2.36', 32, 'Umgebung', 'Eine Teilmenge N von X heißt Umgebung eines Punktes x, wenn eine offene Menge U existiert, die x enthält und vollständig in N liegt.', 'x\\in U\\subseteq N', 'x\\in U\\subseteq N', 'literature', 74, '(X,tau) ist ein topologischer Raum; x liegt in X.', 'Entspricht Gleichung 3.102.', 'verified', 10),
(37, '3.2.37', 32, 'Basis einer Topologie', 'Eine Familie B von Teilmengen von X ist eine Basis einer Topologie, wenn die offenen Mengen durch Vereinigungen geeigneter Basiselemente erzeugt werden und jeder Punkt einer offenen Menge in einem darin enthaltenen Basiselement liegt.', 'x\\in B\\subseteq U', 'x\\in B\\subseteq U', 'literature', 74, 'X ist eine Menge; die Familie B erfüllt die Basisbedingungen einer Topologie.', 'Entspricht den Gleichungen 3.106 und 3.107; Grundlage §13.', 'verified', 10),
(38, '3.2.38', 32, 'Abgeschlossene Menge', 'Eine Teilmenge A eines topologischen Raumes X heißt abgeschlossen, wenn ihr Komplement X ohne A offen ist.', 'A\\text{ abgeschlossen}\\quad\\Longleftrightarrow\\quad X\\setminus A\\in\\tau', 'A\\text{ abgeschlossen}\\quad\\Longleftrightarrow\\quad X\\setminus A\\in\\tau', 'literature', 74, '(X,tau) ist ein topologischer Raum und A ist Teilmenge von X.', 'Entspricht Gleichung 3.108; Grundlage §17.', 'verified', 10),
(39, '3.2.39', 32, 'Inneres', 'Das Innere A° einer Teilmenge A ist die größte offene Teilmenge von A beziehungsweise die Vereinigung aller offenen Teilmengen von A.', 'A^\\circ=\\bigcup\\{U\\in\\tau\\mid U\\subseteq A\\}', 'A^\\circ=\\bigcup\\{U\\in\\tau\\mid U\\subseteq A\\}', 'literature', 74, 'A ist eine Teilmenge des topologischen Raums X.', 'Entspricht Gleichung 3.109.', 'verified', 10),
(40, '3.2.40', 32, 'Abschluss', 'Der Abschluss einer Teilmenge A ist die kleinste abgeschlossene Teilmenge des Raumes, die A enthält.', '\\overline A=\\bigcap\\{F\\subseteq X\\mid A\\subseteq F,\\;F\\text{ abgeschlossen}\\}', '\\overline A=\\bigcap\\{F\\subseteq X\\mid A\\subseteq F,\\;F\\text{ abgeschlossen}\\}', 'literature', 74, 'A ist eine Teilmenge des topologischen Raums X.', 'Entspricht den Gleichungen 3.110 und 3.111; Grundlage §17.', 'verified', 10),
(41, '3.2.41', 32, 'Rand', 'Der Rand einer Teilmenge A ist der Abschluss von A ohne ihr Inneres. Äquivalent ist er der Durchschnitt des Abschlusses von A mit dem Abschluss ihres Komplements.', '\\partial A=\\overline A\\setminus A^\\circ', '\\partial A=\\overline A\\setminus A^\\circ', 'literature', 74, 'A ist eine Teilmenge des topologischen Raums X.', 'Entspricht den Gleichungen 3.112 und 3.113.', 'verified', 10),
(42, '3.2.42', 32, 'Stetige Abbildung', 'Eine Abbildung f von einem topologischen Raum X in einen topologischen Raum Y heißt stetig, wenn das Urbild jeder offenen Menge des Zielraumes im Ausgangsraum offen ist.', 'V\\in\\tau_Y\\quad\\Longrightarrow\\quad f^{-1}(V)\\in\\tau_X', 'V\\in\\tau_Y\\quad\\Longrightarrow\\quad f^{-1}(V)\\in\\tau_X', 'literature', 74, '(X,tau_X) und (Y,tau_Y) sind topologische Räume; f:X nach Y ist eine Abbildung.', 'Entspricht Gleichung 3.114; Grundlage §18.', 'verified', 10),
(43, '3.2.43', 32, 'Homeomorphismus', 'Eine bijektive Abbildung zwischen topologischen Räumen heißt Homeomorphismus, wenn sowohl die Abbildung als auch ihre Umkehrfunktion stetig sind.', 'f:X\\longrightarrow Y\\text{ bijektiv},\\qquad f\\text{ stetig},\\qquad f^{-1}\\text{ stetig}', 'f:X\\longrightarrow Y\\text{ bijektiv},\\qquad f\\text{ stetig},\\qquad f^{-1}\\text{ stetig}', 'literature', 74, 'X und Y sind topologische Räume und f ist bijektiv.', 'Topologische Gleichwertigkeit durch stetige bijektive Abbildung mit stetiger Umkehrfunktion; Grundlage §18.', 'verified', 10),
(44, '3.2.44', 33, 'Trennung', 'Zwei Teilmengen U und V eines topologischen Raumes X bilden eine Trennung von X, wenn beide nichtleer und offen sind, disjunkt sind und gemeinsam den gesamten Raum X ergeben.', 'U\\neq\\varnothing,\\qquad V\\neq\\varnothing,\\qquad U\\cap V=\\varnothing,\\qquad U\\cup V=X', 'U\\neq\\varnothing,\\qquad V\\neq\\varnothing,\\qquad U\\cap V=\\varnothing,\\qquad U\\cup V=X', 'literature', 74, 'X ist ein topologischer Raum; U und V sind Teilmengen von X.', 'Entspricht Gleichung 3.120; Grundlage §23.', 'verified', 11),
(45, '3.2.45', 33, 'Zusammenhängender Raum', 'Ein topologischer Raum X heißt zusammenhängend, wenn keine Trennung von X in zwei nichtleere disjunkte offene Teilmengen existiert.', 'X\\neq U\\cup V\\text{ für eine Trennung }(U,V)', 'X\\neq U\\cup V\\text{ für eine Trennung }(U,V)', 'literature', 74, 'X ist ein topologischer Raum.', 'Die Definition wird im Text durch Gleichung 3.121 konkretisiert; Grundlage §23.', 'verified', 11),
(46, '3.2.46', 33, 'Zusammenhängende Teilmenge', 'Eine Teilmenge A eines topologischen Raumes X heißt zusammenhängend, wenn sie bezüglich der von X auf A induzierten Teilraumtopologie zusammenhängend ist.', 'A\\subseteq X\\text{ ist zusammenhängend bezüglich der Teilraumtopologie}', 'A\\subseteq X\\text{ ist zusammenhängend bezüglich der Teilraumtopologie}', 'literature', 74, 'A ist eine Teilmenge des topologischen Raums X.', 'Grundlage §23.', 'verified', 11),
(47, '3.2.47', 33, 'Weg', 'Ein Weg in einem topologischen Raum X von x nach y ist eine stetige Abbildung gamma vom Einheitsintervall [0,1] nach X mit gamma(0)=x und gamma(1)=y.', '\\gamma:[0,1]\\longrightarrow X,\\qquad \\gamma(0)=x,\\qquad\\gamma(1)=y', '\\gamma:[0,1]\\longrightarrow X,\\qquad \\gamma(0)=x,\\qquad\\gamma(1)=y', 'literature', 74, 'X ist ein topologischer Raum; x,y liegen in X.', 'Entspricht Gleichungen 3.125 und 3.126; einschlägige Zusammenhangsdarstellung §§23-25.', 'verified', 11),
(48, '3.2.48', 33, 'Wegzusammenhängender Raum', 'Ein topologischer Raum X heißt wegzusammenhängend, wenn je zwei Punkte von X durch einen stetigen Weg im Raum miteinander verbunden werden können.', '\\forall x,y\\in X\\;\\exists\\gamma:[0,1]\\to X:\\gamma(0)=x\\land\\gamma(1)=y', '\\forall x,y\\in X\\;\\exists\\gamma:[0,1]\\to X:\\gamma(0)=x\\land\\gamma(1)=y', 'literature', 74, 'X ist ein topologischer Raum.', 'Entspricht Gleichung 3.127.', 'verified', 11),
(49, '3.2.49', 33, 'Zusammenhangskomponente', 'Eine Zusammenhangskomponente eines topologischen Raumes X ist eine maximale zusammenhängende Teilmenge von X.', 'C\\subseteq X\\text{ maximal zusammenhängend}', 'C\\subseteq X\\text{ maximal zusammenhängend}', 'literature', 74, 'X ist ein topologischer Raum.', 'Grundlage §25; Gleichung 3.129 beschreibt die disjunkte Zerlegung verschiedener Komponenten.', 'verified', 11),
(50, '3.2.50', 33, 'Offene Überdeckung', 'Eine Familie offener Mengen U_i heißt offene Überdeckung eines topologischen Raumes X, wenn die Vereinigung der Mengen den gesamten Raum X überdeckt.', 'X\\subseteq\\bigcup_{i\\in I}U_i', 'X\\subseteq\\bigcup_{i\\in I}U_i', 'literature', 74, 'Alle U_i sind offene Teilmengen des topologischen Raums X.', 'Entspricht Gleichungen 3.130 und 3.131; Grundlage §26.', 'verified', 11),
(51, '3.2.51', 33, 'Kompakter Raum', 'Ein topologischer Raum X heißt kompakt, wenn jede offene Überdeckung von X eine endliche Teilüberdeckung besitzt.', 'X\\subseteq\\bigcup_{i\\in I}U_i\\Longrightarrow\\exists i_1,\\ldots,i_n:\\;X\\subseteq U_{i_1}\\cup\\cdots\\cup U_{i_n}', 'X\\subseteq\\bigcup_{i\\in I}U_i\\Longrightarrow\\exists i_1,\\ldots,i_n:\\;X\\subseteq U_{i_1}\\cup\\cdots\\cup U_{i_n}', 'literature', 74, 'X ist ein topologischer Raum; die U_i bilden eine offene Überdeckung.', 'Entspricht Gleichungen 3.132 und 3.133; Grundlage §26.', 'verified', 11),
(52, '3.2.52', 33, 'Kompakte Teilmenge', 'Eine Teilmenge K eines topologischen Raumes X heißt kompakt, wenn sie bezüglich der auf K induzierten Teilraumtopologie kompakt ist.', 'K\\subseteq X\\text{ ist kompakt bezüglich der Teilraumtopologie}', 'K\\subseteq X\\text{ ist kompakt bezüglich der Teilraumtopologie}', 'literature', 74, 'K ist eine Teilmenge des topologischen Raums X.', 'Grundlage §26.', 'verified', 11),
(53, '3.2.53', 34, 'Folge', 'Eine Folge in einer Menge X ist eine Abbildung von den natürlichen Zahlen nach X. Der Funktionswert x(n) wird als x_n geschrieben.', 'x:\\mathbb N\\longrightarrow X', 'x:\\mathbb N\\longrightarrow X', 'literature', 74, 'X ist eine Menge.', 'Entspricht Gleichungen 3.140 und 3.141.', 'verified', 12),
(54, '3.2.54', 34, 'Topologische Konvergenz einer Folge', 'Eine Folge x_n in einem topologischen Raum X konvergiert gegen x, wenn jede Umgebung von x ab einem hinreichend großen Index sämtliche weiteren Folgenglieder enthält.', '\\forall U\\in\\mathcal N(x)\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N:\\;x_n\\in U', '\\forall U\\in\\mathcal N(x)\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N:\\;x_n\\in U', 'literature', 74, '(X,tau) ist ein topologischer Raum; x_n und x liegen in X.', 'Entspricht Gleichungen 3.142 und 3.143.', 'verified', 12),
(55, '3.2.55', 34, 'Cauchy-Folge', 'Eine Folge in einem metrischen Raum heißt Cauchy-Folge, wenn ihre hinreichend späten Folgenglieder untereinander beliebig kleinen Abstand besitzen.', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall m,n\\geq N:\\;d(x_m,x_n)<\\varepsilon', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall m,n\\geq N:\\;d(x_m,x_n)<\\varepsilon', 'literature', 74, '(X,d) ist ein metrischer Raum.', 'Entspricht Gleichungen 3.149 und 3.150.', 'verified', 12),
(56, '3.2.56', 34, 'Vollständiger metrischer Raum', 'Ein metrischer Raum heißt vollständig, wenn jede Cauchy-Folge in diesem Raum gegen ein Element desselben Raumes konvergiert.', '(x_n)\\text{ Cauchy in }X\\quad\\Longrightarrow\\quad\\exists x\\in X:\\;x_n\\to x', '(x_n)\\text{ Cauchy in }X\\quad\\Longrightarrow\\quad\\exists x\\in X:\\;x_n\\to x', 'literature', 74, '(X,d) ist ein metrischer Raum.', 'Entspricht Gleichungen 3.152 und 3.153.', 'verified', 12),
(57, '3.2.57', 34, 'Banachraum', 'Ein normierter Vektorraum heißt Banachraum, wenn er bezüglich der von seiner Norm induzierten Metrik vollständig ist.', '(V,\\|\\cdot\\|)\\text{ Banachraum}\\quad\\Longleftrightarrow\\quad(V,\\|\\cdot\\|)\\text{ vollständig}', '(V,\\|\\cdot\\|)\\text{ Banachraum}\\quad\\Longleftrightarrow\\quad(V,\\|\\cdot\\|)\\text{ vollständig}', 'literature', 73, 'V ist ein normierter reeller oder komplexer Vektorraum.', 'Entspricht Gleichungen 3.155 und 3.156.', 'verified', 12),
(58, '3.2.58', 34, 'Hilbertraum', 'Ein Skalarproduktraum heißt Hilbertraum, wenn er bezüglich der durch das Skalarprodukt induzierten Norm vollständig ist.', '\\|x\\|=\\sqrt{\\langle x,x\\rangle},\\qquad H\\text{ vollständig}', '\\|x\\|=\\sqrt{\\langle x,x\\rangle},\\qquad H\\text{ vollständig}', 'literature', 73, 'H ist ein reeller oder komplexer Skalarproduktraum.', 'Entspricht Gleichungen 3.157 und 3.158.', 'verified', 12),
(59, '3.2.59', 34, 'Teilfolge', 'Eine Teilfolge einer Folge x_n entsteht durch Auswahl einer streng wachsenden Folge von Indizes n_k; die ursprüngliche Reihenfolge der ausgewählten Folgenglieder bleibt erhalten.', 'n_1<n_2<n_3<\\cdots,\\qquad(x_{n_k})_{k\\in\\mathbb N}', 'n_1<n_2<n_3<\\cdots,\\qquad(x_{n_k})_{k\\in\\mathbb N}', 'literature', 74, '(x_n) ist eine Folge und (n_k) eine streng wachsende Folge natürlicher Zahlen.', 'Entspricht Gleichungen 3.160 und 3.161.', 'verified', 12),
(60, '3.2.60', 35, 'Funktionenraum', 'Der Funktionenraum F(X,Y) ist die Menge aller Abbildungen von X nach Y. Seine Elemente sind vollständige Funktionen.', '\\mathcal F(X,Y)=\\{f\\mid f:X\\to Y\\}', '\\mathcal F(X,Y)=\\{f\\mid f:X\\to Y\\}', 'literature', 74, 'X und Y sind Mengen.', 'Entspricht Gleichung 3.167.', 'verified', 13),
(61, '3.2.61', 35, 'Linearer Funktionenraum', 'Ist V ein Vektorraum über K, werden Addition und Skalarmultiplikation von Funktionen X nach V punktweise definiert. Dadurch trägt der Funktionenraum eine natürliche lineare Struktur.', '(\\alpha f+\\beta g)(x)=\\alpha f(x)+\\beta g(x)', '(\\alpha f+\\beta g)(x)=\\alpha f(x)+\\beta g(x)', 'literature', 73, 'V ist ein Vektorraum über K; f,g:X nach V und alpha,beta liegen in K.', 'Entspricht Gleichungen 3.168 und 3.169.', 'verified', 13),
(62, '3.2.62', 35, 'Raum stetiger Funktionen', 'C(X,Y) bezeichnet die Menge aller stetigen Abbildungen eines topologischen Raumes X in einen topologischen Raum Y.', 'C(X,Y)=\\{f:X\\to Y\\mid f\\text{ stetig}\\}', 'C(X,Y)=\\{f:X\\to Y\\mid f\\text{ stetig}\\}', 'literature', 74, 'X und Y sind topologische Räume.', 'Entspricht Gleichung 3.171.', 'verified', 13),
(63, '3.2.63', 35, 'Beschränkte Funktion und Raum beschränkter Funktionen', 'Eine skalare Funktion f:X nach K heißt beschränkt, wenn ihr Betrag durch eine endliche nichtnegative Konstante gleichmäßig auf X nach oben beschränkt ist. B(X,K) bezeichnet die Menge aller solchen Funktionen.', '|f(x)|\\leq M\\quad\\text{für alle }x\\in X', '|f(x)|\\leq M\\quad\\text{für alle }x\\in X', 'literature', 73, 'K ist R oder C; M ist eine nichtnegative reelle Konstante.', 'Entspricht Gleichungen 3.172 und 3.173.', 'verified', 13),
(64, '3.2.64', 35, 'Supremumsnorm', 'Für eine beschränkte skalare Funktion ist die Supremumsnorm das Supremum ihres Betrags über dem gesamten Definitionsbereich.', '\\|f\\|_\\infty=\\sup_{x\\in X}|f(x)|', '\\|f\\|_\\infty=\\sup_{x\\in X}|f(x)|', 'literature', 73, 'f ist eine beschränkte reell- oder komplexwertige Funktion auf X.', 'Entspricht Gleichungen 3.174 und 3.175.', 'verified', 13),
(65, '3.2.65', 35, 'Raum beschränkter stetiger Funktionen', 'C_b(X,K) ist der Schnitt des Raumes stetiger skalarer Funktionen mit dem Raum beschränkter skalarer Funktionen.', 'C_b(X,\\mathbb K)=C(X,\\mathbb K)\\cap B(X,\\mathbb K)', 'C_b(X,\\mathbb K)=C(X,\\mathbb K)\\cap B(X,\\mathbb K)', 'literature', 73, 'X ist ein topologischer Raum und K ist R oder C.', 'Entspricht Gleichung 3.177.', 'verified', 13),
(66, '3.2.66', 35, 'Punktweise Konvergenz', 'Eine Funktionenfolge f_n konvergiert punktweise gegen f, wenn für jedes feste Argument x die skalare beziehungsweise zielraumbezogene Folge f_n(x) gegen f(x) konvergiert.', '\\forall x\\in X:\\quad f_n(x)\\longrightarrow f(x)', '\\forall x\\in X:\\quad f_n(x)\\longrightarrow f(x)', 'literature', 74, 'f_n und f sind Funktionen auf demselben Definitionsbereich X.', 'Entspricht Gleichungen 3.179 und 3.180.', 'verified', 13),
(67, '3.2.67', 35, 'Gleichmäßige Konvergenz', 'Eine Funktionenfolge f_n konvergiert gleichmäßig gegen f, wenn zu jeder positiven Fehlerschranke ein gemeinsamer Index existiert, ab dem die Schranke für alle Argumente gleichzeitig gilt.', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N\\;\\forall x\\in X:\\;|f_n(x)-f(x)|<\\varepsilon', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N\\;\\forall x\\in X:\\;|f_n(x)-f(x)|<\\varepsilon', 'literature', 74, 'f_n und f sind reell- oder komplexwertige Funktionen auf X.', 'Entspricht Gleichung 3.181.', 'verified', 13),
(68, '3.2.68', 35, 'Auswertungsfunktional', 'Für ein festes x in X ordnet das Auswertungsfunktional einer Funktion f ihren Funktionswert f(x) zu.', '\\operatorname{ev}_x(f)=f(x)', '\\operatorname{ev}_x(f)=f(x)', 'literature', 73, 'x ist fest gewählt; f liegt in einem geeigneten skalaren Funktionenraum.', 'Entspricht Gleichungen 3.190 bis 3.193.', 'verified', 13),
(69, '3.2.69', 36, 'Lineares Funktional', 'Ein lineares Funktional auf einem Vektorraum X über K ist eine lineare Abbildung von X in den Skalarkörper K.', '\\varphi(\\alpha x+\\beta y)=\\alpha\\varphi(x)+\\beta\\varphi(y)', '\\varphi(\\alpha x+\\beta y)=\\alpha\\varphi(x)+\\beta\\varphi(y)', 'literature', 73, 'X ist ein Vektorraum über K=R oder C; x,y liegen in X und alpha,beta in K.', 'Entspricht Gleichung 3.203.', 'verified', 14),
(70, '3.2.70', 36, 'Stetiger Dualraum', 'Für einen normierten Vektorraum X bezeichnet X* den Raum aller linearen und stetigen Funktionale von X in den Skalarkörper.', 'X^*=\\{\\varphi:X\\to\\mathbb K\\mid\\varphi\\text{ linear und stetig}\\}', 'X^*=\\{\\varphi:X\\to\\mathbb K\\mid\\varphi\\text{ linear und stetig}\\}', 'literature', 73, 'X ist ein normierter Vektorraum über R oder C.', 'Entspricht den Gleichungen 3.204 bis 3.206; der algebraische Dualraum X# wird davon unterschieden.', 'verified', 14),
(71, '3.2.71', 36, 'Beschränkter linearer Operator', 'Ein linearer Operator T zwischen normierten Vektorräumen X und Y heißt beschränkt, wenn eine nichtnegative Konstante C existiert, sodass die Norm von Tx für alle x durch C mal der Norm von x beschränkt wird.', '\\|Tx\\|_Y\\leq C\\|x\\|_X', '\\|Tx\\|_Y\\leq C\\|x\\|_X', 'literature', 73, 'X und Y sind normierte Vektorräume über demselben Skalarkörper; T:X nach Y ist linear.', 'Entspricht Gleichungen 3.207 und 3.208.', 'verified', 14),
(72, '3.2.72', 36, 'Operatornorm', 'Die Operatornorm eines beschränkten linearen Operators ist das Supremum der Normen seiner Bilder auf der abgeschlossenen Einheitskugel des Ausgangsraumes.', '\\|T\\|=\\sup_{\\|x\\|_X\\leq1}\\|Tx\\|_Y', '\\|T\\|=\\sup_{\\|x\\|_X\\leq1}\\|Tx\\|_Y', 'literature', 73, 'T liegt in B(X,Y).', 'Entspricht Gleichungen 3.210 bis 3.212.', 'verified', 14),
(73, '3.2.73', 36, 'Raum beschränkter linearer Operatoren', 'B(X,Y) bezeichnet den Vektorraum aller linearen und beschränkten Operatoren von einem normierten Vektorraum X in einen normierten Vektorraum Y.', '\\mathcal B(X,Y)=\\{T:X\\to Y\\mid T\\text{ linear und beschränkt}\\}', '\\mathcal B(X,Y)=\\{T:X\\to Y\\mid T\\text{ linear und beschränkt}\\}', 'literature', 73, 'X und Y sind normierte Vektorräume über demselben Skalarkörper.', 'Entspricht Gleichungen 3.213 bis 3.215.', 'verified', 14),
(74, '3.2.74', 36, 'Dualnorm', 'Die Dualnorm eines stetigen linearen Funktionals ist seine Operatornorm als Element von B(X,K).', '\\|\\varphi\\|=\\sup_{\\|x\\|_X\\leq1}|\\varphi(x)|', '\\|\\varphi\\|=\\sup_{\\|x\\|_X\\leq1}|\\varphi(x)|', 'literature', 73, 'varphi liegt im stetigen Dualraum X*.', 'Entspricht Gleichungen 3.218 und 3.219.', 'verified', 14),
(75, '3.2.75', 36, 'Algebra beschränkter Operatoren', 'Für einen normierten Raum X bezeichnet B(X)=B(X,X) die beschränkten linearen Operatoren auf X. Zusammen mit Addition, Skalarmultiplikation und Komposition bilden sie eine normierte Operatoralgebra; bei vollständigem X eine Banachalgebra.', '\\mathcal B(X)=\\mathcal B(X,X)', '\\mathcal B(X)=\\mathcal B(X,X)', 'literature', 73, 'X ist ein normierter Vektorraum; für die Banachalgebra-Aussage ist X vollständig.', 'Entspricht Gleichungen 3.233 bis 3.235.', 'verified', 14),
(76, '3.2.76', 37, 'Eigenwert und Eigenvektor', 'Ein Skalar lambda heißt Eigenwert eines linearen Operators T:X nach X, wenn ein von null verschiedener Vektor v existiert, der durch T lediglich mit lambda skaliert wird. Jeder solche Vektor heißt Eigenvektor zu lambda.', '\\lambda\\text{ ist Eigenwert von }T\\Longleftrightarrow\\exists v\\in X\\setminus\\{0\\}:Tv=\\lambda v', '\\lambda\\text{ ist Eigenwert von }T\\Longleftrightarrow\\exists v\\in X\\setminus\\{0\\}:Tv=\\lambda v', 'literature', 72, 'T:X nach X ist linear; X ist Vektorraum über K.', 'Entspricht Gleichungen 3.246 und 3.247.', 'verified', 15),
(77, '3.2.77', 37, 'Eigenraum', 'Der Eigenraum zum Eigenwert lambda ist der Kern von T-lambda I und enthält sämtliche Eigenvektoren zu lambda sowie den Nullvektor.', 'E_\\lambda=\\ker(T-\\lambda I)=\\{v\\in X\\mid Tv=\\lambda v\\}', 'E_\\lambda=\\ker(T-\\lambda I)=\\{v\\in X\\mid Tv=\\lambda v\\}', 'literature', 72, 'lambda ist Eigenwert von T.', 'Entspricht Gleichung 3.248.', 'verified', 15),
(78, '3.2.78', 37, 'Charakteristisches Polynom', 'Für eine quadratische Matrix A wird das charakteristische Polynom durch die Determinante von A-lambda I definiert.', 'p_A(\\lambda)=\\det(A-\\lambda I)', 'p_A(\\lambda)=\\det(A-\\lambda I)', 'literature', 72, 'A ist eine quadratische Matrix.', 'Entspricht Gleichungen 3.252 bis 3.254.', 'verified', 15),
(79, '3.2.79', 37, 'Algebraische und geometrische Vielfachheit', 'Die algebraische Vielfachheit eines Eigenwertes ist seine Vielfachheit als Nullstelle des charakteristischen Polynoms. Die geometrische Vielfachheit ist die Dimension des zugehörigen Eigenraumes.', 'm_{\\mathrm{geom}}(\\lambda)=\\dim E_\\lambda=\\dim\\ker(A-\\lambda I)', 'm_{\\mathrm{geom}}(\\lambda)=\\dim E_\\lambda=\\dim\\ker(A-\\lambda I)', 'literature', 72, 'A ist endlichdimensional und lambda ein Eigenwert.', 'Entspricht Gleichungen 3.255 und 3.256.', 'verified', 15),
(80, '3.2.80', 37, 'Diagonalisierbarer Operator', 'Eine quadratische Matrix beziehungsweise der dargestellte lineare Operator heißt diagonalisierbar, wenn eine invertierbare Basiswechselmatrix P und eine Diagonalmatrix D existieren, sodass A=PDP^{-1}.', 'A=PDP^{-1}', 'A=PDP^{-1}', 'literature', 72, 'A ist eine quadratische Matrix über K.', 'Entspricht Gleichungen 3.257 und 3.258.', 'verified', 15),
(81, '3.2.81', 37, 'Resolventenmenge', 'Für einen beschränkten Operator T auf einem komplexen Banachraum ist die Resolventenmenge die Menge aller lambda, für die lambda I-T bijektiv ist und einen beschränkten inversen Operator besitzt.', '\\rho(T)=\\{\\lambda\\in\\mathbb C\\mid \\lambda I-T\\text{ bijektiv und }(\\lambda I-T)^{-1}\\in\\mathcal B(X)\\}', '\\rho(T)=\\{\\lambda\\in\\mathbb C\\mid \\lambda I-T\\text{ bijektiv und }(\\lambda I-T)^{-1}\\in\\mathcal B(X)\\}', 'literature', 73, 'X ist ein komplexer Banachraum; T liegt in B(X).', 'Entspricht Gleichungen 3.261 und 3.262.', 'verified', 15),
(82, '3.2.82', 37, 'Spektrum eines beschränkten Operators', 'Das Spektrum eines beschränkten Operators ist das Komplement seiner Resolventenmenge im komplexen Zahlenkörper.', '\\sigma(T)=\\mathbb C\\setminus\\rho(T)', '\\sigma(T)=\\mathbb C\\setminus\\rho(T)', 'literature', 73, 'X ist komplexer Banachraum; T liegt in B(X).', 'Entspricht Gleichungen 3.263 und 3.264.', 'verified', 15),
(83, '3.2.83', 37, 'Punktspektrum', 'Das Punktspektrum besteht aus den Eigenwerten des Operators, also aus den lambda mit nichttrivialem Kern von T-lambda I.', '\\sigma_p(T)=\\{\\lambda\\in\\mathbb C\\mid\\ker(T-\\lambda I)\\neq\\{0\\}\\}', '\\sigma_p(T)=\\{\\lambda\\in\\mathbb C\\mid\\ker(T-\\lambda I)\\neq\\{0\\}\\}', 'literature', 73, 'T liegt in B(X).', 'Entspricht Gleichungen 3.265 bis 3.268.', 'verified', 15),
(84, '3.2.84', 37, 'Spektralradius', 'Der Spektralradius eines beschränkten Operators ist das Supremum der Beträge seiner Spektralwerte.', 'r(T)=\\sup_{\\lambda\\in\\sigma(T)}|\\lambda|', 'r(T)=\\sup_{\\lambda\\in\\sigma(T)}|\\lambda|', 'literature', 73, 'T liegt in B(X) auf einem komplexen Banachraum.', 'Entspricht Gleichungen 3.271 bis 3.273.', 'verified', 15),
(85, '3.2.85', 37, 'Invarianter Teilraum', 'Ein linearer Teilraum M heißt invariant unter T, wenn die Operatorwirkung jedes Element von M wieder nach M abbildet.', 'M\\text{ ist }T\\text{-invariant}\\Longleftrightarrow T(M)\\subseteq M', 'M\\text{ ist }T\\text{-invariant}\\Longleftrightarrow T(M)\\subseteq M', 'literature', 73, 'M ist linearer Teilraum von X; T:X nach X ist linear.', 'Entspricht Gleichungen 3.277 und 3.278.', 'verified', 15),
(86, '3.2.86', 38, 'Orthogonales Komplement', 'Für eine Teilmenge M eines Hilbertraumes H ist M^perp die Menge aller Vektoren, die zu jedem Element von M orthogonal sind.', 'M^\\perp=\\left\\{x\\in H\\;\\middle|\\;\\langle x,m\\rangle=0\\text{ für alle }m\\in M\\right\\}', 'M^\\perp=\\left\\{x\\in H\\;\\middle|\\;\\langle x,m\\rangle=0\\text{ für alle }m\\in M\\right\\}', 'literature', 73, 'H ist ein Hilbertraum; M ist Teilmenge von H.', 'Entspricht Gleichungen 3.282 bis 3.284.', 'verified', 16),
(87, '3.2.87', 38, 'Orthogonale direkte Summe', 'H=M op⊥ N bedeutet, dass jedes Element von H eindeutig als Summe eines Elements aus M und eines dazu orthogonalen Elements aus N dargestellt werden kann.', 'H=M\\oplus^\\perp N', 'H=M\\oplus^\\perp N', 'literature', 73, 'M und N sind lineare Teilräume eines Hilbertraumes H.', 'Entspricht Gleichungen 3.285 und 3.286.', 'verified', 16),
(88, '3.2.88', 38, 'Projektionsoperator', 'Ein linearer Operator P:X nach X heißt Projektion, wenn er idempotent ist, also P^2=P erfüllt.', 'P^2=P', 'P^2=P', 'literature', 73, 'P:X nach X ist linear.', 'Entspricht Gleichungen 3.291 und 3.292.', 'verified', 16),
(89, '3.2.89', 38, 'Orthogonale Projektion', 'Für einen abgeschlossenen Teilraum M eines Hilbertraumes ordnet die orthogonale Projektion P_M jedem x den eindeutig bestimmten Anteil m in der Zerlegung x=m+n mit m in M und n in M^perp zu.', 'P_Mx=m', 'P_Mx=m', 'literature', 73, 'H ist Hilbertraum; M ist abgeschlossener linearer Teilraum.', 'Entspricht Gleichungen 3.298 bis 3.304.', 'verified', 16),
(90, '3.2.90', 38, 'Reduzierender Teilraum', 'Ein abgeschlossener Teilraum M eines Hilbertraumes reduziert T, wenn sowohl M als auch M^perp unter T invariant sind.', 'T(M)\\subseteq M\\qquad\\text{und}\\qquad T(M^\\perp)\\subseteq M^\\perp', 'T(M)\\subseteq M\\qquad\\text{und}\\qquad T(M^\\perp)\\subseteq M^\\perp', 'literature', 73, 'T liegt in B(H); M ist abgeschlossener linearer Teilraum von H.', 'Entspricht Gleichungen 3.322 und 3.323.', 'verified', 16),
(91, '3.2.99', 39, 'Gewöhnliche Differentialgleichung', 'Eine gewöhnliche Differentialgleichung ist eine Gleichung für eine unbekannte Funktion einer einzelnen unabhängigen Variablen, in der Ableitungen dieser Funktion auftreten.', 'F\\left(t,x(t),x\'(t),\\ldots,x^{(k)}(t)\\right)=0', 'F\\left(t,x(t),x\'(t),\\ldots,x^{(k)}(t)\\right)=0', 'literature', 75, 'Die unbekannte Funktion kann skalar- oder vektorwertig sein.', 'Entspricht Gleichung 3.383.', 'verified', 17),
(92, '3.2.100', 39, 'Autonomes Differentialgleichungssystem', 'Ein gewöhnliches Differentialgleichungssystem heißt autonom, wenn seine rechte Seite nicht explizit von der unabhängigen Variablen abhängt.', 'x\'(t)=F(x(t))', 'x\'(t)=F(x(t))', 'literature', 75, 'F hängt nur vom Zustand x ab.', 'Entspricht Gleichungen 3.386 und 3.387.', 'verified', 17),
(93, '3.2.101', 39, 'Klassische Lösung einer ODE', 'Eine hinreichend differenzierbare Funktion heißt klassische Lösung einer gewöhnlichen Differentialgleichung, wenn sie die Gleichung auf ihrem Definitionsintervall punktweise erfüllt.', 'x\'(t)=F(t,x(t))', 'x\'(t)=F(t,x(t))', 'literature', 75, 'x ist auf einem Intervall I_0 differenzierbar und erfüllt die Differentialgleichung punktweise.', 'Entspricht Gleichungen 3.388 und 3.389.', 'verified', 17),
(94, '3.2.102', 39, 'Anfangswertproblem', 'Ein Anfangswertproblem erster Ordnung besteht aus einer gewöhnlichen Differentialgleichung und einer vorgeschriebenen Anfangsbedingung x(t_0)=x_0.', '\\begin{cases}x\'(t)=F(t,x(t)),\\\\x(t_0)=x_0.\\end{cases}', '\\begin{cases}x\'(t)=F(t,x(t)),\\\\x(t_0)=x_0.\\end{cases}', 'literature', 75, 'F ist auf einem geeigneten Gebiet definiert; t_0 und x_0 sind vorgegeben.', 'Entspricht Gleichungen 3.390 bis 3.393.', 'verified', 17),
(95, '3.2.103', 39, 'Maximale Lösung', 'Eine Lösung eines Anfangswertproblems heißt maximal, wenn ihr Definitionsintervall nicht zu einem größeren Intervall erweitert werden kann, auf dem sie weiterhin die Differentialgleichung erfüllt.', '\\text{maximale Lösung}=\\text{nicht weiter fortsetzbare Lösung auf einem größeren Intervall}', '\\text{maximale Lösung}=\\text{nicht weiter fortsetzbare Lösung auf einem größeren Intervall}', 'literature', 75, 'Es liegt ein gewöhnliches Differentialgleichungsproblem mit einer bereits existierenden Lösung vor.', 'Entspricht der Unterscheidung in Gleichung 3.396.', 'verified', 17),
(96, '3.2.104', 39, 'Gleichgewicht eines autonomen Systems', 'Für ein autonomes System x\'=F(x) heißt x_* Gleichgewichtszustand, wenn F(x_*)=0 gilt.', 'F(x_*)=0', 'F(x_*)=0', 'literature', 75, 'Das System ist autonom.', 'Entspricht Gleichungen 3.398 bis 3.400.', 'verified', 17),
(97, '3.2.105', 39, 'Partielle Differentialgleichung', 'Eine partielle Differentialgleichung ist eine Gleichung für eine unbekannte Funktion mehrerer unabhängiger Variablen, in der partielle Ableitungen dieser Funktion auftreten.', 'F\\left(x,u(x),Du(x),D^2u(x),\\ldots,D^ku(x)\\right)=0', 'F\\left(x,u(x),Du(x),D^2u(x),\\ldots,D^ku(x)\\right)=0', 'literature', 76, 'u ist auf einem Gebiet Omega in R^n definiert und besitzt die für die Gleichung benötigten partiellen Ableitungen.', 'Entspricht Gleichung 3.405.', 'verified', 17),
(98, '3.2.106', 39, 'Ordnung einer Differentialgleichung', 'Die Ordnung einer Differentialgleichung ist die höchste Ableitungsordnung, die in der Gleichung auftritt.', '\\operatorname{ord}(F)=\\text{höchste auftretende Ableitungsordnung}', '\\operatorname{ord}(F)=\\text{höchste auftretende Ableitungsordnung}', 'literature', 76, 'Die Differentialgleichung enthält endlich viele Ableitungsordnungen.', 'Entspricht den im Text unmittelbar nach Definition 3.2.106 angegebenen Formen erster und zweiter Ordnung.', 'verified', 17),
(99, '3.2.107', 39, 'Klassische Lösung einer partiellen Differentialgleichung', 'Eine Funktion heißt klassische Lösung einer partiellen Differentialgleichung, wenn alle in der Gleichung benötigten Ableitungen im klassischen Sinn existieren und die Gleichung punktweise auf dem Definitionsgebiet erfüllt ist.', 'F(x,u,Du,D^2u)=0', 'F(x,u,Du,D^2u)=0', 'literature', 76, 'u besitzt mindestens die für den jeweiligen Differentialausdruck erforderliche klassische Regularität.', 'Entspricht Gleichung 3.406.', 'verified', 17),
(100, '3.2.108', 39, 'Randbedingung', 'Eine Randbedingung schränkt die zulässige Lösung einer partiellen Differentialgleichung auf dem Rand des Definitionsgebietes oder über dort definierte Ableitungen ein.', 'u|_{\\partial\\Omega}=g', 'u|_{\\partial\\Omega}=g', 'literature', 76, 'Omega besitzt einen für die betrachtete Randbedingung geeigneten Rand.', 'Entspricht Gleichungen 3.412 und 3.413.', 'verified', 17),
(101, '3.2.109', 39, 'Wohlgestelltes Problem', 'Ein Differentialproblem heißt im klassischen Sinn wohlgestellt, wenn eine Lösung existiert, eindeutig ist und stetig von den vorgegebenen Daten abhängt.', '\\text{Wohlgestelltheit}=\\text{Existenz}+\\text{Eindeutigkeit}+\\text{stetige Datenabhängigkeit}', '\\text{Wohlgestelltheit}=\\text{Existenz}+\\text{Eindeutigkeit}+\\text{stetige Datenabhängigkeit}', 'literature', 76, 'Daten- und Lösungsräume sowie die zugehörigen Normen oder Topologien sind festgelegt.', 'Entspricht Gleichung 3.427.', 'verified', 17),
(102, '3.2.110', 40, 'Dynamisches System', 'Ein dynamisches System ist eine mit einer Halbgruppen- beziehungsweise Gruppenstruktur verträgliche Familie von Zustandsabbildungen auf einem Zustandsraum M.', 'T:G\\times M\\longrightarrow M,\\qquad(g,x)\\longmapsto T_g(x)', 'T:G\\times M\\longrightarrow M,\\qquad(g,x)\\longmapsto T_g(x)', 'literature', 75, 'G wirkt auf M; die Zustandsabbildungen erfüllen die Kompositionsstruktur.', 'Entspricht Gleichungen 3.442 und 3.443.', 'verified', 18),
(103, '3.2.111', 40, 'Fluss', 'Ein globaler Fluss auf einem Zustandsraum M ist eine durch reelle Parameter indizierte Familie von Zustandsabbildungen mit Identität bei Parameter null und der Gruppenverkettung Phi_{t+s}=Phi_t o Phi_s.', '\\Phi_0=I_M,\\qquad\\Phi_{t+s}=\\Phi_t\\circ\\Phi_s', '\\Phi_0=I_M,\\qquad\\Phi_{t+s}=\\Phi_t\\circ\\Phi_s', 'literature', 75, 'Der Fluss ist für alle reellen Parameterwerte definiert.', 'Entspricht Gleichungen 3.447 und 3.448.', 'verified', 18),
(104, '3.2.112', 40, 'Lokaler Fluss', 'Ein lokaler Fluss ist eine Flussstruktur, die nur auf einer geeigneten Teilmenge W von R mal M definiert ist und die Flusseigenschaft überall dort erfüllt, wo alle beteiligten Ausdrücke definiert sind.', 'W\\subseteq\\mathbb R\\times M', 'W\\subseteq\\mathbb R\\times M', 'literature', 75, 'Die maximalen Lösungen müssen nicht für alle Parameterwerte existieren.', 'Entspricht Gleichung 3.453 und dem unmittelbar vorausgehenden Definitionskontext.', 'verified', 18),
(105, '3.2.113', 40, 'Vollständiges Vektorfeld', 'Ein Vektorfeld beziehungsweise autonomes Differentialgleichungssystem heißt vollständig, wenn seine maximale Lösung für jeden Anfangszustand für alle reellen Parameterwerte existiert.', '\\text{Vollständigkeit}\\Longrightarrow\\Phi:\\mathbb R\\times M\\longrightarrow M', '\\text{Vollständigkeit}\\Longrightarrow\\Phi:\\mathbb R\\times M\\longrightarrow M', 'literature', 75, 'Das autonome System besitzt für jeden Anfangszustand globale Lösungen.', 'Entspricht Gleichung 3.454.', 'verified', 18);
INSERT INTO `definitions` (`definition_id`, `definition_number`, `section_id`, `title`, `definition_text`, `formal_latex`, `word_latex`, `provenance`, `source_id`, `assumptions`, `notes`, `validation_status`, `created_revision_id`) VALUES
(106, '3.2.114', 40, 'Semifluss', 'Ein Semifluss ist eine nur für nichtnegative Parameterwerte definierte Familie von Zustandsabbildungen mit Identität bei null und Halbgruppenverkettung.', '\\Phi_0=I_M,\\qquad\\Phi_{t+s}=\\Phi_t\\circ\\Phi_s\\qquad\\text{für }s,t\\geq0', '\\Phi_0=I_M,\\qquad\\Phi_{t+s}=\\Phi_t\\circ\\Phi_s\\qquad\\text{für }s,t\\geq0', 'literature', 75, 'Die Parameterwerte sind auf t>=0 beschränkt.', 'Entspricht Gleichung 3.457.', 'verified', 18),
(107, '3.2.115', 40, 'Trajektorie', 'Die Trajektorie eines Anfangszustandes x_0 ist die parametrisierte Zustandskurve gamma_{x_0}(t)=Phi(t,x_0).', '\\gamma_{x_0}(t)=\\Phi(t,x_0)', '\\gamma_{x_0}(t)=\\Phi(t,x_0)', 'literature', 75, 'Ein Fluss oder Semifluss Phi und ein Anfangszustand x_0 sind gegeben.', 'Entspricht Gleichungen 3.458 und 3.459.', 'verified', 18),
(108, '3.2.116', 40, 'Orbit', 'Der Orbit eines Zustandes ist die Menge der unter dem Fluss von diesem Zustand erreichten Zustände; für einen Semifluss wird entsprechend der positive Orbit verwendet.', '\\mathcal O(x)=\\{\\Phi_t(x)\\mid t\\in\\mathbb R\\}', '\\mathcal O(x)=\\{\\Phi_t(x)\\mid t\\in\\mathbb R\\}', 'literature', 75, 'Ein globaler Fluss beziehungsweise Semifluss ist gegeben.', 'Entspricht Gleichungen 3.460 bis 3.463.', 'verified', 18),
(109, '3.2.117', 40, 'Fixpunkt eines Flusses', 'Ein Zustand x_* heißt Fixpunkt eines Flusses, wenn er durch jede Flussabbildung unverändert bleibt.', '\\Phi_t(x_*)=x_*\\qquad\\text{für alle }t', '\\Phi_t(x_*)=x_*\\qquad\\text{für alle }t', 'literature', 75, 'Ein Fluss Phi auf M ist gegeben.', 'Entspricht Gleichungen 3.466 bis 3.468.', 'verified', 18),
(110, '3.2.118', 40, 'Invariante und vorwärtsinvariante Menge', 'Eine Teilmenge A eines Zustandsraumes heißt unter einem globalen Fluss invariant, wenn Phi_t(A)=A für alle t gilt; sie heißt vorwärtsinvariant, wenn Phi_t(A) Teilmenge A für alle t>=0 gilt.', '\\Phi_t(A)=A\\qquad\\text{für alle }t\\in\\mathbb R', '\\Phi_t(A)=A\\qquad\\text{für alle }t\\in\\mathbb R', 'literature', 75, 'Ein globaler Fluss beziehungsweise Semifluss ist gegeben.', 'Entspricht Gleichungen 3.469 und 3.470.', 'verified', 18),
(111, '3.2.119', 40, 'Periodischer Zustand und periodischer Orbit', 'Ein nichtstationärer Zustand heißt periodisch, wenn nach einem positiven Parameter T wieder derselbe Zustand erreicht wird; der zugehörige Orbit heißt periodischer Orbit.', '\\Phi_T(x)=x,\\qquad T>0', '\\Phi_T(x)=x,\\qquad T>0', 'literature', 75, 'x ist kein Fixpunkt und Phi ist eine geeignete Zustandsentwicklung.', 'Entspricht Gleichungen 3.472 bis 3.474.', 'verified', 18),
(112, '3.2.120', 40, 'Zweiparametriger Evolutionsoperator', 'Ein zweiparametriger Evolutionsoperator U(t,s) bildet einen bei s gegebenen Zustand auf den bei t erreichten Zustand ab und erfüllt U(s,s)=I sowie die Verkettung U(t,s) o U(s,r)=U(t,r).', 'U(t,s)x_s=x(t)', 'U(t,s)x_s=x(t)', 'literature', 75, 'Eine eindeutig bestimmte nichtautonome Zustandsentwicklung ist gegeben.', 'Entspricht Gleichungen 3.489 bis 3.493.', 'verified', 18),
(113, '3.2.121', 41, 'Lyapunov-stabiles Gleichgewicht', 'Ein Gleichgewicht x_* eines dynamischen Systems auf einem metrischen Zustandsraum heißt Lyapunov-stabil, wenn zu jeder vorgegebenen Umgebungsschranke epsilon eine Anfangsschranke delta existiert, sodass alle für t>=0 entwickelten Zustände aus der delta-Umgebung in der epsilon-Umgebung des Gleichgewichts bleiben.', 'd(x_0,x_*)<\\delta\\Longrightarrow d(\\Phi_t(x_0),x_*)<\\varepsilon\\qquad\\text{für alle }t\\geq0', 'd(x_0,x_*)<\\delta\\Longrightarrow d(\\Phi_t(x_0),x_*)<\\varepsilon\\qquad\\text{für alle }t\\geq0', 'literature', 75, 'X ist ein metrischer Zustandsraum; x_* ist ein Gleichgewicht; der betrachtete Fluss oder Semifluss ist für t>=0 definiert.', 'Entspricht Gleichungen 3.514 bis 3.516.', 'verified', 19),
(114, '3.2.122', 41, 'Asymptotisch stabiles Gleichgewicht', 'Ein Gleichgewicht heißt asymptotisch stabil, wenn es Lyapunov-stabil ist und zusätzlich alle Anfangszustände aus einer geeigneten Umgebung asymptotisch gegen das Gleichgewicht konvergieren.', 'x_0\\in U\\Longrightarrow\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*', 'x_0\\in U\\Longrightarrow\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*', 'literature', 75, 'x_* ist Lyapunov-stabil; U ist eine geeignete Umgebung von x_*.', 'Entspricht Gleichungen 3.517 bis 3.519.', 'verified', 19),
(115, '3.2.123', 41, 'Einzugsgebiet eines Gleichgewichts', 'Das Einzugsgebiet eines Gleichgewichts ist die Menge aller Anfangszustände, deren positive Trajektorien asymptotisch gegen dieses Gleichgewicht konvergieren.', '\\mathcal A(x_*)=\\left\\{x_0\\in X\\;\\middle|\\;\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*\\right\\}', '\\mathcal A(x_*)=\\left\\{x_0\\in X\\;\\middle|\\;\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*\\right\\}', 'literature', 75, 'Der positive Zustandsverlauf ist für die betrachteten Anfangszustände hinreichend lange definiert.', 'Entspricht Gleichung 3.520.', 'verified', 19),
(116, '3.2.124', 41, 'Global asymptotisch stabiles Gleichgewicht', 'Ein Gleichgewicht heißt bezüglich eines festgelegten Zustandsraumes global asymptotisch stabil, wenn es stabil ist und jeder Anfangszustand dieses Zustandsraumes asymptotisch gegen das Gleichgewicht konvergiert.', '\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*\\qquad\\text{für alle }x_0\\in X', '\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*\\qquad\\text{für alle }x_0\\in X', 'literature', 75, 'Der Zustandsraum X und die betrachtete Dynamik sind festgelegt.', 'Entspricht Gleichungen 3.521 und 3.522.', 'verified', 19),
(117, '3.2.125', 41, 'Exponentielle Stabilität', 'Ein Gleichgewicht heißt lokal exponentiell stabil, wenn der Abstand entwickelter Zustände zum Gleichgewicht in einer Umgebung durch eine exponentiell abklingende Schranke kontrolliert wird.', '\\|\\Phi_t(x_0)-x_*\\|\\leq Ce^{-\\alpha t}\\|x_0-x_*\\|', '\\|\\Phi_t(x_0)-x_*\\|\\leq Ce^{-\\alpha t}\\|x_0-x_*\\|', 'literature', 75, 'Der Zustandsraum ist normiert; C>=1, alpha>0; x_0 liegt in einer geeigneten Umgebung.', 'Entspricht Gleichungen 3.523 bis 3.525.', 'verified', 19),
(118, '3.2.126', 41, 'Instabiles Gleichgewicht', 'Ein Gleichgewicht heißt instabil, wenn es nicht Lyapunov-stabil ist; dann existiert eine feste Umgebungsschranke, die durch geeignet kleine Anfangsstörungen zu einem späteren Parameterwert verlassen werden kann.', 'd(x_0,x_*)<\\delta\\qquad\\text{und}\\qquad d(\\Phi_t(x_0),x_*)\\geq\\varepsilon_0', 'd(x_0,x_*)<\\delta\\qquad\\text{und}\\qquad d(\\Phi_t(x_0),x_*)\\geq\\varepsilon_0', 'literature', 75, 'x_* ist ein Gleichgewicht eines metrischen dynamischen Systems.', 'Entspricht Gleichung 3.526.', 'verified', 19),
(119, '3.2.127', 41, 'Positive Definitheit bezüglich eines Gleichgewichts', 'Eine skalare Funktion V heißt positiv definit bezüglich x_*, wenn V(x_*)=0 und V(x)>0 für alle anderen Zustände einer betrachteten Umgebung gilt.', 'V(x_*)=0,\\qquad V(x)>0\\text{ für }x\\neq x_*', 'V(x_*)=0,\\qquad V(x)>0\\text{ für }x\\neq x_*', 'literature', 75, 'V ist auf einer Umgebung U von x_* definiert.', 'Entspricht Gleichungen 3.536 und 3.537.', 'verified', 19),
(120, '3.2.128', 41, 'Lyapunov-Funktion', 'Eine geeignete stetige beziehungsweise differenzierbare Funktion V heißt Lyapunov-Funktion für ein Gleichgewicht, wenn sie dort positiv definit ist und ihr Wert entlang der betrachteten Zustandsentwicklung nicht zunimmt.', 'V(x)>0\\text{ für }x\\neq x_*,\\quad V(x_*)=0,\\quad\\dot V(x)\\leq0', 'V(x)>0\\text{ für }x\\neq x_*,\\quad V(x_*)=0,\\quad\\dot V(x)\\leq0', 'literature', 75, 'Die notwendige Regularität von V und der Dynamik ist gegeben.', 'Entspricht Gleichungen 3.538 bis 3.545.', 'verified', 19),
(121, '3.2.129', 41, 'Ableitung entlang des Vektorfeldes', 'Für ein differenzierbares autonomes System wird die Ableitung einer skalaren Funktion V entlang des Vektorfeldes f durch DV(x)f(x) definiert.', '\\dot V(x)=DV(x)\\,f(x)', '\\dot V(x)=DV(x)\\,f(x)', 'literature', 75, 'V und f besitzen die für die Kettenregel notwendige Differenzierbarkeit.', 'Entspricht Gleichungen 3.538 bis 3.540.', 'verified', 19),
(122, '3.2.130', 41, 'Hyperbolisches Gleichgewicht', 'Ein Gleichgewicht eines differenzierbaren endlichdimensionalen Systems heißt hyperbolisch, wenn die Jacobi-Matrix der Linearisierung keinen Eigenwert mit verschwindendem Realteil besitzt.', '\\sigma(Df(x_*))\\cap i\\mathbb R=\\varnothing', '\\sigma(Df(x_*))\\cap i\\mathbb R=\\varnothing', 'literature', 75, 'Das System ist endlichdimensional und in einer Umgebung von x_* hinreichend differenzierbar.', 'Entspricht Gleichungen 3.563 und 3.564.', 'verified', 19),
(123, '3.2.131', 42, 'Positive Omega-Grenzmenge', 'Die positive Omega-Grenzmenge eines Zustandes x ist die Menge aller Zustände y, die als Grenzwerte von Folgen Phi_{t_n}(x) mit t_n gegen plus unendlich auftreten.', '\\omega^+(x)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,t_n\\to+\\infty:\\Phi_{t_n}(x)\\to y\\right\\}', '\\omega^+(x)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,t_n\\to+\\infty:\\Phi_{t_n}(x)\\to y\\right\\}', 'literature', 75, 'Ein Fluss oder eine für positive Parameter definierte Dynamik ist gegeben.', 'Entspricht Gleichungen 3.581 und 3.582.', 'verified', 20),
(124, '3.2.132', 42, 'Negative Omega-Grenzmenge', 'Die negative Omega-Grenzmenge eines Zustandes x ist die Menge aller Zustände y, die als Grenzwerte von Folgen Phi_{t_n}(x) mit t_n gegen minus unendlich auftreten.', '\\omega^-(x)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,t_n\\to-\\infty:\\Phi_{t_n}(x)\\to y\\right\\}', '\\omega^-(x)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,t_n\\to-\\infty:\\Phi_{t_n}(x)\\to y\\right\\}', 'literature', 75, 'Ein globaler Fluss ist für negative Parameterwerte definiert.', 'Entspricht Gleichung 3.583.', 'verified', 20),
(125, '3.2.133', 42, 'Abstand eines Punktes von einer Menge', 'Der Abstand eines Punktes x von einer nichtleeren Teilmenge A eines metrischen Raumes ist das Infimum der Abstände von x zu allen Punkten aus A.', 'd(x,A)=\\inf_{a\\in A}d(x,a)', 'd(x,A)=\\inf_{a\\in A}d(x,a)', 'literature', 75, 'A ist nichtleer und d ist eine Metrik.', 'Entspricht Gleichungen 3.590 und 3.591.', 'verified', 20),
(126, '3.2.134', 42, 'Omega-Grenzmenge einer Menge', 'Die positive Omega-Grenzmenge einer Menge X besteht aus allen Zuständen y, für die Folgen x_n in X und t_n gegen plus unendlich existieren, sodass Phi_{t_n}(x_n) gegen y konvergiert.', '\\omega^+(X)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,x_n\\in X,\\;t_n\\to+\\infty:\\Phi_{t_n}(x_n)\\to y\\right\\}', '\\omega^+(X)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,x_n\\in X,\\;t_n\\to+\\infty:\\Phi_{t_n}(x_n)\\to y\\right\\}', 'literature', 75, 'Eine positive Zustandsentwicklung ist gegeben.', 'Entspricht Gleichungen 3.596 und 3.597.', 'verified', 20),
(127, '3.2.135', 42, 'Stabile Menge einer invarianten Menge', 'Die stabile Menge W^+(Lambda) einer invarianten Menge Lambda enthält diejenigen Zustände, deren Abstand zu Lambda entlang der positiven Zustandsentwicklung gegen null konvergiert.', 'W^+(\\Lambda)=\\left\\{x\\in M\\;\\middle|\\;\\lim_{t\\to+\\infty}d(\\Phi_t(x),\\Lambda)=0\\right\\}', 'W^+(\\Lambda)=\\left\\{x\\in M\\;\\middle|\\;\\lim_{t\\to+\\infty}d(\\Phi_t(x),\\Lambda)=0\\right\\}', 'literature', 75, 'Lambda ist invariant und der Abstand zur Menge ist definiert.', 'Entspricht Gleichungen 3.598 und 3.599.', 'verified', 20),
(128, '3.2.136', 42, 'Anziehende Menge', 'Eine invariante Menge Lambda heißt anziehend, wenn ihre stabile Menge eine Umgebung von Lambda enthält beziehungsweise eine Umgebung von Lambda bildet.', 'd(\\Phi_t(x),\\Lambda)\\longrightarrow0\\qquad(t\\to\\infty)', 'd(\\Phi_t(x),\\Lambda)\\longrightarrow0\\qquad(t\\to\\infty)', 'literature', 75, 'Lambda ist invariant; die betrachteten Anfangszustände liegen in einer geeigneten Umgebung.', 'Entspricht Gleichung 3.600.', 'verified', 20),
(129, '3.2.137', 42, 'Einzugsgebiet einer anziehenden Menge', 'Das Einzugsgebiet einer anziehenden Menge Lambda ist ihre stabile Menge W^+(Lambda), also die Menge der Anfangszustände, deren Trajektorien sich Lambda asymptotisch annähern.', '\\mathcal B(\\Lambda)=W^+(\\Lambda)', '\\mathcal B(\\Lambda)=W^+(\\Lambda)', 'literature', 75, 'Lambda ist eine anziehende invariante Menge.', 'Entspricht Gleichungen 3.601 und 3.602.', 'verified', 20),
(130, '3.2.138', 42, 'Fanggebiet', 'Eine offene zusammenhängende Menge E mit kompakter Abschließung heißt Fanggebiet, wenn sie durch die positive Zustandsentwicklung für alle t>0 in sich selbst abgebildet wird.', '\\Phi_t(E)\\subseteq E\\qquad\\text{für alle }t>0', '\\Phi_t(E)\\subseteq E\\qquad\\text{für alle }t>0', 'literature', 75, 'E ist offen, zusammenhängend und besitzt kompakte Abschließung.', 'Entspricht Gleichung 3.603.', 'verified', 20),
(131, '3.2.139', 42, 'Topologische Transitivität', 'Eine abgeschlossene invariante Menge Lambda heißt topologisch transitiv, wenn für beliebige nichtleere relativ offene Teilmengen U und V von Lambda ein Parameter t existiert, sodass Phi_t(U) den Bereich V trifft.', '\\Phi_t(U)\\cap V\\neq\\varnothing', '\\Phi_t(U)\\cap V\\neq\\varnothing', 'literature', 75, 'Lambda ist abgeschlossen und invariant; U und V sind nichtleere relativ offene Teilmengen von Lambda.', 'Entspricht Gleichung 3.606.', 'verified', 20),
(132, '3.2.140', 42, 'Attraktor', 'Ein Attraktor ist im hier verwendeten Sinn eine anziehende invariante Menge, die zusätzlich topologisch transitiv ist.', '\\text{Attraktor}=\\text{anziehende Menge}+\\text{topologische Transitivität}', '\\text{Attraktor}=\\text{anziehende Menge}+\\text{topologische Transitivität}', 'literature', 75, 'Die zugrunde liegende Menge ist invariant, anziehend und topologisch transitiv.', 'Entspricht Gleichungen 3.607 bis 3.609.', 'verified', 20),
(133, '3.2.141', 43, 'Topologische n-Mannigfaltigkeit', 'Eine topologische n-Mannigfaltigkeit ist ein Hausdorff-Raum mit abzählbarer Basis, der lokal homöomorph zu R^n ist.', '\\varphi:U\\longrightarrow\\widehat U\\subseteq\\mathbb R^n', '\\varphi:U\\longrightarrow\\widehat U\\subseteq\\mathbb R^n', 'literature', 77, 'M ist Hausdorff, besitzt eine abzählbare Basis und ist lokal euklidisch der Dimension n.', 'Entspricht Gleichung 3.631.', 'verified', 21),
(134, '3.2.142', 43, 'Karte und lokale Koordinaten', 'Ein Paar (U,phi) aus einer offenen Teilmenge U einer Mannigfaltigkeit und einem Homöomorphismus phi von U auf eine offene Teilmenge von R^n heißt Karte; die Komponenten von phi heißen lokale Koordinaten.', '\\varphi(p)=\\bigl(x^1(p),\\ldots,x^n(p)\\bigr)', '\\varphi(p)=\\bigl(x^1(p),\\ldots,x^n(p)\\bigr)', 'literature', 77, 'U ist offen in M und phi ist ein Homöomorphismus auf eine offene Teilmenge von R^n.', 'Entspricht Gleichung 3.632.', 'verified', 21),
(135, '3.2.143', 43, 'Glatt verträgliche Karten', 'Zwei Karten heißen glatt verträglich, wenn der Kartenwechsel zwischen ihren überlappenden Koordinatendarstellungen und dessen Inverse glatt sind.', '\\psi\\circ\\varphi^{-1}:\\varphi(U\\cap V)\\longrightarrow\\psi(U\\cap V)', '\\psi\\circ\\varphi^{-1}:\\varphi(U\\cap V)\\longrightarrow\\psi(U\\cap V)', 'literature', 77, 'Die Kartenbereiche überlappen; die Kartenwechsel sind als Abbildungen zwischen offenen Teilmengen euklidischer Räume definiert.', 'Entspricht Gleichung 3.633.', 'verified', 21),
(136, '3.2.144', 43, 'Glatter Atlas', 'Ein glatter Atlas auf einer topologischen Mannigfaltigkeit ist eine Familie paarweise glatt verträglicher Karten, deren Kartenbereiche die gesamte Mannigfaltigkeit überdecken.', 'M=\\bigcup_{(U,\\varphi)\\in\\mathcal A}U', 'M=\\bigcup_{(U,\\varphi)\\in\\mathcal A}U', 'literature', 77, 'Die Karten sind paarweise glatt verträglich.', 'Entspricht Gleichung 3.634.', 'verified', 21),
(137, '3.2.145', 43, 'Glatte Struktur und glatte Mannigfaltigkeit', 'Eine glatte Struktur ist ein maximaler glatter Atlas; eine topologische n-Mannigfaltigkeit zusammen mit einer solchen glatten Struktur heißt glatte beziehungsweise differenzierbare n-Mannigfaltigkeit.', '(M,\\mathcal A)', '(M,\\mathcal A)', 'literature', 77, 'M ist eine topologische n-Mannigfaltigkeit und A ein maximaler glatter Atlas.', 'Entspricht Gleichung 3.635.', 'verified', 21),
(138, '3.2.146', 43, 'Glatte Abbildung', 'Eine Abbildung zwischen glatten Mannigfaltigkeiten heißt glatt, wenn ihre Darstellung in beliebigen kompatiblen lokalen Karten eine glatte Abbildung zwischen offenen Teilmengen euklidischer Räume ist.', '\\widehat F=\\psi\\circ F\\circ\\varphi^{-1}', '\\widehat F=\\psi\\circ F\\circ\\varphi^{-1}', 'literature', 77, 'M und N sind glatte Mannigfaltigkeiten und die verwendeten Karten gehören zu ihren glatten Strukturen.', 'Entspricht Gleichung 3.637.', 'verified', 21),
(139, '3.2.147', 43, 'Tangentialvektor als Derivation', 'Ein Tangentialvektor an einer glatten Mannigfaltigkeit im Punkt p ist eine lineare Abbildung auf glatten reellwertigen Funktionen, die im Punkt p die Leibniz-Regel erfüllt.', 'v(fg)=f(p)\\,v(g)+g(p)\\,v(f)', 'v(fg)=f(p)\\,v(g)+g(p)\\,v(f)', 'literature', 77, 'p liegt in M; v wirkt linear auf glatten reellwertigen Funktionen.', 'Entspricht Gleichungen 3.640 und 3.641.', 'verified', 21),
(140, '3.2.148', 43, 'Tangentialraum', 'Der Tangentialraum T_pM ist die Menge aller Tangentialvektoren an M im Punkt p; mit punktweiser Addition und Skalarmultiplikation ist er ein reeller Vektorraum.', 'T_pM=\\{v\\mid v\\text{ ist Tangentialvektor an }M\\text{ in }p\\}', 'T_pM=\\{v\\mid v\\text{ ist Tangentialvektor an }M\\text{ in }p\\}', 'literature', 77, 'p liegt in der glatten Mannigfaltigkeit M.', 'Entspricht Gleichung 3.642 und den nachfolgenden Vektorraumoperationen.', 'verified', 21),
(141, '3.2.149', 43, 'Tangentialvektor einer Kurve', 'Der Tangentialvektor einer glatten Kurve gamma im Parameterwert t_0 wird durch die Ableitung der Komposition jeder glatten Funktion mit gamma definiert.', '\\gamma\'(t_0)(f)=\\left.\\frac{d}{dt}(f\\circ\\gamma)(t)\\right|_{t=t_0}', '\\gamma\'(t_0)(f)=\\left.\\frac{d}{dt}(f\\circ\\gamma)(t)\\right|_{t=t_0}', 'literature', 77, 'gamma ist in einer Umgebung von t_0 glatt.', 'Entspricht Gleichungen 3.649 bis 3.652.', 'verified', 21),
(142, '3.2.150', 43, 'Differential beziehungsweise Pushforward', 'Das Differential einer glatten Abbildung F:M->N im Punkt p ist die lineare Abbildung dF_p:T_pM->T_{F(p)}N, die Tangentialvektoren des Ausgangsraumes auf Tangentialvektoren des Zielraumes abbildet.', 'dF_p:T_pM\\longrightarrow T_{F(p)}N', 'dF_p:T_pM\\longrightarrow T_{F(p)}N', 'literature', 77, 'F ist glatt und p liegt in M.', 'Entspricht Gleichungen 3.654 und 3.655.', 'verified', 21),
(143, '3.2.151', 43, 'Tangentialbündel', 'Das Tangentialbündel TM einer glatten Mannigfaltigkeit M ist die disjunkte Vereinigung aller Tangentialräume T_pM über den Punkten p von M.', 'TM=\\bigsqcup_{p\\in M}T_pM', 'TM=\\bigsqcup_{p\\in M}T_pM', 'literature', 77, 'M ist eine glatte Mannigfaltigkeit.', 'Entspricht Gleichungen 3.663 bis 3.665.', 'verified', 21),
(155, '3.2.152', 45, 'Symmetrische Bilinearform', 'Eine symmetrische Bilinearform auf einem endlichdimensionalen reellen Vektorraum V ist eine in beiden Argumenten lineare Abbildung g:V×V→R mit g(v,w)=g(w,v).', 'g:V\\times V\\longrightarrow\\mathbb R,\\qquad g(v,w)=g(w,v)', 'g:V\\times V\\longrightarrow\\mathbb R,\\qquad g(v,w)=g(w,v)', 'literature', 78, 'V ist ein endlichdimensionaler reeller Vektorraum.', 'Entspricht Gleichungen 3.686 bis 3.688.', 'verified', 23),
(156, '3.2.153', 45, 'Nichtausgeartete Bilinearform', 'Eine Bilinearform g heißt nicht ausgeartet, wenn aus g(v,w)=0 für alle w notwendig v=0 folgt.', '\\bigl(\\forall w\\in V:\\ g(v,w)=0\\bigr)\\Longrightarrow v=0', '\\bigl(\\forall w\\in V:\\ g(v,w)=0\\bigr)\\Longrightarrow v=0', 'literature', 78, 'g ist eine Bilinearform auf V.', 'Entspricht Gleichungen 3.689 bis 3.692.', 'verified', 23),
(157, '3.2.154', 45, 'Positive Definitheit', 'Eine symmetrische Bilinearform g heißt positiv definit, wenn g(v,v)>0 für jedes von null verschiedene v gilt.', 'g(v,v)>0\\qquad\\text{für jedes }v\\neq0', 'g(v,v)>0\\qquad\\text{für jedes }v\\neq0', 'literature', 78, 'g ist eine symmetrische reelle Bilinearform.', 'Entspricht Gleichungen 3.693 und 3.694.', 'verified', 23),
(158, '3.2.155', 45, 'Semi-riemannsche beziehungsweise pseudo-riemannsche Metrik', 'Eine semi-riemannsche beziehungsweise pseudo-riemannsche Metrik ordnet jedem Punkt p einer glatten Mannigfaltigkeit eine symmetrische, nicht ausgeartete Bilinearform g_p auf T_pM zu, die glatt von p abhängt und konstanten Index besitzt.', 'g_p:T_pM\\times T_pM\\longrightarrow\\mathbb R', 'g_p:T_pM\\times T_pM\\longrightarrow\\mathbb R', 'literature', 78, 'M ist eine glatte Mannigfaltigkeit; der Index der Bilinearformen ist konstant.', 'Entspricht Gleichungen 3.695 und 3.696.', 'verified', 23),
(159, '3.2.156', 45, 'Riemannsche Metrik', 'Eine pseudo-riemannsche Metrik heißt riemannsch, wenn sie auf jedem Tangentialraum positiv definit ist.', 'g_p(v,v)>0\\qquad\\text{für alle }v\\in T_pM\\setminus\\{0\\}', 'g_p(v,v)>0\\qquad\\text{für alle }v\\in T_pM\\setminus\\{0\\}', 'literature', 78, 'g ist eine glatte nicht ausgeartete symmetrische Metrik.', 'Entspricht Gleichungen 3.697 bis 3.701.', 'verified', 23),
(160, '3.2.157', 45, 'Index einer nicht ausgearteten symmetrischen Bilinearform', 'Der Index einer nicht ausgearteten symmetrischen Bilinearform ist die maximale Dimension eines Unterraumes, auf dem die Bilinearform negativ definit ist.', '\\operatorname{ind}(g)=r', '\\operatorname{ind}(g)=r', 'literature', 78, 'g ist eine nicht ausgeartete symmetrische Bilinearform.', 'Entspricht Gleichungen 3.706 bis 3.709.', 'verified', 23),
(161, '3.2.158', 45, 'Lorentzsche Metrik', 'Eine pseudo-riemannsche Metrik heißt in der verwendeten Vorzeichenkonvention lorentzsch, wenn ihr Index eins beträgt.', '\\operatorname{ind}(g)=1', '\\operatorname{ind}(g)=1', 'literature', 78, 'g ist eine pseudo-riemannsche Metrik; verwendet wird die Signaturkonvention (-,+,...,+).', 'Entspricht Gleichungen 3.710 und 3.711.', 'verified', 23),
(162, '3.2.159', 45, 'Metrikkoeffizienten', 'Die Metrikkoeffizienten g_ij sind die Werte der Metrik auf den lokalen Koordinatenbasisvektoren des Tangentialraumes.', 'g_{ij}(p)=g_p\\left(\\left.\\frac{\\partial}{\\partial x^i}\\right|_p,\\left.\\frac{\\partial}{\\partial x^j}\\right|_p\\right)', 'g_{ij}(p)=g_p\\left(\\left.\\frac{\\partial}{\\partial x^i}\\right|_p,\\left.\\frac{\\partial}{\\partial x^j}\\right|_p\\right)', 'literature', 78, 'Eine lokale Koordinatenbasis auf T_pM ist gewählt.', 'Entspricht Gleichungen 3.712 bis 3.718.', 'verified', 23),
(163, '3.2.160', 45, 'Riemannsche Kurvenlänge', 'Die Länge einer stückweise glatten Kurve auf einer riemannschen Mannigfaltigkeit ist das Integral der durch die Metrik bestimmten Norm ihres Tangentialvektors.', 'L_g(\\gamma)=\\int_a^b\\sqrt{g_{\\gamma(t)}\\bigl(\\gamma\'(t),\\gamma\'(t)\\bigr)}\\,dt', 'L_g(\\gamma)=\\int_a^b\\sqrt{g_{\\gamma(t)}\\bigl(\\gamma\'(t),\\gamma\'(t)\\bigr)}\\,dt', 'literature', 78, 'g ist riemannsch und gamma ist stückweise glatt.', 'Entspricht Gleichung 3.723.', 'verified', 23),
(164, '3.2.161', 45, 'Von einer riemannschen Metrik induzierter Abstand', 'Der von einer riemannschen Metrik induzierte Abstand zweier Punkte derselben zusammenhängenden Komponente ist das Infimum der Längen geeigneter stückweise glatter Verbindungskurven.', 'd_g(p,q)=\\inf_{\\gamma}L_g(\\gamma)', 'd_g(p,q)=\\inf_{\\gamma}L_g(\\gamma)', 'literature', 78, 'p und q liegen in derselben zusammenhängenden Komponente einer riemannschen Mannigfaltigkeit.', 'Entspricht Gleichungen 3.724 und 3.725.', 'verified', 23),
(165, '3.2.162', 45, 'Zeitartiger, lichtartiger und raumartiger Tangentialvektor', 'Bei lorentzscher Signatur (-,+,...,+) wird ein von null verschiedener Tangentialvektor nach dem Vorzeichen von g(v,v) als zeitartig, lichtartig oder raumartig klassifiziert.', 'g(v,v)<0,\\qquad g(v,v)=0,\\qquad g(v,v)>0', 'g(v,v)<0,\\qquad g(v,v)=0,\\qquad g(v,v)>0', 'literature', 78, 'g ist lorentzsch mit der Vorzeichenkonvention (-,+,...,+).', 'Entspricht Gleichungen 3.728 bis 3.731.', 'verified', 23),
(166, '3.2.163', 45, 'Isometrie pseudo-riemannscher Mannigfaltigkeiten', 'Ein Diffeomorphismus zwischen pseudo-riemannschen Mannigfaltigkeiten heißt Isometrie, wenn sein Differential die metrische Bilinearform erhält.', 'h_{F(p)}\\bigl(dF_p(v),dF_p(w)\\bigr)=g_p(v,w)', 'h_{F(p)}\\bigl(dF_p(v),dF_p(w)\\bigr)=g_p(v,w)', 'literature', 78, 'F:(M,g)->(N,h) ist ein Diffeomorphismus.', 'Entspricht Gleichungen 3.748 und 3.749.', 'verified', 23),
(167, '3.2.164', 46, 'Glattes Vektorfeld', 'Ein glattes Vektorfeld X auf einer glatten Mannigfaltigkeit M ordnet jedem Punkt p einen Tangentialvektor X_p in T_pM zu und hängt glatt vom Punkt ab; äquivalent ist X ein glatter Schnitt des Tangentialbündels.', 'X:M\\longrightarrow TM,\\qquad \\pi\\circ X=I_M', 'X:M\\longrightarrow TM,\\qquad \\pi\\circ X=I_M', 'literature', 78, 'M ist eine glatte Mannigfaltigkeit.', 'Entspricht Gleichungen 3.766 bis 3.769.', 'verified', 24),
(168, '3.2.165', 46, 'Affiner Zusammenhang', 'Ein affiner Zusammenhang beziehungsweise eine kovariante Ableitung auf M ist eine Abbildung auf Paaren glatter Vektorfelder, die im Richtungsargument C-infinity-linear, im zweiten Argument reell linear ist und dort die Leibnizregel erfüllt.', '\\nabla:\\mathfrak X(M)\\times\\mathfrak X(M)\\longrightarrow\\mathfrak X(M),\\qquad(X,Y)\\longmapsto\\nabla_XY', '\\nabla:\\mathfrak X(M)\\times\\mathfrak X(M)\\longrightarrow\\mathfrak X(M),\\qquad(X,Y)\\longmapsto\\nabla_XY', 'literature', 78, 'M ist eine glatte Mannigfaltigkeit.', 'Entspricht Gleichungen 3.772 bis 3.776.', 'verified', 24),
(169, '3.2.166', 46, 'Zusammenhangskoeffizienten', 'Die lokalen Zusammenhangskoeffizienten Gamma^k_ij sind bezüglich einer Koordinatenbasis durch die kovariante Ableitung der Basisvektoren definiert.', '\\nabla_{\\frac{\\partial}{\\partial x^i}}\\frac{\\partial}{\\partial x^j}=\\Gamma^k_{ij}\\frac{\\partial}{\\partial x^k}', '\\nabla_{\\frac{\\partial}{\\partial x^i}}\\frac{\\partial}{\\partial x^j}=\\Gamma^k_{ij}\\frac{\\partial}{\\partial x^k}', 'literature', 78, 'Eine lokale Koordinatenbasis ist gewählt.', 'Entspricht Gleichungen 3.777 bis 3.781.', 'verified', 24),
(170, '3.2.167', 46, 'Torsion eines Zusammenhangs', 'Die Torsion T eines Zusammenhangs ist das Tensorfeld T(X,Y)=nabla_XY-nabla_YX-[X,Y]. Ein Zusammenhang heißt torsionsfrei, wenn T für alle Vektorfelder verschwindet.', 'T(X,Y)=\\nabla_XY-\\nabla_YX-[X,Y]', 'T(X,Y)=\\nabla_XY-\\nabla_YX-[X,Y]', 'literature', 78, 'Ein affiner Zusammenhang auf M ist gegeben.', 'Entspricht Gleichungen 3.782 bis 3.784.', 'verified', 24),
(171, '3.2.168', 46, 'Metrikverträglicher Zusammenhang', 'Ein Zusammenhang heißt mit einer pseudo-riemannschen Metrik g verträglich, wenn die kovariante Differentiation die metrische Paarung nach der Leibnizregel erhält.', 'X\\bigl(g(Y,Z)\\bigr)=g(\\nabla_XY,Z)+g(Y,\\nabla_XZ)', 'X\\bigl(g(Y,Z)\\bigr)=g(\\nabla_XY,Z)+g(Y,\\nabla_XZ)', 'literature', 78, 'M trägt eine pseudo-riemannsche Metrik g.', 'Entspricht Gleichungen 3.785 und 3.786.', 'verified', 24),
(172, '3.2.169', 46, 'Vektorfeld entlang einer Kurve', 'Ein glattes Vektorfeld V entlang einer Kurve gamma:I->M ist eine glatte Abbildung V:I->TM, deren Bündelprojektion gleich gamma ist.', '\\pi(V(t))=\\gamma(t)', '\\pi(V(t))=\\gamma(t)', 'literature', 78, 'gamma ist eine glatte Kurve in M.', 'Entspricht Gleichungen 3.794 bis 3.796.', 'verified', 24),
(173, '3.2.170', 46, 'Kovariante Ableitung entlang einer Kurve', 'Die kovariante Ableitung eines Vektorfeldes V entlang einer Kurve gamma beschreibt die durch den Zusammenhang bestimmte Änderung von V entlang gamma.', '\\frac{DV^k}{dt}=\\frac{dV^k}{dt}+\\Gamma^k_{ij}\\frac{dx^i}{dt}V^j', '\\frac{DV^k}{dt}=\\frac{dV^k}{dt}+\\Gamma^k_{ij}\\frac{dx^i}{dt}V^j', 'literature', 78, 'Ein Zusammenhang und eine glatte Kurve gamma sind gegeben.', 'Entspricht Gleichungen 3.797 und 3.798.', 'verified', 24),
(174, '3.2.171', 46, 'Paralleles Vektorfeld', 'Ein Vektorfeld V entlang einer Kurve gamma heißt parallel, wenn seine kovariante Ableitung entlang der Kurve verschwindet.', '\\frac{DV}{dt}=0', '\\frac{DV}{dt}=0', 'literature', 78, 'Ein Zusammenhang und ein Vektorfeld entlang gamma sind gegeben.', 'Entspricht Gleichungen 3.799 bis 3.801.', 'verified', 24),
(175, '3.2.172', 46, 'Paralleltransport entlang einer Kurve', 'Der Paralleltransport eines Anfangsvektors entlang einer Kurve ist der Endwert des eindeutig bestimmten parallelen Vektorfeldes mit diesem Anfangswert und definiert eine lineare Abbildung zwischen den Tangentialräumen der Endpunkte.', 'P^\\gamma_{a\\to b}:T_{\\gamma(a)}M\\longrightarrow T_{\\gamma(b)}M', 'P^\\gamma_{a\\to b}:T_{\\gamma(a)}M\\longrightarrow T_{\\gamma(b)}M', 'literature', 78, 'Eine glatte Kurve gamma und ein Zusammenhang sind gegeben; das zugehörige lineare Anfangswertproblem ist eindeutig lösbar.', 'Entspricht Gleichungen 3.802 bis 3.805.', 'verified', 24),
(176, '3.2.173', 47, 'Geodäte', 'Eine glatte Kurve auf einer pseudo-riemannschen Mannigfaltigkeit heißt Geodäte, wenn ihr Tangentialvektor entlang der Kurve parallel ist, also ihre kovariante Beschleunigung verschwindet.', '\\frac{D\\dot\\gamma}{dt}=0', '\\frac{D\\dot\\gamma}{dt}=0', 'literature', 78, 'M ist eine pseudo-riemannsche Mannigfaltigkeit mit Levi-Civita-Zusammenhang.', 'Entspricht Gleichungen 3.846 bis 3.849.', 'verified', 25),
(177, '3.2.174', 47, 'Affiner Parameter einer Geodäte', 'Ein Parameter heißt affiner Parameter einer Geodäte, wenn die Geodätengleichung bezüglich dieses Parameters in der Form D dot gamma / dt = 0 gilt; affine Umparametrisierungen besitzen die Form s=at+b mit a ungleich null.', 's=at+b,\\qquad a\\neq0', 's=at+b,\\qquad a\\neq0', 'literature', 78, 'gamma ist eine Geodäte.', 'Entspricht Gleichung 3.853 sowie der unnummerierten geodätischen Bedingung.', 'verified', 25),
(178, '3.2.175', 47, 'Exponentialabbildung', 'Für einen Punkt p ordnet die Exponentialabbildung jedem zulässigen Tangentialvektor v den Punkt gamma_v(1) der durch p mit Anfangsgeschwindigkeit v bestimmten Geodäte zu.', '\\exp_p(v)=\\gamma_v(1)', '\\exp_p(v)=\\gamma_v(1)', 'literature', 78, 'Die Geodäte gamma_v existiert mindestens bis zum Parameterwert 1.', 'Entspricht Gleichungen 3.858 bis 3.862.', 'verified', 25),
(179, '3.2.176', 47, 'Normale Umgebung', 'Eine offene Umgebung U von p heißt normale Umgebung, wenn eine sternförmige offene Umgebung V des Nullvektors in T_pM existiert, auf der exp_p ein Diffeomorphismus von V nach U ist.', '\\exp_p:V\\longrightarrow U', '\\exp_p:V\\longrightarrow U', 'literature', 78, 'V ist eine sternförmige offene Umgebung von 0 in T_pM.', 'Entspricht Gleichungen 3.863 und 3.864.', 'verified', 25),
(180, '3.2.177', 47, 'Normalkoordinaten', 'Normalkoordinaten um p entstehen, indem die Komponenten v^i eines Tangentialvektors v bezüglich einer Basis von T_pM über q=exp_p(v^i e_i) als lokale Koordinaten eines Punktes q verwendet werden.', 'q=\\exp_p(v^ie_i)', 'q=\\exp_p(v^ie_i)', 'literature', 78, 'Eine Basis e_1,...,e_n von T_pM und eine normale Umgebung sind gewählt.', 'Entspricht Gleichungen 3.865 bis 3.868.', 'verified', 25),
(181, '3.2.178', 47, 'Riemannscher Krümmungstensor', 'Der Krümmungsoperator eines Zusammenhangs wird in der verwendeten Vorzeichenkonvention durch R(X,Y)Z=nabla_X nabla_Y Z - nabla_Y nabla_X Z - nabla_[X,Y] Z definiert.', 'R(X,Y)Z=\\nabla_X\\nabla_YZ-\\nabla_Y\\nabla_XZ-\\nabla_{[X,Y]}Z', 'R(X,Y)Z=\\nabla_X\\nabla_YZ-\\nabla_Y\\nabla_XZ-\\nabla_{[X,Y]}Z', 'literature', 78, 'Ein Zusammenhang ist gegeben; für die weiteren Symmetrien wird der Levi-Civita-Zusammenhang vorausgesetzt.', 'Entspricht Gleichungen 3.870 bis 3.880.', 'verified', 25),
(182, '3.2.179', 47, 'Flacher Zusammenhang beziehungsweise flache Metrik', 'Ein Zusammenhang heißt auf einem Gebiet flach, wenn sein Krümmungstensor dort identisch verschwindet.', 'R=0', 'R=0', 'literature', 78, 'Ein Zusammenhang beziehungsweise bei einer Metrik deren Levi-Civita-Zusammenhang ist gegeben.', 'Entspricht Gleichungen 3.882 und 3.883.', 'verified', 25),
(183, '3.2.180', 47, 'Schnittkrümmung', 'Die Schnittkrümmung einer nicht ausgearteten zweidimensionalen Tangentialebene Pi=span{u,v} ist in der festgelegten Krümmungskonvention der Quotient g(R(u,v)v,u) durch g(u,u)g(v,v)-g(u,v)^2.', 'K(\\Pi)=\\frac{g(R(u,v)v,u)}{g(u,u)g(v,v)-g(u,v)^2}', 'K(\\Pi)=\\frac{g(R(u,v)v,u)}{g(u,u)g(v,v)-g(u,v)^2}', 'literature', 78, 'Pi ist eine nicht ausgeartete zweidimensionale Tangentialebene.', 'Entspricht Gleichungen 3.885 bis 3.889.', 'verified', 25),
(184, '3.2.181', 47, 'Ricci-Tensor', 'Der Ricci-Tensor ist die Spur des linearen Operators Z -> R(Z,X)Y.', '\\operatorname{Ric}(X,Y)=\\operatorname{tr}\\bigl(Z\\mapsto R(Z,X)Y\\bigr)', '\\operatorname{Ric}(X,Y)=\\operatorname{tr}\\bigl(Z\\mapsto R(Z,X)Y\\bigr)', 'literature', 78, 'Der Krümmungstensor des Levi-Civita-Zusammenhangs ist gegeben.', 'Entspricht Gleichungen 3.890 bis 3.892.', 'verified', 25),
(185, '3.2.182', 47, 'Skalarkrümmung', 'Die Skalarkrümmung ist die metrische Spur des Ricci-Tensors.', '\\operatorname{Scal}=\\operatorname{tr}_g\\operatorname{Ric}', '\\operatorname{Scal}=\\operatorname{tr}_g\\operatorname{Ric}', 'literature', 78, 'g ist nicht ausgeartet und der Ricci-Tensor ist definiert.', 'Entspricht Gleichungen 3.893 bis 3.897.', 'verified', 25),
(186, '3.2.183', 47, 'Jacobi-Feld', 'Ein Vektorfeld J entlang einer Geodäte gamma heißt Jacobi-Feld, wenn es die Jacobi-Gleichung D^2J/dt^2 + R(J,dot gamma)dot gamma = 0 erfüllt.', '\\frac{D^2J}{dt^2}+R(J,\\dot\\gamma)\\dot\\gamma=0', '\\frac{D^2J}{dt^2}+R(J,\\dot\\gamma)\\dot\\gamma=0', 'literature', 78, 'gamma ist eine Geodäte des Levi-Civita-Zusammenhangs.', 'Entspricht Gleichungen 3.899 bis 3.903.', 'verified', 25),
(187, '3.2.184', 47, 'Geodätische Vollständigkeit', 'Eine pseudo-riemannsche Mannigfaltigkeit heißt geodätisch vollständig, wenn jede maximal fortgesetzte Geodäte auf dem gesamten reellen affinen Parameterbereich definiert ist.', 'I=\\mathbb R', 'I=\\mathbb R', 'literature', 78, 'Es werden maximal fortgesetzte affin parametrisierte Geodäten betrachtet.', 'Entspricht Gleichungen 3.904 bis 3.908.', 'verified', 25),
(188, '3.2.185', 48, 'Kausaler Tangentialvektor', 'Ein von null verschiedener Tangentialvektor einer lorentzschen Mannigfaltigkeit heißt kausal, wenn er zeitartig oder lichtartig ist.', 'g_p(v,v)\\leq0,\\qquad v\\neq0', 'g_p(v,v)\\leq0,\\qquad v\\neq0', 'literature', 78, 'Es wird die Signaturkonvention (-,+,...,+) verwendet.', 'Entspricht Gleichungen 3.926 bis 3.928.', 'verified', 26),
(189, '3.2.186', 48, 'Nullkegel', 'Der Null- beziehungsweise Lichtkegel im Tangentialraum T_pM ist die Menge aller nichtverschwindenden lichtartigen Tangentialvektoren.', '\\mathcal N_p=\\left\\{v\\in T_pM\\setminus\\{0\\}\\;\\middle|\\;g_p(v,v)=0\\right\\}', '\\mathcal N_p=\\left\\{v\\in T_pM\\setminus\\{0\\}\\;\\middle|\\;g_p(v,v)=0\\right\\}', 'literature', 78, 'M ist lorentzsch und p liegt in M.', 'Entspricht Gleichung 3.929.', 'verified', 26),
(190, '3.2.187', 48, 'Zeitorientierbare lorentzsche Mannigfaltigkeit', 'Eine lorentzsche Mannigfaltigkeit heißt zeitorientierbar, wenn auf ihr ein stetiges nirgends verschwindendes zeitartiges Vektorfeld existiert.', 'T_p\\in T_pM,\\qquad g_p(T_p,T_p)<0\\qquad\\text{für alle }p\\in M', 'T_p\\in T_pM,\\qquad g_p(T_p,T_p)<0\\qquad\\text{für alle }p\\in M', 'literature', 78, 'M ist eine lorentzsche Mannigfaltigkeit.', 'Entspricht Gleichung 3.930.', 'verified', 26),
(191, '3.2.188', 48, 'Zeitorientierung', 'Eine Zeitorientierung ist eine kontinuierliche Wahl einer der beiden zeitartigen Kegelkomponenten als zukünftige Komponente.', 'g_p(v,T_p)<0', 'g_p(v,T_p)<0', 'literature', 78, 'Ein zeitartiges Orientierungsfeld T ist gewählt; verwendet wird die Signaturkonvention (-,+,...,+).', 'Entspricht Gleichungen 3.931 bis 3.934.', 'verified', 26),
(192, '3.2.189', 48, 'Zukunftsgerichtete zeitartige Kurve', 'Eine stückweise glatte Kurve heißt zukunftsgerichtet zeitartig, wenn ihr Tangentialvektor an allen regulären Stellen zukunftsgerichtet zeitartig ist.', 'g(\\dot\\gamma,\\dot\\gamma)<0', 'g(\\dot\\gamma,\\dot\\gamma)<0', 'literature', 78, 'M ist zeitorientiert.', 'Entspricht Gleichung 3.935.', 'verified', 26),
(193, '3.2.190', 48, 'Zukunftsgerichtete kausale Kurve', 'Eine stückweise glatte Kurve heißt zukunftsgerichtet kausal, wenn ihr Tangentialvektor an allen regulären Stellen zukunftsgerichtet und kausal ist.', 'g(\\dot\\gamma,\\dot\\gamma)\\leq0', 'g(\\dot\\gamma,\\dot\\gamma)\\leq0', 'literature', 78, 'M ist zeitorientiert; der Tangentialvektor ist an regulären Stellen von null verschieden.', 'Entspricht Gleichungen 3.936 bis 3.938.', 'verified', 26),
(194, '3.2.191', 48, 'Chronologische Zukunft', 'Die chronologische Zukunft I^+(p) eines Punktes p ist die Menge aller Punkte, die von p durch eine zukunftsgerichtete zeitartige Kurve erreichbar sind; analog wird I^-(p) definiert.', 'p\\ll q\\Longleftrightarrow q\\in I^+(p)', 'p\\ll q\\Longleftrightarrow q\\in I^+(p)', 'literature', 78, 'M ist zeitorientiert.', 'Entspricht Gleichungen 3.939 bis 3.942.', 'verified', 26),
(195, '3.2.192', 48, 'Kausale Zukunft', 'Die kausale Zukunft J^+(p) eines Punktes p enthält p selbst und alle Punkte, die von p durch eine zukunftsgerichtete kausale Kurve erreichbar sind; analog wird J^-(p) definiert.', 'p\\leq q\\Longleftrightarrow q\\in J^+(p)', 'p\\leq q\\Longleftrightarrow q\\in J^+(p)', 'literature', 78, 'M ist zeitorientiert.', 'Entspricht Gleichungen 3.943 bis 3.947.', 'verified', 26),
(196, '3.2.193', 48, 'Horismosrelation', 'Die Horismosrelation kennzeichnet Punkte, die kausal, aber nicht chronologisch miteinander verbunden sind.', 'p\\to q\\Longleftrightarrow q\\in J^+(p)\\setminus I^+(p)', 'p\\to q\\Longleftrightarrow q\\in J^+(p)\\setminus I^+(p)', 'literature', 78, 'M ist zeitorientiert.', 'Entspricht Gleichung 3.948.', 'verified', 26),
(197, '3.2.194', 48, 'Geschlossene zeitartige Kurve', 'Eine zukunftsgerichtete zeitartige Kurve heißt geschlossen, wenn sie für zwei verschiedene Parameterwerte denselben Mannigfaltigkeitspunkt erreicht.', '\\gamma(a)=\\gamma(b)\\qquad(a<b)', '\\gamma(a)=\\gamma(b)\\qquad(a<b)', 'literature', 78, 'gamma ist zukunftsgerichtet zeitartig.', 'Entspricht Gleichungen 3.954 bis 3.956.', 'verified', 26),
(198, '3.2.195', 48, 'Chronologische Mannigfaltigkeit', 'Eine zeitorientierte lorentzsche Mannigfaltigkeit heißt chronologisch, wenn sie keine geschlossene zeitartige Kurve besitzt.', 'p\\notin I^+(p)\\qquad\\text{für alle }p\\in M', 'p\\notin I^+(p)\\qquad\\text{für alle }p\\in M', 'literature', 78, 'M ist zeitorientiert.', 'Entspricht Gleichungen 3.957 bis 3.959.', 'verified', 26),
(199, '3.2.196', 48, 'Kausale Mannigfaltigkeit', 'Eine zeitorientierte lorentzsche Mannigfaltigkeit heißt kausal, wenn keine nichtkonstante geschlossene kausale Kurve existiert.', 'p\\leq q,\\quad q\\leq p\\Longrightarrow p=q', 'p\\leq q,\\quad q\\leq p\\Longrightarrow p=q', 'literature', 78, 'M ist zeitorientiert.', 'Entspricht Gleichungen 3.960 und 3.961.', 'verified', 26),
(200, '3.2.197', 48, 'Starke Kausalität', 'Eine lorentzsche Mannigfaltigkeit heißt stark kausal in p, wenn jede Umgebung von p eine kleinere Umgebung enthält, in der kausale Kurven keine lokal rückkehrende Mehrfachdurchquerung erzeugen; gilt dies für jeden Punkt, heißt die Mannigfaltigkeit stark kausal.', 'p\\in V\\subseteq U\\quad\\text{mit kausal kontrollierter Durchquerung}', 'p\\in V\\subseteq U\\quad\\text{mit kausal kontrollierter Durchquerung}', 'literature', 78, 'M ist zeitorientiert.', 'Entspricht Gleichungen 3.962 bis 3.964.', 'verified', 26),
(201, '3.2.198', 48, 'Global hyperbolische lorentzsche Mannigfaltigkeit', 'Im hier verwendeten klassischen Sinn heißt eine zeitorientierte lorentzsche Mannigfaltigkeit global hyperbolisch, wenn sie stark kausal ist und alle kausalen Diamanten J^+(p)∩J^-(q) kompakt sind.', 'J^+(p)\\cap J^-(q)\\text{ kompakt für alle }p,q\\in M', 'J^+(p)\\cap J^-(q)\\text{ kompakt für alle }p,q\\in M', 'literature', 78, 'M ist zeitorientiert; verwendet wird die klassische Charakterisierung starke Kausalität plus Kompaktheit kausaler Diamanten.', 'Entspricht Gleichungen 3.965 bis 3.971.', 'verified', 26),
(202, '3.2.199', 49, 'Funktional', 'Ein reellwertiges Funktional ist eine Abbildung J von einer zulässigen Klasse A von Funktionen, Kurven oder Feldern nach R.', 'J:\\mathcal A\\longrightarrow\\mathbb R', 'J:\\mathcal A\\longrightarrow\\mathbb R', 'literature', 76, 'Eine zulässige Klasse mathematischer Objekte ist gegeben.', 'Entspricht Gleichungen 3.996 und 3.997.', 'verified', 27),
(203, '3.2.200', 49, 'Zulässige Klasse', 'Eine zulässige Klasse ist eine Teilmenge eines geeigneten Funktionenraumes, deren Elemente die für das Variationsproblem geforderten Regularitäts-, Rand- oder Nebenbedingungen erfüllen.', '\\mathcal A\\subseteq X', '\\mathcal A\\subseteq X', 'literature', 76, 'Ein geeigneter Funktionenraum X ist festgelegt.', 'Entspricht Gleichungen 3.998 und 3.999.', 'verified', 27),
(204, '3.2.201', 49, 'Variation', 'Eine einparametrige Variation eines zulässigen Objekts u in Richtung eta wird durch u_epsilon=u+epsilon eta beschrieben, sofern die variierten Objekte für hinreichend kleines epsilon zulässig bleiben.', 'u_\\varepsilon=u+\\varepsilon\\eta', 'u_\\varepsilon=u+\\varepsilon\\eta', 'literature', 76, 'u liegt in der zulässigen Klasse; eta ist eine zulässige Variationsrichtung.', 'Entspricht Gleichungen 3.1002 bis 3.1005.', 'verified', 27),
(205, '3.2.202', 49, 'Erste Variation', 'Die erste Variation eines Funktionals J an u in Richtung eta ist die Ableitung von J[u+epsilon eta] nach epsilon bei epsilon=0.', '\\delta J[u;\\eta]=\\left.\\frac{d}{d\\varepsilon}J[u+\\varepsilon\\eta]\\right|_{\\varepsilon=0}', '\\delta J[u;\\eta]=\\left.\\frac{d}{d\\varepsilon}J[u+\\varepsilon\\eta]\\right|_{\\varepsilon=0}', 'literature', 76, 'Die Richtungsableitung des Funktionals existiert.', 'Entspricht Gleichungen 3.1006 und 3.1007.', 'verified', 27),
(206, '3.2.203', 49, 'Stationärer Punkt eines Funktionals', 'Ein zulässiges Element u heißt stationärer beziehungsweise kritischer Punkt von J, wenn die erste Variation in jeder zulässigen Variationsrichtung verschwindet.', '\\delta J[u;\\eta]=0', '\\delta J[u;\\eta]=0', 'literature', 76, 'Die erste Variation existiert für alle zulässigen Richtungen.', 'Entspricht Gleichung 3.1008.', 'verified', 27),
(207, '3.2.204', 49, 'Lokaler Minimierer eines Funktionals', 'Ein zulässiges Element u heißt lokaler Minimierer von J, wenn in einer geeigneten Umgebung von u für alle zulässigen v die Ungleichung J[u] <= J[v] gilt; analog wird ein lokaler Maximierer definiert.', 'J[u]\\leq J[v]', 'J[u]\\leq J[v]', 'literature', 76, 'Eine Topologie beziehungsweise geeignete Umgebungsstruktur auf der zulässigen Klasse ist festgelegt.', 'Entspricht Gleichungen 3.1009 und 3.1010.', 'verified', 27),
(208, '3.2.205', 49, 'Lagrange-Funktion', 'Eine Lagrange-Funktion ist im variational-mechanischen Zusammenhang eine reellwertige Funktion auf Geschwindigkeits-/Tangentialdaten des Konfigurationsraumes und gegebenenfalls der Zeit.', 'L:TQ\\times I\\longrightarrow\\mathbb R', 'L:TQ\\times I\\longrightarrow\\mathbb R', 'adapted', 76, 'Ein Konfigurationsraum Q und ein Parameterintervall I sind gegeben.', 'Entspricht Gleichungen 3.1034 und 3.1035.', 'verified', 27),
(209, '3.2.206', 49, 'Wirkungsfunktional', 'Das zu einer Lagrange-Funktion gehörige Wirkungsfunktional ordnet einer zulässigen Kurve q das Integral der Lagrange-Funktion entlang dieser Kurve zu.', 'S[q]=\\int_{t_0}^{t_1}L(q(t),\\dot q(t),t)\\,dt', 'S[q]=\\int_{t_0}^{t_1}L(q(t),\\dot q(t),t)\\,dt', 'adapted', 76, 'Eine Lagrange-Funktion und eine zulässige Kurvenklasse sind gegeben.', 'Entspricht Gleichungen 3.1036 bis 3.1041.', 'verified', 27),
(210, '3.2.207', 49, 'Zweite Variation', 'Die zweite Variation ist die zweite Ableitung des Funktionals entlang einer Variationsfamilie bei epsilon=0.', '\\delta^2J[u;\\eta]=\\left.\\frac{d^2}{d\\varepsilon^2}J[u+\\varepsilon\\eta]\\right|_{\\varepsilon=0}', '\\delta^2J[u;\\eta]=\\left.\\frac{d^2}{d\\varepsilon^2}J[u+\\varepsilon\\eta]\\right|_{\\varepsilon=0}', 'literature', 76, 'Die entsprechende zweite Ableitung existiert.', 'Entspricht Gleichungen 3.1042 bis 3.1044.', 'verified', 27),
(211, '3.2.208', 49, 'Kanonischer beziehungsweise verallgemeinerter Impuls', 'Zu einer Lagrange-Funktion L(q,dot q,t) wird der kanonische beziehungsweise verallgemeinerte Impuls zur Koordinate q^a durch p_a=partial L/partial dot q^a definiert.', 'p_a=\\frac{\\partial L}{\\partial\\dot q^a}', 'p_a=\\frac{\\partial L}{\\partial\\dot q^a}', 'adapted', 76, 'Eine differenzierbare Lagrange-Funktion ist gegeben.', 'Entspricht Gleichungen 3.1088 bis 3.1091.', 'verified', 27);

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
(1, NULL, '3.1', 'Grundlagen der funktionalen Beschreibung von Raum und Zeit', 3, 3100.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:44', '2026-08-09 08:05:44'),
(2, 1, '3.1.0', 'Einleitung', 3, 3101.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:44', '2026-08-09 08:05:44'),
(3, 1, '3.1.1', 'Das Nichts als mathematischer Ausgangspunkt', 3, 3102.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:44', '2026-08-09 08:05:44'),
(4, 1, '3.1.2', 'Philosophische Grundlagen (Teil 1)', 3, 3103.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:44', '2026-08-09 08:05:44'),
(5, 1, '3.1.3', 'Physikalische Grundlagen', 3, 3104.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:44', '2026-08-09 08:05:44'),
(6, 1, '3.1.4', 'Erkenntnistheoretische Grundlagen', 3, 3105.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(7, 6, '3.1.4.1', 'Mathematische Voraussetzungen funktionaler Beschreibung', 3, 3106.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(8, 1, '3.1.5', 'Methodologische Konsequenzen für das Funktionale Raum-Zeit-Kohärenzsystem', 3, 3107.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(9, 1, '3.1.6', 'Funktion statt Objekt – Paradigmenwechsel moderner Wissenschaft', 3, 3108.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(10, 1, '3.1.7', 'Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung', 3, 3109.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(11, 10, '3.1.7.1', 'Gemeinsame Entwicklungslinien des Forschungsstandes', 3, 3110.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(12, 10, '3.1.7.2', 'Gemeinsame Grenze bestehender Ansätze', 3, 3111.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(13, 10, '3.1.7.3', 'Abgrenzung der Forschungslücke', 3, 3112.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(14, 10, '3.1.7.4', 'Wissenschaftliche Positionierung des FRZK', 3, 3113.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(15, 10, '3.1.7.5', 'Das Minimalitätsproblem', 3, 3114.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(16, 10, '3.1.7.6', 'Wissenschaftliche Zielsetzung', 3, 3115.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(17, 10, '3.1.7.7', 'Forschungsfragen', 3, 3116.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(18, 10, '3.1.7.8', 'Wissenschaftlicher Erkenntnisanspruch', 3, 3117.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(19, 10, '3.1.7.9', 'Abgrenzung des Geltungsanspruchs', 3, 3118.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(20, 10, '3.1.7.10', 'Abschluss der Grundlegung', 3, 3119.0000, 'review', 0, 'Import aus Kapitel 3.1 V2; Literaturbereinigung 2026-08-09', '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(22, NULL, '3.2.0', 'Einleitung', 3, 3.2000, 'final', 0, 'Bedarfsorientierte mathematische Grundlegung: etablierte Mathematik wird von späteren FRZK-spezifischen Setzungen getrennt; keine nummerierten Gleichungen und keine neuen Literaturquellen.', '2026-08-12 11:54:59', '2026-08-12 11:54:59'),
(23, NULL, '3.2', 'Mathematische Grundlagen', 3, 3.2000, 'draft', 0, 'Bedarfsorientierte mathematische Grundlegung für die in Kapitel 3.3 folgende FRZK-Axiomatik.', '2026-08-12 12:45:51', '2026-08-12 12:45:51'),
(24, 23, '3.2.1', 'Mengen, Elemente und Relationen', 3, 3.2100, 'final', 0, 'Etablierte mengentheoretische Grundlage: Objektbereiche, Zugehörigkeit, Teilmengen, Mengenoperationen, Potenzmenge, geordnete Paare, kartesisches Produkt, Relationen, Äquivalenzrelationen und partielle Ordnungen. Keine FRZK-spezifische Setzung.', '2026-08-12 12:45:51', '2026-08-12 12:45:51'),
(26, 23, '3.2.2', 'Funktionen und eindeutige Zuordnungen', 3, 3.2200, 'final', 0, 'Etablierte mathematische Grundlagen zu Funktion, Bild, Urbild, Injektivität, Surjektivität, Bijektivität, Umkehrfunktion, Identität, Verkettung und mehreren Eingangsgrößen. Keine FRZK-spezifische Setzung.', '2026-08-12 13:01:49', '2026-08-12 13:01:49'),
(27, 23, '3.2.3', 'Vektorräume und mathematische Zustandsräume', 3, 3.2300, 'final', 0, 'Etablierte mathematische Grundlagen zu Vektorraum, Nullvektor, Untervektorraum, Skalarkörper sowie endlich- und unendlichdimensionalen Räumen. Keine FRZK-spezifische Setzung.', '2026-08-12 13:16:23', '2026-08-12 13:16:23'),
(28, 23, '3.2.4', 'Linearkombinationen, Spannräume und Erzeugung', 3, 3.2400, 'final', 0, 'Etablierte lineare Algebra zu Linearkombination, Spannraum, Erzeugendensystem, Redundanz und Erweiterung eines Spannraums. Keine FRZK-spezifische Setzung.', '2026-08-12 14:21:37', '2026-08-12 14:21:37'),
(29, 23, '3.2.5', 'Lineare Unabhängigkeit, Basis und Dimension', 3, 3.2500, 'final', 0, 'Etablierte lineare Algebra zu linearer Unabhängigkeit, Basis, eindeutiger Basisdarstellung, Koordinaten und algebraischer Dimension. Keine FRZK-spezifische Setzung.', '2026-08-12 14:44:56', '2026-08-12 14:44:56'),
(30, 23, '3.2.6', 'Lineare Abbildungen und Operatoren', 3, 3.2600, 'final', 0, 'Etablierte lineare Algebra zu linearen Abbildungen, Kern, Bild, Rang, Nullität, linearen Operatoren, Invertierbarkeit und Matrixdarstellung. Keine FRZK-spezifische Setzung.', '2026-08-12 15:41:29', '2026-08-12 15:41:29'),
(31, 23, '3.2.7', 'Normen, Abstände und Skalarprodukte', 3, 3.2700, 'final', 0, 'Etablierte Mathematik zu Normen, normierten Vektorräumen, Metriken, Skalarprodukten, Orthogonalität, orthonormalen Systemen und Projektionen. Keine FRZK-spezifische Setzung.', '2026-08-13 00:59:20', '2026-08-13 00:59:20'),
(32, 23, '3.2.8', 'Topologische Räume, Umgebungen und Stetigkeit', 3, 3.2800, 'final', 0, 'Etablierte allgemeine Topologie zu offenen und abgeschlossenen Mengen, Umgebungen, topologischen Basen, Innerem, Abschluss, Rand, metrisch induzierten Topologien, Stetigkeit und Homeomorphismen. Keine FRZK-spezifische Setzung.', '2026-08-13 01:33:34', '2026-08-13 01:33:34'),
(33, 23, '3.2.9', 'Zusammenhang und Kompaktheit topologischer Zustandsräume', 3, 3.2900, 'final', 0, 'Etablierte allgemeine Topologie zu Trennungen, Zusammenhang, Wegzusammenhang, Zusammenhangskomponenten, offenen Überdeckungen und Kompaktheit. Keine FRZK-spezifische Setzung.', '2026-08-13 04:09:20', '2026-08-13 04:09:20'),
(34, 23, '3.2.10', 'Folgen, Konvergenz und Vollständigkeit', 3, 3.3000, 'final', 0, 'Etablierte Mathematik zu Folgen, topologischer und metrischer Konvergenz, Cauchy-Folgen, Vollständigkeit, Banach- und Hilberträumen sowie Teilfolgen und Kompaktheitsbezügen in metrischen Räumen. Keine FRZK-spezifische Setzung.', '2026-08-13 04:23:37', '2026-08-13 04:23:37'),
(35, 23, '3.2.11', 'Funktionenräume als mathematische Zustandsräume', 3, 3.3100, 'final', 0, 'Etablierte Mathematik zu Funktionenräumen, punktweiser linearer Struktur, stetigen und beschränkten Funktionen, Supremumsnorm, punktweiser und gleichmäßiger Konvergenz, vollständigen Funktionenräumen, vektorwertigen Funktionen, Operatoren und Auswertungsfunktionalen. Keine FRZK-spezifische Setzung.', '2026-08-13 04:37:15', '2026-08-13 04:37:15'),
(36, 23, '3.2.12', 'Lineare Funktionale, Dualräume und beschränkte Operatoren', 3, 3.3200, 'final', 0, 'Etablierte Funktionalanalysis zu linearen Funktionalen, stetigem Dualraum, beschränkten linearen Operatoren, Operator- und Dualnorm, Operatorräumen, Riesz-Darstellung, Operatoralgebra und beschränktem inversen Operator. Methodologische Ebenentrennungen sind als eigenständige Originalaussagen gekennzeichnet.', '2026-08-13 04:51:14', '2026-08-13 04:51:14'),
(37, 23, '3.2.13', 'Eigenwerte, Eigenvektoren und Spektralbegriffe von Operatoren', 3, 3.3300, 'final', 0, 'Etablierte lineare Algebra und Funktionalanalysis zu Eigenwerten, Eigenvektoren, Eigenräumen, charakteristischem Polynom, Diagonalisierbarkeit, Resolvente, Spektrum, Punktspektrum, Spektralradius und invarianten Teilräumen. Methodologische Nichtgleichsetzungen sind als Originalaussagen gekennzeichnet.', '2026-08-13 07:20:29', '2026-08-13 07:20:29'),
(38, 23, '3.2.14', 'Projektionen, orthogonale Zerlegungen und invariante Teilräume', 3, 3.3400, 'final', 0, 'Etablierte lineare Algebra und Funktionalanalysis zu orthogonalen Komplementen, direkten Summen, Projektionsoperatoren, orthogonalen Projektionen, besten Approximationen und reduzierenden Teilräumen. Methodologische Nichtgleichsetzungen sind separat als Originalaussagen gekennzeichnet.', '2026-08-13 07:36:29', '2026-08-13 07:36:29'),
(39, 23, '3.2.16', 'Gewöhnliche und partielle Differentialgleichungen als Zustandsrelationen', 3, 3.3600, 'final', 0, 'Mathematische Grundlagen zu ODE, PDE, Anfangs- und Randwertproblemen, Existenz, Eindeutigkeit, Fortsetzbarkeit, Superposition, operatorischer Formulierung und Wohlgestelltheit. Methodologische Nichtgleichsetzungen zu Zeit, Determinismus, Kausalität, physikalischer Realisierbarkeit und Dimension sind als Originalaussagen gekennzeichnet.', '2026-08-13 14:37:48', '2026-08-13 14:37:48'),
(40, 23, '3.2.17', 'Dynamische Systeme, Flüsse und mathematische Zustandsentwicklung', 3, 3.3700, 'final', 0, 'Mathematische Grundlagen zu dynamischen Systemen, diskreten und kontinuierlichen Parametern, lokalen und globalen Flüssen, Semiflüssen, Trajektorien, Orbits, Fixpunkten, invarianten Mengen, Periodizität, linearen Flüssen und zweiparametrigen Evolutionsoperatoren. Methodologische Nichtgleichsetzungen zu physikalischer Zeit, Reversibilität, Isolation, Kausalität und Dimension sind als Originalaussagen gekennzeichnet.', '2026-08-13 16:52:03', '2026-08-13 16:52:03'),
(41, 23, '3.2.18', 'Stabilität, Störungen und Lyapunov-Begriffe dynamischer Systeme', 3, 3.3800, 'final', 0, 'Mathematische Grundlagen zu Lyapunov-, asymptotischer und exponentieller Stabilität, Einzugsgebieten, Störungen, Lyapunov-Funktionen, Linearisierung, Hyperbolizität und spektralen Stabilitätskriterien. Methodologische Abgrenzungen zu physikalischer Störung, Robustheit, Energie, Dissipation, Kohärenz, Erhaltung und Dimension sind als Originalaussagen gekennzeichnet.', '2026-08-13 18:59:11', '2026-08-13 18:59:11'),
(42, 23, '3.2.19', 'Grenzmengen, Attraktoren und asymptotisches Verhalten dynamischer Systeme', 3, 3.3900, 'final', 0, 'Mathematische Grundlagen zu positiven und negativen Omega-Grenzmengen, Grenzmengen von Zustandsmengen, stabilen Mengen, anziehenden Mengen, Einzugsgebieten, Fanggebieten, topologischer Transitivität und Attraktoren. Methodologische Abgrenzungen zu Punktkonvergenz, physikalischer Kausalität, Zielgerichtetheit, Systemgrenzen, Kohärenz, Information und Dimension sind als Originalaussagen gekennzeichnet.', '2026-08-13 19:09:35', '2026-08-13 19:09:35'),
(43, 23, '3.2.20', 'Differenzierbare Mannigfaltigkeiten, lokale Koordinaten und Tangentialräume', 3, 3.4000, 'final', 0, 'Mathematische Grundlagen zu topologischen und glatten Mannigfaltigkeiten, Karten, Atlanten, glatten Abbildungen, Tangentialvektoren, Tangentialräumen, Differentialen und Tangentialbündeln. Methodologische Abgrenzungen zu globaler Linearität, physikalischer Geschwindigkeit, kanonischer Metrik, Koordinatensingularität, physikalischer Dimension und Informationsdimension sind als Originalaussagen gekennzeichnet.', '2026-08-14 14:12:37', '2026-08-14 14:12:37'),
(45, 23, '3.2.21', 'Riemannsche und pseudo-riemannsche Metriken auf Mannigfaltigkeiten', 3, 3.4100, 'final', 0, 'Mathematische Grundlagen zu symmetrischen nicht ausgearteten Bilinearformen, positiver Definitheit, riemannschen, pseudo-riemannschen und lorentzschen Metriken, Index und Signatur, lokalen Metrikkoeffizienten, Kurvenlänge, riemannschem Abstand, lorentzscher Vektorklassifikation und Isometrien. Methodologische Abgrenzungen zu physikalischer Zeit, Raumzeit, Dimension, Information, Dynamik, Kausalität und Kohärenz sind als Originalaussagen gekennzeichnet.', '2026-08-14 14:31:45', '2026-08-14 14:31:45'),
(46, 23, '3.2.22', 'Zusammenhang, kovariante Ableitung und Paralleltransport auf Mannigfaltigkeiten', 3, 3.4200, 'final', 0, 'Mathematische Grundlagen zu Vektorfeldern, affinen Zusammenhängen, kovarianter Ableitung, Zusammenhangskoeffizienten, Torsion, Metrikverträglichkeit, Levi-Civita-Zusammenhang, Koszul-Formel, kovarianter Ableitung entlang von Kurven und Paralleltransport. Methodologische Abgrenzungen zu Koordinatendarstellungen, physikalischer Kraft, Kausalität, Dynamik, Information, Gedächtnis und Dimension sind als Originalaussagen gekennzeichnet.', '2026-08-14 16:42:08', '2026-08-14 16:42:08'),
(47, 23, '3.2.23', 'Geodäten, Exponentialabbildung und Krümmung von Mannigfaltigkeiten', 3, 3.4300, 'final', 0, 'Mathematische Grundlagen zu Geodäten, affinen Parametern, Exponentialabbildung, normalen Umgebungen und Normalkoordinaten, Riemannschem Krümmungstensor, Schnittkrümmung, Ricci-Tensor, Skalarkrümmung, Jacobi-Feldern und geodätischer Vollständigkeit. Methodologische Abgrenzungen zu kürzesten Wegen, physikalischer Kraft, Energie, Information, Zeit, Kausalität, Kohärenz und Dimension sind als Originalaussagen gekennzeichnet.', '2026-08-14 17:16:11', '2026-08-14 17:16:11'),
(48, 23, '3.2.24', 'Zeitorientierung, kausale Kurven und Kausalstruktur lorentzscher Mannigfaltigkeiten', 3, 3.4400, 'final', 0, 'Mathematische Grundlagen zu kausalen Tangentialvektoren, Lichtkegeln, Zeitorientierung, zeitartigen und kausalen Kurven, chronologischer und kausaler Zukunft, Horismos, Chronologie, Kausalität, starker Kausalität, globaler Hyperbolizität und konformer Erhaltung der Kausalstruktur. Methodologische Abgrenzungen zu Dynamik, physikalischer Ursache, Vorhersagbarkeit, Zeitkoordinaten, Information, Kohärenz und Dimension sind als Originalaussagen gekennzeichnet.', '2026-08-14 18:01:40', '2026-08-14 18:01:40'),
(49, 23, '3.2.25', 'Variationsprinzipien, Wirkungsfunktionale und Euler-Lagrange-Strukturen', 3, 3.4500, 'final', 0, 'Mathematische Grundlagen zu Funktionalen, zulässigen Klassen, Variationen, erster und zweiter Variation, stationären Punkten, Euler-Lagrange-Gleichungen, Lagrange-Funktionen, Wirkungsfunktionalen, äquivalenten Lagrange-Funktionen, Funktionalableitungen, geodätischen Energie-Funktionalen und kanonischen Impulsen. Methodologische Abgrenzungen zu physikalischer Zeit, Stabilität, Kausalität, Information, Kohärenz und Raumdimension sind als Originalaussagen gekennzeichnet.', '2026-08-14 18:19:25', '2026-08-14 18:19:25');

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
(1, '3.1', 24, 'Teilmengenbedingung', 'A\\subseteq B\\quad\\Longleftrightarrow\\quad\\forall x\\,\\bigl(x\\in A\\Rightarrow x\\in B\\bigr)', 'A\\subseteq B\\quad\\Longleftrightarrow\\quad\\forall x\\bigl(x\\in A\\Rightarrow x\\in B\\bigr)', 'A ist genau dann Teilmenge von B, wenn jedes Element von A zugleich Element von B ist.', 'definition', 'literature', 71, NULL, 'A und B sind Mengen.', 'verified', 3),
(2, '3.2', 24, 'Extensionalität und Mengengleichheit', 'A=B\\quad\\Longleftrightarrow\\quad\\forall x\\,\\bigl(x\\in A\\Leftrightarrow x\\in B\\bigr)', 'A=B\\quad\\Longleftrightarrow\\quad\\forall x\\bigl(x\\in A\\Leftrightarrow x\\in B\\bigr)', 'Zwei Mengen sind genau dann gleich, wenn sie dieselben Elemente enthalten.', 'definition', 'literature', NULL, NULL, 'A und B sind Mengen.', 'verified', 3),
(3, '3.3', 24, 'Leere Menge', '\\forall x\\,\\bigl(x\\notin\\varnothing\\bigr)', '\\forall x\\bigl(x\\notin\\varnothing\\bigr)', 'Die leere Menge enthält kein Element.', 'definition', 'literature', NULL, NULL, NULL, 'verified', 3),
(4, '3.4', 24, 'Vereinigung, Schnitt und Differenz', '\\begin{aligned}A\\cup B&=\\{x\\mid x\\in A\\lor x\\in B\\},\\\\A\\cap B&=\\{x\\mid x\\in A\\land x\\in B\\},\\\\A\\setminus B&=\\{x\\mid x\\in A\\land x\\notin B\\}.\\end{aligned}', '\\begin{aligned}A\\cup B&=\\{x\\mid x\\in A\\lor x\\in B\\},\\\\A\\cap B&=\\{x\\mid x\\in A\\land x\\in B\\},\\\\A\\setminus B&=\\{x\\mid x\\in A\\land x\\notin B\\}.\\end{aligned}', 'Gemeinsame Definition von Vereinigung, Schnittmenge und Mengendifferenz.', 'definition', 'literature', 71, NULL, 'A und B sind Mengen.', 'verified', 3),
(5, '3.5', 24, 'Potenzmenge', '\\mathcal{P}(A)=\\{B\\mid B\\subseteq A\\}', '\\mathcal{P}(A)=\\{B\\mid B\\subseteq A\\}', 'Die Potenzmenge enthält sämtliche Teilmengen von A.', 'definition', 'literature', 71, NULL, 'A ist eine Menge.', 'verified', 3),
(6, '3.6', 24, 'Gleichheit geordneter Paare', '(x,y)=(u,v)\\quad\\Longleftrightarrow\\quad x=u\\land y=v', '(x,y)=(u,v)\\quad\\Longleftrightarrow\\quad x=u\\land y=v', 'Zwei geordnete Paare sind genau dann gleich, wenn jeweils erste und zweite Komponente übereinstimmen.', 'definition', 'literature', 71, NULL, NULL, 'verified', 3),
(7, '3.7', 24, 'Kartesisches Produkt', 'A\\times B=\\{(x,y)\\mid x\\in A\\land y\\in B\\}', 'A\\times B=\\{(x,y)\\mid x\\in A\\land y\\in B\\}', 'Das kartesische Produkt enthält alle geordneten Paare mit erster Komponente aus A und zweiter Komponente aus B.', 'definition', 'literature', 71, NULL, 'A und B sind Mengen.', 'verified', 3),
(8, '3.8', 24, 'Binäre Relation', 'R\\subseteq A\\times B', 'R\\subseteq A\\times B', 'Eine binäre Relation zwischen A und B ist eine Teilmenge ihres kartesischen Produkts.', 'definition', 'literature', 71, NULL, 'A und B sind Mengen.', 'verified', 3),
(9, '3.9', 24, 'Relationsschreibweise', 'xRy\\quad\\Longleftrightarrow\\quad(x,y)\\in R', 'xRy\\quad\\Longleftrightarrow\\quad(x,y)\\in R', 'Die Infixschreibweise xRy ist äquivalent zur Zugehörigkeit des geordneten Paares (x,y) zur Relation R.', 'definition', 'literature', 71, NULL, 'R ist eine Relation.', 'verified', 3),
(10, '3.10', 24, 'Relation auf einer Menge', 'R\\subseteq A\\times A', 'R\\subseteq A\\times A', 'Eine Relation auf A verbindet Elemente desselben Objektbereichs.', 'definition', 'literature', 71, NULL, 'A ist eine Menge.', 'verified', 3),
(11, '3.11', 24, 'Grundeigenschaften binärer Relationen', '\\begin{aligned}R\\text{ reflexiv}&\\quad\\Longleftrightarrow\\quad\\forall x\\in A:\\;xRx,\\\\R\\text{ symmetrisch}&\\quad\\Longleftrightarrow\\quad\\forall x,y\\in A:\\;xRy\\Rightarrow yRx,\\\\R\\text{ antisymmetrisch}&\\quad\\Longleftrightarrow\\quad\\forall x,y\\in A:\\;(xRy\\land yRx)\\Rightarrow x=y,\\\\R\\text{ transitiv}&\\quad\\Longleftrightarrow\\quad\\forall x,y,z\\in A:\\;(xRy\\land yRz)\\Rightarrow xRz.\\end{aligned}', '\\begin{aligned}R\\text{ reflexiv}&\\quad\\Longleftrightarrow\\quad\\forall x\\in A:\\;xRx,\\\\R\\text{ symmetrisch}&\\quad\\Longleftrightarrow\\quad\\forall x,y\\in A:\\;xRy\\Rightarrow yRx,\\\\R\\text{ antisymmetrisch}&\\quad\\Longleftrightarrow\\quad\\forall x,y\\in A:\\;(xRy\\land yRx)\\Rightarrow x=y,\\\\R\\text{ transitiv}&\\quad\\Longleftrightarrow\\quad\\forall x,y,z\\in A:\\;(xRy\\land yRz)\\Rightarrow xRz.\\end{aligned}', 'Gemeinsame formale Charakterisierung von Reflexivität, Symmetrie, Antisymmetrie und Transitivität.', 'definition', 'literature', 71, NULL, 'R ist eine binäre Relation auf A.', 'verified', 3),
(12, '3.12', 24, 'Äquivalenzrelation', 'R\\text{ ist Äquivalenzrelation}\\quad\\Longleftrightarrow\\quad R\\text{ ist reflexiv, symmetrisch und transitiv}', 'R\\text{ ist Äquivalenzrelation}\\quad\\Longleftrightarrow\\quad R\\text{ ist reflexiv, symmetrisch und transitiv}', 'Eine Äquivalenzrelation ist reflexiv, symmetrisch und transitiv.', 'definition', 'literature', 71, NULL, 'R ist eine binäre Relation auf A.', 'verified', 3),
(13, '3.13', 24, 'Partielle Ordnung', 'R\\text{ ist partielle Ordnung}\\quad\\Longleftrightarrow\\quad R\\text{ ist reflexiv, antisymmetrisch und transitiv}', 'R\\text{ ist partielle Ordnung}\\quad\\Longleftrightarrow\\quad R\\text{ ist reflexiv, antisymmetrisch und transitiv}', 'In der verwendeten schwachen Ordnungsnotation ist eine partielle Ordnung reflexiv, antisymmetrisch und transitiv.', 'definition', 'literature', 71, NULL, 'R ist eine binäre Relation auf A; weak-order-Konvention.', 'verified', 3),
(14, '3.14', 26, 'Funktion als eindeutige Relation', 'f\\subseteq A\\times B,\\qquad\\forall x\\in A\\;\\exists !\\,y\\in B:\\;(x,y)\\in f', 'f\\subseteq A\\times B,\\qquad\\forall x\\in A\\;\\exists !\\,y\\in B:\\;(x,y)\\in f', 'Eine Funktion ist eine Relation zwischen A und B, die jedem Element des Definitionsbereichs genau einen Funktionswert zuordnet.', 'definition', 'literature', 71, NULL, 'A und B sind Mengen.', 'verified', 4),
(15, '3.15', 26, 'Bild einer Funktion', '\\operatorname{Bild}(f)=\\{y\\in B\\mid\\exists x\\in A:\\;y=f(x)\\}', '\\operatorname{Bild}(f)=\\{y\\in B\\mid\\exists x\\in A:\\;y=f(x)\\}', 'Das Bild enthält genau die tatsächlich erreichten Elemente des Zielbereichs.', 'definition', 'literature', 71, NULL, 'f ist eine Funktion von A nach B.', 'verified', 4),
(16, '3.16', 26, 'Bild einer Teilmenge', 'f(S)=\\{f(x)\\mid x\\in S\\}', 'f(S)=\\{f(x)\\mid x\\in S\\}', 'Das Bild einer Teilmenge S besteht aus den Funktionswerten ihrer Elemente.', 'definition', 'literature', 71, NULL, 'S ist eine Teilmenge des Definitionsbereichs.', 'verified', 4),
(17, '3.17', 26, 'Urbild einer Teilmenge', 'f^{-1}(T)=\\{x\\in A\\mid f(x)\\in T\\}', 'f^{-1}(T)=\\{x\\in A\\mid f(x)\\in T\\}', 'Das Urbild einer Teilmenge T enthält alle Ausgangselemente, deren Funktionswerte in T liegen.', 'definition', 'literature', 71, NULL, 'T ist eine Teilmenge des Zielbereichs.', 'verified', 4),
(18, '3.18', 26, 'Injektivität', '\\forall x_1,x_2\\in A:\\quad f(x_1)=f(x_2)\\Rightarrow x_1=x_2', '\\forall x_1,x_2\\in A:\\quad f(x_1)=f(x_2)\\Rightarrow x_1=x_2', 'Gleiche Funktionswerte dürfen bei einer injektiven Funktion nur von gleichen Ausgangselementen stammen.', 'definition', 'literature', 71, NULL, 'f ist eine Funktion von A nach B.', 'verified', 4),
(19, '3.19', 26, 'Surjektivität', '\\forall y\\in B\\;\\exists x\\in A:\\quad f(x)=y', '\\forall y\\in B\\;\\exists x\\in A:\\quad f(x)=y', 'Jedes Element des Zielbereichs wird von mindestens einem Ausgangselement erreicht.', 'definition', 'literature', 71, NULL, 'f ist eine Funktion von A nach B.', 'verified', 4),
(20, '3.20', 26, 'Bijektivität', 'f\\text{ bijektiv}\\quad\\Longleftrightarrow\\quad f\\text{ injektiv}\\land f\\text{ surjektiv}', 'f\\text{ bijektiv}\\quad\\Longleftrightarrow\\quad f\\text{ injektiv}\\land f\\text{ surjektiv}', 'Bijektivität ist die Verbindung von Injektivität und Surjektivität.', 'definition', 'literature', 71, NULL, 'f ist eine Funktion von A nach B.', 'verified', 4),
(21, '3.21', 26, 'Umkehrfunktion', 'f^{-1}(f(x))=x\\quad\\text{und}\\quad f(f^{-1}(y))=y\\qquad\\text{für alle }x\\in A,\\;y\\in B', 'f^{-1}(f(x))=x\\quad\\text{und}\\quad f(f^{-1}(y))=y\\qquad\\text{für alle }x\\in A,\\;y\\in B', 'Eine bijektive Funktion besitzt eine beidseitige Umkehrfunktion.', 'definition', 'literature', 71, NULL, 'f ist bijektiv.', 'verified', 4),
(22, '3.22', 26, 'Identische Funktion', '\\operatorname{id}_A:A\\to A,\\qquad\\operatorname{id}_A(x)=x\\quad\\text{für alle }x\\in A', '\\operatorname{id}_A:A\\to A,\\qquad\\operatorname{id}_A(x)=x\\quad\\text{für alle }x\\in A', 'Die Identität bildet jedes Element auf sich selbst ab.', 'definition', 'literature', 71, NULL, 'A ist eine Menge.', 'verified', 4),
(23, '3.23', 26, 'Verkettung von Funktionen', 'g\\circ f:A\\to C,\\qquad(g\\circ f)(x)=g(f(x))', 'g\\circ f:A\\to C,\\qquad(g\\circ f)(x)=g(f(x))', 'Bei der Verkettung wird zunächst f und anschließend g auf das jeweilige Ergebnis angewendet.', 'definition', 'literature', 71, NULL, 'f bildet A nach B und g bildet B nach C ab.', 'verified', 4),
(24, '3.24', 26, 'Assoziativität der Funktionsverkettung', 'h\\circ(g\\circ f)=(h\\circ g)\\circ f', 'h\\circ(g\\circ f)=(h\\circ g)\\circ f', 'Die Verkettung von Funktionen ist assoziativ.', 'derived', 'literature', 71, 'Standardresultat der Funktionsverkettung.', 'f, g und h sind miteinander verkettbare Funktionen.', 'verified', 4),
(25, '3.25', 26, 'Funktion mit mehreren Eingangsgrößen', 'f:A_1\\times\\cdots\\times A_n\\longrightarrow B', 'f:A_1\\times\\cdots\\times A_n\\longrightarrow B', 'Eine Funktion mehrerer Eingangsgrößen besitzt ein kartesisches Produkt als Definitionsbereich.', 'schema', 'literature', 71, NULL, 'A_1 bis A_n und B sind Mengen.', 'verified', 4),
(26, '3.26', 27, 'Operationen eines Vektorraums', '+\\;:\\;V\\times V\\longrightarrow V,\\qquad\\cdot\\;:\\;\\mathbb{K}\\times V\\longrightarrow V', '+:V\\times V\\longrightarrow V,\\qquad\\cdot:\\mathbb{K}\\times V\\longrightarrow V', 'Die Vektoraddition bildet zwei Vektoren wieder auf einen Vektor ab; die Skalarmultiplikation bildet einen Skalar und einen Vektor auf einen Vektor ab.', 'schema', 'literature', 72, NULL, 'V ist ein Vektorraum über dem Körper K.', 'verified', 5),
(27, '3.27', 27, 'Vektorraumaxiome', '\\begin{aligned}u+(v+w)&=(u+v)+w,\\\\u+v&=v+u,\\\\u+0_V&=u,\\\\u+(-u)&=0_V,\\\\\\alpha(u+v)&=\\alpha u+\\alpha v,\\\\(\\alpha+\\beta)u&=\\alpha u+\\beta u,\\\\(\\alpha\\beta)u&=\\alpha(\\beta u),\\\\1_{\\mathbb K}u&=u.\\end{aligned}', '\\begin{aligned}u+(v+w)&=(u+v)+w,\\\\u+v&=v+u,\\\\u+0_V&=u,\\\\u+(-u)&=0_V,\\\\\\alpha(u+v)&=\\alpha u+\\alpha v,\\\\(\\alpha+\\beta)u&=\\alpha u+\\beta u,\\\\(\\alpha\\beta)u&=\\alpha(\\beta u),\\\\1_{\\mathbb K}u&=u.\\end{aligned}', 'Die Vektorraumaxiome bestimmen Assoziativität und Kommutativität der Addition, Nullvektor und additive Inverse sowie die Verträglichkeit der Skalarmultiplikation mit Körper- und Vektoraddition.', 'axiom', 'literature', 72, NULL, 'u,v,w liegen in V; alpha,beta liegen in K.', 'verified', 5),
(28, '3.28', 27, 'Neutraleigenschaft des Nullvektors', 'u+0_V=u\\qquad\\text{für alle }u\\in V', 'u+0_V=u\\qquad\\text{für alle }u\\in V', 'Der Nullvektor ist das neutrale Element der Vektoraddition.', 'definition', 'literature', 72, NULL, 'V ist ein Vektorraum.', 'verified', 5),
(29, '3.29', 27, 'Nullskalierung und Skalierung des Nullvektors', '0_{\\mathbb K}u=0_V,\\qquad\\alpha 0_V=0_V', '0_{\\mathbb K}u=0_V,\\qquad\\alpha 0_V=0_V', 'Multiplikation eines Vektors mit dem skalaren Nullelement sowie Skalierung des Nullvektors ergeben jeweils den Nullvektor.', 'derived', 'literature', 72, 'Folgt aus den Vektorraumaxiomen.', 'u liegt in V; alpha liegt in K.', 'verified', 5),
(30, '3.30', 27, 'Additives Inverses', 'u+(-u)=0_V', 'u+(-u)=0_V', 'Zu jedem Vektor existiert ein additives Inverses, dessen Summe mit dem Ausgangsvektor den Nullvektor ergibt.', 'axiom', 'literature', 72, NULL, 'u liegt in V.', 'verified', 5),
(31, '3.31', 27, 'Abgeschlossenheit eines Untervektorraums', 'u,v\\in U,\\ \\alpha,\\beta\\in\\mathbb K\\quad\\Longrightarrow\\quad\\alpha u+\\beta v\\in U', 'u,v\\in U,\\ \\alpha,\\beta\\in\\mathbb K\\quad\\Longrightarrow\\quad\\alpha u+\\beta v\\in U', 'Eine nichtleere Teilmenge ist Untervektorraum, wenn sie unter Linearkombinationen ihrer Elemente abgeschlossen ist.', 'definition', 'literature', 72, NULL, 'U ist eine nichtleere Teilmenge von V.', 'verified', 5),
(32, '3.32', 27, 'Reelle und komplexe Vektorräume', 'V\\text{ über }\\mathbb R,\\qquad V\\text{ über }\\mathbb C', 'V\\text{ über }\\mathbb R,\\qquad V\\text{ über }\\mathbb C', 'Die Wahl des Skalarkörpers unterscheidet unter anderem reelle und komplexe Vektorräume.', 'schema', 'literature', 72, NULL, 'V ist ein Vektorraum über einem spezifizierten Skalarkörper.', 'verified', 5),
(33, '3.33', 28, 'Linearkombination', 'v=alpha_1v_1+alpha_2v_2+cdots+alpha_nv_n=sum_{i=1}^{n}alpha_i v_i', 'v=alpha_1v_1+alpha_2v_2+cdots+alpha_nv_n=sum_{i=1}^{n}alpha_i v_i', 'Eine Linearkombination entsteht durch skalare Gewichtung und anschließende Addition gegebener Vektoren.', 'definition', 'literature', 72, NULL, 'v_i liegen in V; alpha_i liegen in K.', 'verified', 6),
(34, '3.34', 28, 'Spannraum endlich vieler Vektoren', 'operatorname{span}(v_1,ldots,v_n)=left{sum_{i=1}^{n}alpha_i v_i;middle|;alpha_iinmathbb K\right}', 'operatorname{span}(v_1,ldots,v_n)=left{sum_{i=1}^{n}alpha_i v_i;middle|;alpha_iinmathbb K\right}', 'Der Spannraum enthält genau alle Linearkombinationen der vorgegebenen Vektoren.', 'definition', 'literature', 72, NULL, 'v_1,...,v_n liegen in V.', 'verified', 6),
(35, '3.35', 28, 'Zugehörigkeitskriterium zum Spannraum', 'winoperatorname{span}(v_1,ldots,v_n)quadLongleftrightarrowquadexists,alpha_1,ldots,alpha_ninmathbb K:;w=sum_{i=1}^{n}alpha_i v_i', 'winoperatorname{span}(v_1,ldots,v_n)quadLongleftrightarrowquadexists,alpha_1,ldots,alpha_ninmathbb K:;w=sum_{i=1}^{n}alpha_i v_i', 'Ein Vektor gehört genau dann zum Spannraum, wenn er als Linearkombination der Erzeuger dargestellt werden kann.', 'derived', 'literature', 72, 'Direkte Charakterisierung durch die Definition des Spannraums.', 'w liegt in V.', 'verified', 6),
(36, '3.36', 28, 'Abgeschlossenheit des Spannraums', 'u,winoperatorname{span}(v_1,ldots,v_n)quadLongrightarrowquadalpha u+eta winoperatorname{span}(v_1,ldots,v_n)', 'u,winoperatorname{span}(v_1,ldots,v_n)quadLongrightarrowquadalpha u+eta winoperatorname{span}(v_1,ldots,v_n)', 'Der Spannraum ist unter Linearkombinationen seiner Elemente abgeschlossen.', 'derived', 'literature', 72, 'Folgt daraus, dass Linearkombinationen von Linearkombinationen erneut Linearkombinationen der ursprünglichen Erzeuger sind.', 'alpha und beta liegen in K.', 'verified', 6),
(37, '3.37', 28, 'Minimalität des Spannraums', 'v_1,ldots,v_nin UquadLongrightarrowquadoperatorname{span}(v_1,ldots,v_n)subseteq U', 'v_1,ldots,v_nin UquadLongrightarrowquadoperatorname{span}(v_1,ldots,v_n)subseteq U', 'Jeder Untervektorraum, der alle Erzeuger enthält, enthält auch deren gesamten Spannraum.', 'derived', 'literature', 72, 'Folgt aus der Abgeschlossenheit eines Untervektorraums unter Linearkombinationen.', 'U ist Untervektorraum von V.', 'verified', 6),
(38, '3.38', 28, 'Erzeugendensystem', 'operatorname{span}(v_1,ldots,v_n)=V', 'operatorname{span}(v_1,ldots,v_n)=V', 'Die Vektoren bilden ein Erzeugendensystem, wenn sie den gesamten Vektorraum aufspannen.', 'definition', 'literature', 72, NULL, 'v_1,...,v_n liegen in V.', 'verified', 6),
(39, '3.39', 28, 'Redundanter Erzeuger', 'v_kinoperatorname{span}(v_1,ldots,v_{k-1},v_{k+1},ldots,v_n)', 'v_kinoperatorname{span}(v_1,ldots,v_{k-1},v_{k+1},ldots,v_n)', 'Ein Erzeuger ist redundant, wenn er bereits im Spannraum der übrigen Erzeuger liegt.', 'schema', 'literature', 72, NULL, 'v_1,...,v_n liegen in V.', 'verified', 6),
(40, '3.40', 28, 'Entfernung eines redundanten Erzeugers', 'operatorname{span}(v_1,ldots,v_n)=operatorname{span}(v_1,ldots,v_{k-1},v_{k+1},ldots,v_n)', 'operatorname{span}(v_1,ldots,v_n)=operatorname{span}(v_1,ldots,v_{k-1},v_{k+1},ldots,v_n)', 'Ein redundanter Vektor kann entfernt werden, ohne den aufgespannten Raum zu verändern.', 'derived', 'literature', 72, 'Folgt aus Gleichung 3.39 und der Definition des Spannraums.', 'v_k liegt im Spannraum der übrigen Erzeuger.', 'verified', 6),
(41, '3.41', 28, 'Vektor außerhalb des vorhandenen Spannraums', 'w\notinoperatorname{span}(v_1,ldots,v_n)', 'w\notinoperatorname{span}(v_1,ldots,v_n)', 'Die Bedingung kennzeichnet einen Vektor, der nicht durch Linearkombination der vorhandenen Erzeuger dargestellt werden kann.', 'schema', 'literature', 72, NULL, 'w liegt in V.', 'verified', 6),
(42, '3.42', 28, 'Erweiterung des Spannraums', 'operatorname{span}(v_1,ldots,v_n)subsetneqoperatorname{span}(v_1,ldots,v_n,w)', 'operatorname{span}(v_1,ldots,v_n)subsetneqoperatorname{span}(v_1,ldots,v_n,w)', 'Die Hinzunahme eines Vektors außerhalb des bisherigen Spannraums vergrößert den erzeugten Untervektorraum echt.', 'derived', 'literature', 72, 'Folgt aus Gleichung 3.41 und der Definition des Spannraums.', 'w liegt nicht im Spannraum von v_1,...,v_n.', 'verified', 6),
(43, '3.43', 28, 'Spann einer allgemeinen Teilmenge', 'operatorname{span}(S)=left{sum_{i=1}^{n}alpha_i v_i;middle|;ninmathbb N,;v_iin S,;alpha_iinmathbb K\right}', 'operatorname{span}(S)=left{sum_{i=1}^{n}alpha_i v_i;middle|;ninmathbb N,;v_iin S,;alpha_iinmathbb K\right}', 'Der algebraische Spann einer beliebigen Teilmenge besteht aus allen endlichen Linearkombinationen ihrer Elemente.', 'definition', 'literature', 72, NULL, 'S ist eine Teilmenge eines Vektorraums V.', 'verified', 6),
(44, '3.44', 28, 'Mögliche Mehrdeutigkeit einer Darstellung', 'v=sum_{i=1}^{n}alpha_i v_i=sum_{i=1}^{n}eta_i v_i', 'v=sum_{i=1}^{n}alpha_i v_i=sum_{i=1}^{n}eta_i v_i', 'Ein Erzeugendensystem kann denselben Vektor durch verschiedene Koeffizientensätze darstellen; Eindeutigkeit erfordert zusätzliche Unabhängigkeitsbedingungen.', 'schema', 'literature', 72, NULL, 'Die Erzeuger müssen nicht linear unabhängig sein.', 'verified', 6),
(45, '3.45', 29, 'Kriterium der linearen Unabhängigkeit', 'sum_{i=1}^{n}alpha_i v_i=0_VquadLongrightarrowquadalpha_1=alpha_2=cdots=alpha_n=0_{mathbb K}', 'sum_{i=1}^{n}alpha_i v_i=0_VquadLongrightarrowquadalpha_1=alpha_2=cdots=alpha_n=0_{mathbb K}', 'Die einzige Linearkombination der betrachteten Vektoren, die den Nullvektor ergibt, ist im linear unabhängigen Fall die triviale Linearkombination.', 'definition', 'literature', 72, NULL, 'v_1,...,v_n liegen in V; alpha_i liegen in K.', 'verified', 7),
(46, '3.46', 29, 'Nichttriviale Nullkombination bei linearer Abhängigkeit', 'sum_{i=1}^{n}alpha_i v_i=0_Vqquad	ext{mit mindestens einem }alpha_i\neq0_{mathbb K}', 'sum_{i=1}^{n}alpha_i v_i=0_Vqquad	ext{mit mindestens einem }alpha_i\neq0_{mathbb K}', 'Bei linearer Abhängigkeit existiert eine nichttriviale Linearkombination, die den Nullvektor ergibt.', 'schema', 'literature', 72, NULL, 'v_1,...,v_n sind linear abhängig.', 'verified', 7),
(47, '3.47', 29, 'Redundanz eines Vektors im abhängigen System', 'v_kinoperatorname{span}(v_1,ldots,v_{k-1},v_{k+1},ldots,v_n)', 'v_kinoperatorname{span}(v_1,ldots,v_{k-1},v_{k+1},ldots,v_n)', 'In einem linear abhängigen System lässt sich mindestens ein Vektor durch die übrigen Vektoren linear erzeugen.', 'derived', 'literature', 72, 'Folgt aus einer nichttrivialen linearen Relation, indem nach einem Koeffizienten ungleich null aufgelöst wird.', 'v_1,...,v_n sind linear abhängig.', 'verified', 7),
(48, '3.48', 29, 'Basis als unabhängiges Erzeugendensystem', 'mathcal B	ext{ ist Basis von }VquadLongleftrightarrowquadegin{cases}b_1,ldots,b_n	ext{ sind linear unabhängig},\\operatorname{span}(b_1,ldots,b_n)=V.end{cases}', 'mathcal B	ext{ ist Basis von }VquadLongleftrightarrowquadegin{cases}b_1,ldots,b_n	ext{ sind linear unabhängig},\\operatorname{span}(b_1,ldots,b_n)=V.end{cases}', 'Eine Basis verbindet lineare Unabhängigkeit mit vollständiger Erzeugung des Vektorraums.', 'definition', 'literature', 72, NULL, 'b_1,...,b_n liegen in V.', 'verified', 7),
(49, '3.49', 29, 'Darstellung eines Vektors bezüglich einer Basis', 'v=sum_{i=1}^{n}alpha_i b_i', 'v=sum_{i=1}^{n}alpha_i b_i', 'Jeder Vektor eines endlich erzeugten Vektorraums lässt sich bezüglich einer Basis als Linearkombination der Basisvektoren darstellen.', 'theorem', 'literature', 72, 'Existenz folgt aus der Erzeugungseigenschaft der Basis.', 'mathcal B={b_1,ldots,b_n} ist eine Basis von V.', 'verified', 7),
(50, '3.50', 29, 'Zwei Basisdarstellungen desselben Vektors', 'v=sum_{i=1}^{n}alpha_i b_i=sum_{i=1}^{n}eta_i b_i', 'v=sum_{i=1}^{n}alpha_i b_i=sum_{i=1}^{n}eta_i b_i', 'Zur Prüfung der Eindeutigkeit werden zwei mögliche Basisdarstellungen desselben Vektors gegenübergestellt.', 'theorem', 'literature', 72, 'Aus der Differenz beider Darstellungen entsteht eine Linearkombination der Basisvektoren mit Ergebnis Nullvektor.', 'mathcal B={b_1,ldots,b_n} ist eine Basis von V.', 'verified', 7),
(51, '3.51', 29, 'Eindeutigkeit der Basiskoeffizienten', 'alpha_i=eta_iqquad	ext{für alle }i=1,ldots,n', 'alpha_i=eta_iqquad	ext{für alle }i=1,ldots,n', 'Die Koeffizienten zweier Darstellungen bezüglich derselben Basis stimmen aufgrund der linearen Unabhängigkeit überein.', 'theorem', 'literature', 72, 'Folgt aus der linearen Unabhängigkeit der Basisvektoren.', 'mathcal B={b_1,ldots,b_n} ist eine Basis von V.', 'verified', 7),
(52, '3.52', 29, 'Koordinatenvektor bezüglich einer Basis', '[v]_{mathcal B}=egin{pmatrix}alpha_1\\alpha_2\\vdots\\alpha_nend{pmatrix}', '[v]_{mathcal B}=egin{pmatrix}alpha_1\\alpha_2\\vdots\\alpha_nend{pmatrix}', 'Der Koordinatenvektor enthält die eindeutigen Koeffizienten der Darstellung eines Vektors bezüglich einer geordneten Basis.', 'definition', 'literature', 72, NULL, 'mathcal B ist eine geordnete Basis; v=sum_i alpha_i b_i.', 'verified', 7),
(53, '3.53', 29, 'Dimension eines endlichdimensionalen Vektorraums', 'dim(V)=n', 'dim(V)=n', 'Die Dimension eines endlichdimensionalen Vektorraums ist die Anzahl der Elemente einer Basis.', 'definition', 'literature', 72, NULL, 'V besitzt eine Basis mit n Elementen.', 'verified', 7),
(54, '3.54', 29, 'Dimensionsschranke eines Untervektorraums', 'Usubseteq VquadLongrightarrowquaddim(U)leqdim(V)', 'Usubseteq VquadLongrightarrowquaddim(U)leqdim(V)', 'Ein Untervektorraum eines endlichdimensionalen Vektorraums besitzt höchstens dessen Dimension.', 'theorem', 'literature', 72, 'Standardresultat der endlichdimensionalen linearen Algebra.', 'U ist ein Untervektorraum des endlichdimensionalen Vektorraums V.', 'verified', 7),
(55, '3.55', 29, 'Neue Richtung außerhalb des bisherigen Spannraums', 'w\notinoperatorname{span}(v_1,ldots,v_n)', 'w\notinoperatorname{span}(v_1,ldots,v_n)', 'Die Bedingung kennzeichnet einen Vektor, der nicht aus den bisherigen Richtungen linear erzeugt werden kann.', 'schema', 'literature', 72, NULL, 'v_1,...,v_n sind linear unabhängig; w liegt in einem übergeordneten Vektorraum.', 'verified', 7),
(56, '3.56', 29, 'Erweitertes Vektorsystem', 'v_1,ldots,v_n,w', 'v_1,ldots,v_n,w', 'Das bestehende linear unabhängige System wird um den außerhalb seines Spannraums liegenden Vektor w erweitert.', 'schema', 'literature', 72, NULL, 'w liegt nicht im Spannraum von v_1,...,v_n.', 'verified', 7),
(57, '3.57', 29, 'Dimensionserhöhung durch eine neue unabhängige Richtung', 'dimleft(operatorname{span}(v_1,ldots,v_n,w)\right)=n+1', 'dimleft(operatorname{span}(v_1,ldots,v_n,w)\right)=n+1', 'Wird eine Basis mit n unabhängigen Richtungen um einen Vektor außerhalb ihres Spannraums erweitert, besitzt der erweiterte Spannraum die Dimension n+1.', 'theorem', 'literature', 72, 'Das erweiterte System ist linear unabhängig und erzeugt den vergrößerten Spannraum.', 'v_1,...,v_n bilden eine Basis eines n-dimensionalen Spannraums; w liegt außerhalb dieses Spannraums.', 'verified', 7),
(58, '3.58', 30, 'Linearitätsbedingungen', 'T(u+v)=T(u)+T(v),\\qquad T(\\alpha u)=\\alpha T(u)', 'T(u+v)=T(u)+T(v),\\qquad T(\\alpha u)=\\alpha T(u)', 'Eine lineare Abbildung erhält Vektoraddition und Skalarmultiplikation.', 'definition', 'literature', 72, NULL, 'T:V nach W; u,v liegen in V; alpha liegt in K.', 'verified', 8),
(59, '3.59', 30, 'Linearität einer Zweierkombination', 'T(\\alpha u+\\beta v)=\\alpha T(u)+\\beta T(v)', 'T(\\alpha u+\\beta v)=\\alpha T(u)+\\beta T(v)', 'Die Linearitätsbedingungen können für eine Linearkombination zweier Vektoren zusammengefasst werden.', 'derived', 'literature', 72, 'Folgt unmittelbar aus Additivität und Homogenität.', 'u,v liegen in V; alpha,beta liegen in K.', 'verified', 8),
(60, '3.60', 30, 'Linearität endlicher Linearkombinationen', 'T\\left(\\sum_{i=1}^{n}\\alpha_i v_i\\right)=\\sum_{i=1}^{n}\\alpha_iT(v_i)', 'T\\left(\\sum_{i=1}^{n}\\alpha_i v_i\\right)=\\sum_{i=1}^{n}\\alpha_iT(v_i)', 'Eine lineare Abbildung kann durch eine endliche Linearkombination hindurchgezogen werden.', 'derived', 'literature', 72, 'Folgt iterativ aus Gleichung 3.59.', 'v_i liegen in V; alpha_i liegen in K.', 'verified', 8),
(61, '3.61', 30, 'Bild des Nullvektors', 'T(0_V)=0_W', 'T(0_V)=0_W', 'Jede lineare Abbildung bildet den Nullvektor des Ausgangsraums auf den Nullvektor des Zielraums ab.', 'derived', 'literature', 72, 'Folgt aus der Homogenität mit dem skalaren Nullelement.', 'T ist linear.', 'verified', 8),
(62, '3.62', 30, 'Bild eines Spannraums', 'T\\left(\\operatorname{span}(v_1,\\ldots,v_n)\\right)=\\operatorname{span}\\bigl(T(v_1),\\ldots,T(v_n)\\bigr)', 'T\\left(\\operatorname{span}(v_1,\\ldots,v_n)\\right)=\\operatorname{span}\\bigl(T(v_1),\\ldots,T(v_n)\\bigr)', 'Das Bild eines endlich erzeugten Spannraums ist der Spannraum der Bilder seiner Erzeuger.', 'theorem', 'literature', 72, 'Folgt aus der Verträglichkeit linearer Abbildungen mit Linearkombinationen.', 'T ist linear; v_1,...,v_n liegen im Definitionsraum.', 'verified', 8),
(63, '3.63', 30, 'Kern einer linearen Abbildung', '\\ker(T)=\\{v\\in V\\mid T(v)=0_W\\}', '\\ker(T)=\\{v\\in V\\mid T(v)=0_W\\}', 'Der Kern enthält genau die Ausgangsvektoren, die auf den Nullvektor abgebildet werden.', 'definition', 'literature', 72, NULL, 'T ist eine lineare Abbildung von V nach W.', 'verified', 8),
(64, '3.64', 30, 'Abgeschlossenheit des Kerns', 'T(\\alpha u+\\beta v)=\\alpha T(u)+\\beta T(v)=0_W', 'T(\\alpha u+\\beta v)=\\alpha T(u)+\\beta T(v)=0_W', 'Linearkombinationen von Kernelementen liegen wieder im Kern.', 'derived', 'literature', 72, 'Folgt aus der Linearität und aus T(u)=T(v)=0_W.', 'u,v liegen im Kern; alpha,beta liegen in K.', 'verified', 8),
(65, '3.65', 30, 'Injektivitätskriterium über den Kern', 'T\\text{ injektiv}\\quad\\Longleftrightarrow\\quad\\ker(T)=\\{0_V\\}', 'T\\text{ injektiv}\\quad\\Longleftrightarrow\\quad\\ker(T)=\\{0_V\\}', 'Eine lineare Abbildung ist genau dann injektiv, wenn ihr Kern trivial ist.', 'theorem', 'literature', 72, 'Standardkriterium für lineare Abbildungen.', 'T ist linear.', 'verified', 8),
(66, '3.66', 30, 'Gleiche Bilder und Kerndifferenz', 'T(u)=T(v)\\quad\\Longrightarrow\\quad T(u-v)=0_W', 'T(u)=T(v)\\quad\\Longrightarrow\\quad T(u-v)=0_W', 'Haben zwei Ausgangsvektoren dasselbe Bild, liegt ihre Differenz im Kern.', 'derived', 'literature', 72, 'T(u-v)=T(u)-T(v).', 'T ist linear.', 'verified', 8),
(67, '3.67', 30, 'Bildraum einer linearen Abbildung', '\\operatorname{im}(T)=\\{T(v)\\mid v\\in V\\}', '\\operatorname{im}(T)=\\{T(v)\\mid v\\in V\\}', 'Der Bildraum enthält alle tatsächlich durch die lineare Abbildung erreichten Zielvektoren.', 'definition', 'literature', 72, NULL, 'T ist eine lineare Abbildung von V nach W.', 'verified', 8),
(68, '3.68', 30, 'Abgeschlossenheit des Bildraums', '\\alpha T(u)+\\beta T(v)=T(\\alpha u+\\beta v)', '\\alpha T(u)+\\beta T(v)=T(\\alpha u+\\beta v)', 'Eine Linearkombination von Bildvektoren ist wiederum ein Bildvektor.', 'derived', 'literature', 72, 'Folgt aus der Linearität von T.', 'u,v liegen in V; alpha,beta liegen in K.', 'verified', 8),
(69, '3.69', 30, 'Rang und Nullität', '\\operatorname{rang}(T)=\\dim\\bigl(\\operatorname{im}(T)\\bigr),\\qquad\\operatorname{null}(T)=\\dim\\bigl(\\ker(T)\\bigr)', '\\operatorname{rang}(T)=\\dim\\bigl(\\operatorname{im}(T)\\bigr),\\qquad\\operatorname{null}(T)=\\dim\\bigl(\\ker(T)\\bigr)', 'Rang und Nullität sind die Dimensionen von Bildraum und Kern.', 'definition', 'literature', 72, NULL, 'Die betreffenden Unterräume sind endlichdimensional.', 'verified', 8),
(70, '3.70', 30, 'Rang-Nullitätssatz', '\\dim(V)=\\dim\\bigl(\\ker(T)\\bigr)+\\dim\\bigl(\\operatorname{im}(T)\\bigr)', '\\dim(V)=\\dim\\bigl(\\ker(T)\\bigr)+\\dim\\bigl(\\operatorname{im}(T)\\bigr)', 'Die Dimension des Ausgangsraums zerfällt in die Dimension des Kerns und die Dimension des Bildes.', 'theorem', 'literature', 72, 'Rang-Nullitätssatz der endlichdimensionalen linearen Algebra.', 'V ist endlichdimensional; T ist linear.', 'verified', 8),
(71, '3.71', 30, 'Rang-Nullitätssatz in Kurzform', '\\dim(V)=\\operatorname{null}(T)+\\operatorname{rang}(T)', '\\dim(V)=\\operatorname{null}(T)+\\operatorname{rang}(T)', 'Der Rang-Nullitätssatz wird mit den zuvor definierten Kurzbezeichnungen geschrieben.', 'theorem', 'literature', 72, 'Umformulierung von Gleichung 3.70 mit Gleichung 3.69.', 'V ist endlichdimensional; T ist linear.', 'verified', 8),
(72, '3.72', 30, 'Linearer Operator', 'T:V\\longrightarrow V', 'T:V\\longrightarrow V', 'Ein linearer Operator ist eine lineare Abbildung eines Vektorraums in sich selbst.', 'definition', 'literature', 72, NULL, 'T ist linear.', 'verified', 8),
(73, '3.73', 30, 'Identitätsoperator', 'I_V(v)=v\\qquad\\text{für alle }v\\in V', 'I_V(v)=v\\qquad\\text{für alle }v\\in V', 'Der Identitätsoperator lässt jeden Vektor unverändert.', 'definition', 'literature', 72, NULL, 'v liegt in V.', 'verified', 8),
(74, '3.74', 30, 'Nulloperator', '0_{\\mathcal L}(v)=0_V\\qquad\\text{für alle }v\\in V', '0_{\\mathcal L}(v)=0_V\\qquad\\text{für alle }v\\in V', 'Der Nulloperator bildet jeden Vektor des Raums auf den Nullvektor ab.', 'definition', 'literature', 72, NULL, 'v liegt in V.', 'verified', 8),
(75, '3.75', 30, 'Verkettung linearer Abbildungen', 'S\\circ T:U\\longrightarrow W', 'S\\circ T:U\\longrightarrow W', 'Die Verkettung zweier passend definierter linearer Abbildungen ist wiederum linear.', 'theorem', 'literature', 72, 'Standardresultat der Linearität unter Komposition.', 'T:U nach V und S:V nach W sind linear.', 'verified', 8),
(76, '3.76', 30, 'Auswertung einer Verkettung', '(S\\circ T)(u)=S(T(u))', '(S\\circ T)(u)=S(T(u))', 'Die Verkettung wird zuerst mit T und anschließend mit S ausgewertet.', 'definition', 'literature', 72, NULL, 'u liegt im Definitionsraum U.', 'verified', 8),
(77, '3.77', 30, 'Kommutation zweier Operatoren', 'S\\circ T=T\\circ S', 'S\\circ T=T\\circ S', 'Diese Gleichung ist keine allgemeine Eigenschaft linearer Operatoren, sondern definiert den besonderen Fall, dass zwei Operatoren kommutieren.', 'schema', 'literature', 72, NULL, 'S und T sind Operatoren auf demselben Vektorraum; Gleichheit ist eine zusätzliche Bedingung.', 'verified', 8),
(78, '3.78', 30, 'Invertierbarer linearer Operator', 'T^{-1}T=TT^{-1}=I_V', 'T^{-1}T=TT^{-1}=I_V', 'Ein invertierbarer linearer Operator besitzt eine lineare Umkehrabbildung, deren beidseitige Verkettung die Identität ergibt.', 'theorem', 'literature', 72, 'Folgt aus der Bijektivität beziehungsweise Invertierbarkeit des Operators.', 'T ist ein invertierbarer linearer Operator auf V.', 'verified', 8),
(79, '3.79', 30, 'Matrixdarstellung einer linearen Abbildung', '[T(v)]_{\\mathcal C}=A[v]_{\\mathcal B}', '[T(v)]_{\\mathcal C}=A[v]_{\\mathcal B}', 'Bezüglich gewählter Basen wird eine lineare Abbildung durch Matrixmultiplikation auf Koordinatenvektoren dargestellt.', 'schema', 'literature', 72, NULL, 'B ist Basis von V, C ist Basis von W und A ist die Darstellungsmatrix von T bezüglich dieser Basen.', 'verified', 8),
(80, '3.80', 30, 'Spalten der Darstellungsmatrix', 'A=\\begin{pmatrix}[T(b_1)]_{\\mathcal C}&[T(b_2)]_{\\mathcal C}&\\cdots&[T(b_n)]_{\\mathcal C}\\end{pmatrix}', 'A=\\begin{pmatrix}[T(b_1)]_{\\mathcal C}&[T(b_2)]_{\\mathcal C}&\\cdots&[T(b_n)]_{\\mathcal C}\\end{pmatrix}', 'Die Spalten der Darstellungsmatrix sind die Koordinaten der Bilder der Basisvektoren des Ausgangsraums.', 'schema', 'literature', 72, NULL, 'B=(b_1,...,b_n) ist Basis von V und C ist Basis von W.', 'verified', 8),
(81, '3.81', 31, 'Normaxiome', '\\begin{aligned}\\|v\\|&\\geq 0,\\\\\\|v\\|=0&\\quad\\Longleftrightarrow\\quad v=0_V,\\\\\\|\\alpha v\\|&=|\\alpha|\\,\\|v\\|,\\\\\\|u+v\\|&\\leq\\|u\\|+\\|v\\|.\\end{aligned}', '\\begin{aligned}\\|v\\|&\\geq 0,\\\\\\|v\\|=0&\\quad\\Longleftrightarrow\\quad v=0_V,\\\\\\|\\alpha v\\|&=|\\alpha|\\,\\|v\\|,\\\\\\|u+v\\|&\\leq\\|u\\|+\\|v\\|.\\end{aligned}', 'Eine Norm erfüllt Nichtnegativität, Definitheit, absolute Homogenität und Dreiecksungleichung.', 'definition', 'literature', 73, NULL, 'V ist ein reeller oder komplexer Vektorraum.', 'verified', 9),
(82, '3.82', 31, 'Normierter Vektorraum', '(V,\\|\\cdot\\|)', '(V,\\|\\cdot\\|)', 'Ein normierter Vektorraum wird als Vektorraum zusammen mit seiner Norm notiert.', 'definition', 'literature', 73, NULL, 'V ist ein Vektorraum und ||.|| eine Norm auf V.', 'verified', 9),
(83, '3.83', 31, 'Norminduzierte Metrik', 'd(u,v)=\\|u-v\\|', 'd(u,v)=\\|u-v\\|', 'Eine Norm erzeugt durch die Norm der Differenz einen Abstand zwischen zwei Vektoren.', 'metric', 'literature', 73, NULL, 'u und v liegen in einem normierten Vektorraum.', 'verified', 9),
(84, '3.84', 31, 'Metrikaxiome', '\\begin{aligned}d(x,y)&\\geq0,\\\\d(x,y)=0&\\quad\\Longleftrightarrow\\quad x=y,\\\\d(x,y)&=d(y,x),\\\\d(x,z)&\\leq d(x,y)+d(y,z).\\end{aligned}', '\\begin{aligned}d(x,y)&\\geq0,\\\\d(x,y)=0&\\quad\\Longleftrightarrow\\quad x=y,\\\\d(x,y)&=d(y,x),\\\\d(x,z)&\\leq d(x,y)+d(y,z).\\end{aligned}', 'Eine Metrik erfüllt Nichtnegativität, Definitheit, Symmetrie und Dreiecksungleichung.', 'metric', 'literature', 73, NULL, 'x,y,z liegen in einer nichtleeren Menge X.', 'verified', 9),
(85, '3.85', 31, 'Umgekehrte Dreiecksungleichung', '\\bigl|\\|u\\|-\\|v\\|\\bigr|\\leq\\|u-v\\|', '\\bigl|\\|u\\|-\\|v\\|\\bigr|\\leq\\|u-v\\|', 'Die Differenz der Normen zweier Vektoren ist durch den norminduzierten Abstand der Vektoren beschränkt.', 'derived', 'literature', 73, 'Folgt aus der Dreiecksungleichung der Norm.', 'u und v liegen in einem normierten Vektorraum.', 'verified', 9),
(86, '3.86', 31, 'Skalarproduktaxiome', '\\begin{aligned}\\langle\\alpha u+\\beta v,w\\rangle&=\\alpha\\langle u,w\\rangle+\\beta\\langle v,w\\rangle,\\\\\\langle u,v\\rangle&=\\overline{\\langle v,u\\rangle},\\\\\\langle v,v\\rangle&\\geq0,\\\\\\langle v,v\\rangle=0&\\quad\\Longleftrightarrow\\quad v=0_V.\\end{aligned}', '\\begin{aligned}\\langle\\alpha u+\\beta v,w\\rangle&=\\alpha\\langle u,w\\rangle+\\beta\\langle v,w\\rangle,\\\\\\langle u,v\\rangle&=\\overline{\\langle v,u\\rangle},\\\\\\langle v,v\\rangle&\\geq0,\\\\\\langle v,v\\rangle=0&\\quad\\Longleftrightarrow\\quad v=0_V.\\end{aligned}', 'Das Skalarprodukt ist in der verwendeten Konvention im ersten Argument linear, konjugiert symmetrisch und positiv definit.', 'definition', 'literature', 73, NULL, 'V ist ein reeller oder komplexer Vektorraum.', 'verified', 9),
(87, '3.87', 31, 'Vom Skalarprodukt zur Norm', '\\|v\\|=\\sqrt{\\langle v,v\\rangle}', '\\|v\\|=\\sqrt{\\langle v,v\\rangle}', 'Ein Skalarprodukt induziert eine Norm durch die Quadratwurzel des Skalarprodukts eines Vektors mit sich selbst.', 'theorem', 'literature', 73, 'Grundlegende Konstruktion in Skalarprodukträumen.', 'V ist ein Skalarproduktraum.', 'verified', 9),
(88, '3.88', 31, 'Cauchy-Schwarz-Ungleichung', '|\\langle u,v\\rangle|\\leq\\|u\\|\\,\\|v\\|', '|\\langle u,v\\rangle|\\leq\\|u\\|\\,\\|v\\|', 'Der Betrag des Skalarprodukts ist durch das Produkt der induzierten Normen beschränkt.', 'theorem', 'literature', 73, 'Cauchy-Schwarz-Ungleichung.', 'u und v liegen in einem Skalarproduktraum.', 'verified', 9),
(89, '3.89', 31, 'Orthogonalität', 'u\\perp v\\quad\\Longleftrightarrow\\quad\\langle u,v\\rangle=0', 'u\\perp v\\quad\\Longleftrightarrow\\quad\\langle u,v\\rangle=0', 'Zwei Vektoren sind genau dann orthogonal, wenn ihr Skalarprodukt verschwindet.', 'definition', 'literature', 73, NULL, 'u und v liegen in einem Skalarproduktraum.', 'verified', 9),
(90, '3.90', 31, 'Pythagoreische Beziehung', '\\|u+v\\|^2=\\|u\\|^2+\\|v\\|^2', '\\|u+v\\|^2=\\|u\\|^2+\\|v\\|^2', 'Für orthogonale Vektoren zerfällt das Quadrat der Norm der Summe additiv.', 'theorem', 'literature', 73, 'Folgt aus der Skalarproduktentwicklung und der Orthogonalität.', 'u und v sind orthogonal.', 'verified', 9),
(91, '3.91', 31, 'Winkel im reellen Skalarproduktraum', '\\cos\\theta=\\frac{\\langle u,v\\rangle}{\\|u\\|\\,\\|v\\|}', '\\cos\\theta=\\frac{\\langle u,v\\rangle}{\\|u\\|\\,\\|v\\|}', 'Für zwei von null verschiedene Vektoren eines reellen Skalarproduktraums wird der Winkel über das normierte Skalarprodukt definiert.', 'definition', 'literature', 72, NULL, 'u und v sind von null verschiedene Vektoren eines reellen Skalarproduktraums.', 'verified', 9),
(92, '3.92', 31, 'Orthonormalitätsbedingung', '\\langle e_i,e_j\\rangle=\\delta_{ij}', '\\langle e_i,e_j\\rangle=\\delta_{ij}', 'Ein orthonormales System besitzt paarweise verschwindende Skalarprodukte und normierte Einzelvektoren.', 'definition', 'literature', 73, NULL, 'Die e_i liegen in einem Skalarproduktraum.', 'verified', 9),
(93, '3.93', 31, 'Kronecker-Symbol', '\\delta_{ij}=\\begin{cases}1,&i=j,\\\\0,&i\\neq j.\\end{cases}', '\\delta_{ij}=\\begin{cases}1,&i=j,\\\\0,&i\\neq j.\\end{cases}', 'Das Kronecker-Symbol fasst die Normierungs- und Orthogonalitätsfälle eines orthonormalen Systems zusammen.', 'definition', 'literature', 73, NULL, 'i und j sind Indizes des betrachteten orthonormalen Systems.', 'verified', 9),
(94, '3.94', 31, 'Darstellung bezüglich einer orthonormalen Basis', 'v=\\sum_{i=1}^{n}\\langle v,e_i\\rangle e_i', 'v=\\sum_{i=1}^{n}\\langle v,e_i\\rangle e_i', 'Bezüglich einer endlichen orthonormalen Basis sind die Koeffizienten eines Vektors durch seine Skalarprodukte mit den Basisvektoren gegeben.', 'theorem', 'literature', 73, 'Folgt aus Orthonormalität und eindeutiger Basisdarstellung.', 'e_1,...,e_n bilden eine orthonormale Basis.', 'verified', 9),
(95, '3.95', 31, 'Orthogonale Projektion auf eine Richtung', '\\operatorname{proj}_{v}(u)=\\frac{\\langle u,v\\rangle}{\\langle v,v\\rangle}\\,v', '\\operatorname{proj}_{v}(u)=\\frac{\\langle u,v\\rangle}{\\langle v,v\\rangle}\\,v', 'Die orthogonale Projektion bestimmt die Komponente von u in der von v erzeugten Richtung.', 'definition', 'literature', 73, NULL, 'v ist von null verschieden.', 'verified', 9),
(96, '3.96', 31, 'Parallelogrammidentität', '\\|u+v\\|^2+\\|u-v\\|^2=2\\|u\\|^2+2\\|v\\|^2', '\\|u+v\\|^2+\\|u-v\\|^2=2\\|u\\|^2+2\\|v\\|^2', 'Jede durch ein Skalarprodukt induzierte Norm erfüllt die Parallelogrammidentität.', 'theorem', 'literature', 73, 'Folgt aus der Entwicklung beider Normquadrate mit dem zugrunde liegenden Skalarprodukt.', 'Die Norm ist durch ein Skalarprodukt induziert.', 'verified', 9),
(97, '3.97', 31, 'Strukturelle Hierarchie von Skalarprodukt, Norm und Metrik', '\\text{Skalarprodukt}\\Longrightarrow\\text{Norm}\\Longrightarrow\\text{Metrik}', '\\text{Skalarprodukt}\\Longrightarrow\\text{Norm}\\Longrightarrow\\text{Metrik}', 'Die Darstellung fasst die logische Strukturrichtung zusammen: Ein Skalarprodukt induziert eine Norm und eine Norm induziert eine Metrik; die Umkehrungen gelten nicht allgemein.', 'schema', 'literature', 73, NULL, 'Die Pfeile bezeichnen strukturelle Implikationen und keine Äquivalenzen.', 'verified', 9),
(98, '3.98', 32, 'Topologie als Teilmenge der Potenzmenge', '\\tau\\subseteq\\mathcal P(X)', '\\tau\\subseteq\\mathcal P(X)', 'Eine Topologie ist eine Familie von Teilmengen der Grundmenge X.', 'definition', 'literature', 74, NULL, 'X ist eine Menge.', 'verified', 10),
(99, '3.99', 32, 'Topologieaxiome', '\\begin{aligned}\\varnothing&\\in\\tau,\\qquad X\\in\\tau,\\\\\\{U_i\\}_{i\\in I}\\subseteq\\tau&\\Longrightarrow\\bigcup_{i\\in I}U_i\\in\\tau,\\\\U_1,\\ldots,U_n\\in\\tau&\\Longrightarrow\\bigcap_{k=1}^{n}U_k\\in\\tau.\\end{aligned}', '\\begin{aligned}\\varnothing&\\in\\tau,\\qquad X\\in\\tau,\\\\\\{U_i\\}_{i\\in I}\\subseteq\\tau&\\Longrightarrow\\bigcup_{i\\in I}U_i\\in\\tau,\\\\U_1,\\ldots,U_n\\in\\tau&\\Longrightarrow\\bigcap_{k=1}^{n}U_k\\in\\tau.\\end{aligned}', 'Die leere Menge und X sind offen; beliebige Vereinigungen und endliche Durchschnitte offener Mengen sind offen.', 'definition', 'literature', 74, NULL, 'tau ist eine Familie von Teilmengen von X.', 'verified', 10),
(100, '3.100', 32, 'Topologischer Raum', '(X,\\tau)', '(X,\\tau)', 'Das Paar aus Grundmenge und Topologie bezeichnet einen topologischen Raum.', 'definition', 'literature', 74, NULL, 'tau ist eine Topologie auf X.', 'verified', 10),
(101, '3.101', 32, 'Offene Menge', 'U\\text{ offen}\\quad\\Longleftrightarrow\\quad U\\in\\tau', 'U\\text{ offen}\\quad\\Longleftrightarrow\\quad U\\in\\tau', 'Eine Teilmenge ist genau dann offen, wenn sie zur festgelegten Topologie gehört.', 'definition', 'literature', 74, NULL, '(X,tau) ist ein topologischer Raum.', 'verified', 10),
(102, '3.102', 32, 'Umgebungsbedingung', 'x\\in U\\subseteq N', 'x\\in U\\subseteq N', 'Eine Umgebung N enthält eine offene Menge U, die den betrachteten Punkt x enthält.', 'definition', 'literature', 74, NULL, 'U ist offen und x liegt in X.', 'verified', 10),
(103, '3.103', 32, 'Offene metrische Kugel', 'B_r(x)=\\{y\\in X\\mid d(x,y)<r\\}', 'B_r(x)=\\{y\\in X\\mid d(x,y)<r\\}', 'Eine metrische Kugel enthält alle Punkte mit Abstand kleiner als r vom Mittelpunkt x.', 'metric', 'literature', 74, NULL, '(X,d) ist ein metrischer Raum und r ist positiv.', 'verified', 10),
(104, '3.104', 32, 'Von einer Metrik induzierte Topologie', 'U\\in\\tau_d\\quad\\Longleftrightarrow\\quad\\forall x\\in U\\;\\exists r>0:B_r(x)\\subseteq U', 'U\\in\\tau_d\\quad\\Longleftrightarrow\\quad\\forall x\\in U\\;\\exists r>0:B_r(x)\\subseteq U', 'Eine Menge ist in der metrisch induzierten Topologie offen, wenn jeder ihrer Punkte eine vollständig enthaltene offene Kugel besitzt.', 'metric', 'literature', 74, NULL, '(X,d) ist ein metrischer Raum.', 'verified', 10),
(105, '3.105', 32, 'Struktureller Übergang von Metrik zu Topologie', '\\text{Metrik}\\Longrightarrow\\text{Topologie}', '\\text{Metrik}\\Longrightarrow\\text{Topologie}', 'Jede Metrik induziert eine Topologie; die Umkehrung gilt nicht allgemein.', 'schema', 'literature', 74, NULL, 'Der Pfeil bezeichnet eine strukturelle Implikation, keine Äquivalenz.', 'verified', 10),
(106, '3.106', 32, 'Lokale Basisbedingung', 'x\\in B\\subseteq U', 'x\\in B\\subseteq U', 'Für jeden Punkt einer offenen Menge existiert ein Basiselement, das den Punkt enthält und innerhalb der offenen Menge liegt.', 'definition', 'literature', 74, NULL, 'B gehört zu einer Basis der Topologie und U ist offen.', 'verified', 10),
(107, '3.107', 32, 'Erzeugung offener Mengen aus einer Basis', 'U=\\bigcup_{\\substack{B\\in\\mathcal B\\\\B\\subseteq U}}B', 'U=\\bigcup_{\\substack{B\\in\\mathcal B\\\\B\\subseteq U}}B', 'Jede offene Menge ist eine Vereinigung geeigneter Basiselemente.', 'derived', 'literature', 74, 'Folgt aus der Basisdefinition.', 'mathcal B ist eine Basis der Topologie und U ist offen.', 'verified', 10),
(108, '3.108', 32, 'Abgeschlossene Menge', 'A\\text{ abgeschlossen}\\quad\\Longleftrightarrow\\quad X\\setminus A\\in\\tau', 'A\\text{ abgeschlossen}\\quad\\Longleftrightarrow\\quad X\\setminus A\\in\\tau', 'Eine Menge ist abgeschlossen, wenn ihr Komplement offen ist.', 'definition', 'literature', 74, NULL, 'A ist eine Teilmenge von X.', 'verified', 10),
(109, '3.109', 32, 'Inneres einer Menge', 'A^\\circ=\\bigcup\\{U\\in\\tau\\mid U\\subseteq A\\}', 'A^\\circ=\\bigcup\\{U\\in\\tau\\mid U\\subseteq A\\}', 'Das Innere ist die Vereinigung aller offenen Teilmengen von A.', 'definition', 'literature', 74, NULL, 'A ist eine Teilmenge des topologischen Raums X.', 'verified', 10),
(110, '3.110', 32, 'Abschluss einer Menge', '\\overline A=\\bigcap\\{F\\subseteq X\\mid A\\subseteq F,\\;F\\text{ abgeschlossen}\\}', '\\overline A=\\bigcap\\{F\\subseteq X\\mid A\\subseteq F,\\;F\\text{ abgeschlossen}\\}', 'Der Abschluss ist der Durchschnitt aller abgeschlossenen Obermengen von A.', 'definition', 'literature', 74, NULL, 'A ist eine Teilmenge des topologischen Raums X.', 'verified', 10),
(111, '3.111', 32, 'Umgebungscharakterisierung des Abschlusses', 'x\\in\\overline A\\quad\\Longleftrightarrow\\quad\\forall N\\in\\mathcal N(x):N\\cap A\\neq\\varnothing', 'x\\in\\overline A\\quad\\Longleftrightarrow\\quad\\forall N\\in\\mathcal N(x):N\\cap A\\neq\\varnothing', 'Ein Punkt liegt genau dann im Abschluss von A, wenn jede seiner Umgebungen A trifft.', 'theorem', 'literature', 74, 'Standardcharakterisierung des Abschlusses durch Umgebungen.', 'N(x) bezeichnet die Umgebungsfamilie von x.', 'verified', 10),
(112, '3.112', 32, 'Rand einer Menge', '\\partial A=\\overline A\\setminus A^\\circ', '\\partial A=\\overline A\\setminus A^\\circ', 'Der Rand ist der Abschluss einer Menge ohne ihr Inneres.', 'definition', 'literature', 74, NULL, 'A ist eine Teilmenge des topologischen Raums X.', 'verified', 10),
(113, '3.113', 32, 'Alternative Randdarstellung', '\\partial A=\\overline A\\cap\\overline{X\\setminus A}', '\\partial A=\\overline A\\cap\\overline{X\\setminus A}', 'Der Rand ist der Durchschnitt des Abschlusses von A mit dem Abschluss seines Komplements.', 'derived', 'literature', 74, 'Äquivalente Charakterisierung des topologischen Randes.', 'A ist eine Teilmenge des topologischen Raums X.', 'verified', 10),
(114, '3.114', 32, 'Topologische Stetigkeit über Urbilder', 'V\\in\\tau_Y\\quad\\Longrightarrow\\quad f^{-1}(V)\\in\\tau_X', 'V\\in\\tau_Y\\quad\\Longrightarrow\\quad f^{-1}(V)\\in\\tau_X', 'Eine Abbildung ist stetig, wenn Urbilder offener Mengen offen sind.', 'definition', 'literature', 74, NULL, 'f:X nach Y ist eine Abbildung zwischen topologischen Räumen.', 'verified', 10),
(115, '3.115', 32, 'Lokale Umgebungsform der Stetigkeit', '\\forall N\\in\\mathcal N(f(x))\\;\\exists M\\in\\mathcal N(x):f(M)\\subseteq N', '\\forall N\\in\\mathcal N(f(x))\\;\\exists M\\in\\mathcal N(x):f(M)\\subseteq N', 'Stetigkeit in einem Punkt kann durch die Verträglichkeit von Umgebungen im Ausgangs- und Zielraum beschrieben werden.', 'theorem', 'literature', 74, 'Lokale Charakterisierung topologischer Stetigkeit.', 'f ist in x stetig.', 'verified', 10),
(116, '3.116', 32, 'Metrische Epsilon-Delta-Stetigkeit', '\\forall\\varepsilon>0\\;\\exists\\delta>0:d_X(x,y)<\\delta\\Longrightarrow d_Y(f(x),f(y))<\\varepsilon', '\\forall\\varepsilon>0\\;\\exists\\delta>0:d_X(x,y)<\\delta\\Longrightarrow d_Y(f(x),f(y))<\\varepsilon', 'In metrischen Räumen ist topologische Stetigkeit mit der Epsilon-Delta-Bedingung verträglich beziehungsweise äquivalent.', 'theorem', 'literature', 74, 'Spezialisierung der topologischen Stetigkeit auf metrisch induzierte Topologien.', 'X und Y sind metrische Räume.', 'verified', 10),
(117, '3.117', 32, 'Verkettung stetiger Abbildungen', 'g\\circ f:X\\longrightarrow Z', 'g\\circ f:X\\longrightarrow Z', 'Die Verkettung zweier passend definierter stetiger Abbildungen ist wieder stetig.', 'theorem', 'literature', 74, 'Satz 3.2.7.', 'f:X nach Y und g:Y nach Z sind stetig.', 'verified', 10),
(118, '3.118', 32, 'Urbild unter einer Verkettung', '(g\\circ f)^{-1}(U)=f^{-1}\\left(g^{-1}(U)\\right)', '(g\\circ f)^{-1}(U)=f^{-1}\\left(g^{-1}(U)\\right)', 'Das Urbild einer Menge unter einer Funktionsverkettung ist das iterierte Urbild.', 'derived', 'literature', 74, 'Grundlage für den Beweis der Stetigkeit von Verkettungen.', 'f:X nach Y und g:Y nach Z sind Abbildungen; U ist Teilmenge von Z.', 'verified', 10),
(119, '3.119', 32, 'Nicht allgemein gültige Umkehrung Topologie zu Metrik', '\\text{Topologie}\\Longrightarrow\\text{Metrik}', '\\text{Topologie}\\Longrightarrow\\text{Metrik}', 'Die dargestellte Implikation ist im Allgemeinen falsch: Nicht jede Topologie ist metrisierbar.', 'schema', 'literature', 74, NULL, 'Die Formel dokumentiert ausdrücklich eine nicht allgemein gültige Implikation.', 'verified', 10),
(120, '3.120', 33, 'Bedingungen einer Trennung', 'U\\neq\\varnothing,\\qquad V\\neq\\varnothing,\\qquad U\\cap V=\\varnothing,\\qquad U\\cup V=X', 'U\\neq\\varnothing,\\qquad V\\neq\\varnothing,\\qquad U\\cap V=\\varnothing,\\qquad U\\cup V=X', 'Eine Trennung zerlegt X in zwei nichtleere, disjunkte offene Teilmengen.', 'definition', 'literature', 74, NULL, 'U und V sind offene Teilmengen von X.', 'verified', 11),
(121, '3.121', 33, 'Zerlegung eines unzusammenhängenden Raumes', 'X=U\\cup V,\\qquad U\\cap V=\\varnothing', 'X=U\\cup V,\\qquad U\\cap V=\\varnothing', 'Die Existenz einer Trennung durch nichtleere offene Mengen kennzeichnet einen unzusammenhängenden Raum.', 'definition', 'literature', 74, NULL, 'U und V sind nichtleer und offen.', 'verified', 11),
(122, '3.122', 33, 'Charakterisierung des Zusammenhangs durch abgeschlossene offene Mengen', 'A\\subseteq X,\\quad A\\text{ offen und abgeschlossen}\\quad\\Longrightarrow\\quad A=\\varnothing\\ \\text{oder}\\ A=X', 'A\\subseteq X,\\quad A\\text{ offen und abgeschlossen}\\quad\\Longrightarrow\\quad A=\\varnothing\\ \\text{oder}\\ A=X', 'In einem zusammenhängenden Raum sind die einzigen zugleich offenen und abgeschlossenen Teilmengen die leere Menge und der gesamte Raum.', 'theorem', 'literature', 74, 'Äquivalente Charakterisierung des Zusammenhangs.', 'X ist zusammenhängend.', 'verified', 11),
(123, '3.123', 33, 'Stetige Abbildung eines zusammenhängenden Raumes', 'f:X\\longrightarrow Y', 'f:X\\longrightarrow Y', 'Betrachtet wird eine stetige Abbildung eines zusammenhängenden Ausgangsraumes in einen topologischen Zielraum.', 'schema', 'literature', 74, NULL, 'X ist zusammenhängend und f ist stetig.', 'verified', 11);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(124, '3.124', 33, 'Bild eines zusammenhängenden Raumes', 'f(X)', 'f(X)', 'Das Bild eines zusammenhängenden Raumes unter einer stetigen Abbildung ist zusammenhängend.', 'theorem', 'literature', 74, 'Satz 3.2.9.', 'X ist zusammenhängend und f ist stetig.', 'verified', 11),
(125, '3.125', 33, 'Weg als stetige Parametrisierung', '\\gamma:[0,1]\\longrightarrow X', '\\gamma:[0,1]\\longrightarrow X', 'Ein Weg ist eine stetige Abbildung des Einheitsintervalls in den topologischen Raum.', 'definition', 'literature', 74, NULL, 'X ist ein topologischer Raum.', 'verified', 11),
(126, '3.126', 33, 'Randbedingungen eines Weges', '\\gamma(0)=x,\\qquad\\gamma(1)=y', '\\gamma(0)=x,\\qquad\\gamma(1)=y', 'Die Endpunkte des Weges sind die zu verbindenden Punkte x und y.', 'definition', 'literature', 74, NULL, 'gamma ist ein Weg von x nach y.', 'verified', 11),
(127, '3.127', 33, 'Wegzusammenhang', '\\forall x,y\\in X\\;\\exists\\gamma:[0,1]\\to X:\\gamma(0)=x\\land\\gamma(1)=y', '\\forall x,y\\in X\\;\\exists\\gamma:[0,1]\\to X:\\gamma(0)=x\\land\\gamma(1)=y', 'In einem wegzusammenhängenden Raum können je zwei Punkte durch einen stetigen Weg verbunden werden.', 'definition', 'literature', 74, NULL, 'X ist ein topologischer Raum.', 'verified', 11),
(128, '3.128', 33, 'Wegzusammenhang impliziert Zusammenhang', 'X\\text{ wegzusammenhängend}\\quad\\Longrightarrow\\quad X\\text{ zusammenhängend}', 'X\\text{ wegzusammenhängend}\\quad\\Longrightarrow\\quad X\\text{ zusammenhängend}', 'Wegzusammenhang ist eine hinreichende Bedingung für Zusammenhang; die Umkehrung gilt nicht allgemein.', 'theorem', 'literature', 74, 'Satz 3.2.10.', 'X ist ein topologischer Raum.', 'verified', 11),
(129, '3.129', 33, 'Disjunktheit verschiedener Zusammenhangskomponenten', 'C_i=C_j\\quad\\text{oder}\\quad C_i\\cap C_j=\\varnothing', 'C_i=C_j\\quad\\text{oder}\\quad C_i\\cap C_j=\\varnothing', 'Zwei Zusammenhangskomponenten stimmen entweder überein oder sind disjunkt.', 'theorem', 'literature', 74, 'Folgt aus der Maximalität von Zusammenhangskomponenten.', 'C_i und C_j sind Zusammenhangskomponenten von X.', 'verified', 11),
(130, '3.130', 33, 'Familie einer offenen Überdeckung', '\\mathcal U=\\{U_i\\}_{i\\in I}', '\\mathcal U=\\{U_i\\}_{i\\in I}', 'Eine offene Überdeckung wird als Familie offener Teilmengen notiert.', 'definition', 'literature', 74, NULL, 'Alle U_i sind offen in X.', 'verified', 11),
(131, '3.131', 33, 'Überdeckungsbedingung', 'X\\subseteq\\bigcup_{i\\in I}U_i', 'X\\subseteq\\bigcup_{i\\in I}U_i', 'Die Vereinigung der offenen Mengen überdeckt den gesamten Raum X.', 'definition', 'literature', 74, NULL, 'Die U_i bilden eine offene Überdeckung.', 'verified', 11),
(132, '3.132', 33, 'Beliebige offene Überdeckung eines kompakten Raumes', 'X\\subseteq\\bigcup_{i\\in I}U_i', 'X\\subseteq\\bigcup_{i\\in I}U_i', 'Ausgangspunkt der Kompaktheitsbedingung ist eine beliebige offene Überdeckung.', 'definition', 'literature', 74, NULL, 'X ist kompakt und die U_i bilden eine offene Überdeckung.', 'verified', 11),
(133, '3.133', 33, 'Endliche Teilüberdeckung', 'X\\subseteq U_{i_1}\\cup\\cdots\\cup U_{i_n}', 'X\\subseteq U_{i_1}\\cup\\cdots\\cup U_{i_n}', 'Kompaktheit garantiert, dass endlich viele Mengen der ursprünglichen offenen Überdeckung weiterhin X überdecken.', 'definition', 'literature', 74, NULL, 'X ist kompakt.', 'verified', 11),
(134, '3.134', 33, 'Abgeschlossene Teilmenge eines kompakten Raumes', 'X\\text{ kompakt}\\land A\\subseteq X\\text{ abgeschlossen}\\quad\\Longrightarrow\\quad A\\text{ kompakt}', 'X\\text{ kompakt}\\land A\\subseteq X\\text{ abgeschlossen}\\quad\\Longrightarrow\\quad A\\text{ kompakt}', 'Abgeschlossene Teilmengen kompakter Räume sind kompakt.', 'theorem', 'literature', 74, 'Satz 3.2.11.', 'X ist kompakt; A ist abgeschlossen in X.', 'verified', 11),
(135, '3.135', 33, 'Stetige Abbildung eines kompakten Raumes', 'f:X\\longrightarrow Y', 'f:X\\longrightarrow Y', 'Betrachtet wird eine stetige Abbildung eines kompakten Ausgangsraumes.', 'schema', 'literature', 74, NULL, 'X ist kompakt und f ist stetig.', 'verified', 11),
(136, '3.136', 33, 'Kompaktes Bild', 'f(X)', 'f(X)', 'Das stetige Bild eines kompakten Raumes ist kompakt.', 'theorem', 'literature', 74, 'Satz 3.2.12.', 'X ist kompakt und f ist stetig.', 'verified', 11),
(137, '3.137', 33, 'Kompaktheit', 'X\\text{ kompakt}', 'X\\text{ kompakt}', 'Die Aussage kennzeichnet die topologische Kompaktheit des betrachteten Raumes.', 'schema', 'literature', 74, NULL, 'X ist ein topologischer Raum.', 'verified', 11),
(138, '3.138', 33, 'Endlichkeit der Mächtigkeit', '|X|<\\infty', '|X|<\\infty', 'Endliche Mächtigkeit ist nicht aus topologischer Kompaktheit ableitbar.', 'schema', 'literature', 74, NULL, 'Die Formel wird im Text ausdrücklich als nicht aus Gleichung 3.137 folgende Aussage verwendet.', 'verified', 11),
(139, '3.139', 33, 'Kompaktheit ist nicht allgemein Beschränktheit', '\\text{Kompaktheit}\\not\\equiv\\text{Beschränktheit}', '\\text{Kompaktheit}\\not\\equiv\\text{Beschränktheit}', 'Kompaktheit und Beschränktheit sind auf der allgemeinen topologischen Ebene keine identischen Begriffe.', 'schema', 'literature', 74, NULL, 'Beschränktheit setzt zusätzliche metrische oder vergleichbare Struktur voraus.', 'verified', 11),
(140, '3.140', 34, 'Folge als Abbildung', 'x:\\mathbb N\\longrightarrow X', 'x:\\mathbb N\\longrightarrow X', 'Eine Folge ist eine Abbildung der natürlichen Zahlen in den betrachteten Zustandsraum.', 'definition', 'literature', 74, NULL, 'X ist eine Menge.', 'verified', 12),
(141, '3.141', 34, 'Folgennotation', '(x_n)_{n\\in\\mathbb N}', '(x_n)_{n\\in\\mathbb N}', 'Übliche Notation einer Folge mit natürlichen Indizes.', 'schema', 'literature', 74, NULL, 'x_n bezeichnet den Wert der Folge am Index n.', 'verified', 12),
(142, '3.142', 34, 'Topologische Folgenkonvergenz', '\\forall U\\in\\mathcal N(x)\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N:\\;x_n\\in U', '\\forall U\\in\\mathcal N(x)\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N:\\;x_n\\in U', 'Eine Folge konvergiert topologisch gegen x, wenn jede Umgebung von x schließlich alle weiteren Folgenglieder enthält.', 'definition', 'literature', 74, NULL, 'X ist ein topologischer Raum.', 'verified', 12),
(143, '3.143', 34, 'Grenzwertnotation', 'x_n\\longrightarrow x\\qquad(n\\to\\infty)', 'x_n\\longrightarrow x\\qquad(n\\to\\infty)', 'Notation für die Konvergenz einer Folge gegen x.', 'schema', 'literature', 74, NULL, 'Die Folge x_n konvergiert gegen x.', 'verified', 12),
(144, '3.144', 34, 'Metrische Folgenkonvergenz', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N:\\;d(x_n,x)<\\varepsilon', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N:\\;d(x_n,x)<\\varepsilon', 'Metrische Epsilon-Form der Folgenkonvergenz.', 'metric', 'literature', 74, NULL, '(X,d) ist ein metrischer Raum.', 'verified', 12),
(145, '3.145', 34, 'Konvergenz in einem normierten Raum', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N:\\;\\|x_n-x\\|<\\varepsilon', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N:\\;\\|x_n-x\\|<\\varepsilon', 'Normierte Form der Folgenkonvergenz.', 'metric', 'literature', 73, NULL, 'x_n und x liegen in einem normierten Vektorraum.', 'verified', 12),
(146, '3.146', 34, 'Normkonvergenz gegen null der Differenz', '\\|x_n-x\\|\\longrightarrow0', '\\|x_n-x\\|\\longrightarrow0', 'Äquivalente Kurzform der Normkonvergenz von x_n gegen x.', 'derived', 'literature', 73, NULL, 'Die verwendete Metrik ist norminduziert.', 'verified', 12),
(147, '3.147', 34, 'Eindeutigkeit des metrischen Grenzwertes', 'x_n\\to x\\land x_n\\to y\\quad\\Longrightarrow\\quad x=y', 'x_n\\to x\\land x_n\\to y\\quad\\Longrightarrow\\quad x=y', 'In metrischen Räumen besitzt eine konvergente Folge höchstens einen Grenzwert.', 'theorem', 'literature', 74, 'Folgt aus Definitheit und Dreiecksungleichung der Metrik.', 'Die Folge liegt in einem metrischen Raum.', 'verified', 12),
(148, '3.148', 34, 'Abgeschlossene Mengen enthalten Folgen-Grenzwerte', 'x_n\\in A\\ \\forall n,\\qquad x_n\\to x\\quad\\Longrightarrow\\quad x\\in A', 'x_n\\in A\\ \\forall n,\\qquad x_n\\to x\\quad\\Longrightarrow\\quad x\\in A', 'In metrischen Räumen enthält eine abgeschlossene Menge die Grenzwerte konvergenter Folgen ihrer Elemente.', 'theorem', 'literature', 74, NULL, 'A ist abgeschlossen in einem metrischen Raum.', 'verified', 12),
(149, '3.149', 34, 'Cauchy-Bedingung in einem metrischen Raum', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall m,n\\geq N:\\;d(x_m,x_n)<\\varepsilon', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall m,n\\geq N:\\;d(x_m,x_n)<\\varepsilon', 'Hinreichend späte Glieder einer Cauchy-Folge liegen beliebig nahe beieinander.', 'definition', 'literature', 74, NULL, '(X,d) ist ein metrischer Raum.', 'verified', 12),
(150, '3.150', 34, 'Cauchy-Bedingung in einem normierten Raum', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall m,n\\geq N:\\;\\|x_m-x_n\\|<\\varepsilon', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall m,n\\geq N:\\;\\|x_m-x_n\\|<\\varepsilon', 'Normierte Form der Cauchy-Bedingung.', 'metric', 'literature', 73, NULL, 'Die Metrik wird durch die Norm induziert.', 'verified', 12),
(151, '3.151', 34, 'Konvergenz impliziert Cauchy-Eigenschaft', 'x_n\\to x\\quad\\Longrightarrow\\quad(x_n)\\text{ ist eine Cauchy-Folge}', 'x_n\\to x\\quad\\Longrightarrow\\quad(x_n)\\text{ ist eine Cauchy-Folge}', 'Jede konvergente Folge in einem metrischen Raum erfüllt die Cauchy-Bedingung.', 'theorem', 'literature', 74, 'Folgt aus der Dreiecksungleichung.', 'Die Folge liegt in einem metrischen Raum.', 'verified', 12),
(152, '3.152', 34, 'Vollständigkeitsbedingung', '(x_n)\\text{ Cauchy in }X\\quad\\Longrightarrow\\quad\\exists x\\in X:\\;x_n\\to x', '(x_n)\\text{ Cauchy in }X\\quad\\Longrightarrow\\quad\\exists x\\in X:\\;x_n\\to x', 'In einem vollständigen metrischen Raum konvergiert jede Cauchy-Folge gegen ein Element des Raums.', 'definition', 'literature', 74, NULL, '(X,d) ist ein metrischer Raum.', 'verified', 12),
(153, '3.153', 34, 'Vollständiger metrischer Raum', '(X,d)\\text{ vollständig}', '(X,d)\\text{ vollständig}', 'Vollständigkeit ist eine Eigenschaft des metrischen Raums einschließlich seiner Metrik.', 'schema', 'literature', 74, NULL, 'd ist die betrachtete Metrik auf X.', 'verified', 12),
(154, '3.154', 34, 'Vollständigkeit abgeschlossener Teilräume', 'X\\text{ vollständig}\\land A\\subseteq X\\text{ abgeschlossen}\\quad\\Longrightarrow\\quad A\\text{ vollständig}', 'X\\text{ vollständig}\\land A\\subseteq X\\text{ abgeschlossen}\\quad\\Longrightarrow\\quad A\\text{ vollständig}', 'Abgeschlossene Teilräume vollständiger metrischer Räume sind vollständig.', 'theorem', 'literature', 74, 'Eine Cauchy-Folge in A konvergiert in X und ihr Grenzwert liegt wegen der Abgeschlossenheit in A.', 'X ist vollständig und A abgeschlossen.', 'verified', 12),
(155, '3.155', 34, 'Normierter Raum als Banachraumkandidat', '(V,\\|\\cdot\\|)', '(V,\\|\\cdot\\|)', 'Ausgangspunkt für die Definition eines Banachraums ist ein normierter Vektorraum.', 'schema', 'literature', 73, NULL, 'V ist ein normierter Vektorraum.', 'verified', 12),
(156, '3.156', 34, 'Banachraum-Vollständigkeit', '(x_n)\\text{ Cauchy bezüglich }\\|\\cdot\\|\\quad\\Longrightarrow\\quad\\exists x\\in V:\\;\\|x_n-x\\|\\to0', '(x_n)\\text{ Cauchy bezüglich }\\|\\cdot\\|\\quad\\Longrightarrow\\quad\\exists x\\in V:\\;\\|x_n-x\\|\\to0', 'In einem Banachraum konvergiert jede normbezogene Cauchy-Folge in der Norm gegen ein Element des Raums.', 'definition', 'literature', 73, NULL, 'V ist vollständig bezüglich der norminduzierten Metrik.', 'verified', 12),
(157, '3.157', 34, 'Induzierte Hilbertraumnorm', '\\|x\\|=\\sqrt{\\langle x,x\\rangle}', '\\|x\\|=\\sqrt{\\langle x,x\\rangle}', 'Das Skalarprodukt induziert die Norm des Hilbertraums.', 'definition', 'literature', 73, NULL, 'H ist ein Skalarproduktraum.', 'verified', 12),
(158, '3.158', 34, 'Hilbertraum-Vollständigkeit', '(x_n)\\text{ Cauchy}\\quad\\Longrightarrow\\quad\\exists x\\in H:\\;\\|x_n-x\\|\\to0', '(x_n)\\text{ Cauchy}\\quad\\Longrightarrow\\quad\\exists x\\in H:\\;\\|x_n-x\\|\\to0', 'Ein Hilbertraum ist bezüglich seiner durch das Skalarprodukt induzierten Norm vollständig.', 'definition', 'literature', 73, NULL, 'H ist ein Hilbertraum.', 'verified', 12),
(159, '3.159', 34, 'Hilbertraum impliziert Banachraum', 'H\\text{ Hilbertraum}\\quad\\Longrightarrow\\quad(H,\\|\\cdot\\|)\\text{ Banachraum}', 'H\\text{ Hilbertraum}\\quad\\Longrightarrow\\quad(H,\\|\\cdot\\|)\\text{ Banachraum}', 'Jeder Hilbertraum ist mit seiner induzierten Norm ein Banachraum.', 'theorem', 'literature', 73, NULL, 'Die Norm ist durch das Skalarprodukt induziert.', 'verified', 12),
(160, '3.160', 34, 'Streng wachsende Teilfolgenindizes', 'n_1<n_2<n_3<\\cdots', 'n_1<n_2<n_3<\\cdots', 'Die Indizes einer Teilfolge bilden eine streng wachsende Folge natürlicher Zahlen.', 'definition', 'literature', 74, NULL, 'n_k sind natürliche Zahlen.', 'verified', 12),
(161, '3.161', 34, 'Teilfolgennotation', '(x_{n_k})_{k\\in\\mathbb N}', '(x_{n_k})_{k\\in\\mathbb N}', 'Notation einer aus der Ausgangsfolge ausgewählten Teilfolge.', 'definition', 'literature', 74, NULL, 'n_k ist streng wachsend.', 'verified', 12),
(162, '3.162', 34, 'Konvergente Teilfolge in kompakten metrischen Räumen', 'X\\text{ kompakt}\\quad\\Longrightarrow\\quad\\forall(x_n)\\subseteq X\\;\\exists(x_{n_k}),\\,x\\in X:\\;x_{n_k}\\to x', 'X\\text{ kompakt}\\quad\\Longrightarrow\\quad\\forall(x_n)\\subseteq X\\;\\exists(x_{n_k}),\\,x\\in X:\\;x_{n_k}\\to x', 'In einem kompakten metrischen Raum besitzt jede Folge eine konvergente Teilfolge mit Grenzwert im Raum.', 'theorem', 'literature', 74, NULL, 'X ist kompakt und metrisch.', 'verified', 12),
(163, '3.163', 34, 'Kompaktheit impliziert Vollständigkeit', 'X\\text{ kompakt und metrisch}\\quad\\Longrightarrow\\quad X\\text{ vollständig}', 'X\\text{ kompakt und metrisch}\\quad\\Longrightarrow\\quad X\\text{ vollständig}', 'Jeder kompakte metrische Raum ist vollständig.', 'theorem', 'literature', 74, NULL, 'X ist ein kompakter metrischer Raum.', 'verified', 12),
(164, '3.164', 34, 'Vollständigkeit und Kompaktheit sind nicht äquivalent', '\\text{Vollständigkeit}\\not\\equiv\\text{Kompaktheit}', '\\text{Vollständigkeit}\\not\\equiv\\text{Kompaktheit}', 'Vollständigkeit und Kompaktheit sind im Allgemeinen verschiedene Eigenschaften.', 'schema', 'literature', 74, NULL, 'Die Aussage dokumentiert ausdrücklich fehlende allgemeine Äquivalenz.', 'verified', 12),
(165, '3.165', 34, 'Abstrakte Grenzwertnotation', 'x_n\\to x', 'x_n\\to x', 'Die Konvergenznotation allein enthält keine zeitliche Interpretation des Folgenindex.', 'schema', 'literature', 74, NULL, 'Der Folgenindex besitzt zunächst nur mathematische Ordnungsfunktion.', 'verified', 12),
(166, '3.166', 34, 'Hierarchie vollständiger linearer Räume', '\\text{Hilbertraum}\\Longrightarrow\\text{Banachraum}\\Longrightarrow\\text{vollständiger metrischer Raum}', '\\text{Hilbertraum}\\Longrightarrow\\text{Banachraum}\\Longrightarrow\\text{vollständiger metrischer Raum}', 'Ein Hilbertraum ist ein spezieller Banachraum; jeder Banachraum ist bezüglich seiner norminduzierten Metrik vollständig.', 'schema', 'literature', 73, NULL, 'Die Umkehrungen gelten nicht allgemein.', 'verified', 12),
(167, '3.167', 35, 'Allgemeiner Funktionenraum', '\\mathcal F(X,Y)=\\{f\\mid f:X\\to Y\\}', '\\mathcal F(X,Y)=\\{f\\mid f:X\\to Y\\}', 'Der Funktionenraum enthält alle Abbildungen von X nach Y.', 'definition', 'literature', 74, NULL, 'X und Y sind Mengen.', 'verified', 13),
(168, '3.168', 35, 'Punktweise Linearkombination von Funktionen', '(\\alpha f+\\beta g)(x)=\\alpha f(x)+\\beta g(x)', '(\\alpha f+\\beta g)(x)=\\alpha f(x)+\\beta g(x)', 'Addition und Skalarmultiplikation im Funktionenraum werden punktweise definiert.', 'definition', 'literature', 73, NULL, 'V ist ein Vektorraum; f,g:X nach V; alpha,beta liegen in K.', 'verified', 13),
(169, '3.169', 35, 'Abgeschlossenheit unter Linearkombinationen', 'f,g\\in\\mathcal F(X,V),\\quad\\alpha,\\beta\\in\\mathbb K\\quad\\Longrightarrow\\quad\\alpha f+\\beta g\\in\\mathcal F(X,V)', 'f,g\\in\\mathcal F(X,V),\\quad\\alpha,\\beta\\in\\mathbb K\\quad\\Longrightarrow\\quad\\alpha f+\\beta g\\in\\mathcal F(X,V)', 'Der Funktionenraum nach einem Vektorraum ist unter punktweisen Linearkombinationen abgeschlossen.', 'theorem', 'literature', 73, NULL, 'V ist ein Vektorraum über K.', 'verified', 13),
(170, '3.170', 35, 'Nullfunktion', '0_{\\mathcal F}(x)=0_V\\qquad\\text{für alle }x\\in X', '0_{\\mathcal F}(x)=0_V\\qquad\\text{für alle }x\\in X', 'Die Nullfunktion ist der Nullvektor des linearen Funktionenraums.', 'definition', 'literature', 73, NULL, 'V ist der Zielvektorraum.', 'verified', 13),
(171, '3.171', 35, 'Raum stetiger Funktionen', 'C(X,Y)=\\{f:X\\to Y\\mid f\\text{ stetig}\\}', 'C(X,Y)=\\{f:X\\to Y\\mid f\\text{ stetig}\\}', 'C(X,Y) enthält genau die stetigen Abbildungen von X nach Y.', 'definition', 'literature', 74, NULL, 'X und Y sind topologische Räume.', 'verified', 13),
(172, '3.172', 35, 'Beschränktheitsbedingung einer Funktion', '|f(x)|\\leq M\\qquad\\text{für alle }x\\in X', '|f(x)|\\leq M\\qquad\\text{für alle }x\\in X', 'Eine beschränkte skalare Funktion besitzt eine einheitliche endliche obere Schranke ihres Betrags.', 'definition', 'literature', 73, NULL, 'M ist nichtnegativ und endlich.', 'verified', 13),
(173, '3.173', 35, 'Raum beschränkter Funktionen', 'B(X,\\mathbb K)=\\{f:X\\to\\mathbb K\\mid f\\text{ beschränkt}\\}', 'B(X,\\mathbb K)=\\{f:X\\to\\mathbb K\\mid f\\text{ beschränkt}\\}', 'B(X,K) enthält alle beschränkten skalarwertigen Funktionen auf X.', 'definition', 'literature', 73, NULL, 'K ist R oder C.', 'verified', 13),
(174, '3.174', 35, 'Supremumsnorm', '\\|f\\|_\\infty=\\sup_{x\\in X}|f(x)|', '\\|f\\|_\\infty=\\sup_{x\\in X}|f(x)|', 'Die Supremumsnorm ist die kleinste obere Schranke des Funktionsbetrags über X.', 'definition', 'literature', 73, NULL, 'f ist beschränkt.', 'verified', 13),
(175, '3.175', 35, 'Supremumsabstand zweier Funktionen', 'd_\\infty(f,g)=\\|f-g\\|_\\infty=\\sup_{x\\in X}|f(x)-g(x)|', 'd_\\infty(f,g)=\\|f-g\\|_\\infty=\\sup_{x\\in X}|f(x)-g(x)|', 'Die Supremumsnorm der Differenz definiert einen globalen Abstand zweier Funktionen.', 'metric', 'literature', 73, NULL, 'f und g sind beschränkte skalarwertige Funktionen.', 'verified', 13),
(176, '3.176', 35, 'Banachraum beschränkter Funktionen', '\\bigl(B(X,\\mathbb K),\\|\\cdot\\|_\\infty\\bigr)', '\\bigl(B(X,\\mathbb K),\\|\\cdot\\|_\\infty\\bigr)', 'Der Raum beschränkter skalarwertiger Funktionen wird mit der Supremumsnorm betrachtet; Satz 3.2.20 stellt seine Vollständigkeit fest.', 'schema', 'literature', 73, NULL, 'K ist R oder C.', 'verified', 13),
(177, '3.177', 35, 'Beschränkte stetige Funktionen', 'C_b(X,\\mathbb K)=C(X,\\mathbb K)\\cap B(X,\\mathbb K)', 'C_b(X,\\mathbb K)=C(X,\\mathbb K)\\cap B(X,\\mathbb K)', 'C_b ist der Raum der zugleich stetigen und beschränkten skalaren Funktionen.', 'definition', 'literature', 73, NULL, 'X ist topologischer Raum; K ist R oder C.', 'verified', 13),
(178, '3.178', 35, 'Stetigkeit auf kompaktem Definitionsraum impliziert Beschränktheit', 'X\\text{ kompakt}\\quad\\Longrightarrow\\quad C_b(X,\\mathbb K)=C(X,\\mathbb K)', 'X\\text{ kompakt}\\quad\\Longrightarrow\\quad C_b(X,\\mathbb K)=C(X,\\mathbb K)', 'Auf kompaktem X sind stetige skalare Funktionen beschränkt.', 'theorem', 'literature', 74, NULL, 'X ist kompakt; K ist R oder C.', 'verified', 13),
(179, '3.179', 35, 'Punktweise Konvergenz', '\\forall x\\in X:\\qquad f_n(x)\\longrightarrow f(x)', '\\forall x\\in X:\\qquad f_n(x)\\longrightarrow f(x)', 'Punktweise Konvergenz wird für jedes feste Argument separat geprüft.', 'definition', 'literature', 74, NULL, 'f_n und f besitzen denselben Definitionsbereich.', 'verified', 13),
(180, '3.180', 35, 'Epsilon-Form punktweiser Konvergenz', '\\forall x\\in X\\;\\forall\\varepsilon>0\\;\\exists N=N(x,\\varepsilon)\\;\\forall n\\geq N:\\;|f_n(x)-f(x)|<\\varepsilon', '\\forall x\\in X\\;\\forall\\varepsilon>0\\;\\exists N=N(x,\\varepsilon)\\;\\forall n\\geq N:\\;|f_n(x)-f(x)|<\\varepsilon', 'Bei punktweiser Konvergenz darf der benötigte Index vom Argument x abhängen.', 'definition', 'literature', 74, NULL, 'Die Funktionen sind skalarwertig.', 'verified', 13),
(181, '3.181', 35, 'Gleichmäßige Konvergenz', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N\\;\\forall x\\in X:\\;|f_n(x)-f(x)|<\\varepsilon', '\\forall\\varepsilon>0\\;\\exists N\\in\\mathbb N\\;\\forall n\\geq N\\;\\forall x\\in X:\\;|f_n(x)-f(x)|<\\varepsilon', 'Bei gleichmäßiger Konvergenz gilt ein gemeinsamer Index gleichzeitig für alle Argumente.', 'definition', 'literature', 74, NULL, 'Die Funktionen sind skalarwertig.', 'verified', 13),
(182, '3.182', 35, 'Gleichmäßige Konvergenz impliziert punktweise Konvergenz', 'f_n\\longrightarrow f\\text{ gleichmäßig}\\quad\\Longrightarrow\\quad f_n\\longrightarrow f\\text{ punktweise}', 'f_n\\longrightarrow f\\text{ gleichmäßig}\\quad\\Longrightarrow\\quad f_n\\longrightarrow f\\text{ punktweise}', 'Gleichmäßige Konvergenz ist stärker als punktweise Konvergenz.', 'theorem', 'literature', 74, NULL, 'Die Funktionen besitzen denselben Definitionsbereich.', 'verified', 13),
(183, '3.183', 35, 'Supremumsnormkonvergenz und gleichmäßige Konvergenz', 'f_n\\longrightarrow f\\text{ gleichmäßig}\\quad\\Longleftrightarrow\\quad\\|f_n-f\\|_\\infty\\longrightarrow0', 'f_n\\longrightarrow f\\text{ gleichmäßig}\\quad\\Longleftrightarrow\\quad\\|f_n-f\\|_\\infty\\longrightarrow0', 'Gleichmäßige Konvergenz entspricht im Supremumsnormraum der Normkonvergenz.', 'theorem', 'literature', 74, NULL, 'Die Supremumsnorm ist endlich definiert.', 'verified', 13),
(184, '3.184', 35, 'Stetigkeit des gleichmäßigen Grenzwertes', '\\Bigl(\\forall n:\\;f_n\\text{ stetig}\\Bigr)\\land f_n\\to f\\text{ gleichmäßig}\\quad\\Longrightarrow\\quad f\\text{ stetig}', '\\Bigl(\\forall n:\\;f_n\\text{ stetig}\\Bigr)\\land f_n\\to f\\text{ gleichmäßig}\\quad\\Longrightarrow\\quad f\\text{ stetig}', 'Der gleichmäßige Grenzwert stetiger Funktionen ist stetig.', 'theorem', 'literature', 74, NULL, 'Alle f_n sind stetig und konvergieren gleichmäßig gegen f.', 'verified', 13),
(185, '3.185', 35, 'Banachraum stetiger Funktionen auf kompaktem X', '\\bigl(C(X,\\mathbb K),\\|\\cdot\\|_\\infty\\bigr)', '\\bigl(C(X,\\mathbb K),\\|\\cdot\\|_\\infty\\bigr)', 'Der Raum stetiger skalarer Funktionen auf kompaktem X wird mit der Supremumsnorm betrachtet; Satz 3.2.24 stellt seine Vollständigkeit fest.', 'schema', 'literature', 73, NULL, 'X ist kompakt; K ist R oder C.', 'verified', 13),
(186, '3.186', 35, 'Vektorwertige Funktion', 'f:X\\longrightarrow V', 'f:X\\longrightarrow V', 'Eine Funktion kann Werte in einem Vektorraum V annehmen.', 'schema', 'literature', 73, NULL, 'V ist ein Vektorraum.', 'verified', 13),
(187, '3.187', 35, 'Vektorwertiger Funktionenraum', '\\mathcal F(X,V)=\\{f\\mid f:X\\to V\\}', '\\mathcal F(X,V)=\\{f\\mid f:X\\to V\\}', 'Der Funktionenraum enthält vollständige vektorwertige Funktionen als Elemente.', 'definition', 'literature', 73, NULL, 'V ist ein Vektorraum.', 'verified', 13),
(188, '3.188', 35, 'Operator zwischen Funktionenräumen', 'T:\\mathcal X\\longrightarrow\\mathcal Y', 'T:\\mathcal X\\longrightarrow\\mathcal Y', 'Ein Operator kann vollständige Funktionen eines Funktionenraums auf vollständige Funktionen eines anderen Raums abbilden.', 'schema', 'literature', 73, NULL, 'mathcal X und mathcal Y sind geeignete Funktionenräume.', 'verified', 13),
(189, '3.189', 35, 'Linearität eines Operators auf Funktionenräumen', 'T(\\alpha f+\\beta g)=\\alpha T(f)+\\beta T(g)', 'T(\\alpha f+\\beta g)=\\alpha T(f)+\\beta T(g)', 'Ein linearer Operator erhält Linearkombinationen vollständiger funktionaler Zustände.', 'definition', 'literature', 73, NULL, 'T ist linear; f,g liegen im Definitionsraum von T.', 'verified', 13),
(190, '3.190', 35, 'Auswertungsfunktional', '\\operatorname{ev}_x(f)=f(x)', '\\operatorname{ev}_x(f)=f(x)', 'Das Auswertungsfunktional ordnet einer Funktion ihren Wert an der fest gewählten Stelle x zu.', 'definition', 'literature', 73, NULL, 'x ist fest gewählt.', 'verified', 13),
(191, '3.191', 35, 'Linearität des Auswertungsfunktionals', '\\operatorname{ev}_x(\\alpha f+\\beta g)=\\alpha\\operatorname{ev}_x(f)+\\beta\\operatorname{ev}_x(g)', '\\operatorname{ev}_x(\\alpha f+\\beta g)=\\alpha\\operatorname{ev}_x(f)+\\beta\\operatorname{ev}_x(g)', 'Die punktweise Auswertung ist auf einem linearen skalaren Funktionenraum linear.', 'theorem', 'literature', 73, NULL, 'Der Funktionenraum ist linear.', 'verified', 13),
(192, '3.192', 35, 'Beschränktheit des Auswertungsfunktionals', '|\\operatorname{ev}_x(f)|=|f(x)|\\leq\\|f\\|_\\infty', '|\\operatorname{ev}_x(f)|=|f(x)|\\leq\\|f\\|_\\infty', 'Der Betrag eines ausgewerteten Funktionswertes wird durch die Supremumsnorm der Funktion beschränkt.', 'theorem', 'literature', 73, NULL, 'f besitzt eine endliche Supremumsnorm.', 'verified', 13),
(193, '3.193', 35, 'Norm des Auswertungsfunktionals', '\\|\\operatorname{ev}_x\\|=1', '\\|\\operatorname{ev}_x\\|=1', 'Auf einem nichtleeren Supremumsnormraum, der die konstanten Funktionen enthält, besitzt das Auswertungsfunktional Norm eins.', 'theorem', 'literature', 73, NULL, 'Der Funktionenraum enthält konstante Funktionen.', 'verified', 13),
(194, '3.194', 35, 'Lokale Gleichheit bei global verschiedener Funktion', 'f(x_0)=g(x_0)\\quad\\text{und zugleich}\\quad f\\neq g', 'f(x_0)=g(x_0)\\quad\\text{und zugleich}\\quad f\\neq g', 'Zwei verschiedene Funktionen können an einem einzelnen Argument denselben Funktionswert besitzen.', 'schema', 'literature', 74, NULL, 'f und g sind unterschiedliche Funktionen auf demselben Definitionsbereich.', 'verified', 13),
(195, '3.195', 35, 'Lokale Funktionsabweichung', '|f(x)-g(x)|', '|f(x)-g(x)|', 'Die lokale Abweichung zweier Funktionen wird an einem einzelnen Argument betrachtet.', 'schema', 'literature', 73, NULL, 'f und g sind skalarwertig.', 'verified', 13),
(196, '3.196', 35, 'Globale Supremumsabweichung', '\\|f-g\\|_\\infty=\\sup_{x\\in X}|f(x)-g(x)|', '\\|f-g\\|_\\infty=\\sup_{x\\in X}|f(x)-g(x)|', 'Die Supremumsnorm der Differenz vergleicht vollständige Funktionen global.', 'metric', 'literature', 73, NULL, 'f-g ist beschränkt.', 'verified', 13),
(197, '3.197', 35, 'Funktionsargumente sind nicht Funktionenraumdimension', '\\text{Anzahl der Funktionsargumente}\\not\\equiv\\dim(\\mathcal X)', '\\text{Anzahl der Funktionsargumente}\\not\\equiv\\dim(\\mathcal X)', 'Die Zahl der Argumente einer Funktion ist nicht mit der Vektorraumdimension des Funktionenraums gleichzusetzen.', 'schema', 'original', NULL, NULL, 'Die Aussage ist eine begriffliche Unterscheidung mathematischer Ebenen.', 'verified', 13),
(198, '3.198', 35, 'Funktionenraumdimension ist nicht physikalische Dimension', '\\dim(\\mathcal X)\\not\\equiv\\text{physikalische Raum- oder Raumzeitdimension}', '\\dim(\\mathcal X)\\not\\equiv\\text{physikalische Raum- oder Raumzeitdimension}', 'Die mathematische Dimension eines Funktionenraums darf nicht mit physikalischer Raum- oder Raumzeitdimension gleichgesetzt werden.', 'schema', 'original', NULL, NULL, 'Methodologische Ebenentrennung; keine physikalische Identifikation wird vorausgesetzt.', 'verified', 13),
(199, '3.199', 35, 'Definitionsbereich und Funktionenraum sind verschiedene Ebenen', 'X\\neq\\mathcal F(X,Y)', 'X\\neq\\mathcal F(X,Y)', 'Der Definitionsbereich einer Funktion und der Raum vollständiger Funktionen sind mathematisch unterschiedliche Objektklassen beziehungsweise Ebenen.', 'schema', 'original', NULL, NULL, 'Die Schreibweise dokumentiert eine strukturelle Ebenentrennung, keine mengenlogische Behauptung für jeden Spezialfall.', 'verified', 13),
(200, '3.200', 35, 'Hierarchie skalarer Funktionenräume', 'C_b(X,\\mathbb K)\\subseteq B(X,\\mathbb K)\\subseteq\\mathcal F(X,\\mathbb K)', 'C_b(X,\\mathbb K)\\subseteq B(X,\\mathbb K)\\subseteq\\mathcal F(X,\\mathbb K)', 'Beschränkte stetige Funktionen bilden einen Teilraum der beschränkten Funktionen und diese einen Teilraum aller skalarwertigen Funktionen.', 'schema', 'literature', 73, NULL, 'K ist R oder C.', 'verified', 13),
(201, '3.201', 35, 'Hierarchie auf kompaktem Definitionsraum', 'C(X,\\mathbb K)=C_b(X,\\mathbb K)\\subseteq B(X,\\mathbb K)\\subseteq\\mathcal F(X,\\mathbb K)', 'C(X,\\mathbb K)=C_b(X,\\mathbb K)\\subseteq B(X,\\mathbb K)\\subseteq\\mathcal F(X,\\mathbb K)', 'Auf kompaktem X sind stetige skalare Funktionen beschränkt; dadurch fällt C mit C_b zusammen.', 'schema', 'literature', 74, NULL, 'X ist kompakt; K ist R oder C.', 'verified', 13),
(202, '3.202', 35, 'Funktionaler Zustandsraum als Teilmenge eines Funktionenraums', '\\mathcal X\\subseteq\\mathcal F(X,V)', '\\mathcal X\\subseteq\\mathcal F(X,V)', 'Ein konkreter funktionaler Zustandsraum kann als durch zusätzliche Zulässigkeitsbedingungen bestimmter Teilraum beziehungsweise Teilbereich eines allgemeinen Funktionenraums modelliert werden.', 'model', 'original', NULL, NULL, 'Welche Funktionen zu mathcal X gehören, wird durch die jeweilige spätere Theorie festgelegt.', 'verified', 13),
(203, '3.203', 36, 'Linearität eines Funktionals', '\\varphi(\\alpha x+\\beta y)=\\alpha\\varphi(x)+\\beta\\varphi(y)', '\\varphi(\\alpha x+\\beta y)=\\alpha\\varphi(x)+\\beta\\varphi(y)', 'Ein lineares Funktional erhält Linearkombinationen und bildet sie in den Skalarkörper ab.', 'definition', 'literature', 73, NULL, 'X ist Vektorraum über K; varphi:X nach K ist linear.', 'verified', 14),
(204, '3.204', 36, 'Algebraischer Dualraum', 'X^\\#=\\{\\varphi:X\\to\\mathbb K\\mid\\varphi\\text{ linear}\\}', 'X^\\#=\\{\\varphi:X\\to\\mathbb K\\mid\\varphi\\text{ linear}\\}', 'Der algebraische Dualraum enthält alle linearen Funktionale ohne zusätzliche Stetigkeitsforderung.', 'definition', 'literature', 73, NULL, 'X ist ein Vektorraum über K.', 'verified', 14),
(205, '3.205', 36, 'Stetiger Dualraum', 'X^*=\\{\\varphi:X\\to\\mathbb K\\mid\\varphi\\text{ linear und stetig}\\}', 'X^*=\\{\\varphi:X\\to\\mathbb K\\mid\\varphi\\text{ linear und stetig}\\}', 'Der stetige Dualraum enthält genau die linearen stetigen beziehungsweise beschränkten Funktionale.', 'definition', 'literature', 73, NULL, 'X ist normiert.', 'verified', 14),
(206, '3.206', 36, 'Einbettung des stetigen in den algebraischen Dualraum', 'X^*\\subseteq X^\\#', 'X^*\\subseteq X^\\#', 'Jedes stetige lineare Funktional ist insbesondere ein lineares Funktional.', 'derived', 'literature', 73, NULL, 'X ist normiert.', 'verified', 14),
(207, '3.207', 36, 'Beschränktheitsbedingung eines linearen Operators', '\\|Tx\\|_Y\\leq C\\|x\\|_X', '\\|Tx\\|_Y\\leq C\\|x\\|_X', 'Ein beschränkter linearer Operator besitzt eine globale lineare Normschranke.', 'definition', 'literature', 73, NULL, 'T:X nach Y ist linear und C ist nichtnegativ.', 'verified', 14),
(208, '3.208', 36, 'Lipschitz-Abschätzung eines beschränkten linearen Operators', '\\|Tx-Ty\\|_Y=\\|T(x-y)\\|_Y\\leq C\\|x-y\\|_X', '\\|Tx-Ty\\|_Y=\\|T(x-y)\\|_Y\\leq C\\|x-y\\|_X', 'Beschränktheit kontrolliert den Abstand der Bilder zweier Zustände.', 'derived', 'literature', 73, 'Folgt aus Linearität und der Beschränktheitsabschätzung.', 'T ist beschränkt linear.', 'verified', 14),
(209, '3.209', 36, 'Beschränktheit ist äquivalent zu Stetigkeit', 'T\\text{ beschränkt}\\quad\\Longleftrightarrow\\quad T\\text{ stetig}', 'T\\text{ beschränkt}\\quad\\Longleftrightarrow\\quad T\\text{ stetig}', 'Für lineare Operatoren zwischen normierten Räumen fallen Beschränktheit und Stetigkeit zusammen.', 'theorem', 'literature', 73, NULL, 'T ist linear zwischen normierten Vektorräumen.', 'verified', 14),
(210, '3.210', 36, 'Operatornorm auf der Einheitskugel', '\\|T\\|=\\sup_{\\|x\\|_X\\leq1}\\|Tx\\|_Y', '\\|T\\|=\\sup_{\\|x\\|_X\\leq1}\\|Tx\\|_Y', 'Die Operatornorm ist das Supremum der Bildnormen auf der Einheitskugel.', 'definition', 'literature', 73, NULL, 'T ist beschränkt linear.', 'verified', 14),
(211, '3.211', 36, 'Quotientendarstellung der Operatornorm', '\\|T\\|=\\sup_{x\\neq0}\\frac{\\|Tx\\|_Y}{\\|x\\|_X}', '\\|T\\|=\\sup_{x\\neq0}\\frac{\\|Tx\\|_Y}{\\|x\\|_X}', 'Für einen nichttrivialen Operator kann die Operatornorm durch das Supremum der relativen Normverstärkung dargestellt werden.', 'derived', 'literature', 73, NULL, 'T ist beschränkt; x ist ungleich null.', 'verified', 14),
(212, '3.212', 36, 'Grundabschätzung durch die Operatornorm', '\\|Tx\\|_Y\\leq\\|T\\|\\,\\|x\\|_X', '\\|Tx\\|_Y\\leq\\|T\\|\\,\\|x\\|_X', 'Die Operatornorm liefert die schärfste globale Standardabschätzung der linearen Operatorwirkung.', 'theorem', 'literature', 73, NULL, 'T ist beschränkt linear.', 'verified', 14),
(213, '3.213', 36, 'Raum beschränkter linearer Operatoren', '\\mathcal B(X,Y)=\\{T:X\\to Y\\mid T\\text{ linear und beschränkt}\\}', '\\mathcal B(X,Y)=\\{T:X\\to Y\\mid T\\text{ linear und beschränkt}\\}', 'B(X,Y) enthält sämtliche beschränkten linearen Operatoren von X nach Y.', 'definition', 'literature', 73, NULL, 'X und Y sind normierte Vektorräume.', 'verified', 14),
(214, '3.214', 36, 'Lineare Abgeschlossenheit des Operatorraumes', '\\alpha S+\\beta T\\in\\mathcal B(X,Y)', '\\alpha S+\\beta T\\in\\mathcal B(X,Y)', 'Linearkombinationen beschränkter linearer Operatoren sind wieder beschränkt linear.', 'theorem', 'literature', 73, NULL, 'S,T liegen in B(X,Y); alpha,beta im Skalarkörper.', 'verified', 14),
(215, '3.215', 36, 'Vollständiger Operatorraum', '\\bigl(\\mathcal B(X,Y),\\|\\cdot\\|\\bigr)\\text{ ein Banachraum}', '\\bigl(\\mathcal B(X,Y),\\|\\cdot\\|\\bigr)\\text{ ein Banachraum}', 'Bei vollständigem Zielraum ist der Operatorraum mit der Operatornorm vollständig.', 'theorem', 'literature', 73, NULL, 'X ist normiert und Y Banachraum.', 'verified', 14),
(216, '3.216', 36, 'Dualraum als spezieller Operatorraum', 'X^*=\\mathcal B(X,\\mathbb K)', 'X^*=\\mathcal B(X,\\mathbb K)', 'Der stetige Dualraum ist der Raum beschränkter linearer Operatoren in den Skalarkörper.', 'definition', 'literature', 73, NULL, 'X ist normiert.', 'verified', 14),
(217, '3.217', 36, 'Vollständigkeit des Dualraumes', 'X^*\\text{ ein Banachraum}', 'X^*\\text{ ein Banachraum}', 'Der stetige Dualraum eines normierten Vektorraumes ist vollständig.', 'theorem', 'literature', 73, NULL, 'X ist normiert; K ist R oder C.', 'verified', 14),
(218, '3.218', 36, 'Dualnorm', '\\|\\varphi\\|=\\sup_{\\|x\\|_X\\leq1}|\\varphi(x)|', '\\|\\varphi\\|=\\sup_{\\|x\\|_X\\leq1}|\\varphi(x)|', 'Die Dualnorm ist die Operatornorm eines stetigen linearen Funktionals.', 'definition', 'literature', 73, NULL, 'varphi liegt in X*.', 'verified', 14),
(219, '3.219', 36, 'Grundabschätzung eines Funktionals', '|\\varphi(x)|\\leq\\|\\varphi\\|\\,\\|x\\|_X', '|\\varphi(x)|\\leq\\|\\varphi\\|\\,\\|x\\|_X', 'Der Betrag eines Funktionalwertes wird durch Dualnorm mal Zustandsnorm kontrolliert.', 'theorem', 'literature', 73, NULL, 'varphi liegt in X*.', 'verified', 14),
(220, '3.220', 36, 'Dualitätspaarung', '\\langle\\varphi,x\\rangle=\\varphi(x)', '\\langle\\varphi,x\\rangle=\\varphi(x)', 'Die Dualitätspaarung notiert die Auswertung eines Funktionals an einem Zustand.', 'definition', 'literature', 73, NULL, 'varphi liegt in X* und x in X.', 'verified', 14),
(221, '3.221', 36, 'Kern eines Funktionals', '\\ker\\varphi=\\{x\\in X\\mid\\varphi(x)=0\\}', '\\ker\\varphi=\\{x\\in X\\mid\\varphi(x)=0\\}', 'Der Kern enthält genau die Zustände, die vom Funktional auf null abgebildet werden.', 'definition', 'literature', 73, NULL, 'varphi ist ein lineares Funktional.', 'verified', 14),
(222, '3.222', 36, 'Geschlossenheit des Funktionalkerns', '\\ker\\varphi\\text{ ist abgeschlossen in }X', '\\ker\\varphi\\text{ ist abgeschlossen in }X', 'Der Kern eines stetigen linearen Funktionals ist eine abgeschlossene lineare Teilmenge.', 'theorem', 'literature', 73, NULL, 'varphi liegt in X*.', 'verified', 14),
(223, '3.223', 36, 'Kodimension des Kerns eines nichttrivialen Funktionals', '\\varphi\\neq0\\quad\\Longrightarrow\\quad\\dim(X/\\ker\\varphi)=1', '\\varphi\\neq0\\quad\\Longrightarrow\\quad\\dim(X/\\ker\\varphi)=1', 'Der Kern eines nichttrivialen linearen Funktionals besitzt algebraische Kodimension eins.', 'theorem', 'literature', 73, NULL, 'varphi ist ein nichttriviales lineares Funktional.', 'verified', 14),
(224, '3.224', 36, 'Hilbertraumfunktional durch Skalarprodukt', '\\varphi_y(x)=\\langle x,y\\rangle', '\\varphi_y(x)=\\langle x,y\\rangle', 'Ein Vektor y eines Hilbertraumes erzeugt über das Skalarprodukt ein stetiges lineares Funktional in x.', 'definition', 'literature', 73, NULL, 'H ist Hilbertraum; das Skalarprodukt ist im ersten Argument linear.', 'verified', 14),
(225, '3.225', 36, 'Cauchy-Schwarz-Abschätzung des Hilbertraumfunktionals', '|\\varphi_y(x)|=|\\langle x,y\\rangle|\\leq\\|x\\|\\,\\|y\\|', '|\\varphi_y(x)|=|\\langle x,y\\rangle|\\leq\\|x\\|\\,\\|y\\|', 'Die Cauchy-Schwarz-Ungleichung zeigt die Beschränktheit des durch y dargestellten Funktionals.', 'theorem', 'literature', 73, NULL, 'H ist Hilbertraum.', 'verified', 14),
(226, '3.226', 36, 'Riesz-Darstellung', '\\varphi(x)=\\langle x,y\\rangle', '\\varphi(x)=\\langle x,y\\rangle', 'Jedes stetige lineare Funktional auf einem Hilbertraum wird eindeutig durch einen Vektor des Hilbertraumes dargestellt.', 'theorem', 'literature', 73, NULL, 'varphi liegt in H*; H ist Hilbertraum.', 'verified', 14),
(227, '3.227', 36, 'Normgleichheit der Riesz-Darstellung', '\\|\\varphi\\|=\\|y\\|', '\\|\\varphi\\|=\\|y\\|', 'Das Funktional und sein repräsentierender Hilbertraumvektor besitzen gleiche Norm.', 'theorem', 'literature', 73, NULL, 'y repräsentiert varphi gemäß Riesz-Darstellung.', 'verified', 14),
(228, '3.228', 36, 'Skalare Zustandsauswertung erzeugt keine zusätzliche Dimension', '\\text{zusätzliche skalare Zustandsauswertung}\\not\\Longrightarrow\\text{zusätzliche Dimension des Zustandsraumes}', '\\text{zusätzliche skalare Zustandsauswertung}\\not\\Longrightarrow\\text{zusätzliche Dimension des Zustandsraumes}', 'Die Existenz eines zusätzlichen skalaren Funktionals begründet allein keine zusätzliche Dimension des ursprünglichen Zustandsraumes.', 'schema', 'original', NULL, NULL, 'Methodologische Ebenentrennung zwischen Zustandsraum und Auswertungsabbildung.', 'verified', 14),
(229, '3.229', 36, 'Abgeschlossenheit beschränkter Operatoren unter Komposition', 'S\\circ T\\in\\mathcal B(X,Z)', 'S\\circ T\\in\\mathcal B(X,Z)', 'Die Komposition zweier passend definierter beschränkter linearer Operatoren ist wieder beschränkt linear.', 'theorem', 'literature', 73, NULL, 'T liegt in B(X,Y) und S in B(Y,Z).', 'verified', 14),
(230, '3.230', 36, 'Submultiplikativität der Operatornorm', '\\|S\\circ T\\|\\leq\\|S\\|\\,\\|T\\|', '\\|S\\circ T\\|\\leq\\|S\\|\\,\\|T\\|', 'Die Norm einer Operatorverkettung ist höchstens das Produkt der Einzelnormen.', 'theorem', 'literature', 73, NULL, 'S und T sind komponierbare beschränkte lineare Operatoren.', 'verified', 14),
(231, '3.231', 36, 'Normabschätzung einer endlichen Operatorverkettung', '\\|T_n\\circ\\cdots\\circ T_1\\|\\leq\\prod_{k=1}^{n}\\|T_k\\|', '\\|T_n\\circ\\cdots\\circ T_1\\|\\leq\\prod_{k=1}^{n}\\|T_k\\|', 'Die Norm einer endlichen Komposition wird durch das Produkt der Operatornormen beschränkt.', 'derived', 'literature', 73, 'Wiederholte Anwendung der Submultiplikativität.', 'Die Operatoren sind paarweise passend komponierbar.', 'verified', 14),
(232, '3.232', 36, 'Norm des Identitätsoperators', '\\|I_X\\|=1', '\\|I_X\\|=1', 'Der Identitätsoperator eines nichttrivialen normierten Raumes besitzt Operatornorm eins.', 'theorem', 'literature', 73, NULL, 'X ist ein normierter Vektorraum und X ist nicht der Nullraum.', 'verified', 14),
(233, '3.233', 36, 'Operatoralgebra auf einem Raum', '\\mathcal B(X)=\\mathcal B(X,X)', '\\mathcal B(X)=\\mathcal B(X,X)', 'B(X) bezeichnet die beschränkten linearen Operatoren von X nach X.', 'definition', 'literature', 73, NULL, 'X ist normiert.', 'verified', 14),
(234, '3.234', 36, 'Operatorprodukt als Komposition', 'ST:=S\\circ T\\in\\mathcal B(X)', 'ST:=S\\circ T\\in\\mathcal B(X)', 'Die Multiplikation in der Operatoralgebra wird durch Komposition definiert.', 'definition', 'literature', 73, NULL, 'S,T liegen in B(X).', 'verified', 14),
(235, '3.235', 36, 'Banachraum erzeugt Banachalgebra der beschränkten Operatoren', 'X\\text{ Banachraum}\\quad\\Longrightarrow\\quad\\mathcal B(X)\\text{ Banachalgebra}', 'X\\text{ Banachraum}\\quad\\Longrightarrow\\quad\\mathcal B(X)\\text{ Banachalgebra}', 'Ist X vollständig, ist die normierte Operatoralgebra B(X) ebenfalls vollständig.', 'theorem', 'literature', 73, NULL, 'X ist Banachraum.', 'verified', 14),
(236, '3.236', 36, 'Inverse Operatoridentitäten', 'T^{-1}T=I_X,\\qquad TT^{-1}=I_Y', 'T^{-1}T=I_X,\\qquad TT^{-1}=I_Y', 'Eine inverse lineare Abbildung erfüllt die beidseitigen Identitätsbeziehungen.', 'definition', 'literature', 73, NULL, 'T:X nach Y ist bijektiv.', 'verified', 14),
(237, '3.237', 36, 'Normabschätzung des inversen Operators', '\\|T^{-1}y\\|_X\\leq\\|T^{-1}\\|\\,\\|y\\|_Y', '\\|T^{-1}y\\|_X\\leq\\|T^{-1}\\|\\,\\|y\\|_Y', 'Ist der inverse Operator beschränkt, wird seine Wirkung durch seine Operatornorm kontrolliert.', 'theorem', 'literature', 73, NULL, 'T^{-1} liegt in B(Y,X).', 'verified', 14),
(238, '3.238', 36, 'Beschränkter inverser Operator', 'T^{-1}\\in\\mathcal B(Y,X)', 'T^{-1}\\in\\mathcal B(Y,X)', 'Ein bijektiver beschränkter linearer Operator zwischen Banachräumen besitzt einen beschränkten linearen inversen Operator.', 'theorem', 'literature', 73, NULL, 'X,Y sind Banachräume und T liegt bijektiv in B(X,Y).', 'verified', 14),
(239, '3.239', 36, 'Analytisch beschränkte Invertierbarkeit', 'T^{-1}\\in\\mathcal B(Y,X)', 'T^{-1}\\in\\mathcal B(Y,X)', 'Die Formel wird methodologisch als Aussage mathematischer Invertierbarkeit verwendet und nicht mit physikalischer Reversibilität gleichgesetzt.', 'schema', 'literature', 73, NULL, 'T ist unter den Voraussetzungen des beschränkten inversen Operators invertierbar.', 'verified', 14),
(240, '3.240', 36, 'Relative Normbeschränkung eines Operators', '\\|Tx\\|\\leq C\\|x\\|', '\\|Tx\\|\\leq C\\|x\\|', 'Beschränktheit eines linearen Operators bedeutet eine relative lineare Normabschätzung und keine absolute physikalische Obergrenze.', 'schema', 'literature', 73, NULL, 'T ist beschränkt linear.', 'verified', 14),
(241, '3.241', 36, 'Operatornorm als Lipschitz-Konstante', '\\|Tx-Ty\\|_Y\\leq\\|T\\|\\,\\|x-y\\|_X', '\\|Tx-Ty\\|_Y\\leq\\|T\\|\\,\\|x-y\\|_X', 'Jeder beschränkte lineare Operator ist Lipschitz-stetig mit einer Lipschitz-Konstante höchstens seiner Operatornorm.', 'theorem', 'literature', 73, NULL, 'T liegt in B(X,Y).', 'verified', 14),
(242, '3.242', 36, 'Strikte Abstandsverkleinerung bei Operatornorm kleiner eins', '\\|Tx-Ty\\|_Y<\\|x-y\\|_X\\qquad\\text{für }x\\neq y', '\\|Tx-Ty\\|_Y<\\|x-y\\|_X\\qquad\\text{für }x\\neq y', 'Bei Operatornorm kleiner eins verkleinert ein linearer Operator jeden von null verschiedenen norminduzierten Abstand strikt.', 'theorem', 'literature', 73, 'Folgt aus Gleichung 3.241 und der Voraussetzung ||T||<1.', 'T liegt in B(X,Y), ||T||<1 und x ist ungleich y.', 'verified', 14),
(243, '3.243', 36, 'Skalarwert eines Funktionals', '\\varphi(x)\\in\\mathbb K', '\\varphi(x)\\in\\mathbb K', 'Ein Funktional liefert einen skalaren Wert; daraus folgt noch keine spezifische physikalische Interpretation.', 'schema', 'literature', 73, NULL, 'varphi ist ein Funktional auf X.', 'verified', 14),
(244, '3.244', 36, 'Zustandsraum ist nicht automatisch sein Dualraum', 'X=X^*', 'X=X^*', 'Die dargestellte Gleichsetzung ist im Allgemeinen nicht gerechtfertigt; Zustandsraum und stetiger Dualraum sind unterschiedliche mathematische Konstruktionen.', 'schema', 'original', NULL, NULL, 'Die Gleichung dokumentiert ausdrücklich eine im Allgemeinen nicht zulässige Identifikation.', 'verified', 14),
(245, '3.245', 36, 'Zustand ist nicht Zustandsfunktional', '\\text{Zustand}\\neq\\text{Zustandsfunktional}', '\\text{Zustand}\\neq\\text{Zustandsfunktional}', 'Ein Element des Zustandsraumes und ein auf diesem Raum wirkendes Funktional sind unterschiedliche mathematische Objekte.', 'schema', 'original', NULL, NULL, 'Methodologische Ebenentrennung.', 'verified', 14),
(246, '3.246', 37, 'Eigenwertbedingung', '\\lambda\\text{ ist Eigenwert von }T\\Longleftrightarrow\\exists v\\in X\\setminus\\{0\\}:Tv=\\lambda v', '\\lambda\\text{ ist Eigenwert von }T\\Longleftrightarrow\\exists v\\in X\\setminus\\{0\\}:Tv=\\lambda v', 'Eigenwert und Eigenvektor werden durch die skalare Operatorwirkung auf einen von null verschiedenen Vektor charakterisiert.', 'definition', 'literature', 72, NULL, 'T ist linear.', 'verified', 15),
(247, '3.247', 37, 'Kernform des Eigenwertproblems', 'Tv=\\lambda v\\Longleftrightarrow(T-\\lambda I)v=0', 'Tv=\\lambda v\\Longleftrightarrow(T-\\lambda I)v=0', 'Die Eigenwertgleichung ist äquivalent zur Existenz eines nichttrivialen Vektors im Kern von T-lambda I.', 'derived', 'literature', 72, NULL, 'v ist von null verschieden.', 'verified', 15),
(248, '3.248', 37, 'Eigenraum', 'E_\\lambda=\\ker(T-\\lambda I)=\\{v\\in X\\mid Tv=\\lambda v\\}', 'E_\\lambda=\\ker(T-\\lambda I)=\\{v\\in X\\mid Tv=\\lambda v\\}', 'Der Eigenraum ist der Kern des verschobenen Operators.', 'definition', 'literature', 72, NULL, 'lambda ist Eigenwert.', 'verified', 15),
(249, '3.249', 37, 'Eigenraum als Teilraum', 'E_\\lambda\\leq X', 'E_\\lambda\\leq X', 'Der Eigenraum ist ein linearer Teilraum des Zustandsraumes.', 'theorem', 'literature', 72, NULL, 'lambda ist Eigenwert.', 'verified', 15),
(250, '3.250', 37, 'Unabhängigkeit verschiedener Eigenrichtungen', '\\lambda_i\\neq\\lambda_j\\text{ für }i\\neq j\\Longrightarrow\\{v_1,\\ldots,v_m\\}\\text{ ist linear unabhängig}', '\\lambda_i\\neq\\lambda_j\\text{ für }i\\neq j\\Longrightarrow\\{v_1,\\ldots,v_m\\}\\text{ ist linear unabhängig}', 'Eigenvektoren zu paarweise verschiedenen Eigenwerten sind linear unabhängig.', 'theorem', 'literature', 72, NULL, 'v_i sind Eigenvektoren zu lambda_i.', 'verified', 15),
(251, '3.251', 37, 'Matrixform des Eigenwertproblems', 'Ax=\\lambda x\\Longleftrightarrow(A-\\lambda I)x=0\\text{ besitzt eine Lösung }x\\neq0', 'Ax=\\lambda x\\Longleftrightarrow(A-\\lambda I)x=0\\text{ besitzt eine Lösung }x\\neq0', 'In Matrixdarstellung entspricht das Eigenwertproblem einem homogenen linearen Gleichungssystem mit nichttrivialer Lösung.', 'theorem', 'literature', 72, NULL, 'A ist quadratisch.', 'verified', 15),
(252, '3.252', 37, 'Determinantenkriterium für Eigenwerte', '\\lambda\\text{ ist Eigenwert von }A\\Longleftrightarrow\\det(A-\\lambda I)=0', '\\lambda\\text{ ist Eigenwert von }A\\Longleftrightarrow\\det(A-\\lambda I)=0', 'Im endlichdimensionalen Fall sind Eigenwerte genau die Nullstellen der Determinante von A-lambda I.', 'theorem', 'literature', 72, NULL, 'A ist quadratisch.', 'verified', 15),
(253, '3.253', 37, 'Charakteristisches Polynom', 'p_A(\\lambda)=\\det(A-\\lambda I)', 'p_A(\\lambda)=\\det(A-\\lambda I)', 'Definition des charakteristischen Polynoms.', 'definition', 'literature', 72, NULL, 'A ist quadratisch.', 'verified', 15),
(254, '3.254', 37, 'Nullstellen des charakteristischen Polynoms', 'p_A(\\lambda)=0\\Longleftrightarrow\\lambda\\text{ ist Eigenwert von }A', 'p_A(\\lambda)=0\\Longleftrightarrow\\lambda\\text{ ist Eigenwert von }A', 'Die Nullstellen des charakteristischen Polynoms sind die Eigenwerte.', 'theorem', 'literature', 72, NULL, 'A ist quadratisch.', 'verified', 15),
(255, '3.255', 37, 'Geometrische Vielfachheit', 'm_{\\mathrm{geom}}(\\lambda)=\\dim E_\\lambda=\\dim\\ker(A-\\lambda I)', 'm_{\\mathrm{geom}}(\\lambda)=\\dim E_\\lambda=\\dim\\ker(A-\\lambda I)', 'Die geometrische Vielfachheit ist die Dimension des Eigenraumes.', 'definition', 'literature', 72, NULL, 'lambda ist Eigenwert.', 'verified', 15),
(256, '3.256', 37, 'Vergleich algebraischer und geometrischer Vielfachheit', '1\\leq m_{\\mathrm{geom}}(\\lambda)\\leq m_{\\mathrm{alg}}(\\lambda)', '1\\leq m_{\\mathrm{geom}}(\\lambda)\\leq m_{\\mathrm{alg}}(\\lambda)', 'Die geometrische Vielfachheit ist mindestens eins und höchstens die algebraische Vielfachheit.', 'theorem', 'literature', 72, NULL, 'lambda ist Eigenwert einer endlichdimensionalen Matrix.', 'verified', 15),
(257, '3.257', 37, 'Diagonalisierung', 'A=PDP^{-1}', 'A=PDP^{-1}', 'Eine diagonalisierbare Matrix ist zu einer Diagonalmatrix ähnlich.', 'definition', 'literature', 72, NULL, 'P ist invertierbar und D diagonal.', 'verified', 15),
(258, '3.258', 37, 'Diagonalisierbarkeit und Eigenbasis', 'A\\text{ diagonalisierbar}\\Longleftrightarrow X\\text{ besitzt eine Basis aus Eigenvektoren von }A', 'A\\text{ diagonalisierbar}\\Longleftrightarrow X\\text{ besitzt eine Basis aus Eigenvektoren von }A', 'Diagonalisierbarkeit ist äquivalent zur Existenz einer Eigenbasis.', 'theorem', 'literature', 72, NULL, 'X ist endlichdimensional.', 'verified', 15),
(259, '3.259', 37, 'Darstellung in einer Eigenbasis', 'x=\\sum_{k=1}^{n}c_kv_k', 'x=\\sum_{k=1}^{n}c_kv_k', 'Ein Zustand wird bezüglich einer Eigenbasis durch seine Koeffizienten dargestellt.', 'schema', 'literature', 72, NULL, 'v_k bilden eine Eigenbasis.', 'verified', 15),
(260, '3.260', 37, 'Operatorwirkung in einer Eigenbasis', 'Tx=\\sum_{k=1}^{n}c_k\\lambda_kv_k', 'Tx=\\sum_{k=1}^{n}c_k\\lambda_kv_k', 'In einer Eigenbasis wirkt der Operator komponentenweise durch Skalierung mit den Eigenwerten.', 'derived', 'literature', 72, NULL, 'Tv_k=lambda_k v_k.', 'verified', 15);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(261, '3.261', 37, 'Resolventenmenge', '\\rho(T)=\\left\\{\\lambda\\in\\mathbb C\\;\\middle|\\;\\lambda I-T\\text{ ist bijektiv und }(\\lambda I-T)^{-1}\\in\\mathcal B(X)\\right\\}', '\\rho(T)=\\left\\{\\lambda\\in\\mathbb C\\;\\middle|\\;\\lambda I-T\\text{ ist bijektiv und }(\\lambda I-T)^{-1}\\in\\mathcal B(X)\\right\\}', 'Definition der Resolventenmenge eines beschränkten Operators.', 'definition', 'literature', 73, NULL, 'X ist komplexer Banachraum; T liegt in B(X).', 'verified', 15),
(262, '3.262', 37, 'Resolventenoperator', 'R(\\lambda,T)=(\\lambda I-T)^{-1},\\qquad\\lambda\\in\\rho(T)', 'R(\\lambda,T)=(\\lambda I-T)^{-1},\\qquad\\lambda\\in\\rho(T)', 'Der Resolventenoperator ist der beschränkte inverse Operator zu lambda I-T.', 'definition', 'literature', 73, NULL, 'lambda liegt in rho(T).', 'verified', 15),
(263, '3.263', 37, 'Spektrum', '\\sigma(T)=\\mathbb C\\setminus\\rho(T)', '\\sigma(T)=\\mathbb C\\setminus\\rho(T)', 'Das Spektrum ist das Komplement der Resolventenmenge.', 'definition', 'literature', 73, NULL, 'T liegt in B(X) auf komplexem Banachraum.', 'verified', 15),
(264, '3.264', 37, 'Spektralwert durch fehlende beschränkte Invertierbarkeit', '\\lambda\\in\\sigma(T)\\Longleftrightarrow\\lambda I-T\\text{ besitzt keinen beschränkten inversen Operator auf }X', '\\lambda\\in\\sigma(T)\\Longleftrightarrow\\lambda I-T\\text{ besitzt keinen beschränkten inversen Operator auf }X', 'Spektralwerte sind genau die Verschiebungsparameter, bei denen beschränkte Invertierbarkeit ausfällt.', 'definition', 'literature', 73, NULL, 'T liegt in B(X).', 'verified', 15),
(265, '3.265', 37, 'Punktspektrum', '\\sigma_p(T)=\\{\\lambda\\in\\mathbb C\\mid\\ker(T-\\lambda I)\\neq\\{0\\}\\}', '\\sigma_p(T)=\\{\\lambda\\in\\mathbb C\\mid\\ker(T-\\lambda I)\\neq\\{0\\}\\}', 'Das Punktspektrum ist die Menge der Eigenwerte.', 'definition', 'literature', 73, NULL, 'T liegt in B(X).', 'verified', 15),
(266, '3.266', 37, 'Punktspektrum als Teilmenge des Spektrums', '\\sigma_p(T)\\subseteq\\sigma(T)', '\\sigma_p(T)\\subseteq\\sigma(T)', 'Jeder Eigenwert ist ein Spektralwert.', 'theorem', 'literature', 73, NULL, 'T liegt in B(X).', 'verified', 15),
(267, '3.267', 37, 'Spektralwert muss kein Eigenwert sein', '\\lambda\\in\\sigma(T)\\not\\Longrightarrow\\lambda\\in\\sigma_p(T)', '\\lambda\\in\\sigma(T)\\not\\Longrightarrow\\lambda\\in\\sigma_p(T)', 'In unendlichdimensionalen Räumen muss ein Spektralwert kein Eigenwert sein.', 'schema', 'literature', 73, NULL, 'Allgemeine unendlichdimensionale Situation.', 'verified', 15),
(268, '3.268', 37, 'Endlichdimensionale Gleichheit von Spektrum und Punktspektrum', '\\sigma(T)=\\sigma_p(T)', '\\sigma(T)=\\sigma_p(T)', 'Auf endlichdimensionalen komplexen Vektorräumen sind Spektralwerte genau die Eigenwerte.', 'theorem', 'literature', 73, NULL, 'X ist endlichdimensional über C.', 'verified', 15),
(269, '3.269', 37, 'Nichtleeres kompaktes Spektrum innerhalb der Normscheibe', '\\varnothing\\neq\\sigma(T)\\subseteq\\{\\lambda\\in\\mathbb C\\mid|\\lambda|\\leq\\|T\\|\\}', '\\varnothing\\neq\\sigma(T)\\subseteq\\{\\lambda\\in\\mathbb C\\mid|\\lambda|\\leq\\|T\\|\\}', 'Das Spektrum eines beschränkten Operators auf einem nichttrivialen komplexen Banachraum ist nichtleer, kompakt und normbeschränkt.', 'theorem', 'literature', 73, NULL, 'X ist nichttrivialer komplexer Banachraum.', 'verified', 15),
(270, '3.270', 37, 'Normschranke eines Spektralwertes', '\\lambda\\in\\sigma(T)\\Longrightarrow|\\lambda|\\leq\\|T\\|', '\\lambda\\in\\sigma(T)\\Longrightarrow|\\lambda|\\leq\\|T\\|', 'Jeder Spektralwert liegt betragsmäßig unterhalb oder auf der Operatornorm.', 'derived', 'literature', 73, NULL, 'T liegt in B(X).', 'verified', 15),
(271, '3.271', 37, 'Spektralradius', 'r(T)=\\sup_{\\lambda\\in\\sigma(T)}|\\lambda|', 'r(T)=\\sup_{\\lambda\\in\\sigma(T)}|\\lambda|', 'Definition des Spektralradius.', 'definition', 'literature', 73, NULL, 'T liegt in B(X).', 'verified', 15),
(272, '3.272', 37, 'Spektralradius ist durch Operatornorm beschränkt', 'r(T)\\leq\\|T\\|', 'r(T)\\leq\\|T\\|', 'Der Spektralradius ist höchstens die Operatornorm.', 'theorem', 'literature', 73, NULL, 'T liegt in B(X).', 'verified', 15),
(273, '3.273', 37, 'Spektralradiusformel', 'r(T)=\\lim_{n\\to\\infty}\\|T^n\\|^{1/n}', 'r(T)=\\lim_{n\\to\\infty}\\|T^n\\|^{1/n}', 'Die asymptotischen n-ten Wurzeln der Normen der Operatorpotenzen bestimmen den Spektralradius.', 'theorem', 'literature', 73, NULL, 'T liegt in B(X) auf komplexem Banachraum.', 'verified', 15),
(274, '3.274', 37, 'Eigenwertgleichung für wiederholte Wirkung', 'Tv=\\lambda v', 'Tv=\\lambda v', 'Ausgangspunkt für die wiederholte Operatorwirkung auf einen Eigenvektor.', 'schema', 'literature', 73, NULL, 'v ist Eigenvektor.', 'verified', 15),
(275, '3.275', 37, 'Operatorpotenzen auf Eigenvektoren', 'T^n v=\\lambda^n v', 'T^n v=\\lambda^n v', 'Die n-fache Operatoranwendung skaliert einen Eigenvektor mit lambda hoch n.', 'derived', 'literature', 73, NULL, 'Tv=lambda v.', 'verified', 15),
(276, '3.276', 37, 'Normentwicklung entlang einer Eigenrichtung', '\\|T^n v\\|=|\\lambda|^n\\|v\\|', '\\|T^n v\\|=|\\lambda|^n\\|v\\|', 'Entlang einer Eigenrichtung wird die Norm bei wiederholter Operatoranwendung mit dem Betrag des Eigenwerts potenziert.', 'derived', 'literature', 73, NULL, 'v ist Eigenvektor; Norm ist homogen.', 'verified', 15),
(277, '3.277', 37, 'Invarianter Teilraum', 'M\\text{ ist }T\\text{-invariant}\\Longleftrightarrow T(M)\\subseteq M', 'M\\text{ ist }T\\text{-invariant}\\Longleftrightarrow T(M)\\subseteq M', 'Ein Teilraum ist invariant, wenn die Operatorwirkung ihn nicht verlässt.', 'definition', 'literature', 73, NULL, 'M ist linearer Teilraum.', 'verified', 15),
(278, '3.278', 37, 'Invarianz eines Eigenraumes', 'T(E_\\lambda)\\subseteq E_\\lambda', 'T(E_\\lambda)\\subseteq E_\\lambda', 'Jeder Eigenraum ist unter dem zugehörigen Operator invariant.', 'theorem', 'literature', 73, NULL, 'lambda ist Eigenwert.', 'verified', 15),
(279, '3.279', 37, 'Zusätzlicher Eigenvektor impliziert nicht automatisch zusätzliche Dimension', '\\text{zusätzlicher Eigenvektor}\\Longrightarrow\\text{zusätzliche Dimension}', '\\text{zusätzlicher Eigenvektor}\\Longrightarrow\\text{zusätzliche Dimension}', 'Die dargestellte Implikation ist ausdrücklich nicht allgemein gültig; für eine Dimensionserhöhung ist lineare Unabhängigkeit erforderlich.', 'schema', 'original', NULL, NULL, 'Methodologische Nichtimplikation; Gleichung spiegelt die im Manuskript diskutierte, verworfene Schlussform.', 'verified', 15),
(280, '3.280', 37, 'Spektrum ist nicht allgemein identisch mit der Eigenwertmenge', '\\text{Spektrum}=\\text{Menge der Eigenwerte}', '\\text{Spektrum}=\\text{Menge der Eigenwerte}', 'Die dargestellte Gleichsetzung ist in unendlichdimensionalen Räumen ausdrücklich nicht allgemein zulässig.', 'schema', 'original', NULL, NULL, 'Methodologische Nichtgleichsetzung; im endlichdimensionalen komplexen Fall gilt die Gleichheit.', 'verified', 15),
(281, '3.281', 38, 'Orthogonalität im Hilbertraum', 'x\\perp y\\Longleftrightarrow\\langle x,y\\rangle=0', 'x\\perp y\\Longleftrightarrow\\langle x,y\\rangle=0', 'Orthogonalität wird durch das Verschwinden des Skalarprodukts charakterisiert.', 'definition', 'literature', 73, NULL, NULL, 'verified', 16),
(282, '3.282', 38, 'Orthogonales Komplement', 'M^\\perp=\\left\\{x\\in H\\;\\middle|\\;\\langle x,m\\rangle=0\\text{ für alle }m\\in M\\right\\}', 'M^\\perp=\\left\\{x\\in H\\;\\middle|\\;\\langle x,m\\rangle=0\\text{ für alle }m\\in M\\right\\}', 'Definition des orthogonalen Komplements.', 'definition', 'literature', 73, NULL, NULL, 'verified', 16),
(283, '3.283', 38, 'Trivialer Schnitt mit dem orthogonalen Komplement', 'M\\cap M^\\perp=\\{0\\}', 'M\\cap M^\\perp=\\{0\\}', 'Ein linearer Teilraum eines positiv definiten Hilbertraumes schneidet sein orthogonales Komplement nur im Nullvektor.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(284, '3.284', 38, 'Geschlossenheit des orthogonalen Komplements', 'M^\\perp\\leq H\\qquad\\text{und}\\qquad M^\\perp\\text{ ist abgeschlossen}', 'M^\\perp\\leq H\\qquad\\text{und}\\qquad M^\\perp\\text{ ist abgeschlossen}', 'Das orthogonale Komplement ist ein abgeschlossener linearer Teilraum.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(285, '3.285', 38, 'Orthogonale direkte Summe', 'H=M\\oplus^\\perp N', 'H=M\\oplus^\\perp N', 'Notation einer orthogonalen direkten Summenzerlegung.', 'schema', 'literature', 73, NULL, NULL, 'verified', 16),
(286, '3.286', 38, 'Eindeutige orthogonale Zerlegung', 'x=m+n,\\qquad m\\in M,\\quad n\\in N,\\quad\\langle m,n\\rangle=0', 'x=m+n,\\qquad m\\in M,\\quad n\\in N,\\quad\\langle m,n\\rangle=0', 'Elementweise Charakterisierung der orthogonalen direkten Summe.', 'definition', 'literature', 73, NULL, NULL, 'verified', 16),
(287, '3.287', 38, 'Projektionssatz', 'H=M\\oplus^\\perp M^\\perp', 'H=M\\oplus^\\perp M^\\perp', 'Ein abgeschlossener Teilraum eines Hilbertraumes erzeugt mit seinem orthogonalen Komplement eine vollständige orthogonale Zerlegung.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(288, '3.288', 38, 'Komponentenzerlegung', 'x=m+n', 'x=m+n', 'Jeder Zustand wird im Projektionssatz in Teilraum- und Orthogonalkomponente zerlegt.', 'schema', 'literature', 73, NULL, NULL, 'verified', 16),
(289, '3.289', 38, 'Orthogonalität der Projektionskomponenten', '\\langle m,n\\rangle=0', '\\langle m,n\\rangle=0', 'Die beiden Komponenten der Hilbertraumzerlegung sind orthogonal.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(290, '3.290', 38, 'Pythagoreische Normzerlegung', '\\|x\\|^2=\\|m\\|^2+\\|n\\|^2', '\\|x\\|^2=\\|m\\|^2+\\|n\\|^2', 'Orthogonale Komponenten addieren ihre quadrierten Normen.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(291, '3.291', 38, 'Idempotenz einer Projektion', 'P^2=P', 'P^2=P', 'Algebraische Definition eines Projektionsoperators.', 'definition', 'literature', 73, NULL, NULL, 'verified', 16),
(292, '3.292', 38, 'Wiederholte Projektion', 'P(Px)=Px\\qquad\\text{für alle }x\\in X', 'P(Px)=Px\\qquad\\text{für alle }x\\in X', 'Idempotenz bedeutet, dass eine zweite Projektion keine weitere Änderung erzeugt.', 'derived', 'literature', 73, NULL, NULL, 'verified', 16),
(293, '3.293', 38, 'Direkte Summe aus Bild und Kern', 'X=\\operatorname{ran}P\\oplus\\ker P', 'X=\\operatorname{ran}P\\oplus\\ker P', 'Jede lineare Projektion zerlegt den Raum algebraisch in Bild und Kern.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(294, '3.294', 38, 'Projektionszerlegung eines Zustands', 'x=Px+(I-P)x', 'x=Px+(I-P)x', 'Jeder Zustand zerfällt in projizierten und komplementären Anteil.', 'derived', 'literature', 73, NULL, NULL, 'verified', 16),
(295, '3.295', 38, 'Lage der Projektionskomponenten', 'Px\\in\\operatorname{ran}P\\qquad\\text{und}\\qquad(I-P)x\\in\\ker P', 'Px\\in\\operatorname{ran}P\\qquad\\text{und}\\qquad(I-P)x\\in\\ker P', 'Die beiden Summanden liegen im Bild beziehungsweise Kern.', 'derived', 'literature', 73, NULL, NULL, 'verified', 16),
(296, '3.296', 38, 'Komplementäre Projektion', '(I-P)^2=I-P', '(I-P)^2=I-P', 'I-P ist ebenfalls eine Projektion.', 'derived', 'literature', 73, NULL, NULL, 'verified', 16),
(297, '3.297', 38, 'Bild-Kern-Tausch der komplementären Projektion', '\\operatorname{ran}(I-P)=\\ker P,\\qquad\\ker(I-P)=\\operatorname{ran}P', '\\operatorname{ran}(I-P)=\\ker P,\\qquad\\ker(I-P)=\\operatorname{ran}P', 'Die komplementäre Projektion vertauscht Bild und Kern.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(298, '3.298', 38, 'Orthogonale Projektion auf M', 'P_Mx=m', 'P_Mx=m', 'P_M wählt aus x=m+n die Komponente m in M aus.', 'definition', 'literature', 73, NULL, NULL, 'verified', 16),
(299, '3.299', 38, 'Orthogonaler Restanteil', '(I-P_M)x=n', '(I-P_M)x=n', 'I-P_M liefert die orthogonale Restkomponente.', 'derived', 'literature', 73, NULL, NULL, 'verified', 16),
(300, '3.300', 38, 'Orthogonale Projektionszerlegung', 'x=P_Mx+(I-P_M)x', 'x=P_Mx+(I-P_M)x', 'Vollständige Zerlegung eines Hilbertraumzustands durch P_M.', 'derived', 'literature', 73, NULL, NULL, 'verified', 16),
(301, '3.301', 38, 'Orthogonalität von Projektionsbild und Rest', '\\left\\langle P_Mx,(I-P_M)x\\right\\rangle=0', '\\left\\langle P_Mx,(I-P_M)x\\right\\rangle=0', 'Projizierter Anteil und Rest sind orthogonal.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(302, '3.302', 38, 'Bild der orthogonalen Projektion', '\\operatorname{ran}P_M=M', '\\operatorname{ran}P_M=M', 'Der Bildraum der orthogonalen Projektion ist der Projektionsraum.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(303, '3.303', 38, 'Kern der orthogonalen Projektion', '\\ker P_M=M^\\perp', '\\ker P_M=M^\\perp', 'Der Kern der orthogonalen Projektion ist das orthogonale Komplement.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(304, '3.304', 38, 'Operatorform der orthogonalen Zerlegung', 'H=\\operatorname{ran}P_M\\oplus^\\perp\\ker P_M', 'H=\\operatorname{ran}P_M\\oplus^\\perp\\ker P_M', 'Bild und Kern der orthogonalen Projektion bilden eine orthogonale direkte Summe.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(305, '3.305', 38, 'Beste Approximation', '\\|x-P_Mx\\|=\\inf_{m\\in M}\\|x-m\\|', '\\|x-P_Mx\\|=\\inf_{m\\in M}\\|x-m\\|', 'P_Mx ist die beste Approximation von x im abgeschlossenen Teilraum M.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(306, '3.306', 38, 'Minimalitätsabschätzung', '\\|x-P_Mx\\|\\leq\\|x-m\\|', '\\|x-P_Mx\\|\\leq\\|x-m\\|', 'Der Projektionsfehler ist nicht größer als der Abstand zu irgendeinem anderen Element m aus M.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(307, '3.307', 38, 'Orthogonalitätsbedingung des Projektionsfehlers', '\\langle x-P_Mx,m\\rangle=0', '\\langle x-P_Mx,m\\rangle=0', 'Der Projektionsfehler ist zu jedem Element des Projektionsraumes orthogonal.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(308, '3.308', 38, 'Kontraktivität orthogonaler Projektionen', '\\|P_Mx\\|\\leq\\|x\\|\\qquad\\text{für alle }x\\in H', '\\|P_Mx\\|\\leq\\|x\\|\\qquad\\text{für alle }x\\in H', 'Orthogonale Projektionen vergrößern die Hilbertraumnorm nicht.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(309, '3.309', 38, 'Normschranke der orthogonalen Projektion', '\\|P_M\\|\\leq1', '\\|P_M\\|\\leq1', 'Die Operatornorm einer orthogonalen Projektion ist höchstens eins.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(310, '3.310', 38, 'Norm nichttrivialer orthogonaler Projektion', 'M\\neq\\{0\\}\\Longrightarrow\\|P_M\\|=1', 'M\\neq\\{0\\}\\Longrightarrow\\|P_M\\|=1', 'Eine nichttriviale orthogonale Projektion besitzt Operatornorm eins.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(311, '3.311', 38, 'Invertierbare Projektion ist Identität', 'P^2=P\\land P\\text{ invertierbar}\\Longrightarrow P=I', 'P^2=P\\land P\\text{ invertierbar}\\Longrightarrow P=I', 'Eine lineare Projektion kann nur dann invertierbar sein, wenn sie die Identität ist.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(312, '3.312', 38, 'Gleiches Projektionsbild und Kerndifferenz', 'Px=Py\\Longleftrightarrow x-y\\in\\ker P', 'Px=Py\\Longleftrightarrow x-y\\in\\ker P', 'Zwei Zustände haben genau dann dasselbe Projektionsbild, wenn ihre Differenz im Kern liegt.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(313, '3.313', 38, 'Matrix einer orthogonalen Projektion', 'P=A(A^\\mathsf T A)^{-1}A^\\mathsf T', 'P=A(A^\\mathsf T A)^{-1}A^\\mathsf T', 'Projektionsmatrix auf den Spaltenraum einer Matrix A mit linear unabhängigen Spalten.', 'definition', 'literature', 72, NULL, NULL, 'verified', 16),
(314, '3.314', 38, 'Projizierter Vektor in Matrixform', 'Pb=A(A^\\mathsf T A)^{-1}A^\\mathsf T b', 'Pb=A(A^\\mathsf T A)^{-1}A^\\mathsf T b', 'Anwendung der Projektionsmatrix auf einen Vektor b.', 'derived', 'literature', 72, NULL, NULL, 'verified', 16),
(315, '3.315', 38, 'Orthogonalität des Matrixprojektionsfehlers', 'A^\\mathsf T(b-Pb)=0', 'A^\\mathsf T(b-Pb)=0', 'Der Projektionsfehler ist orthogonal zu allen Spalten von A.', 'theorem', 'literature', 72, NULL, NULL, 'verified', 16),
(316, '3.316', 38, 'Projektion auf eine orthonormale Basis', 'P_Mx=\\sum_{j=1}^{k}\\langle x,q_j\\rangle q_j', 'P_Mx=\\sum_{j=1}^{k}\\langle x,q_j\\rangle q_j', 'Darstellung der orthogonalen Projektion über eine orthonormale Basis des Teilraumes.', 'theorem', 'literature', 72, NULL, NULL, 'verified', 16),
(317, '3.317', 38, 'Projektionsmatrix bei orthonormalen Spalten', 'P=QQ^\\mathsf T', 'P=QQ^\\mathsf T', 'Bei orthonormalen Spalten vereinfacht sich die Projektionsmatrix zu QQ^T.', 'theorem', 'literature', 72, NULL, NULL, 'verified', 16),
(318, '3.318', 38, 'Projektionsbedingung', 'P^2=P', 'P^2=P', 'Die Idempotenz allein charakterisiert eine allgemeine Projektion, nicht notwendigerweise eine orthogonale.', 'schema', 'literature', 73, NULL, NULL, 'verified', 16),
(319, '3.319', 38, 'Algebraische Projektionszerlegung', 'X=\\operatorname{ran}P\\oplus\\ker P', 'X=\\operatorname{ran}P\\oplus\\ker P', 'Allgemeine Projektionen erzeugen eine direkte, aber nicht notwendig orthogonale Summe.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(320, '3.320', 38, 'Orthogonale Projektion impliziert Projektion', '\\text{orthogonale Projektion}\\Longrightarrow\\text{Projektion}', '\\text{orthogonale Projektion}\\Longrightarrow\\text{Projektion}', 'Jede orthogonale Projektion ist insbesondere eine Projektion.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(321, '3.321', 38, 'Invarianz impliziert nicht allgemein Invarianz des Orthogonalkomplements', 'T(M)\\subseteq M\\Longrightarrow T(M^\\perp)\\subseteq M^\\perp', 'T(M)\\subseteq M\\Longrightarrow T(M^\\perp)\\subseteq M^\\perp', 'Die dargestellte Implikation ist im Allgemeinen ausdrücklich nicht gültig; bloße Invarianz von M genügt nicht.', 'schema', 'literature', 73, NULL, NULL, 'verified', 16),
(322, '3.322', 38, 'Reduzierender Teilraum', 'T(M)\\subseteq M\\qquad\\text{und}\\qquad T(M^\\perp)\\subseteq M^\\perp', 'T(M)\\subseteq M\\qquad\\text{und}\\qquad T(M^\\perp)\\subseteq M^\\perp', 'Ein reduzierender Teilraum und sein orthogonales Komplement sind beide invariant.', 'definition', 'literature', 73, NULL, NULL, 'verified', 16),
(323, '3.323', 38, 'Kommutationskriterium', 'M\\text{ reduziert }T\\Longleftrightarrow TP_M=P_MT', 'M\\text{ reduziert }T\\Longleftrightarrow TP_M=P_MT', 'Reduzierbarkeit ist äquivalent zur Kommutation von T mit der orthogonalen Projektion.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(324, '3.324', 38, 'Operatorzerlegung auf reduzierenden Teilräumen', 'Tx=T|_M\\,m+T|_{M^\\perp}\\,n', 'Tx=T|_M\\,m+T|_{M^\\perp}\\,n', 'Auf einer reduzierenden Zerlegung wirkt T getrennt auf beiden orthogonalen Komponenten.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(325, '3.325', 38, 'Operatorabhängige Invarianz I', 'T(M)\\subseteq M', 'T(M)\\subseteq M', 'M kann unter einem bestimmten Operator T invariant sein.', 'schema', 'literature', 73, NULL, NULL, 'verified', 16),
(326, '3.326', 38, 'Operatorabhängige Invarianz II', 'S(M)\\not\\subseteq M', 'S(M)\\not\\subseteq M', 'Derselbe Teilraum muss unter einem anderen Operator S nicht invariant sein.', 'schema', 'literature', 73, NULL, NULL, 'verified', 16),
(327, '3.327', 38, 'Abhängigkeit der Projektion vom Skalarprodukt', '\\langle\\cdot,\\cdot\\rangle_1\\neq\\langle\\cdot,\\cdot\\rangle_2\\Longrightarrow P_M^{(1)}\\text{ und }P_M^{(2)}\\text{ müssen nicht übereinstimmen}', '\\langle\\cdot,\\cdot\\rangle_1\\neq\\langle\\cdot,\\cdot\\rangle_2\\Longrightarrow P_M^{(1)}\\text{ und }P_M^{(2)}\\text{ müssen nicht übereinstimmen}', 'Methodologische Aussage: Orthogonalität und Projektion hängen von der gewählten Skalarproduktstruktur ab.', 'schema', 'original', NULL, NULL, NULL, 'verified', 16),
(328, '3.328', 38, 'Abstrakte Orthogonalität ist keine physikalische Rechtwinkligkeit', '\\langle x,y\\rangle=0\\not\\Longrightarrow\\text{physikalische Rechtwinkligkeit}', '\\langle x,y\\rangle=0\\not\\Longrightarrow\\text{physikalische Rechtwinkligkeit}', 'Methodologische Nichtimplikation zwischen abstrakter Hilbertraumorthogonalität und physikalischer Geometrie.', 'schema', 'original', NULL, NULL, NULL, 'verified', 16),
(329, '3.329', 38, 'Zustandszerlegung durch allgemeine Projektion', 'x=Px+(I-P)x', 'x=Px+(I-P)x', 'Der vollständige Zustand zerfällt in projizierten und komplementären Anteil.', 'derived', 'literature', 73, NULL, NULL, 'verified', 16),
(330, '3.330', 38, 'Dimensionszerlegung einer endlichen Projektion', '\\dim X=\\dim(\\operatorname{ran}P)+\\dim(\\ker P)', '\\dim X=\\dim(\\operatorname{ran}P)+\\dim(\\ker P)', 'In endlichdimensionalen Räumen folgt die Dimensionszerlegung aus der direkten Summe von Bild und Kern.', 'theorem', 'literature', 72, NULL, NULL, 'verified', 16),
(331, '3.331', 38, 'Orthogonalität impliziert lineare Unabhängigkeit', 'x\\perp y,\\quad x\\neq0,\\quad y\\neq0\\Longrightarrow\\{x,y\\}\\text{ ist linear unabhängig}', 'x\\perp y,\\quad x\\neq0,\\quad y\\neq0\\Longrightarrow\\{x,y\\}\\text{ ist linear unabhängig}', 'Zwei von null verschiedene orthogonale Vektoren sind linear unabhängig.', 'theorem', 'literature', 72, NULL, NULL, 'verified', 16),
(332, '3.332', 38, 'Orthogonale Zustandsraumzerlegung', 'H=M\\oplus^\\perp M^\\perp', 'H=M\\oplus^\\perp M^\\perp', 'Orthogonale direkte Summe eines abgeschlossenen Teilraumes und seines Komplements; keine automatische Kausalinterpretation.', 'schema', 'literature', 73, NULL, NULL, 'verified', 16),
(333, '3.333', 38, 'Projektionszerlegung eines funktionalen Zustands', '\\psi=P_M\\psi+(I-P_M)\\psi', '\\psi=P_M\\psi+(I-P_M)\\psi', 'Ein funktionaler Hilbertraumzustand kann in Projektions- und Orthogonalanteil zerlegt werden.', 'model', 'literature', 73, NULL, NULL, 'verified', 16),
(334, '3.334', 38, 'Lage der funktionalen Projektionskomponenten', 'P_M\\psi\\in M\\qquad\\text{und}\\qquad(I-P_M)\\psi\\in M^\\perp', 'P_M\\psi\\in M\\qquad\\text{und}\\qquad(I-P_M)\\psi\\in M^\\perp', 'Die beiden Komponenten eines funktionalen Zustands liegen im gewählten Teilraum beziehungsweise seinem orthogonalen Komplement.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 16),
(335, '3.383', 39, 'Allgemeine gewöhnliche Differentialgleichung k-ter Ordnung', 'F\\left(t,x(t),x\'(t),\\ldots,x^{(k)}(t)\\right)=0', 'F\\left(t,x(t),x\'(t),\\ldots,x^{(k)}(t)\\right)=0', 'Allgemeine implizite Form einer ODE k-ter Ordnung.', 'definition', 'literature', 75, NULL, NULL, 'verified', 17),
(336, '3.384', 39, 'ODE-System erster Ordnung', 'x\'(t)=F(t,x(t))', 'x\'(t)=F(t,x(t))', 'Ein System erster Ordnung ordnet jedem zulässigen Parameter-Zustands-Paar eine Änderungsrate zu.', 'model', 'literature', 75, NULL, NULL, 'verified', 17),
(337, '3.385', 39, 'Unabhängige Variable ist nicht automatisch physikalische Zeit', 't\\text{ ist unabhängige Variable}\\not\\Longrightarrow t\\text{ ist physikalische Zeit}', 't\\text{ ist unabhängige Variable}\\not\\Longrightarrow t\\text{ ist physikalische Zeit}', 'Methodologische Nichtimplikation zwischen mathematischer unabhängiger Variable und physikalischer Zeit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(338, '3.386', 39, 'Autonomes ODE-System', 'x\'(t)=F(x(t))', 'x\'(t)=F(x(t))', 'In einem autonomen System hängt die rechte Seite nicht explizit von der unabhängigen Variablen ab.', 'definition', 'literature', 75, NULL, NULL, 'verified', 17),
(339, '3.387', 39, 'Nichtautonomes ODE-System', 'x\'(t)=F(t,x(t))', 'x\'(t)=F(t,x(t))', 'Ein nichtautonomes System kann explizit von der unabhängigen Variablen abhängen.', 'schema', 'literature', 75, NULL, NULL, 'verified', 17),
(340, '3.388', 39, 'Klassische ODE-Lösung', 'x\'(t)=F(t,x(t))', 'x\'(t)=F(t,x(t))', 'Eine klassische Lösung erfüllt die Differentialgleichung punktweise.', 'definition', 'literature', 75, NULL, NULL, 'verified', 17),
(341, '3.389', 39, 'Differentialgleichung und Lösung sind verschiedene Objekte', '\\text{Differentialgleichung}\\neq\\text{Lösung der Differentialgleichung}', '\\text{Differentialgleichung}\\neq\\text{Lösung der Differentialgleichung}', 'Methodologische Ebenentrennung zwischen Bedingung und sie erfüllender Funktion.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(342, '3.390', 39, 'Differentialgleichung eines Anfangswertproblems', 'x\'(t)=F(t,x(t))', 'x\'(t)=F(t,x(t))', 'Differentialgleichung als erster Bestandteil eines Anfangswertproblems.', 'schema', 'literature', 75, NULL, NULL, 'verified', 17),
(343, '3.391', 39, 'Anfangsbedingung', 'x(t_0)=x_0', 'x(t_0)=x_0', 'Vorgabe eines Zustandes an einem ausgezeichneten Parameterwert.', 'definition', 'literature', 75, NULL, NULL, 'verified', 17),
(344, '3.392', 39, 'Anfangswertproblem erster Ordnung', '\\begin{cases}x\'(t)=F(t,x(t)),\\\\x(t_0)=x_0.\\end{cases}', '\\begin{cases}x\'(t)=F(t,x(t)),\\\\x(t_0)=x_0.\\end{cases}', 'Kombination aus ODE und Anfangsbedingung.', 'definition', 'literature', 75, NULL, NULL, 'verified', 17),
(345, '3.393', 39, 'Lokal eindeutig lösbares Anfangswertproblem', '\\begin{cases}x\'(t)=F(t,x(t)),\\\\x(t_0)=x_0\\end{cases}', '\\begin{cases}x\'(t)=F(t,x(t)),\\\\x(t_0)=x_0\\end{cases}', 'Problemform des lokalen Existenz- und Eindeutigkeitssatzes.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 17),
(346, '3.394', 39, 'Lokale Lipschitz-Bedingung', '\\|F(t,x)-F(t,y)\\|\\leq L\\|x-y\\|', '\\|F(t,x)-F(t,y)\\|\\leq L\\|x-y\\|', 'Lokale Lipschitz-Abschätzung bezüglich der Zustandsvariablen.', 'definition', 'literature', 75, NULL, NULL, 'verified', 17),
(347, '3.395', 39, 'Mathematische Eindeutigkeit beweist nicht automatisch physikalischen Determinismus', '\\text{mathematische Eindeutigkeit}\\not\\Longrightarrow\\text{physikalischer Determinismus}', '\\text{mathematische Eindeutigkeit}\\not\\Longrightarrow\\text{physikalischer Determinismus}', 'Methodologische Nichtimplikation zwischen eindeutiger Modelllösung und physikalischem Determinismus.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(348, '3.396', 39, 'Lokale Lösung impliziert nicht allgemein globale Lösung', '\\text{lokale Lösung}\\not\\Longrightarrow\\text{globale Lösung}', '\\text{lokale Lösung}\\not\\Longrightarrow\\text{globale Lösung}', 'Lokale Existenz garantiert keine globale Fortsetzbarkeit.', 'schema', 'literature', 75, NULL, NULL, 'verified', 17),
(349, '3.397', 39, 'Stetige Abhängigkeit von Anfangsdaten', 'x_0^{(n)}\\longrightarrow x_0\\Longrightarrow x^{(n)}\\longrightarrow x', 'x_0^{(n)}\\longrightarrow x_0\\Longrightarrow x^{(n)}\\longrightarrow x', 'Symbolische Darstellung stetiger Datenabhängigkeit in einer festzulegenden Lösungstopologie.', 'schema', 'literature', 75, NULL, NULL, 'verified', 17),
(350, '3.398', 39, 'Gleichgewichtsbedingung', 'F(x_*)=0', 'F(x_*)=0', 'Ein Gleichgewicht eines autonomen Systems ist eine Nullstelle des Vektorfeldes F.', 'definition', 'literature', 75, NULL, NULL, 'verified', 17),
(351, '3.399', 39, 'Konstante Gleichgewichtslösung', 'x(t)=x_*', 'x(t)=x_*', 'Ein Gleichgewicht erzeugt eine konstante Zustandskurve.', 'model', 'literature', 75, NULL, NULL, 'verified', 17),
(352, '3.400', 39, 'Verifikation der konstanten Gleichgewichtslösung', 'x(t)=x_*\\Longrightarrow x\'(t)=0=F(x_*)', 'x(t)=x_*\\Longrightarrow x\'(t)=0=F(x_*)', 'Die konstante Funktion erfüllt das autonome System, wenn F(x_*)=0 gilt.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 17),
(353, '3.401', 39, 'Lineares inhomogenes ODE-System', 'x\'(t)=A(t)x(t)+b(t)', 'x\'(t)=A(t)x(t)+b(t)', 'Allgemeine Form eines linearen inhomogenen Systems erster Ordnung.', 'model', 'literature', 75, NULL, NULL, 'verified', 17),
(354, '3.402', 39, 'Lineares homogenes ODE-System', 'x\'(t)=A(t)x(t)', 'x\'(t)=A(t)x(t)', 'Homogene Form eines linearen Systems erster Ordnung.', 'model', 'literature', 75, NULL, NULL, 'verified', 17),
(355, '3.403', 39, 'Linearkombination homogener ODE-Lösungen', 'x=\\alpha x_1+\\beta x_2', 'x=\\alpha x_1+\\beta x_2', 'Linearkombination zweier Lösungen eines homogenen linearen Systems.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 17),
(356, '3.404', 39, 'Nachweis des Superpositionsprinzips', 'x\'=\\alpha x_1\'+\\beta x_2\'=A(t)(\\alpha x_1+\\beta x_2)=A(t)x', 'x\'=\\alpha x_1\'+\\beta x_2\'=A(t)(\\alpha x_1+\\beta x_2)=A(t)x', 'Direkter Nachweis des Superpositionsprinzips durch Linearität.', 'derived', 'literature', 75, NULL, NULL, 'verified', 17),
(357, '3.405', 39, 'Allgemeine PDE k-ter Ordnung', 'F\\left(x,u(x),Du(x),D^2u(x),\\ldots,D^ku(x)\\right)=0', 'F\\left(x,u(x),Du(x),D^2u(x),\\ldots,D^ku(x)\\right)=0', 'Symbolische Form einer partiellen Differentialgleichung k-ter Ordnung.', 'definition', 'literature', 76, NULL, NULL, 'verified', 17),
(358, '3.406', 39, 'Klassische PDE-Lösung', 'F(x,u,Du,D^2u)=0', 'F(x,u,Du,D^2u)=0', 'Eine klassische Lösung erfüllt die PDE punktweise mit ausreichender Regularität.', 'definition', 'literature', 76, NULL, NULL, 'verified', 17),
(359, '3.407', 39, 'Laplace-Gleichung', '\\Delta u=0', '\\Delta u=0', 'Prototypische lineare elliptische Gleichung.', 'model', 'literature', 76, NULL, NULL, 'verified', 17),
(360, '3.408', 39, 'Prototypische Diffusionsgleichung', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0,\\qquad\\kappa>0', '\\frac{\\partial u}{\\partial t}-\\kappa\\Delta u=0,\\qquad\\kappa>0', 'Standardform einer Diffusions- beziehungsweise Wärmeleitungsgleichung.', 'model', 'literature', 76, NULL, NULL, 'verified', 17),
(361, '3.409', 39, 'Prototypische Wellengleichung', '\\frac{\\partial^2u}{\\partial t^2}-c^2\\Delta u=0,\\qquad c>0', '\\frac{\\partial^2u}{\\partial t^2}-c^2\\Delta u=0,\\qquad c>0', 'Standardform einer linearen Wellengleichung.', 'model', 'literature', 76, NULL, NULL, 'verified', 17),
(362, '3.410', 39, 'Anfangsdaten einer PDE', 'u(0,x)=u_0(x)', 'u(0,x)=u_0(x)', 'Vorgabe des Zustandes auf einer ausgezeichneten Parameterfläche.', 'definition', 'literature', 76, NULL, NULL, 'verified', 17),
(363, '3.411', 39, 'Anfangsdaten erster Ableitungsordnung', '\\frac{\\partial u}{\\partial t}(0,x)=v_0(x)', '\\frac{\\partial u}{\\partial t}(0,x)=v_0(x)', 'Zusätzliche Anfangsbedingung für Probleme zweiter Ordnung bezüglich des Entwicklungsparameters.', 'definition', 'literature', 76, NULL, NULL, 'verified', 17),
(364, '3.412', 39, 'Dirichlet-Randbedingung', 'u|_{\\partial\\Omega}=g', 'u|_{\\partial\\Omega}=g', 'Vorgabe der Funktionswerte am Rand des Definitionsgebietes.', 'definition', 'literature', 76, NULL, NULL, 'verified', 17),
(365, '3.413', 39, 'Neumann-Randbedingung', '\\frac{\\partial u}{\\partial n}\\Big|_{\\partial\\Omega}=h', '\\frac{\\partial u}{\\partial n}\\Big|_{\\partial\\Omega}=h', 'Vorgabe einer Normalableitung am Rand bei hinreichend regulärer Randstruktur.', 'definition', 'literature', 76, NULL, NULL, 'verified', 17),
(366, '3.414', 39, 'Mathematischer Rand ist nicht automatisch physikalische Systemgrenze', '\\partial\\Omega\\text{ mathematischer Rand}\\not\\Longrightarrow\\partial\\Omega\\text{ physikalische Systemgrenze}', '\\partial\\Omega\\text{ mathematischer Rand}\\not\\Longrightarrow\\partial\\Omega\\text{ physikalische Systemgrenze}', 'Methodologische Nichtimplikation zwischen mathematischem Gebietsrand und physikalischer Grenze.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(367, '3.415', 39, 'Abstraktes Randwertproblem', '\\begin{cases}Au=f&\\text{ in }\\Omega,\\\\Bu=g&\\text{ auf }\\partial\\Omega.\\end{cases}', '\\begin{cases}Au=f&\\text{ in }\\Omega,\\\\Bu=g&\\text{ auf }\\partial\\Omega.\\end{cases}', 'Abstrakte Kombination aus Differentialoperator im Inneren und Randoperator.', 'model', 'literature', 76, NULL, NULL, 'verified', 17),
(368, '3.416', 39, 'Abstraktes Anfangs-Randwertproblem', '\\begin{cases}\\partial_tu=Au&\\text{ in }(0,T)\\times\\Omega,\\\\u(0,\\cdot)=u_0&\\text{ in }\\Omega,\\\\Bu=g&\\text{ auf }(0,T)\\times\\partial\\Omega.\\end{cases}', '\\begin{cases}\\partial_tu=Au&\\text{ in }(0,T)\\times\\Omega,\\\\u(0,\\cdot)=u_0&\\text{ in }\\Omega,\\\\Bu=g&\\text{ auf }(0,T)\\times\\partial\\Omega.\\end{cases}', 'Evolutionäre PDE mit Anfangs- und Randdaten.', 'model', 'literature', 76, NULL, NULL, 'verified', 17),
(369, '3.417', 39, 'Vollständige Spezifikation eines Differentialproblems', '\\text{Differentialausdruck}+\\text{Definitionsgebiet}+\\text{Definitionsbereich}+\\text{Anfangs-/Randbedingungen}\\longrightarrow\\text{vollständiges Differentialproblem}', '\\text{Differentialausdruck}+\\text{Definitionsgebiet}+\\text{Definitionsbereich}+\\text{Anfangs-/Randbedingungen}\\longrightarrow\\text{vollständiges Differentialproblem}', 'Methodologische Synthese der Bestandteile eines vollständigen Differentialproblems.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(370, '3.418', 39, 'Operatorform einer Differentialgleichung', 'Au=f', 'Au=f', 'Abstrakte Operatorform eines linearen Differentialproblems.', 'model', 'literature', 73, NULL, NULL, 'verified', 17),
(371, '3.419', 39, 'Lösung einer Operatorgleichung', 'u\\in D(A),\\qquad Au=f', 'u\\in D(A),\\qquad Au=f', 'Eine Lösung muss im Definitionsbereich des Operators liegen und die Operatorgleichung erfüllen.', 'schema', 'literature', 73, NULL, NULL, 'verified', 17),
(372, '3.420', 39, 'Homogenes lineares Differentialproblem', 'Au=0', 'Au=0', 'Homogene Operatorgleichung.', 'model', 'literature', 73, NULL, NULL, 'verified', 17),
(373, '3.421', 39, 'Lösungsraum als Kern', '\\{u\\in D(A)\\mid Au=0\\}=\\ker A', '\\{u\\in D(A)\\mid Au=0\\}=\\ker A', 'Die Lösungen eines homogenen linearen Operatorproblems bilden den Kern von A.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 17),
(374, '3.422', 39, 'Superposition homogener Differentiallösungen', 'u_1,u_2\\in\\ker A\\Longrightarrow\\alpha u_1+\\beta u_2\\in\\ker A', 'u_1,u_2\\in\\ker A\\Longrightarrow\\alpha u_1+\\beta u_2\\in\\ker A', 'Der Kern eines linearen Operators ist ein linearer Raum.', 'theorem', 'literature', 73, NULL, NULL, 'verified', 17),
(375, '3.423', 39, 'Inhomogenes lineares Differentialproblem', 'Au=f', 'Au=f', 'Inhomogene lineare Operatorgleichung.', 'model', 'literature', 73, NULL, NULL, 'verified', 17),
(376, '3.424', 39, 'Partikuläre Lösung', 'Au_p=f', 'Au_p=f', 'Eine bestimmte Lösung des inhomogenen Problems.', 'schema', 'literature', 73, NULL, NULL, 'verified', 17),
(377, '3.425', 39, 'Addition einer homogenen Lösung', 'A(u_p+u_h)=f', 'A(u_p+u_h)=f', 'Zu einer partikulären Lösung kann jedes Kernelement addiert werden.', 'derived', 'literature', 73, NULL, NULL, 'verified', 17),
(378, '3.426', 39, 'Affiner Lösungsraum', 'u_p+\\ker A', 'u_p+\\ker A', 'Die nichtleere Lösungsmenge eines inhomogenen linearen Problems ist eine affine Verschiebung des Kerns.', 'derived', 'literature', 73, NULL, NULL, 'verified', 17),
(379, '3.427', 39, 'Wohlgestelltheit', '\\text{Wohlgestelltheit}=\\text{Existenz}+\\text{Eindeutigkeit}+\\text{stetige Datenabhängigkeit}', '\\text{Wohlgestelltheit}=\\text{Existenz}+\\text{Eindeutigkeit}+\\text{stetige Datenabhängigkeit}', 'Klassische Struktur eines wohlgestellten Differentialproblems.', 'definition', 'literature', 76, NULL, NULL, 'verified', 17),
(380, '3.428', 39, 'Wohlgestelltheit beweist nicht physikalische Richtigkeit', '\\text{mathematisch wohlgestellt}\\not\\Longrightarrow\\text{physikalisch richtig}', '\\text{mathematisch wohlgestellt}\\not\\Longrightarrow\\text{physikalisch richtig}', 'Methodologische Nichtimplikation zwischen mathematischer Qualität und empirischer Gültigkeit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(381, '3.429', 39, 'Mathematische Lösung beweist nicht physikalische Realisierbarkeit', 'u\\text{ löst die Differentialgleichung}\\not\\Longrightarrow u\\text{ ist physikalisch realisierbar}', 'u\\text{ löst die Differentialgleichung}\\not\\Longrightarrow u\\text{ ist physikalisch realisierbar}', 'Methodologische Nichtimplikation zwischen formaler Lösung und physikalischer Realisierbarkeit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(382, '3.430', 39, 'Anfangswert', 'x(t_0)=x_0', 'x(t_0)=x_0', 'Mathematische Vorgabe eines Zustandes an einem ausgezeichneten Parameterwert.', 'schema', 'literature', 75, NULL, NULL, 'verified', 17),
(383, '3.431', 39, 'Anfangswert ist nicht automatisch physikalische Ursache', '\\text{Anfangswert}\\neq\\text{automatisch physikalische Ursache}', '\\text{Anfangswert}\\neq\\text{automatisch physikalische Ursache}', 'Methodologische Trennung zwischen Anfangsdaten und Kausalitätsbegriff.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(384, '3.432', 39, 'Funktion mit vier unabhängigen Variablen', 'u=u(x_1,x_2,x_3,x_4)', 'u=u(x_1,x_2,x_3,x_4)', 'Beispiel zur Trennung von Argumentzahl und physikalischer Dimension.', 'model', 'original', NULL, NULL, NULL, 'verified', 17),
(385, '3.433', 39, 'Vier Funktionsargumente beweisen keine vier physikalischen Dimensionen', '4\\text{ Funktionsargumente}\\not\\Longrightarrow4\\text{ physikalische Dimensionen}', '4\\text{ Funktionsargumente}\\not\\Longrightarrow4\\text{ physikalische Dimensionen}', 'Methodologische Nichtimplikation für spätere Dimensionsargumente.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(386, '3.434', 39, 'Mehrdimensionaler ODE-Zustand bei einer unabhängigen Variablen', 'x(t)=\\begin{pmatrix}x_1(t)\\\\\\vdots\\\\x_n(t)\\end{pmatrix}\\in\\mathbb R^n', 'x(t)=\\begin{pmatrix}x_1(t)\\\\\\vdots\\\\x_n(t)\\end{pmatrix}\\in\\mathbb R^n', 'Ein ODE-System kann einen n-dimensionalen Zustand bei nur einer unabhängigen Variablen besitzen.', 'model', 'literature', 75, NULL, NULL, 'verified', 17),
(387, '3.435', 39, 'Zustandsdimension ist nicht Zahl unabhängiger Variablen', '\\dim X=n\\not\\equiv\\text{Zahl der unabhängigen Variablen}', '\\dim X=n\\not\\equiv\\text{Zahl der unabhängigen Variablen}', 'Methodologische Trennung von Zustandsraumdimension und Argumentstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(388, '3.436', 39, 'Lösungsmenge einer Differentialrelation', '\\mathcal S=\\{u\\in\\mathcal X\\mid F(u)=0\\}', '\\mathcal S=\\{u\\in\\mathcal X\\mid F(u)=0\\}', 'Eine Differentialrelation selektiert aus einem Zustandsraum die sie erfüllenden Lösungen.', 'model', 'original', NULL, NULL, NULL, 'verified', 17),
(389, '3.437', 39, 'Einschränkung durch Daten', '\\mathcal S_{\\mathrm{data}}\\subseteq\\mathcal S', '\\mathcal S_{\\mathrm{data}}\\subseteq\\mathcal S', 'Anfangs- oder Randdaten schränken die allgemeine Lösungsmenge weiter ein.', 'model', 'original', NULL, NULL, NULL, 'verified', 17),
(390, '3.438', 39, 'Hierarchie von Funktionenraum und Lösungsmenge', '\\mathcal F\\supseteq\\mathcal X\\supseteq\\mathcal S\\supseteq\\mathcal S_{\\mathrm{data}}', '\\mathcal F\\supseteq\\mathcal X\\supseteq\\mathcal S\\supseteq\\mathcal S_{\\mathrm{data}}', 'Hierarchie zwischen allgemeinem Funktionenraum, zulässigem Zustandsraum und Lösungsräumen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(391, '3.439', 39, 'Didaktischer Aufbau eines Differentialproblems', '\\text{Differentialoperator}\\longrightarrow\\text{Differentialgleichung}\\longrightarrow\\text{Anfangs-/Randdaten}\\longrightarrow\\text{Lösungsproblem}', '\\text{Differentialoperator}\\longrightarrow\\text{Differentialgleichung}\\longrightarrow\\text{Anfangs-/Randdaten}\\longrightarrow\\text{Lösungsproblem}', 'Didaktische Struktur von Operator zur vollständigen Problemstellung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(392, '3.440', 39, 'Didaktischer Aufbau der Wohlgestelltheit', '\\text{Lösungsproblem}\\longrightarrow\\text{Existenz}\\longrightarrow\\text{Eindeutigkeit}\\longrightarrow\\text{stetige Datenabhängigkeit}\\longrightarrow\\text{Wohlgestelltheit}', '\\text{Lösungsproblem}\\longrightarrow\\text{Existenz}\\longrightarrow\\text{Eindeutigkeit}\\longrightarrow\\text{stetige Datenabhängigkeit}\\longrightarrow\\text{Wohlgestelltheit}', 'Didaktische Struktur der mathematischen Qualitätsprüfung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(393, '3.441', 39, 'Funktionenraum bis Lösungsmenge', '\\text{Funktionenraum}\\longrightarrow\\text{zulässiger Zustandsraum}\\longrightarrow\\text{Differentialrelation}\\longrightarrow\\text{Lösungsmenge}', '\\text{Funktionenraum}\\longrightarrow\\text{zulässiger Zustandsraum}\\longrightarrow\\text{Differentialrelation}\\longrightarrow\\text{Lösungsmenge}', 'Didaktische Einordnung der Differentialgleichung in die Funktionenraumstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 17),
(394, '3.442', 40, 'Dynamisches System als Zustandswirkung', 'T:G\\times M\\longrightarrow M,\\qquad(g,x)\\longmapsto T_g(x)', 'T:G\\times M\\longrightarrow M,\\qquad(g,x)\\longmapsto T_g(x)', 'Definition einer parametrisierten Wirkung auf dem Zustandsraum.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(395, '3.443', 40, 'Verträglichkeit mit der Halbgruppenstruktur', 'T_g\\circ T_h=T_{gh},\\qquad T_e=I_M', 'T_g\\circ T_h=T_{gh},\\qquad T_e=I_M', 'Kompositions- und Identitätsbedingung eines dynamischen Systems.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(396, '3.444', 40, 'Diskrete Parameterbereiche', 'G=\\mathbb N_0\\qquad\\text{oder}\\qquad G=\\mathbb Z', 'G=\\mathbb N_0\\qquad\\text{oder}\\qquad G=\\mathbb Z', 'Typische diskrete Parameterbereiche dynamischer Systeme.', 'schema', 'literature', 75, NULL, NULL, 'verified', 18),
(397, '3.445', 40, 'Diskrete Iteration', 'T_n=F^n,\\qquad F^0=I_M', 'T_n=F^n,\\qquad F^0=I_M', 'Ein diskretes dynamisches System kann durch Iteration einer Abbildung erzeugt werden.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(398, '3.446', 40, 'Kontinuierliche Parameterbereiche', 'G=\\mathbb R_{\\geq0}\\qquad\\text{oder}\\qquad G=\\mathbb R', 'G=\\mathbb R_{\\geq0}\\qquad\\text{oder}\\qquad G=\\mathbb R', 'Typische kontinuierliche Parameterbereiche für Semi- beziehungsweise Flüsse.', 'schema', 'literature', 75, NULL, NULL, 'verified', 18),
(399, '3.447', 40, 'Flussabbildungen', '\\Phi_t:M\\longrightarrow M,\\qquad t\\in\\mathbb R', '\\Phi_t:M\\longrightarrow M,\\qquad t\\in\\mathbb R', 'Ein globaler Fluss ist eine durch reelle Parameter indizierte Familie von Zustandsabbildungen.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(400, '3.448', 40, 'Flussgesetz', '\\Phi_0=I_M,\\qquad\\Phi_{t+s}=\\Phi_t\\circ\\Phi_s', '\\Phi_0=I_M,\\qquad\\Phi_{t+s}=\\Phi_t\\circ\\Phi_s', 'Identitäts- und Gruppenverkettung eines globalen Flusses.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(401, '3.449', 40, 'Autonomes Anfangswertproblem', '\\dot x=f(x),\\qquad x(0)=x_0', '\\dot x=f(x),\\qquad x(0)=x_0', 'Autonomes Anfangswertproblem als Erzeuger einer Zustandsentwicklung.', 'model', 'literature', 75, NULL, NULL, 'verified', 18),
(402, '3.450', 40, 'Fluss aus der Lösung eines Anfangswertproblems', '\\Phi(t,x_0)=\\varphi_{x_0}(t)', '\\Phi(t,x_0)=\\varphi_{x_0}(t)', 'Der Flusswert ist der durch die Lösung erreichte Zustand.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(403, '3.451', 40, 'Flusseigenschaft autonomer Systeme', '\\Phi(t+s,x)=\\Phi\\left(t,\\Phi(s,x)\\right)', '\\Phi(t+s,x)=\\Phi\\left(t,\\Phi(s,x)\\right)', 'Eindeutigkeit der Lösung impliziert die Flussverkettung.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(404, '3.452', 40, 'Einparameterdarstellung des Flusses', '\\Phi_t(x)=\\Phi(t,x)', '\\Phi_t(x)=\\Phi(t,x)', 'Notation einer Flussabbildung für festen Parameter t.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(405, '3.453', 40, 'Globaler Definitionsbereich eines Flusses', 'W=\\mathbb R\\times M', 'W=\\mathbb R\\times M', 'Ein lokaler Fluss ist global, wenn sein Definitionsbereich ganz R mal M ist.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(406, '3.454', 40, 'Vollständigkeit und globaler Fluss', '\\text{Vollständigkeit}\\Longrightarrow\\Phi:\\mathbb R\\times M\\longrightarrow M', '\\text{Vollständigkeit}\\Longrightarrow\\Phi:\\mathbb R\\times M\\longrightarrow M', 'Vollständige autonome Systeme erzeugen globale Flüsse.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(407, '3.455', 40, 'Inverse einer globalen Flussabbildung', '\\Phi_t^{-1}=\\Phi_{-t}', '\\Phi_t^{-1}=\\Phi_{-t}', 'Die negative Parameterabbildung ist die Inverse.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(408, '3.456', 40, 'Nachweis der Flussinverse', '\\Phi_t\\circ\\Phi_{-t}=\\Phi_0=I_M=\\Phi_{-t}\\circ\\Phi_t', '\\Phi_t\\circ\\Phi_{-t}=\\Phi_0=I_M=\\Phi_{-t}\\circ\\Phi_t', 'Direkter Nachweis über das Flussgesetz.', 'derived', 'literature', 75, NULL, NULL, 'verified', 18),
(409, '3.457', 40, 'Semiflussgesetz', '\\Phi_0=I_M,\\qquad\\Phi_{t+s}=\\Phi_t\\circ\\Phi_s\\qquad\\text{für }s,t\\geq0', '\\Phi_0=I_M,\\qquad\\Phi_{t+s}=\\Phi_t\\circ\\Phi_s\\qquad\\text{für }s,t\\geq0', 'Halbgruppenstruktur eines vorwärts parametrisierten Semiflusses.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(410, '3.458', 40, 'Trajektorie', '\\gamma_{x_0}(t)=\\Phi(t,x_0)', '\\gamma_{x_0}(t)=\\Phi(t,x_0)', 'Parametrisierte Zustandskurve durch einen Anfangszustand.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(411, '3.459', 40, 'Integralkurvengleichung', '\\frac{d}{dt}\\gamma_{x_0}(t)=f\\left(\\gamma_{x_0}(t)\\right)', '\\frac{d}{dt}\\gamma_{x_0}(t)=f\\left(\\gamma_{x_0}(t)\\right)', 'Trajektorien eines ODE-Flusses erfüllen die zugrunde liegende autonome Differentialgleichung.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(412, '3.460', 40, 'Orbit eines Zustandes', '\\mathcal O(x)=\\{\\Phi_t(x)\\mid t\\in\\mathbb R\\}', '\\mathcal O(x)=\\{\\Phi_t(x)\\mid t\\in\\mathbb R\\}', 'Bildmenge der globalen Trajektorie eines Zustandes.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(413, '3.461', 40, 'Positiver Orbit', '\\mathcal O^+(x)=\\{\\Phi_t(x)\\mid t\\geq0\\}', '\\mathcal O^+(x)=\\{\\Phi_t(x)\\mid t\\geq0\\}', 'Vorwärtsorbit eines Zustandes unter einem Semifluss.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(414, '3.462', 40, 'Negativer Orbit', '\\mathcal O^-(x)=\\{\\Phi_t(x)\\mid t\\leq0\\}', '\\mathcal O^-(x)=\\{\\Phi_t(x)\\mid t\\leq0\\}', 'Rückwärtsorbit eines Zustandes unter einem globalen Fluss.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(415, '3.463', 40, 'Trajektorie und Orbit sind verschiedene Objekte', '\\text{Trajektorie}\\neq\\text{Orbit}', '\\text{Trajektorie}\\neq\\text{Orbit}', 'Methodologische Ebenentrennung zwischen parametrisierter Kurve und ihrer Bildmenge.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(416, '3.464', 40, 'Orbitinvarianz', '\\Phi_s\\left(\\mathcal O(x)\\right)=\\mathcal O(x)', '\\Phi_s\\left(\\mathcal O(x)\\right)=\\mathcal O(x)', 'Ein globaler Orbit ist unter jeder Flussabbildung invariant.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(417, '3.465', 40, 'Verschiebung entlang eines Orbits', '\\Phi_s(\\Phi_t(x))=\\Phi_{s+t}(x)', '\\Phi_s(\\Phi_t(x))=\\Phi_{s+t}(x)', 'Das Flussgesetz verschiebt Zustände entlang desselben Orbits.', 'derived', 'literature', 75, NULL, NULL, 'verified', 18),
(418, '3.466', 40, 'Fixpunkt eines Flusses', '\\Phi_t(x_*)=x_*\\qquad\\text{für alle }t', '\\Phi_t(x_*)=x_*\\qquad\\text{für alle }t', 'Ein Fixpunkt bleibt unter allen Flussabbildungen unverändert.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(419, '3.467', 40, 'Gleichgewicht und Fixpunkt', 'f(x_*)=0\\Longleftrightarrow\\Phi_t(x_*)=x_*\\text{ für alle }t', 'f(x_*)=0\\Longleftrightarrow\\Phi_t(x_*)=x_*\\text{ für alle }t', 'Gleichgewicht des Vektorfeldes und Fixpunkt des Flusses sind äquivalent.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(420, '3.468', 40, 'Orbit eines Fixpunktes', '\\mathcal O(x_*)=\\{x_*\\}', '\\mathcal O(x_*)=\\{x_*\\}', 'Der Orbit eines Fixpunktes besteht nur aus diesem Zustand.', 'derived', 'literature', 75, NULL, NULL, 'verified', 18),
(421, '3.469', 40, 'Invariante Menge', '\\Phi_t(A)=A\\qquad\\text{für alle }t\\in\\mathbb R', '\\Phi_t(A)=A\\qquad\\text{für alle }t\\in\\mathbb R', 'Definition einer invariant bleibenden Menge unter einem globalen Fluss.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(422, '3.470', 40, 'Vorwärtsinvariante Menge', '\\Phi_t(A)\\subseteq A\\qquad\\text{für alle }t\\geq0', '\\Phi_t(A)\\subseteq A\\qquad\\text{für alle }t\\geq0', 'Definition einer vorwärtsinvarianten Menge unter einer vorwärts gerichteten Dynamik.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(423, '3.471', 40, 'Dynamische Invarianz ist keine physikalische Isolation', '\\text{dynamisch invariant}\\not\\Longrightarrow\\text{physikalisch isoliert}', '\\text{dynamisch invariant}\\not\\Longrightarrow\\text{physikalisch isoliert}', 'Methodologische Nichtimplikation zwischen mathematischer Invarianz und physikalischer Isolation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(424, '3.472', 40, 'Periodischer Zustand', '\\Phi_T(x)=x', '\\Phi_T(x)=x', 'Ein periodischer Zustand kehrt nach einem positiven Parameter T zu sich zurück.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(425, '3.473', 40, 'Periodische Trajektorie', '\\gamma_x(t+T)=\\gamma_x(t)\\qquad\\text{für alle }t', '\\gamma_x(t+T)=\\gamma_x(t)\\qquad\\text{für alle }t', 'Die Trajektorie eines periodischen Zustandes ist T-periodisch.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(426, '3.474', 40, 'Periodizität impliziert nicht Gleichgewicht', '\\text{periodisch}\\not\\Longrightarrow\\text{Gleichgewicht}', '\\text{periodisch}\\not\\Longrightarrow\\text{Gleichgewicht}', 'Ein periodischer Zustand muss kein Fixpunkt sein.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(427, '3.475', 40, 'Injektivität einer Flussabbildung', '\\Phi_t(x)=\\Phi_t(y)\\Longrightarrow x=y', '\\Phi_t(x)=\\Phi_t(y)\\Longrightarrow x=y', 'Globale Flussabbildungen sind aufgrund ihrer Invertierbarkeit injektiv.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(428, '3.476', 40, 'Rückgewinnung des Anfangszustandes', 'x=\\Phi_{-t}(\\Phi_t(x))=\\Phi_{-t}(\\Phi_t(y))=y', 'x=\\Phi_{-t}(\\Phi_t(x))=\\Phi_{-t}(\\Phi_t(y))=y', 'Anwendung der inversen Flussabbildung liefert die Eindeutigkeit der Herkunft.', 'derived', 'literature', 75, NULL, NULL, 'verified', 18),
(429, '3.477', 40, 'Mathematische Flussinverse', '\\Phi_t^{-1}=\\Phi_{-t}', '\\Phi_t^{-1}=\\Phi_{-t}', 'Inverse Zustandsabbildung eines globalen Flusses.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(430, '3.478', 40, 'Invertierbarer Fluss beweist nicht physikalische Reversibilität', '\\text{invertierbarer Fluss}\\not\\Longrightarrow\\text{physikalisch reversibler Prozess}', '\\text{invertierbarer Fluss}\\not\\Longrightarrow\\text{physikalisch reversibler Prozess}', 'Methodologische Nichtimplikation zwischen mathematischer Umkehrbarkeit und physikalischer Reversibilität.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(431, '3.479', 40, 'Lineares autonomes System', 'x\'(t)=Ax(t)', 'x\'(t)=Ax(t)', 'Lineares autonomes Differentialgleichungssystem.', 'model', 'literature', 75, NULL, NULL, 'verified', 18),
(432, '3.480', 40, 'Matrixexponentialfunktion', 'e^{tA}=\\sum_{k=0}^{\\infty}\\frac{t^kA^k}{k!}', 'e^{tA}=\\sum_{k=0}^{\\infty}\\frac{t^kA^k}{k!}', 'Definition der Matrix- beziehungsweise Operatorexponentialfunktion im endlichdimensionalen linearen System.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(433, '3.481', 40, 'Lösung des linearen autonomen Systems', 'x(t)=e^{tA}x_0', 'x(t)=e^{tA}x_0', 'Lösung des linearen autonomen Anfangswertproblems.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(434, '3.482', 40, 'Fluss des linearen autonomen Systems', '\\Phi_t=e^{tA}', '\\Phi_t=e^{tA}', 'Die Exponentialfunktion erzeugt den linearen Fluss.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(435, '3.483', 40, 'Exponentialgesetz', 'e^{(t+s)A}=e^{tA}e^{sA}', 'e^{(t+s)A}=e^{tA}e^{sA}', 'Die Matrixexponentialfunktion erfüllt das Flussgesetz.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(436, '3.484', 40, 'Inverse der Matrixexponentialfunktion', '\\left(e^{tA}\\right)^{-1}=e^{-tA}', '\\left(e^{tA}\\right)^{-1}=e^{-tA}', 'Die Exponentialfunktion mit negativem Parameter ist die Inverse.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(437, '3.485', 40, 'Eigenwertgleichung des Erzeugers', 'Av=\\lambda v', 'Av=\\lambda v', 'Eigenvektorbeziehung für den linearen Erzeuger A.', 'schema', 'literature', 75, NULL, NULL, 'verified', 18),
(438, '3.486', 40, 'Entwicklung einer Eigenrichtung', 'e^{tA}v=e^{t\\lambda}v', 'e^{tA}v=e^{t\\lambda}v', 'Eine Eigenrichtung wird unter dem linearen Fluss exponentiell skaliert.', 'derived', 'literature', 75, NULL, NULL, 'verified', 18),
(439, '3.487', 40, 'Normentwicklung einer Eigenrichtung', '\\|e^{tA}v\\|=e^{t\\operatorname{Re}\\lambda}\\|v\\|', '\\|e^{tA}v\\|=e^{t\\operatorname{Re}\\lambda}\\|v\\|', 'Der Realteil des Eigenwertes bestimmt bei komplexen Eigenwerten die exponentielle Normskalierung entlang der Eigenrichtung.', 'derived', 'literature', 75, NULL, NULL, 'verified', 18),
(440, '3.488', 40, 'Nichtautonomes System', 'x\'(t)=F(t,x(t))', 'x\'(t)=F(t,x(t))', 'Nichtautonome Zustandsentwicklung mit expliziter Parameterabhängigkeit.', 'model', 'literature', 75, NULL, NULL, 'verified', 18),
(441, '3.489', 40, 'Zweiparametriger Evolutionsoperator', 'U(t,s)x_s=x(t)', 'U(t,s)x_s=x(t)', 'U(t,s) bildet einen bei s gegebenen Zustand auf den bei t erreichten Zustand ab.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(442, '3.490', 40, 'Identität des Evolutionsoperators', 'U(s,s)=I', 'U(s,s)=I', 'Keine Entwicklung zwischen identischen Parameterwerten.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(443, '3.491', 40, 'Verkettung von Evolutionsoperatoren', 'U(t,s)\\circ U(s,r)=U(t,r)', 'U(t,s)\\circ U(s,r)=U(t,r)', 'Konsistenz der nichtautonomen Zustandsentwicklung.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(444, '3.492', 40, 'Autonomer Spezialfall des Evolutionsoperators', 'U(t,s)=\\Phi_{t-s}', 'U(t,s)=\\Phi_{t-s}', 'Bei autonomen Systemen hängt die Entwicklung nur von der Parameterdifferenz ab.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(445, '3.493', 40, 'Nichtautonome Entwicklung erzeugt nicht allgemein einen Einparameterfluss', '\\text{nichtautonome Zustandsentwicklung}\\not\\Longrightarrow\\text{Einparameterfluss auf dem ursprünglichen Zustandsraum}', '\\text{nichtautonome Zustandsentwicklung}\\not\\Longrightarrow\\text{Einparameterfluss auf dem ursprünglichen Zustandsraum}', 'Methodologische Grenze zwischen allgemeiner Evolution und autonomer Flussstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(446, '3.494', 40, 'Autonomisierung eines nichtautonomen Systems', '\\begin{cases}t\'=1,\\\\x\'=F(t,x).\\end{cases}', '\\begin{cases}t\'=1,\\\\x\'=F(t,x).\\end{cases}', 'Ein nichtautonomes System kann auf einem erweiterten Zustandsraum formal autonomisiert werden.', 'model', 'literature', 75, NULL, NULL, 'verified', 18),
(447, '3.495', 40, 'Erweiterter Zustandsraum', '\\widetilde M=\\mathbb R\\times M', '\\widetilde M=\\mathbb R\\times M', 'Der unabhängige Parameter wird als zusätzliche mathematische Zustandskomponente aufgenommen.', 'definition', 'literature', 75, NULL, NULL, 'verified', 18),
(448, '3.496', 40, 'Ebenen einer Zustandskurve', 't\\in I,\\qquad x(t)\\in M,\\qquad x\\in\\mathcal F(I,M)', 't\\in I,\\qquad x(t)\\in M,\\qquad x\\in\\mathcal F(I,M)', 'Unterscheidung zwischen Parameter, momentaner Zustandswert und vollständigem Zustandsverlauf.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(449, '3.497', 40, 'Flussabbildung als eigener Objekttyp', '\\Phi_t:M\\longrightarrow M', '\\Phi_t:M\\longrightarrow M', 'Eine Flussabbildung ist eine Transformation des Zustandsraumes und kein Zustand.', 'schema', 'literature', 75, NULL, NULL, 'verified', 18),
(450, '3.498', 40, 'Hierarchie Parameter, Flussabbildung und Zustand', 't\\longrightarrow\\Phi_t\\longrightarrow\\Phi_t(x_0)=x(t)', 't\\longrightarrow\\Phi_t\\longrightarrow\\Phi_t(x_0)=x(t)', 'Methodologische Ebenenhierarchie der mathematischen Zustandsentwicklung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(451, '3.499', 40, 'Transformationsparameter erhöht nicht die Zustandsdimension', '\\Phi_t:M\\to M\\not\\Longrightarrow\\dim M\\text{ erhöht sich um eine Dimension}', '\\Phi_t:M\\to M\\not\\Longrightarrow\\dim M\\text{ erhöht sich um eine Dimension}', 'Methodologische Nichtimplikation zwischen Parameterfamilie und Zustandsraumdimension.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(452, '3.500', 40, 'Diskrete Iteration', 'x_{n+1}=F(x_n)', 'x_{n+1}=F(x_n)', 'Diskrete Zustandsentwicklung durch wiederholte Anwendung einer Abbildung.', 'model', 'literature', 75, NULL, NULL, 'verified', 18),
(453, '3.501', 40, 'Iterationsindex ist nicht automatisch physikalische Zeit', 'n\\neq\\text{physikalische Zeit}', 'n\\neq\\text{physikalische Zeit}', 'Methodologische Trennung zwischen Iterationsindex und physikalischer Zeit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(454, '3.502', 40, 'Semifluss erzeugt nicht automatisch thermodynamischen Zeitpfeil', 't\\geq0\\text{ im Semifluss}\\not\\Longrightarrow\\text{thermodynamischer Zeitpfeil}', 't\\geq0\\text{ im Semifluss}\\not\\Longrightarrow\\text{thermodynamischer Zeitpfeil}', 'Methodologische Nichtimplikation zwischen Halbgruppenparameter und thermodynamischer Zeitrichtung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(455, '3.503', 40, 'Dynamikabhängigkeit der Invarianz', '\\Phi_t(A)=A\\qquad\\text{und zugleich}\\qquad\\Psi_s(A)\\neq A', '\\Phi_t(A)=A\\qquad\\text{und zugleich}\\qquad\\Psi_s(A)\\neq A', 'Eine Menge kann unter einer Dynamik invariant und unter einer anderen nicht invariant sein.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(456, '3.504', 40, 'Dynamisches System ist nicht automatisch physikalisches System', '\\text{dynamisches System}\\not\\Longrightarrow\\text{physikalisches System}', '\\text{dynamisches System}\\not\\Longrightarrow\\text{physikalisches System}', 'Methodologische Nichtimplikation zwischen mathematischer Dynamik und physikalischer Interpretation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(457, '3.505', 40, 'Flusseigenschaft als Kompositionsgesetz', '\\Phi_{t+s}=\\Phi_t\\circ\\Phi_s', '\\Phi_{t+s}=\\Phi_t\\circ\\Phi_s', 'Konsistenz der Zustandsabbildungen eines Flusses.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 18),
(458, '3.506', 40, 'Flusseigenschaft beweist keine physikalische Kausalität', '\\text{Flusseigenschaft}\\not\\Longrightarrow\\text{physikalische Kausalität}', '\\text{Flusseigenschaft}\\not\\Longrightarrow\\text{physikalische Kausalität}', 'Methodologische Nichtimplikation zwischen mathematischer Komposition und Ursache-Wirkungs-Beziehung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(459, '3.507', 40, 'Entwickelter Zustand', 'x(t)=\\Phi_t(x_0)\\in M', 'x(t)=\\Phi_t(x_0)\\in M', 'Ein Anfangszustand wird durch die Flussabbildung in einen Zustand desselben Zustandsraumes überführt.', 'model', 'literature', 75, NULL, NULL, 'verified', 18),
(460, '3.508', 40, 'Strukturkette von Differentialgleichung zu Orbit', '\\text{Differentialgleichung}\\longrightarrow\\text{Lösung}\\longrightarrow\\text{Fluss}\\longrightarrow\\text{Trajektorie}\\longrightarrow\\text{Orbit}', '\\text{Differentialgleichung}\\longrightarrow\\text{Lösung}\\longrightarrow\\text{Fluss}\\longrightarrow\\text{Trajektorie}\\longrightarrow\\text{Orbit}', 'Methodologische Synthese der dynamischen Begriffe.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(461, '3.509', 40, 'Didaktischer Aufbau des Flusses', '\\text{Anfangswertproblem}\\longrightarrow\\text{eindeutige Lösung}\\longrightarrow\\text{Zustandsabbildung}\\longrightarrow\\text{Fluss}', '\\text{Anfangswertproblem}\\longrightarrow\\text{eindeutige Lösung}\\longrightarrow\\text{Zustandsabbildung}\\longrightarrow\\text{Fluss}', 'Didaktischer Aufbau der Transformationsfamilie aus dem Anfangswertproblem.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(462, '3.510', 40, 'Didaktischer Aufbau vom Anfangszustand zum Orbit', '\\text{Anfangszustand}\\longrightarrow\\text{Trajektorie}\\longrightarrow\\text{Orbit}', '\\text{Anfangszustand}\\longrightarrow\\text{Trajektorie}\\longrightarrow\\text{Orbit}', 'Didaktische Ebenen des einzelnen Zustandsverlaufs.', 'schema', 'original', NULL, NULL, NULL, 'verified', 18),
(463, '3.511', 41, 'Autonomes System', '\\dot x=f(x)', '\\dot x=f(x)', 'Autonomes dynamisches System als Ausgangspunkt der Stabilitätsanalyse.', 'model', 'literature', 75, NULL, NULL, 'verified', 19),
(464, '3.512', 41, 'Gleichgewichtsbedingung', 'f(x_*)=0', 'f(x_*)=0', 'Ein Gleichgewicht ist eine Nullstelle des Vektorfeldes.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(465, '3.513', 41, 'Fixpunkteigenschaft des Gleichgewichts', '\\Phi_t(x_*)=x_*', '\\Phi_t(x_*)=x_*', 'Der Fluss lässt ein Gleichgewicht unverändert.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 19),
(466, '3.514', 41, 'Lyapunov-Stabilität', 'd(x_0,x_*)<\\delta\\Longrightarrow d(\\Phi_t(x_0),x_*)<\\varepsilon\\qquad\\text{für alle }t\\geq0', 'd(x_0,x_*)<\\delta\\Longrightarrow d(\\Phi_t(x_0),x_*)<\\varepsilon\\qquad\\text{für alle }t\\geq0', 'Metrische Definition der Lyapunov-Stabilität.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(467, '3.515', 41, 'Quantorenstruktur der Lyapunov-Stabilität', '\\forall\\varepsilon>0\\;\\exists\\delta>0\\;\\forall t\\geq0', '\\forall\\varepsilon>0\\;\\exists\\delta>0\\;\\forall t\\geq0', 'Die Reihenfolge der Quantoren ist Bestandteil des Stabilitätsbegriffs.', 'schema', 'literature', 75, NULL, NULL, 'verified', 19),
(468, '3.516', 41, 'Stabilität impliziert nicht Konvergenz', 'x_*\\text{ Lyapunov-stabil}\\not\\Longrightarrow\\Phi_t(x_0)\\longrightarrow x_*', 'x_*\\text{ Lyapunov-stabil}\\not\\Longrightarrow\\Phi_t(x_0)\\longrightarrow x_*', 'Methodologische Nichtimplikation zwischen Stabilität und Attraktivität.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(469, '3.517', 41, 'Lokale Anziehung', 'x_0\\in U\\Longrightarrow\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*', 'x_0\\in U\\Longrightarrow\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*', 'Lokale Attraktivität eines Gleichgewichts.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(470, '3.518', 41, 'Struktur asymptotischer Stabilität', '\\text{asymptotische Stabilität}=\\text{Lyapunov-Stabilität}+\\text{lokale Anziehung}', '\\text{asymptotische Stabilität}=\\text{Lyapunov-Stabilität}+\\text{lokale Anziehung}', 'Schematische Zusammenfassung der Definitionsbestandteile asymptotischer Stabilität.', 'schema', 'adapted', 75, NULL, NULL, 'verified', 19),
(471, '3.519', 41, 'Asymptotische Stabilität impliziert Stabilität', '\\text{asymptotisch stabil}\\Longrightarrow\\text{Lyapunov-stabil}', '\\text{asymptotisch stabil}\\Longrightarrow\\text{Lyapunov-stabil}', 'Unmittelbare Implikation aus der Definition asymptotischer Stabilität.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 19),
(472, '3.520', 41, 'Einzugsgebiet', '\\mathcal A(x_*)=\\left\\{x_0\\in X\\;\\middle|\\;\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*\\right\\}', '\\mathcal A(x_*)=\\left\\{x_0\\in X\\;\\middle|\\;\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*\\right\\}', 'Menge aller Anfangszustände, die gegen das Gleichgewicht konvergieren.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(473, '3.521', 41, 'Globale Anziehung', '\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*\\qquad\\text{für alle }x_0\\in X', '\\lim_{t\\to\\infty}\\Phi_t(x_0)=x_*\\qquad\\text{für alle }x_0\\in X', 'Konvergenz sämtlicher Zustände des festgelegten Zustandsraumes gegen das Gleichgewicht.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(474, '3.522', 41, 'Einzugsgebiet bei globaler asymptotischer Stabilität', '\\mathcal A(x_*)=X', '\\mathcal A(x_*)=X', 'Bei globaler asymptotischer Stabilität ist der gesamte Zustandsraum Einzugsgebiet.', 'derived', 'literature', 75, NULL, NULL, 'verified', 19),
(475, '3.523', 41, 'Exponentielle Stabilitätsabschätzung', '\\|\\Phi_t(x_0)-x_*\\|\\leq Ce^{-\\alpha t}\\|x_0-x_*\\|', '\\|\\Phi_t(x_0)-x_*\\|\\leq Ce^{-\\alpha t}\\|x_0-x_*\\|', 'Quantitative exponentielle Schranke für die Zustandsabweichung.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(476, '3.524', 41, 'Konvergenz aus exponentieller Stabilität', '\\Phi_t(x_0)\\longrightarrow x_*', '\\Phi_t(x_0)\\longrightarrow x_*', 'Die exponentielle Abklingrate erzwingt Konvergenz zum Gleichgewicht.', 'derived', 'literature', 75, NULL, NULL, 'verified', 19),
(477, '3.525', 41, 'Hierarchie der Stabilitätsbegriffe', '\\text{exponentiell stabil}\\Longrightarrow\\text{asymptotisch stabil}\\Longrightarrow\\text{Lyapunov-stabil}', '\\text{exponentiell stabil}\\Longrightarrow\\text{asymptotisch stabil}\\Longrightarrow\\text{Lyapunov-stabil}', 'Logische Implikationshierarchie der drei Stabilitätsbegriffe.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 19),
(478, '3.526', 41, 'Negation der Lyapunov-Stabilität', 'd(x_0,x_*)<\\delta\\qquad\\text{und}\\qquad d(\\Phi_t(x_0),x_*)\\geq\\varepsilon_0', 'd(x_0,x_*)<\\delta\\qquad\\text{und}\\qquad d(\\Phi_t(x_0),x_*)\\geq\\varepsilon_0', 'Charakterisierung von Instabilität durch beliebig kleine Anfangsstörungen mit späterer fester Abweichung.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(479, '3.527', 41, 'Gestörter Anfangszustand', '\\widetilde x_0=x_0+\\eta_0', '\\widetilde x_0=x_0+\\eta_0', 'Mathematische Darstellung einer Anfangsstörung.', 'model', 'original', NULL, NULL, NULL, 'verified', 19),
(480, '3.528', 41, 'Referenztrajektorie', 'x(t)=\\Phi_t(x_0)', 'x(t)=\\Phi_t(x_0)', 'Zustandsentwicklung des Referenzanfangszustandes.', 'model', 'literature', 75, NULL, NULL, 'verified', 19),
(481, '3.529', 41, 'Gestörte Trajektorie', '\\widetilde x(t)=\\Phi_t(x_0+\\eta_0)', '\\widetilde x(t)=\\Phi_t(x_0+\\eta_0)', 'Zustandsentwicklung des gestörten Anfangszustandes.', 'model', 'original', NULL, NULL, NULL, 'verified', 19),
(482, '3.530', 41, 'Trajektorienabweichung', '\\eta(t)=\\widetilde x(t)-x(t)', '\\eta(t)=\\widetilde x(t)-x(t)', 'Zeitabhängige Abweichung zweier Zustandsverläufe.', 'definition', 'original', NULL, NULL, NULL, 'verified', 19),
(483, '3.531', 41, 'Anfangsstörung ist nicht automatisch äußere physikalische Störung', '\\eta_0\\text{ mathematische Anfangsstörung}\\not\\Longrightarrow\\eta_0\\text{ äußere physikalische Störung}', '\\eta_0\\text{ mathematische Anfangsstörung}\\not\\Longrightarrow\\eta_0\\text{ äußere physikalische Störung}', 'Methodologische Nichtimplikation zwischen mathematischem Zustandsvergleich und äußerer Einwirkung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(484, '3.532', 41, 'Gestörte Dynamik', '\\dot x=f(x)+r(t,x)', '\\dot x=f(x)+r(t,x)', 'Mathematische Änderung des Entwicklungsgesetzes durch einen zusätzlichen Störungsterm.', 'model', 'original', NULL, NULL, NULL, 'verified', 19),
(485, '3.533', 41, 'Metrik aus einer Norm', 'd(x,y)=\\|x-y\\|', 'd(x,y)=\\|x-y\\|', 'Auf normierten Räumen induziert die Norm eine natürliche Metrik.', 'metric', 'literature', 75, NULL, NULL, 'verified', 19),
(486, '3.534', 41, 'Strukturabhängigkeit der Stabilität', '\\text{Stabilität}=\\text{Eigenschaft von Dynamik und gewählter Zustandsraumstruktur}', '\\text{Stabilität}=\\text{Eigenschaft von Dynamik und gewählter Zustandsraumstruktur}', 'Methodologische Zusammenfassung der Abhängigkeit des Stabilitätsbegriffs von Dynamik und Nähebegriff.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(487, '3.535', 41, 'Stabilität impliziert nicht FRZK-Kohärenz', '\\text{dynamische Stabilität}\\not\\Longrightarrow\\text{FRZK-Kohärenz}', '\\text{dynamische Stabilität}\\not\\Longrightarrow\\text{FRZK-Kohärenz}', 'Methodologische Nichtimplikation; Kohärenz muss unabhängig definiert werden.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(488, '3.536', 41, 'Nullwert positiver definitiver Funktion am Gleichgewicht', 'V(x_*)=0', 'V(x_*)=0', 'Erste Bedingung positiver Definitheit bezüglich eines Gleichgewichts.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(489, '3.537', 41, 'Positive Definitheit außerhalb des Gleichgewichts', 'V(x)>0\\qquad\\text{für alle }x\\in U\\setminus\\{x_*\\}', 'V(x)>0\\qquad\\text{für alle }x\\in U\\setminus\\{x_*\\}', 'Zweite Bedingung positiver Definitheit.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(490, '3.538', 41, 'Ableitung entlang des Vektorfeldes', '\\dot V(x)=DV(x)\\,f(x)', '\\dot V(x)=DV(x)\\,f(x)', 'Ableitung einer skalaren Funktion entlang des autonomen Vektorfeldes.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(491, '3.539', 41, 'Euklidische Darstellung der Lyapunov-Ableitung', '\\dot V(x)=\\nabla V(x)^{\\mathsf T}f(x)', '\\dot V(x)=\\nabla V(x)^{\\mathsf T}f(x)', 'Gradientendarstellung der Ableitung entlang des Vektorfeldes.', 'derived', 'literature', 75, NULL, NULL, 'verified', 19),
(492, '3.540', 41, 'Kettenregel entlang einer Trajektorie', '\\frac{d}{dt}V(x(t))=DV(x(t))\\,\\dot x(t)=DV(x(t))\\,f(x(t))', '\\frac{d}{dt}V(x(t))=DV(x(t))\\,\\dot x(t)=DV(x(t))\\,f(x(t))', 'Kettenregel für die Entwicklung einer Lyapunov-Funktion entlang einer Lösung.', 'derived', 'literature', 75, NULL, NULL, 'verified', 19),
(493, '3.541', 41, 'Nichtpositive Lyapunov-Ableitung', '\\dot V(x)\\leq0', '\\dot V(x)\\leq0', 'Bedingung für Nichtzunahme einer Lyapunov-Funktion.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(494, '3.542', 41, 'Monotonie entlang einer Trajektorie', 'V(x(t_2))\\leq V(x(t_1))', 'V(x(t_2))\\leq V(x(t_1))', 'Aus nichtpositiver Ableitung folgt Nichtzunahme für t2>=t1.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 19),
(495, '3.543', 41, 'Lyapunov-Bedingung für Stabilität', '\\dot V(x)\\leq0', '\\dot V(x)\\leq0', 'Nichtpositive Ableitung als Teil des direkten Lyapunov-Kriteriums.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 19),
(496, '3.544', 41, 'Schematisches Lyapunov-Stabilitätskriterium', 'V>0,\\qquad\\dot V\\leq0\\Longrightarrow\\text{Stabilität}', 'V>0,\\qquad\\dot V\\leq0\\Longrightarrow\\text{Stabilität}', 'Schematische Zusammenfassung der direkten Lyapunov-Methode unter den im Text genannten Voraussetzungen.', 'schema', 'adapted', 75, NULL, NULL, 'verified', 19),
(497, '3.545', 41, 'Strikt negative Lyapunov-Ableitung', '\\dot V(x)<0\\qquad\\text{für }x\\neq x_*', '\\dot V(x)<0\\qquad\\text{für }x\\neq x_*', 'Negative Definitheit der Lyapunov-Ableitung außerhalb des Gleichgewichts.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(498, '3.546', 41, 'Konvergenz unter strikter Lyapunov-Abnahme', 'x(t)\\longrightarrow x_*', 'x(t)\\longrightarrow x_*', 'Unter den Voraussetzungen des asymptotischen Lyapunov-Kriteriums konvergiert die Trajektorie zum Gleichgewicht.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 19),
(499, '3.547', 41, 'Nicht-Eindeutigkeit von Lyapunov-Funktionen', 'V_1\\neq V_2\\text{ ist möglich}', 'V_1\\neq V_2\\text{ ist möglich}', 'Für dasselbe dynamische System können verschiedene geeignete Lyapunov-Funktionen existieren; Identität ist nicht erforderlich.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(500, '3.548', 41, 'Lyapunov-Funktion ist nicht automatisch Energie', 'V\\text{ Lyapunov-Funktion}\\not\\Longrightarrow V\\text{ physikalische Energie}', 'V\\text{ Lyapunov-Funktion}\\not\\Longrightarrow V\\text{ physikalische Energie}', 'Methodologische Nichtimplikation zwischen analytischem Hilfsobjekt und physikalischer Energie.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(501, '3.549', 41, 'Abnahme einer Lyapunov-Funktion ist nicht automatisch Dissipation', '-\\dot V>0\\not\\Longrightarrow\\text{physikalische Dissipation}', '-\\dot V>0\\not\\Longrightarrow\\text{physikalische Dissipation}', 'Methodologische Nichtimplikation zwischen mathematischer Monotonie und physikalischer Dissipation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(502, '3.550', 41, 'Lyapunov-Funktion ist nicht automatisch Kohärenzmaß', 'V\\text{ Lyapunov-Funktion}\\not\\Longrightarrow V\\text{ Kohärenzmaß}', 'V\\text{ Lyapunov-Funktion}\\not\\Longrightarrow V\\text{ Kohärenzmaß}', 'Methodologische Nichtimplikation zwischen Lyapunov-Funktion und späterem FRZK-Kohärenzmaß.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(503, '3.551', 41, 'Nichtlineares autonomes System', '\\dot x=f(x)', '\\dot x=f(x)', 'Nichtlineares System für die lokale Linearisierung am Gleichgewicht.', 'model', 'literature', 75, NULL, NULL, 'verified', 19),
(504, '3.552', 41, 'Störungskoordinate um das Gleichgewicht', 'x=x_*+\\eta', 'x=x_*+\\eta', 'Lokale Darstellung eines Zustandes als Gleichgewicht plus Abweichung.', 'definition', 'adapted', 75, NULL, NULL, 'verified', 19),
(505, '3.553', 41, 'Lokale Entwicklung des Vektorfeldes', 'f(x_*+\\eta)=f(x_*)+Df(x_*)\\eta+r(\\eta)', 'f(x_*+\\eta)=f(x_*)+Df(x_*)\\eta+r(\\eta)', 'Erste lineare Approximation des Vektorfeldes mit Restterm.', 'derived', 'literature', 75, NULL, NULL, 'verified', 19),
(506, '3.554', 41, 'Störungsgleichung', '\\dot\\eta=A\\eta+r(\\eta),\\qquad A=Df(x_*)', '\\dot\\eta=A\\eta+r(\\eta),\\qquad A=Df(x_*)', 'Lokale Dynamik der Abweichung um das Gleichgewicht.', 'derived', 'literature', 75, NULL, NULL, 'verified', 19),
(507, '3.555', 41, 'Restbedingung der Linearisierung', '\\frac{\\|r(\\eta)\\|}{\\|\\eta\\|}\\longrightarrow0\\qquad(\\eta\\to0)', '\\frac{\\|r(\\eta)\\|}{\\|\\eta\\|}\\longrightarrow0\\qquad(\\eta\\to0)', 'Der Restterm ist gegenüber der linearen Störung von höherer Ordnung.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(508, '3.556', 41, 'Linearisiertes System', '\\dot\\eta=A\\eta', '\\dot\\eta=A\\eta', 'Lineare Hauptdynamik in der Umgebung des Gleichgewichts.', 'model', 'literature', 75, NULL, NULL, 'verified', 19),
(509, '3.557', 41, 'Lösung des linearisierten Systems', '\\eta(t)=e^{tA}\\eta_0', '\\eta(t)=e^{tA}\\eta_0', 'Zustandsentwicklung der linearen Störung durch die Exponentialfunktion.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 19),
(510, '3.558', 41, 'Entwicklung einer Eigenrichtung', 'e^{tA}v=e^{\\lambda t}v', 'e^{tA}v=e^{\\lambda t}v', 'Exponentielle Entwicklung entlang einer Eigenrichtung des linearen Erzeugers.', 'derived', 'literature', 75, NULL, NULL, 'verified', 19),
(511, '3.559', 41, 'Negative Realteile', '\\operatorname{Re}\\lambda<0', '\\operatorname{Re}\\lambda<0', 'Spektrale Bedingung für exponentielles Abklingen einer Eigenrichtung.', 'schema', 'literature', 75, NULL, NULL, 'verified', 19),
(512, '3.560', 41, 'Positiver Realteil', '\\operatorname{Re}\\lambda>0', '\\operatorname{Re}\\lambda>0', 'Spektrale Bedingung für exponentielles Anwachsen einer Eigenrichtung.', 'schema', 'literature', 75, NULL, NULL, 'verified', 19),
(513, '3.561', 41, 'Verschwindender Realteil', '\\operatorname{Re}\\lambda=0', '\\operatorname{Re}\\lambda=0', 'Spektraler Grenzfall der linearen Stabilitätsanalyse.', 'schema', 'literature', 75, NULL, NULL, 'verified', 19),
(514, '3.562', 41, 'Grenzfall entscheidet Stabilität nicht allgemein', '\\operatorname{Re}\\lambda=0\\not\\Longrightarrow\\text{Stabilität oder Instabilität eindeutig entschieden}', '\\operatorname{Re}\\lambda=0\\not\\Longrightarrow\\text{Stabilität oder Instabilität eindeutig entschieden}', 'Methodologische Grenze der Linearisierung bei Spektralwerten auf der imaginären Achse.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(515, '3.563', 41, 'Jacobi-Matrix der Linearisierung', 'A=Df(x_*)', 'A=Df(x_*)', 'Linearisierungsoperator am Gleichgewicht.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(516, '3.564', 41, 'Hyperbolizitätsbedingung', '\\sigma(A)\\cap i\\mathbb R=\\varnothing', '\\sigma(A)\\cap i\\mathbb R=\\varnothing', 'Ein hyperbolisches Gleichgewicht besitzt keine Eigenwerte mit Realteil null.', 'definition', 'literature', 75, NULL, NULL, 'verified', 19),
(517, '3.565', 41, 'Linearisierungskriterium für lokale asymptotische Stabilität', '\\max_{\\lambda\\in\\sigma(Df(x_*))}\\operatorname{Re}\\lambda<0\\Longrightarrow x_*\\text{ lokal asymptotisch stabil}', '\\max_{\\lambda\\in\\sigma(Df(x_*))}\\operatorname{Re}\\lambda<0\\Longrightarrow x_*\\text{ lokal asymptotisch stabil}', 'Negative Realteile aller Eigenwerte der Linearisierung liefern lokale asymptotische Stabilität.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 19),
(518, '3.566', 41, 'Positive Spektralrichtung und Instabilität', '\\exists\\lambda\\in\\sigma(Df(x_*)):\\operatorname{Re}\\lambda>0\\Longrightarrow x_*\\text{ instabil}', '\\exists\\lambda\\in\\sigma(Df(x_*)):\\operatorname{Re}\\lambda>0\\Longrightarrow x_*\\text{ instabil}', 'Ein Eigenwert mit positivem Realteil liefert lokale Instabilität.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 19),
(519, '3.567', 41, 'Lokale Stabilität impliziert nicht globale Stabilität', '\\text{lokal asymptotisch stabil}\\not\\Longrightarrow\\text{global asymptotisch stabil}', '\\text{lokal asymptotisch stabil}\\not\\Longrightarrow\\text{global asymptotisch stabil}', 'Methodologische Nichtimplikation zwischen lokaler und globaler Aussage.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(520, '3.568', 41, 'Stabiles Gleichgewicht impliziert nicht Stabilität aller Trajektorien', 'x_*\\text{ stabil}\\not\\Longrightarrow\\text{jede Trajektorie des Systems ist stabil}', 'x_*\\text{ stabil}\\not\\Longrightarrow\\text{jede Trajektorie des Systems ist stabil}', 'Stabilität ist an ein Referenzobjekt gebunden.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(521, '3.569', 41, 'Abstand zweier entwickelter Zustände', 'd_t(x_0,y_0)=d\\left(\\Phi_t(x_0),\\Phi_t(y_0)\\right)', 'd_t(x_0,y_0)=d\\left(\\Phi_t(x_0),\\Phi_t(y_0)\\right)', 'Zeitabhängiger Abstand zweier Trajektorien.', 'definition', 'original', NULL, NULL, NULL, 'verified', 19),
(522, '3.570', 41, 'Trajektoriensensitivität und Fixpunktinstabilität sind nicht identisch', '\\text{wachsende Trajektorienabweichung}\\not\\equiv\\text{Instabilität eines bestimmten Fixpunktes}', '\\text{wachsende Trajektorienabweichung}\\not\\equiv\\text{Instabilität eines bestimmten Fixpunktes}', 'Methodologische Trennung zweier Stabilitätsfragestellungen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(523, '3.571', 41, 'Vollständige Referenzstruktur einer Stabilitätsaussage', '\\text{Dynamik}+\\text{Referenzobjekt}+\\text{Zustandsraumstruktur}+\\text{Störungsbegriff}', '\\text{Dynamik}+\\text{Referenzobjekt}+\\text{Zustandsraumstruktur}+\\text{Störungsbegriff}', 'Stabilitätsaussagen benötigen eine vollständig spezifizierte Referenzstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(524, '3.572', 41, 'Stabilität gegenüber Anfangsdaten impliziert nicht Modellrobustheit', '\\text{Stabilität gegenüber Anfangsdaten}\\not\\Longrightarrow\\text{Robustheit gegenüber Modellstörungen}', '\\text{Stabilität gegenüber Anfangsdaten}\\not\\Longrightarrow\\text{Robustheit gegenüber Modellstörungen}', 'Methodologische Nichtimplikation zwischen zwei verschiedenen Störungsklassen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(525, '3.573', 41, 'Stabilität ist keine Erhaltung', '\\text{stabil}\\not\\Longrightarrow\\Phi_t(x_0)=x_0', '\\text{stabil}\\not\\Longrightarrow\\Phi_t(x_0)=x_0', 'Ein stabiler Zustand muss nicht stationär sein.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(526, '3.574', 41, 'Erhaltungsgröße', 'C(\\Phi_t(x))=C(x)', 'C(\\Phi_t(x))=C(x)', 'Eine Erhaltungsgröße bleibt entlang der betrachteten Zustandsentwicklung konstant.', 'definition', 'adapted', 75, NULL, NULL, 'verified', 19),
(527, '3.575', 41, 'Lyapunov-Monotonie', 'V(\\Phi_t(x))\\leq V(x)', 'V(\\Phi_t(x))\\leq V(x)', 'Eine Lyapunov-Funktion darf entlang der Dynamik abnehmen und unterscheidet sich daher von einer Erhaltungsgröße.', 'schema', 'literature', 75, NULL, NULL, 'verified', 19),
(528, '3.576', 41, 'Stabilitätsparameter erzeugt keine zusätzliche Zustandsdimension', '\\text{zusätzlicher Stabilitätsparameter}\\not\\Longrightarrow\\text{zusätzliche Zustandsdimension}', '\\text{zusätzlicher Stabilitätsparameter}\\not\\Longrightarrow\\text{zusätzliche Zustandsdimension}', 'Methodologische Nichtimplikation für Dimensionsargumente.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(529, '3.577', 41, 'Didaktische Reihenfolge der Stabilitätsbegriffe', '\\text{Stabilität}\\longrightarrow\\text{asymptotische Stabilität}\\longrightarrow\\text{exponentielle Stabilität}', '\\text{Stabilität}\\longrightarrow\\text{asymptotische Stabilität}\\longrightarrow\\text{exponentielle Stabilität}', 'Didaktische Aufbaufolge; nicht die logische Implikationsrichtung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(530, '3.578', 41, 'Logische Implikationsrichtung der Stabilitätsbegriffe', '\\text{exponentielle Stabilität}\\Longrightarrow\\text{asymptotische Stabilität}\\Longrightarrow\\text{Lyapunov-Stabilität}', '\\text{exponentielle Stabilität}\\Longrightarrow\\text{asymptotische Stabilität}\\Longrightarrow\\text{Lyapunov-Stabilität}', 'Logische Hierarchie der Stabilitätsbegriffe.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 19),
(531, '3.579', 41, 'Lyapunov-Analysekette', 'x\\longmapsto V(x)\\longmapsto\\dot V(x)', 'x\\longmapsto V(x)\\longmapsto\\dot V(x)', 'Didaktische Reduktion einer Zustandsentwicklung auf eine skalare Bewertungsfunktion und deren Ableitung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(532, '3.580', 41, 'Linearisierungs- und Spektralkette', '\\dot x=f(x)\\longrightarrow Df(x_*)\\longrightarrow\\sigma(Df(x_*))\\longrightarrow\\text{lokale Stabilitätsaussage}', '\\dot x=f(x)\\longrightarrow Df(x_*)\\longrightarrow\\sigma(Df(x_*))\\longrightarrow\\text{lokale Stabilitätsaussage}', 'Didaktische Verbindung von Differentialrechnung, Linearisierung, Spektrum und lokaler Stabilität.', 'schema', 'original', NULL, NULL, NULL, 'verified', 19),
(533, '3.581', 42, 'Folgencharakterisierung eines positiven Grenzpunktes', '\\Phi_{t_n}(x)\\longrightarrow y', '\\Phi_{t_n}(x)\\longrightarrow y', 'Ein positiver Grenzpunkt entsteht als Folgenlimit entlang t_n gegen plus unendlich.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(534, '3.582', 42, 'Positive Omega-Grenzmenge', '\\omega^+(x)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,t_n\\to+\\infty:\\Phi_{t_n}(x)\\to y\\right\\}', '\\omega^+(x)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,t_n\\to+\\infty:\\Phi_{t_n}(x)\\to y\\right\\}', 'Definition der positiven Omega-Grenzmenge.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(535, '3.583', 42, 'Negative Omega-Grenzmenge', '\\omega^-(x)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,t_n\\to-\\infty:\\Phi_{t_n}(x)\\to y\\right\\}', '\\omega^-(x)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,t_n\\to-\\infty:\\Phi_{t_n}(x)\\to y\\right\\}', 'Definition der negativen Omega-Grenzmenge.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(536, '3.584', 42, 'Konvergenz zu einem einzelnen Zustand', '\\lim_{t\\to\\infty}\\Phi_t(x)=x_*', '\\lim_{t\\to\\infty}\\Phi_t(x)=x_*', 'Spezialfall eines asymptotischen Zustandsverlaufs mit eindeutigem Punktgrenzwert.', 'schema', 'literature', 75, NULL, NULL, 'verified', 20),
(537, '3.585', 42, 'Grenzmenge bei Punktkonvergenz', '\\omega^+(x)=\\{x_*\\}', '\\omega^+(x)=\\{x_*\\}', 'Bei Konvergenz der gesamten positiven Trajektorie besteht die Grenzmenge nur aus dem Grenzzustand.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 20),
(538, '3.586', 42, 'Invarianz der Grenzmenge', '\\Phi_s\\left(\\omega^\\pm(x)\\right)=\\omega^\\pm(x)\\qquad\\text{für alle zulässigen }s', '\\Phi_s\\left(\\omega^\\pm(x)\\right)=\\omega^\\pm(x)\\qquad\\text{für alle zulässigen }s', 'Omega-Grenzmengen sind unter dem Fluss invariant.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 20),
(539, '3.587', 42, 'Punkt auf demselben Orbit', 'y=\\Phi_s(x)', 'y=\\Phi_s(x)', 'Zwei Zustände auf demselben Orbit unterscheiden sich durch eine Parametertranslation.', 'schema', 'literature', 75, NULL, NULL, 'verified', 20),
(540, '3.588', 42, 'Gleiche Grenzmenge auf demselben Orbit', '\\omega^\\pm(y)=\\omega^\\pm(x)', '\\omega^\\pm(y)=\\omega^\\pm(x)', 'Die Omega-Grenzmenge hängt vom Orbit und nicht vom gewählten Startpunkt auf diesem Orbit ab.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 20),
(541, '3.589', 42, 'Kompakte Orbitbeschränkung und Grenzmenge', '\\mathcal O^+(x)\\subseteq K,\\qquad K\\text{ kompakt}\\Longrightarrow\\omega^+(x)\\neq\\varnothing\\text{ und }\\omega^+(x)\\text{ kompakt}', '\\mathcal O^+(x)\\subseteq K,\\qquad K\\text{ kompakt}\\Longrightarrow\\omega^+(x)\\neq\\varnothing\\text{ und }\\omega^+(x)\\text{ kompakt}', 'Repository-korrigierte Notation: Verwendung des bereits definierten positiven Orbits O^+(x) statt einer nicht eingeführten gamma^+-Notation.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 20),
(542, '3.590', 42, 'Abstand eines Punktes von einer Menge', 'd(x,A)=\\inf_{a\\in A}d(x,a)', 'd(x,A)=\\inf_{a\\in A}d(x,a)', 'Metrischer Abstand eines Punktes von einer nichtleeren Menge.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(543, '3.591', 42, 'Norminduzierter Abstand zu einer Menge', 'd(x,A)=\\inf_{a\\in A}\\|x-a\\|', 'd(x,A)=\\inf_{a\\in A}\\|x-a\\|', 'Spezialfall in einem normierten Raum.', 'metric', 'literature', 75, NULL, NULL, 'verified', 20),
(544, '3.592', 42, 'Annäherung an die eigene positive Grenzmenge', '\\lim_{t\\to\\infty}d\\left(\\Phi_t(x),\\omega^+(x)\\right)=0', '\\lim_{t\\to\\infty}d\\left(\\Phi_t(x),\\omega^+(x)\\right)=0', 'Bei kompakter Orbitbeschränkung nähert sich die Trajektorie ihrer Grenzmenge im Mengenabstand an.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 20),
(545, '3.593', 42, 'Grenzmenge eines Gleichgewichts', '\\omega^+(x_*)=\\{x_*\\}', '\\omega^+(x_*)=\\{x_*\\}', 'Der Fixpunkt besitzt eine einelementige positive Grenzmenge.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 20),
(546, '3.594', 42, 'Grenzmenge eines periodischen Orbits', '\\omega^+(x)=\\mathcal O(x)', '\\omega^+(x)=\\mathcal O(x)', 'Bei periodischer Dynamik ist der vollständige periodische Orbit die positive Grenzmenge.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 20),
(547, '3.595', 42, 'Grenzmenge muss nicht einelementig sein', '\\omega^+(x)\\text{ ist nicht notwendig einelementig}', '\\omega^+(x)\\text{ ist nicht notwendig einelementig}', 'Grenzmengen können aus mehr als einem Zustand bestehen.', 'schema', 'adapted', 75, NULL, NULL, 'verified', 20),
(548, '3.596', 42, 'Positive Omega-Grenzmenge einer Menge', '\\omega^+(X)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,x_n\\in X,\\;t_n\\to+\\infty:\\Phi_{t_n}(x_n)\\to y\\right\\}', '\\omega^+(X)=\\left\\{y\\in M\\;\\middle|\\;\\exists\\,x_n\\in X,\\;t_n\\to+\\infty:\\Phi_{t_n}(x_n)\\to y\\right\\}', 'Mengenbezogene positive Omega-Grenzmenge.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(549, '3.597', 42, 'Punktweise Grenzmengen liegen in der Mengengrenzmenge', '\\bigcup_{x\\in X}\\omega^+(x)\\subseteq\\omega^+(X)', '\\bigcup_{x\\in X}\\omega^+(x)\\subseteq\\omega^+(X)', 'Die Vereinigung punktweiser Grenzmengen ist in der Grenzmenge der gesamten Anfangsmenge enthalten.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 20),
(550, '3.598', 42, 'Stabile Menge einer invarianten Menge', 'W^+(\\Lambda)=\\left\\{x\\in M\\;\\middle|\\;\\lim_{t\\to+\\infty}d(\\Phi_t(x),\\Lambda)=0\\right\\}', 'W^+(\\Lambda)=\\left\\{x\\in M\\;\\middle|\\;\\lim_{t\\to+\\infty}d(\\Phi_t(x),\\Lambda)=0\\right\\}', 'Definition der vorwärts stabilen Menge einer invarianten Menge.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(551, '3.599', 42, 'Rückwärts stabile Menge', 'W^-(\\Lambda)=\\left\\{x\\in M\\;\\middle|\\;\\lim_{t\\to-\\infty}d(\\Phi_t(x),\\Lambda)=0\\right\\}', 'W^-(\\Lambda)=\\left\\{x\\in M\\;\\middle|\\;\\lim_{t\\to-\\infty}d(\\Phi_t(x),\\Lambda)=0\\right\\}', 'Rückwärts gerichtete stabile Menge bei globalem Fluss.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(552, '3.600', 42, 'Anziehung einer invarianten Menge', 'd(\\Phi_t(x),\\Lambda)\\longrightarrow0\\qquad(t\\to\\infty)', 'd(\\Phi_t(x),\\Lambda)\\longrightarrow0\\qquad(t\\to\\infty)', 'Zustände einer geeigneten Umgebung nähern sich der invarianten Menge an.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(553, '3.601', 42, 'Einzugsgebiet einer anziehenden Menge', '\\mathcal B(\\Lambda)=W^+(\\Lambda)', '\\mathcal B(\\Lambda)=W^+(\\Lambda)', 'Das Einzugsgebiet wird mit der stabilen Menge der anziehenden Menge identifiziert.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(554, '3.602', 42, 'Kennzeichnung eines Zustandes im Einzugsgebiet', 'x\\in\\mathcal B(\\Lambda)\\Longrightarrow d(\\Phi_t(x),\\Lambda)\\to0', 'x\\in\\mathcal B(\\Lambda)\\Longrightarrow d(\\Phi_t(x),\\Lambda)\\to0', 'Zustände des Einzugsgebietes nähern sich asymptotisch der anziehenden Menge.', 'derived', 'literature', 75, NULL, NULL, 'verified', 20),
(555, '3.603', 42, 'Fanggebiet', '\\Phi_t(E)\\subseteq E\\qquad\\text{für alle }t>0', '\\Phi_t(E)\\subseteq E\\qquad\\text{für alle }t>0', 'Vorwärtsgerichtete Inklusion eines Fanggebietes.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(556, '3.604', 42, 'Anziehende Grenzmenge eines Fanggebietes', '\\Lambda=\\omega^+(E)', '\\Lambda=\\omega^+(E)', 'Definition der aus einem Fanggebiet erzeugten Grenzmenge.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(557, '3.605', 42, 'Schnittdarstellung der Fanggebiets-Grenzmenge', '\\Lambda=\\bigcap_{t\\geq0}\\overline{\\Phi_t(E)}', '\\Lambda=\\bigcap_{t\\geq0}\\overline{\\Phi_t(E)}', 'Die langfristige anziehende Menge entsteht als Schnitt der abgeschlossenen vorwärts entwickelten Fanggebiete.', 'theorem', 'literature', 75, NULL, NULL, 'verified', 20),
(558, '3.606', 42, 'Topologische Transitivität', '\\Phi_t(U)\\cap V\\neq\\varnothing', '\\Phi_t(U)\\cap V\\neq\\varnothing', 'Transitivitätsbedingung auf einer invarianten Menge.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(559, '3.607', 42, 'Attraktor als anziehende transitive Menge', '\\text{Attraktor}=\\text{anziehende Menge}+\\text{topologische Transitivität}', '\\text{Attraktor}=\\text{anziehende Menge}+\\text{topologische Transitivität}', 'Schematische Zusammenfassung des im Abschnitt verwendeten Attraktorbegriffs.', 'definition', 'adapted', 75, NULL, NULL, 'verified', 20),
(560, '3.608', 42, 'Attraktor ist nicht notwendig Fixpunkt', '\\text{Attraktor}\\not\\Longrightarrow\\text{Fixpunkt}', '\\text{Attraktor}\\not\\Longrightarrow\\text{Fixpunkt}', 'Methodologische Nichtimplikation zwischen Attraktor und Gleichgewicht.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(561, '3.609', 42, 'Periodischer Orbit als mögliche Attraktorstruktur', '\\Lambda=\\mathcal O(x)', '\\Lambda=\\mathcal O(x)', 'Ein periodischer Orbit kann als anziehende transitive invariante Menge einen Attraktor bilden.', 'model', 'literature', 75, NULL, NULL, 'verified', 20),
(562, '3.610', 42, 'Annäherung an eine invariante Menge', 'd(\\Phi_t(x),\\Lambda)\\longrightarrow0', 'd(\\Phi_t(x),\\Lambda)\\longrightarrow0', 'Asymptotische Mengenannäherung.', 'schema', 'literature', 75, NULL, NULL, 'verified', 20),
(563, '3.611', 42, 'Mengenannäherung impliziert nicht Punktkonvergenz', 'd(\\Phi_t(x),\\Lambda)\\to0\\not\\Longrightarrow\\exists\\,y\\in\\Lambda:\\Phi_t(x)\\to y', 'd(\\Phi_t(x),\\Lambda)\\to0\\not\\Longrightarrow\\exists\\,y\\in\\Lambda:\\Phi_t(x)\\to y', 'Methodologische Nichtimplikation zwischen Mengenannäherung und Konvergenz gegen einen einzelnen Zustand.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(564, '3.612', 42, 'Asymptotische Annäherung impliziert keine endliche Erreichung', 'd(\\Phi_t(x),\\Lambda)\\longrightarrow0\\not\\Longrightarrow\\exists\\,T<\\infty:\\Phi_T(x)\\in\\Lambda', 'd(\\Phi_t(x),\\Lambda)\\longrightarrow0\\not\\Longrightarrow\\exists\\,T<\\infty:\\Phi_T(x)\\in\\Lambda', 'Methodologische Nichtimplikation zwischen asymptotischer Annäherung und Eintritt in endlicher Parameterzeit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(565, '3.613', 42, 'Attraktor verursacht die Dynamik nicht', '\\Lambda\\text{ Attraktor}\\not\\Longrightarrow\\Lambda\\text{ verursacht die Zustandsentwicklung}', '\\Lambda\\text{ Attraktor}\\not\\Longrightarrow\\Lambda\\text{ verursacht die Zustandsentwicklung}', 'Methodologische Nichtimplikation zwischen asymptotischer Struktur und Ursache.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(566, '3.614', 42, 'Attraktor ist kein teleologischer Zielzustand', '\\text{Attraktor}\\not\\Longrightarrow\\text{teleologischer Zielzustand}', '\\text{Attraktor}\\not\\Longrightarrow\\text{teleologischer Zielzustand}', 'Methodologische Nichtimplikation zwischen Attraktion und Zielgerichtetheit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(567, '3.615', 42, 'Rand eines Einzugsgebietes', '\\partial\\mathcal B(\\Lambda)', '\\partial\\mathcal B(\\Lambda)', 'Topologischer Rand des Einzugsgebietes im Zustandsraum.', 'schema', 'literature', 75, NULL, NULL, 'verified', 20),
(568, '3.616', 42, 'Einzugsgebietsrand ist nicht automatisch physikalische Systemgrenze', '\\partial\\mathcal B(\\Lambda)\\text{ dynamische Grenzstruktur}\\not\\Longrightarrow\\text{physikalische Systemgrenze}', '\\partial\\mathcal B(\\Lambda)\\text{ dynamische Grenzstruktur}\\not\\Longrightarrow\\text{physikalische Systemgrenze}', 'Methodologische Nichtimplikation zwischen dynamisch-topologischem Rand und physikalischer Grenze.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(569, '3.617', 42, 'Änderung der Zustandsraum- und Dynamikstruktur', '(X,d,\\Phi)\\longrightarrow(\\widetilde X,\\widetilde d,\\widetilde\\Phi)', '(X,d,\\Phi)\\longrightarrow(\\widetilde X,\\widetilde d,\\widetilde\\Phi)', 'Modelländerung von Zustandsraum, Metrik und Dynamik.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(570, '3.618', 42, 'Strukturabhängigkeit eines Attraktors', '\\text{Attraktor}=\\text{strukturabhängiges mathematisches Objekt}', '\\text{Attraktor}=\\text{strukturabhängiges mathematisches Objekt}', 'Ein Attraktor ist relativ zur festgelegten Zustandsraum- und Dynamikstruktur definiert.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(571, '3.619', 42, 'Attraktion impliziert nicht FRZK-Kohärenzzunahme', 'd(\\Phi_t(x),\\Lambda)\\longrightarrow0\\not\\Longrightarrow\\text{FRZK-Kohärenz nimmt zu}', 'd(\\Phi_t(x),\\Lambda)\\longrightarrow0\\not\\Longrightarrow\\text{FRZK-Kohärenz nimmt zu}', 'Methodologische Nichtimplikation zwischen asymptotischer Annäherung und später zu definierender Kohärenz.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(572, '3.620', 42, 'Attraktor als Teilmenge des Zustandsraumes', '\\Lambda\\subseteq X', '\\Lambda\\subseteq X', 'Ein Attraktor liegt als Teilmenge im zugrunde liegenden Zustandsraum.', 'schema', 'literature', 75, NULL, NULL, 'verified', 20),
(573, '3.621', 42, 'Attraktorkennzahl erzeugt keine zusätzliche Zustandsdimension', '\\text{zusätzliche Attraktorkennzahl}\\not\\Longrightarrow\\text{zusätzliche Zustandsdimension}', '\\text{zusätzliche Attraktorkennzahl}\\not\\Longrightarrow\\text{zusätzliche Zustandsdimension}', 'Methodologische Nichtimplikation für Dimensionsargumente.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(574, '3.622', 42, 'Zuordnung eines Zustandes zu seiner Grenzmenge', 'x\\longmapsto\\omega^+(x)', 'x\\longmapsto\\omega^+(x)', 'Die asymptotische Grenzstruktur kann einem Zustand beziehungsweise Orbit zugeordnet werden.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(575, '3.623', 42, 'Grenzmengenzuordnung erzeugt keine neue Basisrichtung', 'x\\longmapsto\\omega^+(x)\\not\\Longrightarrow\\text{neue Basisrichtung von }X', 'x\\longmapsto\\omega^+(x)\\not\\Longrightarrow\\text{neue Basisrichtung von }X', 'Repository-korrigierte formale Nichtimplikation: Die Zuordnung zu einer Grenzmenge erweitert den Zustandsraum nicht automatisch um eine neue Basisrichtung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(576, '3.624', 42, 'Positiver Orbit', '\\mathcal O^+(x)=\\{\\Phi_t(x)\\mid t\\geq0\\}', '\\mathcal O^+(x)=\\{\\Phi_t(x)\\mid t\\geq0\\}', 'Positiver Orbit als Ausgangsmenge der asymptotischen Betrachtung.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(577, '3.625', 42, 'Einzugsgebiet als stabile Menge', '\\mathcal B(\\Lambda)=W^+(\\Lambda)', '\\mathcal B(\\Lambda)=W^+(\\Lambda)', 'Einzugsgebiet und stabile Menge einer anziehenden Menge.', 'definition', 'literature', 75, NULL, NULL, 'verified', 20),
(578, '3.626', 42, 'Asymptotische Annäherung aus dem Einzugsgebiet', 'x\\in\\mathcal B(\\Lambda)\\Longrightarrow d(\\Phi_t(x),\\Lambda)\\to0', 'x\\in\\mathcal B(\\Lambda)\\Longrightarrow d(\\Phi_t(x),\\Lambda)\\to0', 'Kennzeichnende Eigenschaft von Zuständen im Einzugsgebiet.', 'derived', 'literature', 75, NULL, NULL, 'verified', 20),
(579, '3.627', 42, 'Didaktische Kette der asymptotischen Begriffe', '\\text{Trajektorie}\\longrightarrow\\text{Orbit}\\longrightarrow\\omega\\text{-Grenzmenge}\\longrightarrow\\text{anziehende Menge}\\longrightarrow\\text{Attraktor}', '\\text{Trajektorie}\\longrightarrow\\text{Orbit}\\longrightarrow\\omega\\text{-Grenzmenge}\\longrightarrow\\text{anziehende Menge}\\longrightarrow\\text{Attraktor}', 'Didaktische Aufbaufolge der asymptotischen Dynamik.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(580, '3.628', 42, 'Didaktische Kette von Umgebung zu asymptotischer Annäherung', '\\text{Umgebung}\\longrightarrow\\text{Einzugsgebiet}\\longrightarrow\\text{asymptotische Annäherung}', '\\text{Umgebung}\\longrightarrow\\text{Einzugsgebiet}\\longrightarrow\\text{asymptotische Annäherung}', 'Didaktische Struktur der Anfangszustandsseite.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(581, '3.629', 42, 'Fanggebiet erzeugt seine Grenzmenge', 'E\\longrightarrow\\omega^+(E)=\\Lambda', 'E\\longrightarrow\\omega^+(E)=\\Lambda', 'Didaktische Verbindung zwischen Fanggebiet und anziehender Grenzmenge.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(582, '3.630', 42, 'Strukturkette von Ableitung bis Grenzstruktur', '\\text{Ableitung}\\longrightarrow\\text{Differentialgleichung}\\longrightarrow\\text{Fluss}\\longrightarrow\\text{Stabilität}\\longrightarrow\\text{Grenzstruktur}', '\\text{Ableitung}\\longrightarrow\\text{Differentialgleichung}\\longrightarrow\\text{Fluss}\\longrightarrow\\text{Stabilität}\\longrightarrow\\text{Grenzstruktur}', 'Zusammenfassende Struktur der Abschnitte 3.2.15 bis 3.2.19.', 'schema', 'original', NULL, NULL, NULL, 'verified', 20),
(583, '3.631', 43, 'Lokale euklidische Karte', '\\varphi:U\\longrightarrow\\widehat U\\subseteq\\mathbb R^n', '\\varphi:U\\longrightarrow\\widehat U\\subseteq\\mathbb R^n', 'Lokale Homöomorphie einer topologischen n-Mannigfaltigkeit mit einer offenen Teilmenge von R^n.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(584, '3.632', 43, 'Lokale Koordinaten eines Punktes', '\\varphi(p)=\\bigl(x^1(p),\\ldots,x^n(p)\\bigr)', '\\varphi(p)=\\bigl(x^1(p),\\ldots,x^n(p)\\bigr)', 'Koordinatendarstellung eines Punktes in einer Karte.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(585, '3.633', 43, 'Kartenwechsel', '\\psi\\circ\\varphi^{-1}:\\varphi(U\\cap V)\\longrightarrow\\psi(U\\cap V)', '\\psi\\circ\\varphi^{-1}:\\varphi(U\\cap V)\\longrightarrow\\psi(U\\cap V)', 'Übergang zwischen zwei überlappenden lokalen Koordinatendarstellungen.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(586, '3.634', 43, 'Überdeckung durch einen Atlas', 'M=\\bigcup_{(U,\\varphi)\\in\\mathcal A}U', 'M=\\bigcup_{(U,\\varphi)\\in\\mathcal A}U', 'Die Kartenbereiche eines Atlas überdecken die gesamte Mannigfaltigkeit.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(587, '3.635', 43, 'Mannigfaltigkeit mit glatter Struktur', '(M,\\mathcal A)', '(M,\\mathcal A)', 'Schematische Darstellung einer Mannigfaltigkeit mit ihrem glatten Atlas.', 'schema', 'literature', 77, NULL, NULL, 'verified', 21),
(588, '3.636', 43, 'Glatte Mannigfaltigkeit impliziert nicht Vektorraum', '\\text{glatte Mannigfaltigkeit}\\not\\Longrightarrow\\text{Vektorraum}', '\\text{glatte Mannigfaltigkeit}\\not\\Longrightarrow\\text{Vektorraum}', 'Methodologische Nichtimplikation zwischen lokaler euklidischer Struktur und globaler Vektorraumstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(589, '3.637', 43, 'Lokale Darstellung einer glatten Abbildung', '\\widehat F=\\psi\\circ F\\circ\\varphi^{-1}', '\\widehat F=\\psi\\circ F\\circ\\varphi^{-1}', 'Lokale Koordinatendarstellung einer Mannigfaltigkeitsabbildung.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(590, '3.638', 43, 'Verkettung glatter Abbildungen', 'G\\circ F:M\\longrightarrow P', 'G\\circ F:M\\longrightarrow P', 'Die Komposition glatter Mannigfaltigkeitsabbildungen ist glatt.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(591, '3.639', 43, 'Lokale Euklidizität', 'U\\cong\\widehat U\\subseteq\\mathbb R^n', 'U\\cong\\widehat U\\subseteq\\mathbb R^n', 'Schematische Darstellung der lokalen euklidischen Struktur einer Mannigfaltigkeit.', 'schema', 'adapted', 77, NULL, NULL, 'verified', 21),
(592, '3.640', 43, 'Tangentialvektor als lineares Funktional auf glatten Funktionen', 'v:C^\\infty(M)\\longrightarrow\\mathbb R', 'v:C^\\infty(M)\\longrightarrow\\mathbb R', 'Ein Tangentialvektor am Punkt p wirkt als Derivation auf glatten Funktionen.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(593, '3.641', 43, 'Leibniz-Regel einer Derivation', 'v(fg)=f(p)\\,v(g)+g(p)\\,v(f)', 'v(fg)=f(p)\\,v(g)+g(p)\\,v(f)', 'Leibniz-Eigenschaft eines Tangentialvektors am Punkt p.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(594, '3.642', 43, 'Tangentialraum', 'T_pM=\\{v\\mid v\\text{ ist Tangentialvektor an }M\\text{ in }p\\}', 'T_pM=\\{v\\mid v\\text{ ist Tangentialvektor an }M\\text{ in }p\\}', 'Menge aller Tangentialvektoren im Punkt p.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(595, '3.643', 43, 'Koordinatenbasis als Ableitungsoperator', '\\left.\\frac{\\partial}{\\partial x^i}\\right|_p(f)=\\left.\\frac{\\partial(f\\circ\\varphi^{-1})}{\\partial x^i}\\right|_{\\varphi(p)}', '\\left.\\frac{\\partial}{\\partial x^i}\\right|_p(f)=\\left.\\frac{\\partial(f\\circ\\varphi^{-1})}{\\partial x^i}\\right|_{\\varphi(p)}', 'Koordinatenbasisvektor des Tangentialraumes in lokalen Koordinaten.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(596, '3.644', 43, 'Dimension des Tangentialraumes', '\\dim T_pM=n\\qquad\\text{für jedes }p\\in M', '\\dim T_pM=n\\qquad\\text{für jedes }p\\in M', 'Tangentialräume einer n-Mannigfaltigkeit sind n-dimensional.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(597, '3.645', 43, 'Koordinatenbasis des Tangentialraumes', '\\left\\{\\left.\\frac{\\partial}{\\partial x^1}\\right|_p,\\ldots,\\left.\\frac{\\partial}{\\partial x^n}\\right|_p\\right\\}', '\\left\\{\\left.\\frac{\\partial}{\\partial x^1}\\right|_p,\\ldots,\\left.\\frac{\\partial}{\\partial x^n}\\right|_p\\right\\}', 'Durch eine Karte induzierte Basis des Tangentialraumes.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(598, '3.646', 43, 'Komponentendarstellung eines Tangentialvektors', 'v=\\sum_{i=1}^{n}v^i\\left.\\frac{\\partial}{\\partial x^i}\\right|_p', 'v=\\sum_{i=1}^{n}v^i\\left.\\frac{\\partial}{\\partial x^i}\\right|_p', 'Eindeutige Darstellung eines Tangentialvektors in der lokalen Koordinatenbasis.', 'schema', 'literature', 77, NULL, NULL, 'verified', 21),
(599, '3.647', 43, 'Transformation der Koordinatenbasis', '\\left.\\frac{\\partial}{\\partial x^i}\\right|_p=\\sum_{j=1}^{n}\\left.\\frac{\\partial y^j}{\\partial x^i}\\right|_p\\left.\\frac{\\partial}{\\partial y^j}\\right|_p', '\\left.\\frac{\\partial}{\\partial x^i}\\right|_p=\\sum_{j=1}^{n}\\left.\\frac{\\partial y^j}{\\partial x^i}\\right|_p\\left.\\frac{\\partial}{\\partial y^j}\\right|_p', 'Transformationsregel der Tangentialbasis unter Koordinatenwechsel.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(600, '3.648', 43, 'Keine kanonische Identifikation verschiedener Tangentialräume', 'T_pM\\not\\cong_{\\mathrm{kanonisch}}T_qM\\qquad(p\\neq q)', 'T_pM\\not\\cong_{\\mathrm{kanonisch}}T_qM\\qquad(p\\neq q)', 'Ohne zusätzliche Struktur besteht im Allgemeinen keine ausgezeichnete natürliche Identifikation der Tangentialräume verschiedener Punkte.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(601, '3.649', 43, 'Kurve auf einer Mannigfaltigkeit', '\\gamma:I\\longrightarrow M', '\\gamma:I\\longrightarrow M', 'Parametrisierte Kurve auf einer Mannigfaltigkeit.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(602, '3.650', 43, 'Tangentialvektor einer Kurve', '\\gamma\'(t_0)(f)=\\left.\\frac{d}{dt}(f\\circ\\gamma)(t)\\right|_{t=t_0}', '\\gamma\'(t_0)(f)=\\left.\\frac{d}{dt}(f\\circ\\gamma)(t)\\right|_{t=t_0}', 'Definition des Kurventangentialvektors als Derivation.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(603, '3.651', 43, 'Kurventangentialvektor liegt im Tangentialraum', '\\gamma\'(t_0)\\in T_{\\gamma(t_0)}M', '\\gamma\'(t_0)\\in T_{\\gamma(t_0)}M', 'Zuordnung des Kurventangentialvektors zum Tangentialraum des Kurvenpunktes.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(604, '3.652', 43, 'Koordinatendarstellung des Kurventangentialvektors', '\\gamma\'(t)=\\sum_{i=1}^{n}\\frac{d(x^i\\circ\\gamma)}{dt}\\left.\\frac{\\partial}{\\partial x^i}\\right|_{\\gamma(t)}', '\\gamma\'(t)=\\sum_{i=1}^{n}\\frac{d(x^i\\circ\\gamma)}{dt}\\left.\\frac{\\partial}{\\partial x^i}\\right|_{\\gamma(t)}', 'Lokale Koordinatendarstellung des Tangentialvektors einer Kurve.', 'derived', 'literature', 77, NULL, NULL, 'verified', 21),
(605, '3.653', 43, 'Tangentialvektor ist nicht automatisch physikalische Geschwindigkeit', '\\gamma\'(t)\\text{ Tangentialvektor}\\not\\Longrightarrow\\gamma\'(t)\\text{ physikalische Geschwindigkeit}', '\\gamma\'(t)\\text{ Tangentialvektor}\\not\\Longrightarrow\\gamma\'(t)\\text{ physikalische Geschwindigkeit}', 'Methodologische Nichtimplikation ohne physikalische Interpretation von Kurve und Parameter.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(606, '3.654', 43, 'Differential einer glatten Abbildung', 'dF_p:T_pM\\longrightarrow T_{F(p)}N', 'dF_p:T_pM\\longrightarrow T_{F(p)}N', 'Pushforward zwischen den Tangentialräumen von Ausgangs- und Zielmannigfaltigkeit.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(607, '3.655', 43, 'Wirkung des Differentials auf Funktionen', '(dF_pv)(g)=v(g\\circ F)', '(dF_pv)(g)=v(g\\circ F)', 'Definition des Pushforwards mittels Derivationen.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(608, '3.656', 43, 'Linearität des Differentials', 'dF_p(\\alpha v+\\beta w)=\\alpha\\,dF_p(v)+\\beta\\,dF_p(w)', 'dF_p(\\alpha v+\\beta w)=\\alpha\\,dF_p(v)+\\beta\\,dF_p(w)', 'Das Differential ist eine lineare Abbildung zwischen Tangentialräumen.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(609, '3.657', 43, 'Kettenregel auf Mannigfaltigkeiten', 'd(G\\circ F)_p=dG_{F(p)}\\circ dF_p', 'd(G\\circ F)_p=dG_{F(p)}\\circ dF_p', 'Kettenregel für Differentiale glatter Mannigfaltigkeitsabbildungen.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(610, '3.658', 43, 'Differential der Identität', 'd(I_M)_p=I_{T_pM}', 'd(I_M)_p=I_{T_pM}', 'Das Differential der Identitätsabbildung ist die Identität des Tangentialraumes.', 'derived', 'literature', 77, NULL, NULL, 'verified', 21),
(611, '3.659', 43, 'Differential des inversen Diffeomorphismus', 'd(F^{-1})_{F(p)}=(dF_p)^{-1}', 'd(F^{-1})_{F(p)}=(dF_p)^{-1}', 'Das Differential eines Diffeomorphismus ist punktweise ein Vektorraumisomorphismus.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(612, '3.660', 43, 'Lokale Komponenten einer Mannigfaltigkeitsabbildung', 'F^a=y^a\\circ F', 'F^a=y^a\\circ F', 'Komponenten einer glatten Abbildung in Zielkoordinaten.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(613, '3.661', 43, 'Koordinatenwirkung des Differentials', 'dF_p\\left(\\left.\\frac{\\partial}{\\partial x^i}\\right|_p\\right)=\\sum_{a=1}^{m}\\frac{\\partial F^a}{\\partial x^i}(p)\\left.\\frac{\\partial}{\\partial y^a}\\right|_{F(p)}', 'dF_p\\left(\\left.\\frac{\\partial}{\\partial x^i}\\right|_p\\right)=\\sum_{a=1}^{m}\\frac{\\partial F^a}{\\partial x^i}(p)\\left.\\frac{\\partial}{\\partial y^a}\\right|_{F(p)}', 'Wirkung des Differentials auf einen Koordinatenbasisvektor.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(614, '3.662', 43, 'Jacobi-Matrix als Darstellung des Differentials', '[dF_p]=\\left(\\frac{\\partial F^a}{\\partial x^i}(p)\\right)', '[dF_p]=\\left(\\frac{\\partial F^a}{\\partial x^i}(p)\\right)', 'Matrixdarstellung des abstrakten Differentials in lokalen Koordinaten.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(615, '3.663', 43, 'Tangentialbündel', 'TM=\\bigsqcup_{p\\in M}T_pM', 'TM=\\bigsqcup_{p\\in M}T_pM', 'Disjunkte Vereinigung sämtlicher Tangentialräume einer Mannigfaltigkeit.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(616, '3.664', 43, 'Bündelprojektion', '\\pi:TM\\longrightarrow M,\\qquad\\pi(p,v)=p', '\\pi:TM\\longrightarrow M,\\qquad\\pi(p,v)=p', 'Natürliche Projektion des Tangentialbündels auf seinen Basispunkt.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(617, '3.665', 43, 'Dimension des Tangentialbündels', '\\dim TM=2n', '\\dim TM=2n', 'Das Tangentialbündel einer glatten n-Mannigfaltigkeit ist 2n-dimensional.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(618, '3.666', 43, 'Typen von Punkt und Tangentialvektor', 'p\\in M,\\qquad v\\in T_pM', 'p\\in M,\\qquad v\\in T_pM', 'Punkt und Tangentialvektor gehören zu unterschiedlichen mathematischen Objekttypen.', 'schema', 'adapted', 77, NULL, NULL, 'verified', 21),
(619, '3.667', 43, 'Punkt plus Tangentialvektor ist nicht allgemein definiert', 'p\\in M,\\;v\\in T_pM\\not\\Longrightarrow p+v\\in M', 'p\\in M,\\;v\\in T_pM\\not\\Longrightarrow p+v\\in M', 'Methodologische Nichtimplikation zur Vermeidung unzulässiger globaler Vektorraumoperationen auf Mannigfaltigkeiten.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(620, '3.668', 43, 'Glatte Mannigfaltigkeit besitzt keine kanonische Metrik', '\\text{glatte Mannigfaltigkeit}\\not\\Longrightarrow\\text{kanonische Metrik}', '\\text{glatte Mannigfaltigkeit}\\not\\Longrightarrow\\text{kanonische Metrik}', 'Eine glatte Struktur allein legt keine Längen- oder Winkelmessung fest.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(621, '3.669', 43, 'Tangentialraum besitzt kein kanonisches Skalarprodukt', '\\text{Tangentialraum}\\not\\Longrightarrow\\text{kanonisches Skalarprodukt}', '\\text{Tangentialraum}\\not\\Longrightarrow\\text{kanonisches Skalarprodukt}', 'Ein Tangentialraum erhält nicht allein aus der Mannigfaltigkeitsstruktur ein ausgezeichnetes Skalarprodukt.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(622, '3.670', 43, 'Lokale Koordinaten sind nicht automatisch physikalisch bevorzugt', '\\text{lokale Koordinaten}\\not\\Longrightarrow\\text{physikalisch bevorzugte Koordinaten}', '\\text{lokale Koordinaten}\\not\\Longrightarrow\\text{physikalisch bevorzugte Koordinaten}', 'Methodologische Nichtimplikation zwischen Kartenwahl und physikalischer Auszeichnung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(623, '3.671', 43, 'Kartenende ist nicht Mannigfaltigkeitsende', '\\text{Karte endet}\\not\\Longrightarrow\\text{Mannigfaltigkeit endet}', '\\text{Karte endet}\\not\\Longrightarrow\\text{Mannigfaltigkeit endet}', 'Das Ende eines Kartenbereichs muss keine globale Grenze der Mannigfaltigkeit sein.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(624, '3.672', 43, 'Koordinatensingularität ist nicht automatisch geometrische Singularität', '\\text{Koordinatendarstellung singulär}\\not\\Longrightarrow\\text{geometrische Singularität}', '\\text{Koordinatendarstellung singulär}\\not\\Longrightarrow\\text{geometrische Singularität}', 'Methodologische Trennung von Koordinatenartefakt und geometrischer Singularität.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(625, '3.673', 43, 'Dimension einer n-Mannigfaltigkeit', '\\dim M=n', '\\dim M=n', 'Lokale Mannigfaltigkeitsdimension.', 'definition', 'literature', 77, NULL, NULL, 'verified', 21),
(626, '3.674', 43, 'Mannigfaltigkeitsdimension beweist nicht physikalische Dimensionszahl', '\\dim M=n\\not\\Longrightarrow n\\text{ fundamentale physikalische Dimensionen}', '\\dim M=n\\not\\Longrightarrow n\\text{ fundamentale physikalische Dimensionen}', 'Methodologische Nichtimplikation zwischen mathematischer und physikalischer Dimensionsinterpretation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(627, '3.675', 43, 'Skalare Funktion auf der Mannigfaltigkeit', 'I:M\\longrightarrow\\mathbb R', 'I:M\\longrightarrow\\mathbb R', 'Abstrakte skalare Zustandsbewertung auf einer Mannigfaltigkeit.', 'model', 'original', NULL, NULL, NULL, 'verified', 21),
(628, '3.676', 43, 'Skalare Funktion erhöht die Mannigfaltigkeitsdimension nicht', 'I:M\\to\\mathbb R\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', 'I:M\\to\\mathbb R\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', 'Eine skalare Funktion erzeugt nicht automatisch eine neue unabhängige Koordinate.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(629, '3.677', 43, 'Explizite Produkterweiterung des Zustandsraumes', '\\widetilde M=M\\times\\mathbb R', '\\widetilde M=M\\times\\mathbb R', 'Eine zusätzliche reelle Zustandskoordinate kann durch eine explizite Produktkonstruktion eingeführt werden.', 'model', 'adapted', 77, NULL, NULL, 'verified', 21),
(630, '3.678', 43, 'Dimension der Produkterweiterung', '\\dim\\widetilde M=n+1', '\\dim\\widetilde M=n+1', 'Für eine n-dimensionale Mannigfaltigkeit erhöht die Produktkonstruktion mit R die Dimension um eins.', 'theorem', 'adapted', 77, NULL, NULL, 'verified', 21),
(631, '3.679', 43, 'Skalare Funktion erzeugt nicht automatisch ein Produkt', 'I:M\\to\\mathbb R\\not\\Longrightarrow M\\text{ wird automatisch zu }M\\times\\mathbb R', 'I:M\\to\\mathbb R\\not\\Longrightarrow M\\text{ wird automatisch zu }M\\times\\mathbb R', 'Methodologische Nichtimplikation zwischen Zustandsbewertung und Zustandsraumerweiterung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(632, '3.680', 43, 'Dimension von Mannigfaltigkeit und Tangentialraum', '\\dim T_pM=\\dim M=n', '\\dim T_pM=\\dim M=n', 'Der Tangentialraum besitzt dieselbe Dimension wie die zugrunde liegende n-Mannigfaltigkeit.', 'theorem', 'literature', 77, NULL, NULL, 'verified', 21),
(633, '3.681', 43, 'Tangentialraum ist nicht automatisch physisch zusätzlicher Raum', 'T_pM\\text{ Tangentialraum}\\not\\Longrightarrow T_pM\\text{ physisch vorhandener zusätzlicher Raum}', 'T_pM\\text{ Tangentialraum}\\not\\Longrightarrow T_pM\\text{ physisch vorhandener zusätzlicher Raum}', 'Methodologische Nichtimplikation zwischen linearer lokaler Approximation und physischem zusätzlichen Raum.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(634, '3.682', 43, 'Zuordnung eines Punktes zu seinem Tangentialraum', 'p\\longmapsto T_pM', 'p\\longmapsto T_pM', 'Schematische Zuordnung der lokalen linearen Struktur zu jedem Mannigfaltigkeitspunkt.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(635, '3.683', 43, 'Differential als lokale lineare Abbildung', 'M\\xrightarrow{\\,F\\,}N\\qquad\\Longrightarrow\\qquad T_pM\\xrightarrow{\\,dF_p\\,}T_{F(p)}N', 'M\\xrightarrow{\\,F\\,}N\\qquad\\Longrightarrow\\qquad T_pM\\xrightarrow{\\,dF_p\\,}T_{F(p)}N', 'Verbindung einer glatten Abbildung mit ihrer induzierten linearen Tangentialabbildung.', 'schema', 'adapted', 77, NULL, NULL, 'verified', 21),
(636, '3.684', 43, 'Didaktische Struktur zur glatten Mannigfaltigkeit', '\\text{topologischer Raum}\\longrightarrow\\text{lokale Karte}\\longrightarrow\\text{glatter Atlas}\\longrightarrow\\text{glatte Mannigfaltigkeit}', '\\text{topologischer Raum}\\longrightarrow\\text{lokale Karte}\\longrightarrow\\text{glatter Atlas}\\longrightarrow\\text{glatte Mannigfaltigkeit}', 'Didaktische Aufbaufolge der Mannigfaltigkeitsstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(637, '3.685', 43, 'Didaktische Struktur der lokalen linearen Geometrie', '\\text{Mannigfaltigkeit}\\longrightarrow\\text{Tangentialraum}\\longrightarrow\\text{Differential}\\longrightarrow\\text{lokale lineare Geometrie}', '\\text{Mannigfaltigkeit}\\longrightarrow\\text{Tangentialraum}\\longrightarrow\\text{Differential}\\longrightarrow\\text{lokale lineare Geometrie}', 'Didaktische Verbindung von Mannigfaltigkeit, Tangentialraum und Differential.', 'schema', 'original', NULL, NULL, NULL, 'verified', 21),
(693, '3.686', 45, 'Bilinearform', 'g:V\\times V\\longrightarrow\\mathbb R', 'g:V\\times V\\longrightarrow\\mathbb R', 'Abbildung einer Bilinearform auf einem reellen Vektorraum.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(694, '3.687', 45, 'Linearität im ersten Argument', 'g(\\alpha u+\\beta v,w)=\\alpha g(u,w)+\\beta g(v,w)', 'g(\\alpha u+\\beta v,w)=\\alpha g(u,w)+\\beta g(v,w)', 'Beispiel der Bilinearität.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(695, '3.688', 45, 'Symmetrie einer Bilinearform', 'g(v,w)=g(w,v)', 'g(v,w)=g(w,v)', 'Symmetriebedingung.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(696, '3.689', 45, 'Orthogonalität zu allen Vektoren', 'g(v,w)=0\\qquad\\text{für alle }w\\in V', 'g(v,w)=0\\qquad\\text{für alle }w\\in V', 'Ausgangsbedingung der Nichtausgeartetheit.', 'schema', 'literature', 78, NULL, NULL, 'verified', 23),
(697, '3.690', 45, 'Folgerung der Nichtausgeartetheit', 'v=0', 'v=0', 'Nichtausgeartetheit erzwingt den Nullvektor.', 'schema', 'literature', 78, NULL, NULL, 'verified', 23),
(698, '3.691', 45, 'Matrix einer Bilinearform', 'G=(g_{ij})', 'G=(g_{ij})', 'Matrixdarstellung einer Bilinearform.', 'schema', 'literature', 78, NULL, NULL, 'verified', 23),
(699, '3.692', 45, 'Determinantenkriterium der Nichtausgeartetheit', '\\det G\\neq0', '\\det G\\neq0', 'In endlicher Dimension ist die Matrix einer nicht ausgearteten Bilinearform invertierbar.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 23),
(700, '3.693', 45, 'Positive Definitheit', 'g(v,v)>0\\qquad\\text{für jedes }v\\neq0', 'g(v,v)>0\\qquad\\text{für jedes }v\\neq0', 'Definition positiver Definitheit.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(701, '3.694', 45, 'Nullselbstprodukt im positiv definiten Fall', 'g(v,v)=0\\Longleftrightarrow v=0', 'g(v,v)=0\\Longleftrightarrow v=0', 'Positive Definitheit schließt nichttriviale Nullvektoren aus.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 23),
(702, '3.695', 45, 'Pseudo-riemannsche Metrik am Punkt', 'g_p:T_pM\\times T_pM\\longrightarrow\\mathbb R', 'g_p:T_pM\\times T_pM\\longrightarrow\\mathbb R', 'Punktweise metrische Bilinearform auf dem Tangentialraum.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(703, '3.696', 45, 'Punktabhängigkeit der metrischen Bilinearformen', 'g_p:T_pM\\times T_pM\\to\\mathbb R,\\qquad g_q:T_qM\\times T_qM\\to\\mathbb R\\qquad(p\\neq q)', 'g_p:T_pM\\times T_pM\\to\\mathbb R,\\qquad g_q:T_qM\\times T_qM\\to\\mathbb R\\qquad(p\\neq q)', 'Formal präzisiert: Die Metrik liefert punktabhängige Bilinearformen auf im Allgemeinen verschiedenen Tangentialräumen; eine direkte Gleichsetzung ist ohne Identifikation der Tangentialräume nicht sinnvoll.', 'schema', 'adapted', 78, NULL, NULL, 'verified', 23),
(704, '3.697', 45, 'Riemannsche positive Definitheit', 'g_p(v,v)>0\\qquad\\text{für alle }v\\in T_pM\\setminus\\{0\\}', 'g_p(v,v)>0\\qquad\\text{für alle }v\\in T_pM\\setminus\\{0\\}', 'Positive Definitheit einer riemannschen Metrik.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(705, '3.698', 45, 'Riemannsche Mannigfaltigkeit', '(M,g)', '(M,g)', 'Mannigfaltigkeit mit riemannscher Metrik.', 'schema', 'literature', 78, NULL, NULL, 'verified', 23),
(706, '3.699', 45, 'Riemannsche Norm eines Tangentialvektors', '\\|v\\|_g=\\sqrt{g_p(v,v)}', '\\|v\\|_g=\\sqrt{g_p(v,v)}', 'Von der positiv definiten Metrik induzierte Norm.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(707, '3.700', 45, 'Riemannscher Winkel', '\\cos\\theta=\\frac{g_p(v,w)}{\\|v\\|_g\\,\\|w\\|_g}', '\\cos\\theta=\\frac{g_p(v,w)}{\\|v\\|_g\\,\\|w\\|_g}', 'Winkeldefinition im positiv definiten Fall.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(708, '3.701', 45, 'Orthogonalitätsbedingung', 'g_p(v,w)=0', 'g_p(v,w)=0', 'Metrische Orthogonalität zweier Tangentialvektoren.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(709, '3.702', 45, 'Negatives Selbstprodukt', 'g_p(v,v)<0', 'g_p(v,v)<0', 'Möglicher Wert in einer indefiniten Metrik.', 'schema', 'literature', 78, NULL, NULL, 'verified', 23),
(710, '3.703', 45, 'Positives Selbstprodukt', 'g_p(v,v)>0', 'g_p(v,v)>0', 'Möglicher Wert in einer indefiniten Metrik.', 'schema', 'literature', 78, NULL, NULL, 'verified', 23),
(711, '3.704', 45, 'Verschwindendes Selbstprodukt', 'g_p(v,v)=0', 'g_p(v,v)=0', 'Nichttriviale Nullrichtungen sind in indefiniten Metriken möglich.', 'schema', 'literature', 78, NULL, NULL, 'verified', 23),
(712, '3.705', 45, 'Nullselbstprodukt impliziert im pseudo-riemannschen Fall nicht den Nullvektor', 'g_p(v,v)=0\\not\\Longrightarrow v=0', 'g_p(v,v)=0\\not\\Longrightarrow v=0', 'Methodologische Abgrenzung zum positiv definiten Fall.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(713, '3.706', 45, 'Diagonalform nach Signatur', '\\operatorname{diag}(\\underbrace{-1,\\ldots,-1}_{r},\\underbrace{1,\\ldots,1}_{n-r})', '\\operatorname{diag}(\\underbrace{-1,\\ldots,-1}_{r},\\underbrace{1,\\ldots,1}_{n-r})', 'Normalform einer nicht ausgearteten symmetrischen Bilinearform.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(714, '3.707', 45, 'Index', '\\operatorname{ind}(g)=r', '\\operatorname{ind}(g)=r', 'Index als Zahl negativer Richtungen in der Normalform.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(715, '3.708', 45, 'Basisunabhängigkeit des Index', '\\operatorname{ind}(g_p)=\\text{basisunabhängig}', '\\operatorname{ind}(g_p)=\\text{basisunabhängig}', 'Folge des Trägheitssatzes.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 23),
(716, '3.709', 45, 'Riemannscher Index', '\\operatorname{ind}(g)=0', '\\operatorname{ind}(g)=0', 'Riemannsche Metriken besitzen Index null.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(717, '3.710', 45, 'Lorentzscher Index', '\\operatorname{ind}(g)=1', '\\operatorname{ind}(g)=1', 'Lorentzsche Metrik in O\'Neills Indexkonvention.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(718, '3.711', 45, 'Lorentzsche Signaturkonvention', '(-,+,\\ldots,+)', '(-,+,\\ldots,+)', 'Verwendete globale Vorzeichenkonvention.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(719, '3.712', 45, 'Metrikkoeffizienten', 'g_{ij}(p)=g_p\\left(\\left.\\frac{\\partial}{\\partial x^i}\\right|_p,\\left.\\frac{\\partial}{\\partial x^j}\\right|_p\\right)', 'g_{ij}(p)=g_p\\left(\\left.\\frac{\\partial}{\\partial x^i}\\right|_p,\\left.\\frac{\\partial}{\\partial x^j}\\right|_p\\right)', 'Definition lokaler Metrikkoeffizienten.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(720, '3.713', 45, 'Symmetrie der Metrikkoeffizienten', 'g_{ij}=g_{ji}', 'g_{ij}=g_{ji}', 'Komponentendarstellung der Symmetrie.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 23),
(721, '3.714', 45, 'Metrikmatrix', 'G(p)=\\bigl(g_{ij}(p)\\bigr)', 'G(p)=\\bigl(g_{ij}(p)\\bigr)', 'Lokale Matrixdarstellung der Metrik.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(722, '3.715', 45, 'Nichtsingularität der Metrikmatrix', '\\det G(p)\\neq0\\qquad\\text{für alle }p\\in M', '\\det G(p)\\neq0\\qquad\\text{für alle }p\\in M', 'Nichtausgeartetheit an jedem Punkt.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 23),
(723, '3.716', 45, 'Metrischer Wert in Komponenten', 'g_p(v,w)=\\sum_{i,j=1}^{n}g_{ij}(p)v^iw^j', 'g_p(v,w)=\\sum_{i,j=1}^{n}g_{ij}(p)v^iw^j', 'Komponentendarstellung des metrischen Paarungswertes.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(724, '3.717', 45, 'Einstein-artige Kurznotation', 'g_p(v,w)=g_{ij}v^iw^j', 'g_p(v,w)=g_{ij}v^iw^j', 'Kompakte Indexnotation der metrischen Paarung.', 'schema', 'adapted', 78, NULL, NULL, 'verified', 23),
(725, '3.718', 45, 'Transformation der Metrikkoeffizienten', '\\widetilde g_{ab}=\\sum_{i,j}\\frac{\\partial x^i}{\\partial y^a}\\frac{\\partial x^j}{\\partial y^b}g_{ij}', '\\widetilde g_{ab}=\\sum_{i,j}\\frac{\\partial x^i}{\\partial y^a}\\frac{\\partial x^j}{\\partial y^b}g_{ij}', 'Transformationsregel eines kovarianten Tensorfeldes zweiter Stufe.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 23),
(726, '3.719', 45, 'Metrikmatrix ist nicht das abstrakte Metrikobjekt', '(g_{ij})\\neq\\text{die Metrik als abstraktes geometrisches Objekt}', '(g_{ij})\\neq\\text{die Metrik als abstraktes geometrisches Objekt}', 'Methodologische Trennung von geometrischem Objekt und Koordinatendarstellung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(727, '3.720', 45, 'Indexinvarianz unter Koordinatenwechsel', '\\operatorname{ind}(\\widetilde G)=\\operatorname{ind}(G)', '\\operatorname{ind}(\\widetilde G)=\\operatorname{ind}(G)', 'Index bleibt bei Basis- und Koordinatenwechsel erhalten.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 23),
(728, '3.721', 45, 'Inverse Metrikmatrix', 'G^{-1}(p)=(g^{ij}(p))', 'G^{-1}(p)=(g^{ij}(p))', 'Inverse der nichtsingulären Metrikmatrix.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(729, '3.722', 45, 'Inverse Metrikkomponenten', 'g^{ik}g_{kj}=\\delta^i_j', 'g^{ik}g_{kj}=\\delta^i_j', 'Inverse-Matrix-Identität.', 'derived', 'literature', 78, NULL, NULL, 'verified', 23),
(730, '3.723', 45, 'Riemannsche Kurvenlänge', 'L_g(\\gamma)=\\int_a^b\\sqrt{g_{\\gamma(t)}\\bigl(\\gamma\'(t),\\gamma\'(t)\\bigr)}\\,dt', 'L_g(\\gamma)=\\int_a^b\\sqrt{g_{\\gamma(t)}\\bigl(\\gamma\'(t),\\gamma\'(t)\\bigr)}\\,dt', 'Kurvenlänge in einer riemannschen Mannigfaltigkeit.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(731, '3.724', 45, 'Riemannscher Abstand', 'd_g(p,q)=\\inf_{\\gamma}L_g(\\gamma)', 'd_g(p,q)=\\inf_{\\gamma}L_g(\\gamma)', 'Abstand als Infimum der Längen verbindender Kurven.', 'metric', 'literature', 78, NULL, NULL, 'verified', 23),
(732, '3.725', 45, 'Bilinearformfeld und Abstandsfunktion sind verschiedene Objekte', 'g\\neq d', 'g\\neq d', 'Methodologische Trennung der beiden mathematischen Bedeutungen von Metrik.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(733, '3.726', 45, 'Pseudo-riemannsche Metrik erzeugt nicht allgemein eine Norm', '\\text{pseudo-riemannsche Metrik}\\not\\Longrightarrow\\text{Norm auf jedem }T_pM', '\\text{pseudo-riemannsche Metrik}\\not\\Longrightarrow\\text{Norm auf jedem }T_pM', 'Indefinite Selbstprodukte verhindern eine allgemeine Normkonstruktion aus g(v,v).', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(734, '3.727', 45, 'Pseudo-riemannsche Metrik erzeugt nicht allgemein einen metrischen Raum', '\\text{pseudo-riemannsche Metrik}\\not\\Longrightarrow\\text{metrischer Raum }(M,d_g)', '\\text{pseudo-riemannsche Metrik}\\not\\Longrightarrow\\text{metrischer Raum }(M,d_g)', 'Die riemannsche Distanzkonstruktion überträgt sich nicht direkt auf indefinite Metriken.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(735, '3.728', 45, 'Zeitartiger Tangentialvektor', 'g(v,v)<0', 'g(v,v)<0', 'Zeitartige Klasse bei Signatur (-,+,...,+).', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(736, '3.729', 45, 'Lichtartiger Tangentialvektor', 'g(v,v)=0', 'g(v,v)=0', 'Lichtartige beziehungsweise Nullklasse bei v ungleich null.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(737, '3.730', 45, 'Raumartiger Tangentialvektor', 'g(v,v)>0', 'g(v,v)>0', 'Raumartige Klasse bei Signatur (-,+,...,+).', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(738, '3.731', 45, 'Nichttrivialer lichtartiger Vektor', 'v\\neq0,\\qquad g(v,v)=0', 'v\\neq0,\\qquad g(v,v)=0', 'Lichtartige Vektoren sind nicht der Nullvektor.', 'schema', 'literature', 78, NULL, NULL, 'verified', 23),
(739, '3.732', 45, 'Vierdimensionale Mannigfaltigkeit', '\\dim M=4', '\\dim M=4', 'Mathematische Dimensionsannahme für eine vierdimensionale Mannigfaltigkeit.', 'schema', 'adapted', 78, NULL, NULL, 'verified', 23),
(740, '3.733', 45, 'Vierdimensionale lorentzsche Struktur', '\\dim M=4,\\qquad\\operatorname{ind}(g)=1', '\\dim M=4,\\qquad\\operatorname{ind}(g)=1', 'Mathematische Kennzeichnung einer vierdimensionalen lorentzschen Mannigfaltigkeit.', 'metric', 'adapted', 78, NULL, NULL, 'verified', 23),
(741, '3.734', 45, 'Lorentzsche Viermannigfaltigkeit ist nicht automatisch empirisches Raumzeitmodell', '\\text{vierdimensionale lorentzsche Mannigfaltigkeit}\\not\\Longrightarrow\\text{empirisch bestätigtes Raumzeitmodell}', '\\text{vierdimensionale lorentzsche Mannigfaltigkeit}\\not\\Longrightarrow\\text{empirisch bestätigtes Raumzeitmodell}', 'Methodologische Nichtimplikation zwischen mathematischer Struktur und empirischem Modellstatus.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(742, '3.735', 45, 'Index eins identifiziert keine bestimmte Zeitkoordinate', '\\operatorname{ind}(g)=1\\not\\Longrightarrow x^0\\text{ ist automatisch physikalische Zeit}', '\\operatorname{ind}(g)=1\\not\\Longrightarrow x^0\\text{ ist automatisch physikalische Zeit}', 'Signatur ist koordinatenunabhängig; konkrete Koordinatenbezeichnungen sind es nicht.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(743, '3.736', 45, 'Schranken für den Index', '0\\leq\\operatorname{ind}(g)\\leq n', '0\\leq\\operatorname{ind}(g)\\leq n', 'Index und Dimension sind getrennte Kennzahlen.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 23),
(744, '3.737', 45, 'Index erzeugt keine zusätzliche Dimension', '\\operatorname{ind}(g)=1\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', '\\operatorname{ind}(g)=1\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', 'Methodologische Nichtimplikation zwischen Signatur und Dimension.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(745, '3.738', 45, 'Anzahl unabhängiger Komponenten einer symmetrischen Metrikmatrix', '\\frac{n(n+1)}{2}', '\\frac{n(n+1)}{2}', 'Zahl unabhängiger Komponenten einer symmetrischen n×n-Matrix.', 'derived', 'literature', 78, NULL, NULL, 'verified', 23),
(746, '3.739', 45, 'Metrikkomponenten sind keine Raumdimensionen', '\\frac{n(n+1)}{2}\\text{ Metrikkomponenten}\\not\\Longrightarrow\\frac{n(n+1)}{2}\\text{ Raumdimensionen}', '\\frac{n(n+1)}{2}\\text{ Metrikkomponenten}\\not\\Longrightarrow\\frac{n(n+1)}{2}\\text{ Raumdimensionen}', 'Methodologische Nichtimplikation zwischen Komponentenanzahl und Dimensionszahl.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(747, '3.740', 45, 'Skalare Zusatzfunktion', 'I:M\\longrightarrow\\mathbb R', 'I:M\\longrightarrow\\mathbb R', 'Abstrakte zusätzliche skalare Zustandsbewertung.', 'model', 'original', NULL, NULL, NULL, 'verified', 23),
(748, '3.741', 45, 'Skalare Funktion erhöht die Mannigfaltigkeitsdimension nicht', 'I:M\\to\\mathbb R\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', 'I:M\\to\\mathbb R\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', 'Eine skalare Zustandsfunktion erzeugt keine neue Koordinatenrichtung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(749, '3.742', 45, 'Skalare Funktion erhöht den Metrikindex nicht', 'I:M\\to\\mathbb R\\not\\Longrightarrow\\operatorname{ind}(g)\\mapsto\\operatorname{ind}(g)+1', 'I:M\\to\\mathbb R\\not\\Longrightarrow\\operatorname{ind}(g)\\mapsto\\operatorname{ind}(g)+1', 'Eine skalare Zustandsfunktion verändert nicht automatisch die Signatur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(750, '3.743', 45, 'Explizite Produkterweiterung', '\\widetilde M=M\\times\\mathbb R', '\\widetilde M=M\\times\\mathbb R', 'Explizite mathematische Einführung einer zusätzlichen reellen Zustandskoordinate.', 'model', 'adapted', 78, NULL, NULL, 'verified', 23),
(751, '3.744', 45, 'Dimension der Produkterweiterung', '\\dim\\widetilde M=\\dim M+1', '\\dim\\widetilde M=\\dim M+1', 'Dimension einer Produktmannigfaltigkeit mit R.', 'theorem', 'adapted', 78, NULL, NULL, 'verified', 23),
(752, '3.745', 45, 'Produkterweiterung bestimmt keine eindeutige Metrik', 'M\\times\\mathbb R\\not\\Longrightarrow\\text{eindeutig bestimmte Metrik auf }M\\times\\mathbb R', 'M\\times\\mathbb R\\not\\Longrightarrow\\text{eindeutig bestimmte Metrik auf }M\\times\\mathbb R', 'Zusätzliche Dimension und metrische Bedeutung sind getrennte Festlegungen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(753, '3.746', 45, 'Lorentzsche Produktmetrik', 'g=-dt^2+h', 'g=-dt^2+h', 'Beispiel einer explizit gewählten lorentzschen Produktmetrik.', 'metric', 'adapted', 78, NULL, NULL, 'verified', 23),
(754, '3.747', 45, 'Reeller Produktfaktor ist nicht automatisch physikalische Zeit', '\\mathbb R\\text{-Faktor}\\not\\Longrightarrow\\text{physikalische Zeit}', '\\mathbb R\\text{-Faktor}\\not\\Longrightarrow\\text{physikalische Zeit}', 'Methodologische Nichtimplikation zwischen Produktkoordinate und Zeitinterpretation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(755, '3.748', 45, 'Isometriebedingung', 'h_{F(p)}\\bigl(dF_p(v),dF_p(w)\\bigr)=g_p(v,w)', 'h_{F(p)}\\bigl(dF_p(v),dF_p(w)\\bigr)=g_p(v,w)', 'Erhaltung der metrischen Bilinearform durch einen Diffeomorphismus.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(756, '3.749', 45, 'Erhaltung des Selbstproduktes durch Isometrien', 'h_{F(p)}\\bigl(dF_p(v),dF_p(v)\\bigr)=g_p(v,v)', 'h_{F(p)}\\bigl(dF_p(v),dF_p(v)\\bigr)=g_p(v,v)', 'Isometrien erhalten die metrische Vektorklasse.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 23),
(757, '3.750', 45, 'Koordinatenänderung ist nicht geometrische Metrikänderung', 'G\\neq\\widetilde G\\not\\Longrightarrow g\\text{ hat sich geometrisch verändert}', 'G\\neq\\widetilde G\\not\\Longrightarrow g\\text{ hat sich geometrisch verändert}', 'Methodologische Trennung zwischen Komponentendarstellung und geometrischem Bilinearformfeld.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(758, '3.751', 45, 'Orthogonalitätsbedingung', 'g(v,w)=0', 'g(v,w)=0', 'Orthogonalität bezüglich der Metrik.', 'definition', 'literature', 78, NULL, NULL, 'verified', 23),
(759, '3.752', 45, 'Positive Definitheit schließt selbstorthogonale Nichtnullvektoren aus', 'v\\neq0\\Longrightarrow g(v,v)>0', 'v\\neq0\\Longrightarrow g(v,v)>0', 'Riemannscher Fall.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 23),
(760, '3.753', 45, 'Lichtartiger selbstorthogonaler Nichtnullvektor', 'v\\neq0,\\qquad g(v,v)=0', 'v\\neq0,\\qquad g(v,v)=0', 'Lorentzscher Gegenfall zum positiv definiten Raum.', 'schema', 'literature', 78, NULL, NULL, 'verified', 23),
(761, '3.754', 45, 'Hilbertraumargumente übertragen sich nicht automatisch auf Lorentzgeometrie', '\\text{Hilbertraumargument}\\not\\Longrightarrow\\text{unverändert gültiges Lorentzraumargument}', '\\text{Hilbertraumargument}\\not\\Longrightarrow\\text{unverändert gültiges Lorentzraumargument}', 'Positive Definitheit ist in vielen Hilbertraumsätzen wesentlich.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(762, '3.755', 45, 'Metrik legt keine eindeutige Dynamik fest', 'g\\text{ gegeben}\\not\\Longrightarrow\\text{Dynamik eindeutig festgelegt}', 'g\\text{ gegeben}\\not\\Longrightarrow\\text{Dynamik eindeutig festgelegt}', 'Geometrische Struktur und Evolutionsgesetz sind getrennte Modellbestandteile.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(763, '3.756', 45, 'Lorentzsche Metrik ist noch keine vollständige globale Kausalstruktur', '\\text{lorentzsche Metrik}\\not\\Longrightarrow\\text{vollständige globale Kausalstruktur}', '\\text{lorentzsche Metrik}\\not\\Longrightarrow\\text{vollständige globale Kausalstruktur}', 'Globale Kausalbegriffe erfordern zusätzliche Struktur und Bedingungen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(764, '3.757', 45, 'Metrik ist nicht automatisch FRZK-Kohärenzmaß', 'g\\text{ Metrik}\\not\\Longrightarrow g\\text{ FRZK-Kohärenzmaß}', 'g\\text{ Metrik}\\not\\Longrightarrow g\\text{ FRZK-Kohärenzmaß}', 'Methodologische Nichtimplikation zwischen Geometrie und späterem Kohärenzbegriff.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(765, '3.758', 45, 'Geometrische Kurvenlänge ist nicht automatisch gemessene physikalische Länge', 'L_g(\\gamma)\\text{ geometrische Kurvenlänge}\\not\\Longrightarrow L_g(\\gamma)\\text{ gemessene physikalische Länge}', 'L_g(\\gamma)\\text{ geometrische Kurvenlänge}\\not\\Longrightarrow L_g(\\gamma)\\text{ gemessene physikalische Länge}', 'Formal präzisiert: Eine mathematisch definierte Länge erhält erst durch Modellinterpretation die Bedeutung einer gemessenen physikalischen Länge.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(766, '3.759', 45, 'Hierarchie Mannigfaltigkeit, Tangentialraum und Metrik', 'M\\longrightarrow T_pM\\longrightarrow g_p', 'M\\longrightarrow T_pM\\longrightarrow g_p', 'Strukturelle Einordnung der metrischen Erweiterung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(767, '3.760', 45, 'Riemannsche Messstruktur', 'g_p\\longrightarrow\\|v\\|_g\\longrightarrow\\text{Winkel und Kurvenlängen}', 'g_p\\longrightarrow\\|v\\|_g\\longrightarrow\\text{Winkel und Kurvenlängen}', 'Didaktische Folge im positiv definiten Fall.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(768, '3.761', 45, 'Pseudo-riemannsche Signaturstruktur', 'g_p\\longrightarrow\\operatorname{ind}(g)\\longrightarrow\\text{indefinite Vektorklassifikation}', 'g_p\\longrightarrow\\operatorname{ind}(g)\\longrightarrow\\text{indefinite Vektorklassifikation}', 'Didaktische Folge im indefiniten Fall.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(769, '3.762', 45, 'Riemannsche Kette von Selbstprodukt zu Abstand', 'g_p(v,v)\\longrightarrow\\|v\\|_g\\longrightarrow L_g(\\gamma)\\longrightarrow d_g(p,q)', 'g_p(v,v)\\longrightarrow\\|v\\|_g\\longrightarrow L_g(\\gamma)\\longrightarrow d_g(p,q)', 'Didaktische Kette der positiv definiten Messstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(770, '3.763', 45, 'Pseudo-riemannsche Vorzeichenklassifikation', 'g_p(v,v)\\longrightarrow\\text{Vorzeichenklasse von }v', 'g_p(v,v)\\longrightarrow\\text{Vorzeichenklasse von }v', 'Didaktische Kette der indefiniten Vektorklassifikation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(771, '3.764', 45, 'Lorentzsche Vektorklassen', '\\text{zeitartig}\\quad\\text{oder}\\quad\\text{lichtartig}\\quad\\text{oder}\\quad\\text{raumartig}', '\\text{zeitartig}\\quad\\text{oder}\\quad\\text{lichtartig}\\quad\\text{oder}\\quad\\text{raumartig}', 'Drei metrische Klassen nichtverschwindender Tangentialvektoren.', 'schema', 'literature', 78, NULL, NULL, 'verified', 23),
(772, '3.765', 45, 'Didaktische Gesamtstruktur der metrischen Geometrie', '\\text{Mannigfaltigkeit}\\longrightarrow\\text{Tangentialräume}\\longrightarrow\\text{metrisches Bilinearformfeld}\\longrightarrow\\text{Signatur}\\longrightarrow\\text{Geometrie}', '\\text{Mannigfaltigkeit}\\longrightarrow\\text{Tangentialräume}\\longrightarrow\\text{metrisches Bilinearformfeld}\\longrightarrow\\text{Signatur}\\longrightarrow\\text{Geometrie}', 'Zusammenfassende Struktur der metrischen Erweiterung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 23),
(773, '3.766', 46, 'Vektorfeldwert im Tangentialraum', 'X_p\\in T_pM', 'X_p\\in T_pM', 'Ein Vektorfeld ordnet jedem Punkt einen Tangentialvektor zu.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(774, '3.767', 46, 'Vektorfeld als Schnitt des Tangentialbündels', 'X:M\\longrightarrow TM,\\qquad\\pi\\circ X=I_M', 'X:M\\longrightarrow TM,\\qquad\\pi\\circ X=I_M', 'Ein Vektorfeld ist ein glatter Schnitt des Tangentialbündels.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(775, '3.768', 46, 'Raum glatter Vektorfelder', '\\mathfrak X(M)', '\\mathfrak X(M)', 'Notation für die Menge der glatten Vektorfelder auf M.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(776, '3.769', 46, 'Lokale Darstellung eines Vektorfeldes', 'X=X^i\\frac{\\partial}{\\partial x^i}', 'X=X^i\\frac{\\partial}{\\partial x^i}', 'Komponentendarstellung eines Vektorfeldes in lokalen Koordinaten.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(777, '3.770', 46, 'Naive partielle Komponentenänderung', '\\frac{\\partial X^j}{\\partial x^i}', '\\frac{\\partial X^j}{\\partial x^i}', 'Gewöhnliche partielle Ableitung der Komponenten eines Vektorfeldes.', 'schema', 'adapted', 78, NULL, NULL, 'verified', 24),
(778, '3.771', 46, 'Partielle Komponentenänderung ist keine koordinatenunabhängige Vektorfeldableitung', '\\text{partielle Ableitung der Komponenten}\\not\\Longrightarrow\\text{koordinatenunabhängige Ableitung des Vektorfeldes}', '\\text{partielle Ableitung der Komponenten}\\not\\Longrightarrow\\text{koordinatenunabhängige Ableitung des Vektorfeldes}', 'Methodologische Nichtimplikation zur Motivation des Zusammenhangs.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(779, '3.772', 46, 'Affiner Zusammenhang', '\\nabla:\\mathfrak X(M)\\times\\mathfrak X(M)\\longrightarrow\\mathfrak X(M),\\qquad(X,Y)\\longmapsto\\nabla_XY', '\\nabla:\\mathfrak X(M)\\times\\mathfrak X(M)\\longrightarrow\\mathfrak X(M),\\qquad(X,Y)\\longmapsto\\nabla_XY', 'Abbildung eines affinen Zusammenhangs.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(780, '3.773', 46, 'C-infinity-Linearität im Richtungsargument', '\\nabla_{fX+gY}Z=f\\nabla_XZ+g\\nabla_YZ', '\\nabla_{fX+gY}Z=f\\nabla_XZ+g\\nabla_YZ', 'Linearität des Zusammenhangs im ersten Argument über glatten Funktionen.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(781, '3.774', 46, 'Reelle Linearität im zweiten Argument', '\\nabla_X(\\alpha Y+\\beta Z)=\\alpha\\nabla_XY+\\beta\\nabla_XZ', '\\nabla_X(\\alpha Y+\\beta Z)=\\alpha\\nabla_XY+\\beta\\nabla_XZ', 'Reelle Linearität im abzuleitenden Vektorfeld.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(782, '3.775', 46, 'Leibnizregel des Zusammenhangs', '\\nabla_X(fY)=X(f)\\,Y+f\\nabla_XY', '\\nabla_X(fY)=X(f)\\,Y+f\\nabla_XY', 'Leibnizregel im zweiten Argument.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(783, '3.776', 46, 'Glatte Mannigfaltigkeit bestimmt keinen eindeutigen Zusammenhang', '\\text{glatte Mannigfaltigkeit}\\not\\Longrightarrow\\text{eindeutig bestimmter Zusammenhang}', '\\text{glatte Mannigfaltigkeit}\\not\\Longrightarrow\\text{eindeutig bestimmter Zusammenhang}', 'Ein Zusammenhang ist zusätzliche Struktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(784, '3.777', 46, 'Zusammenhangskoeffizienten', '\\nabla_{\\frac{\\partial}{\\partial x^i}}\\frac{\\partial}{\\partial x^j}=\\Gamma^k_{ij}\\frac{\\partial}{\\partial x^k}', '\\nabla_{\\frac{\\partial}{\\partial x^i}}\\frac{\\partial}{\\partial x^j}=\\Gamma^k_{ij}\\frac{\\partial}{\\partial x^k}', 'Definition lokaler Zusammenhangskoeffizienten.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(785, '3.778', 46, 'Lokale Formel der kovarianten Ableitung', '\\nabla_XY=X^i\\left(\\frac{\\partial Y^k}{\\partial x^i}+\\Gamma^k_{ij}Y^j\\right)\\frac{\\partial}{\\partial x^k}', '\\nabla_XY=X^i\\left(\\frac{\\partial Y^k}{\\partial x^i}+\\Gamma^k_{ij}Y^j\\right)\\frac{\\partial}{\\partial x^k}', 'Komponentenformel für die kovariante Ableitung.', 'derived', 'literature', 78, NULL, NULL, 'verified', 24),
(786, '3.779', 46, 'Zusammenhangskoeffizienten sind keine Tensorkomponenten', '\\Gamma^k_{ij}\\neq\\text{Komponenten eines Tensors}', '\\Gamma^k_{ij}\\neq\\text{Komponenten eines Tensors}', 'Christoffel-Symbole transformieren nicht tensorial.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(787, '3.780', 46, 'Verschwinden von Zusammenhangskoeffizienten an einem Punkt', '\\Gamma^k_{ij}(p)=0', '\\Gamma^k_{ij}(p)=0', 'In geeigneten lokalen Koordinaten können Levi-Civita-Koeffizienten an einem Punkt verschwinden.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(788, '3.781', 46, 'Lokales Verschwinden der Christoffel-Symbole impliziert keine globale Trivialität', '\\Gamma^k_{ij}(p)=0\\not\\Longrightarrow\\text{Geometrie global trivial}', '\\Gamma^k_{ij}(p)=0\\not\\Longrightarrow\\text{Geometrie global trivial}', 'Methodologische Nichtimplikation zwischen Koordinatendarstellung und globaler Geometrie.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(789, '3.782', 46, 'Torsion', 'T(X,Y)=\\nabla_XY-\\nabla_YX-[X,Y]', 'T(X,Y)=\\nabla_XY-\\nabla_YX-[X,Y]', 'Definition der Torsion eines Zusammenhangs.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(790, '3.783', 46, 'Torsionsfreiheit', 'T(X,Y)=0\\qquad\\text{für alle }X,Y', 'T(X,Y)=0\\qquad\\text{für alle }X,Y', 'Definition eines torsionsfreien Zusammenhangs.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(791, '3.784', 46, 'Symmetrie der Christoffel-Symbole bei Torsionsfreiheit', '\\Gamma^k_{ij}=\\Gamma^k_{ji}', '\\Gamma^k_{ij}=\\Gamma^k_{ji}', 'In einer Koordinatenbasis sind die unteren Indizes eines torsionsfreien Zusammenhangs symmetrisch.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 24),
(792, '3.785', 46, 'Metrikverträglichkeit', 'X\\bigl(g(Y,Z)\\bigr)=g(\\nabla_XY,Z)+g(Y,\\nabla_XZ)', 'X\\bigl(g(Y,Z)\\bigr)=g(\\nabla_XY,Z)+g(Y,\\nabla_XZ)', 'Kompatibilität zwischen Zusammenhang und metrischer Paarung.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(793, '3.786', 46, 'Kovariante Konstanz der Metrik', '\\nabla g=0', '\\nabla g=0', 'Kurznotation der Metrikverträglichkeit.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(794, '3.787', 46, 'Levi-Civita-Bedingungen', 'T=0,\\qquad\\nabla g=0', 'T=0,\\qquad\\nabla g=0', 'Torsionsfreiheit und Metrikverträglichkeit charakterisieren den Levi-Civita-Zusammenhang eindeutig.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 24),
(795, '3.788', 46, 'Metrik bestimmt den Levi-Civita-Zusammenhang', 'g\\longmapsto\\nabla^{\\mathrm{LC}}', 'g\\longmapsto\\nabla^{\\mathrm{LC}}', 'Eindeutige Zuordnung unter den Levi-Civita-Bedingungen.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(796, '3.789', 46, 'Koszul-Formel', '2g(\\nabla_XY,Z)=Xg(Y,Z)+Yg(Z,X)-Zg(X,Y)-g(X,[Y,Z])+g(Y,[Z,X])+g(Z,[X,Y])', '2g(\\nabla_XY,Z)=Xg(Y,Z)+Yg(Z,X)-Zg(X,Y)-g(X,[Y,Z])+g(Y,[Z,X])+g(Z,[X,Y])', 'Intrinsische Bestimmung des Levi-Civita-Zusammenhangs.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 24),
(797, '3.790', 46, 'Christoffel-Symbole aus der Metrik', '\\Gamma^k_{ij}=\\frac{1}{2}g^{k\\ell}\\left(\\frac{\\partial g_{\\ell j}}{\\partial x^i}+\\frac{\\partial g_{i\\ell}}{\\partial x^j}-\\frac{\\partial g_{ij}}{\\partial x^\\ell}\\right)', '\\Gamma^k_{ij}=\\frac{1}{2}g^{k\\ell}\\left(\\frac{\\partial g_{\\ell j}}{\\partial x^i}+\\frac{\\partial g_{i\\ell}}{\\partial x^j}-\\frac{\\partial g_{ij}}{\\partial x^\\ell}\\right)', 'Lokale Formel für Levi-Civita-Christoffel-Symbole.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 24),
(798, '3.791', 46, 'Konstante Metrikkoeffizienten', '\\frac{\\partial g_{ij}}{\\partial x^k}=0', '\\frac{\\partial g_{ij}}{\\partial x^k}=0', 'Konstanz der Metrikkomponenten in einer Karte.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(799, '3.792', 46, 'Verschwinden der Christoffel-Symbole bei konstanten Metrikkoeffizienten', '\\Gamma^k_{ij}=0', '\\Gamma^k_{ij}=0', 'Folgerung aus der Levi-Civita-Formel in einer Karte mit konstanten Metrikkomponenten.', 'derived', 'literature', 78, NULL, NULL, 'verified', 24),
(800, '3.793', 46, 'Metrik und Zusammenhang sind verschiedene Objekttypen', 'g\\neq\\nabla', 'g\\neq\\nabla', 'Methodologische Typentrennung zwischen Bilinearformfeld und Differentiationsvorschrift.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(801, '3.794', 46, 'Kurve auf der Mannigfaltigkeit', '\\gamma:I\\longrightarrow M', '\\gamma:I\\longrightarrow M', 'Kurve als Grundlage der kovarianten Ableitung entlang eines Weges.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(802, '3.795', 46, 'Vektorfeldwert entlang einer Kurve', 'V(t)\\in T_{\\gamma(t)}M', 'V(t)\\in T_{\\gamma(t)}M', 'Ein Vektorfeld entlang einer Kurve liegt punktweise im jeweiligen Tangentialraum.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(803, '3.796', 46, 'Bündelprojektion eines Vektorfeldes entlang einer Kurve', '\\pi(V(t))=\\gamma(t)', '\\pi(V(t))=\\gamma(t)', 'Kennzeichnende Bedingung eines Vektorfeldes entlang einer Kurve.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(804, '3.797', 46, 'Kovariante Ableitung entlang einer Kurve', '\\frac{DV}{dt}', '\\frac{DV}{dt}', 'Notation der kovarianten Ableitung entlang gamma.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(805, '3.798', 46, 'Komponentenform der kovarianten Kurvenableitung', '\\frac{DV^k}{dt}=\\frac{dV^k}{dt}+\\Gamma^k_{ij}\\frac{dx^i}{dt}V^j', '\\frac{DV^k}{dt}=\\frac{dV^k}{dt}+\\Gamma^k_{ij}\\frac{dx^i}{dt}V^j', 'Lokale Formel der kovarianten Ableitung entlang einer Kurve.', 'derived', 'literature', 78, NULL, NULL, 'verified', 24),
(806, '3.799', 46, 'Paralleles Vektorfeld', '\\frac{DV}{dt}=0', '\\frac{DV}{dt}=0', 'Parallelität entlang einer Kurve.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(807, '3.800', 46, 'Paralleltransportgleichung in Komponenten', '\\frac{dV^k}{dt}+\\Gamma^k_{ij}(\\gamma(t))\\dot\\gamma^i(t)V^j(t)=0', '\\frac{dV^k}{dt}+\\Gamma^k_{ij}(\\gamma(t))\\dot\\gamma^i(t)V^j(t)=0', 'Lineares Differentialgleichungssystem des Paralleltransports.', 'model', 'literature', 78, NULL, NULL, 'verified', 24),
(808, '3.801', 46, 'Kovariante Parallelität bedeutet nicht konstante Komponenten', '\\frac{DV}{dt}=0\\not\\Longrightarrow\\frac{dV^k}{dt}=0', '\\frac{DV}{dt}=0\\not\\Longrightarrow\\frac{dV^k}{dt}=0', 'Methodologische Nichtimplikation in allgemeinen Koordinaten.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(809, '3.802', 46, 'Anfangsbedingung des Paralleltransports', 'V(a)=v', 'V(a)=v', 'Anfangswert des parallel zu transportierenden Vektorfeldes.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(810, '3.803', 46, 'Paralleltransportabbildung', 'P^\\gamma_{a\\to b}:T_{\\gamma(a)}M\\longrightarrow T_{\\gamma(b)}M', 'P^\\gamma_{a\\to b}:T_{\\gamma(a)}M\\longrightarrow T_{\\gamma(b)}M', 'Abbildung zwischen den Tangentialräumen entlang einer festgelegten Kurve.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(811, '3.804', 46, 'Linearität des Paralleltransports', 'P^\\gamma_{a\\to b}(\\alpha v+\\beta w)=\\alpha P^\\gamma_{a\\to b}(v)+\\beta P^\\gamma_{a\\to b}(w)', 'P^\\gamma_{a\\to b}(\\alpha v+\\beta w)=\\alpha P^\\gamma_{a\\to b}(v)+\\beta P^\\gamma_{a\\to b}(w)', 'Paralleltransport ist für eine feste Kurve linear.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 24),
(812, '3.805', 46, 'Inverse des Paralleltransports', '\\left(P^\\gamma_{a\\to b}\\right)^{-1}=P^{\\bar\\gamma}_{b\\to a}', '\\left(P^\\gamma_{a\\to b}\\right)^{-1}=P^{\\bar\\gamma}_{b\\to a}', 'Rücktransport entlang der umgekehrten Kurve ist die Inverse.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 24),
(813, '3.806', 46, 'Wegabhängigkeit des Paralleltransports', 'P^{\\gamma_1}_{p\\to q}\\neq P^{\\gamma_2}_{p\\to q}\\text{ ist im Allgemeinen möglich}', 'P^{\\gamma_1}_{p\\to q}\\neq P^{\\gamma_2}_{p\\to q}\\text{ ist im Allgemeinen möglich}', 'Verschiedene Wege zwischen denselben Endpunkten können verschiedene Paralleltransporte erzeugen.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(814, '3.807', 46, 'Paralleltransport hängt von Endpunkten und Weg ab', '(p,q,\\gamma)\\longmapsto P^\\gamma_{p\\to q}', '(p,q,\\gamma)\\longmapsto P^\\gamma_{p\\to q}', 'Schematische Darstellung der Wegabhängigkeit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(815, '3.808', 46, 'Wegabhängigkeit erzeugt keine zusätzliche Dimension', '\\text{Wegabhängigkeit des Paralleltransports}\\not\\Longrightarrow\\text{zusätzliche Dimension}', '\\text{Wegabhängigkeit des Paralleltransports}\\not\\Longrightarrow\\text{zusätzliche Dimension}', 'Methodologische Nichtimplikation für Dimensionsargumente.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(816, '3.809', 46, 'Konstanz der metrischen Paarung paralleler Felder', '\\frac{d}{dt}g_{\\gamma(t)}\\bigl(V(t),W(t)\\bigr)=0', '\\frac{d}{dt}g_{\\gamma(t)}\\bigl(V(t),W(t)\\bigr)=0', 'Metrikverträglicher Paralleltransport erhält die Paarung.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 24),
(817, '3.810', 46, 'Metrikerhaltung des Paralleltransports', 'g_{\\gamma(b)}\\left(P^\\gamma_{a\\to b}v,P^\\gamma_{a\\to b}w\\right)=g_{\\gamma(a)}(v,w)', 'g_{\\gamma(b)}\\left(P^\\gamma_{a\\to b}v,P^\\gamma_{a\\to b}w\\right)=g_{\\gamma(a)}(v,w)', 'Levi-Civita-Paralleltransport ist eine lineare Isometrie der Tangentialräume.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 24),
(818, '3.811', 46, 'Erhaltung des metrischen Selbstproduktes', 'g_{\\gamma(b)}\\left(P^\\gamma_{a\\to b}v,P^\\gamma_{a\\to b}v\\right)=g_{\\gamma(a)}(v,v)', 'g_{\\gamma(b)}\\left(P^\\gamma_{a\\to b}v,P^\\gamma_{a\\to b}v\\right)=g_{\\gamma(a)}(v,v)', 'Selbstprodukt und damit lorentzsche Vektorklasse bleiben erhalten.', 'derived', 'literature', 78, NULL, NULL, 'verified', 24),
(819, '3.812', 46, 'Erhaltung der raumartigen Klasse', '\\text{raumartig}\\longmapsto\\text{raumartig}', '\\text{raumartig}\\longmapsto\\text{raumartig}', 'Zusammen mit den unmittelbar vorausgehenden unnummerierten zeit- und lichtartigen Abbildungen dokumentiert dies die Erhaltung der lorentzschen Klasse.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(820, '3.813', 46, 'Verschwindende Christoffel-Symbole im euklidischen Spezialfall', '\\Gamma^k_{ij}=0', '\\Gamma^k_{ij}=0', 'Kartesische Koordinaten der flachen Standardgeometrie.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(821, '3.814', 46, 'Konstante Komponenten im euklidischen Paralleltransport', '\\frac{dV^k}{dt}=0', '\\frac{dV^k}{dt}=0', 'Bei verschwindenden Christoffel-Symbolen reduziert sich Parallelität auf konstante Komponenten.', 'derived', 'literature', 78, NULL, NULL, 'verified', 24),
(822, '3.815', 46, 'Euklidische Parallelverschiebung als Spezialfall', '\\text{euklidische Parallelverschiebung}\\subset\\text{allgemeiner geometrischer Paralleltransport}', '\\text{euklidische Parallelverschiebung}\\subset\\text{allgemeiner geometrischer Paralleltransport}', 'Konzeptionelle Einordnung der euklidischen Parallelverschiebung als Spezialfall des allgemeinen Paralleltransports.', 'schema', 'adapted', 78, NULL, NULL, 'verified', 24),
(823, '3.816', 46, 'Kovariante Ableitung eines Skalars', '\\nabla_Xf=X(f)', '\\nabla_Xf=X(f)', 'Für Skalare stimmt die kovariante Ableitung mit der Richtungsableitung überein.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 24),
(824, '3.817', 46, 'Kovariante Änderung impliziert nicht automatisch physikalische Änderung', '\\nabla_XY\\neq0\\not\\Longrightarrow\\text{physikalische Änderung eines realen Systems}', '\\nabla_XY\\neq0\\not\\Longrightarrow\\text{physikalische Änderung eines realen Systems}', 'Formal präzisierte Nichtimplikation; mathematische und physikalische Aussageebene bleiben getrennt.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(825, '3.818', 46, 'Geometrische Parallelität impliziert nicht automatisch physikalische Konstanz', '\\frac{DV}{dt}=0\\not\\Longrightarrow V\\text{ ist eine physikalisch unveränderliche Größe}', '\\frac{DV}{dt}=0\\not\\Longrightarrow V\\text{ ist eine physikalisch unveränderliche Größe}', 'Formal präzisierte Nichtimplikation zwischen kovarianter Parallelität und physikalischer Erhaltung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(826, '3.819', 46, 'Zusammenhangskoeffizienten sind nicht physikalische Kraftkomponenten', '\\Gamma^k_{ij}\\not\\equiv\\text{physikalische Kraftkomponenten}', '\\Gamma^k_{ij}\\not\\equiv\\text{physikalische Kraftkomponenten}', 'Koordinatenabhängige geometrische Koeffizienten sind nicht automatisch physikalische Observablen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(827, '3.820', 46, 'Zusammenhang impliziert keine Kausalrelation', '\\text{Zusammenhang}\\not\\Longrightarrow\\text{Kausalrelation}', '\\text{Zusammenhang}\\not\\Longrightarrow\\text{Kausalrelation}', 'Methodologische Trennung von Differentiationsstruktur und Kausalstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(828, '3.821', 46, 'Zusammenhang bestimmt keinen eindeutigen dynamischen Fluss', '\\nabla\\text{ gegeben}\\not\\Longrightarrow\\Phi_t\\text{ eindeutig gegeben}', '\\nabla\\text{ gegeben}\\not\\Longrightarrow\\Phi_t\\text{ eindeutig gegeben}', 'Geometrische Differentiationsstruktur und Evolutionsgesetz sind getrennte Modellbestandteile.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(829, '3.822', 46, 'Zusammenhang erhöht die Zustandsraumdimension nicht', '\\nabla\\text{ auf }M\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', '\\nabla\\text{ auf }M\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', 'Ein Zusammenhang strukturiert den vorhandenen Zustandsraum, erweitert ihn aber nicht.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(830, '3.823', 46, 'Paralleltransport zwischen Tangentialräumen', 'P^\\gamma_{p\\to q}:T_pM\\longrightarrow T_qM', 'P^\\gamma_{p\\to q}:T_pM\\longrightarrow T_qM', 'Paralleltransport als Abbildung zwischen zwei Tangentialräumen.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(831, '3.824', 46, 'Paralleltransport erzeugt keine zusätzliche Dimension', 'P^\\gamma_{p\\to q}\\not\\Longrightarrow\\text{zusätzliche Dimension}', 'P^\\gamma_{p\\to q}\\not\\Longrightarrow\\text{zusätzliche Dimension}', 'Methodologische Nichtimplikation für Dimensionsargumente.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(832, '3.825', 46, 'Skalare Informationsfunktion', 'I:M\\longrightarrow\\mathbb R', 'I:M\\longrightarrow\\mathbb R', 'Abstrakte skalare Informationsgröße auf der Mannigfaltigkeit.', 'model', 'original', NULL, NULL, NULL, 'verified', 24),
(833, '3.826', 46, 'Kovariante Ableitung einer skalaren Informationsfunktion', '\\nabla_XI=X(I)', '\\nabla_XI=X(I)', 'Für eine skalare Funktion entspricht die kovariante Ableitung ihrer Richtungsableitung.', 'derived', 'adapted', 78, NULL, NULL, 'verified', 24),
(834, '3.827', 46, 'Informationsableitung erzeugt keine Raum-Zeit-Dimension', '\\nabla I\\text{ vorhanden}\\not\\Longrightarrow\\text{Information ist zusätzliche Raum-Zeit-Dimension}', '\\nabla I\\text{ vorhanden}\\not\\Longrightarrow\\text{Information ist zusätzliche Raum-Zeit-Dimension}', 'Methodologische Nichtimplikation zwischen Differentialstruktur einer Funktion und zusätzlicher Dimension.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(835, '3.828', 46, 'Tangentialvektor einer Kurve', '\\dot\\gamma(t)\\in T_{\\gamma(t)}M', '\\dot\\gamma(t)\\in T_{\\gamma(t)}M', 'Geschwindigkeitsvektor einer parametrisierten Kurve als Tangentialvektor.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(836, '3.829', 46, 'Kovariante Beschleunigung einer Kurve', '\\frac{D\\dot\\gamma}{dt}', '\\frac{D\\dot\\gamma}{dt}', 'Kovariante Ableitung des Kurventangentialvektors.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(837, '3.830', 46, 'Geodätische Bedingung', '\\frac{D\\dot\\gamma}{dt}=0', '\\frac{D\\dot\\gamma}{dt}=0', 'Vorbereitung des Geodätenbegriffs.', 'model', 'literature', 78, NULL, NULL, 'verified', 24),
(838, '3.831', 46, 'Paralleltransport und dynamischer Fluss sind verschiedene Abbildungstypen', 'P^\\gamma_{a\\to b}\\neq\\Phi_t', 'P^\\gamma_{a\\to b}\\neq\\Phi_t', 'Typentrennung zwischen Tangentialraumabbildung und Zustandsraumfluss.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(839, '3.832', 46, 'Paralleltransport ist keine globale Mannigfaltigkeitsisometrie', '\\text{Paralleltransport}\\neq\\text{globale Isometrie der Mannigfaltigkeit}', '\\text{Paralleltransport}\\neq\\text{globale Isometrie der Mannigfaltigkeit}', 'Paralleltransport wirkt zwischen Tangentialräumen und setzt keine globale Symmetrie voraus.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(840, '3.833', 46, 'Verkettung des Paralleltransports', 'P^\\gamma_{a\\to c}=P^\\gamma_{b\\to c}\\circ P^\\gamma_{a\\to b}', 'P^\\gamma_{a\\to c}=P^\\gamma_{b\\to c}\\circ P^\\gamma_{a\\to b}', 'Konsistenz des Paralleltransports bei Zerlegung der Kurve.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 24),
(841, '3.834', 46, 'Gleiche Kompositionsform bedeutet nicht gleiche mathematische Bedeutung', '\\text{gleiche Kompositionsform}\\not\\Longrightarrow\\text{gleiche mathematische Bedeutung}', '\\text{gleiche Kompositionsform}\\not\\Longrightarrow\\text{gleiche mathematische Bedeutung}', 'Methodologische Trennung formal ähnlicher Verkettungsgesetze.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(842, '3.835', 46, 'Geschlossener Transportweg', '\\gamma(a)=\\gamma(b)=p', '\\gamma(a)=\\gamma(b)=p', 'Geschlossene Kurve mit identischem Anfangs- und Endpunkt.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(843, '3.836', 46, 'Paralleltransport auf demselben Tangentialraum', 'P^\\gamma:T_pM\\longrightarrow T_pM', 'P^\\gamma:T_pM\\longrightarrow T_pM', 'Holonomieartige Endomorphie bei einem geschlossenen Weg.', 'definition', 'literature', 78, NULL, NULL, 'verified', 24),
(844, '3.837', 46, 'Geschlossener Paralleltransport muss nicht die Identität sein', 'P^\\gamma\\neq I_{T_pM}\\text{ ist möglich}', 'P^\\gamma\\neq I_{T_pM}\\text{ ist möglich}', 'Wegabhängigkeit kann bei geschlossenen Kurven einen nichttrivialen Rücktransport erzeugen.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(845, '3.838', 46, 'Nichttrivialer geschlossener Paralleltransport impliziert kein physikalisches Gedächtnis', 'P^\\gamma\\neq I\\not\\Longrightarrow\\text{physikalisches Gedächtnis des Systems}', 'P^\\gamma\\neq I\\not\\Longrightarrow\\text{physikalisches Gedächtnis des Systems}', 'Methodologische Nichtimplikation zwischen geometrischer Wegabhängigkeit und physikalischem Gedächtnis.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(846, '3.839', 46, 'Paralleltransport ist nicht automatisch physikalischer Informationstransport', '\\text{Paralleltransport}\\not\\Longrightarrow\\text{physikalischer Informationstransport}', '\\text{Paralleltransport}\\not\\Longrightarrow\\text{physikalischer Informationstransport}', 'Methodologische Trennung geometrischer und informationstheoretischer Bedeutung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(847, '3.840', 46, 'Lokale-zu-endliche Struktur des Paralleltransports', '\\Gamma^k_{ij}\\longrightarrow\\nabla\\longrightarrow\\frac{D}{dt}\\longrightarrow P^\\gamma', '\\Gamma^k_{ij}\\longrightarrow\\nabla\\longrightarrow\\frac{D}{dt}\\longrightarrow P^\\gamma', 'Didaktische Kette von lokalen Koeffizienten zum endlichen Paralleltransport.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(848, '3.841', 46, 'Pseudo-riemannsche Metrik bestimmt den Levi-Civita-Zusammenhang', '(M,g)\\longrightarrow\\nabla^{\\mathrm{LC}}', '(M,g)\\longrightarrow\\nabla^{\\mathrm{LC}}', 'Didaktische Zuordnung des metrisch verträglichen torsionsfreien Zusammenhangs.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(849, '3.842', 46, 'Paralleltransport zwischen Endpunkttangentialräumen', 'T_{\\gamma(a)}M\\xrightarrow{\\;P^\\gamma_{a\\to b}\\;}T_{\\gamma(b)}M', 'T_{\\gamma(a)}M\\xrightarrow{\\;P^\\gamma_{a\\to b}\\;}T_{\\gamma(b)}M', 'Didaktische Darstellung des endlichen Transports.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(850, '3.843', 46, 'Didaktische Kette von Zusammenhang zu Paralleltransport', '\\text{Zusammenhang}\\longrightarrow\\text{kovariante Ableitung}\\longrightarrow\\text{Parallelität}\\longrightarrow\\text{Paralleltransport}', '\\text{Zusammenhang}\\longrightarrow\\text{kovariante Ableitung}\\longrightarrow\\text{Parallelität}\\longrightarrow\\text{Paralleltransport}', 'Zusammenfassende Aufbaufolge des Abschnitts.', 'schema', 'original', NULL, NULL, NULL, 'verified', 24),
(851, '3.844', 46, 'Geschlossener Paralleltransport als Tangentialraumendomorphismus', 'T_pM\\xrightarrow{\\;P^\\gamma\\;}T_pM', 'T_pM\\xrightarrow{\\;P^\\gamma\\;}T_pM', 'Geschlossener Weg erzeugt eine lineare Selbstabbildung des Tangentialraumes.', 'schema', 'literature', 78, NULL, NULL, 'verified', 24),
(852, '3.845', 46, 'Geodätische Ausgangsbedingung für den Folgeabschnitt', '\\frac{D\\dot\\gamma}{dt}=0', '\\frac{D\\dot\\gamma}{dt}=0', 'Übergang zur Untersuchung von Geodäten, Exponentialabbildung und Krümmung.', 'model', 'literature', 78, NULL, NULL, 'verified', 24),
(853, '3.846', 47, 'Geodätenbedingung', '\\frac{D\\dot\\gamma}{dt}=0', '\\frac{D\\dot\\gamma}{dt}=0', 'Eine Geodäte transportiert ihren Tangentialvektor parallel entlang sich selbst.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(854, '3.847', 47, 'Tangentialvektor in lokalen Koordinaten', '\\dot\\gamma=\\dot x^i\\frac{\\partial}{\\partial x^i}', '\\dot\\gamma=\\dot x^i\\frac{\\partial}{\\partial x^i}', 'Lokale Darstellung des Tangentialvektors einer Kurve.', 'schema', 'literature', 78, NULL, NULL, 'verified', 25),
(855, '3.848', 47, 'Geodätengleichung in lokalen Koordinaten', '\\ddot x^k+\\Gamma^k_{ij}\\dot x^i\\dot x^j=0', '\\ddot x^k+\\Gamma^k_{ij}\\dot x^i\\dot x^j=0', 'Koordinatenform der Geodätengleichung.', 'model', 'literature', 78, NULL, NULL, 'verified', 25),
(856, '3.849', 47, 'Geodäte und Koordinatengleichung sind verschiedene Objekte', '\\text{Geodäte}\\neq\\text{ihre Koordinatengleichung}', '\\text{Geodäte}\\neq\\text{ihre Koordinatengleichung}', 'Methodologische Trennung zwischen geometrischer Kurve und lokaler Darstellung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(857, '3.850', 47, 'Geodätische Anfangsposition', '\\gamma(0)=p', '\\gamma(0)=p', 'Anfangspunkt einer Geodäte.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(858, '3.851', 47, 'Geodätische Anfangsrichtung', '\\dot\\gamma(0)=v', '\\dot\\gamma(0)=v', 'Anfangstangentialvektor einer Geodäte.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(859, '3.852', 47, 'Geodätisches Anfangswertproblem', '\\gamma_v(0)=p,\\qquad\\dot\\gamma_v(0)=v', '\\gamma_v(0)=p,\\qquad\\dot\\gamma_v(0)=v', 'Anfangsdaten der eindeutig bestimmten maximalen Geodäte.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(860, '3.853', 47, 'Affine Umparametrisierung', 's=at+b,\\qquad a\\neq0', 's=at+b,\\qquad a\\neq0', 'Affine Parameteränderungen erhalten die affine Geodätenform.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(861, '3.854', 47, 'Konstanz des metrischen Selbstproduktes', '\\frac{d}{dt}g(\\dot\\gamma,\\dot\\gamma)=0', '\\frac{d}{dt}g(\\dot\\gamma,\\dot\\gamma)=0', 'Metrischer Betrag der geodätischen Geschwindigkeit ist konstant.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(862, '3.855', 47, 'Herleitung der Konstanz', '\\frac{d}{dt}g(\\dot\\gamma,\\dot\\gamma)=2g\\left(\\frac{D\\dot\\gamma}{dt},\\dot\\gamma\\right)=0', '\\frac{d}{dt}g(\\dot\\gamma,\\dot\\gamma)=2g\\left(\\frac{D\\dot\\gamma}{dt},\\dot\\gamma\\right)=0', 'Folgerung aus Metrikverträglichkeit und Geodätenbedingung.', 'derived', 'literature', 78, NULL, NULL, 'verified', 25),
(863, '3.856', 47, 'Geodäte ist nicht notwendig global kürzeste Verbindung', '\\text{Geodäte}\\not\\Longrightarrow\\text{global kürzeste Verbindung}', '\\text{Geodäte}\\not\\Longrightarrow\\text{global kürzeste Verbindung}', 'Methodologische Nichtimplikation selbst im riemannschen Fall.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(864, '3.857', 47, 'Lorentzsche Geodäte ist nicht euklidisch kürzester Weg', '\\text{lorentzsche Geodäte}\\not\\equiv\\text{euklidisch kürzester Weg}', '\\text{lorentzsche Geodäte}\\not\\equiv\\text{euklidisch kürzester Weg}', 'Methodologische Abgrenzung der lorentzschen Variationsstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(865, '3.858', 47, 'Exponentialabbildung', '\\exp_p(v)=\\gamma_v(1)', '\\exp_p(v)=\\gamma_v(1)', 'Definition der Exponentialabbildung über die Geodäte mit Anfangsvektor v.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(866, '3.859', 47, 'Definitionsbereich der Exponentialabbildung', '\\exp_p:\\mathcal D_p\\subseteq T_pM\\longrightarrow M', '\\exp_p:\\mathcal D_p\\subseteq T_pM\\longrightarrow M', 'Die Exponentialabbildung ist nur auf den bis t=1 fortsetzbaren Anfangsvektoren definiert.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(867, '3.860', 47, 'Skalierungseigenschaft der Exponentialabbildung', '\\exp_p(tv)=\\gamma_v(t)', '\\exp_p(tv)=\\gamma_v(t)', 'Lokale Verbindung radialer Geraden im Tangentialraum mit Geodäten.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(868, '3.861', 47, 'Exponentialabbildung des Nullvektors', '\\exp_p(0)=p', '\\exp_p(0)=p', 'Der Nullvektor wird auf den Basispunkt abgebildet.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(869, '3.862', 47, 'Differential der Exponentialabbildung', 'd(\\exp_p)_0=I_{T_pM}', 'd(\\exp_p)_0=I_{T_pM}', 'Das Differential am Ursprung ist die Identität.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(870, '3.863', 47, 'Normale Umgebung über die Exponentialabbildung', '\\exp_p:V\\longrightarrow U', '\\exp_p:V\\longrightarrow U', 'Diffeomorphe Einschränkung der Exponentialabbildung auf eine sternförmige Umgebung.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(871, '3.864', 47, 'Darstellung eines Punktes in einer normalen Umgebung', 'q=\\exp_p(v)', 'q=\\exp_p(v)', 'Eindeutige geodätische Darstellung in einer normalen Umgebung.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(872, '3.865', 47, 'Tangentialvektor in gewählter Basis', 'v=v^ie_i', 'v=v^ie_i', 'Komponentenzerlegung des Anfangsvektors.', 'schema', 'literature', 78, NULL, NULL, 'verified', 25),
(873, '3.866', 47, 'Normalkoordinaten über Exponentialabbildung', 'q=\\exp_p(v^ie_i)', 'q=\\exp_p(v^ie_i)', 'Lokale Normalkoordinaten um p.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(874, '3.867', 47, 'Verschwinden der Christoffel-Symbole in Normalkoordinaten am Mittelpunkt', '\\Gamma^k_{ij}(p)=0', '\\Gamma^k_{ij}(p)=0', 'Normalkoordinaten normalisieren den Levi-Civita-Zusammenhang am Basispunkt.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(875, '3.868', 47, 'Verschwinden erster Metrikableitungen in Normalkoordinaten', '\\frac{\\partial g_{ij}}{\\partial x^k}(p)=0', '\\frac{\\partial g_{ij}}{\\partial x^k}(p)=0', 'Erste Metrikableitungen verschwinden am Mittelpunkt geeigneter Normalkoordinaten.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(876, '3.869', 47, 'Verschwindende Christoffel-Symbole implizieren keine verschwindende Krümmung', '\\Gamma^k_{ij}(p)=0\\not\\Longrightarrow R(p)=0', '\\Gamma^k_{ij}(p)=0\\not\\Longrightarrow R(p)=0', 'Methodologische Trennung von Koordinatennormalisierung und intrinsischer Krümmung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(877, '3.870', 47, 'Riemannscher Krümmungsoperator', 'R(X,Y)Z=\\nabla_X\\nabla_YZ-\\nabla_Y\\nabla_XZ-\\nabla_{[X,Y]}Z', 'R(X,Y)Z=\\nabla_X\\nabla_YZ-\\nabla_Y\\nabla_XZ-\\nabla_{[X,Y]}Z', 'Definition in der im Abschnitt festgelegten Vorzeichenkonvention.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(878, '3.871', 47, 'Tensorialität im ersten Argument', 'R(fX,Y)Z=fR(X,Y)Z', 'R(fX,Y)Z=fR(X,Y)Z', 'Beispiel der Tensorialität des Krümmungsoperators.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(879, '3.872', 47, 'Antisymmetrie des Krümmungsoperators', 'R(X,Y)Z=-R(Y,X)Z', 'R(X,Y)Z=-R(Y,X)Z', 'Antisymmetrie in den ersten beiden Argumenten.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(880, '3.873', 47, 'Definition der Krümmungskomponenten', 'R\\left(\\frac{\\partial}{\\partial x^i},\\frac{\\partial}{\\partial x^j}\\right)\\frac{\\partial}{\\partial x^k}=R^\\ell{}_{kij}\\frac{\\partial}{\\partial x^\\ell}', 'R\\left(\\frac{\\partial}{\\partial x^i},\\frac{\\partial}{\\partial x^j}\\right)\\frac{\\partial}{\\partial x^k}=R^\\ell{}_{kij}\\frac{\\partial}{\\partial x^\\ell}', 'Lokale Komponenten des Krümmungsoperators.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(881, '3.874', 47, 'Krümmungskomponenten aus Christoffel-Symbolen', 'R^\\ell{}_{kij}=\\frac{\\partial\\Gamma^\\ell_{jk}}{\\partial x^i}-\\frac{\\partial\\Gamma^\\ell_{ik}}{\\partial x^j}+\\Gamma^\\ell_{im}\\Gamma^m_{jk}-\\Gamma^\\ell_{jm}\\Gamma^m_{ik}', 'R^\\ell{}_{kij}=\\frac{\\partial\\Gamma^\\ell_{jk}}{\\partial x^i}-\\frac{\\partial\\Gamma^\\ell_{ik}}{\\partial x^j}+\\Gamma^\\ell_{im}\\Gamma^m_{jk}-\\Gamma^\\ell_{jm}\\Gamma^m_{ik}', 'Lokale Formel für die gewählte Vorzeichenkonvention.', 'derived', 'literature', 78, NULL, NULL, 'verified', 25),
(882, '3.875', 47, 'Vollständig kovarianter Krümmungstensor', 'R(X,Y,Z,W)=g(R(X,Y)Z,W)', 'R(X,Y,Z,W)=g(R(X,Y)Z,W)', 'Absenkung des Ausgangsindex mit der Metrik.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(883, '3.876', 47, 'Kovariante Krümmungskomponenten', 'R_{ijk\\ell}=g_{\\ell m}R^m{}_{kij}', 'R_{ijk\\ell}=g_{\\ell m}R^m{}_{kij}', 'Lokale vollständig kovariante Komponenten in der verwendeten Indexreihenfolge.', 'derived', 'literature', 78, NULL, NULL, 'verified', 25),
(884, '3.877', 47, 'Erste Antisymmetrie', 'R(X,Y,Z,W)=-R(Y,X,Z,W)', 'R(X,Y,Z,W)=-R(Y,X,Z,W)', 'Algebraische Symmetrie des Levi-Civita-Krümmungstensors.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(885, '3.878', 47, 'Zweite Antisymmetrie', 'R(X,Y,Z,W)=-R(X,Y,W,Z)', 'R(X,Y,Z,W)=-R(X,Y,W,Z)', 'Algebraische Symmetrie des Levi-Civita-Krümmungstensors.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(886, '3.879', 47, 'Paarsymmetrie', 'R(X,Y,Z,W)=R(Z,W,X,Y)', 'R(X,Y,Z,W)=R(Z,W,X,Y)', 'Paarsymmetrie des vollständig kovarianten Krümmungstensors.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(887, '3.880', 47, 'Erste Bianchi-Identität', 'R(X,Y)Z+R(Y,Z)X+R(Z,X)Y=0', 'R(X,Y)Z+R(Y,Z)X+R(Z,X)Y=0', 'Zyklische Identität des Levi-Civita-Krümmungstensors.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(888, '3.881', 47, 'Krümmungskomponenten sind keine zusätzlichen Dimensionen', '\\text{viele Krümmungskomponenten}\\not\\Longrightarrow\\text{viele zusätzliche Raumdimensionen}', '\\text{viele Krümmungskomponenten}\\not\\Longrightarrow\\text{viele zusätzliche Raumdimensionen}', 'Methodologische Nichtimplikation zwischen Tensor-Komponentenanzahl und Dimensionszahl.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(889, '3.882', 47, 'Flachheitsbedingung', 'R=0', 'R=0', 'Ein Zusammenhang beziehungsweise eine Levi-Civita-Geometrie ist flach, wenn der Krümmungstensor verschwindet.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(890, '3.883', 47, 'Verschwindende Christoffel-Symbole sind nicht äquivalent zu Flachheit', '\\Gamma(p)=0\\not\\Longrightarrow R(p)=0', '\\Gamma(p)=0\\not\\Longrightarrow R(p)=0', 'Koordinatenabhängige Christoffel-Symbole und intrinsische Krümmung sind verschiedene Ebenen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(891, '3.884', 47, 'Intrinsische Krümmung verlangt keine äußere Verbiegung', '\\text{intrinsische Krümmung}\\not\\Longrightarrow\\text{Verbiegung in einem äußeren Raum}', '\\text{intrinsische Krümmung}\\not\\Longrightarrow\\text{Verbiegung in einem äußeren Raum}', 'Methodologische Nichtimplikation zwischen intrinsischer Geometrie und Einbettungsbild.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(892, '3.885', 47, 'Schnittkrümmung', 'K(\\Pi)=\\frac{g(R(u,v)v,u)}{g(u,u)g(v,v)-g(u,v)^2}', 'K(\\Pi)=\\frac{g(R(u,v)v,u)}{g(u,u)g(v,v)-g(u,v)^2}', 'Schnittkrümmung einer nicht ausgearteten Tangentialebene.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(893, '3.886', 47, 'Nichtausgeartetheit der Tangentialebene', 'g(u,u)g(v,v)-g(u,v)^2\\neq0', 'g(u,u)g(v,v)-g(u,v)^2\\neq0', 'Der Nenner der Schnittkrümmung muss von null verschieden sein.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(894, '3.887', 47, 'Schnittkrümmung als Funktion von Punkt und Ebene', 'K=K(p,\\Pi)', 'K=K(p,\\Pi)', 'Basisunabhängige geometrische Größe einer Tangentialebene.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(895, '3.888', 47, 'Konstante Schnittkrümmung', 'K(\\Pi)=c', 'K(\\Pi)=c', 'Alle zulässigen Tangentialebenen besitzen denselben Krümmungswert c.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(896, '3.889', 47, 'Krümmungstensor bei konstanter Schnittkrümmung', 'R(X,Y)Z=c\\bigl(g(Y,Z)X-g(X,Z)Y\\bigr)', 'R(X,Y)Z=c\\bigl(g(Y,Z)X-g(X,Z)Y\\bigr)', 'Standardform bei konstanter Schnittkrümmung in der gewählten Konvention.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(897, '3.890', 47, 'Operator für die Ricci-Kontraktion', 'Z\\longmapsto R(Z,X)Y', 'Z\\longmapsto R(Z,X)Y', 'Linearer Operator, dessen Spur den Ricci-Tensor definiert.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(898, '3.891', 47, 'Ricci-Tensor', '\\operatorname{Ric}(X,Y)=\\operatorname{tr}\\bigl(Z\\mapsto R(Z,X)Y\\bigr)', '\\operatorname{Ric}(X,Y)=\\operatorname{tr}\\bigl(Z\\mapsto R(Z,X)Y\\bigr)', 'Definition als Kontraktion des Krümmungstensors.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(899, '3.892', 47, 'Symmetrie des Ricci-Tensors', '\\operatorname{Ric}(X,Y)=\\operatorname{Ric}(Y,X)', '\\operatorname{Ric}(X,Y)=\\operatorname{Ric}(Y,X)', 'Symmetrie für den Levi-Civita-Zusammenhang.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(900, '3.893', 47, 'Skalarkrümmung', '\\operatorname{Scal}=\\operatorname{tr}_g\\operatorname{Ric}', '\\operatorname{Scal}=\\operatorname{tr}_g\\operatorname{Ric}', 'Metrische Spur des Ricci-Tensors.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(901, '3.894', 47, 'Skalarkrümmung in Komponenten', '\\operatorname{Scal}=g^{ij}\\operatorname{Ric}_{ij}', '\\operatorname{Scal}=g^{ij}\\operatorname{Ric}_{ij}', 'Lokale Komponentendarstellung der Skalarkrümmung.', 'derived', 'literature', 78, NULL, NULL, 'verified', 25),
(902, '3.895', 47, 'Skalarkrümmung als skalare Funktion', '\\operatorname{Scal}:M\\longrightarrow\\mathbb R', '\\operatorname{Scal}:M\\longrightarrow\\mathbb R', 'Skalarkrümmung ist eine reellwertige Funktion auf M.', 'schema', 'literature', 78, NULL, NULL, 'verified', 25),
(903, '3.896', 47, 'Skalarkrümmung bestimmt nicht den vollständigen Krümmungstensor', '\\operatorname{Scal}\\text{ gegeben}\\not\\Longrightarrow R\\text{ vollständig bestimmt}', '\\operatorname{Scal}\\text{ gegeben}\\not\\Longrightarrow R\\text{ vollständig bestimmt}', 'Kontraktion verwirft im Allgemeinen Krümmungsinformation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(904, '3.897', 47, 'Skalarkrümmung erhöht die Mannigfaltigkeitsdimension nicht', '\\operatorname{Scal}:M\\to\\mathbb R\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', '\\operatorname{Scal}:M\\to\\mathbb R\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', 'Formal korrigierte Nichtimplikation: Eine skalare Krümmungsfunktion erzeugt keine neue Koordinatenrichtung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(905, '3.898', 47, 'Krümmung und infinitesimaler Schleifentransport', '\\text{Paralleltransport um kleine Schleife}\\longrightarrow\\text{Abweichung vom Ausgangsvektor}\\longrightarrow R', '\\text{Paralleltransport um kleine Schleife}\\longrightarrow\\text{Abweichung vom Ausgangsvektor}\\longrightarrow R', 'Didaktische Beziehung zwischen Krümmung und infinitesimaler Wegabhängigkeit.', 'schema', 'adapted', 78, NULL, NULL, 'verified', 25),
(906, '3.899', 47, 'Jacobi-Gleichung', '\\frac{D^2J}{dt^2}+R(J,\\dot\\gamma)\\dot\\gamma=0', '\\frac{D^2J}{dt^2}+R(J,\\dot\\gamma)\\dot\\gamma=0', 'Definition eines Jacobi-Feldes entlang einer Geodäte.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(907, '3.900', 47, 'Krümmung und relative Geodätenentwicklung', '\\text{Krümmung}\\longrightarrow\\text{relative geodätische Entwicklung}', '\\text{Krümmung}\\longrightarrow\\text{relative geodätische Entwicklung}', 'Didaktische Einordnung der Jacobi-Gleichung.', 'schema', 'adapted', 78, NULL, NULL, 'verified', 25),
(908, '3.901', 47, 'Jacobi-Gleichung als relative Beschleunigungsform', '\\frac{D^2J}{dt^2}=-R(J,\\dot\\gamma)\\dot\\gamma', '\\frac{D^2J}{dt^2}=-R(J,\\dot\\gamma)\\dot\\gamma', 'Umgestellte Jacobi-Gleichung.', 'derived', 'literature', 78, NULL, NULL, 'verified', 25),
(909, '3.902', 47, 'Krümmungsterm ist nicht automatisch physikalische Kraft', 'R(J,\\dot\\gamma)\\dot\\gamma\\not\\equiv\\text{physikalische Kraft}', 'R(J,\\dot\\gamma)\\dot\\gamma\\not\\equiv\\text{physikalische Kraft}', 'Formal präzisiert: Der geometrische Krümmungsterm ist ohne zusätzliche Modellinterpretation nicht mit einer physikalischen Kraft gleichzusetzen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(910, '3.903', 47, 'Geometrische Geodätenabweichung impliziert keine bereits interpretierte Wechselwirkung', '\\text{geometrische Geodätenabweichung}\\not\\Longrightarrow\\text{bereits interpretierte physikalische Wechselwirkung}', '\\text{geometrische Geodätenabweichung}\\not\\Longrightarrow\\text{bereits interpretierte physikalische Wechselwirkung}', 'Methodologische Nichtimplikation zwischen Geometrie und physikalischer Interpretation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(911, '3.904', 47, 'Parameterbereich geodätischer Vollständigkeit', 'I=\\mathbb R', 'I=\\mathbb R', 'Jede maximal fortgesetzte Geodäte ist für alle reellen affinen Parameterwerte definiert.', 'definition', 'literature', 78, NULL, NULL, 'verified', 25),
(912, '3.905', 47, 'Riemannsche Vollständigkeitsäquivalenz überträgt sich nicht allgemein auf Lorentzgeometrie', '\\text{riemannsche Vollständigkeitsäquivalenz}\\not\\Longrightarrow\\text{allgemeine lorentzsche Vollständigkeitsäquivalenz}', '\\text{riemannsche Vollständigkeitsäquivalenz}\\not\\Longrightarrow\\text{allgemeine lorentzsche Vollständigkeitsäquivalenz}', 'Methodologische Grenze der Übertragung positiv definiter Vollständigkeitssätze.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(913, '3.906', 47, 'Endlicher Koordinatenbereich impliziert keine geodätische Unvollständigkeit', '\\text{endlicher Koordinatenbereich}\\not\\Longrightarrow\\text{geodätische Unvollständigkeit}', '\\text{endlicher Koordinatenbereich}\\not\\Longrightarrow\\text{geodätische Unvollständigkeit}', 'Formal korrigierte Nichtimplikation zwischen Kartenbereich und globaler Fortsetzbarkeit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(914, '3.907', 47, 'Nichtverschwindende Krümmung impliziert keine geodätische Unvollständigkeit', 'R\\neq0\\not\\Longrightarrow\\text{geodätisch unvollständig}', 'R\\neq0\\not\\Longrightarrow\\text{geodätisch unvollständig}', 'Lokale Krümmung und globale Vollständigkeit sind unterschiedliche Eigenschaften.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(915, '3.908', 47, 'Flachheit impliziert keine globale geodätische Vollständigkeit', 'R=0\\not\\Longrightarrow\\text{globale geodätische Vollständigkeit}', 'R=0\\not\\Longrightarrow\\text{globale geodätische Vollständigkeit}', 'Auch flache Geometrien können global unvollständig sein.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(916, '3.909', 47, 'Geometrische Krümmung ist nicht automatisch Energie', 'R\\text{ geometrisch}\\not\\Longrightarrow R\\text{ Energie}', 'R\\text{ geometrisch}\\not\\Longrightarrow R\\text{ Energie}', 'Formal korrigierte Nichtimplikation zwischen geometrischem Tensor und physikalischer Energie.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(917, '3.910', 47, 'Skalarkrümmung ist nicht identisch mit Information', '\\operatorname{Scal}\\not\\equiv\\text{Information}', '\\operatorname{Scal}\\not\\equiv\\text{Information}', 'Methodologische Trennung geometrischer und informationstheoretischer Größen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(918, '3.911', 47, 'Geometrie bestimmt keinen eindeutigen dynamischen Fluss', '(M,g,R)\\text{ gegeben}\\not\\Longrightarrow\\Phi_t\\text{ eindeutig gegeben}', '(M,g,R)\\text{ gegeben}\\not\\Longrightarrow\\Phi_t\\text{ eindeutig gegeben}', 'Geometrische Struktur und allgemeines Evolutionsgesetz sind getrennte Modellbestandteile.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(919, '3.912', 47, 'Affiner Geodätenparameter ist nicht automatisch physikalische Zeit', 't\\text{ affiner Parameter}\\not\\Longrightarrow t\\text{ physikalische Zeit}', 't\\text{ affiner Parameter}\\not\\Longrightarrow t\\text{ physikalische Zeit}', 'Formal korrigierte Nichtimplikation zwischen mathematischer Parametrisierung und physikalischer Zeit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(920, '3.913', 47, 'Lichtartige Geodäte besitzt verschwindendes metrisches Selbstprodukt', 'g(\\dot\\gamma,\\dot\\gamma)=0', 'g(\\dot\\gamma,\\dot\\gamma)=0', 'Kennzeichnende Eigenschaft lichtartiger Geodäten.', 'metric', 'literature', 78, NULL, NULL, 'verified', 25),
(921, '3.914', 47, 'Dimension von Tangentialraum und Mannigfaltigkeit', '\\dim T_pM=\\dim M=n', '\\dim T_pM=\\dim M=n', 'Exponentialabbildung verbindet gleichdimensionale lokale Strukturen.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 25),
(922, '3.915', 47, 'Exponentialabbildung erzeugt keine zusätzliche Dimension', '\\exp_p\\not\\Longrightarrow\\text{zusätzliche geometrische Dimension}', '\\exp_p\\not\\Longrightarrow\\text{zusätzliche geometrische Dimension}', 'Methodologische Nichtimplikation für Dimensionsargumente.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(923, '3.916', 47, 'Zusätzlicher Tangentialvektor erhöht die Mannigfaltigkeitsdimension nicht', 'v\\text{ zusätzlicher Vektor}\\not\\Longrightarrow\\dim M\\text{ erhöht}', 'v\\text{ zusätzlicher Vektor}\\not\\Longrightarrow\\dim M\\text{ erhöht}', 'Ein Vektor ist Element eines bereits vorhandenen Tangentialraumes.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(924, '3.917', 47, 'Bekannte Krümmung bestimmt nicht die globale Kausalstruktur', 'R\\text{ bekannt}\\not\\Longrightarrow\\text{globale Kausalstruktur bekannt}', 'R\\text{ bekannt}\\not\\Longrightarrow\\text{globale Kausalstruktur bekannt}', 'Formal korrigierte Nichtimplikation zwischen lokaler Krümmungsinformation und globaler Kausalstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(925, '3.918', 47, 'Krümmungstensor ist nicht automatisch Kohärenztensor', 'R\\text{ Krümmungstensor}\\not\\Longrightarrow R\\text{ Kohärenztensor}', 'R\\text{ Krümmungstensor}\\not\\Longrightarrow R\\text{ Kohärenztensor}', 'Methodologische Trennung von Geometrie und FRZK-Kohärenz.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(926, '3.919', 47, 'Skalarkrümmung ist nicht automatisch Kohärenzmaß', '\\operatorname{Scal}\\text{ Skalarkrümmung}\\not\\Longrightarrow\\operatorname{Scal}\\text{ Kohärenzmaß}', '\\operatorname{Scal}\\text{ Skalarkrümmung}\\not\\Longrightarrow\\operatorname{Scal}\\text{ Kohärenzmaß}', 'Methodologische Trennung von geometrischem Skalar und FRZK-Kohärenz.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(927, '3.920', 47, 'Geodätisch-exponentielle Strukturkette', '(p,v)\\longrightarrow\\gamma_v\\longrightarrow\\exp_p(v)\\longrightarrow\\text{lokale Geometrie}', '(p,v)\\longrightarrow\\gamma_v\\longrightarrow\\exp_p(v)\\longrightarrow\\text{lokale Geometrie}', 'Didaktische Verbindung von Anfangsdaten, Geodäte und Exponentialabbildung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(928, '3.921', 47, 'Krümmungskontraktionskette', '\\nabla\\longrightarrow R\\longrightarrow\\operatorname{Ric}\\longrightarrow\\operatorname{Scal}', '\\nabla\\longrightarrow R\\longrightarrow\\operatorname{Ric}\\longrightarrow\\operatorname{Scal}', 'Didaktische Verbindung von Zusammenhang und kontrahierten Krümmungsgrößen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(929, '3.922', 47, 'Exponentialabbildung vom Tangentialraum zur Mannigfaltigkeit', 'T_pM\\xrightarrow{\\;\\exp_p\\;}M', 'T_pM\\xrightarrow{\\;\\exp_p\\;}M', 'Didaktische Darstellung der lokalen geodätischen Abbildung.', 'schema', 'literature', 78, NULL, NULL, 'verified', 25),
(930, '3.923', 47, 'Kontraktionshierarchie der Krümmung', 'R\\longrightarrow\\operatorname{Ric}\\longrightarrow\\operatorname{Scal}', 'R\\longrightarrow\\operatorname{Ric}\\longrightarrow\\operatorname{Scal}', 'Didaktische Hierarchie der Krümmungsinformation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(931, '3.924', 47, 'Krümmung und Jacobi-Struktur', 'R\\longrightarrow\\text{Jacobi-Gleichung}\\longrightarrow\\text{relative Geodätenentwicklung}', 'R\\longrightarrow\\text{Jacobi-Gleichung}\\longrightarrow\\text{relative Geodätenentwicklung}', 'Didaktische Verbindung von Krümmung und geodätischer Variation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(932, '3.925', 47, 'Gesamtstruktur der intrinsischen Geometrie', '\\text{Metrik}\\longrightarrow\\text{Levi-Civita-Zusammenhang}\\longrightarrow\\begin{cases}\\text{Geodäten},\\\\\\text{Paralleltransport},\\\\\\text{Krümmung}.\\end{cases}', '\\text{Metrik}\\longrightarrow\\text{Levi-Civita-Zusammenhang}\\longrightarrow\\begin{cases}\\text{Geodäten},\\\\\\text{Paralleltransport},\\\\\\text{Krümmung}.\\end{cases}', 'Zusammenfassende Struktur der intrinsischen pseudo-riemannschen Geometrie.', 'schema', 'original', NULL, NULL, NULL, 'verified', 25),
(933, '3.926', 48, 'Kausaler Tangentialvektor', 'g_p(v,v)\\leq0,\\qquad v\\neq0', 'g_p(v,v)\\leq0,\\qquad v\\neq0', 'Zeitartige und lichtartige Nichtnullvektoren sind kausal.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(934, '3.927', 48, 'Lichtartiger Tangentialvektor', 'g_p(v,v)=0,\\qquad v\\neq0', 'g_p(v,v)=0,\\qquad v\\neq0', 'Lichtartige Nichtnullrichtung.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(935, '3.928', 48, 'Zeitartiger Tangentialvektor', 'g_p(v,v)<0', 'g_p(v,v)<0', 'Zeitartige Richtung bei Signatur (-,+,...,+).', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(936, '3.929', 48, 'Null- beziehungsweise Lichtkegel', '\\mathcal N_p=\\left\\{v\\in T_pM\\setminus\\{0\\}\\;\\middle|\\;g_p(v,v)=0\\right\\}', '\\mathcal N_p=\\left\\{v\\in T_pM\\setminus\\{0\\}\\;\\middle|\\;g_p(v,v)=0\\right\\}', 'Menge aller nichtverschwindenden lichtartigen Tangentialvektoren.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(937, '3.930', 48, 'Zeitartiges Orientierungsfeld', 'T_p\\in T_pM,\\qquad g_p(T_p,T_p)<0\\qquad\\text{für alle }p\\in M', 'T_p\\in T_pM,\\qquad g_p(T_p,T_p)<0\\qquad\\text{für alle }p\\in M', 'Ein globales zeitartiges Vektorfeld ermöglicht eine Zeitorientierung.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(938, '3.931', 48, 'Zukunftsgerichteter kausaler Vektor', 'g_p(v,T_p)<0', 'g_p(v,T_p)<0', 'Zukunftsrichtung relativ zum gewählten zeitartigen Orientierungsfeld.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(939, '3.932', 48, 'Vergangenheitsgerichteter kausaler Vektor', 'g_p(v,T_p)>0', 'g_p(v,T_p)>0', 'Vergangenheitsrichtung relativ zum gewählten Orientierungsfeld.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(940, '3.933', 48, 'Auswahl einer zukünftigen Kegelkomponente', '\\text{eine Kegelkomponente}\\longmapsto\\text{„Zukunft“}', '\\text{eine Kegelkomponente}\\longmapsto\\text{„Zukunft“}', 'Schematische Darstellung der Zeitorientierung.', 'schema', 'adapted', 78, NULL, NULL, 'verified', 26),
(941, '3.934', 48, 'Zeitorientierung impliziert keinen thermodynamischen Zeitpfeil', '\\text{Zeitorientierung}\\not\\Longrightarrow\\text{thermodynamischer Zeitpfeil}', '\\text{Zeitorientierung}\\not\\Longrightarrow\\text{thermodynamischer Zeitpfeil}', 'Methodologische Nichtimplikation zwischen geometrischer Orientierung und thermodynamischer Irreversibilität.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(942, '3.935', 48, 'Zukunftsgerichtete zeitartige Kurve', 'g(\\dot\\gamma,\\dot\\gamma)<0', 'g(\\dot\\gamma,\\dot\\gamma)<0', 'Metrische Bedingung einer zeitartigen Kurve.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(943, '3.936', 48, 'Zukunftsgerichtete kausale Kurve', 'g(\\dot\\gamma,\\dot\\gamma)\\leq0', 'g(\\dot\\gamma,\\dot\\gamma)\\leq0', 'Metrische Bedingung einer kausalen Kurve.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(944, '3.937', 48, 'Zeitartig impliziert kausal', '\\text{zeitartig}\\Longrightarrow\\text{kausal}', '\\text{zeitartig}\\Longrightarrow\\text{kausal}', 'Jede zeitartige Richtung ist kausal.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(945, '3.938', 48, 'Kausal impliziert nicht zeitartig', '\\text{kausal}\\not\\Longrightarrow\\text{zeitartig}', '\\text{kausal}\\not\\Longrightarrow\\text{zeitartig}', 'Lichtartige Richtungen sind kausal, aber nicht zeitartig.', 'schema', 'literature', 78, NULL, NULL, 'verified', 26),
(946, '3.939', 48, 'Chronologische Zukunft', 'I^+(p)=\\left\\{q\\in M\\;\\middle|\\;\\text{es existiert eine zukunftsgerichtete zeitartige Kurve von }p\\text{ nach }q\\right\\}', 'I^+(p)=\\left\\{q\\in M\\;\\middle|\\;\\text{es existiert eine zukunftsgerichtete zeitartige Kurve von }p\\text{ nach }q\\right\\}', 'Definition der chronologischen Zukunft.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(947, '3.940', 48, 'Chronologische Vergangenheit', 'I^-(p)=\\left\\{q\\in M\\;\\middle|\\;\\text{es existiert eine zukunftsgerichtete zeitartige Kurve von }q\\text{ nach }p\\right\\}', 'I^-(p)=\\left\\{q\\in M\\;\\middle|\\;\\text{es existiert eine zukunftsgerichtete zeitartige Kurve von }q\\text{ nach }p\\right\\}', 'Definition der chronologischen Vergangenheit.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(948, '3.941', 48, 'Chronologische Relation', 'p\\ll q\\Longleftrightarrow q\\in I^+(p)', 'p\\ll q\\Longleftrightarrow q\\in I^+(p)', 'Relation zeitartiger Erreichbarkeit.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(949, '3.942', 48, 'Offenheit der chronologischen Zukunft', 'I^+(p)\\subseteq M\\quad\\text{offen}', 'I^+(p)\\subseteq M\\quad\\text{offen}', 'I^+(p) ist offen.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(950, '3.943', 48, 'Kausale Zukunft', 'J^+(p)=\\{p\\}\\cup\\left\\{q\\in M\\;\\middle|\\;\\text{eine zukunftsgerichtete kausale Kurve führt von }p\\text{ nach }q\\right\\}', 'J^+(p)=\\{p\\}\\cup\\left\\{q\\in M\\;\\middle|\\;\\text{eine zukunftsgerichtete kausale Kurve führt von }p\\text{ nach }q\\right\\}', 'Definition der kausalen Zukunft.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(951, '3.944', 48, 'Kausale Vergangenheit', 'J^-(p)=\\{p\\}\\cup\\left\\{q\\in M\\;\\middle|\\;\\text{eine zukunftsgerichtete kausale Kurve führt von }q\\text{ nach }p\\right\\}', 'J^-(p)=\\{p\\}\\cup\\left\\{q\\in M\\;\\middle|\\;\\text{eine zukunftsgerichtete kausale Kurve führt von }q\\text{ nach }p\\right\\}', 'Definition der kausalen Vergangenheit.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(952, '3.945', 48, 'Kausale Relation', 'p\\leq q\\Longleftrightarrow q\\in J^+(p)', 'p\\leq q\\Longleftrightarrow q\\in J^+(p)', 'Relation kausaler Erreichbarkeit mit zugelassener Gleichheit.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(953, '3.946', 48, 'Chronologische Zukunft liegt in kausaler Zukunft', 'I^+(p)\\subseteq J^+(p)', 'I^+(p)\\subseteq J^+(p)', 'Zeitartige Erreichbarkeit ist ein Spezialfall kausaler Erreichbarkeit.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(954, '3.947', 48, 'Kausal aber nicht chronologisch erreichbar', 'q\\in J^+(p)\\setminus I^+(p)', 'q\\in J^+(p)\\setminus I^+(p)', 'Lichtartiger Randfall der kausalen Erreichbarkeit.', 'schema', 'literature', 78, NULL, NULL, 'verified', 26),
(955, '3.948', 48, 'Horismosrelation', 'p\\to q\\Longleftrightarrow q\\in J^+(p)\\setminus I^+(p)', 'p\\to q\\Longleftrightarrow q\\in J^+(p)\\setminus I^+(p)', 'Kausale, aber nicht chronologische Randrelation.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(956, '3.949', 48, 'Transitivität der chronologischen Relation', 'p\\ll q,\\qquad q\\ll r\\Longrightarrow p\\ll r', 'p\\ll q,\\qquad q\\ll r\\Longrightarrow p\\ll r', 'Chronologische Relation ist transitiv.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(957, '3.950', 48, 'Transitivität der kausalen Relation', 'p\\leq q,\\qquad q\\leq r\\Longrightarrow p\\leq r', 'p\\leq q,\\qquad q\\leq r\\Longrightarrow p\\leq r', 'Kausale Relation ist transitiv.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(958, '3.951', 48, 'Push-up: kausal gefolgt von zeitartig', 'p\\leq q\\quad\\text{und}\\quad q\\ll r\\Longrightarrow p\\ll r', 'p\\leq q\\quad\\text{und}\\quad q\\ll r\\Longrightarrow p\\ll r', 'Eine zeitartige Teilstrecke macht die zusammengesetzte Verbindung zeitartig.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(959, '3.952', 48, 'Push-up: zeitartig gefolgt von kausal', 'p\\ll q\\quad\\text{und}\\quad q\\leq r\\Longrightarrow p\\ll r', 'p\\ll q\\quad\\text{und}\\quad q\\leq r\\Longrightarrow p\\ll r', 'Zweite Form der Push-up-Eigenschaft.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(960, '3.953', 48, 'Kausale Zukunft ist nicht ohne Zusatzannahmen abgeschlossen', 'J^+(p)\\text{ definiert}\\not\\Longrightarrow J^+(p)\\text{ abgeschlossen}', 'J^+(p)\\text{ definiert}\\not\\Longrightarrow J^+(p)\\text{ abgeschlossen}', 'Formal präzisiert: Die Definition der kausalen Zukunft garantiert im Allgemeinen keine Abgeschlossenheit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(961, '3.954', 48, 'Geschlossene zeitartige Kurve', '\\gamma(a)=\\gamma(b)\\qquad(a<b)', '\\gamma(a)=\\gamma(b)\\qquad(a<b)', 'Eine zeitartige Kurve kehrt zu demselben Mannigfaltigkeitspunkt zurück.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(962, '3.955', 48, 'Chronologischer Selbstbezug durch geschlossene zeitartige Kurve', 'p\\ll p', 'p\\ll p', 'Eine geschlossene zeitartige Kurve durch p erzeugt p<<p.', 'schema', 'literature', 78, NULL, NULL, 'verified', 26),
(963, '3.956', 48, 'Lorentzsignatur schließt geschlossene zeitartige Kurven nicht aus', '\\text{lorentzsche Mannigfaltigkeit}\\not\\Longrightarrow\\text{keine geschlossenen zeitartigen Kurven}', '\\text{lorentzsche Mannigfaltigkeit}\\not\\Longrightarrow\\text{keine geschlossenen zeitartigen Kurven}', 'Globale Chronologie folgt nicht aus der lokalen Lorentzsignatur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26);
INSERT INTO `equations` (`equation_id`, `equation_number`, `section_id`, `title`, `equation_latex`, `word_latex`, `plain_description`, `equation_type`, `provenance`, `source_id`, `derivation`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(964, '3.957', 48, 'Chronologiebedingung', 'p\\notin I^+(p)\\qquad\\text{für alle }p\\in M', 'p\\notin I^+(p)\\qquad\\text{für alle }p\\in M', 'Keine geschlossene zeitartige Kurve.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(965, '3.958', 48, 'Irreflexivität der chronologischen Relation', 'p\\not\\ll p', 'p\\not\\ll p', 'Chronologische Mannigfaltigkeiten besitzen keinen chronologischen Selbstbezug.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(966, '3.959', 48, 'Chronologie impliziert nicht Kausalität', '\\text{chronologisch}\\not\\Longrightarrow\\text{kausal}', '\\text{chronologisch}\\not\\Longrightarrow\\text{kausal}', 'Geschlossene lichtartige oder andere kausale Kurven können trotz Chronologiebedingung auftreten.', 'schema', 'literature', 78, NULL, NULL, 'verified', 26),
(967, '3.960', 48, 'Gegenseitige kausale Erreichbarkeit verschiedener Punkte ist in kausalen Mannigfaltigkeiten ausgeschlossen', 'p\\leq q,\\qquad q\\leq p', 'p\\leq q,\\qquad q\\leq p', 'Ausgangskonstellation für die Antisymmetrie der kausalen Relation.', 'schema', 'literature', 78, NULL, NULL, 'verified', 26),
(968, '3.961', 48, 'Antisymmetrie der kausalen Relation', 'p\\leq q,\\quad q\\leq p\\Longrightarrow p=q', 'p\\leq q,\\quad q\\leq p\\Longrightarrow p=q', 'Unter der Kausalitätsbedingung ist die kausale Relation antisymmetrisch.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(969, '3.962', 48, 'Lokale Bedingung starker Kausalität', 'p\\in V\\subseteq U\\quad\\text{mit kausal kontrollierter Durchquerung}', 'p\\in V\\subseteq U\\quad\\text{mit kausal kontrollierter Durchquerung}', 'Schematische Darstellung starker Kausalität.', 'definition', 'adapted', 78, NULL, NULL, 'verified', 26),
(970, '3.963', 48, 'Starke Kausalität impliziert Kausalität', '\\text{stark kausal}\\Longrightarrow\\text{kausal}', '\\text{stark kausal}\\Longrightarrow\\text{kausal}', 'Hierarchische Implikation.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(971, '3.964', 48, 'Kausalität impliziert nicht starke Kausalität', '\\text{kausal}\\not\\Longrightarrow\\text{stark kausal}', '\\text{kausal}\\not\\Longrightarrow\\text{stark kausal}', 'Die Umkehrung der Kausalitätshierarchie gilt nicht allgemein.', 'schema', 'literature', 78, NULL, NULL, 'verified', 26),
(972, '3.965', 48, 'Kausaler Diamant', 'J^+(p)\\cap J^-(q)', 'J^+(p)\\cap J^-(q)', 'Schnitt aus kausaler Zukunft von p und kausaler Vergangenheit von q.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(973, '3.966', 48, 'Punkt im kausalen Diamanten', 'r\\in J^+(p)\\cap J^-(q)\\Longleftrightarrow p\\leq r\\leq q', 'r\\in J^+(p)\\cap J^-(q)\\Longleftrightarrow p\\leq r\\leq q', 'Charakterisierung eines Punktes im kausalen Diamanten.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(974, '3.967', 48, 'Kompakter kausaler Diamant', 'J^+(p)\\cap J^-(q)\\text{ kompakt}', 'J^+(p)\\cap J^-(q)\\text{ kompakt}', 'Kompaktheitsbedingung der klassischen globalen Hyperbolizität.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(975, '3.968', 48, 'Globale Hyperbolizität impliziert starke Kausalität', '\\text{global hyperbolisch}\\Longrightarrow\\text{stark kausal}', '\\text{global hyperbolisch}\\Longrightarrow\\text{stark kausal}', 'Erste Stufe der hier verwendeten Kausalitätshierarchie.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(976, '3.969', 48, 'Globale Hyperbolizität impliziert Kausalität und Chronologie', '\\text{global hyperbolisch}\\Longrightarrow\\text{kausal}\\Longrightarrow\\text{chronologisch}', '\\text{global hyperbolisch}\\Longrightarrow\\text{kausal}\\Longrightarrow\\text{chronologisch}', 'Weitere Folgerungen der Kausalitätshierarchie.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(977, '3.970', 48, 'Kausalitätshierarchie', '\\text{globale Hyperbolizität}\\Longrightarrow\\text{starke Kausalität}\\Longrightarrow\\text{Kausalität}\\Longrightarrow\\text{Chronologie}', '\\text{globale Hyperbolizität}\\Longrightarrow\\text{starke Kausalität}\\Longrightarrow\\text{Kausalität}\\Longrightarrow\\text{Chronologie}', 'Zusammenfassende Hierarchie der im Abschnitt verwendeten globalen Bedingungen.', 'schema', 'literature', 78, NULL, NULL, 'verified', 26),
(978, '3.971', 48, 'Lorentzindex impliziert keine globale Hyperbolizität', '\\operatorname{ind}(g)=1\\not\\Longrightarrow\\text{globale Hyperbolizität}', '\\operatorname{ind}(g)=1\\not\\Longrightarrow\\text{globale Hyperbolizität}', 'Lokale Signatur legt keine globale Kausalitätsstufe fest.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(979, '3.972', 48, 'Lokale Lichtkegel bestimmen keine einfache globale Kausalordnung', '\\text{lokale Lichtkegelstruktur}\\not\\Longrightarrow\\text{vollständig bestimmte einfache globale Kausalordnung}', '\\text{lokale Lichtkegelstruktur}\\not\\Longrightarrow\\text{vollständig bestimmte einfache globale Kausalordnung}', 'Topologie und globale Geometrie beeinflussen die kausale Gesamtstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(980, '3.973', 48, 'Positive konforme Skalierung', '\\widetilde g=\\Omega^2g\\qquad\\text{mit}\\qquad\\Omega:M\\to(0,\\infty)', '\\widetilde g=\\Omega^2g\\qquad\\text{mit}\\qquad\\Omega:M\\to(0,\\infty)', 'Definition einer positiven konformen Skalierung der Lorentzmetrik.', 'metric', 'literature', 78, NULL, NULL, 'verified', 26),
(981, '3.974', 48, 'Selbstprodukt unter konformer Skalierung', '\\widetilde g(v,v)=\\Omega^2g(v,v)', '\\widetilde g(v,v)=\\Omega^2g(v,v)', 'Positive Skalierung erhält das Vorzeichen des Selbstproduktes.', 'derived', 'literature', 78, NULL, NULL, 'verified', 26),
(982, '3.975', 48, 'Konforme Erhaltung der Vorzeichenklasse', '\\operatorname{sgn}\\widetilde g(v,v)=\\operatorname{sgn}g(v,v)', '\\operatorname{sgn}\\widetilde g(v,v)=\\operatorname{sgn}g(v,v)', 'Zeitartige, lichtartige und raumartige Klassen bleiben erhalten.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 26),
(983, '3.976', 48, 'Konforme Klasse bestimmt die Kegel-Kausalstruktur', '[g]\\longrightarrow\\text{Kausalstruktur}', '[g]\\longrightarrow\\text{Kausalstruktur}', 'Schematische Zuordnung der positiven konformen Metrikklasse zur Kegelstruktur.', 'schema', 'adapted', 78, NULL, NULL, 'verified', 26),
(984, '3.977', 48, 'Gleiche Kausalstruktur impliziert nicht identische Metrik', '\\text{gleiche Kausalstruktur}\\not\\Longrightarrow g=\\widetilde g', '\\text{gleiche Kausalstruktur}\\not\\Longrightarrow g=\\widetilde g', 'Konform verwandte Metriken können dieselbe Kausalstruktur besitzen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(985, '3.978', 48, 'Konforme Kausalstruktur ist nicht vollständige metrische Struktur', '\\text{konforme Kausalstruktur}\\neq\\text{vollständige metrische Struktur}', '\\text{konforme Kausalstruktur}\\neq\\text{vollständige metrische Struktur}', 'Formal präzisiert: Kegelstruktur und vollständige metrische Messstruktur sind verschiedene Informationsstufen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(986, '3.979', 48, 'Kausale Relation zwischen zwei Punkten', 'p\\leq q', 'p\\leq q', 'Geometrische kausale Erreichbarkeit.', 'schema', 'literature', 78, NULL, NULL, 'verified', 26),
(987, '3.980', 48, 'Kausale Erreichbarkeit bestimmt keine konkrete Flussentwicklung', 'p\\leq q\\not\\Longrightarrow\\exists\\,t:\\Phi_t(p)=q', 'p\\leq q\\not\\Longrightarrow\\exists\\,t:\\Phi_t(p)=q', 'Geometrische Zulässigkeit und dynamische Realisierung sind verschiedene Aussagen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(988, '3.981', 48, 'Dynamische Trajektorie ist nicht automatisch lorentzsch kausal', '\\text{dynamische Trajektorie}\\not\\Longrightarrow\\text{lorentzsch kausale Kurve}', '\\text{dynamische Trajektorie}\\not\\Longrightarrow\\text{lorentzsch kausale Kurve}', 'Ein abstrakter Fluss muss die lorentzsche Kegelbedingung nicht erfüllen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(989, '3.982', 48, 'Geometrische Kausalrelation impliziert keine konkrete Ursache', 'p\\leq q\\not\\Longrightarrow p\\text{ verursacht }q', 'p\\leq q\\not\\Longrightarrow p\\text{ verursacht }q', 'Formal korrigierte Nichtimplikation zwischen kausaler Erreichbarkeit und tatsächlicher Ursache-Wirkungs-Beziehung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(990, '3.983', 48, 'Lorentzsche Kausalrelation ist nicht vollständige physikalische Kausalität', '\\text{lorentzsche Kausalrelation}\\not\\equiv\\text{vollständige physikalische Kausalität}', '\\text{lorentzsche Kausalrelation}\\not\\equiv\\text{vollständige physikalische Kausalität}', 'Methodologische Trennung geometrischer und physikalischer Kausalitätsbegriffe.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(991, '3.984', 48, 'Kausale Zukunft ist keine eindeutige Vorhersage', 'q\\in J^+(p)\\not\\Longrightarrow\\text{Zustand bei }q\\text{ aus }p\\text{ eindeutig bestimmt}', 'q\\in J^+(p)\\not\\Longrightarrow\\text{Zustand bei }q\\text{ aus }p\\text{ eindeutig bestimmt}', 'Geometrische Erreichbarkeit impliziert keine deterministische Vorhersagbarkeit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(992, '3.985', 48, 'Chronologische Zukunft ist nicht die Menge tatsächlich zukünftiger Systemzustände', 'I^+(p)\\not\\equiv\\text{tatsächliche zukünftige Systemzustände}', 'I^+(p)\\not\\equiv\\text{tatsächliche zukünftige Systemzustände}', 'Geometrische Zukunftsmenge und reale Dynamik sind verschiedene Objekte.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(993, '3.986', 48, 'Zeitorientierung impliziert keine globale Zeitkoordinate', '\\text{Zeitorientierung}\\not\\Longrightarrow\\text{globale Zeitkoordinate}', '\\text{Zeitorientierung}\\not\\Longrightarrow\\text{globale Zeitkoordinate}', 'Eine globale Kegelorientierung ist keine Kartenkoordinate.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(994, '3.987', 48, 'Koordinatenname t garantiert keine globale physikalische Zeit', 'x^0=t\\not\\Longrightarrow t\\text{ ist global zulässige physikalische Zeit}', 'x^0=t\\not\\Longrightarrow t\\text{ ist global zulässige physikalische Zeit}', 'Benennung einer Koordinate ersetzt keine globale kausale Prüfung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(995, '3.988', 48, 'Kausalrelation als Teilmenge des kartesischen Produkts', 'J^+\\subseteq M\\times M', 'J^+\\subseteq M\\times M', 'Kausale Relation ist eine Relation auf der bereits vorhandenen Mannigfaltigkeit.', 'definition', 'literature', 78, NULL, NULL, 'verified', 26),
(996, '3.989', 48, 'Kausalrelation erhöht die Mannigfaltigkeitsdimension nicht', '\\text{Kausalrelation}\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', '\\text{Kausalrelation}\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', 'Eine Relation auf M×M ist keine zusätzliche Zustandskoordinate.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(997, '3.990', 48, 'Zukünftige und vergangene Kegelkomponente', '\\mathcal C_p^+\\qquad\\text{und}\\qquad\\mathcal C_p^-', '\\mathcal C_p^+\\qquad\\text{und}\\qquad\\mathcal C_p^-', 'Bezeichnung der beiden orientierten zeitartigen Kegelkomponenten.', 'schema', 'literature', 78, NULL, NULL, 'verified', 26),
(998, '3.991', 48, 'Zeitorientierung erzeugt keine zusätzliche Zeitdimension', '\\text{Wahl von }\\mathcal C_p^+\\not\\Longrightarrow\\text{zusätzliche Zeitdimension}', '\\text{Wahl von }\\mathcal C_p^+\\not\\Longrightarrow\\text{zusätzliche Zeitdimension}', 'Die Orientierung klassifiziert vorhandene Richtungen.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(999, '3.992', 48, 'Skalare Informationsfunktion', 'I:M\\longrightarrow\\mathbb R', 'I:M\\longrightarrow\\mathbb R', 'Abstrakte Informationsfunktion auf der lorentzschen Mannigfaltigkeit.', 'model', 'original', NULL, NULL, NULL, 'verified', 26),
(1000, '3.993', 48, 'Informationswert entlang einer kausalen Kurve', 't\\longmapsto I(\\gamma(t))', 't\\longmapsto I(\\gamma(t))', 'Zusammensetzung einer skalaren Funktion mit einer kausalen Kurve.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(1001, '3.994', 48, 'Kausale Kurve impliziert keine Informationsmonotonie', '\\gamma\\text{ kausal}\\not\\Longrightarrow\\frac{d}{dt}I(\\gamma(t))\\geq0', '\\gamma\\text{ kausal}\\not\\Longrightarrow\\frac{d}{dt}I(\\gamma(t))\\geq0', 'Kausalität allein legt keine Monotonie einer Informationsfunktion fest.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(1002, '3.995', 48, 'Kausale Zukunft impliziert keine Kohärenz- oder Informationszunahme', '\\text{kausale Zukunft}\\not\\Longrightarrow\\text{zunehmende FRZK-Kohärenz oder Information}', '\\text{kausale Zukunft}\\not\\Longrightarrow\\text{zunehmende FRZK-Kohärenz oder Information}', 'Methodologische Nichtimplikation zwischen geometrischer Zukunft und FRZK-spezifischer Monotonie.', 'schema', 'original', NULL, NULL, NULL, 'verified', 26),
(1003, '3.996', 49, 'Funktional', 'J:\\mathcal A\\longrightarrow\\mathbb R', 'J:\\mathcal A\\longrightarrow\\mathbb R', 'Reellwertiges Funktional auf einer zulässigen Klasse.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1004, '3.997', 49, 'Funktionalwert', 'J[u]\\in\\mathbb R', 'J[u]\\in\\mathbb R', 'Skalarer Wert, der dem gesamten zulässigen Objekt u zugeordnet wird.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1005, '3.998', 49, 'Zulässige Klasse', '\\mathcal A\\subseteq X', '\\mathcal A\\subseteq X', 'Zulässige Menge innerhalb eines geeigneten Funktionenraumes.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1006, '3.999', 49, 'Variationsproblem als Paar', '(J,\\mathcal A)', '(J,\\mathcal A)', 'Funktional und zulässige Klasse gehören gemeinsam zur Problemdefinition.', 'schema', 'adapted', 76, NULL, NULL, 'verified', 27),
(1007, '3.1000', 49, 'Allgemeines Integral-Funktional', 'J[u]=\\int_{\\Omega}L\\bigl(x,u(x),Du(x)\\bigr)\\,dx', 'J[u]=\\int_{\\Omega}L\\bigl(x,u(x),Du(x)\\bigr)\\,dx', 'Grundform eines Integral-Funktionals.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1008, '3.1001', 49, 'Eindimensionales Integral-Funktional', 'J[y]=\\int_a^bL\\bigl(x,y(x),y\'(x)\\bigr)\\,dx', 'J[y]=\\int_a^bL\\bigl(x,y(x),y\'(x)\\bigr)\\,dx', 'Eindimensionale Spezialform.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1009, '3.1002', 49, 'Einparametrige Variation', 'u_\\varepsilon=u+\\varepsilon\\eta', 'u_\\varepsilon=u+\\varepsilon\\eta', 'Variation von u in Richtung eta.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1010, '3.1003', 49, 'Ausgangselement der Variation', 'u_0=u', 'u_0=u', 'Die Variationsfamilie enthält bei epsilon=0 das Ausgangselement.', 'derived', 'literature', 76, NULL, NULL, 'verified', 27),
(1011, '3.1004', 49, 'Variationsparameter ist nicht automatisch physikalische Zeit', '\\varepsilon\\text{ Variationsparameter}\\not\\Longrightarrow\\varepsilon\\text{ physikalische Zeit}', '\\varepsilon\\text{ Variationsparameter}\\not\\Longrightarrow\\varepsilon\\text{ physikalische Zeit}', 'Methodologische Nichtimplikation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1012, '3.1005', 49, 'Variation erzeugt keine zusätzliche Raumzeitdimension', 'u_\\varepsilon=u+\\varepsilon\\eta\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', 'u_\\varepsilon=u+\\varepsilon\\eta\\not\\Longrightarrow\\dim M\\mapsto\\dim M+1', 'Der Variationsparameter ist keine zusätzliche Zustandskoordinate.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1013, '3.1006', 49, 'Erste Variation', '\\delta J[u;\\eta]=\\left.\\frac{d}{d\\varepsilon}J[u+\\varepsilon\\eta]\\right|_{\\varepsilon=0}', '\\delta J[u;\\eta]=\\left.\\frac{d}{d\\varepsilon}J[u+\\varepsilon\\eta]\\right|_{\\varepsilon=0}', 'Richtungsableitung des Funktionals.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1014, '3.1007', 49, 'Linearität der ersten Variation', '\\delta J[u;\\alpha\\eta+\\beta\\xi]=\\alpha\\delta J[u;\\eta]+\\beta\\delta J[u;\\xi]', '\\delta J[u;\\alpha\\eta+\\beta\\xi]=\\alpha\\delta J[u;\\eta]+\\beta\\delta J[u;\\xi]', 'Linearität in der Variationsrichtung unter geeigneten Differenzierbarkeitsvoraussetzungen.', 'theorem', 'literature', 76, NULL, NULL, 'verified', 27),
(1015, '3.1008', 49, 'Stationaritätsbedingung', '\\delta J[u;\\eta]=0', '\\delta J[u;\\eta]=0', 'Erste Variation verschwindet in allen zulässigen Richtungen.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1016, '3.1009', 49, 'Lokale Minimalitätsbedingung', 'J[u]\\leq J[v]', 'J[u]\\leq J[v]', 'Lokaler Minimierer in einer geeigneten Umgebung.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1017, '3.1010', 49, 'Lokale Maximalitätsbedingung', 'J[u]\\geq J[v]', 'J[u]\\geq J[v]', 'Lokaler Maximierer in einer geeigneten Umgebung.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1018, '3.1011', 49, 'Notwendige Stationarität eines inneren Extremums', '\\delta J[u;\\eta]=0', '\\delta J[u;\\eta]=0', 'Notwendige Bedingung erster Ordnung.', 'theorem', 'literature', 76, NULL, NULL, 'verified', 27),
(1019, '3.1012', 49, 'Inneres lokales Extremum impliziert Stationarität', '\\text{lokales inneres Extremum}\\Longrightarrow\\text{stationärer Punkt}', '\\text{lokales inneres Extremum}\\Longrightarrow\\text{stationärer Punkt}', 'Logische Form der notwendigen Bedingung.', 'theorem', 'literature', 76, NULL, NULL, 'verified', 27),
(1020, '3.1013', 49, 'Stationarität impliziert nicht Minimalität', '\\text{stationärer Punkt}\\not\\Longrightarrow\\text{lokales Minimum}', '\\text{stationärer Punkt}\\not\\Longrightarrow\\text{lokales Minimum}', 'Stationäre Punkte können auch Maxima oder Sattelpunkte sein.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1021, '3.1014', 49, 'Eindimensionales Variationsfunktional', 'J[y]=\\int_a^bL(x,y,y\')\\,dx', 'J[y]=\\int_a^bL(x,y,y\')\\,dx', 'Ausgangsfunktional zur Euler-Lagrange-Herleitung.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1022, '3.1015', 49, 'Feste Randwerte', 'y(a)=y_a,\\qquad y(b)=y_b', 'y(a)=y_a,\\qquad y(b)=y_b', 'Randbedingungen des eindimensionalen Variationsproblems.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1023, '3.1016', 49, 'Variation bei festen Randwerten', 'y_\\varepsilon=y+\\varepsilon\\eta', 'y_\\varepsilon=y+\\varepsilon\\eta', 'Variierte Kurve.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1024, '3.1017', 49, 'Verschwindende Randvariation', '\\eta(a)=\\eta(b)=0', '\\eta(a)=\\eta(b)=0', 'Zulässige Variationen erhalten feste Randwerte.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1025, '3.1018', 49, 'Erste Variation des eindimensionalen Integral-Funktionals', '\\delta J[y;\\eta]=\\int_a^b\\left(\\frac{\\partial L}{\\partial y}\\eta+\\frac{\\partial L}{\\partial y\'}\\eta\'\\right)dx', '\\delta J[y;\\eta]=\\int_a^b\\left(\\frac{\\partial L}{\\partial y}\\eta+\\frac{\\partial L}{\\partial y\'}\\eta\'\\right)dx', 'Erste Ableitung des Funktionals entlang der Variation.', 'derived', 'literature', 76, NULL, NULL, 'verified', 27),
(1026, '3.1019', 49, 'Partielle Integration des Ableitungsterms', '\\int_a^b\\frac{\\partial L}{\\partial y\'}\\eta\'\\,dx=\\left[\\frac{\\partial L}{\\partial y\'}\\eta\\right]_a^b-\\int_a^b\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y\'}\\right)\\eta\\,dx', '\\int_a^b\\frac{\\partial L}{\\partial y\'}\\eta\'\\,dx=\\left[\\frac{\\partial L}{\\partial y\'}\\eta\\right]_a^b-\\int_a^b\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y\'}\\right)\\eta\\,dx', 'Partielle Integration in der Euler-Lagrange-Herleitung.', 'derived', 'literature', 76, NULL, NULL, 'verified', 27),
(1027, '3.1020', 49, 'Verschwindender Randterm', '\\left[\\frac{\\partial L}{\\partial y\'}\\eta\\right]_a^b=0', '\\left[\\frac{\\partial L}{\\partial y\'}\\eta\\right]_a^b=0', 'Folge der festen Randwerte.', 'derived', 'literature', 76, NULL, NULL, 'verified', 27),
(1028, '3.1021', 49, 'Erste Variation nach partieller Integration', '\\delta J[y;\\eta]=\\int_a^b\\left[\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y\'}\\right)\\right]\\eta\\,dx', '\\delta J[y;\\eta]=\\int_a^b\\left[\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y\'}\\right)\\right]\\eta\\,dx', 'Variationsintegral in Euler-Lagrange-Form.', 'derived', 'literature', 76, NULL, NULL, 'verified', 27),
(1029, '3.1022', 49, 'Eindimensionale Euler-Lagrange-Gleichung', '\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y\'}\\right)=0', '\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y\'}\\right)=0', 'Notwendige Stationaritätsgleichung.', 'theorem', 'literature', 76, NULL, NULL, 'verified', 27),
(1030, '3.1023', 49, 'Minimierer erfüllt Euler-Lagrange', 'y\\text{ minimiert }J\\Longrightarrow y\\text{ erfüllt die Euler-Lagrange-Gleichung}', 'y\\text{ minimiert }J\\Longrightarrow y\\text{ erfüllt die Euler-Lagrange-Gleichung}', 'Notwendige Bedingung eines geeigneten Minimierers.', 'theorem', 'literature', 76, NULL, NULL, 'verified', 27),
(1031, '3.1024', 49, 'Euler-Lagrange-Lösung impliziert nicht Minimalität', 'y\\text{ erfüllt Euler-Lagrange}\\not\\Longrightarrow y\\text{ minimiert }J', 'y\\text{ erfüllt Euler-Lagrange}\\not\\Longrightarrow y\\text{ minimiert }J', 'Euler-Lagrange ist nicht allgemein hinreichend für Minimalität.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1032, '3.1025', 49, 'Mehrdimensionales Feldfunktional', 'J[u]=\\int_\\Omega L(x,u,Du)\\,dx', 'J[u]=\\int_\\Omega L(x,u,Du)\\,dx', 'Variationsfunktional für ein skalares Feld.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1033, '3.1026', 49, 'Variation eines skalaren Feldes', 'u_\\varepsilon=u+\\varepsilon\\eta', 'u_\\varepsilon=u+\\varepsilon\\eta', 'Variation des Feldes.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1034, '3.1027', 49, 'Erste Variation eines Feldfunktionals', '\\delta J[u;\\eta]=\\int_\\Omega\\left(L_u\\,\\eta+L_{p_i}\\frac{\\partial\\eta}{\\partial x^i}\\right)dx', '\\delta J[u;\\eta]=\\int_\\Omega\\left(L_u\\,\\eta+L_{p_i}\\frac{\\partial\\eta}{\\partial x^i}\\right)dx', 'Formale erste Variation.', 'derived', 'literature', 76, NULL, NULL, 'verified', 27),
(1035, '3.1028', 49, 'Feldvariation nach partieller Integration', '\\delta J[u;\\eta]=\\int_\\Omega\\left(L_u-\\frac{\\partial}{\\partial x^i}L_{p_i}\\right)\\eta\\,dx', '\\delta J[u;\\eta]=\\int_\\Omega\\left(L_u-\\frac{\\partial}{\\partial x^i}L_{p_i}\\right)\\eta\\,dx', 'Euler-Lagrange-Form der ersten Variation.', 'derived', 'literature', 76, NULL, NULL, 'verified', 27),
(1036, '3.1029', 49, 'Euler-Lagrange-Gleichung für skalare Felder', 'L_u-\\sum_{i=1}^{n}\\frac{\\partial}{\\partial x^i}L_{p_i}=0', 'L_u-\\sum_{i=1}^{n}\\frac{\\partial}{\\partial x^i}L_{p_i}=0', 'Euler-Lagrange-PDE für ein skalares Feld.', 'theorem', 'literature', 76, NULL, NULL, 'verified', 27),
(1037, '3.1030', 49, 'Euler-Lagrange-Gleichung in Divergenznotation', 'L_u-\\operatorname{div}\\left(L_{Du}\\right)=0', 'L_u-\\operatorname{div}\\left(L_{Du}\\right)=0', 'Vektorielle Kurznotation.', 'derived', 'literature', 76, NULL, NULL, 'verified', 27),
(1038, '3.1031', 49, 'Wirkungsartiges Funktional für mehrere abhängige Variablen', 'S[q]=\\int_{t_0}^{t_1}L(q,\\dot q,t)\\,dt', 'S[q]=\\int_{t_0}^{t_1}L(q,\\dot q,t)\\,dt', 'Variationsfunktional für mehrere Komponenten.', 'model', 'adapted', 76, NULL, NULL, 'verified', 27),
(1039, '3.1032', 49, 'Euler-Lagrange-Gleichungen für mehrere Komponenten', '\\frac{d}{dt}\\left(\\frac{\\partial L}{\\partial\\dot q^a}\\right)-\\frac{\\partial L}{\\partial q^a}=0,\\qquad a=1,\\ldots,m', '\\frac{d}{dt}\\left(\\frac{\\partial L}{\\partial\\dot q^a}\\right)-\\frac{\\partial L}{\\partial q^a}=0,\\qquad a=1,\\ldots,m', 'Komponentenweise Euler-Lagrange-Struktur.', 'theorem', 'adapted', 76, NULL, NULL, 'verified', 27),
(1040, '3.1033', 49, 'Anzahl der Euler-Lagrange-Gleichungen ist keine Raumdimensionszahl', 'm\\text{ Euler-Lagrange-Gleichungen}\\not\\Longrightarrow m\\text{ physikalische Raumdimensionen}', 'm\\text{ Euler-Lagrange-Gleichungen}\\not\\Longrightarrow m\\text{ physikalische Raumdimensionen}', 'Methodologische Nichtimplikation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1041, '3.1034', 49, 'Lagrange-Funktion auf Tangentialdaten', 'L:TQ\\times I\\longrightarrow\\mathbb R', 'L:TQ\\times I\\longrightarrow\\mathbb R', 'Abbildung auf Konfigurations-, Geschwindigkeits- und Parameterdaten.', 'definition', 'adapted', 76, NULL, NULL, 'verified', 27),
(1042, '3.1035', 49, 'Lokale Lagrange-Funktion', 'L=L(q,\\dot q,t)', 'L=L(q,\\dot q,t)', 'Lokale Schreibweise.', 'definition', 'adapted', 76, NULL, NULL, 'verified', 27),
(1043, '3.1036', 49, 'Wirkungsfunktional', 'S[q]=\\int_{t_0}^{t_1}L(q(t),\\dot q(t),t)\\,dt', 'S[q]=\\int_{t_0}^{t_1}L(q(t),\\dot q(t),t)\\,dt', 'Integral der Lagrange-Funktion entlang einer Kurve.', 'definition', 'adapted', 76, NULL, NULL, 'verified', 27),
(1044, '3.1037', 49, 'Trajektorie und Wirkungswert sind verschiedene Objekte', 'q\\neq S[q]', 'q\\neq S[q]', 'Typentrennung zwischen Kurve und Skalar.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1045, '3.1038', 49, 'Stationäre Wirkung', '\\delta S=0', '\\delta S=0', 'Variationsbedingung stationärer Wirkung.', 'definition', 'adapted', 76, NULL, NULL, 'verified', 27),
(1046, '3.1039', 49, 'Euler-Lagrange-Bedingung stationärer Wirkung', '\\frac{d}{dt}\\left(\\frac{\\partial L}{\\partial\\dot q^a}\\right)-\\frac{\\partial L}{\\partial q^a}=0', '\\frac{d}{dt}\\left(\\frac{\\partial L}{\\partial\\dot q^a}\\right)-\\frac{\\partial L}{\\partial q^a}=0', 'Stationäre Wirkung führt zu Euler-Lagrange-Gleichungen.', 'theorem', 'adapted', 76, NULL, NULL, 'verified', 27),
(1047, '3.1040', 49, 'Stationäre Wirkung impliziert Euler-Lagrange-Struktur', '\\delta S=0\\Longrightarrow\\text{Euler-Lagrange-Gleichungen}', '\\delta S=0\\Longrightarrow\\text{Euler-Lagrange-Gleichungen}', 'Unter den erforderlichen Regularitäts- und Randbedingungen.', 'theorem', 'adapted', 76, NULL, NULL, 'verified', 27),
(1048, '3.1041', 49, 'Stationäre Wirkung impliziert nicht minimale Wirkung', '\\delta S=0\\not\\Longrightarrow S\\text{ ist lokal minimal}', '\\delta S=0\\not\\Longrightarrow S\\text{ ist lokal minimal}', 'Stationarität kann Minimum, Maximum oder Sattelpunkt bedeuten.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1049, '3.1042', 49, 'Zweite Variation', '\\delta^2J[u;\\eta]=\\left.\\frac{d^2}{d\\varepsilon^2}J[u+\\varepsilon\\eta]\\right|_{\\varepsilon=0}', '\\delta^2J[u;\\eta]=\\left.\\frac{d^2}{d\\varepsilon^2}J[u+\\varepsilon\\eta]\\right|_{\\varepsilon=0}', 'Zweite Richtungsableitung des Funktionals.', 'definition', 'literature', 76, NULL, NULL, 'verified', 27),
(1050, '3.1043', 49, 'Nichtnegative zweite Variation am lokalen Minimum', '\\delta^2J[u;\\eta]\\geq0', '\\delta^2J[u;\\eta]\\geq0', 'Notwendige Bedingung zweiter Ordnung.', 'theorem', 'literature', 76, NULL, NULL, 'verified', 27),
(1051, '3.1044', 49, 'Notwendige Bedingungen erster und zweiter Ordnung', 'u\\text{ lokaler Minimierer}\\Longrightarrow\\begin{cases}\\delta J[u;\\eta]=0,\\\\\\delta^2J[u;\\eta]\\geq0.\\end{cases}', 'u\\text{ lokaler Minimierer}\\Longrightarrow\\begin{cases}\\delta J[u;\\eta]=0,\\\\\\delta^2J[u;\\eta]\\geq0.\\end{cases}', 'Zusammenfassung der notwendigen Variationsbedingungen.', 'theorem', 'literature', 76, NULL, NULL, 'verified', 27),
(1052, '3.1045', 49, 'Variationale Stationarität impliziert nicht dynamische Stabilität', '\\text{variational stationär}\\not\\Longrightarrow\\text{dynamisch stabil}', '\\text{variational stationär}\\not\\Longrightarrow\\text{dynamisch stabil}', 'Variationsrechnung und Lyapunov-Stabilität sind verschiedene Begriffe.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1053, '3.1046', 49, 'Dynamische Stabilität impliziert nicht Minimum eines beliebigen Funktionals', '\\text{dynamisch stabil}\\not\\Longrightarrow\\text{Minimum eines beliebigen Funktionals}', '\\text{dynamisch stabil}\\not\\Longrightarrow\\text{Minimum eines beliebigen Funktionals}', 'Umgekehrte methodologische Nichtimplikation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1054, '3.1047', 49, 'Randterm der Variation', '\\left[\\frac{\\partial L}{\\partial y\'}\\eta\\right]_a^b', '\\left[\\frac{\\partial L}{\\partial y\'}\\eta\\right]_a^b', 'Randterm nach partieller Integration.', 'schema', 'literature', 76, NULL, NULL, 'verified', 27),
(1055, '3.1048', 49, 'Lagrange-Funktion allein bestimmt kein vollständiges Variationsproblem', 'L\\text{ gegeben}\\not\\Longrightarrow\\text{vollständiges Variationsproblem bestimmt}', 'L\\text{ gegeben}\\not\\Longrightarrow\\text{vollständiges Variationsproblem bestimmt}', 'Zulässige Klasse, Gebiet und Randbedingungen fehlen sonst.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1056, '3.1049', 49, 'Mathematischer Rand impliziert keine physikalische Systemgrenze', '\\partial\\Omega\\not\\Longrightarrow\\text{physikalische Grenze eines realen Systems}', '\\partial\\Omega\\not\\Longrightarrow\\text{physikalische Grenze eines realen Systems}', 'Methodologische Trennung mathematischer und physikalischer Randbegriffe.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1057, '3.1050', 49, 'Äquivalente Lagrange-Funktion durch totalen Ableitungsterm', '\\widetilde L=L+\\frac{d}{dt}F(q,t)', '\\widetilde L=L+\\frac{d}{dt}F(q,t)', 'Änderung der Lagrange-Funktion um eine totale Ableitung.', 'model', 'adapted', 76, NULL, NULL, 'verified', 27),
(1058, '3.1051', 49, 'Änderung der Wirkung um einen Randterm', '\\widetilde S[q]=S[q]+F(q(t_1),t_1)-F(q(t_0),t_0)', '\\widetilde S[q]=S[q]+F(q(t_1),t_1)-F(q(t_0),t_0)', 'Wirkungsänderung bei totalem Ableitungsterm.', 'derived', 'adapted', 76, NULL, NULL, 'verified', 27),
(1059, '3.1052', 49, 'Totale Ableitung in der Lagrange-Funktion', '\\widetilde L=L+\\frac{dF}{dt}', '\\widetilde L=L+\\frac{dF}{dt}', 'Ausgangsform der invarianten Euler-Lagrange-Struktur.', 'theorem', 'adapted', 76, NULL, NULL, 'verified', 27),
(1060, '3.1053', 49, 'Gleiche Euler-Lagrange-Gleichungen äquivalenter Lagrange-Funktionen', '\\operatorname{EL}(L)=\\operatorname{EL}(\\widetilde L)', '\\operatorname{EL}(L)=\\operatorname{EL}(\\widetilde L)', 'Bei festen Endpunkten gleiche Euler-Lagrange-Gleichungen.', 'theorem', 'adapted', 76, NULL, NULL, 'verified', 27),
(1061, '3.1054', 49, 'Euler-Lagrange-Operatorausdruck', '\\mathcal E_L[u]=0', '\\mathcal E_L[u]=0', 'Abstrakte Schreibweise einer Euler-Lagrange-Gleichung.', 'model', 'adapted', 76, NULL, NULL, 'verified', 27),
(1062, '3.1055', 49, 'Funktional und Euler-Lagrange-Operator sind verschiedene Objekte', 'J\\neq\\mathcal E_L', 'J\\neq\\mathcal E_L', 'Typentrennung zwischen Funktional und Differentialgleichung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1063, '3.1056', 49, 'Funktionalwert ist keine zusätzliche Zustandsdimension', 'J[u]\\text{ skalar}\\not\\Longrightarrow J[u]\\text{ zusätzliche Zustandsdimension}', 'J[u]\\text{ skalar}\\not\\Longrightarrow J[u]\\text{ zusätzliche Zustandsdimension}', 'Formal korrigierte Nichtimplikation gegenüber der gerenderten Fassung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1064, '3.1057', 49, 'Wirkungswert ist skalar', 'S[q]\\in\\mathbb R', 'S[q]\\in\\mathbb R', 'Wirkungsfunktional liefert einen reellen Wert.', 'schema', 'adapted', 76, NULL, NULL, 'verified', 27),
(1065, '3.1058', 49, 'Wirkungswert ist keine zusätzliche Raumzeitdimension', 'S[q]\\in\\mathbb R\\not\\Longrightarrow\\text{zusätzliche Raumzeitdimension}', 'S[q]\\in\\mathbb R\\not\\Longrightarrow\\text{zusätzliche Raumzeitdimension}', 'Typologisch präzisierte Nichtimplikation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1066, '3.1059', 49, 'Informationsfunktional', '\\mathcal I[u]=\\int_\\Omega F(u,Du,x)\\,dx', '\\mathcal I[u]=\\int_\\Omega F(u,Du,x)\\,dx', 'Abstraktes Beispiel eines Informationsfunktionals.', 'model', 'original', NULL, NULL, NULL, 'verified', 27),
(1067, '3.1060', 49, 'Informationsfunktional erzeugt keine geometrische Dimension', '\\mathcal I[u]\\text{ definiert}\\not\\Longrightarrow\\text{Information ist geometrische Dimension}', '\\mathcal I[u]\\text{ definiert}\\not\\Longrightarrow\\text{Information ist geometrische Dimension}', 'Methodologische Nichtimplikation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1068, '3.1061', 49, 'Stationäres Informationsfunktional erzeugt keine Informationsdimension', '\\delta\\mathcal I=0\\not\\Longrightarrow\\text{zusätzliche Informationsdimension}', '\\delta\\mathcal I=0\\not\\Longrightarrow\\text{zusätzliche Informationsdimension}', 'Stationarität ändert den Objekttyp nicht.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1069, '3.1062', 49, 'Mathematisch definierte Wirkung ist nicht automatisch Naturgesetz', 'S[q]=\\int L\\,dt\\text{ mathematisch definiert}\\not\\Longrightarrow L\\text{ beschreibt die Natur}', 'S[q]=\\int L\\,dt\\text{ mathematisch definiert}\\not\\Longrightarrow L\\text{ beschreibt die Natur}', 'Formal korrigierte Nichtimplikation zwischen mathematischer Konstruktion und physikalischer Gültigkeit.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1070, '3.1063', 49, 'Euler-Lagrange-Struktur impliziert keine vollständige Kausalrelation', '\\text{Euler-Lagrange-Gleichung}\\not\\Longrightarrow\\text{vollständige Kausalrelation}', '\\text{Euler-Lagrange-Gleichung}\\not\\Longrightarrow\\text{vollständige Kausalrelation}', 'Formal korrigierte Nichtimplikation zwischen Variationsgleichung und Kausalstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1071, '3.1064', 49, 'Euler-Lagrange-Gleichung impliziert keine explizite Zeitentwicklung', '\\text{Euler-Lagrange-Gleichung}\\not\\Longrightarrow\\text{explizite Zeitentwicklung}', '\\text{Euler-Lagrange-Gleichung}\\not\\Longrightarrow\\text{explizite Zeitentwicklung}', 'Variationsgleichungen können ODE, PDE oder Randwertprobleme sein.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1072, '3.1065', 49, 'Variationsrichtung ist kein Raumzeitbasisvektor', '\\eta\\text{ Variationsrichtung}\\not\\Longrightarrow\\eta\\text{ Raumzeitbasisvektor}', '\\eta\\text{ Variationsrichtung}\\not\\Longrightarrow\\eta\\text{ Raumzeitbasisvektor}', 'Variationsraum und geometrischer Tangentialraum sind zu unterscheiden.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1073, '3.1066', 49, 'Unendlichdimensionaler Funktionenraum impliziert keine unendlichdimensionale Raumzeit', '\\dim\\mathcal A=\\infty\\not\\Longrightarrow\\dim M=\\infty', '\\dim\\mathcal A=\\infty\\not\\Longrightarrow\\dim M=\\infty', 'Formal korrigierte Nichtimplikation zwischen Funktionenraum- und Mannigfaltigkeitsdimension.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1074, '3.1067', 49, 'Funktionalableitung in Integraldarstellung', '\\delta J[u;\\eta]=\\int_\\Omega\\frac{\\delta J}{\\delta u}\\,\\eta\\,dx', '\\delta J[u;\\eta]=\\int_\\Omega\\frac{\\delta J}{\\delta u}\\,\\eta\\,dx', 'Formale Darstellung der ersten Variation über eine Funktionalableitung.', 'schema', 'adapted', 76, NULL, NULL, 'verified', 27),
(1075, '3.1068', 49, 'Funktionalableitung ist nicht automatisch physikalische Kraft', '\\frac{\\delta J}{\\delta u}\\not\\equiv\\text{physikalische Kraft}', '\\frac{\\delta J}{\\delta u}\\not\\equiv\\text{physikalische Kraft}', 'Physikalische Interpretation ist modellspezifisch.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1076, '3.1069', 49, 'Geodätisches Energie-Funktional', 'E[\\gamma]=\\frac{1}{2}\\int_a^b g_{\\gamma(t)}\\bigl(\\dot\\gamma(t),\\dot\\gamma(t)\\bigr)\\,dt', 'E[\\gamma]=\\frac{1}{2}\\int_a^b g_{\\gamma(t)}\\bigl(\\dot\\gamma(t),\\dot\\gamma(t)\\bigr)\\,dt', 'Energie-Funktional einer Kurve auf einer pseudo-riemannschen Mannigfaltigkeit.', 'definition', 'literature', 78, NULL, NULL, 'verified', 27),
(1077, '3.1070', 49, 'Variationscharakterisierung von Geodäten', '\\delta E[\\gamma]=0\\Longleftrightarrow\\frac{D\\dot\\gamma}{dt}=0', '\\delta E[\\gamma]=0\\Longleftrightarrow\\frac{D\\dot\\gamma}{dt}=0', 'Stationäre Kurven des geodätischen Energie-Funktionals sind affin parametrisierte Geodäten.', 'theorem', 'literature', 78, NULL, NULL, 'verified', 27),
(1078, '3.1071', 49, 'Geodäte und stationäre Energie-Kurve', '\\text{Levi-Civita-Geodäte}\\Longleftrightarrow\\text{stationäre Kurve des geodätischen Energie-Funktionals}', '\\text{Levi-Civita-Geodäte}\\Longleftrightarrow\\text{stationäre Kurve des geodätischen Energie-Funktionals}', 'Didaktische Zusammenfassung der Variationscharakterisierung.', 'theorem', 'adapted', 78, NULL, NULL, 'verified', 27),
(1079, '3.1072', 49, 'Lichtartige Kurve', 'g(\\dot\\gamma,\\dot\\gamma)=0', 'g(\\dot\\gamma,\\dot\\gamma)=0', 'Metrisches Selbstprodukt einer lichtartigen Kurve.', 'metric', 'literature', 78, NULL, NULL, 'verified', 27),
(1080, '3.1073', 49, 'Lichtartige Geodäte ist nicht durch gewöhnliche positive Längenminimierung charakterisiert', '\\text{lichtartige Geodäte}\\not\\Longrightarrow\\text{durch gewöhnliche positive Längenminimierung charakterisiert}', '\\text{lichtartige Geodäte}\\not\\Longrightarrow\\text{durch gewöhnliche positive Längenminimierung charakterisiert}', 'Riemannsche Längenintuition überträgt sich nicht direkt auf Nullgeodäten.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1081, '3.1074', 49, 'Funktional als Bewertungsabbildung', '\\mathcal A\\xrightarrow{\\;J\\;}\\mathbb R', '\\mathcal A\\xrightarrow{\\;J\\;}\\mathbb R', 'Zulässige Objekte werden durch ein Funktional bewertet.', 'schema', 'adapted', 76, NULL, NULL, 'verified', 27),
(1082, '3.1075', 49, 'Stationaritätsforderung', '\\delta J=0', '\\delta J=0', 'Kritische Elemente werden durch verschwindende erste Variation ausgezeichnet.', 'schema', 'adapted', 76, NULL, NULL, 'verified', 27),
(1083, '3.1076', 49, 'Stationarität erzeugt Euler-Lagrange-Gleichung', '\\delta J=0\\longrightarrow\\mathcal E_J[u]=0', '\\delta J=0\\longrightarrow\\mathcal E_J[u]=0', 'Didaktische Ableitungskette.', 'schema', 'adapted', 76, NULL, NULL, 'verified', 27),
(1084, '3.1077', 49, 'Variationsstrukturelle Hauptkette', '\\text{Funktional}\\longrightarrow\\text{Variation}\\longrightarrow\\text{Stationarität}\\longrightarrow\\text{Euler-Lagrange-Struktur}', '\\text{Funktional}\\longrightarrow\\text{Variation}\\longrightarrow\\text{Stationarität}\\longrightarrow\\text{Euler-Lagrange-Struktur}', 'Zusammenfassende didaktische Struktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1085, '3.1078', 49, 'Differentialgleichung impliziert nicht automatisch ein gegebenes Variationsprinzip', '\\text{Differentialgleichung}\\not\\Longrightarrow\\text{bereits gegebenes Variationsprinzip}', '\\text{Differentialgleichung}\\not\\Longrightarrow\\text{bereits gegebenes Variationsprinzip}', 'Umkehrproblem der Variationsrechnung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1086, '3.1079', 49, 'Stationäre Wirkung impliziert keinen Zeitpfeil', '\\delta S=0\\not\\Longrightarrow\\text{Zeitpfeil}', '\\delta S=0\\not\\Longrightarrow\\text{Zeitpfeil}', 'Stationarität erzeugt keine bevorzugte physikalische Zeitrichtung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1087, '3.1080', 49, 'Stationäre Wirkung impliziert keine Lorentzsignatur', '\\delta S=0\\not\\Longrightarrow g\\text{ besitzt Lorentzsignatur}', '\\delta S=0\\not\\Longrightarrow g\\text{ besitzt Lorentzsignatur}', 'Variationsstruktur und metrische Signatur sind getrennte Modellbestandteile.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1088, '3.1081', 49, 'Lorentzmetrik bestimmt kein eindeutiges Wirkungsfunktional', 'g\\text{ lorentzsch}\\not\\Longrightarrow S\\text{ eindeutig festgelegt}', 'g\\text{ lorentzsch}\\not\\Longrightarrow S\\text{ eindeutig festgelegt}', 'Umgekehrte methodologische Nichtimplikation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1089, '3.1082', 49, 'Abstraktes FRZK-Kohärenzfunktional', '\\mathcal K:\\mathcal A\\longrightarrow\\mathbb R', '\\mathcal K:\\mathcal A\\longrightarrow\\mathbb R', 'Mögliche spätere Form eines Kohärenzfunktionals.', 'model', 'original', NULL, NULL, NULL, 'verified', 27),
(1090, '3.1083', 49, 'Kohärenzfunktional ist nicht automatisch Wirkungsfunktional', '\\mathcal K\\not\\equiv S', '\\mathcal K\\not\\equiv S', 'Formal korrigierte Nichtgleichsetzung gegenüber der gerenderten Fassung.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1091, '3.1084', 49, 'Mögliche Stationarität eines Kohärenzfunktionals', '\\delta\\mathcal K=0', '\\delta\\mathcal K=0', 'Abstrakte spätere Variationsbedingung ohne physikalische Identifikation.', 'model', 'original', NULL, NULL, NULL, 'verified', 27),
(1092, '3.1085', 49, 'Abstraktes Kohärenzmaximum', '\\mathcal K[u]=\\max', '\\mathcal K[u]=\\max', 'Schematische Extremalaussage eines möglichen Kohärenzfunktionals.', 'model', 'original', NULL, NULL, NULL, 'verified', 27),
(1093, '3.1086', 49, 'Stationäre Wirkung impliziert keine maximale Kohärenz', '\\text{stationäre Wirkung}\\not\\Longrightarrow\\text{maximale Kohärenz}', '\\text{stationäre Wirkung}\\not\\Longrightarrow\\text{maximale Kohärenz}', 'Methodologische Nichtimplikation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1094, '3.1087', 49, 'Maximale Kohärenz impliziert keine stationäre Wirkung', '\\text{maximale Kohärenz}\\not\\Longrightarrow\\text{stationäre Wirkung}', '\\text{maximale Kohärenz}\\not\\Longrightarrow\\text{stationäre Wirkung}', 'Umgekehrte methodologische Nichtimplikation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1095, '3.1088', 49, 'Kanonischer beziehungsweise verallgemeinerter Impuls', 'p_a=\\frac{\\partial L}{\\partial\\dot q^a}', 'p_a=\\frac{\\partial L}{\\partial\\dot q^a}', 'Definition des zur verallgemeinerten Koordinate gehörigen Impulses.', 'definition', 'adapted', 76, NULL, NULL, 'verified', 27),
(1096, '3.1089', 49, 'Euler-Lagrange-Gleichung in Impulsform', '\\dot p_a=\\frac{\\partial L}{\\partial q^a}', '\\dot p_a=\\frac{\\partial L}{\\partial q^a}', 'Umformung der Euler-Lagrange-Gleichung mit p_a.', 'derived', 'adapted', 76, NULL, NULL, 'verified', 27),
(1097, '3.1090', 49, 'Kanonischer Impuls ist nicht automatisch kartesischer mechanischer Impuls', 'p_a\\not\\equiv\\text{mechanischer Impuls in kartesischen Raumkoordinaten}', 'p_a\\not\\equiv\\text{mechanischer Impuls in kartesischen Raumkoordinaten}', 'Formal korrigierte Nichtgleichsetzung; Interpretation hängt vom Modell ab.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1098, '3.1091', 49, 'Impulsvariable erzeugt keine zusätzliche Raumdimension', 'p_a\\text{ zusätzliche Variable}\\not\\Longrightarrow p_a\\text{ zusätzliche Raumdimension}', 'p_a\\text{ zusätzliche Variable}\\not\\Longrightarrow p_a\\text{ zusätzliche Raumdimension}', 'Formal korrigierte Nichtimplikation.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1099, '3.1092', 49, 'Stationarität führt zur Euler-Lagrange-Gleichung', '\\delta J=0\\longrightarrow\\text{Euler-Lagrange-Gleichung}', '\\delta J=0\\longrightarrow\\text{Euler-Lagrange-Gleichung}', 'Didaktische Kurzform.', 'schema', 'adapted', 76, NULL, NULL, 'verified', 27),
(1100, '3.1093', 49, 'Didaktische Hauptkette der Variationsrechnung', '\\text{zulässige Funktionen}\\longrightarrow\\text{Funktional}\\longrightarrow\\text{Variation}\\longrightarrow\\text{Stationarität}\\longrightarrow\\text{Differentialgleichung}', '\\text{zulässige Funktionen}\\longrightarrow\\text{Funktional}\\longrightarrow\\text{Variation}\\longrightarrow\\text{Stationarität}\\longrightarrow\\text{Differentialgleichung}', 'Zusammenfassende Aufbaufolge.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1101, '3.1094', 49, 'Mechanische Variationskette', 'L\\longrightarrow S[q]\\longrightarrow\\delta S=0\\longrightarrow\\text{Euler-Lagrange-Gleichungen}', 'L\\longrightarrow S[q]\\longrightarrow\\delta S=0\\longrightarrow\\text{Euler-Lagrange-Gleichungen}', 'Didaktische Spezialisierung auf ein Wirkungsfunktional.', 'schema', 'adapted', 76, NULL, NULL, 'verified', 27),
(1102, '3.1095', 49, 'Übergang von Geschwindigkeits- zu Impulsvariablen', '(q,\\dot q)\\longrightarrow(q,p)', '(q,\\dot q)\\longrightarrow(q,p)', 'Vorbereitung der Hamilton- und Phasenraumstruktur.', 'schema', 'original', NULL, NULL, NULL, 'verified', 27),
(1103, '3.1096', 49, 'Kanonischer Impuls als Übergangsgröße', 'p_a=\\frac{\\partial L}{\\partial\\dot q^a}', 'p_a=\\frac{\\partial L}{\\partial\\dot q^a}', 'Übergang zu Legendre-Transformation, Hamilton-Funktion und Phasenraum.', 'definition', 'adapted', 76, NULL, NULL, 'verified', 27);

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

--
-- Daten für Tabelle `object_source_links`
--

INSERT INTO `object_source_links` (`object_source_link_id`, `object_type`, `object_id`, `source_id`, `usage_type`, `note`) VALUES
(1, 'definition', 2, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Definition.'),
(2, 'definition', 3, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Definition.'),
(3, 'definition', 4, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Definition.'),
(4, 'definition', 5, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Definition.'),
(8, 'equation', 1, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(9, 'equation', 4, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(10, 'equation', 5, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(11, 'equation', 6, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(12, 'equation', 7, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(13, 'equation', 8, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(14, 'equation', 9, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(15, 'equation', 10, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(16, 'equation', 11, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(17, 'equation', 12, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(18, 'equation', 13, 71, 'primary_source', 'Literaturgrundlage der etablierten mathematischen Aussage.'),
(23, 'definition', 1, 71, 'supporting_source', 'Ergänzende axiomatische und systematische Einordnung in Enderton [71].'),
(24, 'definition', 6, 71, 'primary_source', 'Etablierte mengentheoretische Funktionsdefinition; Quelle [71].'),
(25, 'definition', 7, 71, 'primary_source', 'Etablierte mengentheoretische Funktionsdefinition; Quelle [71].'),
(26, 'definition', 8, 71, 'primary_source', 'Etablierte mengentheoretische Funktionsdefinition; Quelle [71].'),
(27, 'definition', 9, 71, 'primary_source', 'Etablierte mengentheoretische Funktionsdefinition; Quelle [71].'),
(28, 'definition', 10, 71, 'primary_source', 'Etablierte mengentheoretische Funktionsdefinition; Quelle [71].'),
(29, 'definition', 11, 71, 'primary_source', 'Etablierte mengentheoretische Funktionsdefinition; Quelle [71].'),
(30, 'definition', 12, 71, 'primary_source', 'Etablierte mengentheoretische Funktionsdefinition; Quelle [71].'),
(31, 'equation', 14, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(32, 'equation', 15, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(33, 'equation', 16, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(34, 'equation', 17, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(35, 'equation', 18, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(36, 'equation', 19, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(37, 'equation', 20, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(38, 'equation', 21, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(39, 'equation', 22, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(40, 'equation', 23, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(41, 'equation', 24, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(42, 'equation', 25, 71, 'primary_source', 'Etablierte mathematische Aussage zum Funktionsbegriff; Quelle [71].'),
(46, 'definition', 13, 72, 'primary_source', 'Etablierte lineare Algebra; Quelle [72].'),
(47, 'definition', 14, 72, 'primary_source', 'Etablierte lineare Algebra; Quelle [72].'),
(48, 'definition', 15, 72, 'primary_source', 'Etablierte lineare Algebra; Quelle [72].'),
(49, 'equation', 26, 72, 'primary_source', 'Etablierte lineare Algebra zu Vektorraum und Unterraum; Quelle [72].'),
(50, 'equation', 27, 72, 'primary_source', 'Etablierte lineare Algebra zu Vektorraum und Unterraum; Quelle [72].'),
(51, 'equation', 28, 72, 'primary_source', 'Etablierte lineare Algebra zu Vektorraum und Unterraum; Quelle [72].'),
(52, 'equation', 29, 72, 'primary_source', 'Etablierte lineare Algebra zu Vektorraum und Unterraum; Quelle [72].'),
(53, 'equation', 30, 72, 'primary_source', 'Etablierte lineare Algebra zu Vektorraum und Unterraum; Quelle [72].'),
(54, 'equation', 31, 72, 'primary_source', 'Etablierte lineare Algebra zu Vektorraum und Unterraum; Quelle [72].'),
(55, 'equation', 32, 72, 'primary_source', 'Etablierte lineare Algebra zu Vektorraum und Unterraum; Quelle [72].'),
(56, 'definition', 16, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombination, Spannraum und Erzeugung; Quelle [72].'),
(57, 'definition', 17, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombination, Spannraum und Erzeugung; Quelle [72].'),
(58, 'definition', 18, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombination, Spannraum und Erzeugung; Quelle [72].'),
(59, 'definition', 19, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombination, Spannraum und Erzeugung; Quelle [72].'),
(63, 'equation', 33, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(64, 'equation', 34, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(65, 'equation', 35, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(66, 'equation', 36, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(67, 'equation', 37, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(68, 'equation', 38, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(69, 'equation', 39, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(70, 'equation', 40, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(71, 'equation', 41, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(72, 'equation', 42, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(73, 'equation', 43, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(74, 'equation', 44, 72, 'primary_source', 'Etablierte lineare Algebra zu Linearkombinationen, Spannräumen, Erzeugung und Redundanz; Quelle [72].'),
(78, 'definition', 20, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis und Dimension; Quelle [72], §3.4.'),
(79, 'definition', 21, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis und Dimension; Quelle [72], §3.4.'),
(80, 'definition', 22, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis und Dimension; Quelle [72], §3.4.'),
(81, 'theorem', 1, 72, 'primary_source', 'Eindeutigkeit der Darstellung bezüglich einer Basis; Quelle [72], §3.4.'),
(82, 'equation', 45, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(83, 'equation', 46, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(84, 'equation', 47, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(85, 'equation', 48, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(86, 'equation', 49, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(87, 'equation', 50, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(88, 'equation', 51, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(89, 'equation', 52, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(90, 'equation', 53, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(91, 'equation', 54, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(92, 'equation', 55, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(93, 'equation', 56, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(94, 'equation', 57, 72, 'primary_source', 'Etablierte lineare Algebra zu Unabhängigkeit, Basis, Koordinaten und Dimension; Quelle [72], §§3.4-3.5.'),
(97, 'definition', 23, 72, 'primary_source', 'Etablierte lineare Algebra zu linearen Abbildungen, Kern, Bild, Rang, Nullität und Operatoren; Quelle [72].'),
(98, 'definition', 24, 72, 'primary_source', 'Etablierte lineare Algebra zu linearen Abbildungen, Kern, Bild, Rang, Nullität und Operatoren; Quelle [72].'),
(99, 'definition', 25, 72, 'primary_source', 'Etablierte lineare Algebra zu linearen Abbildungen, Kern, Bild, Rang, Nullität und Operatoren; Quelle [72].'),
(100, 'definition', 26, 72, 'primary_source', 'Etablierte lineare Algebra zu linearen Abbildungen, Kern, Bild, Rang, Nullität und Operatoren; Quelle [72].'),
(101, 'definition', 27, 72, 'primary_source', 'Etablierte lineare Algebra zu linearen Abbildungen, Kern, Bild, Rang, Nullität und Operatoren; Quelle [72].'),
(104, 'theorem', 2, 72, 'primary_source', 'Etablierte Sätze zu Injektivität/Kern und Rang-Nullität; Quelle [72].'),
(105, 'theorem', 3, 72, 'primary_source', 'Etablierte Sätze zu Injektivität/Kern und Rang-Nullität; Quelle [72].'),
(107, 'equation', 58, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(108, 'equation', 59, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(109, 'equation', 60, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(110, 'equation', 61, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(111, 'equation', 62, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(112, 'equation', 63, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(113, 'equation', 64, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(114, 'equation', 65, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(115, 'equation', 66, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(116, 'equation', 67, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(117, 'equation', 68, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(118, 'equation', 69, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(119, 'equation', 70, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(120, 'equation', 71, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(121, 'equation', 72, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(122, 'equation', 73, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(123, 'equation', 74, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(124, 'equation', 75, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(125, 'equation', 76, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(126, 'equation', 77, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(127, 'equation', 78, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(128, 'equation', 79, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(129, 'equation', 80, 72, 'primary_source', 'Etablierte Aussagen zu linearen Abbildungen und ihrer Matrixdarstellung; Quelle [72].'),
(130, 'definition', 28, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm, Metrik, Skalarprodukt, Orthogonalität, orthonormale Systeme und Projektionen; Quelle [73].'),
(131, 'definition', 29, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm, Metrik, Skalarprodukt, Orthogonalität, orthonormale Systeme und Projektionen; Quelle [73].'),
(132, 'definition', 30, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm, Metrik, Skalarprodukt, Orthogonalität, orthonormale Systeme und Projektionen; Quelle [73].'),
(133, 'definition', 31, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm, Metrik, Skalarprodukt, Orthogonalität, orthonormale Systeme und Projektionen; Quelle [73].'),
(134, 'definition', 32, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm, Metrik, Skalarprodukt, Orthogonalität, orthonormale Systeme und Projektionen; Quelle [73].'),
(135, 'definition', 33, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm, Metrik, Skalarprodukt, Orthogonalität, orthonormale Systeme und Projektionen; Quelle [73].'),
(136, 'definition', 34, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm, Metrik, Skalarprodukt, Orthogonalität, orthonormale Systeme und Projektionen; Quelle [73].'),
(137, 'theorem', 4, 73, 'primary_source', 'Grundlegende Sätze zu Skalarproduktnorm, Cauchy-Schwarz und Orthogonalität; Quelle [73].'),
(138, 'theorem', 5, 73, 'primary_source', 'Grundlegende Sätze zu Skalarproduktnorm, Cauchy-Schwarz und Orthogonalität; Quelle [73].'),
(139, 'theorem', 6, 73, 'primary_source', 'Grundlegende Sätze zu Skalarproduktnorm, Cauchy-Schwarz und Orthogonalität; Quelle [73].'),
(140, 'equation', 81, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(141, 'equation', 82, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(142, 'equation', 83, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(143, 'equation', 84, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(144, 'equation', 85, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(145, 'equation', 86, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(146, 'equation', 87, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(147, 'equation', 88, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(148, 'equation', 89, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(149, 'equation', 90, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(150, 'equation', 92, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(151, 'equation', 93, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(152, 'equation', 94, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(153, 'equation', 95, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(154, 'equation', 96, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(155, 'equation', 97, 73, 'primary_source', 'Funktionalanalytische Grundlage für Norm-, Metrik- und Skalarproduktstrukturen; Quelle [73].'),
(171, 'equation', 81, 72, 'supporting_source', 'Ergänzende endlichdimensionale Darstellung zu Längen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen; Quelle [72].'),
(172, 'equation', 83, 72, 'supporting_source', 'Ergänzende endlichdimensionale Darstellung zu Längen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen; Quelle [72].'),
(173, 'equation', 88, 72, 'supporting_source', 'Ergänzende endlichdimensionale Darstellung zu Längen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen; Quelle [72].'),
(174, 'equation', 89, 72, 'supporting_source', 'Ergänzende endlichdimensionale Darstellung zu Längen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen; Quelle [72].'),
(175, 'equation', 90, 72, 'supporting_source', 'Ergänzende endlichdimensionale Darstellung zu Längen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen; Quelle [72].'),
(176, 'equation', 91, 72, 'supporting_source', 'Ergänzende endlichdimensionale Darstellung zu Längen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen; Quelle [72].'),
(177, 'equation', 92, 72, 'supporting_source', 'Ergänzende endlichdimensionale Darstellung zu Längen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen; Quelle [72].'),
(178, 'equation', 94, 72, 'supporting_source', 'Ergänzende endlichdimensionale Darstellung zu Längen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen; Quelle [72].'),
(179, 'equation', 95, 72, 'supporting_source', 'Ergänzende endlichdimensionale Darstellung zu Längen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen; Quelle [72].'),
(186, 'definition', 35, 74, 'primary_source', 'Etablierte allgemeine Topologie; Quelle [74], insbesondere §§12, 13, 17, 18, 20 und 21.'),
(187, 'definition', 36, 74, 'primary_source', 'Etablierte allgemeine Topologie; Quelle [74], insbesondere §§12, 13, 17, 18, 20 und 21.'),
(188, 'definition', 37, 74, 'primary_source', 'Etablierte allgemeine Topologie; Quelle [74], insbesondere §§12, 13, 17, 18, 20 und 21.'),
(189, 'definition', 38, 74, 'primary_source', 'Etablierte allgemeine Topologie; Quelle [74], insbesondere §§12, 13, 17, 18, 20 und 21.'),
(190, 'definition', 39, 74, 'primary_source', 'Etablierte allgemeine Topologie; Quelle [74], insbesondere §§12, 13, 17, 18, 20 und 21.'),
(191, 'definition', 40, 74, 'primary_source', 'Etablierte allgemeine Topologie; Quelle [74], insbesondere §§12, 13, 17, 18, 20 und 21.'),
(192, 'definition', 41, 74, 'primary_source', 'Etablierte allgemeine Topologie; Quelle [74], insbesondere §§12, 13, 17, 18, 20 und 21.'),
(193, 'definition', 42, 74, 'primary_source', 'Etablierte allgemeine Topologie; Quelle [74], insbesondere §§12, 13, 17, 18, 20 und 21.'),
(194, 'definition', 43, 74, 'primary_source', 'Etablierte allgemeine Topologie; Quelle [74], insbesondere §§12, 13, 17, 18, 20 und 21.'),
(201, 'theorem', 7, 74, 'primary_source', 'Stetigkeit der Verkettung stetiger Abbildungen; Quelle [74], §18.'),
(202, 'equation', 100, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(203, 'equation', 101, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(204, 'equation', 102, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(205, 'equation', 103, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(206, 'equation', 104, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(207, 'equation', 105, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(208, 'equation', 106, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(209, 'equation', 107, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(210, 'equation', 108, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(211, 'equation', 109, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(212, 'equation', 110, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(213, 'equation', 111, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(214, 'equation', 112, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(215, 'equation', 113, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(216, 'equation', 114, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(217, 'equation', 115, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(218, 'equation', 116, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(219, 'equation', 117, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(220, 'equation', 118, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(221, 'equation', 119, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(222, 'equation', 98, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(223, 'equation', 99, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74].'),
(233, 'definition', 44, 74, 'primary_source', 'Etablierte Topologie zu Zusammenhang, Wegen, Komponenten, offenen Überdeckungen und Kompaktheit; Quelle [74], §§23-26.'),
(234, 'definition', 45, 74, 'primary_source', 'Etablierte Topologie zu Zusammenhang, Wegen, Komponenten, offenen Überdeckungen und Kompaktheit; Quelle [74], §§23-26.'),
(235, 'definition', 46, 74, 'primary_source', 'Etablierte Topologie zu Zusammenhang, Wegen, Komponenten, offenen Überdeckungen und Kompaktheit; Quelle [74], §§23-26.'),
(236, 'definition', 47, 74, 'primary_source', 'Etablierte Topologie zu Zusammenhang, Wegen, Komponenten, offenen Überdeckungen und Kompaktheit; Quelle [74], §§23-26.'),
(237, 'definition', 48, 74, 'primary_source', 'Etablierte Topologie zu Zusammenhang, Wegen, Komponenten, offenen Überdeckungen und Kompaktheit; Quelle [74], §§23-26.'),
(238, 'definition', 49, 74, 'primary_source', 'Etablierte Topologie zu Zusammenhang, Wegen, Komponenten, offenen Überdeckungen und Kompaktheit; Quelle [74], §§23-26.'),
(239, 'definition', 50, 74, 'primary_source', 'Etablierte Topologie zu Zusammenhang, Wegen, Komponenten, offenen Überdeckungen und Kompaktheit; Quelle [74], §§23-26.'),
(240, 'definition', 51, 74, 'primary_source', 'Etablierte Topologie zu Zusammenhang, Wegen, Komponenten, offenen Überdeckungen und Kompaktheit; Quelle [74], §§23-26.'),
(241, 'definition', 52, 74, 'primary_source', 'Etablierte Topologie zu Zusammenhang, Wegen, Komponenten, offenen Überdeckungen und Kompaktheit; Quelle [74], §§23-26.'),
(248, 'theorem', 8, 74, 'primary_source', 'Etablierte Sätze zu Zusammenhang, Wegzusammenhang und Kompaktheit; Quelle [74], §§23-26.'),
(249, 'theorem', 9, 74, 'primary_source', 'Etablierte Sätze zu Zusammenhang, Wegzusammenhang und Kompaktheit; Quelle [74], §§23-26.'),
(250, 'theorem', 10, 74, 'primary_source', 'Etablierte Sätze zu Zusammenhang, Wegzusammenhang und Kompaktheit; Quelle [74], §§23-26.'),
(251, 'theorem', 11, 74, 'primary_source', 'Etablierte Sätze zu Zusammenhang, Wegzusammenhang und Kompaktheit; Quelle [74], §§23-26.'),
(252, 'theorem', 12, 74, 'primary_source', 'Etablierte Sätze zu Zusammenhang, Wegzusammenhang und Kompaktheit; Quelle [74], §§23-26.'),
(255, 'equation', 120, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(256, 'equation', 121, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(257, 'equation', 122, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(258, 'equation', 123, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(259, 'equation', 124, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(260, 'equation', 125, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(261, 'equation', 126, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(262, 'equation', 127, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(263, 'equation', 128, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(264, 'equation', 129, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(265, 'equation', 130, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(266, 'equation', 131, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(267, 'equation', 132, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(268, 'equation', 133, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(269, 'equation', 134, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(270, 'equation', 135, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(271, 'equation', 136, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(272, 'equation', 137, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(273, 'equation', 138, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(274, 'equation', 139, 74, 'primary_source', 'Etablierte topologische Aussage beziehungsweise Definition; Quelle [74], §§23-26.'),
(286, 'definition', 53, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit und Teilfolgen; Quelle [74].'),
(287, 'definition', 54, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit und Teilfolgen; Quelle [74].'),
(288, 'definition', 55, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit und Teilfolgen; Quelle [74].'),
(289, 'definition', 56, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit und Teilfolgen; Quelle [74].'),
(290, 'definition', 59, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit und Teilfolgen; Quelle [74].'),
(293, 'definition', 57, 73, 'primary_source', 'Funktionalanalytische Grundlage für Banach- und Hilberträume; Quelle [73].'),
(294, 'definition', 58, 73, 'primary_source', 'Funktionalanalytische Grundlage für Banach- und Hilberträume; Quelle [73].'),
(296, 'theorem', 13, 74, 'primary_source', 'Metrische und topologische Sätze zu Konvergenz, Vollständigkeit und Kompaktheit; Quelle [74].'),
(297, 'theorem', 14, 74, 'primary_source', 'Metrische und topologische Sätze zu Konvergenz, Vollständigkeit und Kompaktheit; Quelle [74].'),
(298, 'theorem', 15, 74, 'primary_source', 'Metrische und topologische Sätze zu Konvergenz, Vollständigkeit und Kompaktheit; Quelle [74].'),
(299, 'theorem', 17, 74, 'primary_source', 'Metrische und topologische Sätze zu Konvergenz, Vollständigkeit und Kompaktheit; Quelle [74].'),
(300, 'theorem', 18, 74, 'primary_source', 'Metrische und topologische Sätze zu Konvergenz, Vollständigkeit und Kompaktheit; Quelle [74].'),
(303, 'theorem', 16, 73, 'primary_source', 'Hilbertraum als spezieller vollständiger normierter Raum; Quelle [73].'),
(304, 'equation', 140, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(305, 'equation', 141, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(306, 'equation', 142, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(307, 'equation', 143, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(308, 'equation', 144, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(309, 'equation', 147, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(310, 'equation', 148, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(311, 'equation', 149, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(312, 'equation', 151, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(313, 'equation', 152, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(314, 'equation', 153, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(315, 'equation', 154, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(316, 'equation', 160, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(317, 'equation', 161, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(318, 'equation', 162, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(319, 'equation', 163, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(320, 'equation', 164, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(321, 'equation', 165, 74, 'primary_source', 'Topologische und metrische Grundlage für Folgen, Konvergenz, Cauchy-Folgen, Vollständigkeit, Teilfolgen und Kompaktheit; Quelle [74].'),
(335, 'equation', 145, 73, 'primary_source', 'Funktionalanalytische Grundlage für normierte Konvergenz, Banach- und Hilbertraum-Vollständigkeit; Quelle [73].'),
(336, 'equation', 146, 73, 'primary_source', 'Funktionalanalytische Grundlage für normierte Konvergenz, Banach- und Hilbertraum-Vollständigkeit; Quelle [73].'),
(337, 'equation', 150, 73, 'primary_source', 'Funktionalanalytische Grundlage für normierte Konvergenz, Banach- und Hilbertraum-Vollständigkeit; Quelle [73].'),
(338, 'equation', 155, 73, 'primary_source', 'Funktionalanalytische Grundlage für normierte Konvergenz, Banach- und Hilbertraum-Vollständigkeit; Quelle [73].'),
(339, 'equation', 156, 73, 'primary_source', 'Funktionalanalytische Grundlage für normierte Konvergenz, Banach- und Hilbertraum-Vollständigkeit; Quelle [73].'),
(340, 'equation', 157, 73, 'primary_source', 'Funktionalanalytische Grundlage für normierte Konvergenz, Banach- und Hilbertraum-Vollständigkeit; Quelle [73].'),
(341, 'equation', 158, 73, 'primary_source', 'Funktionalanalytische Grundlage für normierte Konvergenz, Banach- und Hilbertraum-Vollständigkeit; Quelle [73].'),
(342, 'equation', 159, 73, 'primary_source', 'Funktionalanalytische Grundlage für normierte Konvergenz, Banach- und Hilbertraum-Vollständigkeit; Quelle [73].'),
(343, 'equation', 166, 73, 'primary_source', 'Funktionalanalytische Grundlage für normierte Konvergenz, Banach- und Hilbertraum-Vollständigkeit; Quelle [73].'),
(350, 'definition', 61, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare Funktionenräume, Beschränktheit, Supremumsnorm und Auswertungsfunktionale; Quelle [73].'),
(351, 'definition', 63, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare Funktionenräume, Beschränktheit, Supremumsnorm und Auswertungsfunktionale; Quelle [73].'),
(352, 'definition', 64, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare Funktionenräume, Beschränktheit, Supremumsnorm und Auswertungsfunktionale; Quelle [73].'),
(353, 'definition', 65, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare Funktionenräume, Beschränktheit, Supremumsnorm und Auswertungsfunktionale; Quelle [73].'),
(354, 'definition', 68, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare Funktionenräume, Beschränktheit, Supremumsnorm und Auswertungsfunktionale; Quelle [73].'),
(357, 'definition', 60, 74, 'primary_source', 'Topologische Grundlage für Funktionenräume, stetige Funktionen sowie punktweise und gleichmäßige Konvergenz; Quelle [74].'),
(358, 'definition', 62, 74, 'primary_source', 'Topologische Grundlage für Funktionenräume, stetige Funktionen sowie punktweise und gleichmäßige Konvergenz; Quelle [74].'),
(359, 'definition', 66, 74, 'primary_source', 'Topologische Grundlage für Funktionenräume, stetige Funktionen sowie punktweise und gleichmäßige Konvergenz; Quelle [74].'),
(360, 'definition', 67, 74, 'primary_source', 'Topologische Grundlage für Funktionenräume, stetige Funktionen sowie punktweise und gleichmäßige Konvergenz; Quelle [74].'),
(364, 'theorem', 19, 73, 'primary_source', 'Funktionalanalytische Sätze zu linearen und vollständigen Funktionenräumen sowie Auswertungsfunktionalen; Quelle [73].'),
(365, 'theorem', 20, 73, 'primary_source', 'Funktionalanalytische Sätze zu linearen und vollständigen Funktionenräumen sowie Auswertungsfunktionalen; Quelle [73].'),
(366, 'theorem', 24, 73, 'primary_source', 'Funktionalanalytische Sätze zu linearen und vollständigen Funktionenräumen sowie Auswertungsfunktionalen; Quelle [73].'),
(367, 'theorem', 25, 73, 'primary_source', 'Funktionalanalytische Sätze zu linearen und vollständigen Funktionenräumen sowie Auswertungsfunktionalen; Quelle [73].'),
(371, 'theorem', 21, 74, 'primary_source', 'Konvergenzsätze für Funktionenräume; Quelle [74].'),
(372, 'theorem', 22, 74, 'primary_source', 'Konvergenzsätze für Funktionenräume; Quelle [74].'),
(373, 'theorem', 23, 74, 'primary_source', 'Konvergenzsätze für Funktionenräume; Quelle [74].'),
(374, 'equation', 168, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(375, 'equation', 169, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(376, 'equation', 170, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(377, 'equation', 172, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(378, 'equation', 173, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(379, 'equation', 174, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(380, 'equation', 175, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(381, 'equation', 176, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(382, 'equation', 177, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(383, 'equation', 185, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(384, 'equation', 186, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(385, 'equation', 187, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(386, 'equation', 188, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(387, 'equation', 189, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(388, 'equation', 190, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(389, 'equation', 191, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(390, 'equation', 192, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(391, 'equation', 193, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(392, 'equation', 195, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(393, 'equation', 196, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(394, 'equation', 200, 73, 'primary_source', 'Funktionalanalytische Grundlage für lineare, normierte und vollständige Funktionenräume und Funktionale; Quelle [73].'),
(405, 'equation', 167, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(406, 'equation', 171, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(407, 'equation', 178, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(408, 'equation', 179, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(409, 'equation', 180, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(410, 'equation', 181, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(411, 'equation', 182, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(412, 'equation', 183, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(413, 'equation', 184, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(414, 'equation', 194, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(415, 'equation', 201, 74, 'primary_source', 'Topologische und konvergenztheoretische Grundlage für Funktionenräume; Quelle [74].'),
(420, 'definition', 69, 73, 'primary_source', 'Funktionalanalytische Standarddefinition; Quelle [73], verifizierte Kapitelbereiche zu Hilbert-, Banach- und Operatorräumen.'),
(421, 'definition', 70, 73, 'primary_source', 'Funktionalanalytische Standarddefinition; Quelle [73], verifizierte Kapitelbereiche zu Hilbert-, Banach- und Operatorräumen.'),
(422, 'definition', 71, 73, 'primary_source', 'Funktionalanalytische Standarddefinition; Quelle [73], verifizierte Kapitelbereiche zu Hilbert-, Banach- und Operatorräumen.'),
(423, 'definition', 72, 73, 'primary_source', 'Funktionalanalytische Standarddefinition; Quelle [73], verifizierte Kapitelbereiche zu Hilbert-, Banach- und Operatorräumen.'),
(424, 'definition', 73, 73, 'primary_source', 'Funktionalanalytische Standarddefinition; Quelle [73], verifizierte Kapitelbereiche zu Hilbert-, Banach- und Operatorräumen.'),
(425, 'definition', 74, 73, 'primary_source', 'Funktionalanalytische Standarddefinition; Quelle [73], verifizierte Kapitelbereiche zu Hilbert-, Banach- und Operatorräumen.'),
(426, 'definition', 75, 73, 'primary_source', 'Funktionalanalytische Standarddefinition; Quelle [73], verifizierte Kapitelbereiche zu Hilbert-, Banach- und Operatorräumen.'),
(427, 'theorem', 26, 73, 'primary_source', 'Funktionalanalytischer Standardsatz; Quelle [73].'),
(428, 'theorem', 27, 73, 'primary_source', 'Funktionalanalytischer Standardsatz; Quelle [73].'),
(429, 'theorem', 28, 73, 'primary_source', 'Funktionalanalytischer Standardsatz; Quelle [73].'),
(430, 'theorem', 29, 73, 'primary_source', 'Funktionalanalytischer Standardsatz; Quelle [73].'),
(431, 'theorem', 30, 73, 'primary_source', 'Funktionalanalytischer Standardsatz; Quelle [73].'),
(432, 'theorem', 31, 73, 'primary_source', 'Funktionalanalytischer Standardsatz; Quelle [73].'),
(433, 'theorem', 32, 73, 'primary_source', 'Funktionalanalytischer Standardsatz; Quelle [73].'),
(434, 'equation', 203, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(435, 'equation', 204, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(436, 'equation', 205, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(437, 'equation', 206, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(438, 'equation', 207, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(439, 'equation', 208, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(440, 'equation', 209, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(441, 'equation', 210, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(442, 'equation', 211, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(443, 'equation', 212, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(444, 'equation', 213, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(445, 'equation', 214, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(446, 'equation', 215, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(447, 'equation', 216, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(448, 'equation', 217, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(449, 'equation', 218, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(450, 'equation', 219, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(451, 'equation', 220, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(452, 'equation', 221, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(453, 'equation', 222, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(454, 'equation', 223, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(455, 'equation', 224, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(456, 'equation', 225, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(457, 'equation', 226, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(458, 'equation', 227, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(459, 'equation', 229, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(460, 'equation', 230, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(461, 'equation', 231, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(462, 'equation', 232, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(463, 'equation', 233, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(464, 'equation', 234, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(465, 'equation', 235, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(466, 'equation', 236, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(467, 'equation', 237, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(468, 'equation', 238, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(469, 'equation', 239, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(470, 'equation', 240, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(471, 'equation', 241, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(472, 'equation', 242, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(473, 'equation', 243, 73, 'primary_source', 'Funktionalanalytische Definition, Standardaussage oder direkte Ableitung aus Quelle [73].'),
(497, 'definition', 76, 72, 'primary_source', 'Lineare Algebra zu Eigenwerten, Eigenräumen, charakteristischem Polynom und Diagonalisierung; Quelle [72], Kap. 6 §§6.1-6.5.'),
(498, 'definition', 77, 72, 'primary_source', 'Lineare Algebra zu Eigenwerten, Eigenräumen, charakteristischem Polynom und Diagonalisierung; Quelle [72], Kap. 6 §§6.1-6.5.'),
(499, 'definition', 78, 72, 'primary_source', 'Lineare Algebra zu Eigenwerten, Eigenräumen, charakteristischem Polynom und Diagonalisierung; Quelle [72], Kap. 6 §§6.1-6.5.');
INSERT INTO `object_source_links` (`object_source_link_id`, `object_type`, `object_id`, `source_id`, `usage_type`, `note`) VALUES
(500, 'definition', 79, 72, 'primary_source', 'Lineare Algebra zu Eigenwerten, Eigenräumen, charakteristischem Polynom und Diagonalisierung; Quelle [72], Kap. 6 §§6.1-6.5.'),
(501, 'definition', 80, 72, 'primary_source', 'Lineare Algebra zu Eigenwerten, Eigenräumen, charakteristischem Polynom und Diagonalisierung; Quelle [72], Kap. 6 §§6.1-6.5.'),
(504, 'definition', 81, 73, 'primary_source', 'Funktionalanalytische Operator- und Spektraltheorie; Quelle [73].'),
(505, 'definition', 82, 73, 'primary_source', 'Funktionalanalytische Operator- und Spektraltheorie; Quelle [73].'),
(506, 'definition', 83, 73, 'primary_source', 'Funktionalanalytische Operator- und Spektraltheorie; Quelle [73].'),
(507, 'definition', 84, 73, 'primary_source', 'Funktionalanalytische Operator- und Spektraltheorie; Quelle [73].'),
(508, 'definition', 85, 73, 'primary_source', 'Funktionalanalytische Operator- und Spektraltheorie; Quelle [73].'),
(511, 'theorem', 33, 72, 'primary_source', 'Endlichdimensionale Eigenwerttheorie; Quelle [72].'),
(512, 'theorem', 34, 72, 'primary_source', 'Endlichdimensionale Eigenwerttheorie; Quelle [72].'),
(513, 'theorem', 35, 72, 'primary_source', 'Endlichdimensionale Eigenwerttheorie; Quelle [72].'),
(514, 'theorem', 36, 73, 'primary_source', 'Spektraltheorie beschränkter Operatoren und invariante Teilräume; Quelle [73].'),
(515, 'theorem', 37, 73, 'primary_source', 'Spektraltheorie beschränkter Operatoren und invariante Teilräume; Quelle [73].'),
(516, 'theorem', 38, 73, 'primary_source', 'Spektraltheorie beschränkter Operatoren und invariante Teilräume; Quelle [73].'),
(517, 'theorem', 39, 73, 'primary_source', 'Spektraltheorie beschränkter Operatoren und invariante Teilräume; Quelle [73].'),
(521, 'equation', 246, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(522, 'equation', 247, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(523, 'equation', 248, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(524, 'equation', 249, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(525, 'equation', 250, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(526, 'equation', 251, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(527, 'equation', 252, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(528, 'equation', 253, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(529, 'equation', 254, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(530, 'equation', 255, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(531, 'equation', 256, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(532, 'equation', 257, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(533, 'equation', 258, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(534, 'equation', 259, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(535, 'equation', 260, 72, 'primary_source', 'Endlichdimensionale Eigenwert- und Diagonalisierungstheorie; Quelle [72].'),
(536, 'equation', 261, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(537, 'equation', 262, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(538, 'equation', 263, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(539, 'equation', 264, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(540, 'equation', 265, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(541, 'equation', 266, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(542, 'equation', 267, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(543, 'equation', 268, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(544, 'equation', 269, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(545, 'equation', 270, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(546, 'equation', 271, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(547, 'equation', 272, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(548, 'equation', 273, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(549, 'equation', 274, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(550, 'equation', 275, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(551, 'equation', 276, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(552, 'equation', 277, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(553, 'equation', 278, 73, 'primary_source', 'Funktionalanalytische Spektral- und Invarianztheorie; Quelle [73].'),
(567, 'definition', 86, 73, 'primary_source', 'Hilbertraum- und Projektionstheorie; Quelle [73].'),
(568, 'definition', 87, 73, 'primary_source', 'Hilbertraum- und Projektionstheorie; Quelle [73].'),
(569, 'definition', 88, 73, 'primary_source', 'Hilbertraum- und Projektionstheorie; Quelle [73].'),
(570, 'definition', 89, 73, 'primary_source', 'Hilbertraum- und Projektionstheorie; Quelle [73].'),
(571, 'definition', 90, 73, 'primary_source', 'Hilbertraum- und Projektionstheorie; Quelle [73].'),
(574, 'theorem', 40, 73, 'primary_source', 'Hilbertraum- und Operatorprojektionstheorie; Quelle [73].'),
(575, 'theorem', 41, 73, 'primary_source', 'Hilbertraum- und Operatorprojektionstheorie; Quelle [73].'),
(576, 'theorem', 42, 73, 'primary_source', 'Hilbertraum- und Operatorprojektionstheorie; Quelle [73].'),
(577, 'theorem', 43, 73, 'primary_source', 'Hilbertraum- und Operatorprojektionstheorie; Quelle [73].'),
(578, 'theorem', 44, 73, 'primary_source', 'Hilbertraum- und Operatorprojektionstheorie; Quelle [73].'),
(579, 'theorem', 45, 73, 'primary_source', 'Hilbertraum- und Operatorprojektionstheorie; Quelle [73].'),
(580, 'theorem', 46, 73, 'primary_source', 'Hilbertraum- und Operatorprojektionstheorie; Quelle [73].'),
(581, 'theorem', 47, 73, 'primary_source', 'Hilbertraum- und Operatorprojektionstheorie; Quelle [73].'),
(589, 'equation', 313, 72, 'primary_source', 'Endlichdimensionale Orthogonalitäts- und Projektionsrechnung; Quelle [72], Kap. 4 §§4.1-4.4.'),
(590, 'equation', 314, 72, 'primary_source', 'Endlichdimensionale Orthogonalitäts- und Projektionsrechnung; Quelle [72], Kap. 4 §§4.1-4.4.'),
(591, 'equation', 315, 72, 'primary_source', 'Endlichdimensionale Orthogonalitäts- und Projektionsrechnung; Quelle [72], Kap. 4 §§4.1-4.4.'),
(592, 'equation', 316, 72, 'primary_source', 'Endlichdimensionale Orthogonalitäts- und Projektionsrechnung; Quelle [72], Kap. 4 §§4.1-4.4.'),
(593, 'equation', 317, 72, 'primary_source', 'Endlichdimensionale Orthogonalitäts- und Projektionsrechnung; Quelle [72], Kap. 4 §§4.1-4.4.'),
(594, 'equation', 330, 72, 'primary_source', 'Endlichdimensionale Orthogonalitäts- und Projektionsrechnung; Quelle [72], Kap. 4 §§4.1-4.4.'),
(595, 'equation', 331, 72, 'primary_source', 'Endlichdimensionale Orthogonalitäts- und Projektionsrechnung; Quelle [72], Kap. 4 §§4.1-4.4.'),
(596, 'equation', 281, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(597, 'equation', 282, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(598, 'equation', 283, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(599, 'equation', 284, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(600, 'equation', 285, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(601, 'equation', 286, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(602, 'equation', 287, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(603, 'equation', 288, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(604, 'equation', 289, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(605, 'equation', 290, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(606, 'equation', 291, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(607, 'equation', 292, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(608, 'equation', 293, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(609, 'equation', 294, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(610, 'equation', 295, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(611, 'equation', 296, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(612, 'equation', 297, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(613, 'equation', 298, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(614, 'equation', 299, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(615, 'equation', 300, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(616, 'equation', 301, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(617, 'equation', 302, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(618, 'equation', 303, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(619, 'equation', 304, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(620, 'equation', 305, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(621, 'equation', 306, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(622, 'equation', 307, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(623, 'equation', 308, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(624, 'equation', 309, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(625, 'equation', 310, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(626, 'equation', 311, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(627, 'equation', 312, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(628, 'equation', 318, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(629, 'equation', 319, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(630, 'equation', 320, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(631, 'equation', 321, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(632, 'equation', 322, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(633, 'equation', 323, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(634, 'equation', 324, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(635, 'equation', 325, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(636, 'equation', 326, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(637, 'equation', 329, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(638, 'equation', 332, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(639, 'equation', 333, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(640, 'equation', 334, 73, 'primary_source', 'Hilbertraumzerlegung, Projektionen und reduzierte Teilräume; Quelle [73].'),
(659, 'definition', 91, 75, 'primary_source', 'Grundlagen gewöhnlicher Differentialgleichungen; Quelle [76].'),
(660, 'definition', 92, 75, 'primary_source', 'Grundlagen gewöhnlicher Differentialgleichungen; Quelle [76].'),
(661, 'definition', 93, 75, 'primary_source', 'Grundlagen gewöhnlicher Differentialgleichungen; Quelle [76].'),
(662, 'definition', 94, 75, 'primary_source', 'Grundlagen gewöhnlicher Differentialgleichungen; Quelle [76].'),
(663, 'definition', 95, 75, 'primary_source', 'Grundlagen gewöhnlicher Differentialgleichungen; Quelle [76].'),
(664, 'definition', 96, 75, 'primary_source', 'Grundlagen gewöhnlicher Differentialgleichungen; Quelle [76].'),
(666, 'definition', 97, 76, 'primary_source', 'Grundlagen partieller Differentialgleichungen und Differentialprobleme; Quelle [77].'),
(667, 'definition', 98, 76, 'primary_source', 'Grundlagen partieller Differentialgleichungen und Differentialprobleme; Quelle [77].'),
(668, 'definition', 99, 76, 'primary_source', 'Grundlagen partieller Differentialgleichungen und Differentialprobleme; Quelle [77].'),
(669, 'definition', 100, 76, 'primary_source', 'Grundlagen partieller Differentialgleichungen und Differentialprobleme; Quelle [77].'),
(670, 'definition', 101, 76, 'primary_source', 'Grundlagen partieller Differentialgleichungen und Differentialprobleme; Quelle [77].'),
(673, 'theorem', 48, 75, 'primary_source', 'Existenz, Eindeutigkeit, Gleichgewicht und lineare ODE-Struktur; Quelle [76].'),
(674, 'theorem', 49, 75, 'primary_source', 'Existenz, Eindeutigkeit, Gleichgewicht und lineare ODE-Struktur; Quelle [76].'),
(675, 'theorem', 50, 75, 'primary_source', 'Existenz, Eindeutigkeit, Gleichgewicht und lineare ODE-Struktur; Quelle [76].'),
(676, 'theorem', 51, 73, 'supporting_source', 'Lineare Operatorstruktur und Kern; Quelle [73].'),
(677, 'equation', 335, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(678, 'equation', 336, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(679, 'equation', 338, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(680, 'equation', 339, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(681, 'equation', 340, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(682, 'equation', 342, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(683, 'equation', 343, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(684, 'equation', 344, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(685, 'equation', 345, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(686, 'equation', 346, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(687, 'equation', 348, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(688, 'equation', 349, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(689, 'equation', 350, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(690, 'equation', 351, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(691, 'equation', 352, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(692, 'equation', 353, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(693, 'equation', 354, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(694, 'equation', 355, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(695, 'equation', 356, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(696, 'equation', 382, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(697, 'equation', 386, 75, 'primary_source', 'Gewöhnliche Differentialgleichungen und Anfangswertprobleme; Quelle [76].'),
(708, 'equation', 357, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(709, 'equation', 358, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(710, 'equation', 359, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(711, 'equation', 360, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(712, 'equation', 361, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(713, 'equation', 362, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(714, 'equation', 363, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(715, 'equation', 364, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(716, 'equation', 365, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(717, 'equation', 367, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(718, 'equation', 368, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(719, 'equation', 379, 76, 'primary_source', 'Partielle Differentialgleichungen, Anfangs-/Randdaten und Wohlgestelltheit; Quelle [77].'),
(723, 'equation', 370, 73, 'supporting_source', 'Abstrakte lineare Operatorstruktur, Definitionsbereich, Kern und affine Lösungsmenge; Quelle [73].'),
(724, 'equation', 371, 73, 'supporting_source', 'Abstrakte lineare Operatorstruktur, Definitionsbereich, Kern und affine Lösungsmenge; Quelle [73].'),
(725, 'equation', 372, 73, 'supporting_source', 'Abstrakte lineare Operatorstruktur, Definitionsbereich, Kern und affine Lösungsmenge; Quelle [73].'),
(726, 'equation', 373, 73, 'supporting_source', 'Abstrakte lineare Operatorstruktur, Definitionsbereich, Kern und affine Lösungsmenge; Quelle [73].'),
(727, 'equation', 374, 73, 'supporting_source', 'Abstrakte lineare Operatorstruktur, Definitionsbereich, Kern und affine Lösungsmenge; Quelle [73].'),
(728, 'equation', 375, 73, 'supporting_source', 'Abstrakte lineare Operatorstruktur, Definitionsbereich, Kern und affine Lösungsmenge; Quelle [73].'),
(729, 'equation', 376, 73, 'supporting_source', 'Abstrakte lineare Operatorstruktur, Definitionsbereich, Kern und affine Lösungsmenge; Quelle [73].'),
(730, 'equation', 377, 73, 'supporting_source', 'Abstrakte lineare Operatorstruktur, Definitionsbereich, Kern und affine Lösungsmenge; Quelle [73].'),
(731, 'equation', 378, 73, 'supporting_source', 'Abstrakte lineare Operatorstruktur, Definitionsbereich, Kern und affine Lösungsmenge; Quelle [73].'),
(738, 'definition', 102, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(739, 'definition', 103, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(740, 'definition', 104, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(741, 'definition', 105, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(742, 'definition', 106, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(743, 'definition', 107, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(744, 'definition', 108, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(745, 'definition', 109, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(746, 'definition', 110, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(747, 'definition', 111, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(748, 'definition', 112, 75, 'primary_source', 'Dynamische Systeme, Flüsse, Orbits und Evolutionsoperatoren; Quelle [76], Part 2, Chapter 6.'),
(753, 'theorem', 52, 75, 'primary_source', 'Fluss-, Orbit-, Fixpunkt-, lineare Evolutions- und Verkettungseigenschaften; Quelle [76].'),
(754, 'theorem', 53, 75, 'primary_source', 'Fluss-, Orbit-, Fixpunkt-, lineare Evolutions- und Verkettungseigenschaften; Quelle [76].'),
(755, 'theorem', 54, 75, 'primary_source', 'Fluss-, Orbit-, Fixpunkt-, lineare Evolutions- und Verkettungseigenschaften; Quelle [76].'),
(756, 'theorem', 55, 75, 'primary_source', 'Fluss-, Orbit-, Fixpunkt-, lineare Evolutions- und Verkettungseigenschaften; Quelle [76].'),
(757, 'theorem', 56, 75, 'primary_source', 'Fluss-, Orbit-, Fixpunkt-, lineare Evolutions- und Verkettungseigenschaften; Quelle [76].'),
(758, 'theorem', 57, 75, 'primary_source', 'Fluss-, Orbit-, Fixpunkt-, lineare Evolutions- und Verkettungseigenschaften; Quelle [76].'),
(759, 'theorem', 58, 75, 'primary_source', 'Fluss-, Orbit-, Fixpunkt-, lineare Evolutions- und Verkettungseigenschaften; Quelle [76].'),
(760, 'equation', 394, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(761, 'equation', 395, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(762, 'equation', 396, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(763, 'equation', 397, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(764, 'equation', 398, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(765, 'equation', 399, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(766, 'equation', 400, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(767, 'equation', 401, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(768, 'equation', 402, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(769, 'equation', 403, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(770, 'equation', 404, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(771, 'equation', 405, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(772, 'equation', 406, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(773, 'equation', 407, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(774, 'equation', 408, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(775, 'equation', 409, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(776, 'equation', 410, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(777, 'equation', 411, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(778, 'equation', 412, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(779, 'equation', 413, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(780, 'equation', 414, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(781, 'equation', 416, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(782, 'equation', 417, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(783, 'equation', 418, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(784, 'equation', 419, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(785, 'equation', 420, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(786, 'equation', 421, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(787, 'equation', 422, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(788, 'equation', 424, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(789, 'equation', 425, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(790, 'equation', 427, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(791, 'equation', 428, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(792, 'equation', 429, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(793, 'equation', 431, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(794, 'equation', 432, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(795, 'equation', 433, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(796, 'equation', 434, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(797, 'equation', 435, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(798, 'equation', 436, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(799, 'equation', 437, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(800, 'equation', 438, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(801, 'equation', 439, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(802, 'equation', 440, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(803, 'equation', 441, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(804, 'equation', 442, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(805, 'equation', 443, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(806, 'equation', 444, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(807, 'equation', 446, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(808, 'equation', 447, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(809, 'equation', 449, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(810, 'equation', 452, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(811, 'equation', 457, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(812, 'equation', 459, 75, 'primary_source', 'Dynamische Systeme, autonome Flüsse, Trajektorien, Orbits, lineare Flüsse und Evolutionsoperatoren; Quelle [76].'),
(823, 'definition', 113, 75, 'primary_source', 'Stabilität, Lyapunov-Funktionen, Linearisierung und Hyperbolizität; Quelle [76], Part 2, Chapter 9.'),
(824, 'definition', 114, 75, 'primary_source', 'Stabilität, Lyapunov-Funktionen, Linearisierung und Hyperbolizität; Quelle [76], Part 2, Chapter 9.'),
(825, 'definition', 115, 75, 'primary_source', 'Stabilität, Lyapunov-Funktionen, Linearisierung und Hyperbolizität; Quelle [76], Part 2, Chapter 9.'),
(826, 'definition', 116, 75, 'primary_source', 'Stabilität, Lyapunov-Funktionen, Linearisierung und Hyperbolizität; Quelle [76], Part 2, Chapter 9.'),
(827, 'definition', 117, 75, 'primary_source', 'Stabilität, Lyapunov-Funktionen, Linearisierung und Hyperbolizität; Quelle [76], Part 2, Chapter 9.'),
(828, 'definition', 118, 75, 'primary_source', 'Stabilität, Lyapunov-Funktionen, Linearisierung und Hyperbolizität; Quelle [76], Part 2, Chapter 9.'),
(829, 'definition', 119, 75, 'primary_source', 'Stabilität, Lyapunov-Funktionen, Linearisierung und Hyperbolizität; Quelle [76], Part 2, Chapter 9.'),
(830, 'definition', 120, 75, 'primary_source', 'Stabilität, Lyapunov-Funktionen, Linearisierung und Hyperbolizität; Quelle [76], Part 2, Chapter 9.'),
(831, 'definition', 121, 75, 'primary_source', 'Stabilität, Lyapunov-Funktionen, Linearisierung und Hyperbolizität; Quelle [76], Part 2, Chapter 9.'),
(832, 'definition', 122, 75, 'primary_source', 'Stabilität, Lyapunov-Funktionen, Linearisierung und Hyperbolizität; Quelle [76], Part 2, Chapter 9.'),
(838, 'theorem', 59, 75, 'primary_source', 'Lyapunov-, exponentielle, spektrale und linearisierte Stabilitätskriterien; Quelle [76].'),
(839, 'theorem', 60, 75, 'primary_source', 'Lyapunov-, exponentielle, spektrale und linearisierte Stabilitätskriterien; Quelle [76].'),
(840, 'theorem', 61, 75, 'primary_source', 'Lyapunov-, exponentielle, spektrale und linearisierte Stabilitätskriterien; Quelle [76].'),
(841, 'theorem', 62, 75, 'primary_source', 'Lyapunov-, exponentielle, spektrale und linearisierte Stabilitätskriterien; Quelle [76].'),
(842, 'theorem', 63, 75, 'primary_source', 'Lyapunov-, exponentielle, spektrale und linearisierte Stabilitätskriterien; Quelle [76].'),
(843, 'theorem', 64, 75, 'primary_source', 'Lyapunov-, exponentielle, spektrale und linearisierte Stabilitätskriterien; Quelle [76].'),
(844, 'theorem', 65, 75, 'primary_source', 'Lyapunov-, exponentielle, spektrale und linearisierte Stabilitätskriterien; Quelle [76].'),
(845, 'equation', 463, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(846, 'equation', 464, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(847, 'equation', 465, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(848, 'equation', 466, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(849, 'equation', 467, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(850, 'equation', 469, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(851, 'equation', 470, 75, 'adapted_from', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(852, 'equation', 471, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(853, 'equation', 472, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(854, 'equation', 473, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(855, 'equation', 474, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(856, 'equation', 475, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(857, 'equation', 476, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(858, 'equation', 477, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(859, 'equation', 478, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(860, 'equation', 480, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(861, 'equation', 485, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(862, 'equation', 488, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(863, 'equation', 489, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(864, 'equation', 490, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(865, 'equation', 491, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(866, 'equation', 492, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(867, 'equation', 493, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(868, 'equation', 494, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(869, 'equation', 495, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(870, 'equation', 496, 75, 'adapted_from', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(871, 'equation', 497, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(872, 'equation', 498, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(873, 'equation', 503, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(874, 'equation', 504, 75, 'adapted_from', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(875, 'equation', 505, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(876, 'equation', 506, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(877, 'equation', 507, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(878, 'equation', 508, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(879, 'equation', 509, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(880, 'equation', 510, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(881, 'equation', 511, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(882, 'equation', 512, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(883, 'equation', 513, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(884, 'equation', 515, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(885, 'equation', 516, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(886, 'equation', 517, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(887, 'equation', 518, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(888, 'equation', 526, 75, 'adapted_from', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(889, 'equation', 527, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(890, 'equation', 530, 75, 'primary_source', 'Stabilitäts- und Linearisierungsstruktur; Quelle [76].'),
(908, 'definition', 123, 75, 'primary_source', 'Omega-Grenzmengen, stabile und anziehende Mengen, Fanggebiete und Attraktoren; Quelle [76].'),
(909, 'definition', 124, 75, 'primary_source', 'Omega-Grenzmengen, stabile und anziehende Mengen, Fanggebiete und Attraktoren; Quelle [76].'),
(910, 'definition', 125, 75, 'primary_source', 'Omega-Grenzmengen, stabile und anziehende Mengen, Fanggebiete und Attraktoren; Quelle [76].'),
(911, 'definition', 126, 75, 'primary_source', 'Omega-Grenzmengen, stabile und anziehende Mengen, Fanggebiete und Attraktoren; Quelle [76].'),
(912, 'definition', 127, 75, 'primary_source', 'Omega-Grenzmengen, stabile und anziehende Mengen, Fanggebiete und Attraktoren; Quelle [76].'),
(913, 'definition', 128, 75, 'primary_source', 'Omega-Grenzmengen, stabile und anziehende Mengen, Fanggebiete und Attraktoren; Quelle [76].'),
(914, 'definition', 129, 75, 'primary_source', 'Omega-Grenzmengen, stabile und anziehende Mengen, Fanggebiete und Attraktoren; Quelle [76].'),
(915, 'definition', 130, 75, 'primary_source', 'Omega-Grenzmengen, stabile und anziehende Mengen, Fanggebiete und Attraktoren; Quelle [76].'),
(916, 'definition', 131, 75, 'primary_source', 'Omega-Grenzmengen, stabile und anziehende Mengen, Fanggebiete und Attraktoren; Quelle [76].'),
(917, 'definition', 132, 75, 'primary_source', 'Omega-Grenzmengen, stabile und anziehende Mengen, Fanggebiete und Attraktoren; Quelle [76].'),
(923, 'theorem', 66, 75, 'primary_source', 'Invarianz, Kompaktheit und asymptotische Eigenschaften von Grenzmengen sowie Fanggebietsresultate; Quelle [76].'),
(924, 'theorem', 67, 75, 'primary_source', 'Invarianz, Kompaktheit und asymptotische Eigenschaften von Grenzmengen sowie Fanggebietsresultate; Quelle [76].'),
(925, 'theorem', 68, 75, 'primary_source', 'Invarianz, Kompaktheit und asymptotische Eigenschaften von Grenzmengen sowie Fanggebietsresultate; Quelle [76].'),
(926, 'theorem', 69, 75, 'primary_source', 'Invarianz, Kompaktheit und asymptotische Eigenschaften von Grenzmengen sowie Fanggebietsresultate; Quelle [76].'),
(930, 'equation', 533, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(931, 'equation', 534, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(932, 'equation', 535, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(933, 'equation', 536, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(934, 'equation', 537, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(935, 'equation', 538, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(936, 'equation', 539, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(937, 'equation', 540, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(938, 'equation', 541, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(939, 'equation', 542, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(940, 'equation', 543, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(941, 'equation', 544, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(942, 'equation', 545, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(943, 'equation', 546, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(944, 'equation', 547, 75, 'adapted_from', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(945, 'equation', 548, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(946, 'equation', 549, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(947, 'equation', 550, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(948, 'equation', 551, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(949, 'equation', 552, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(950, 'equation', 553, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(951, 'equation', 554, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(952, 'equation', 555, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(953, 'equation', 556, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(954, 'equation', 557, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(955, 'equation', 558, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(956, 'equation', 559, 75, 'adapted_from', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(957, 'equation', 561, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(958, 'equation', 562, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(959, 'equation', 567, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(960, 'equation', 572, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(961, 'equation', 576, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(962, 'equation', 577, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(963, 'equation', 578, 75, 'primary_source', 'Asymptotische Dynamik und Attraktorstruktur; Quelle [76].'),
(993, 'definition', 133, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(994, 'definition', 134, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(995, 'definition', 135, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(996, 'definition', 136, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(997, 'definition', 137, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(998, 'definition', 138, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(999, 'definition', 139, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(1000, 'definition', 140, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(1001, 'definition', 141, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(1002, 'definition', 142, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(1003, 'definition', 143, 77, 'primary_source', 'Grundbegriffe glatter Mannigfaltigkeiten, glatter Abbildungen und Tangentialräume; Quelle [78].'),
(1008, 'theorem', 70, 77, 'primary_source', 'Kartenunabhängigkeit, Verkettung, Tangentialraumdimension, Basiswechsel, Differential und Kettenregel; Quelle [78].'),
(1009, 'theorem', 71, 77, 'primary_source', 'Kartenunabhängigkeit, Verkettung, Tangentialraumdimension, Basiswechsel, Differential und Kettenregel; Quelle [78].'),
(1010, 'theorem', 72, 77, 'primary_source', 'Kartenunabhängigkeit, Verkettung, Tangentialraumdimension, Basiswechsel, Differential und Kettenregel; Quelle [78].'),
(1011, 'theorem', 73, 77, 'primary_source', 'Kartenunabhängigkeit, Verkettung, Tangentialraumdimension, Basiswechsel, Differential und Kettenregel; Quelle [78].'),
(1012, 'theorem', 74, 77, 'primary_source', 'Kartenunabhängigkeit, Verkettung, Tangentialraumdimension, Basiswechsel, Differential und Kettenregel; Quelle [78].'),
(1013, 'theorem', 75, 77, 'primary_source', 'Kartenunabhängigkeit, Verkettung, Tangentialraumdimension, Basiswechsel, Differential und Kettenregel; Quelle [78].'),
(1014, 'theorem', 76, 77, 'primary_source', 'Kartenunabhängigkeit, Verkettung, Tangentialraumdimension, Basiswechsel, Differential und Kettenregel; Quelle [78].'),
(1015, 'equation', 583, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1016, 'equation', 584, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1017, 'equation', 585, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1018, 'equation', 586, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1019, 'equation', 587, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1020, 'equation', 589, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1021, 'equation', 590, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1022, 'equation', 591, 77, 'adapted_from', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1023, 'equation', 592, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1024, 'equation', 593, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1025, 'equation', 594, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1026, 'equation', 595, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1027, 'equation', 596, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1028, 'equation', 597, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1029, 'equation', 598, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1030, 'equation', 599, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1031, 'equation', 601, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1032, 'equation', 602, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1033, 'equation', 603, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1034, 'equation', 604, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1035, 'equation', 606, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1036, 'equation', 607, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].');
INSERT INTO `object_source_links` (`object_source_link_id`, `object_type`, `object_id`, `source_id`, `usage_type`, `note`) VALUES
(1037, 'equation', 608, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1038, 'equation', 609, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1039, 'equation', 610, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1040, 'equation', 611, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1041, 'equation', 612, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1042, 'equation', 613, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1043, 'equation', 614, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1044, 'equation', 615, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1045, 'equation', 616, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1046, 'equation', 617, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1047, 'equation', 618, 77, 'adapted_from', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1048, 'equation', 625, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1049, 'equation', 629, 77, 'adapted_from', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1050, 'equation', 630, 77, 'adapted_from', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1051, 'equation', 632, 77, 'primary_source', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1052, 'equation', 635, 77, 'adapted_from', 'Mannigfaltigkeits-, Tangentialraum- und Differentialstruktur; Quelle [78].'),
(1081, 'definition', 155, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1082, 'definition', 156, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1083, 'definition', 157, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1084, 'definition', 158, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1085, 'definition', 159, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1086, 'definition', 160, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1087, 'definition', 161, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1088, 'definition', 162, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1089, 'definition', 163, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1090, 'definition', 164, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1091, 'definition', 165, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1092, 'definition', 166, 78, 'primary_source', 'Semi-/pseudo-riemannsche Metrik, Signatur, riemannsche und lorentzsche Geometrie sowie Isometrien; Quelle [79].'),
(1096, 'theorem', 84, 78, 'primary_source', 'Trägheit, Indexinvarianz und Erhaltung metrischer Klassen durch Isometrien; Quelle [79].'),
(1097, 'theorem', 85, 78, 'primary_source', 'Trägheit, Indexinvarianz und Erhaltung metrischer Klassen durch Isometrien; Quelle [79].'),
(1098, 'theorem', 86, 78, 'primary_source', 'Trägheit, Indexinvarianz und Erhaltung metrischer Klassen durch Isometrien; Quelle [79].'),
(1099, 'equation', 693, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1100, 'equation', 694, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1101, 'equation', 695, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1102, 'equation', 696, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1103, 'equation', 697, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1104, 'equation', 698, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1105, 'equation', 699, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1106, 'equation', 700, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1107, 'equation', 701, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1108, 'equation', 702, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1109, 'equation', 703, 78, 'adapted_from', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1110, 'equation', 704, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1111, 'equation', 705, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1112, 'equation', 706, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1113, 'equation', 707, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1114, 'equation', 708, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1115, 'equation', 709, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1116, 'equation', 710, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1117, 'equation', 711, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1118, 'equation', 713, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1119, 'equation', 714, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1120, 'equation', 715, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1121, 'equation', 716, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1122, 'equation', 717, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1123, 'equation', 718, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1124, 'equation', 719, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1125, 'equation', 720, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1126, 'equation', 721, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1127, 'equation', 722, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1128, 'equation', 723, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1129, 'equation', 724, 78, 'adapted_from', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1130, 'equation', 725, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1131, 'equation', 727, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1132, 'equation', 728, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1133, 'equation', 729, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1134, 'equation', 730, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1135, 'equation', 731, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1136, 'equation', 735, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1137, 'equation', 736, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1138, 'equation', 737, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1139, 'equation', 738, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1140, 'equation', 739, 78, 'adapted_from', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1141, 'equation', 740, 78, 'adapted_from', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1142, 'equation', 743, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1143, 'equation', 745, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1144, 'equation', 750, 78, 'adapted_from', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1145, 'equation', 751, 78, 'adapted_from', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1146, 'equation', 753, 78, 'adapted_from', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1147, 'equation', 755, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1148, 'equation', 756, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1149, 'equation', 758, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1150, 'equation', 759, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1151, 'equation', 760, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1152, 'equation', 771, 78, 'primary_source', 'Metrische Bilinearform-, Signatur-, Lorentz- und Isometriestruktur; Quelle [79].'),
(1162, 'definition', 167, 78, 'primary_source', 'Zusammenhang, Torsion, Metrikverträglichkeit, kovariante Kurvenableitung und Paralleltransport; Quelle [79].'),
(1163, 'definition', 168, 78, 'primary_source', 'Zusammenhang, Torsion, Metrikverträglichkeit, kovariante Kurvenableitung und Paralleltransport; Quelle [79].'),
(1164, 'definition', 169, 78, 'primary_source', 'Zusammenhang, Torsion, Metrikverträglichkeit, kovariante Kurvenableitung und Paralleltransport; Quelle [79].'),
(1165, 'definition', 170, 78, 'primary_source', 'Zusammenhang, Torsion, Metrikverträglichkeit, kovariante Kurvenableitung und Paralleltransport; Quelle [79].'),
(1166, 'definition', 171, 78, 'primary_source', 'Zusammenhang, Torsion, Metrikverträglichkeit, kovariante Kurvenableitung und Paralleltransport; Quelle [79].'),
(1167, 'definition', 172, 78, 'primary_source', 'Zusammenhang, Torsion, Metrikverträglichkeit, kovariante Kurvenableitung und Paralleltransport; Quelle [79].'),
(1168, 'definition', 173, 78, 'primary_source', 'Zusammenhang, Torsion, Metrikverträglichkeit, kovariante Kurvenableitung und Paralleltransport; Quelle [79].'),
(1169, 'definition', 174, 78, 'primary_source', 'Zusammenhang, Torsion, Metrikverträglichkeit, kovariante Kurvenableitung und Paralleltransport; Quelle [79].'),
(1170, 'definition', 175, 78, 'primary_source', 'Zusammenhang, Torsion, Metrikverträglichkeit, kovariante Kurvenableitung und Paralleltransport; Quelle [79].'),
(1177, 'theorem', 87, 78, 'primary_source', 'Levi-Civita-Eindeutigkeit, Koszul-Formel, Christoffel-Symbole und Eigenschaften des Paralleltransports; Quelle [79].'),
(1178, 'theorem', 88, 78, 'primary_source', 'Levi-Civita-Eindeutigkeit, Koszul-Formel, Christoffel-Symbole und Eigenschaften des Paralleltransports; Quelle [79].'),
(1179, 'theorem', 89, 78, 'primary_source', 'Levi-Civita-Eindeutigkeit, Koszul-Formel, Christoffel-Symbole und Eigenschaften des Paralleltransports; Quelle [79].'),
(1180, 'theorem', 90, 78, 'primary_source', 'Levi-Civita-Eindeutigkeit, Koszul-Formel, Christoffel-Symbole und Eigenschaften des Paralleltransports; Quelle [79].'),
(1181, 'theorem', 91, 78, 'primary_source', 'Levi-Civita-Eindeutigkeit, Koszul-Formel, Christoffel-Symbole und Eigenschaften des Paralleltransports; Quelle [79].'),
(1182, 'theorem', 92, 78, 'primary_source', 'Levi-Civita-Eindeutigkeit, Koszul-Formel, Christoffel-Symbole und Eigenschaften des Paralleltransports; Quelle [79].'),
(1184, 'equation', 773, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1185, 'equation', 774, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1186, 'equation', 775, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1187, 'equation', 776, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1188, 'equation', 777, 78, 'adapted_from', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1189, 'equation', 779, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1190, 'equation', 780, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1191, 'equation', 781, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1192, 'equation', 782, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1193, 'equation', 784, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1194, 'equation', 785, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1195, 'equation', 786, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1196, 'equation', 787, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1197, 'equation', 789, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1198, 'equation', 790, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1199, 'equation', 791, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1200, 'equation', 792, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1201, 'equation', 793, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1202, 'equation', 794, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1203, 'equation', 795, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1204, 'equation', 796, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1205, 'equation', 797, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1206, 'equation', 798, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1207, 'equation', 799, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1208, 'equation', 801, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1209, 'equation', 802, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1210, 'equation', 803, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1211, 'equation', 804, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1212, 'equation', 805, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1213, 'equation', 806, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1214, 'equation', 807, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1215, 'equation', 809, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1216, 'equation', 810, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1217, 'equation', 811, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1218, 'equation', 812, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1219, 'equation', 813, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1220, 'equation', 816, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1221, 'equation', 817, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1222, 'equation', 818, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1223, 'equation', 819, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1224, 'equation', 820, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1225, 'equation', 821, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1226, 'equation', 822, 78, 'adapted_from', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1227, 'equation', 823, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1228, 'equation', 830, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1229, 'equation', 833, 78, 'adapted_from', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1230, 'equation', 835, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1231, 'equation', 836, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1232, 'equation', 837, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1233, 'equation', 840, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1234, 'equation', 842, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1235, 'equation', 843, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1236, 'equation', 844, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1237, 'equation', 848, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1238, 'equation', 849, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1239, 'equation', 851, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1240, 'equation', 852, 78, 'primary_source', 'Kovariante Differential- und Paralleltransportstruktur; Quelle [79].'),
(1247, 'definition', 176, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1248, 'definition', 177, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1249, 'definition', 178, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1250, 'definition', 179, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1251, 'definition', 180, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1252, 'definition', 181, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1253, 'definition', 182, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1254, 'definition', 183, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1255, 'definition', 184, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1256, 'definition', 185, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1257, 'definition', 186, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1258, 'definition', 187, 78, 'primary_source', 'Geodäten, Exponentialabbildung, Krümmung und geodätische Vollständigkeit; Quelle [79].'),
(1262, 'theorem', 93, 78, 'primary_source', 'Geodätenexistenz, Exponentialabbildung, Tensorialität und Symmetrien der Krümmung, Schnittkrümmung und Jacobi-Felder; Quelle [79].'),
(1263, 'theorem', 94, 78, 'primary_source', 'Geodätenexistenz, Exponentialabbildung, Tensorialität und Symmetrien der Krümmung, Schnittkrümmung und Jacobi-Felder; Quelle [79].'),
(1264, 'theorem', 95, 78, 'primary_source', 'Geodätenexistenz, Exponentialabbildung, Tensorialität und Symmetrien der Krümmung, Schnittkrümmung und Jacobi-Felder; Quelle [79].'),
(1265, 'theorem', 96, 78, 'primary_source', 'Geodätenexistenz, Exponentialabbildung, Tensorialität und Symmetrien der Krümmung, Schnittkrümmung und Jacobi-Felder; Quelle [79].'),
(1266, 'theorem', 97, 78, 'primary_source', 'Geodätenexistenz, Exponentialabbildung, Tensorialität und Symmetrien der Krümmung, Schnittkrümmung und Jacobi-Felder; Quelle [79].'),
(1267, 'theorem', 98, 78, 'primary_source', 'Geodätenexistenz, Exponentialabbildung, Tensorialität und Symmetrien der Krümmung, Schnittkrümmung und Jacobi-Felder; Quelle [79].'),
(1268, 'theorem', 99, 78, 'primary_source', 'Geodätenexistenz, Exponentialabbildung, Tensorialität und Symmetrien der Krümmung, Schnittkrümmung und Jacobi-Felder; Quelle [79].'),
(1269, 'equation', 853, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1270, 'equation', 854, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1271, 'equation', 855, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1272, 'equation', 857, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1273, 'equation', 858, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1274, 'equation', 859, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1275, 'equation', 860, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1276, 'equation', 861, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1277, 'equation', 862, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1278, 'equation', 865, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1279, 'equation', 866, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1280, 'equation', 867, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1281, 'equation', 868, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1282, 'equation', 869, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1283, 'equation', 870, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1284, 'equation', 871, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1285, 'equation', 872, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1286, 'equation', 873, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1287, 'equation', 874, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1288, 'equation', 875, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1289, 'equation', 877, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1290, 'equation', 878, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1291, 'equation', 879, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1292, 'equation', 880, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1293, 'equation', 881, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1294, 'equation', 882, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1295, 'equation', 883, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1296, 'equation', 884, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1297, 'equation', 885, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1298, 'equation', 886, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1299, 'equation', 887, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1300, 'equation', 889, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1301, 'equation', 892, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1302, 'equation', 893, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1303, 'equation', 894, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1304, 'equation', 895, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1305, 'equation', 896, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1306, 'equation', 897, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1307, 'equation', 898, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1308, 'equation', 899, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1309, 'equation', 900, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1310, 'equation', 901, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1311, 'equation', 902, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1312, 'equation', 905, 78, 'adapted_from', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1313, 'equation', 906, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1314, 'equation', 907, 78, 'adapted_from', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1315, 'equation', 908, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1316, 'equation', 911, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1317, 'equation', 920, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1318, 'equation', 921, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1319, 'equation', 929, 78, 'primary_source', 'Geodätische, exponentielle und Krümmungsstruktur; Quelle [79].'),
(1332, 'definition', 188, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1333, 'definition', 189, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1334, 'definition', 190, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1335, 'definition', 191, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1336, 'definition', 192, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1337, 'definition', 193, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1338, 'definition', 194, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1339, 'definition', 195, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1340, 'definition', 196, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1341, 'definition', 197, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1342, 'definition', 198, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1343, 'definition', 199, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1344, 'definition', 200, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1345, 'definition', 201, 78, 'primary_source', 'Zeitorientierung, kausale Kurven und globale Kausalitätsbedingungen; Quelle [79].'),
(1347, 'theorem', 100, 78, 'primary_source', 'Offenheit, Transitivität, Push-up-Eigenschaft und konforme Erhaltung der kausalen Klassen; Quelle [79].'),
(1348, 'theorem', 101, 78, 'primary_source', 'Offenheit, Transitivität, Push-up-Eigenschaft und konforme Erhaltung der kausalen Klassen; Quelle [79].'),
(1349, 'theorem', 102, 78, 'primary_source', 'Offenheit, Transitivität, Push-up-Eigenschaft und konforme Erhaltung der kausalen Klassen; Quelle [79].'),
(1350, 'theorem', 103, 78, 'primary_source', 'Offenheit, Transitivität, Push-up-Eigenschaft und konforme Erhaltung der kausalen Klassen; Quelle [79].'),
(1351, 'theorem', 104, 78, 'primary_source', 'Offenheit, Transitivität, Push-up-Eigenschaft und konforme Erhaltung der kausalen Klassen; Quelle [79].'),
(1354, 'equation', 933, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1355, 'equation', 934, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1356, 'equation', 935, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1357, 'equation', 936, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1358, 'equation', 937, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1359, 'equation', 938, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1360, 'equation', 939, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1361, 'equation', 940, 78, 'adapted_from', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1362, 'equation', 942, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1363, 'equation', 943, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1364, 'equation', 944, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1365, 'equation', 945, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1366, 'equation', 946, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1367, 'equation', 947, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1368, 'equation', 948, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1369, 'equation', 949, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1370, 'equation', 950, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1371, 'equation', 951, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1372, 'equation', 952, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1373, 'equation', 953, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1374, 'equation', 954, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1375, 'equation', 955, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1376, 'equation', 956, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1377, 'equation', 957, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1378, 'equation', 958, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1379, 'equation', 959, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1380, 'equation', 961, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1381, 'equation', 962, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1382, 'equation', 964, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1383, 'equation', 965, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1384, 'equation', 966, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1385, 'equation', 967, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1386, 'equation', 968, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1387, 'equation', 969, 78, 'adapted_from', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1388, 'equation', 970, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1389, 'equation', 971, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1390, 'equation', 972, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1391, 'equation', 973, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1392, 'equation', 974, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1393, 'equation', 975, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1394, 'equation', 976, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1395, 'equation', 977, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1396, 'equation', 980, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1397, 'equation', 981, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1398, 'equation', 982, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1399, 'equation', 983, 78, 'adapted_from', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1400, 'equation', 986, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1401, 'equation', 995, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1402, 'equation', 997, 78, 'primary_source', 'Lorentzsche Kegel-, Kurven- und Kausalstruktur; Quelle [79].'),
(1417, 'definition', 202, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1418, 'definition', 203, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1419, 'definition', 204, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1420, 'definition', 205, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1421, 'definition', 206, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1422, 'definition', 207, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1423, 'definition', 208, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1424, 'definition', 209, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1425, 'definition', 210, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1426, 'definition', 211, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1432, 'theorem', 105, 76, 'primary_source', 'Variationsrechnung, Euler-Lagrange-Struktur und notwendige Extremalbedingungen; Quelle [77].'),
(1433, 'theorem', 106, 76, 'primary_source', 'Variationsrechnung, Euler-Lagrange-Struktur und notwendige Extremalbedingungen; Quelle [77].'),
(1434, 'theorem', 107, 76, 'primary_source', 'Variationsrechnung, Euler-Lagrange-Struktur und notwendige Extremalbedingungen; Quelle [77].'),
(1435, 'theorem', 108, 76, 'adapted_from', 'Variationsrechnung, Euler-Lagrange-Struktur und notwendige Extremalbedingungen; Quelle [77].'),
(1436, 'theorem', 109, 76, 'primary_source', 'Variationsrechnung, Euler-Lagrange-Struktur und notwendige Extremalbedingungen; Quelle [77].'),
(1437, 'theorem', 110, 76, 'adapted_from', 'Variationsrechnung, Euler-Lagrange-Struktur und notwendige Extremalbedingungen; Quelle [77].'),
(1439, 'theorem', 111, 78, 'primary_source', 'Variationscharakterisierung von Geodäten; Quelle [79].'),
(1440, 'equation', 1003, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1441, 'equation', 1004, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1442, 'equation', 1005, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1443, 'equation', 1006, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1444, 'equation', 1007, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1445, 'equation', 1008, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1446, 'equation', 1009, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1447, 'equation', 1010, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1448, 'equation', 1013, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1449, 'equation', 1014, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1450, 'equation', 1015, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1451, 'equation', 1016, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1452, 'equation', 1017, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1453, 'equation', 1018, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1454, 'equation', 1019, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1455, 'equation', 1021, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1456, 'equation', 1022, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1457, 'equation', 1023, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1458, 'equation', 1024, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1459, 'equation', 1025, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1460, 'equation', 1026, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1461, 'equation', 1027, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1462, 'equation', 1028, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1463, 'equation', 1029, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1464, 'equation', 1030, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1465, 'equation', 1032, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1466, 'equation', 1033, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1467, 'equation', 1034, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1468, 'equation', 1035, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1469, 'equation', 1036, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1470, 'equation', 1037, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1471, 'equation', 1038, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1472, 'equation', 1039, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1473, 'equation', 1041, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1474, 'equation', 1042, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1475, 'equation', 1043, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1476, 'equation', 1045, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1477, 'equation', 1046, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1478, 'equation', 1047, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1479, 'equation', 1049, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1480, 'equation', 1050, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1481, 'equation', 1051, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1482, 'equation', 1054, 76, 'primary_source', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1483, 'equation', 1057, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1484, 'equation', 1058, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1485, 'equation', 1059, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1486, 'equation', 1060, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1487, 'equation', 1061, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1488, 'equation', 1064, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1489, 'equation', 1074, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1490, 'equation', 1081, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1491, 'equation', 1082, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1492, 'equation', 1083, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1493, 'equation', 1095, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1494, 'equation', 1096, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1495, 'equation', 1099, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1496, 'equation', 1101, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1497, 'equation', 1103, 76, 'adapted_from', 'Variationsrechnung und Euler-Lagrange-Strukturen; Quelle [77].'),
(1503, 'equation', 1076, 78, 'primary_source', 'Geodätisches Energie-Funktional und Variationscharakterisierung; Quelle [79].'),
(1504, 'equation', 1077, 78, 'primary_source', 'Geodätisches Energie-Funktional und Variationscharakterisierung; Quelle [79].'),
(1505, 'equation', 1078, 78, 'adapted_from', 'Geodätisches Energie-Funktional und Variationscharakterisierung; Quelle [79].'),
(1506, 'equation', 1079, 78, 'primary_source', 'Geodätisches Energie-Funktional und Variationscharakterisierung; Quelle [79].');

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
('current_section', '3.2.26', '2026-08-14 18:19:25'),
('last_citation_number', '79', '2026-08-14 14:31:45'),
('last_completed_chapter', '3.1', '2026-08-12 11:54:59'),
('last_completed_section', '3.2.25', '2026-08-14 18:19:25'),
('next_citation_number', '80', '2026-08-14 14:31:45');

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
(1, 'CH3.1-LIT-20260809', '2026-08-09 08:46:00', 'chapter', '3.1', '3.1-literaturbereinigt', 'Deduplizierte Literatur, korrigierte Erstnennungen, Source-Usage-Matrix und Abschnittsstruktur Kapitel 3.1. Gleichungen gemäß leerem equations-Bestand nicht erfunden.', 'Olaf Thiele / ChatGPT', NULL),
(2, 'RKB-NEU-K3.2.0-ABSCHLUSS-V4', '2026-08-12 13:54:59', 'section', '3.2.0', '3.2.0-Abschluss-v4', 'Neuaufbau von Abschnitt 3.2.0 „Einleitung“ als bedarfsorientierte mathematische Grundlegung für Kapitel 3.2. Wiederverwendung der vorhandenen Literatur [6], [59], [60], [67] und [68]; keine neuen Literaturstellen, Definitionen oder nummerierten Gleichungen.', 'Olaf Thiele / ChatGPT', 1),
(3, 'RKB-NEU-K3.2.1-ABSCHLUSS-V1', '2026-08-12 14:45:51', 'section', '3.2.1', '3.2.1-Abschluss-v1', 'Abschnitt 3.2.1 „Mengen, Elemente und Relationen“ vollständig aufgenommen: Definitionen 3.2.1 bis 3.2.5, Gleichungen 3.1 bis 3.13, Wiederverwendung [6] und neue verifizierte Literaturquelle [71].', 'Olaf Thiele / ChatGPT', 2),
(4, 'RKB-NEU-K3.2.2-ABSCHLUSS-V1', '2026-08-12 15:01:49', 'section', '3.2.2', '3.2.2-Abschluss-v1', 'Abschnitt 3.2.2 „Funktionen und eindeutige Zuordnungen“ vollständig aufgenommen: Definitionen 3.2.6 bis 3.2.12, Gleichungen 3.14 bis 3.25 sowie Wiederverwendung der vorhandenen Quellen [6] und [71]. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 3),
(5, 'RKB-NEU-K3.2.3-ABSCHLUSS-V1', '2026-08-12 15:16:23', 'section', '3.2.3', '3.2.3-Abschluss-v1', 'Abschnitt 3.2.3 „Vektorräume und mathematische Zustandsräume“ vollständig aufgenommen: Definitionen 3.2.13 bis 3.2.15, Gleichungen 3.26 bis 3.32 und neue Literaturquelle [72] Gilbert Strang.', 'Olaf Thiele / ChatGPT', 4),
(6, 'RKB-NEU-K3.2.4-ABSCHLUSS-V1', '2026-08-12 16:21:37', 'section', '3.2.4', '3.2.4-Abschluss-v1', 'Abschnitt 3.2.4 „Linearkombinationen, Spannräume und Erzeugung“ vollständig aufgenommen: Definitionen 3.2.16 bis 3.2.19, Gleichungen 3.33 bis 3.44 sowie Wiederverwendung der vorhandenen Quelle [72]. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 5),
(7, 'RKB-NEU-K3.2.5-ABSCHLUSS-V1', '2026-08-12 16:44:57', 'section', '3.2.5', '3.2.5-Abschluss-v1', 'Abschnitt 3.2.5 „Lineare Unabhängigkeit, Basis und Dimension“ vollständig aufgenommen: Definitionen 3.2.20 bis 3.2.22, Satz 3.2.1, Gleichungen 3.45 bis 3.57 sowie Wiederverwendung der vorhandenen Quelle [72]. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 6),
(8, 'RKB-NEU-K3.2.6-ABSCHLUSS-V1', '2026-08-12 17:41:29', 'section', '3.2.6', '3.2.6-Abschluss-v1', 'Abschnitt 3.2.6 „Lineare Abbildungen und Operatoren“ vollständig aufgenommen: Definitionen 3.2.23 bis 3.2.27, Sätze 3.2.2 bis 3.2.3, Gleichungen 3.58 bis 3.80 sowie Wiederverwendung der vorhandenen Quelle [72]. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 7),
(9, 'RKB-NEU-K3.2.7-ABSCHLUSS-V1', '2026-08-13 02:59:20', 'section', '3.2.7', '3.2.7-Abschluss-v1', 'Abschnitt 3.2.7 „Normen, Abstände und Skalarprodukte“ vollständig aufgenommen: Definitionen 3.2.28 bis 3.2.34, Sätze 3.2.4 bis 3.2.6, Gleichungen 3.81 bis 3.97, neue Quelle [73] Conway und ergänzende Wiederverwendung von [72] Strang.', 'Olaf Thiele / ChatGPT', 8),
(10, 'RKB-NEU-K3.2.8-ABSCHLUSS-V1', '2026-08-13 03:33:34', 'section', '3.2.8', '3.2.8-Abschluss-v1', 'Abschnitt 3.2.8 „Topologische Räume, Umgebungen und Stetigkeit“ vollständig aufgenommen: Definitionen 3.2.35 bis 3.2.43, Satz 3.2.7, Gleichungen 3.98 bis 3.119 und neue Quelle [74] Munkres.', 'Olaf Thiele / ChatGPT', 9),
(11, 'RKB-NEU-K3.2.9-ABSCHLUSS-V1', '2026-08-13 06:09:20', 'section', '3.2.9', '3.2.9-Abschluss-v1', 'Abschnitt 3.2.9 „Zusammenhang und Kompaktheit topologischer Zustandsräume“ vollständig aufgenommen: Definitionen 3.2.44 bis 3.2.52, Sätze 3.2.8 bis 3.2.12, Gleichungen 3.120 bis 3.139 sowie Wiederverwendung der vorhandenen Quelle [74]. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 10),
(12, 'RKB-NEU-K3.2.10-ABSCHLUSS-V1', '2026-08-13 06:23:37', 'section', '3.2.10', '3.2.10-Abschluss-v1', 'Abschnitt 3.2.10 „Folgen, Konvergenz und Vollständigkeit“ vollständig aufgenommen: Definitionen 3.2.53 bis 3.2.59, Sätze 3.2.13 bis 3.2.18, Gleichungen 3.140 bis 3.166 sowie Wiederverwendung der Quellen [73] Conway und [74] Munkres. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 11),
(13, 'RKB-NEU-K3.2.11-ABSCHLUSS-V1', '2026-08-13 06:37:15', 'section', '3.2.11', '3.2.11-Abschluss-v1', 'Abschnitt 3.2.11 „Funktionenräume als mathematische Zustandsräume“ vollständig aufgenommen: Definitionen 3.2.60 bis 3.2.68, Sätze 3.2.19 bis 3.2.25, Gleichungen 3.167 bis 3.202 sowie Wiederverwendung der Quellen [73] Conway und [74] Munkres. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 12),
(14, 'RKB-NEU-K3.2.12-ABSCHLUSS-V1', '2026-08-13 06:51:14', 'section', '3.2.12', '3.2.12-Abschluss-v1', 'Abschnitt 3.2.12 „Lineare Funktionale, Dualräume und beschränkte Operatoren“ vollständig aufgenommen: Definitionen 3.2.69 bis 3.2.75, Sätze 3.2.26 bis 3.2.32, Gleichungen 3.203 bis 3.245 sowie Wiederverwendung der Quelle [73] Conway. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 13),
(15, 'RKB-NEU-K3.2.13-ABSCHLUSS-V1', '2026-08-13 09:20:29', 'section', '3.2.13', '3.2.13-Abschluss-v1', 'Abschnitt 3.2.13 vollständig aufgenommen: Definitionen 3.2.76 bis 3.2.85, Sätze 3.2.33 bis 3.2.39, Gleichungen 3.246 bis 3.280 sowie Wiederverwendung der Quellen [72] Strang und [73] Conway. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 14),
(16, 'RKB-NEU-K3.2.14-ABSCHLUSS-V1', '2026-08-13 09:36:29', 'section', '3.2.14', '3.2.14-Abschluss-v1', 'Abschnitt 3.2.14 vollständig aufgenommen: Definitionen 3.2.86 bis 3.2.90, Sätze 3.2.40 bis 3.2.47, Gleichungen 3.281 bis 3.334 sowie Wiederverwendung der Quellen [72] Strang und [73] Conway. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 15),
(17, 'RKB-NEU-K3.2.16-ABSCHLUSS-V1', '2026-08-13 16:37:48', 'section', '3.2.16', '3.2.16-Abschluss-v1', 'Abschnitt 3.2.16 vollständig aufgenommen: Definitionen 3.2.99 bis 3.2.109, Sätze 3.2.55 bis 3.2.58, Gleichungen 3.383 bis 3.441, Wiederverwendung von [73] Conway sowie erstmalige Einführung von [76] Teschl und [77] Evans.', 'Olaf Thiele / ChatGPT', 16),
(18, 'RKB-NEU-K3.2.17-ABSCHLUSS-V1', '2026-08-13 18:52:03', 'section', '3.2.17', '3.2.17-Abschluss-v1', 'Abschnitt 3.2.17 vollständig aufgenommen: Definitionen 3.2.110 bis 3.2.120, Sätze 3.2.59 bis 3.2.65, Gleichungen 3.442 bis 3.510 sowie Wiederverwendung von [76] Teschl. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 17),
(19, 'RKB-NEU-K3.2.18-ABSCHLUSS-V1', '2026-08-13 20:59:11', 'section', '3.2.18', '3.2.18-Abschluss-v1', 'Abschnitt 3.2.18 vollständig aufgenommen: Definitionen 3.2.121 bis 3.2.130, Sätze 3.2.66 bis 3.2.72, Gleichungen 3.511 bis 3.580 sowie Wiederverwendung von [76] Teschl. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 18),
(20, 'RKB-NEU-K3.2.19-ABSCHLUSS-V1', '2026-08-13 21:09:35', 'section', '3.2.19', '3.2.19-Abschluss-v1', 'Abschnitt 3.2.19 vollständig aufgenommen: Definitionen 3.2.131 bis 3.2.140, Sätze 3.2.73 bis 3.2.76, Gleichungen 3.581 bis 3.630 sowie Wiederverwendung von [76] Teschl. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 19),
(21, 'RKB-NEU-K3.2.20-ABSCHLUSS-V1', '2026-08-14 16:12:43', 'section', '3.2.20', '3.2.20-Abschluss-v1', 'Abschnitt 3.2.20 vollständig aufgenommen: Definitionen 3.2.141 bis 3.2.151, Sätze 3.2.77 bis 3.2.83, Gleichungen 3.631 bis 3.685 sowie erstmalige Einführung von [78] John M. Lee.', 'Olaf Thiele / ChatGPT', 20),
(23, 'RKB-NEU-K3.2.21-ABSCHLUSS-V1', '2026-08-14 16:31:45', 'section', '3.2.21', '3.2.21-Abschluss-v1', 'Abschnitt 3.2.21 vollständig aufgenommen: Definitionen 3.2.152 bis 3.2.163, Sätze 3.2.84 bis 3.2.86, Gleichungen 3.686 bis 3.765 sowie erstmalige Einführung von [79] Barrett O\'Neill.', 'Olaf Thiele / ChatGPT', 21),
(24, 'RKB-NEU-K3.2.22-ABSCHLUSS-V1', '2026-08-14 18:42:08', 'section', '3.2.22', '3.2.22-Abschluss-v1', 'Abschnitt 3.2.22 vollständig aufgenommen: Definitionen 3.2.164 bis 3.2.172, Sätze 3.2.87 bis 3.2.92, Gleichungen 3.766 bis 3.845 sowie Wiederverwendung von [79] Barrett O\'Neill. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 23),
(25, 'RKB-NEU-K3.2.23-ABSCHLUSS-V1', '2026-08-14 19:16:11', 'section', '3.2.23', '3.2.23-Abschluss-v1', 'Abschnitt 3.2.23 vollständig aufgenommen: Definitionen 3.2.173 bis 3.2.184, Sätze 3.2.93 bis 3.2.99, Gleichungen 3.846 bis 3.925 sowie Wiederverwendung von [79] Barrett O\'Neill. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 24),
(26, 'RKB-NEU-K3.2.24-ABSCHLUSS-V1', '2026-08-14 20:01:40', 'section', '3.2.24', '3.2.24-Abschluss-v1', 'Abschnitt 3.2.24 vollständig aufgenommen: Definitionen 3.2.185 bis 3.2.198, Sätze 3.2.100 bis 3.2.104, Gleichungen 3.926 bis 3.995 sowie Wiederverwendung von [79] Barrett O\'Neill. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 25),
(27, 'RKB-NEU-K3.2.25-ABSCHLUSS-V1', '2026-08-14 20:19:25', 'section', '3.2.25', '3.2.25-Abschluss-v1', 'Abschnitt 3.2.25 vollständig aufgenommen: Definitionen 3.2.199 bis 3.2.208, Sätze 3.2.105 bis 3.2.111, Gleichungen 3.996 bis 3.1096 sowie Wiederverwendung von [77] Evans und [79] O\'Neill. Keine neue Literaturquelle.', 'Olaf Thiele / ChatGPT', 26);

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
(1, 2, 'K3_2_0_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.0 muss genau einmal vorhanden sein.', '2026-08-12 11:54:59'),
(2, 2, 'K3_2_0_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.0 muss den Status final besitzen.', '2026-08-12 11:54:59'),
(3, 2, 'K3_2_0_SOURCE_USAGE', 'passed', '5', '5', 'Abschnitt 3.2.0 verwendet genau die fünf vorhandenen Quellen [6], [59], [60], [67] und [68].', '2026-08-12 11:54:59'),
(4, 2, 'K3_2_0_NO_EQUATIONS', 'passed', '0', '0', 'Abschnitt 3.2.0 enthält keine nummerierten Gleichungen.', '2026-08-12 11:54:59'),
(5, 2, 'K3_2_0_NO_DEFINITIONS', 'passed', '0', '0', 'Abschnitt 3.2.0 enthält keine nummerierten Definitionen.', '2026-08-12 11:54:59'),
(6, 2, 'K3_2_0_CITATION_COUNTERS', 'passed', 'last=70; next=71', 'last=70; next=71', 'Da 3.2.0 keine neue Literatur einführt, müssen die Literaturzähler bei 70/71 bleiben.', '2026-08-12 11:54:59'),
(7, 3, 'K3_2_1_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.1 muss genau einmal vorhanden sein.', '2026-08-12 12:45:52'),
(8, 3, 'K3_2_1_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.1 muss den Status final besitzen.', '2026-08-12 12:45:52'),
(9, 3, 'K3_2_1_SOURCE_71', 'passed', '1', '1', 'Die neue Literaturquelle Enderton muss exakt als [71] vorhanden sein.', '2026-08-12 12:45:52'),
(10, 3, 'K3_2_1_SOURCE_USAGE', 'failed', '2', '1', 'Die Quellen [6] und [71] müssen jeweils genau einmal als Abschnittsverwendung dokumentiert sein.', '2026-08-12 12:45:52'),
(11, 3, 'K3_2_1_FIRST_MENTION_71', 'passed', '1', '1', 'Quelle [71] muss in Abschnitt 3.2.1 genau einmal als Erstnennung markiert sein.', '2026-08-12 12:45:52'),
(12, 3, 'K3_2_1_DEFINITIONS', 'passed', '5', '5', 'Die Definitionen 3.2.1 bis 3.2.5 müssen vollständig registriert sein.', '2026-08-12 12:45:52'),
(13, 3, 'K3_2_1_EQUATIONS', 'passed', '13', '13', 'Die Gleichungen 3.1 bis 3.13 müssen vollständig registriert sein.', '2026-08-12 12:45:52'),
(14, 3, 'K3_2_1_WORD_LATEX', 'passed', '13', '13', 'Jede nummerierte Gleichung des Abschnitts muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-12 12:45:52'),
(15, 3, 'K3_2_1_CITATION_COUNTERS', 'passed', 'last=71; next=72', 'last=71; next=72', 'Nach erstmaliger Einführung von [71] müssen die Literaturzähler auf 71/72 stehen.', '2026-08-12 12:45:52'),
(16, 4, 'K3_2_2_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.2 muss genau einmal vorhanden sein.', '2026-08-12 13:01:49'),
(17, 4, 'K3_2_2_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.2 muss den Status final besitzen.', '2026-08-12 13:01:49'),
(18, 4, 'K3_2_2_SOURCE_USAGE', 'failed', '2', '1', 'Die wiederverwendeten Quellen [6] und [71] müssen als Abschnittsverwendungen dokumentiert sein.', '2026-08-12 13:01:49'),
(19, 4, 'K3_2_2_NO_NEW_SOURCE', 'passed', 'last=71; next=72', 'last=71; next=72', '3.2.2 führt keine neue Literaturquelle ein.', '2026-08-12 13:01:49'),
(20, 4, 'K3_2_2_DEFINITIONS', 'passed', '7', '7', 'Die Definitionen 3.2.6 bis 3.2.12 müssen vollständig registriert sein.', '2026-08-12 13:01:50'),
(21, 4, 'K3_2_2_EQUATIONS', 'passed', '12', '12', 'Die Gleichungen 3.14 bis 3.25 müssen vollständig registriert sein.', '2026-08-12 13:01:50'),
(22, 4, 'K3_2_2_WORD_LATEX', 'passed', '12', '12', 'Jede nummerierte Gleichung des Abschnitts muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-12 13:01:50'),
(23, 5, 'K3_2_3_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.3 muss genau einmal vorhanden sein.', '2026-08-12 13:16:23'),
(24, 5, 'K3_2_3_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.3 muss den Status final besitzen.', '2026-08-12 13:16:23'),
(25, 5, 'K3_2_3_SOURCE_72', 'passed', '1', '1', 'Quelle [72] muss genau einmal mit dem Strang-source_key vorhanden sein.', '2026-08-12 13:16:23'),
(26, 5, 'K3_2_3_SOURCE_USAGE', 'passed', '1', '1', 'Quelle [72] muss in 3.2.3 genau einmal als Erstverwendung dokumentiert sein.', '2026-08-12 13:16:23'),
(27, 5, 'K3_2_3_DEFINITIONS', 'passed', '3', '3', 'Die Definitionen 3.2.13 bis 3.2.15 müssen vollständig registriert sein.', '2026-08-12 13:16:23'),
(28, 5, 'K3_2_3_EQUATIONS', 'passed', '7', '7', 'Die Gleichungen 3.26 bis 3.32 müssen vollständig registriert sein.', '2026-08-12 13:16:24'),
(29, 5, 'K3_2_3_WORD_LATEX', 'passed', '7', '7', 'Jede nummerierte Gleichung des Abschnitts muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-12 13:16:24'),
(30, 5, 'K3_2_3_CITATION_COUNTERS', 'passed', 'last=72; next=73', 'last=72; next=73', '3.2.3 führt genau die neue Literaturquelle [72] ein.', '2026-08-12 13:16:24'),
(31, 6, 'K3_2_4_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.4 muss genau einmal vorhanden sein.', '2026-08-12 14:21:38'),
(32, 6, 'K3_2_4_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.4 muss den Status final besitzen.', '2026-08-12 14:21:38'),
(33, 6, 'K3_2_4_SOURCE_72', 'passed', '1', '1', 'Die bereits in 3.2.3 eingeführte Quelle [72] muss im Repository vorhanden sein.', '2026-08-12 14:21:38'),
(34, 6, 'K3_2_4_SOURCE_USAGE', 'passed', '1', '1', 'Quelle [72] muss einmal als Abschnittsverwendung für 3.2.4 dokumentiert sein.', '2026-08-12 14:21:38'),
(35, 6, 'K3_2_4_DEFINITIONS', 'passed', '4', '4', 'Die Definitionen 3.2.16 bis 3.2.19 müssen vollständig registriert sein.', '2026-08-12 14:21:38'),
(36, 6, 'K3_2_4_EQUATIONS', 'passed', '12', '12', 'Die Gleichungen 3.33 bis 3.44 müssen vollständig registriert sein.', '2026-08-12 14:21:38'),
(37, 6, 'K3_2_4_WORD_LATEX', 'passed', '12', '12', 'Jede nummerierte Gleichung von 3.2.4 muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-12 14:21:38'),
(38, 6, 'K3_2_4_CITATION_COUNTERS', 'passed', 'last=72; next=73', 'last=72; next=73', '3.2.4 führt keine neue Literaturquelle ein; die Zähler müssen daher bei 72/73 bleiben.', '2026-08-12 14:21:38'),
(39, 7, 'K3_2_5_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.5 muss genau einmal vorhanden sein.', '2026-08-12 14:44:57'),
(40, 7, 'K3_2_5_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.5 muss den Status final besitzen.', '2026-08-12 14:44:57'),
(41, 7, 'K3_2_5_SOURCE_72', 'passed', '1', '1', 'Die bereits in 3.2.3 eingeführte Quelle [72] muss im Repository vorhanden sein.', '2026-08-12 14:44:57'),
(42, 7, 'K3_2_5_SOURCE_USAGE', 'passed', '1', '1', 'Quelle [72] muss einmal als Abschnittsverwendung für 3.2.5 dokumentiert sein.', '2026-08-12 14:44:57'),
(43, 7, 'K3_2_5_DEFINITIONS', 'passed', '3', '3', 'Die Definitionen 3.2.20 bis 3.2.22 müssen vollständig registriert sein.', '2026-08-12 14:44:57'),
(44, 7, 'K3_2_5_THEOREM', 'passed', '1', '1', 'Satz 3.2.1 muss genau einmal in 3.2.5 registriert sein.', '2026-08-12 14:44:57'),
(45, 7, 'K3_2_5_EQUATIONS', 'passed', '13', '13', 'Die Gleichungen 3.45 bis 3.57 müssen vollständig registriert sein.', '2026-08-12 14:44:57'),
(46, 7, 'K3_2_5_WORD_LATEX', 'passed', '13', '13', 'Jede nummerierte Gleichung von 3.2.5 muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-12 14:44:57'),
(47, 7, 'K3_2_5_THEOREM_WORD_LATEX', 'passed', '1', '1', 'Satz 3.2.1 muss eine nichtleere formale und Word-LaTeX-Darstellung besitzen.', '2026-08-12 14:44:57'),
(48, 7, 'K3_2_5_CITATION_COUNTERS', 'passed', 'last=72; next=73', 'last=72; next=73', '3.2.5 führt keine neue Literaturquelle ein; die Literaturzähler müssen daher bei 72/73 bleiben.', '2026-08-12 14:44:57'),
(49, 8, 'K3_2_6_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.6 muss genau einmal vorhanden sein.', '2026-08-12 15:41:29'),
(50, 8, 'K3_2_6_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.6 muss den Status final besitzen.', '2026-08-12 15:41:29'),
(51, 8, 'K3_2_6_SOURCE_72', 'passed', '1', '1', 'Quelle [72] muss mit dem festgelegten source_key vorhanden sein.', '2026-08-12 15:41:29'),
(52, 8, 'K3_2_6_SOURCE_USAGE', 'passed', '1', '1', 'Quelle [72] muss einmal als Abschnittsverwendung für 3.2.6 dokumentiert sein.', '2026-08-12 15:41:29'),
(53, 8, 'K3_2_6_DEFINITIONS', 'passed', '5', '5', 'Die Definitionen 3.2.23 bis 3.2.27 müssen vollständig registriert sein.', '2026-08-12 15:41:29'),
(54, 8, 'K3_2_6_THEOREMS', 'passed', '2', '2', 'Die Sätze 3.2.2 bis 3.2.3 müssen vollständig registriert sein.', '2026-08-12 15:41:29'),
(55, 8, 'K3_2_6_THEOREM_WORD_LATEX', 'passed', '2', '2', 'Beide Sätze des Abschnitts müssen eine formale und eine Word-LaTeX-Darstellung besitzen.', '2026-08-12 15:41:29'),
(56, 8, 'K3_2_6_EQUATIONS', 'passed', '23', '23', 'Die Gleichungen 3.58 bis 3.80 müssen vollständig registriert sein.', '2026-08-12 15:41:30'),
(57, 8, 'K3_2_6_WORD_LATEX', 'passed', '23', '23', 'Jede nummerierte Gleichung von 3.2.6 muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-12 15:41:30'),
(58, 8, 'K3_2_6_CITATION_COUNTERS', 'passed', 'last=72; next=73', 'last=72; next=73', '3.2.6 führt keine neue Literaturquelle ein; die Literaturzähler müssen bei 72/73 bleiben.', '2026-08-12 15:41:30'),
(59, 9, 'K3_2_7_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.7 muss genau einmal vorhanden sein.', '2026-08-13 00:59:20'),
(60, 9, 'K3_2_7_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.7 muss den Status final besitzen.', '2026-08-13 00:59:20'),
(61, 9, 'K3_2_7_SOURCE_73', 'passed', '1', '1', 'Die neue Quelle [73] Conway muss genau einmal mit dem festgelegten source_key vorhanden sein.', '2026-08-13 00:59:20'),
(62, 9, 'K3_2_7_SOURCE_USAGE_73', 'passed', '1', '1', 'Quelle [73] muss genau einmal als Erstnennung in 3.2.7 dokumentiert sein.', '2026-08-13 00:59:20'),
(63, 9, 'K3_2_7_SOURCE_USAGE_72', 'passed', '1 if source [72] exists', '1', 'Quelle [72] wird ergänzend verwendet. Fehlt sie im Ausführungsstand, wird dies nur als Warnung dokumentiert und nicht als künstliches Abbruch-Gate behandelt.', '2026-08-13 00:59:20'),
(64, 9, 'K3_2_7_DEFINITIONS', 'passed', '7', '7', 'Die Definitionen 3.2.28 bis 3.2.34 müssen vollständig registriert sein.', '2026-08-13 00:59:20'),
(65, 9, 'K3_2_7_THEOREMS', 'passed', '3', '3', 'Die Sätze 3.2.4 bis 3.2.6 müssen vollständig registriert sein.', '2026-08-13 00:59:20'),
(66, 9, 'K3_2_7_THEOREM_WORD_LATEX', 'passed', '3', '3', 'Alle drei Sätze von 3.2.7 müssen eine formale und eine Word-LaTeX-Darstellung besitzen.', '2026-08-13 00:59:20'),
(67, 9, 'K3_2_7_EQUATIONS', 'passed', '17', '17', 'Die Gleichungen 3.81 bis 3.97 müssen vollständig registriert sein.', '2026-08-13 00:59:20'),
(68, 9, 'K3_2_7_WORD_LATEX', 'passed', '17', '17', 'Jede nummerierte Gleichung von 3.2.7 muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-13 00:59:20'),
(69, 9, 'K3_2_7_CITATION_COUNTERS', 'passed', 'last=73; next=74', 'last=73; next=74', '3.2.7 führt Quelle [73] neu ein; die Literaturzähler müssen danach 73/74 betragen.', '2026-08-13 00:59:20'),
(70, 10, 'K3_2_8_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.8 muss genau einmal vorhanden sein.', '2026-08-13 01:33:34'),
(71, 10, 'K3_2_8_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.8 muss den Status final besitzen.', '2026-08-13 01:33:34'),
(72, 10, 'K3_2_8_SOURCE_74', 'passed', '1', '1', 'Quelle [74] Munkres muss genau einmal mit dem vorgesehenen source_key vorhanden sein.', '2026-08-13 01:33:34'),
(73, 10, 'K3_2_8_SOURCE_USAGE_74', 'passed', '1', '1', 'Quelle [74] muss genau einmal als Erstnennung in Abschnitt 3.2.8 dokumentiert sein.', '2026-08-13 01:33:34'),
(74, 10, 'K3_2_8_DEFINITIONS', 'passed', '9', '9', 'Die Definitionen 3.2.35 bis 3.2.43 müssen vollständig registriert sein.', '2026-08-13 01:33:34'),
(75, 10, 'K3_2_8_THEOREM', 'passed', '1', '1', 'Satz 3.2.7 muss genau einmal in Abschnitt 3.2.8 registriert sein.', '2026-08-13 01:33:34'),
(76, 10, 'K3_2_8_THEOREM_WORD_LATEX', 'passed', '1', '1', 'Satz 3.2.7 muss eine formale und eine Word-LaTeX-Darstellung besitzen.', '2026-08-13 01:33:34'),
(77, 10, 'K3_2_8_EQUATIONS', 'passed', '22', '22', 'Die Gleichungen 3.98 bis 3.119 müssen vollständig registriert sein.', '2026-08-13 01:33:34'),
(78, 10, 'K3_2_8_WORD_LATEX', 'passed', '22', '22', 'Jede nummerierte Gleichung von 3.2.8 muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-13 01:33:34'),
(79, 10, 'K3_2_8_CITATION_COUNTERS', 'passed', 'last=74; next=75', 'last=74; next=75', 'Nach erfolgreicher Anlage der neuen Quelle [74] müssen die Literaturzähler 74/75 betragen. Bei einem Zitationskonflikt werden die Zähler nicht künstlich überschrieben.', '2026-08-13 01:33:34'),
(80, 11, 'K3_2_9_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.9 muss genau einmal vorhanden sein.', '2026-08-13 04:09:20'),
(81, 11, 'K3_2_9_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.9 muss den Status final besitzen.', '2026-08-13 04:09:20'),
(82, 11, 'K3_2_9_SOURCE_74', 'passed', '1', '1', 'Quelle [74] Munkres sollte aus Abschnitt 3.2.8 vorhanden sein. Ein fehlender Vorgängereintrag wird dokumentiert, aber nicht als künstliches Ausführungs-Gate verwendet.', '2026-08-13 04:09:20'),
(83, 11, 'K3_2_9_SOURCE_USAGE_74', 'passed', '1 if source [74] exists', '1', 'Quelle [74] soll einmal als Abschnittsverwendung für 3.2.9 dokumentiert sein.', '2026-08-13 04:09:20'),
(84, 11, 'K3_2_9_DEFINITIONS', 'passed', '9', '9', 'Die Definitionen 3.2.44 bis 3.2.52 müssen vollständig registriert sein.', '2026-08-13 04:09:20'),
(85, 11, 'K3_2_9_THEOREMS', 'passed', '5', '5', 'Die Sätze 3.2.8 bis 3.2.12 müssen vollständig registriert sein.', '2026-08-13 04:09:20'),
(86, 11, 'K3_2_9_THEOREM_WORD_LATEX', 'passed', '5', '5', 'Alle fünf Sätze von 3.2.9 müssen eine formale und eine Word-LaTeX-Darstellung besitzen.', '2026-08-13 04:09:20'),
(87, 11, 'K3_2_9_EQUATIONS', 'passed', '20', '20', 'Die Gleichungen 3.120 bis 3.139 müssen vollständig registriert sein.', '2026-08-13 04:09:20'),
(88, 11, 'K3_2_9_WORD_LATEX', 'passed', '20', '20', 'Jede nummerierte Gleichung von 3.2.9 muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-13 04:09:20'),
(89, 11, 'K3_2_9_CITATION_COUNTERS', 'passed', 'last=74; next=75', 'last=74; next=75', '3.2.9 führt keine neue Literaturquelle ein. Bei vorhandenem [74] müssen die Literaturzähler daher bei 74/75 bleiben.', '2026-08-13 04:09:20'),
(90, 12, 'K3_2_10_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.10 muss genau einmal vorhanden sein.', '2026-08-13 04:23:37'),
(91, 12, 'K3_2_10_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.10 muss den Status final besitzen.', '2026-08-13 04:23:37'),
(92, 12, 'K3_2_10_SOURCES_73_74', 'passed', '2', '2', 'Die bereits eingeführten Quellen [73] Conway und [74] Munkres sollten im Ausführungsstand vorhanden sein. Ein Fehlen wird dokumentiert, aber nicht als künstliches SQL-Abbruch-Gate verwendet.', '2026-08-13 04:23:37'),
(93, 12, 'K3_2_10_SOURCE_USAGE', 'passed', '2 if sources [73] and [74] exist', '2', 'Für 3.2.10 sollen genau zwei Abschnittsverwendungen der Quellen [73] und [74] dokumentiert sein.', '2026-08-13 04:23:37'),
(94, 12, 'K3_2_10_DEFINITIONS', 'passed', '7', '7', 'Die Definitionen 3.2.53 bis 3.2.59 müssen vollständig registriert sein.', '2026-08-13 04:23:37'),
(95, 12, 'K3_2_10_THEOREMS', 'passed', '6', '6', 'Die Sätze 3.2.13 bis 3.2.18 müssen vollständig registriert sein.', '2026-08-13 04:23:37'),
(96, 12, 'K3_2_10_THEOREM_WORD_LATEX', 'passed', '6', '6', 'Alle sechs Sätze von 3.2.10 müssen eine formale und eine Word-LaTeX-Darstellung besitzen.', '2026-08-13 04:23:37'),
(97, 12, 'K3_2_10_EQUATIONS', 'passed', '27', '27', 'Die Gleichungen 3.140 bis 3.166 müssen vollständig registriert sein.', '2026-08-13 04:23:37'),
(98, 12, 'K3_2_10_WORD_LATEX', 'passed', '27', '27', 'Jede nummerierte Gleichung von 3.2.10 muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-13 04:23:37'),
(99, 12, 'K3_2_10_CITATION_COUNTERS', 'passed', 'last=74; next=75', 'last=74; next=75', '3.2.10 führt keine neue Literaturquelle ein; bei vorhandenem [73] und [74] müssen die Literaturzähler bei 74/75 bleiben.', '2026-08-13 04:23:37'),
(100, 13, 'K3_2_11_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.11 muss genau einmal vorhanden sein.', '2026-08-13 04:37:15'),
(101, 13, 'K3_2_11_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.11 muss den Status final besitzen.', '2026-08-13 04:37:15'),
(102, 13, 'K3_2_11_SOURCES_73_74', 'passed', '2', '2', 'Die bereits eingeführten Quellen [73] Conway und [74] Munkres sollten im Ausführungsstand vorhanden sein. Ein Fehlen wird dokumentiert, aber nicht als künstliches SQL-Abbruch-Gate verwendet.', '2026-08-13 04:37:15'),
(103, 13, 'K3_2_11_SOURCE_USAGE', 'passed', '2 if sources [73] and [74] exist', '2', 'Für 3.2.11 sollen genau zwei Abschnittsverwendungen der Quellen [73] und [74] dokumentiert sein.', '2026-08-13 04:37:15'),
(104, 13, 'K3_2_11_DEFINITIONS', 'passed', '9', '9', 'Die Definitionen 3.2.60 bis 3.2.68 müssen vollständig registriert sein.', '2026-08-13 04:37:15'),
(105, 13, 'K3_2_11_THEOREMS', 'passed', '7', '7', 'Die Sätze 3.2.19 bis 3.2.25 müssen vollständig registriert sein.', '2026-08-13 04:37:15'),
(106, 13, 'K3_2_11_THEOREM_WORD_LATEX', 'passed', '7', '7', 'Alle sieben Sätze von 3.2.11 müssen eine formale und eine Word-LaTeX-Darstellung besitzen.', '2026-08-13 04:37:15'),
(107, 13, 'K3_2_11_EQUATIONS', 'passed', '36', '36', 'Die Gleichungen 3.167 bis 3.202 müssen vollständig registriert sein.', '2026-08-13 04:37:15'),
(108, 13, 'K3_2_11_WORD_LATEX', 'passed', '36', '36', 'Jede nummerierte Gleichung von 3.2.11 muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-13 04:37:15'),
(109, 13, 'K3_2_11_CITATION_COUNTERS', 'passed', 'last=74; next=75', 'last=74; next=75', '3.2.11 führt keine neue Literaturquelle ein; bei vorhandenem [73] und [74] müssen die Literaturzähler bei 74/75 bleiben.', '2026-08-13 04:37:15'),
(110, 14, 'K3_2_12_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.12 muss genau einmal vorhanden sein.', '2026-08-13 04:51:15'),
(111, 14, 'K3_2_12_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.12 muss den Status final besitzen.', '2026-08-13 04:51:15'),
(112, 14, 'K3_2_12_SOURCE_73', 'passed', '1', '1', 'Die bereits eingeführte Quelle [73] Conway sollte im Ausführungsstand vorhanden sein. Ein Fehlen wird dokumentiert, aber nicht als künstliches SQL-Abbruch-Gate verwendet.', '2026-08-13 04:51:15'),
(113, 14, 'K3_2_12_SOURCE_USAGE_73', 'passed', '1 if source [73] exists', '1', 'Quelle [73] soll genau einmal als Abschnittsverwendung für 3.2.12 dokumentiert sein.', '2026-08-13 04:51:15'),
(114, 14, 'K3_2_12_DEFINITIONS', 'passed', '7', '7', 'Die Definitionen 3.2.69 bis 3.2.75 müssen vollständig registriert sein.', '2026-08-13 04:51:15'),
(115, 14, 'K3_2_12_THEOREMS', 'passed', '7', '7', 'Die Sätze 3.2.26 bis 3.2.32 müssen vollständig registriert sein.', '2026-08-13 04:51:15'),
(116, 14, 'K3_2_12_THEOREM_WORD_LATEX', 'passed', '7', '7', 'Alle sieben Sätze von 3.2.12 müssen eine formale und eine Word-LaTeX-Darstellung besitzen.', '2026-08-13 04:51:15'),
(117, 14, 'K3_2_12_EQUATIONS', 'passed', '43', '43', 'Die Gleichungen 3.203 bis 3.245 müssen vollständig registriert sein.', '2026-08-13 04:51:15'),
(118, 14, 'K3_2_12_WORD_LATEX', 'passed', '43', '43', 'Jede nummerierte Gleichung von 3.2.12 muss eine nichtleere Word-LaTeX-Entsprechung besitzen.', '2026-08-13 04:51:15'),
(119, 14, 'K3_2_12_CITATION_COUNTERS', 'passed', 'last=74; next=75', 'last=74; next=75', '3.2.12 führt keine neue Literaturquelle ein und verändert die Literaturzähler bewusst nicht. Im erwarteten sequenziellen Stand bleiben sie bei 74/75.', '2026-08-13 04:51:15'),
(120, 15, 'K3_2_13_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.13 muss genau einmal vorhanden sein.', '2026-08-13 07:20:29'),
(121, 15, 'K3_2_13_SOURCES_72_73', 'passed', '2', '2', 'Die bereits eingeführten Quellen [72] und [73] sollten vorhanden sein; fehlende Vorgängerquellen erzeugen nur eine Warnung.', '2026-08-13 07:20:29'),
(122, 15, 'K3_2_13_SOURCE_USAGE', 'passed', '2 if sources exist', '2', 'Für 3.2.13 sollen zwei Quellenverwendungen für [72] und [73] dokumentiert sein.', '2026-08-13 07:20:29'),
(123, 15, 'K3_2_13_DEFINITIONS', 'passed', '10', '10', 'Definitionen 3.2.76 bis 3.2.85 müssen vollständig registriert sein.', '2026-08-13 07:20:29'),
(124, 15, 'K3_2_13_THEOREMS', 'passed', '7', '7', 'Sätze 3.2.33 bis 3.2.39 müssen vollständig registriert sein.', '2026-08-13 07:20:29'),
(125, 15, 'K3_2_13_EQUATIONS', 'passed', '35', '35', 'Gleichungen 3.246 bis 3.280 müssen vollständig registriert sein.', '2026-08-13 07:20:29'),
(126, 15, 'K3_2_13_WORD_LATEX', 'passed', '35', '35', 'Alle nummerierten Gleichungen von 3.2.13 müssen Word-LaTeX enthalten.', '2026-08-13 07:20:29'),
(127, 15, 'K3_2_13_CITATION_COUNTERS', 'passed', 'last=74; next=75', 'last=74; next=75', '3.2.13 führt keine neue Literaturquelle ein und verändert die Literaturzähler bewusst nicht.', '2026-08-13 07:20:30'),
(128, 16, 'K3_2_14_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.14 muss genau einmal vorhanden sein.', '2026-08-13 07:36:30'),
(129, 16, 'K3_2_14_SOURCES_72_73', 'passed', '2', '2', 'Die bereits eingeführten Quellen [72] und [73] sollten vorhanden sein; fehlende Vorgängerquellen führen nur zu einer Warnung.', '2026-08-13 07:36:30'),
(130, 16, 'K3_2_14_SOURCE_USAGE', 'passed', '2 if sources exist', '2', 'Für 3.2.14 sollen zwei Quellenverwendungen für [72] und [73] dokumentiert sein.', '2026-08-13 07:36:30'),
(131, 16, 'K3_2_14_DEFINITIONS', 'passed', '5', '5', 'Definitionen 3.2.86 bis 3.2.90 müssen vollständig registriert sein.', '2026-08-13 07:36:30'),
(132, 16, 'K3_2_14_THEOREMS', 'passed', '8', '8', 'Sätze 3.2.40 bis 3.2.47 müssen vollständig registriert sein.', '2026-08-13 07:36:30'),
(133, 16, 'K3_2_14_EQUATIONS', 'passed', '54', '54', 'Gleichungen 3.281 bis 3.334 müssen vollständig registriert sein.', '2026-08-13 07:36:30'),
(134, 16, 'K3_2_14_WORD_LATEX', 'passed', '54', '54', 'Alle Gleichungen 3.281 bis 3.334 müssen Word-LaTeX enthalten.', '2026-08-13 07:36:30'),
(135, 16, 'K3_2_14_CITATION_COUNTERS', 'passed', 'last=74; next=75', 'last=74; next=75', '3.2.14 führt keine neue Literaturquelle ein und verändert die Literaturzähler bewusst nicht.', '2026-08-13 07:36:30'),
(136, 17, 'K3_2_16_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.16 muss genau einmal vorhanden sein.', '2026-08-13 14:37:48'),
(137, 17, 'K3_2_16_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.16 muss den Status final besitzen.', '2026-08-13 14:37:48'),
(138, 17, 'K3_2_16_SOURCE_76', 'passed', '1', '1', 'Quelle [76] Teschl muss mit der vorgesehenen Literaturzahl und dem vorgesehenen source_key vorhanden sein.', '2026-08-13 14:37:48'),
(139, 17, 'K3_2_16_SOURCE_77', 'passed', '1', '1', 'Quelle [77] Evans muss mit der vorgesehenen Literaturzahl und dem vorgesehenen source_key vorhanden sein.', '2026-08-13 14:37:48'),
(140, 17, 'K3_2_16_AUTHORS_76_77', 'passed', '2', '2', 'Gerald Teschl und Lawrence C. Evans müssen als Autoren registriert sein.', '2026-08-13 14:37:48'),
(141, 17, 'K3_2_16_SOURCE_USAGE', 'passed', '3 if [73], [76], [77] exist', '3', 'Für 3.2.16 sollen [76] und [77] als Erstnennungen sowie [73] als Wiederverwendung dokumentiert sein.', '2026-08-13 14:37:48'),
(142, 17, 'K3_2_16_DEFINITIONS', 'passed', '11', '11', 'Definitionen 3.2.99 bis 3.2.109 müssen vollständig registriert sein.', '2026-08-13 14:37:48'),
(143, 17, 'K3_2_16_THEOREMS', 'passed', '4', '4', 'Sätze 3.2.55 bis 3.2.58 müssen vollständig registriert sein.', '2026-08-13 14:37:48'),
(144, 17, 'K3_2_16_EQUATIONS', 'passed', '59', '59', 'Gleichungen 3.383 bis 3.441 müssen vollständig registriert sein.', '2026-08-13 14:37:48'),
(145, 17, 'K3_2_16_WORD_LATEX', 'passed', '59', '59', 'Alle Gleichungen 3.383 bis 3.441 müssen eine nichtleere Word-LaTeX-Darstellung besitzen.', '2026-08-13 14:37:48'),
(146, 17, 'K3_2_16_CITATION_COUNTERS', 'passed', 'last=77; next=78', 'last=77; next=78', 'Mit den neuen Quellen [76] und [77] müssen die Literaturzähler auf last=77 und next=78 fortgeschrieben werden.', '2026-08-13 14:37:48'),
(147, 18, 'K3_2_17_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.17 muss genau einmal vorhanden sein.', '2026-08-13 16:52:03'),
(148, 18, 'K3_2_17_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.17 muss den Status final besitzen.', '2026-08-13 16:52:03'),
(149, 18, 'K3_2_17_SOURCE_76', 'passed', '1', '1', 'Die bereits in 3.2.16 eingeführte Quelle [76] Teschl sollte mit dem verbindlichen source_key vorhanden sein.', '2026-08-13 16:52:03'),
(150, 18, 'K3_2_17_SOURCE_USAGE', 'passed', '1 if [76] exists', '1', 'Für 3.2.17 soll genau eine Wiederverwendung der Quelle [76] dokumentiert sein.', '2026-08-13 16:52:03'),
(151, 18, 'K3_2_17_DEFINITIONS', 'passed', '11', '11', 'Definitionen 3.2.110 bis 3.2.120 müssen vollständig registriert sein.', '2026-08-13 16:52:03'),
(152, 18, 'K3_2_17_THEOREMS', 'passed', '7', '7', 'Sätze 3.2.59 bis 3.2.65 müssen vollständig registriert sein.', '2026-08-13 16:52:03'),
(153, 18, 'K3_2_17_EQUATIONS', 'passed', '69', '69', 'Gleichungen 3.442 bis 3.510 müssen vollständig registriert sein.', '2026-08-13 16:52:03'),
(154, 18, 'K3_2_17_WORD_LATEX', 'passed', '69', '69', 'Alle Gleichungen 3.442 bis 3.510 müssen eine nichtleere Word-LaTeX-Darstellung besitzen.', '2026-08-13 16:52:03'),
(155, 18, 'K3_2_17_CITATION_COUNTERS', 'passed', 'last=77; next=78', 'last=77; next=78', '3.2.17 führt keine neue Literaturquelle ein und verändert die Literaturzähler bewusst nicht.', '2026-08-13 16:52:03'),
(156, 19, 'K3_2_18_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.18 muss genau einmal vorhanden sein.', '2026-08-13 18:59:12'),
(157, 19, 'K3_2_18_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.18 muss den Status final besitzen.', '2026-08-13 18:59:12'),
(158, 19, 'K3_2_18_SOURCE_76', 'passed', '1', '1', 'Die bereits eingeführte Quelle [76] Teschl sollte mit dem verbindlichen source_key vorhanden sein.', '2026-08-13 18:59:12'),
(159, 19, 'K3_2_18_SOURCE_USAGE', 'passed', '1 if [76] exists', '1', 'Für 3.2.18 soll genau eine Wiederverwendung der Quelle [76] dokumentiert sein.', '2026-08-13 18:59:12'),
(160, 19, 'K3_2_18_DEFINITIONS', 'passed', '10', '10', 'Definitionen 3.2.121 bis 3.2.130 müssen vollständig registriert sein.', '2026-08-13 18:59:12'),
(161, 19, 'K3_2_18_THEOREMS', 'passed', '7', '7', 'Sätze 3.2.66 bis 3.2.72 müssen vollständig registriert sein.', '2026-08-13 18:59:12'),
(162, 19, 'K3_2_18_EQUATIONS', 'passed', '70', '70', 'Gleichungen 3.511 bis 3.580 müssen vollständig registriert sein.', '2026-08-13 18:59:12'),
(163, 19, 'K3_2_18_WORD_LATEX', 'passed', '70', '70', 'Alle Gleichungen 3.511 bis 3.580 müssen eine nichtleere Word-LaTeX-Darstellung besitzen.', '2026-08-13 18:59:12'),
(164, 19, 'K3_2_18_EQ_3547_CORRECTED', 'failed', '1', '0', 'Gleichung 3.547 muss die mögliche Nichtidentität verschiedener Lyapunov-Funktionen formal eindeutig ausdrücken.', '2026-08-13 18:59:12'),
(165, 19, 'K3_2_18_CITATION_COUNTERS', 'passed', 'last=77; next=78', 'last=77; next=78', '3.2.18 führt keine neue Literaturquelle ein und verändert die Literaturzähler bewusst nicht.', '2026-08-13 18:59:12'),
(166, 20, 'K3_2_19_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.19 muss genau einmal vorhanden sein.', '2026-08-13 19:09:35'),
(167, 20, 'K3_2_19_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.19 muss den Status final besitzen.', '2026-08-13 19:09:35'),
(168, 20, 'K3_2_19_SOURCE_76', 'passed', '1', '1', 'Die bereits eingeführte Quelle [76] Teschl sollte mit dem verbindlichen source_key vorhanden sein.', '2026-08-13 19:09:35'),
(169, 20, 'K3_2_19_SOURCE_USAGE', 'passed', '1 if [76] exists', '1', 'Für 3.2.19 soll genau eine Wiederverwendung der Quelle [76] dokumentiert sein.', '2026-08-13 19:09:36'),
(170, 20, 'K3_2_19_DEFINITIONS', 'passed', '10', '10', 'Definitionen 3.2.131 bis 3.2.140 müssen vollständig registriert sein.', '2026-08-13 19:09:36'),
(171, 20, 'K3_2_19_THEOREMS', 'passed', '4', '4', 'Sätze 3.2.73 bis 3.2.76 müssen vollständig registriert sein.', '2026-08-13 19:09:36'),
(172, 20, 'K3_2_19_EQUATIONS', 'passed', '50', '50', 'Gleichungen 3.581 bis 3.630 müssen vollständig registriert sein.', '2026-08-13 19:09:36'),
(173, 20, 'K3_2_19_WORD_LATEX', 'passed', '50', '50', 'Alle Gleichungen 3.581 bis 3.630 müssen eine nichtleere Word-LaTeX-Darstellung besitzen.', '2026-08-13 19:09:36'),
(174, 20, 'K3_2_19_FORMAL_CORRECTIONS', 'failed', '2', '0', 'Die formalen Repository-Bereinigungen der Gleichungen 3.589 und 3.623 müssen vorhanden sein.', '2026-08-13 19:09:36'),
(175, 20, 'K3_2_19_CITATION_COUNTERS', 'passed', 'last=77; next=78', 'last=77; next=78', '3.2.19 führt keine neue Literaturquelle ein und verändert die Literaturzähler bewusst nicht.', '2026-08-13 19:09:36'),
(176, 21, 'K3_2_20_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.20 muss genau einmal vorhanden sein.', '2026-08-14 14:12:44'),
(177, 21, 'K3_2_20_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.20 muss den Status final besitzen.', '2026-08-14 14:12:44'),
(178, 21, 'K3_2_20_SOURCE_78', 'passed', '1', '1', 'Quelle [78] John M. Lee muss mit der vorgesehenen Literaturzahl und dem vorgesehenen source_key vorhanden sein.', '2026-08-14 14:12:44'),
(179, 21, 'K3_2_20_AUTHOR_LEE', 'passed', '1', '1', 'John M. Lee muss als Autor registriert sein.', '2026-08-14 14:12:44'),
(180, 21, 'K3_2_20_SOURCE_USAGE', 'passed', '1', '1', 'Für 3.2.20 muss die Erstnennung der Quelle [78] genau einmal mit verifizierter Fundstelle dokumentiert sein.', '2026-08-14 14:12:44'),
(181, 21, 'K3_2_20_DEFINITIONS', 'passed', '11', '11', 'Definitionen 3.2.141 bis 3.2.151 müssen vollständig registriert sein.', '2026-08-14 14:12:44'),
(182, 21, 'K3_2_20_THEOREMS', 'passed', '7', '7', 'Sätze 3.2.77 bis 3.2.83 müssen vollständig registriert sein.', '2026-08-14 14:12:44'),
(183, 21, 'K3_2_20_EQUATIONS', 'passed', '55', '55', 'Gleichungen 3.631 bis 3.685 müssen vollständig registriert sein.', '2026-08-14 14:12:44'),
(184, 21, 'K3_2_20_WORD_LATEX', 'passed', '55', '55', 'Alle Gleichungen 3.631 bis 3.685 müssen eine nichtleere Word-LaTeX-Darstellung besitzen.', '2026-08-14 14:12:44'),
(185, 21, 'K3_2_20_CITATION_COUNTERS', 'passed', 'last=78; next=79', 'last=78; next=79', 'Mit der neuen Quelle [78] müssen die Literaturzähler auf last=78 und next=79 fortgeschrieben werden.', '2026-08-14 14:12:44'),
(196, 23, 'K3_2_21_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.21 muss genau einmal vorhanden sein.', '2026-08-14 14:31:45'),
(197, 23, 'K3_2_21_SOURCE_79', 'passed', '1', '1', 'Quelle [79] O\'Neill muss mit der vorgesehenen Literaturzahl und dem vorgesehenen source_key vorhanden sein.', '2026-08-14 14:31:45'),
(198, 23, 'K3_2_21_SOURCE_USAGE', 'passed', '1', '1', 'Für 3.2.21 muss die Erstnennung der Quelle [79] genau einmal mit verifizierter Fundstelle dokumentiert sein.', '2026-08-14 14:31:45'),
(199, 23, 'K3_2_21_DEFINITIONS', 'passed', '12', '12', 'Definitionen 3.2.152 bis 3.2.163 müssen vollständig registriert sein.', '2026-08-14 14:31:45'),
(200, 23, 'K3_2_21_THEOREMS', 'passed', '3', '3', 'Sätze 3.2.84 bis 3.2.86 müssen vollständig registriert sein.', '2026-08-14 14:31:45'),
(201, 23, 'K3_2_21_EQUATIONS', 'passed', '80', '80', 'Gleichungen 3.686 bis 3.765 müssen vollständig registriert sein.', '2026-08-14 14:31:45'),
(202, 23, 'K3_2_21_WORD_LATEX', 'passed', '80', '80', 'Alle Gleichungen 3.686 bis 3.765 müssen eine nichtleere Word-LaTeX-Darstellung besitzen.', '2026-08-14 14:31:45'),
(203, 23, 'K3_2_21_FORMAL_CORRECTIONS', 'failed', '2', '1', 'Die formalen Präzisierungen der Gleichungen 3.696 und 3.758 müssen vorhanden sein.', '2026-08-14 14:31:45'),
(204, 23, 'K3_2_21_CITATION_COUNTERS', 'passed', 'last=79; next=80', 'last=79; next=80', 'Mit der neuen Quelle [79] müssen die Literaturzähler auf last=79 und next=80 fortgeschrieben werden.', '2026-08-14 14:31:45'),
(205, 24, 'K3_2_22_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.22 muss genau einmal vorhanden sein.', '2026-08-14 16:42:09'),
(206, 24, 'K3_2_22_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.22 muss den Status final besitzen.', '2026-08-14 16:42:09'),
(207, 24, 'K3_2_22_SOURCE_79', 'passed', '1', '1', 'Die bereits in 3.2.21 eingeführte Quelle [79] O\'Neill sollte mit dem verbindlichen source_key vorhanden sein.', '2026-08-14 16:42:09'),
(208, 24, 'K3_2_22_SOURCE_USAGE', 'passed', '1 if [79] exists', '1', 'Für 3.2.22 soll genau eine Wiederverwendung der Quelle [79] dokumentiert sein.', '2026-08-14 16:42:09'),
(209, 24, 'K3_2_22_DEFINITIONS', 'passed', '9', '9', 'Definitionen 3.2.164 bis 3.2.172 müssen vollständig registriert sein.', '2026-08-14 16:42:09'),
(210, 24, 'K3_2_22_THEOREMS', 'passed', '6', '6', 'Sätze 3.2.87 bis 3.2.92 müssen vollständig registriert sein.', '2026-08-14 16:42:09'),
(211, 24, 'K3_2_22_EQUATIONS', 'passed', '80', '80', 'Gleichungen 3.766 bis 3.845 müssen vollständig registriert sein.', '2026-08-14 16:42:09'),
(212, 24, 'K3_2_22_WORD_LATEX', 'passed', '80', '80', 'Alle Gleichungen 3.766 bis 3.845 müssen eine nichtleere Word-LaTeX-Darstellung besitzen.', '2026-08-14 16:42:09'),
(213, 24, 'K3_2_22_FORMAL_CORRECTIONS', 'failed', '3', '0', 'Die formalen Präzisierungen der Gleichungen 3.817, 3.818 und 3.837 müssen vorhanden sein.', '2026-08-14 16:42:09'),
(214, 24, 'K3_2_22_CITATION_COUNTERS', 'passed', 'last=79; next=80', 'last=79; next=80', '3.2.22 führt keine neue Literaturquelle ein und verändert die Literaturzähler bewusst nicht.', '2026-08-14 16:42:09'),
(215, 25, 'K3_2_23_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.23 muss genau einmal vorhanden sein.', '2026-08-14 17:16:11'),
(216, 25, 'K3_2_23_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.23 muss den Status final besitzen.', '2026-08-14 17:16:11'),
(217, 25, 'K3_2_23_SOURCE_79', 'passed', '1', '1', 'Die bereits eingeführte Quelle [79] O\'Neill sollte mit dem verbindlichen source_key vorhanden sein.', '2026-08-14 17:16:11'),
(218, 25, 'K3_2_23_SOURCE_USAGE', 'passed', '1 if [79] exists', '1', 'Für 3.2.23 soll genau eine Wiederverwendung der Quelle [79] dokumentiert sein.', '2026-08-14 17:16:11'),
(219, 25, 'K3_2_23_DEFINITIONS', 'passed', '12', '12', 'Definitionen 3.2.173 bis 3.2.184 müssen vollständig registriert sein.', '2026-08-14 17:16:11'),
(220, 25, 'K3_2_23_THEOREMS', 'passed', '7', '7', 'Sätze 3.2.93 bis 3.2.99 müssen vollständig registriert sein.', '2026-08-14 17:16:11'),
(221, 25, 'K3_2_23_EQUATIONS', 'passed', '80', '80', 'Gleichungen 3.846 bis 3.925 müssen vollständig registriert sein.', '2026-08-14 17:16:11'),
(222, 25, 'K3_2_23_WORD_LATEX', 'passed', '80', '80', 'Alle Gleichungen 3.846 bis 3.925 müssen eine nichtleere Word-LaTeX-Darstellung besitzen.', '2026-08-14 17:16:11'),
(223, 25, 'K3_2_23_FORMAL_CORRECTIONS', 'failed', '6', '0', 'Die formalen Präzisierungen der Gleichungen 3.897, 3.902, 3.906, 3.909, 3.912 und 3.917 müssen vorhanden sein.', '2026-08-14 17:16:11'),
(224, 25, 'K3_2_23_CITATION_COUNTERS', 'passed', 'last=79; next=80', 'last=79; next=80', '3.2.23 führt keine neue Literaturquelle ein und verändert die Literaturzähler bewusst nicht.', '2026-08-14 17:16:11'),
(225, 26, 'K3_2_24_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.24 muss genau einmal vorhanden sein.', '2026-08-14 18:01:40'),
(226, 26, 'K3_2_24_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.24 muss den Status final besitzen.', '2026-08-14 18:01:40'),
(227, 26, 'K3_2_24_SOURCE_79', 'passed', '1', '1', 'Die bereits eingeführte Quelle [79] O\'Neill sollte mit dem verbindlichen source_key vorhanden sein.', '2026-08-14 18:01:40'),
(228, 26, 'K3_2_24_SOURCE_USAGE', 'passed', '1 if [79] exists', '1', 'Für 3.2.24 soll genau eine Wiederverwendung der Quelle [79] dokumentiert sein.', '2026-08-14 18:01:40'),
(229, 26, 'K3_2_24_DEFINITIONS', 'passed', '14', '14', 'Definitionen 3.2.185 bis 3.2.198 müssen vollständig registriert sein.', '2026-08-14 18:01:40'),
(230, 26, 'K3_2_24_THEOREMS', 'passed', '5', '5', 'Sätze 3.2.100 bis 3.2.104 müssen vollständig registriert sein.', '2026-08-14 18:01:40'),
(231, 26, 'K3_2_24_EQUATIONS', 'passed', '70', '70', 'Gleichungen 3.926 bis 3.995 müssen vollständig registriert sein.', '2026-08-14 18:01:40'),
(232, 26, 'K3_2_24_WORD_LATEX', 'passed', '70', '70', 'Alle Gleichungen 3.926 bis 3.995 müssen eine nichtleere Word-LaTeX-Darstellung besitzen.', '2026-08-14 18:01:40'),
(233, 26, 'K3_2_24_FORMAL_CORRECTIONS', 'passed', '3', '3', 'Die formalen Präzisierungen der Gleichungen 3.953, 3.978 und 3.982 müssen vorhanden sein.', '2026-08-14 18:01:40'),
(234, 26, 'K3_2_24_CITATION_COUNTERS', 'passed', 'last=79; next=80', 'last=79; next=80', '3.2.24 führt keine neue Literaturquelle ein und verändert die Literaturzähler bewusst nicht.', '2026-08-14 18:01:40'),
(235, 27, 'K3_2_25_SECTION_EXISTS', 'passed', '1', '1', 'Abschnitt 3.2.25 muss genau einmal vorhanden sein.', '2026-08-14 18:19:25'),
(236, 27, 'K3_2_25_SECTION_FINAL', 'passed', '1', '1', 'Abschnitt 3.2.25 muss den Status final besitzen.', '2026-08-14 18:19:25'),
(237, 27, 'K3_2_25_SOURCES_77_79', 'passed', '2', '2', 'Die bereits eingeführten Quellen [77] Evans und [79] O\'Neill sollten mit ihren verbindlichen source_keys vorhanden sein.', '2026-08-14 18:19:25'),
(238, 27, 'K3_2_25_SOURCE_USAGE', 'passed', '2 if [77] and [79] exist', '2', 'Für 3.2.25 sollen genau zwei Quellenwiederverwendungen für [77] und [79] dokumentiert sein.', '2026-08-14 18:19:25'),
(239, 27, 'K3_2_25_DEFINITIONS', 'passed', '10', '10', 'Definitionen 3.2.199 bis 3.2.208 müssen vollständig registriert sein.', '2026-08-14 18:19:25'),
(240, 27, 'K3_2_25_THEOREMS', 'passed', '7', '7', 'Sätze 3.2.105 bis 3.2.111 müssen vollständig registriert sein.', '2026-08-14 18:19:25'),
(241, 27, 'K3_2_25_EQUATIONS', 'passed', '101', '101', 'Gleichungen 3.996 bis 3.1096 müssen vollständig registriert sein.', '2026-08-14 18:19:25'),
(242, 27, 'K3_2_25_WORD_LATEX', 'passed', '101', '101', 'Alle Gleichungen 3.996 bis 3.1096 müssen eine nichtleere Word-LaTeX-Darstellung besitzen.', '2026-08-14 18:19:25'),
(243, 27, 'K3_2_25_FORMAL_CORRECTIONS', 'failed', '7', '0', 'Die formalen Präzisierungen 3.1056, 3.1062, 3.1063, 3.1066, 3.1083, 3.1090 und 3.1091 müssen vorhanden sein.', '2026-08-14 18:19:25'),
(244, 27, 'K3_2_25_CITATION_COUNTERS', 'passed', 'last=79; next=80', 'last=79; next=80', '3.2.25 führt keine neue Literaturquelle ein und verändert die Literaturzähler bewusst nicht.', '2026-08-14 18:19:25');

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
(1, 2, 22, 'created', 'section', '3.2.0', 'Abschnitt 3.2.0 wurde als Einleitung der mathematischen Grundlagen angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; bedarfsorientierte mathematische Grundlegung; keine neuen Literaturstellen; keine Definitionen; keine nummerierten Gleichungen.', '2026-08-12 11:54:59'),
(2, 2, 22, 'source_reused', 'sources', '[6],[59],[60],[67],[68]', 'Die bereits vorhandenen Literaturquellen [6], [59], [60], [67] und [68] wurden Abschnitt 3.2.0 zugeordnet.', NULL, 'Fünf Wiederverwendungen; keine neue Literaturzahl vergeben.', '2026-08-12 11:54:59'),
(3, 3, 24, 'created', 'section', '3.2.1', 'Abschnitt 3.2.1 „Mengen, Elemente und Relationen“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte Mathematik; keine FRZK-spezifische Setzung.', '2026-08-12 12:45:52'),
(4, 3, 24, 'source_reused', 'source', '[6]', 'Die bereits vorhandene Quelle [6] wurde mit verifizierten Fundstellen für die elementare mengentheoretische Grundlegung wiederverwendet.', NULL, 'Vorwort S. v; Extensionalität S. 1-3; Ordered Pairs S. 22-25; Relations S. 26-29.', '2026-08-12 12:45:52'),
(5, 3, 24, 'source_added', 'source', '[71]', 'Herbert B. Enderton, Elements of Set Theory, wurde als neue Literaturquelle [71] aufgenommen und mit Deep Research verifiziert.', 'last_citation_number=70', 'last_citation_number=71', '2026-08-12 12:45:52'),
(6, 3, 24, 'definition_added', 'definition_range', '3.2.1-3.2.5', 'Fünf etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.1 bis 3.2.5.', '2026-08-12 12:45:52'),
(7, 3, 24, 'equation_added', 'equation_range', '3.1-3.13', 'Dreizehn nummerierte mathematische Aussagen einschließlich Word-LaTeX wurden registriert.', NULL, 'Gleichungen 3.1 bis 3.13.', '2026-08-12 12:45:52'),
(8, 3, 24, 'status_changed', 'section', '3.2.1-ABSCHLUSS', 'Abschnitt 3.2.1 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-12 12:45:52'),
(9, 4, 26, 'created', 'section', '3.2.2', 'Abschnitt 3.2.2 „Funktionen und eindeutige Zuordnungen“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte Mathematik; keine FRZK-spezifische Setzung.', '2026-08-12 13:01:49'),
(10, 4, 26, 'source_reused', 'sources', '[6],[71]', 'Die bereits vorhandenen Quellen [6] und [71] wurden für die mathematische Grundlegung des Funktionsbegriffs wiederverwendet.', NULL, 'Keine neue Literaturzahl; last_citation_number=71; next_citation_number=72.', '2026-08-12 13:01:49'),
(11, 4, 26, 'definition_added', 'definition_range', '3.2.6-3.2.12', 'Sieben etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.6 bis 3.2.12.', '2026-08-12 13:01:49'),
(12, 4, 26, 'equation_added', 'equation_range', '3.14-3.25', 'Zwölf nummerierte mathematische Aussagen wurden mit ihrer Word-LaTeX-Entsprechung registriert.', NULL, 'Gleichungen 3.14 bis 3.25.', '2026-08-12 13:01:49'),
(13, 4, 26, 'status_changed', 'section', '3.2.2-ABSCHLUSS', 'Abschnitt 3.2.2 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-12 13:01:49'),
(14, 5, 27, 'created', 'section', '3.2.3', 'Abschnitt 3.2.3 „Vektorräume und mathematische Zustandsräume“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte Mathematik; keine FRZK-spezifische Setzung.', '2026-08-12 13:16:23'),
(15, 5, 27, 'source_added', 'source', '[72]', 'Gilbert Strang, Introduction to Linear Algebra, Fifth Edition, wurde als neue Literaturquelle [72] aufgenommen und erstmals in 3.2.3 verwendet.', NULL, 'last_citation_number=72; next_citation_number=73.', '2026-08-12 13:16:23'),
(16, 5, 27, 'definition_added', 'definition_range', '3.2.13-3.2.15', 'Drei etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.13 bis 3.2.15.', '2026-08-12 13:16:23'),
(17, 5, 27, 'equation_added', 'equation_range', '3.26-3.32', 'Sieben nummerierte mathematische Aussagen wurden mit ihren Word-LaTeX-Entsprechungen registriert.', NULL, 'Gleichungen 3.26 bis 3.32.', '2026-08-12 13:16:23'),
(18, 5, 27, 'status_changed', 'section', '3.2.3-ABSCHLUSS', 'Abschnitt 3.2.3 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-12 13:16:23'),
(19, 6, 28, 'created', 'section', '3.2.4', 'Abschnitt 3.2.4 „Linearkombinationen, Spannräume und Erzeugung“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte lineare Algebra; keine FRZK-spezifische Setzung.', '2026-08-12 14:21:38'),
(20, 6, 28, 'source_reused', 'source', '[72]', 'Die bereits vorhandene Quelle [72] wurde für Linearkombinationen, Spannräume und Erzeugung wiederverwendet.', NULL, 'Keine neue Literaturzahl; last_citation_number=72; next_citation_number=73.', '2026-08-12 14:21:38'),
(21, 6, 28, 'definition_added', 'definition_range', '3.2.16-3.2.19', 'Vier etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.16 bis 3.2.19.', '2026-08-12 14:21:38'),
(22, 6, 28, 'equation_added', 'equation_range', '3.33-3.44', 'Zwölf nummerierte mathematische Aussagen wurden mit ihren Word-LaTeX-Entsprechungen registriert.', NULL, 'Gleichungen 3.33 bis 3.44.', '2026-08-12 14:21:38'),
(23, 6, 28, 'status_changed', 'section', '3.2.4-ABSCHLUSS', 'Abschnitt 3.2.4 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-12 14:21:38'),
(24, 7, 29, 'created', 'section', '3.2.5', 'Abschnitt 3.2.5 „Lineare Unabhängigkeit, Basis und Dimension“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte lineare Algebra; keine FRZK-spezifische Setzung.', '2026-08-12 14:44:57'),
(25, 7, 29, 'source_reused', 'source', '[72]', 'Die bereits vorhandene Quelle [72] wurde für lineare Unabhängigkeit, Basis, Koordinaten und Dimension wiederverwendet.', NULL, 'Keine neue Literaturzahl; last_citation_number=72; next_citation_number=73.', '2026-08-12 14:44:57'),
(26, 7, 29, 'definition_added', 'definition_range', '3.2.20-3.2.22', 'Drei etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.20 bis 3.2.22.', '2026-08-12 14:44:57'),
(27, 7, 29, 'statement_added', 'theorem', '3.2.1', 'Der Satz zur eindeutigen Darstellung eines Vektors bezüglich einer Basis wurde registriert.', NULL, 'Satz 3.2.1.', '2026-08-12 14:44:57'),
(28, 7, 29, 'equation_added', 'equation_range', '3.45-3.57', 'Dreizehn nummerierte mathematische Aussagen wurden mit ihren Word-LaTeX-Entsprechungen registriert.', NULL, 'Gleichungen 3.45 bis 3.57.', '2026-08-12 14:44:57'),
(29, 7, 29, 'status_changed', 'section', '3.2.5-ABSCHLUSS', 'Abschnitt 3.2.5 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-12 14:44:57'),
(30, 8, 30, 'created', 'section', '3.2.6', 'Abschnitt 3.2.6 „Lineare Abbildungen und Operatoren“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte lineare Algebra; keine FRZK-spezifische Setzung.', '2026-08-12 15:41:29'),
(31, 8, 30, 'source_reused', 'source', '[72]', 'Die bereits vorhandene Quelle [72] wurde für lineare Abbildungen, Kern, Bild, Rang, Nullität, Operatoren und Matrixdarstellungen wiederverwendet.', NULL, 'Keine neue Literaturzahl; last_citation_number=72; next_citation_number=73.', '2026-08-12 15:41:29'),
(32, 8, 30, 'definition_added', 'definition_range', '3.2.23-3.2.27', 'Fünf etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.23 bis 3.2.27.', '2026-08-12 15:41:29'),
(33, 8, 30, 'statement_added', 'theorem_range', '3.2.2-3.2.3', 'Zwei etablierte mathematische Sätze wurden registriert.', NULL, 'Sätze 3.2.2 bis 3.2.3.', '2026-08-12 15:41:29'),
(34, 8, 30, 'equation_added', 'equation_range', '3.58-3.80', 'Dreiundzwanzig nummerierte mathematische Aussagen wurden mit ihren Word-LaTeX-Entsprechungen registriert.', NULL, 'Gleichungen 3.58 bis 3.80.', '2026-08-12 15:41:29'),
(35, 8, 30, 'status_changed', 'section', '3.2.6-ABSCHLUSS', 'Abschnitt 3.2.6 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-12 15:41:29'),
(36, 9, 31, 'created', 'section', '3.2.7', 'Abschnitt 3.2.7 „Normen, Abstände und Skalarprodukte“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte Mathematik; keine FRZK-spezifische Setzung.', '2026-08-13 00:59:20'),
(37, 9, 31, 'source_added', 'source', '[73]', 'John B. Conway wurde als neue Quelle [73] für die funktionalanalytische Grundlegung aufgenommen.', 'last_citation_number=72', 'last_citation_number=73; next_citation_number=74.', '2026-08-13 00:59:20'),
(38, 9, 31, 'source_reused', 'source', '[72]', 'Die bereits vorhandene Quelle [72] wurde ergänzend für endlichdimensionale Skalarprodukt- und Orthogonalitätsstrukturen wiederverwendet.', NULL, '§1.2 sowie Kap. 4 §§4.1-4.4.', '2026-08-13 00:59:20'),
(39, 9, 31, 'definition_added', 'definition_range', '3.2.28-3.2.34', 'Sieben etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.28 bis 3.2.34.', '2026-08-13 00:59:20'),
(40, 9, 31, 'statement_added', 'theorem_range', '3.2.4-3.2.6', 'Drei etablierte mathematische Sätze wurden registriert.', NULL, 'Sätze 3.2.4 bis 3.2.6.', '2026-08-13 00:59:20'),
(41, 9, 31, 'equation_added', 'equation_range', '3.81-3.97', 'Siebzehn nummerierte mathematische Aussagen wurden mit ihren Word-LaTeX-Entsprechungen registriert.', NULL, 'Gleichungen 3.81 bis 3.97.', '2026-08-13 00:59:20'),
(42, 9, 31, 'status_changed', 'section', '3.2.7-ABSCHLUSS', 'Abschnitt 3.2.7 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-13 00:59:20'),
(43, 10, 32, 'created', 'section', '3.2.8', 'Abschnitt 3.2.8 „Topologische Räume, Umgebungen und Stetigkeit“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte allgemeine Topologie; keine FRZK-spezifische Setzung.', '2026-08-13 01:33:34'),
(44, 10, 32, 'source_added', 'source', '[74]', 'James R. Munkres wurde als neue Quelle [74] für die topologischen Grundlagen aufgenommen.', 'last_citation_number=73', 'Bei erfolgreicher Quellenanlage: last_citation_number=74; next_citation_number=75.', '2026-08-13 01:33:34'),
(45, 10, 32, 'definition_added', 'definition_range', '3.2.35-3.2.43', 'Neun etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.35 bis 3.2.43.', '2026-08-13 01:33:34'),
(46, 10, 32, 'statement_added', 'theorem', '3.2.7', 'Der Satz zur Stetigkeit der Verkettung stetiger Abbildungen wurde registriert.', NULL, 'Satz 3.2.7.', '2026-08-13 01:33:34'),
(47, 10, 32, 'equation_added', 'equation_range', '3.98-3.119', 'Zweiundzwanzig nummerierte mathematische Aussagen wurden mit ihren Word-LaTeX-Entsprechungen registriert.', NULL, 'Gleichungen 3.98 bis 3.119.', '2026-08-13 01:33:34'),
(48, 10, 32, 'status_changed', 'section', '3.2.8-ABSCHLUSS', 'Abschnitt 3.2.8 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-13 01:33:34'),
(49, 11, 33, 'created', 'section', '3.2.9', 'Abschnitt 3.2.9 „Zusammenhang und Kompaktheit topologischer Zustandsräume“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte allgemeine Topologie; keine FRZK-spezifische Setzung.', '2026-08-13 04:09:20'),
(50, 11, 33, 'source_reused', 'source', '[74]', 'Die bereits vorhandene Quelle [74] wurde für Zusammenhang, Wegzusammenhang, Komponenten und Kompaktheit wiederverwendet.', NULL, 'Keine neue Literaturzahl; bei vorhandenem [74]: last_citation_number=74; next_citation_number=75.', '2026-08-13 04:09:20'),
(51, 11, 33, 'definition_added', 'definition_range', '3.2.44-3.2.52', 'Neun etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.44 bis 3.2.52.', '2026-08-13 04:09:20'),
(52, 11, 33, 'statement_added', 'theorem_range', '3.2.8-3.2.12', 'Fünf etablierte mathematische Sätze wurden registriert.', NULL, 'Sätze 3.2.8 bis 3.2.12.', '2026-08-13 04:09:20'),
(53, 11, 33, 'equation_added', 'equation_range', '3.120-3.139', 'Zwanzig nummerierte mathematische Aussagen wurden mit ihren Word-LaTeX-Entsprechungen registriert.', NULL, 'Gleichungen 3.120 bis 3.139.', '2026-08-13 04:09:20'),
(54, 11, 33, 'status_changed', 'section', '3.2.9-ABSCHLUSS', 'Abschnitt 3.2.9 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-13 04:09:20'),
(55, 12, 34, 'created', 'section', '3.2.10', 'Abschnitt 3.2.10 „Folgen, Konvergenz und Vollständigkeit“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte Topologie, metrische Raumtheorie und Funktionalanalysis; keine FRZK-spezifische Setzung.', '2026-08-13 04:23:37'),
(56, 12, 34, 'source_reused', 'source_range', '[73]-[74]', 'Die vorhandenen Quellen [73] Conway und [74] Munkres wurden für Vollständigkeit, Banach-/Hilberträume sowie Folgen- und Konvergenztheorie wiederverwendet.', NULL, 'Keine neue Literaturzahl; bei vorhandenem [73] und [74]: last_citation_number=74; next_citation_number=75.', '2026-08-13 04:23:37'),
(57, 12, 34, 'definition_added', 'definition_range', '3.2.53-3.2.59', 'Sieben etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.53 bis 3.2.59.', '2026-08-13 04:23:37'),
(58, 12, 34, 'statement_added', 'theorem_range', '3.2.13-3.2.18', 'Sechs etablierte mathematische Sätze wurden registriert.', NULL, 'Sätze 3.2.13 bis 3.2.18.', '2026-08-13 04:23:37'),
(59, 12, 34, 'equation_added', 'equation_range', '3.140-3.166', 'Siebenundzwanzig nummerierte mathematische Aussagen wurden mit ihren Word-LaTeX-Entsprechungen registriert.', NULL, 'Gleichungen 3.140 bis 3.166.', '2026-08-13 04:23:37'),
(60, 12, 34, 'status_changed', 'section', '3.2.10-ABSCHLUSS', 'Abschnitt 3.2.10 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-13 04:23:37'),
(61, 13, 35, 'created', 'section', '3.2.11', 'Abschnitt 3.2.11 „Funktionenräume als mathematische Zustandsräume“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte Funktionalanalysis und Topologie; keine FRZK-spezifische Setzung.', '2026-08-13 04:37:15'),
(62, 13, 35, 'source_reused', 'source_range', '[73]-[74]', 'Die vorhandenen Quellen [73] Conway und [74] Munkres wurden für Funktionenraum-, Vollständigkeits- und Konvergenzstrukturen wiederverwendet.', NULL, 'Keine neue Literaturzahl; bei vorhandenem [73] und [74]: last_citation_number=74; next_citation_number=75.', '2026-08-13 04:37:15'),
(63, 13, 35, 'definition_added', 'definition_range', '3.2.60-3.2.68', 'Neun etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.60 bis 3.2.68.', '2026-08-13 04:37:15'),
(64, 13, 35, 'statement_added', 'theorem_range', '3.2.19-3.2.25', 'Sieben etablierte mathematische Sätze wurden registriert.', NULL, 'Sätze 3.2.19 bis 3.2.25.', '2026-08-13 04:37:15'),
(65, 13, 35, 'equation_added', 'equation_range', '3.167-3.202', 'Sechsunddreißig nummerierte mathematische Aussagen wurden mit ihren Word-LaTeX-Entsprechungen registriert.', NULL, 'Gleichungen 3.167 bis 3.202.', '2026-08-13 04:37:15'),
(66, 13, 35, 'status_changed', 'section', '3.2.11-ABSCHLUSS', 'Abschnitt 3.2.11 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-13 04:37:15'),
(67, 14, 36, 'created', 'section', '3.2.12', 'Abschnitt 3.2.12 „Lineare Funktionale, Dualräume und beschränkte Operatoren“ wurde vollständig angelegt beziehungsweise auf den verbindlichen Stand aktualisiert.', NULL, 'Status final; etablierte Funktionalanalysis; methodologische Originalaussagen separat gekennzeichnet.', '2026-08-13 04:51:15'),
(68, 14, 36, 'source_reused', 'source', '[73]', 'Die vorhandene Quelle [73] Conway wurde für Funktionale, Dualräume, beschränkte Operatoren, Operatornormen, Riesz-Darstellung, Banachalgebra und inversen Operator wiederverwendet.', NULL, 'Keine neue Literaturzahl; Literaturzähler bleiben unverändert.', '2026-08-13 04:51:15'),
(69, 14, 36, 'definition_added', 'definition_range', '3.2.69-3.2.75', 'Sieben etablierte mathematische Definitionen wurden registriert.', NULL, 'Definitionen 3.2.69 bis 3.2.75.', '2026-08-13 04:51:15'),
(70, 14, 36, 'statement_added', 'theorem_range', '3.2.26-3.2.32', 'Sieben etablierte mathematische Sätze wurden registriert.', NULL, 'Sätze 3.2.26 bis 3.2.32.', '2026-08-13 04:51:15'),
(71, 14, 36, 'equation_added', 'equation_range', '3.203-3.245', 'Dreiundvierzig nummerierte mathematische Aussagen wurden mit ihren Word-LaTeX-Entsprechungen registriert.', NULL, 'Gleichungen 3.203 bis 3.245.', '2026-08-13 04:51:15'),
(72, 14, 36, 'status_changed', 'section', '3.2.12-ABSCHLUSS', 'Abschnitt 3.2.12 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-13 04:51:15'),
(73, 15, 37, 'created', 'section', '3.2.13', 'Abschnitt 3.2.13 „Eigenwerte, Eigenvektoren und Spektralbegriffe von Operatoren“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; Literatur [72] und [73]; keine neue Literaturquelle.', '2026-08-13 07:20:29'),
(74, 15, 37, 'source_reused', 'source_range', '[72]-[73]', 'Die vorhandenen Quellen [72] Strang und [73] Conway wurden wiederverwendet.', NULL, 'Keine Änderung der Literaturzähler.', '2026-08-13 07:20:29'),
(75, 15, 37, 'definition_added', 'definition_range', '3.2.76-3.2.85', 'Zehn Definitionen registriert.', NULL, 'Definitionen 3.2.76 bis 3.2.85.', '2026-08-13 07:20:29'),
(76, 15, 37, 'statement_added', 'theorem_range', '3.2.33-3.2.39', 'Sieben Sätze registriert.', NULL, 'Sätze 3.2.33 bis 3.2.39.', '2026-08-13 07:20:29'),
(77, 15, 37, 'equation_added', 'equation_range', '3.246-3.280', 'Fünfunddreißig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.246 bis 3.280.', '2026-08-13 07:20:29'),
(78, 15, 37, 'status_changed', 'section', '3.2.13-ABSCHLUSS', 'Abschnitt 3.2.13 als abgeschlossen markiert.', 'draft', 'final', '2026-08-13 07:20:29'),
(79, 16, 38, 'created', 'section', '3.2.14', 'Abschnitt 3.2.14 „Projektionen, orthogonale Zerlegungen und invariante Teilräume“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; Quellen [72] und [73]; keine neue Literaturquelle.', '2026-08-13 07:36:30'),
(80, 16, 38, 'source_reused', 'source_range', '[72]-[73]', 'Die vorhandenen Quellen [72] Strang und [73] Conway wurden wiederverwendet.', NULL, 'Keine Änderung der Literaturzähler.', '2026-08-13 07:36:30'),
(81, 16, 38, 'definition_added', 'definition_range', '3.2.86-3.2.90', 'Fünf Definitionen registriert.', NULL, 'Definitionen 3.2.86 bis 3.2.90.', '2026-08-13 07:36:30'),
(82, 16, 38, 'statement_added', 'theorem_range', '3.2.40-3.2.47', 'Acht Sätze registriert.', NULL, 'Sätze 3.2.40 bis 3.2.47.', '2026-08-13 07:36:30'),
(83, 16, 38, 'equation_added', 'equation_range', '3.281-3.334', 'Vierundfünfzig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.281 bis 3.334.', '2026-08-13 07:36:30'),
(84, 16, 38, 'status_changed', 'section', '3.2.14-ABSCHLUSS', 'Abschnitt 3.2.14 als abgeschlossen markiert.', 'draft', 'final', '2026-08-13 07:36:30'),
(85, 17, 39, 'created', 'section', '3.2.16', 'Abschnitt 3.2.16 „Gewöhnliche und partielle Differentialgleichungen als Zustandsrelationen“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; neue Quellen [76] Teschl und [77] Evans; Wiederverwendung [73] Conway.', '2026-08-13 14:37:48'),
(86, 17, 39, 'source_added', 'source', '[76]', 'Gerald Teschl, Ordinary Differential Equations and Dynamical Systems (2012), als neue ODE-Grundlagenquelle eingeführt.', NULL, 'citation_number=76; source_key=teschl_ordinary_differential_equations_dynamical_systems_2012.', '2026-08-13 14:37:48'),
(87, 17, 39, 'source_added', 'source', '[77]', 'Lawrence C. Evans, Partial Differential Equations, Second Edition (2010), als neue PDE-Grundlagenquelle eingeführt.', NULL, 'citation_number=77; source_key=evans_partial_differential_equations_2e_2010.', '2026-08-13 14:37:48'),
(88, 17, 39, 'source_reused', 'source', '[73]', 'Conway [73] für abstrakte Operatorgleichungen, Definitionsbereiche, Kerne und affine Lösungsräume wiederverwendet.', NULL, 'Keine neue Fundstellenbehauptung in exact_location.', '2026-08-13 14:37:48'),
(89, 17, 39, 'definition_added', 'definition_range', '3.2.99-3.2.109', 'Elf Definitionen registriert.', NULL, 'Definitionen 3.2.99 bis 3.2.109.', '2026-08-13 14:37:48'),
(90, 17, 39, 'statement_added', 'theorem_range', '3.2.55-3.2.58', 'Vier Sätze registriert.', NULL, 'Sätze 3.2.55 bis 3.2.58.', '2026-08-13 14:37:48'),
(91, 17, 39, 'equation_added', 'equation_range', '3.383-3.441', 'Neunundfünfzig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.383 bis 3.441.', '2026-08-13 14:37:48'),
(92, 17, 39, 'status_changed', 'section', '3.2.16-ABSCHLUSS', 'Abschnitt 3.2.16 als abgeschlossen markiert.', 'draft', 'final', '2026-08-13 14:37:48'),
(93, 18, 40, 'created', 'section', '3.2.17', 'Abschnitt 3.2.17 „Dynamische Systeme, Flüsse und mathematische Zustandsentwicklung“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; Wiederverwendung der Quelle [76]; keine neue Literaturquelle.', '2026-08-13 16:52:03'),
(94, 18, 40, 'source_reused', 'source', '[76]', 'Teschl [76] als Grundlagenquelle für dynamische Systeme und Flüsse wiederverwendet.', NULL, 'Verifizierte Fundstelle: Part 2 „Dynamical systems“, Chapter 6 „Dynamical systems“.', '2026-08-13 16:52:03'),
(95, 18, 40, 'definition_added', 'definition_range', '3.2.110-3.2.120', 'Elf Definitionen registriert.', NULL, 'Definitionen 3.2.110 bis 3.2.120.', '2026-08-13 16:52:03'),
(96, 18, 40, 'statement_added', 'theorem_range', '3.2.59-3.2.65', 'Sieben Sätze registriert.', NULL, 'Sätze 3.2.59 bis 3.2.65.', '2026-08-13 16:52:03'),
(97, 18, 40, 'equation_added', 'equation_range', '3.442-3.510', 'Neunundsechzig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.442 bis 3.510.', '2026-08-13 16:52:03'),
(98, 18, 40, 'status_changed', 'section', '3.2.17-ABSCHLUSS', 'Abschnitt 3.2.17 als abgeschlossen markiert.', 'draft', 'final', '2026-08-13 16:52:03'),
(99, 19, 41, 'created', 'section', '3.2.18', 'Abschnitt 3.2.18 „Stabilität, Störungen und Lyapunov-Begriffe dynamischer Systeme“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; Wiederverwendung der Quelle [76]; keine neue Literaturquelle.', '2026-08-13 18:59:12'),
(100, 19, 41, 'source_reused', 'source', '[76]', 'Teschl [76] als Grundlagenquelle für Stabilität und lokale Dynamik wiederverwendet.', NULL, 'Verifizierte Fundstelle: Part 2 „Dynamical systems“, Chapter 9 „Local behavior near fixed points“.', '2026-08-13 18:59:12'),
(101, 19, 41, 'definition_added', 'definition_range', '3.2.121-3.2.130', 'Zehn Definitionen registriert.', NULL, 'Definitionen 3.2.121 bis 3.2.130.', '2026-08-13 18:59:12'),
(102, 19, 41, 'statement_added', 'theorem_range', '3.2.66-3.2.72', 'Sieben Sätze registriert.', NULL, 'Sätze 3.2.66 bis 3.2.72.', '2026-08-13 18:59:12'),
(103, 19, 41, 'equation_added', 'equation_range', '3.511-3.580', 'Siebzig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.511 bis 3.580.', '2026-08-13 18:59:12'),
(104, 19, 41, 'equation_changed', 'equation', '3.547', 'Die formale Repository-Fassung von Gleichung 3.547 wurde logisch eindeutig als mögliche Nichtidentität zweier Lyapunov-Funktionen gespeichert.', NULL, 'V_1 != V_2 ist möglich; Gleichungsnummer bleibt 3.547.', '2026-08-13 18:59:12'),
(105, 19, 41, 'status_changed', 'section', '3.2.18-ABSCHLUSS', 'Abschnitt 3.2.18 als abgeschlossen markiert.', 'draft', 'final', '2026-08-13 18:59:12'),
(106, 20, 42, 'created', 'section', '3.2.19', 'Abschnitt 3.2.19 „Grenzmengen, Attraktoren und asymptotisches Verhalten dynamischer Systeme“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; Wiederverwendung der Quelle [76]; keine neue Literaturquelle.', '2026-08-13 19:09:35'),
(107, 20, 42, 'source_reused', 'source', '[76]', 'Teschl [76] als Grundlagenquelle für Grenzmengen und Attraktoren wiederverwendet.', NULL, 'Verifizierte Themenbereiche: Chapter 6 „Dynamical systems“; Chapter 8, Section 8.1 „Attracting sets“.', '2026-08-13 19:09:35'),
(108, 20, 42, 'definition_added', 'definition_range', '3.2.131-3.2.140', 'Zehn Definitionen registriert.', NULL, 'Definitionen 3.2.131 bis 3.2.140.', '2026-08-13 19:09:35'),
(109, 20, 42, 'statement_added', 'theorem_range', '3.2.73-3.2.76', 'Vier Sätze registriert.', NULL, 'Sätze 3.2.73 bis 3.2.76.', '2026-08-13 19:09:35'),
(110, 20, 42, 'equation_added', 'equation_range', '3.581-3.630', 'Fünfzig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.581 bis 3.630.', '2026-08-13 19:09:35'),
(111, 20, 42, 'equation_changed', 'equation', '3.589', 'Notation des positiven Orbits im Repository an die bereits eingeführte Schreibweise angepasst.', NULL, 'Verwendung von O^+(x) statt einer nicht eingeführten gamma^+(x)-Notation; Nummer 3.589 bleibt erhalten.', '2026-08-13 19:09:35'),
(112, 20, 42, 'equation_changed', 'equation', '3.623', 'Formale Aussage zur Grenzmengenzuordnung als echte Nichtimplikation gespeichert.', NULL, 'x -> omega^+(x) impliziert keine neue Basisrichtung von X; Nummer 3.623 bleibt erhalten.', '2026-08-13 19:09:35'),
(113, 20, 42, 'status_changed', 'section', '3.2.19-ABSCHLUSS', 'Abschnitt 3.2.19 als abgeschlossen markiert.', 'draft', 'final', '2026-08-13 19:09:35'),
(120, 21, 43, 'created', 'section', '3.2.20', 'Abschnitt 3.2.20 „Differenzierbare Mannigfaltigkeiten, lokale Koordinaten und Tangentialräume“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; neue Quelle [78] John M. Lee.', '2026-08-14 14:12:44'),
(121, 21, 43, 'source_added', 'source', '[78]', 'John M. Lee, Introduction to Smooth Manifolds, Second Edition (2012), als neue Grundlagenquelle eingeführt.', NULL, 'citation_number=78; source_key=lee_introduction_smooth_manifolds_2e_2012.', '2026-08-14 14:12:44'),
(122, 21, 43, 'definition_added', 'definition_range', '3.2.141-3.2.151', 'Elf Definitionen registriert.', NULL, 'Definitionen 3.2.141 bis 3.2.151.', '2026-08-14 14:12:44'),
(123, 21, 43, 'statement_added', 'theorem_range', '3.2.77-3.2.83', 'Sieben Sätze registriert.', NULL, 'Sätze 3.2.77 bis 3.2.83.', '2026-08-14 14:12:44'),
(124, 21, 43, 'equation_added', 'equation_range', '3.631-3.685', 'Fünfundfünfzig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.631 bis 3.685.', '2026-08-14 14:12:44'),
(125, 21, 43, 'status_changed', 'section', '3.2.20-ABSCHLUSS', 'Abschnitt 3.2.20 als abgeschlossen markiert.', 'draft', 'final', '2026-08-14 14:12:44'),
(126, 23, 45, 'created', 'section', '3.2.21', 'Abschnitt 3.2.21 „Riemannsche und pseudo-riemannsche Metriken auf Mannigfaltigkeiten“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; neue Quelle [79] Barrett O\'Neill.', '2026-08-14 14:31:45'),
(127, 23, 45, 'source_added', 'source', '[79]', 'Barrett O\'Neill, Semi-Riemannian Geometry With Applications to Relativity (1983), als neue Grundlagenquelle eingeführt.', NULL, 'citation_number=79; source_key=oneill_semi_riemannian_geometry_relativity_1983.', '2026-08-14 14:31:45'),
(128, 23, 45, 'definition_added', 'definition_range', '3.2.152-3.2.163', 'Zwölf Definitionen registriert.', NULL, 'Definitionen 3.2.152 bis 3.2.163.', '2026-08-14 14:31:45'),
(129, 23, 45, 'statement_added', 'theorem_range', '3.2.84-3.2.86', 'Drei Sätze registriert.', NULL, 'Sätze 3.2.84 bis 3.2.86.', '2026-08-14 14:31:45'),
(130, 23, 45, 'equation_added', 'equation_range', '3.686-3.765', 'Achtzig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.686 bis 3.765.', '2026-08-14 14:31:45'),
(131, 23, 45, 'equation_changed', 'equation', '3.696', 'Die Punktabhängigkeit der metrischen Bilinearformen typologisch sauber dargestellt.', NULL, 'g_p und g_q werden als Bilinearformen auf T_pM beziehungsweise T_qM dargestellt; Nummer 3.696 bleibt erhalten.', '2026-08-14 14:31:45'),
(132, 23, 45, 'equation_changed', 'equation', '3.758', 'Die Aussage zur geometrischen und physikalischen Länge als echte Nichtimplikation präzisiert.', NULL, 'Geometrische Kurvenlänge impliziert nicht automatisch gemessene physikalische Länge; Nummer 3.758 bleibt erhalten.', '2026-08-14 14:31:45'),
(133, 23, 45, 'status_changed', 'section', '3.2.21-ABSCHLUSS', 'Abschnitt 3.2.21 als abgeschlossen markiert.', 'draft', 'final', '2026-08-14 14:31:45'),
(134, 24, 46, 'created', 'section', '3.2.22', 'Abschnitt 3.2.22 „Zusammenhang, kovariante Ableitung und Paralleltransport auf Mannigfaltigkeiten“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; Wiederverwendung der Quelle [79]; keine neue Literaturquelle.', '2026-08-14 16:42:09'),
(135, 24, 46, 'source_reused', 'source', '[79]', 'O\'Neill [79] als Grundlagenquelle für Zusammenhang, Levi-Civita-Verbindung und Paralleltransport wiederverwendet.', NULL, 'Verifizierte Fundstelle: Chapter 3 „Semi-Riemannian Manifolds“, S. 54-96.', '2026-08-14 16:42:09'),
(136, 24, 46, 'definition_added', 'definition_range', '3.2.164-3.2.172', 'Neun Definitionen registriert.', NULL, 'Definitionen 3.2.164 bis 3.2.172.', '2026-08-14 16:42:09'),
(137, 24, 46, 'statement_added', 'theorem_range', '3.2.87-3.2.92', 'Sechs Sätze registriert.', NULL, 'Sätze 3.2.87 bis 3.2.92.', '2026-08-14 16:42:09'),
(138, 24, 46, 'equation_added', 'equation_range', '3.766-3.845', 'Achtzig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.766 bis 3.845.', '2026-08-14 16:42:09'),
(139, 24, 46, 'equation_changed', 'equation', '3.817', 'Die Aussage zur kovarianten Änderung als echte Nichtimplikation gegenüber physikalischer Änderung gespeichert.', NULL, 'nabla_X Y != 0 impliziert nicht automatisch physikalische Änderung; Nummer 3.817 bleibt erhalten.', '2026-08-14 16:42:09'),
(140, 24, 46, 'equation_changed', 'equation', '3.818', 'Die Aussage zur geometrischen Parallelität als echte Nichtimplikation gegenüber physikalischer Konstanz gespeichert.', NULL, 'DV/dt = 0 impliziert nicht automatisch physikalische Unveränderlichkeit; Nummer 3.818 bleibt erhalten.', '2026-08-14 16:42:09'),
(141, 24, 46, 'equation_changed', 'equation', '3.837', 'Die Aussage zum geschlossenen Paralleltransport entsprechend dem Text als mögliche Nichtidentität gespeichert.', NULL, 'P^gamma != I ist möglich; Nummer 3.837 bleibt erhalten.', '2026-08-14 16:42:09'),
(142, 24, 46, 'status_changed', 'section', '3.2.22-ABSCHLUSS', 'Abschnitt 3.2.22 als abgeschlossen markiert.', 'draft', 'final', '2026-08-14 16:42:09'),
(143, 25, 47, 'created', 'section', '3.2.23', 'Abschnitt 3.2.23 „Geodäten, Exponentialabbildung und Krümmung von Mannigfaltigkeiten“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; Wiederverwendung der Quelle [79]; keine neue Literaturquelle.', '2026-08-14 17:16:11'),
(144, 25, 47, 'source_reused', 'source', '[79]', 'O\'Neill [79] als Grundlagenquelle für Geodäten und Krümmung wiederverwendet.', NULL, 'Verifizierte Fundstellen: Chapter 3 „Semi-Riemannian Manifolds“, S. 54-96; Chapter 5 „Riemannian and Lorentz Geometry“, S. 126-157.', '2026-08-14 17:16:11'),
(145, 25, 47, 'definition_added', 'definition_range', '3.2.173-3.2.184', 'Zwölf Definitionen registriert.', NULL, 'Definitionen 3.2.173 bis 3.2.184.', '2026-08-14 17:16:11'),
(146, 25, 47, 'statement_added', 'theorem_range', '3.2.93-3.2.99', 'Sieben Sätze registriert.', NULL, 'Sätze 3.2.93 bis 3.2.99.', '2026-08-14 17:16:11'),
(147, 25, 47, 'equation_added', 'equation_range', '3.846-3.925', 'Achtzig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.846 bis 3.925.', '2026-08-14 17:16:11'),
(148, 25, 47, 'equation_changed', 'equation', '3.897', 'Die Skalarkrümmung wurde formal eindeutig als nicht dimensionssteigernde skalare Funktion gespeichert.', NULL, 'Scal:M->R impliziert keine Erhöhung von dim M; Nummer 3.897 bleibt erhalten.', '2026-08-14 17:16:11'),
(149, 25, 47, 'equation_changed', 'equation', '3.902', 'Der Krümmungsterm wurde formal von einer physikalischen Kraft getrennt.', NULL, 'R(J,dot gamma)dot gamma ist ohne zusätzliche Interpretation nicht mit physikalischer Kraft identisch; Nummer 3.902 bleibt erhalten.', '2026-08-14 17:16:11'),
(150, 25, 47, 'equation_changed', 'equation', '3.906', 'Endlicher Koordinatenbereich wurde formal von geodätischer Unvollständigkeit getrennt.', NULL, 'Endlicher Koordinatenbereich impliziert keine geodätische Unvollständigkeit; Nummer 3.906 bleibt erhalten.', '2026-08-14 17:16:11'),
(151, 25, 47, 'equation_changed', 'equation', '3.909', 'Geometrische Krümmung wurde formal von physikalischer Energie getrennt.', NULL, 'Geometrische Krümmung impliziert nicht automatisch Energie; Nummer 3.909 bleibt erhalten.', '2026-08-14 17:16:11'),
(152, 25, 47, 'equation_changed', 'equation', '3.912', 'Affiner Geodätenparameter wurde formal von physikalischer Zeit getrennt.', NULL, 'Affiner Parameter impliziert nicht automatisch physikalische Zeit; Nummer 3.912 bleibt erhalten.', '2026-08-14 17:16:11'),
(153, 25, 47, 'equation_changed', 'equation', '3.917', 'Lokale Krümmungskenntnis wurde formal von globaler Kausalstruktur getrennt.', NULL, 'Bekannter Krümmungstensor impliziert nicht automatisch bekannte globale Kausalstruktur; Nummer 3.917 bleibt erhalten.', '2026-08-14 17:16:11'),
(154, 25, 47, 'status_changed', 'section', '3.2.23-ABSCHLUSS', 'Abschnitt 3.2.23 als abgeschlossen markiert.', 'draft', 'final', '2026-08-14 17:16:11'),
(155, 26, 48, 'created', 'section', '3.2.24', 'Abschnitt 3.2.24 „Zeitorientierung, kausale Kurven und Kausalstruktur lorentzscher Mannigfaltigkeiten“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; Wiederverwendung der Quelle [79]; keine neue Literaturquelle.', '2026-08-14 18:01:40'),
(156, 26, 48, 'source_reused', 'source', '[79]', 'O\'Neill [79] als Grundlagenquelle für die lorentzsche Kausalstruktur wiederverwendet.', NULL, 'Verifizierte Fundstelle: Chapter 14 „Causality in Lorentz Manifolds“, S. 401-440.', '2026-08-14 18:01:40'),
(157, 26, 48, 'definition_added', 'definition_range', '3.2.185-3.2.198', 'Vierzehn Definitionen registriert.', NULL, 'Definitionen 3.2.185 bis 3.2.198.', '2026-08-14 18:01:40'),
(158, 26, 48, 'statement_added', 'theorem_range', '3.2.100-3.2.104', 'Fünf Sätze registriert.', NULL, 'Sätze 3.2.100 bis 3.2.104.', '2026-08-14 18:01:40'),
(159, 26, 48, 'equation_added', 'equation_range', '3.926-3.995', 'Siebzig nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.926 bis 3.995.', '2026-08-14 18:01:40'),
(160, 26, 48, 'equation_changed', 'equation', '3.953', 'Die fehlende allgemeine Abgeschlossenheit von J^+(p) formal als Nichtimplikation präzisiert.', NULL, 'Die Definition von J^+(p) impliziert ohne Zusatzannahmen keine Abgeschlossenheit; Nummer 3.953 bleibt erhalten.', '2026-08-14 18:01:40'),
(161, 26, 48, 'equation_changed', 'equation', '3.978', 'Konforme Kausalstruktur und vollständige metrische Struktur formal getrennt.', NULL, 'Konforme Kausalstruktur ist nicht mit vollständiger metrischer Struktur identisch; Nummer 3.978 bleibt erhalten.', '2026-08-14 18:01:40'),
(162, 26, 48, 'equation_changed', 'equation', '3.982', 'Die geometrische Kausalrelation formal von einer konkreten Ursache-Wirkungs-Beziehung getrennt.', NULL, 'p <= q impliziert nicht, dass p q tatsächlich verursacht; Nummer 3.982 bleibt erhalten.', '2026-08-14 18:01:40'),
(163, 26, 48, 'status_changed', 'section', '3.2.24-ABSCHLUSS', 'Abschnitt 3.2.24 als abgeschlossen markiert.', 'draft', 'final', '2026-08-14 18:01:40'),
(164, 27, 49, 'created', 'section', '3.2.25', 'Abschnitt 3.2.25 „Variationsprinzipien, Wirkungsfunktionale und Euler-Lagrange-Strukturen“ vollständig angelegt beziehungsweise aktualisiert.', NULL, 'Status final; Wiederverwendung der Quellen [77] und [79]; keine neue Literaturquelle.', '2026-08-14 18:19:25'),
(165, 27, 49, 'source_reused', 'source', '[77]', 'Evans [77] als Grundlagenquelle für Variationsrechnung und Euler-Lagrange-Strukturen wiederverwendet.', NULL, 'Verifizierte Fundstelle: Chapter 8 „The calculus of variations“.', '2026-08-14 18:19:25'),
(166, 27, 49, 'source_reused', 'source', '[79]', 'O\'Neill [79] ergänzend für die Variationscharakterisierung von Geodäten wiederverwendet.', NULL, 'Verifizierter Kapitelname: „Calculus of Variations“; keine ungesicherte Seitenangabe.', '2026-08-14 18:19:25'),
(167, 27, 49, 'definition_added', 'definition_range', '3.2.199-3.2.208', 'Zehn Definitionen registriert.', NULL, 'Definitionen 3.2.199 bis 3.2.208.', '2026-08-14 18:19:25'),
(168, 27, 49, 'statement_added', 'theorem_range', '3.2.105-3.2.111', 'Sieben Sätze registriert.', NULL, 'Sätze 3.2.105 bis 3.2.111.', '2026-08-14 18:19:25'),
(169, 27, 49, 'equation_added', 'equation_range', '3.996-3.1096', 'Einhunderteins nummerierte Gleichungen beziehungsweise mathematische Aussagen registriert.', NULL, 'Gleichungen 3.996 bis 3.1096.', '2026-08-14 18:19:25'),
(170, 27, 49, 'equation_changed', 'equation', '3.1056', 'Funktionalwert und zusätzliche Zustandsdimension formal als Nichtimplikation gespeichert.', NULL, 'J[u] als Skalar impliziert keine zusätzliche Zustandsdimension.', '2026-08-14 18:19:25'),
(171, 27, 49, 'equation_changed', 'equation', '3.1062', 'Mathematische Definition einer Wirkung formal von physikalischer Naturgesetzlichkeit getrennt.', NULL, 'Mathematisch definiertes S impliziert nicht, dass L die Natur beschreibt.', '2026-08-14 18:19:25'),
(172, 27, 49, 'equation_changed', 'equation', '3.1063', 'Euler-Lagrange-Struktur formal von vollständiger Kausalrelation getrennt.', NULL, 'Euler-Lagrange-Gleichung impliziert keine vollständige Kausalrelation.', '2026-08-14 18:19:25'),
(173, 27, 49, 'equation_changed', 'equation', '3.1066', 'Funktionenraumdimension formal von Mannigfaltigkeits-/Raumzeitdimension getrennt.', NULL, 'Unendlichdimensionale zulässige Klasse impliziert keine unendlichdimensionale Mannigfaltigkeit.', '2026-08-14 18:19:25'),
(174, 27, 49, 'equation_changed', 'equation', '3.1083', 'Kohärenzfunktional und Wirkungsfunktional formal als nicht identisch gespeichert.', NULL, 'K ist nicht automatisch mit S identisch.', '2026-08-14 18:19:25'),
(175, 27, 49, 'equation_changed', 'equation', '3.1090', 'Kanonischer Impuls formal von automatisch kartesischem mechanischem Impuls getrennt.', NULL, 'p_a ist nicht automatisch mit kartesischem mechanischem Impuls identisch.', '2026-08-14 18:19:25'),
(176, 27, 49, 'equation_changed', 'equation', '3.1091', 'Impulsvariable formal von zusätzlicher physikalischer Raumdimension getrennt.', NULL, 'Zusätzliche Impulsvariable impliziert keine zusätzliche Raumdimension.', '2026-08-14 18:19:25'),
(177, 27, 49, 'status_changed', 'section', '3.2.25-ABSCHLUSS', 'Abschnitt 3.2.25 als abgeschlossen markiert.', 'draft', 'final', '2026-08-14 18:19:25');

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
(1, 1, 'ch31-001-isaac-newton-philosophiae-naturalis-principia-ma', 'historical_work', 'Philosophiae Naturalis Principia Mathematica', NULL, NULL, 1687, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.0', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Isaac Newton: Philosophiae Naturalis Principia Mathematica. London: Joseph Streater, 1687, insbesondere Scholium zu den Definitionen', 'Isaac Newton: Philosophiae Naturalis Principia Mathematica', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(2, 2, 'ch31-002-albert-einstein-die-grundlage-der-allgemeinen-relat', 'journal_article', 'Die Grundlage der allgemeinen Relativitätstheorie', NULL, NULL, 1916, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.0', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Albert Einstein: „Die Grundlage der allgemeinen Relativitätstheorie“. In: Annalen der Physik, Band 49, 1916, S. 769–822', 'Albert Einstein: Die Grundlage der allgemeinen Relativitätstheorie', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(3, 3, 'ch31-003-carlo-rovelli-quantum-gravity', 'book', 'Quantum Gravity', NULL, NULL, 2004, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.0', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Carlo Rovelli: Quantum Gravity. Cambridge: Cambridge University Press, 2004', 'Carlo Rovelli: Quantum Gravity', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(4, 4, 'ch31-004-parmenides-die-fragmente-der-vorsokratiker', 'book', 'Die Fragmente der Vorsokratiker', NULL, NULL, 1951, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.1', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Parmenides: Die Fragmente der Vorsokratiker, griechisch und deutsch herausgegeben von Hermann Diels, bearbeitet von Walther Kranz, Band 1, 6. Auflage, Berlin: Weidmann, 1951, Fragmente 28 B2, B3 und B6', 'Parmenides: Die Fragmente der Vorsokratiker', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(5, 5, 'ch31-005-steven-weinberg-the-quantum-theory-of-fields-volume', 'book', 'The Quantum Theory of Fields, Volume I: Foundations', NULL, NULL, 1995, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.1', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Steven Weinberg: The Quantum Theory of Fields, Volume I: Foundations, Cambridge: Cambridge University Press, 1995, insbesondere Kapitel 2 und 5', 'Steven Weinberg: The Quantum Theory of Fields, Volume I: Foundations', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(6, 6, 'ch31-006-paul-r-halmos-naive-set-theory', 'book', 'Naive Set Theory', NULL, NULL, 1974, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.1', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Paul R. Halmos: Naive Set Theory, New York: Springer-Verlag, 1974, insbesondere S. 1–12', 'Paul R. Halmos: Naive Set Theory', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(7, 7, 'ch31-007-platon-sophistes-in-platon-werke-in-acht-b', 'book', 'Sophistes, in: Platon. Werke in acht Bänden', NULL, NULL, 1990, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Platon: Sophistes, in: Platon. Werke in acht Bänden, griechisch und deutsch, herausgegeben von Gunther Eigler, Band 6, Darmstadt: Wissenschaftliche Buchgesellschaft, 1990, insbesondere 254d–259d', 'Platon: Sophistes, in: Platon. Werke in acht Bänden', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(8, 8, 'ch31-008-aristoteles-physikvorlesung', 'book', 'Physikvorlesung', NULL, NULL, 1987, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Aristoteles: Physikvorlesung, übersetzt von Hans Günter Zekl, Hamburg: Felix Meiner Verlag, 1987, Bücher IV und VI', 'Aristoteles: Physikvorlesung', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(9, 9, 'ch31-009-plotin-schriften', 'book', 'Schriften', NULL, NULL, 1960, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Plotin: Schriften, griechisch-deutsch, übersetzt von Richard Harder, Neubearbeitung mit griechischem Lesetext und Anmerkungen fortgeführt von Rudolf Beutler und Willy Theiler, Bände I–V, Hamburg: Felix Meiner Verlag, 1956–1960, insbesondere Enneaden V.1 und V.2', 'Plotin: Schriften', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(10, 10, 'ch31-010-nikolaus-von-kues-de-docta-ignorantia-die-belehrte-un', 'book', 'De docta ignorantia – Die belehrte Unwissenheit', NULL, NULL, 1994, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Nikolaus von Kues: De docta ignorantia – Die belehrte Unwissenheit, lateinisch-deutsch, übersetzt und herausgegeben von Paul Wilpert, Hamburg: Felix Meiner Verlag, 1994', 'Nikolaus von Kues: De docta ignorantia – Die belehrte Unwissenheit', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(11, 11, 'ch31-011-baruch-de-spinoza-ethik-in-geometrischer-ordnung-darg', 'book', 'Ethik in geometrischer Ordnung dargestellt', NULL, NULL, 2015, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Baruch de Spinoza: Ethik in geometrischer Ordnung dargestellt, lateinisch-deutsch, übersetzt und herausgegeben von Wolfgang Bartuschat, Hamburg: Felix Meiner Verlag, 2015', 'Baruch de Spinoza: Ethik in geometrischer Ordnung dargestellt', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(12, 12, 'ch31-012-gottfried-wilhelm-leibniz-the-leibnizclarke-correspondence', 'book', 'The Leibniz–Clarke Correspondence', NULL, NULL, 1956, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Gottfried Wilhelm Leibniz; Samuel Clarke: The Leibniz–Clarke Correspondence, herausgegeben von H. G. Alexander, Manchester: Manchester University Press, 1956, insbesondere Leibniz’ drittes bis fünftes Schreiben', 'Gottfried Wilhelm Leibniz; Samuel Clarke: The Leibniz–Clarke Correspondence', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:45', '2026-08-09 08:05:45'),
(13, 13, 'ch31-013-immanuel-kant-kritik-der-reinen-vernunft', 'book', 'Kritik der reinen Vernunft', NULL, NULL, 1998, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Immanuel Kant: Kritik der reinen Vernunft, herausgegeben von Jens Timmermann, Hamburg: Felix Meiner Verlag, 1998, insbesondere A19/B33–A49/B73', 'Immanuel Kant: Kritik der reinen Vernunft', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(14, 14, 'ch31-014-georg-wilhelm-friedrich-hegel-wissenschaft-der-logik-i-werke-band', 'book', 'Wissenschaft der Logik I, Werke, Band 5', NULL, NULL, 1986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Georg Wilhelm Friedrich Hegel: Wissenschaft der Logik I, Werke, Band 5, Frankfurt am Main: Suhrkamp, 1986, insbesondere „Sein“, „Nichts“ und „Werden“', 'Georg Wilhelm Friedrich Hegel: Wissenschaft der Logik I, Werke, Band 5', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(15, 15, 'ch31-015-bertrand-russell-the-principles-of-mathematics', 'book', 'The Principles of Mathematics', NULL, NULL, 1903, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Bertrand Russell: The Principles of Mathematics, Cambridge: Cambridge University Press, 1903', 'Bertrand Russell: The Principles of Mathematics', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(16, 16, 'ch31-016-alfred-north-whitehead-process-and-reality-an-essay-in-cos', 'book', 'Process and Reality. An Essay in Cosmology, corrected edition', NULL, NULL, 1978, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Alfred North Whitehead: Process and Reality. An Essay in Cosmology, corrected edition, herausgegeben von David Ray Griffin und Donald W. Sherburne, New York: Free Press, 1978', 'Alfred North Whitehead: Process and Reality. An Essay in Cosmology, corrected edition', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(17, 17, 'ch31-017-edmund-husserl-zur-phanomenologie-des-inneren-zeit', 'book', 'Zur Phänomenologie des inneren Zeitbewusstseins (1893–1917), Husserliana, Band X', NULL, NULL, 1966, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Edmund Husserl: Zur Phänomenologie des inneren Zeitbewusstseins (1893–1917), Husserliana, Band X, herausgegeben von Rudolf Boehm, Den Haag: Martinus Nijhoff, 1966', 'Edmund Husserl: Zur Phänomenologie des inneren Zeitbewusstseins (1893–1917), Husserliana, Band X', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(18, 18, 'ch31-018-ernst-cassirer-substanzbegriff-und-funktionsbegrif', 'book', 'Substanzbegriff und Funktionsbegriff. Untersuchungen über die Grundfragen der Erkenntniskritik', NULL, NULL, 1910, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Ernst Cassirer: Substanzbegriff und Funktionsbegriff. Untersuchungen über die Grundfragen der Erkenntniskritik, Berlin: Bruno Cassirer, 1910', 'Ernst Cassirer: Substanzbegriff und Funktionsbegriff. Untersuchungen über die Grundfragen der Erkenntniskritik', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(19, 19, 'ch31-019-martin-heidegger-sein-und-zeit-19-auflage', 'book', 'Sein und Zeit, 19. Auflage', NULL, NULL, 2006, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Martin Heidegger: Sein und Zeit, 19. Auflage, Tübingen: Max Niemeyer Verlag, 2006, insbesondere §§ 65–71', 'Martin Heidegger: Sein und Zeit, 19. Auflage', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(20, 20, 'ch31-020-ludwig-wittgenstein-tractatus-logico-philosophicus', 'book', 'Tractatus logico-philosophicus', NULL, NULL, 1963, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Ludwig Wittgenstein: Tractatus logico-philosophicus, Frankfurt am Main: Suhrkamp, 1963', 'Ludwig Wittgenstein: Tractatus logico-philosophicus', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(21, 21, 'ch31-021-ludwig-wittgenstein-philosophische-untersuchungen', 'book', 'Philosophische Untersuchungen', NULL, NULL, 2003, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Ludwig Wittgenstein: Philosophische Untersuchungen, Frankfurt am Main: Suhrkamp, 2003', 'Ludwig Wittgenstein: Philosophische Untersuchungen', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(22, 22, 'ch31-022-rudolf-carnap-der-logische-aufbau-der-welt', 'book', 'Der logische Aufbau der Welt', NULL, NULL, 1928, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Rudolf Carnap: Der logische Aufbau der Welt, Hamburg: Felix Meiner Verlag, 1998, Erstveröffentlichung 1928', 'Rudolf Carnap: Der logische Aufbau der Welt', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(23, 23, 'ch31-023-george-spencer-brown-laws-of-form', 'book', 'Laws of Form', NULL, NULL, 1969, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'George Spencer-Brown: Laws of Form, London: George Allen & Unwin, 1969', 'George Spencer-Brown: Laws of Form', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(24, 24, 'ch31-024-luciano-floridi-the-philosophy-of-information', 'book', 'The Philosophy of Information', NULL, NULL, 2011, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Luciano Floridi: The Philosophy of Information, Oxford: Oxford University Press, 2011', 'Luciano Floridi: The Philosophy of Information', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(25, 25, 'ch31-025-michel-bitbol-reflective-metaphysics-understandin', 'book', 'Reflective Metaphysics. Understanding Quantum Mechanics from a Kantian Standpoint', NULL, NULL, 2021, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.2', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Michel Bitbol: Reflective Metaphysics. Understanding Quantum Mechanics from a Kantian Standpoint, Cham: Springer, 2021', 'Michel Bitbol: Reflective Metaphysics. Understanding Quantum Mechanics from a Kantian Standpoint', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(26, 26, 'ch31-026-ernst-mach-die-mechanik-in-ihrer-entwicklung-h', 'historical_work', 'Die Mechanik in ihrer Entwicklung historisch-kritisch dargestellt', NULL, NULL, 1883, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Ernst Mach: Die Mechanik in ihrer Entwicklung historisch-kritisch dargestellt. Leipzig: F. A. Brockhaus, 1883', 'Ernst Mach: Die Mechanik in ihrer Entwicklung historisch-kritisch dargestellt', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(27, 27, 'ch31-027-albert-einstein-zur-elektrodynamik-bewegter-korper', 'journal_article', 'Zur Elektrodynamik bewegter Körper', NULL, NULL, 1905, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Albert Einstein: „Zur Elektrodynamik bewegter Körper“. In: Annalen der Physik, Band 17, 1905, S. 891–921', 'Albert Einstein: Zur Elektrodynamik bewegter Körper', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(28, 28, 'ch31-028-hermann-minkowski-raum-und-zeit', 'book', 'Raum und Zeit', NULL, NULL, 1909, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Hermann Minkowski: Raum und Zeit. Leipzig: B. G. Teubner, 1909', 'Hermann Minkowski: Raum und Zeit', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(29, 29, 'ch31-029-hermann-weyl-raum-zeit-materie-vorlesungen-uber-', 'book', 'Raum – Zeit – Materie. Vorlesungen über allgemeine Relativitätstheorie. 5. Auflage', NULL, NULL, 1923, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Hermann Weyl: Raum – Zeit – Materie. Vorlesungen über allgemeine Relativitätstheorie. 5. Auflage, Berlin: Springer, 1923', 'Hermann Weyl: Raum – Zeit – Materie. Vorlesungen über allgemeine Relativitätstheorie. 5. Auflage', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(30, 30, 'ch31-030-robert-m-wald-general-relativity', 'book', 'General Relativity', NULL, NULL, 1984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Robert M. Wald: General Relativity. Chicago: University of Chicago Press, 1984', 'Robert M. Wald: General Relativity', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(31, 31, 'ch31-031-stephen-w-hawking-the-large-scale-structure-of-space-', 'book', 'The Large Scale Structure of Space-Time', NULL, NULL, 1973, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Stephen W. Hawking; George F. R. Ellis: The Large Scale Structure of Space-Time. Cambridge: Cambridge University Press, 1973', 'Stephen W. Hawking; George F. R. Ellis: The Large Scale Structure of Space-Time', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(32, 32, 'ch31-032-john-von-neumann-mathematische-grundlagen-der-quante', 'book', 'Mathematische Grundlagen der Quantenmechanik', NULL, NULL, 1932, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'John von Neumann: Mathematische Grundlagen der Quantenmechanik. Berlin: Julius Springer, 1932', 'John von Neumann: Mathematische Grundlagen der Quantenmechanik', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(33, 33, 'ch31-033-paul-a-m-dirac-the-principles-of-quantum-mechanics', 'book', 'The Principles of Quantum Mechanics', NULL, NULL, 1930, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Paul A. M. Dirac: The Principles of Quantum Mechanics. Oxford: Clarendon Press, 1930', 'Paul A. M. Dirac: The Principles of Quantum Mechanics', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(34, 34, 'ch31-034-bryce-s-dewitt-quantum-theory-of-gravity-i-the-can', 'journal_article', 'Quantum Theory of Gravity. I. The Canonical Theory', NULL, NULL, 1967, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Bryce S. DeWitt: „Quantum Theory of Gravity. I. The Canonical Theory“. In: Physical Review, Band 160, 1967, S. 1113–1148', 'Bryce S. DeWitt: Quantum Theory of Gravity. I. The Canonical Theory', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(35, 35, 'ch31-035-claus-kiefer-quantum-gravity-3-auflage', 'book', 'Quantum Gravity. 3. Auflage', NULL, NULL, 2012, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Claus Kiefer: Quantum Gravity. 3. Auflage, Oxford: Oxford University Press, 2012', 'Claus Kiefer: Quantum Gravity. 3. Auflage', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(36, 36, 'ch31-036-luca-bombelli-space-time-as-a-causal-set', 'journal_article', 'Space-Time as a Causal Set', NULL, NULL, 1987, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Luca Bombelli; Joohan Lee; David Meyer; Rafael D. Sorkin: „Space-Time as a Causal Set“. In: Physical Review Letters, Band 59, 1987, S. 521–524', 'Luca Bombelli; Joohan Lee; David Meyer; Rafael D. Sorkin: Space-Time as a Causal Set', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(37, 37, 'ch31-037-ted-jacobson-thermodynamics-of-spacetime-the-ein', 'journal_article', 'Thermodynamics of Spacetime: The Einstein Equation of State', NULL, NULL, 1995, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Ted Jacobson: „Thermodynamics of Spacetime: The Einstein Equation of State“. In: Physical Review Letters, Band 75, 1995, S. 1260–1263', 'Ted Jacobson: Thermodynamics of Spacetime: The Einstein Equation of State', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(38, 38, 'ch31-038-shinsei-ryu-holographic-derivation-of-entanglem', 'journal_article', 'Holographic Derivation of Entanglement Entropy from AdS/CFT', NULL, NULL, 2006, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Shinsei Ryu; Tadashi Takayanagi: „Holographic Derivation of Entanglement Entropy from AdS/CFT“. In: Physical Review Letters, Band 96, 2006, Artikel 181602', 'Shinsei Ryu; Tadashi Takayanagi: Holographic Derivation of Entanglement Entropy from AdS/CFT', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(39, 39, 'ch31-039-mark-van-raamsdonk-building-up-spacetime-with-quantum-', 'journal_article', 'Building up Spacetime with Quantum Entanglement', NULL, NULL, 2010, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Mark Van Raamsdonk: „Building up Spacetime with Quantum Entanglement“. In: General Relativity and Gravitation, Band 42, 2010, S. 2323–2329', 'Mark Van Raamsdonk: Building up Spacetime with Quantum Entanglement', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(40, 40, 'ch31-040-erik-verlinde-on-the-origin-of-gravity-and-the-la', 'journal_article', 'On the Origin of Gravity and the Laws of Newton', NULL, NULL, 2011, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.3', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Erik Verlinde: „On the Origin of Gravity and the Laws of Newton“. In: Journal of High Energy Physics, Ausgabe 04, 2011, Artikel 029', 'Erik Verlinde: On the Origin of Gravity and the Laws of Newton', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(41, 41, 'ch31-041-hermann-von-helmholtz-handbuch-der-physiologischen-optik', 'historical_work', 'Handbuch der physiologischen Optik', NULL, NULL, 1867, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Hermann von Helmholtz: Handbuch der physiologischen Optik. Leipzig: Leopold Voss, 1867', 'Hermann von Helmholtz: Handbuch der physiologischen Optik', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(42, 42, 'ch31-042-norwood-russell-hanson-patterns-of-discovery-an-inquiry-in', 'book', 'Patterns of Discovery. An Inquiry into the Conceptual Foundations of Science', NULL, NULL, 1958, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Norwood Russell Hanson: Patterns of Discovery. An Inquiry into the Conceptual Foundations of Science. Cambridge: Cambridge University Press, 1958', 'Norwood Russell Hanson: Patterns of Discovery. An Inquiry into the Conceptual Foundations of Science', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(43, 43, 'ch31-043-thomas-s-kuhn-the-structure-of-scientific-revolut', 'book', 'The Structure of Scientific Revolutions', NULL, NULL, 1962, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Thomas S. Kuhn: The Structure of Scientific Revolutions. Chicago: University of Chicago Press, 1962', 'Thomas S. Kuhn: The Structure of Scientific Revolutions', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(44, 44, 'ch31-044-karl-r-popper-logik-der-forschung-zur-erkenntnist', 'book', 'Logik der Forschung. Zur Erkenntnistheorie der modernen Naturwissenschaft', NULL, NULL, 1935, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Karl R. Popper: Logik der Forschung. Zur Erkenntnistheorie der modernen Naturwissenschaft. Wien: Julius Springer, 1935', 'Karl R. Popper: Logik der Forschung. Zur Erkenntnistheorie der modernen Naturwissenschaft', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(45, 45, 'ch31-045-imre-lakatos-falsification-and-the-methodology-o', 'journal_article', 'Falsification and the Methodology of Scientific Research Programmes', NULL, NULL, 1970, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Imre Lakatos: Falsification and the Methodology of Scientific Research Programmes. In: Imre Lakatos; Alan Musgrave (Hrsg.): Criticism and the Growth of Knowledge. Cambridge: Cambridge University Press, 1970, S. 91–196', 'Imre Lakatos: Falsification and the Methodology of Scientific Research Programmes', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(46, 46, 'ch31-046-willard-van-orman-quine-two-dogmas-of-empiricism', 'journal_article', 'Two Dogmas of Empiricism', NULL, NULL, 1951, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Willard Van Orman Quine: Two Dogmas of Empiricism. In: The Philosophical Review, Bd. 60, 1951, S. 20–43', 'Willard Van Orman Quine: Two Dogmas of Empiricism', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(47, 47, 'ch31-047-pierre-duhem-la-theorie-physique-son-objet-et-sa', 'book', 'La théorie physique. Son objet et sa structure', NULL, NULL, 1906, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Pierre Duhem: La théorie physique. Son objet et sa structure. Paris: Chevalier & Rivière, 1906', 'Pierre Duhem: La théorie physique. Son objet et sa structure', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(48, 48, 'ch31-048-bas-c-van-fraassen-the-scientific-image', 'book', 'The Scientific Image', NULL, NULL, 1980, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Bas C. van Fraassen: The Scientific Image. Oxford: Clarendon Press, 1980', 'Bas C. van Fraassen: The Scientific Image', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(49, 49, 'ch31-049-john-worrall-structural-realism-the-best-of-both', 'journal_article', 'Structural Realism: The Best of Both Worlds?', NULL, NULL, 1989, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'John Worrall: Structural Realism: The Best of Both Worlds?. In: Dialectica, Bd. 43, 1989, S. 99–124', 'John Worrall: Structural Realism: The Best of Both Worlds?', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(50, 50, 'ch31-050-james-ladyman-what-is-structural-realism', 'journal_article', 'What is Structural Realism?', NULL, NULL, 1998, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'James Ladyman: What is Structural Realism?. In: Studies in History and Philosophy of Science, Bd. 29, 1998, S. 409–424', 'James Ladyman: What is Structural Realism?', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(51, 51, 'ch31-051-steven-french-remodelling-structural-realism-quan', 'journal_article', 'Remodelling Structural Realism: Quantum Physics and the Metaphysics of Structure', NULL, NULL, 2003, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Steven French; James Ladyman: Remodelling Structural Realism: Quantum Physics and the Metaphysics of Structure. In: Synthese, Bd. 136, 2003, S. 31–56', 'Steven French; James Ladyman: Remodelling Structural Realism: Quantum Physics and the Metaphysics of Structure', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:46', '2026-08-09 08:05:46'),
(52, 52, 'ch31-052-mary-b-hesse-models-and-analogies-in-science', 'book', 'Models and Analogies in Science', NULL, NULL, 1963, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Mary B. Hesse: Models and Analogies in Science. London: Sheed and Ward, 1963', 'Mary B. Hesse: Models and Analogies in Science', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(53, 53, 'ch31-053-ronald-n-giere-explaining-science-a-cognitive-appr', 'book', 'Explaining Science. A Cognitive Approach', NULL, NULL, 1988, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Ronald N. Giere: Explaining Science. A Cognitive Approach. Chicago: University of Chicago Press, 1988', 'Ronald N. Giere: Explaining Science. A Cognitive Approach', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(54, 54, 'ch31-054-patrick-suppes-a-comparison-of-the-meaning-and-use', 'journal_article', 'A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences', NULL, NULL, 1960, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Patrick Suppes: A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences. In: Synthese, Bd. 12, 1960, S. 287–301', 'Patrick Suppes: A Comparison of the Meaning and Uses of Models in Mathematics and the Empirical Sciences', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(55, 55, 'ch31-055-alfred-tarski-the-concept-of-truth-in-formalized-', 'journal_article', 'The Concept of Truth in Formalized Languages', NULL, NULL, 1933, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Alfred Tarski: The Concept of Truth in Formalized Languages. In: Logic, Semantics, Metamathematics. Oxford: Clarendon Press, 1956, S. 152–278; polnische Erstveröffentlichung 1933', 'Alfred Tarski: The Concept of Truth in Formalized Languages', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(56, 56, 'ch31-056-george-boole-an-investigation-of-the-laws-of-tho', 'historical_work', 'An Investigation of the Laws of Thought', NULL, NULL, 1854, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4.1', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'George Boole: An Investigation of the Laws of Thought. London: Walton and Maberly, 1854', 'George Boole: An Investigation of the Laws of Thought', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(57, 57, 'ch31-057-giuseppe-peano-arithmetices-principia-nova-methodo', 'historical_work', 'Arithmetices principia, nova methodo exposita', NULL, NULL, 1889, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4.1', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Giuseppe Peano: Arithmetices principia, nova methodo exposita. Turin: Bocca, 1889', 'Giuseppe Peano: Arithmetices principia, nova methodo exposita', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(58, 58, 'ch31-058-alfred-north-whitehead-principia-mathematica', 'book', 'Principia Mathematica', NULL, NULL, 1913, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4.1', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Alfred North Whitehead; Bertrand Russell: Principia Mathematica. Cambridge: Cambridge University Press, 1910–1913', 'Alfred North Whitehead; Bertrand Russell: Principia Mathematica', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(59, 59, 'ch31-059-david-hilbert-grundlagen-der-geometrie', 'historical_work', 'Grundlagen der Geometrie', NULL, NULL, 1899, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4.1', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'David Hilbert: Grundlagen der Geometrie. Leipzig: Teubner, 1899', 'David Hilbert: Grundlagen der Geometrie', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47');
INSERT INTO `sources` (`source_id`, `citation_number`, `source_key`, `source_type`, `title`, `subtitle`, `year_original`, `year_edition`, `journal`, `publisher`, `place`, `volume`, `issue`, `pages`, `edition`, `doi`, `isbn`, `url`, `language_code`, `priority`, `evidence_type`, `frzk_relevance`, `verification_status`, `first_citation_section_code`, `first_citation_note`, `full_citation_text`, `short_citation_text`, `notes`, `created_revision_id`, `created_at`, `updated_at`) VALUES
(60, 60, 'ch31-060-georg-cantor-beitrage-zur-begrundung-der-transfi', 'historical_work', 'Beiträge zur Begründung der transfiniten Mengenlehre', NULL, NULL, 1897, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.4.1', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Georg Cantor: Beiträge zur Begründung der transfiniten Mengenlehre. Leipzig: Teubner, 1895–1897', 'Georg Cantor: Beiträge zur Begründung der transfiniten Mengenlehre', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(61, 61, 'ch31-061-saunders-mac-lane-mathematics-form-and-function', 'book', 'Mathematics: Form and Function', NULL, NULL, 1986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.5', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Saunders Mac Lane: Mathematics: Form and Function. New York: Springer, 1986', 'Saunders Mac Lane: Mathematics: Form and Function', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(62, 62, 'ch31-062-samuel-eilenberg-general-theory-of-natural-equivalen', 'journal_article', 'General Theory of Natural Equivalences', NULL, NULL, 1945, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.5', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Samuel Eilenberg; Saunders Mac Lane: „General Theory of Natural Equivalences“. In: Transactions of the American Mathematical Society, Band 58, 1945, S. 231–294', 'Samuel Eilenberg; Saunders Mac Lane: General Theory of Natural Equivalences', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(63, 63, 'ch31-063-gottlob-frege-die-grundlagen-der-arithmetik-eine-', 'historical_work', 'Die Grundlagen der Arithmetik. Eine logisch mathematische Untersuchung über den Begriff der Zahl', NULL, NULL, 1884, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.6', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Gottlob Frege: Die Grundlagen der Arithmetik. Eine logisch mathematische Untersuchung über den Begriff der Zahl. Breslau: Wilhelm Koebner, 1884', 'Gottlob Frege: Die Grundlagen der Arithmetik. Eine logisch mathematische Untersuchung über den Begriff der Zahl', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(64, 64, 'ch31-064-ludwig-von-bertalanffy-general-system-theory-foundations-d', 'book', 'General System Theory. Foundations, Development, Applications', NULL, NULL, 1968, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.6', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Ludwig von Bertalanffy: General System Theory. Foundations, Development, Applications. New York: George Braziller, 1968', 'Ludwig von Bertalanffy: General System Theory. Foundations, Development, Applications', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(65, 65, 'ch31-065-norbert-wiener-cybernetics-or-control-and-communic', 'book', 'Cybernetics or Control and Communication in the Animal and the Machine', NULL, NULL, 1948, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.6', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Norbert Wiener: Cybernetics or Control and Communication in the Animal and the Machine. Paris: Hermann & Cie; Cambridge, Massachusetts: MIT Press, 1948', 'Norbert Wiener: Cybernetics or Control and Communication in the Animal and the Machine', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(66, 66, 'ch31-066-w-ross-ashby-an-introduction-to-cybernetics', 'book', 'An Introduction to Cybernetics', NULL, NULL, 1956, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.6', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'W. Ross Ashby: An Introduction to Cybernetics. London: Chapman & Hall, 1956', 'W. Ross Ashby: An Introduction to Cybernetics', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(67, 67, 'ch31-067-michael-d-resnik-mathematics-as-a-science-of-pattern', 'book', 'Mathematics as a Science of Patterns', NULL, NULL, 1997, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.6', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Michael D. Resnik: Mathematics as a Science of Patterns. Oxford: Clarendon Press, 1997', 'Michael D. Resnik: Mathematics as a Science of Patterns', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(68, 68, 'ch31-068-stewart-shapiro-philosophy-of-mathematics-structure', 'book', 'Philosophy of Mathematics. Structure and Ontology', NULL, NULL, 1997, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.6', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Stewart Shapiro: Philosophy of Mathematics. Structure and Ontology. New York: Oxford University Press, 1997', 'Stewart Shapiro: Philosophy of Mathematics. Structure and Ontology', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(69, 69, 'ch31-069-heinz-von-foerster-observing-systems', 'book', 'Observing Systems', NULL, NULL, 1981, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.6', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Heinz von Foerster: Observing Systems. Seaside, Kalifornien: Intersystems Publications, 1981', 'Heinz von Foerster: Observing Systems', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(70, 70, 'ch31-070-niklas-luhmann-soziale-systeme-grundri-einer-allge', 'book', 'Soziale Systeme. Grundriß einer allgemeinen Theorie', NULL, NULL, 1984, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 3, 'secondary', 5, 'needs_review', '3.1.6', 'Vollständige bibliografische Angabe bei Erstnennung im bereinigten Kapiteltext. Originalquellentext/Belegabsatz wurde nicht bereitgestellt; daher keine wörtliche Passage in die DB übernommen.', 'Niklas Luhmann: Soziale Systeme. Grundriß einer allgemeinen Theorie. Frankfurt am Main: Suhrkamp, 1984', 'Niklas Luhmann: Soziale Systeme. Grundriß einer allgemeinen Theorie', 'Keine verifizierte Fundstelle eingetragen. Konkrete Belegstellen dürfen ausschließlich aus der tatsächlich recherchierten Literaturquelle stammen.', 1, '2026-08-09 08:05:47', '2026-08-09 08:05:47'),
(71, 71, 'enderton_elements_set_theory_1977', 'book', 'Elements of Set Theory', NULL, 1977, 1977, NULL, 'Academic Press', 'New York; San Francisco; London', NULL, NULL, NULL, '1st Edition', NULL, '0-12-238440-7', NULL, 'en', 1, 'textbook', 9, 'verified', '3.2.1', 'Erstnennung zur systematischen mengentheoretischen Einordnung von Mengenoperationen, geordneten Paaren, Relationen, Funktionen, Äquivalenzrelationen und Ordnungsrelationen.', 'Enderton, Herbert B.: Elements of Set Theory. New York, San Francisco und London: Academic Press, 1977. ISBN 0-12-238440-7.', 'Enderton, Elements of Set Theory [71]', 'Bibliografische Angaben an Titel- und Copyrightseite der Ausgabe von 1977 verifiziert. Inhalts- und Belegstellen in Kapitel 2, Kapitel 3 und Kapitel 7 anhand der zugänglichen Ausgabe geprüft.', 3, '2026-08-12 12:45:51', '2026-08-12 12:45:51'),
(72, 72, 'strang_introduction_linear_algebra_5e_2016', 'book', 'Introduction to Linear Algebra', NULL, 1993, 2016, NULL, 'Wellesley-Cambridge Press', 'Wellesley, Massachusetts', NULL, NULL, NULL, 'Fifth Edition', NULL, '978-0-9802327-7-6', NULL, 'en', 1, 'textbook', 9, 'verified', '3.2.3', 'Erstnennung zur strukturellen Einführung von Vektorräumen, Unterräumen und der später benötigten Basis-/Dimensionsstruktur.', 'Strang, Gilbert: Introduction to Linear Algebra. Fifth Edition. Wellesley, Massachusetts: Wellesley-Cambridge Press, 2016. ISBN 978-0-9802327-7-6.', 'Strang, Introduction to Linear Algebra, 5th ed. (2016) [72]', 'Bibliografische Kerndaten und Inhaltsstruktur an der offiziellen MIT-Seite zur fünften Auflage verifiziert. Für 3.2.3 relevant: §1.1 ab S. 2; §3.1 S. 123-134; §3.4 ab S. 164; §9.1 ab S. 431.', 5, '2026-08-12 13:16:23', '2026-08-12 13:16:23'),
(73, 73, 'conway_course_functional_analysis_2e_1990', 'book', 'A Course in Functional Analysis', NULL, NULL, 1990, NULL, 'Springer-Verlag', 'New York', '96', NULL, NULL, 'Second Edition', '10.1007/978-1-4757-4383-8', '978-0-387-97245-9', NULL, 'en', 1, 'textbook', 9, 'verified', '3.2.7', 'Erstnennung zur funktionalanalytischen Grundlegung von Hilbert- und Banachraumstrukturen, insbesondere Skalarprodukt, Norm und Vollständigkeitskontext.', 'Conway, John B.: A Course in Functional Analysis. Second Edition. Graduate Texts in Mathematics 96. New York: Springer-Verlag, 1990. ISBN 978-0-387-97245-9.', 'Conway, A Course in Functional Analysis, 2nd ed. (1990) [73]', 'Bibliografische Angaben über Springer verifiziert. Für 3.2.7 verwendete Fundstellen: \"Hilbert Spaces\", S. 1-25; \"Banach Spaces\", S. 63-98. DOI 10.1007/978-1-4757-4383-8.', 9, '2026-08-13 00:59:20', '2026-08-13 00:59:20'),
(74, 74, 'munkres_topology_2e_2000', 'book', 'Topology', NULL, NULL, 2000, NULL, 'Prentice Hall', 'Upper Saddle River, New Jersey', NULL, NULL, NULL, 'Second Edition', NULL, '0-13-181629-2', NULL, 'en', 1, 'textbook', 9, 'verified', '3.2.8', 'Erstnennung zur allgemeinen Topologie, insbesondere zu topologischen Räumen, Basen, abgeschlossenen Mengen, Stetigkeit und metrisch induzierten Topologien.', 'Munkres, James R.: Topology. Second Edition. Upper Saddle River, New Jersey: Prentice Hall, 2000. ISBN 0-13-181629-2.', 'Munkres, Topology, 2nd ed. (2000) [74]', 'Bibliografische Angaben und einschlägige Gliederungsstellen verifiziert. Für 3.2.8 verwendet: §§12, 13, 17, 18, 20 und 21. Keine ungesicherten Seitenzahlen als Fundstelle eingetragen.', 10, '2026-08-13 01:33:34', '2026-08-13 01:33:34'),
(75, 76, 'teschl_ordinary_differential_equations_dynamical_systems_2012', 'book', 'Ordinary Differential Equations and Dynamical Systems', NULL, NULL, 2012, NULL, 'American Mathematical Society', 'Providence, Rhode Island', '140', NULL, '356', NULL, NULL, '978-0-8218-8328-0', NULL, 'en', 1, 'textbook', 9, 'verified', '3.2.16', 'Erstnennung zur Grundlegung gewöhnlicher Differentialgleichungen, Anfangswertprobleme, Existenz, Eindeutigkeit, Fortsetzbarkeit und stetiger Abhängigkeit von Anfangsdaten.', 'Teschl, Gerald: Ordinary Differential Equations and Dynamical Systems. Graduate Studies in Mathematics 140. Providence, Rhode Island: American Mathematical Society, 2012. ISBN 978-0-8218-8328-0.', 'Teschl, Ordinary Differential Equations and Dynamical Systems (2012) [76]', 'Bibliografische Angaben gegen die American Mathematical Society verifiziert. Die AMS beschreibt als grundlegende Inhalte des Anfangswertproblems insbesondere Existenz, Eindeutigkeit, Fortsetzbarkeit und Abhängigkeit von Anfangsdaten. exact_location bleibt mangels unmittelbar verifizierter Seitenangabe leer.', 17, '2026-08-13 14:37:48', '2026-08-13 14:37:48'),
(76, 77, 'evans_partial_differential_equations_2e_2010', 'book', 'Partial Differential Equations', NULL, NULL, 2010, NULL, 'American Mathematical Society', 'Providence, Rhode Island', '19', NULL, '749', 'Second Edition', NULL, '978-0-8218-4974-3', NULL, 'en', 1, 'textbook', 9, 'verified', '3.2.16', 'Erstnennung zur Grundlegung partieller Differentialgleichungen, klassischen Lösungen, Anfangs- und Randbedingungen sowie Wohlgestelltheit von Differentialproblemen.', 'Evans, Lawrence C.: Partial Differential Equations. Second Edition. Graduate Studies in Mathematics 19. Providence, Rhode Island: American Mathematical Society, 2010. ISBN 978-0-8218-4974-3.', 'Evans, Partial Differential Equations, 2nd ed. (2010) [77]', 'Bibliografische Angaben der zweiten Ausgabe gegen die American Mathematical Society verifiziert. exact_location bleibt mangels unmittelbar verifizierter Seiten- oder Kapitelangabe leer.', 17, '2026-08-13 14:37:48', '2026-08-13 14:37:48'),
(77, 78, 'lee_introduction_smooth_manifolds_2e_2012', 'book', 'Introduction to Smooth Manifolds', NULL, 2003, 2012, NULL, 'Springer', 'New York', '218', NULL, 'XVI, 708', 'Second Edition', '10.1007/978-1-4419-9982-5', '978-1-4419-9981-8', NULL, 'en', 1, 'textbook', 10, 'verified', '3.2.20', 'Erstnennung zur Einführung glatter Mannigfaltigkeiten, glatter Abbildungen, Tangentialvektoren, Tangentialräume, Differentiale und Tangentialbündel.', 'Lee, John M.: Introduction to Smooth Manifolds. Second Edition. Graduate Texts in Mathematics 218. New York: Springer, 2012. ISBN 978-1-4419-9981-8. DOI 10.1007/978-1-4419-9982-5.', 'Lee, Introduction to Smooth Manifolds, 2nd ed. (2012) [78]', 'Bibliografische Angaben und Edition über Springer Nature verifiziert. Verwendete Kapitel: \"Smooth Manifolds\", S. 1-31; \"Smooth Maps\", S. 32-49; \"Tangent Vectors\", S. 50-76. Springer weist die erste Ausgabe als 2003 und die zweite Ausgabe mit Copyright 2012 aus.', 21, '2026-08-14 14:12:37', '2026-08-14 14:12:37'),
(78, 79, 'oneill_semi_riemannian_geometry_relativity_1983', 'book', 'Semi-Riemannian Geometry With Applications to Relativity', NULL, 1983, 1983, NULL, 'Academic Press', 'New York', '103', NULL, 'xiii+468', 'First Edition', NULL, '978-0-12-526740-3', NULL, 'en', 1, 'textbook', 10, 'verified', '3.2.21', 'Erstnennung zur Grundlegung semi-/pseudo-riemannscher Metriken beliebiger Signatur, riemannscher und lorentzscher Spezialfälle, metrischer Vektorklassifikation sowie Isometrien.', 'O\'Neill, Barrett: Semi-Riemannian Geometry With Applications to Relativity. Pure and Applied Mathematics 103. Academic Press, 1983. ISBN 978-0-12-526740-3.', 'O\'Neill, Semi-Riemannian Geometry With Applications to Relativity (1983) [79]', 'Edition, Band, Jahr, Autor und ISBN gegen Elsevier verifiziert. Verifizierte Fundstellen: Chapter 3 \"Semi-Riemannian Manifolds\", S. 54-96; Chapter 5 \"Riemannian and Lorentz Geometry\", S. 126-157. Der Kapitelname \"Isometries\" ist im Elsevier-Inhaltsverzeichnis bestätigt; hierfür wird keine ungesicherte Seitenangabe gespeichert.', 23, '2026-08-14 14:31:45', '2026-08-14 14:31:45');

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
(5, 5, 1, 'author'),
(6, 6, 1, 'author'),
(7, 7, 1, 'author'),
(8, 8, 1, 'author'),
(9, 9, 1, 'author'),
(10, 10, 1, 'author'),
(11, 11, 1, 'author'),
(12, 12, 1, 'author'),
(12, 13, 2, 'author'),
(13, 14, 1, 'author'),
(14, 15, 1, 'author'),
(15, 16, 1, 'author'),
(16, 17, 1, 'author'),
(17, 18, 1, 'author'),
(18, 19, 1, 'author'),
(19, 20, 1, 'author'),
(20, 21, 1, 'author'),
(21, 21, 1, 'author'),
(22, 22, 1, 'author'),
(23, 23, 1, 'author'),
(24, 24, 1, 'author'),
(25, 25, 1, 'author'),
(26, 26, 1, 'author'),
(27, 2, 1, 'author'),
(28, 27, 1, 'author'),
(29, 28, 1, 'author'),
(30, 29, 1, 'author'),
(31, 30, 1, 'author'),
(31, 31, 2, 'author'),
(32, 32, 1, 'author'),
(33, 33, 1, 'author'),
(34, 34, 1, 'author'),
(35, 35, 1, 'author'),
(36, 36, 1, 'author'),
(36, 37, 2, 'author'),
(36, 38, 3, 'author'),
(36, 39, 4, 'author'),
(37, 40, 1, 'author'),
(38, 41, 1, 'author'),
(38, 42, 2, 'author'),
(39, 43, 1, 'author'),
(40, 44, 1, 'author'),
(41, 45, 1, 'author'),
(42, 46, 1, 'author'),
(43, 47, 1, 'author'),
(44, 48, 1, 'author'),
(45, 49, 1, 'author'),
(46, 50, 1, 'author'),
(47, 51, 1, 'author'),
(48, 52, 1, 'author'),
(49, 53, 1, 'author'),
(50, 54, 1, 'author'),
(51, 55, 1, 'author'),
(51, 54, 2, 'author'),
(52, 56, 1, 'author'),
(53, 57, 1, 'author'),
(54, 58, 1, 'author'),
(55, 59, 1, 'author'),
(56, 60, 1, 'author'),
(57, 61, 1, 'author'),
(58, 17, 1, 'author'),
(58, 16, 2, 'author'),
(59, 62, 1, 'author'),
(60, 63, 1, 'author'),
(61, 64, 1, 'author'),
(62, 65, 1, 'author'),
(62, 64, 2, 'author'),
(63, 66, 1, 'author'),
(64, 67, 1, 'author'),
(65, 68, 1, 'author'),
(66, 69, 1, 'author'),
(67, 70, 1, 'author'),
(68, 71, 1, 'author'),
(69, 72, 1, 'author'),
(70, 73, 1, 'author'),
(71, 74, 1, 'author'),
(72, 75, 1, 'author'),
(73, 76, 1, 'author'),
(74, 77, 1, 'author'),
(75, 78, 1, 'author'),
(76, 79, 1, 'author'),
(77, 80, 1, 'author'),
(78, 81, 1, 'author');

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
  `source_excerpt` longtext DEFAULT NULL,
  `source_excerpt_language` char(2) DEFAULT NULL,
  `source_excerpt_translation` longtext DEFAULT NULL,
  `is_first_mention` tinyint(1) NOT NULL DEFAULT 0,
  `citation_checked` tinyint(1) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_revision_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `source_usage`
--

INSERT INTO `source_usage` (`usage_id`, `source_id`, `section_id`, `usage_type`, `claim_summary`, `exact_location`, `source_excerpt`, `source_excerpt_language`, `source_excerpt_translation`, `is_first_mention`, `citation_checked`, `notes`, `created_revision_id`) VALUES
(1, 1, 2, 'first_citation', 'Die Frage nach der Natur von Raum und Zeit gehört zu den ältesten und zugleich grundlegendsten Fragestellungen der Naturwissenschaften. Seit Jahrhunderten versuchen Philosophie, Mathematik und Physik zu erklären, ob Raum und Zeit eigenständige Entitäten darstellen, lediglich Beziehungen zwischen Objekten beschreiben oder als Folge tieferliegender physikalischer Prozesse entstehen. Trotz der außerordentlichen Erfolge moderner Theorien existiert bis heute keine allgemein akzeptierte Beschreibung, welche die unterschiedlichen Ansätze in einem gemeinsamen theoretischen Rahmen zusammenführt. Insbesondere bleibt offen, welche minimalen Voraussetzungen erfüllt sein müssen, damit Raum und Zeit überhaupt mathematisch beschrieben werden können', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(2, 2, 2, 'first_citation', 'Die Frage nach der Natur von Raum und Zeit gehört zu den ältesten und zugleich grundlegendsten Fragestellungen der Naturwissenschaften. Seit Jahrhunderten versuchen Philosophie, Mathematik und Physik zu erklären, ob Raum und Zeit eigenständige Entitäten darstellen, lediglich Beziehungen zwischen Objekten beschreiben oder als Folge tieferliegender physikalischer Prozesse entstehen. Trotz der außerordentlichen Erfolge moderner Theorien existiert bis heute keine allgemein akzeptierte Beschreibung, welche die unterschiedlichen Ansätze in einem gemeinsamen theoretischen Rahmen zusammenführt. Insbesondere bleibt offen, welche minimalen Voraussetzungen erfüllt sein müssen, damit Raum und Zeit überhaupt mathematisch beschrieben werden können', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(3, 3, 2, 'first_citation', 'Die Frage nach der Natur von Raum und Zeit gehört zu den ältesten und zugleich grundlegendsten Fragestellungen der Naturwissenschaften. Seit Jahrhunderten versuchen Philosophie, Mathematik und Physik zu erklären, ob Raum und Zeit eigenständige Entitäten darstellen, lediglich Beziehungen zwischen Objekten beschreiben oder als Folge tieferliegender physikalischer Prozesse entstehen. Trotz der außerordentlichen Erfolge moderner Theorien existiert bis heute keine allgemein akzeptierte Beschreibung, welche die unterschiedlichen Ansätze in einem gemeinsamen theoretischen Rahmen zusammenführt. Insbesondere bleibt offen, welche minimalen Voraussetzungen erfüllt sein müssen, damit Raum und Zeit überhaupt mathematisch beschrieben werden können', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(4, 4, 3, 'first_citation', 'Diese Schwierigkeit wurde früh in der europäischen Philosophie erkannt. Parmenides bestreitet, dass das Nichtseiende gedacht oder sprachlich bestimmt werden könne. Denken und Sein sind in seiner Argumentation so eng miteinander verbunden, dass nur das Seiende zum Gegenstand rationaler Erkenntnis werden kann. Das Nichtsein kann weder erkannt noch widerspruchsfrei ausgesprochen werden  Unabhängig davon, ob diese ontologische Position vollständig übernommen wird, enthält sie einen für die vorliegende Untersuchung entscheidenden Hinweis: Sobald über das Nichts gesprochen wird, ist es bereits in einen Zusammenhang des Denkens, Unterscheidens und Bezeichnens eingebunden.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(5, 5, 3, 'first_citation', 'In der modernen Physik wird der Begriff des Nichts häufig mit dem Vakuum verbunden. Ein physikalisches Vakuum ist jedoch kein absolutes Fehlen aller Strukturen. In der Quantenfeldtheorie bezeichnet es einen bestimmten Zustand eines bereits vorausgesetzten theoretischen Systems. Dieser Zustand besitzt definierte Eigenschaften, wird durch mathematische Größen charakterisiert und steht in Beziehung zu Feldern, Operatoren und möglichen Anregungen. Selbst der energetisch niedrigste Zustand eines Quantenfeldes setzt damit eine Zustandsstruktur, ein mathematisches Modell und Regeln seiner Entwicklung voraus  Das physikalische Vakuum kann deshalb nicht als voraussetzungsloses Nichts verstanden werden. Es ist vielmehr ein hochgradig strukturierter Grenz- oder Grundzustand innerhalb einer bereits bestehenden physikalischen Theorie.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(6, 6, 3, 'first_citation', 'Auch die Mathematik kennt kein Objekt, das mit einem absoluten Nichts gleichgesetzt werden könnte. Die leere Menge (\\emptyset) enthält zwar keine Elemente, ist aber selbst ein eindeutig definiertes mathematisches Objekt. Sie kann Element anderer Mengen sein, besitzt eine bestimmte Stellung innerhalb der Mengenhierarchie und erfüllt Aussagen, die aus einem Axiomensystem folgen. In der axiomatischen Mengenlehre ist sie nicht die Abwesenheit jeglicher Mathematik, sondern ein durch Axiome bestimmtes Objekt innerhalb einer mathematischen Theorie  Die leere Menge setzt somit bereits die Möglichkeit von Mengen, Identität, Zugehörigkeit und logischer Folgerung voraus.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(7, 4, 4, 'historical_context', 'Die frühe griechische Philosophie formuliert das Grundproblem zunächst als Verhältnis von Sein und Nichtsein. Parmenides schließt das Nichtseiende aus dem Bereich des Denkbaren aus und bindet Erkenntnis an das Seiende . Diese Position schützt das Denken vor der Annahme, aus einem vollständig eigenschaftslosen Nichts könne ohne weitere Voraussetzung etwas Bestimmtes hervorgehen. Für die Entwicklung des FRZK ist daran wesentlich, dass jede Beschreibung an eine Bestimmbarkeit gebunden wird. Zugleich führt die strikte Identifizierung von Denkbarem und Seiendem zu einer Schwierigkeit: Veränderung, Differenz und Entstehung lassen sich nur schwer erklären, wenn allein unveränderliches Sein als rational bestimmbar gilt.', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(8, 7, 4, 'first_citation', 'Platon versucht, diese Schwierigkeit durch eine differenziertere Bestimmung des Nichtseins zu überwinden. Im Sophistes erscheint das Nichtseiende nicht einfach als absolutes Gegenteil des Seins, sondern als Andersheit. Etwas ist nicht, insofern es von etwas anderem verschieden ist. Damit wird das Nichtsein relational bestimmt und in die Möglichkeit von Aussage, Unterschied und Erkenntnis integriert  Für meine Fragestellung ist dieser Schritt entscheidend. Der Unterschied wird nicht länger als bloßer Mangel behandelt, sondern als positive Bedingung dafür, dass Bestimmungen voneinander abgegrenzt werden können.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(9, 8, 4, 'first_citation', 'Aristoteles verlagert die Betrachtung stärker auf konkrete Dinge, Veränderungen und Beziehungen. Raum wird von ihm als Ort eines Körpers verstanden, während Zeit als Zahl beziehungsweise Maß der Bewegung hinsichtlich des Früher und Später bestimmt wird  Raum und Zeit erscheinen dadurch nicht als vollständig unabhängige Substanzen. Sie erhalten ihre Bedeutung im Zusammenhang mit Körpern, Bewegung, Veränderung und Ordnung.', 'Physics IV.11, Bekker 219b1–2', 'For time is just this—number of motion in respect of \'before\' and \'after.\'', 'en', NULL, 1, 1, 'Fundstelle und Fundtext anhand einer digital verfügbaren Übersetzung des Primärtextes von Aristoteles, Physics IV.11, verifiziert.', 1),
(10, 9, 4, 'first_citation', 'Plotin radikalisiert die Frage nach dem Ursprung der Vielheit. In seiner neuplatonischen Philosophie geht die Vielheit aus dem Einen hervor, das selbst jenseits aller bestimmten Vielheit und begrifflichen Unterscheidung liegt  Der Gedanke einer stufenweisen Hervorbringung von Einheit, Geist und geordneter Vielheit besitzt eine erkennbare Nähe zu späteren Emergenzvorstellungen. Struktur muss nicht von Anfang an vollständig vorhanden sein, sondern kann als Folge einer gestuften Entfaltung verstanden werden.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(11, 10, 4, 'first_citation', 'Nikolaus von Kues entwickelt mit der coincidentia oppositorum den Gedanken, dass Gegensätze in einem nicht endlichen Ursprung zusammenfallen können  Seine Überlegungen machen deutlich, dass menschliche Bestimmungen durch Unterschiede, Grenzen und Verhältnisse entstehen, während ein absoluter Ursprung nicht ohne Weiteres innerhalb derselben begrifflichen Ordnung erfasst werden kann. Damit verbindet sich eine erkenntnistheoretische Einsicht: Die Strukturen unserer Beschreibung dürfen nicht vorschnell mit der Struktur eines angenommenen Ursprungs gleichgesetzt werden.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(12, 11, 4, 'first_citation', 'Baruch de Spinoza fasst Wirklichkeit als eine einheitliche Substanz auf, deren Attribute und Modi keine voneinander unabhängigen Substanzen bilden, sondern Ausdrucksweisen derselben immanenten Ordnung sind  Für die funktionale Perspektive ist insbesondere die Abkehr von isolierten, ontologisch selbstständigen Dingen bedeutsam. Einzelne Entitäten sind nur innerhalb eines umfassenden Zusammenhangs bestimmbar. Ihre Eigenschaften ergeben sich nicht vollständig aus ihnen selbst, sondern aus der Ordnung, in der sie stehen.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(13, 12, 4, 'first_citation', 'Gottfried Wilhelm Leibniz entwickelt eine ausdrücklich relationale Auffassung von Raum und Zeit. Raum bezeichnet für ihn die Ordnung des Zugleichseins, Zeit die Ordnung des Nacheinanders. Beide besitzen keine von den Dingen unabhängige substantielle Existenz, sondern entstehen aus ihren Relationen  Diese Position kommt der Fragestellung des FRZK näher als die Annahme eines absoluten räumlichen und zeitlichen Behälters. Raum und Zeit werden als Ordnungsformen verstanden, die nicht ohne die relationierten Zustände bestehen.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(14, 13, 4, 'first_citation', 'Immanuel Kant verschiebt die Fragestellung von der Ontologie zur Bedingung möglicher Erfahrung. Raum und Zeit sind in seiner transzendentalen Ästhetik keine Eigenschaften der Dinge an sich, sondern reine Formen der sinnlichen Anschauung. Sie strukturieren jede mögliche äußere und innere Erfahrung, bevor einzelne Gegenstände empirisch erkannt werden können  Kant zeigt damit, dass wissenschaftliche Beschreibung nicht nur von einer angenommenen äußeren Realität abhängt, sondern ebenso von den Formen, unter denen ein erkennendes Subjekt überhaupt Gegenstände erfahren kann.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(15, 14, 4, 'first_citation', 'Georg Wilhelm Friedrich Hegel versteht Bestimmungen nicht als isolierte Einheiten, sondern als Momente eines Prozesses, in dem Identität durch Negation, Unterschied und Vermittlung entsteht. In der Wissenschaft der Logik wird das reine Sein wegen seiner vollständigen Bestimmungslosigkeit unmittelbar mit dem Nichts verbunden; ihre Wahrheit liegt im Werden  Diese Denkbewegung berührt den Ausgangspunkt von Abschnitt 3.1.1 unmittelbar. Ein vollständig bestimmungsloses Sein lässt sich nicht von einem vollständig bestimmungslosen Nichts unterscheiden. Erst der Übergang beziehungsweise die Vermittlung erzeugt eine bestimmtere Struktur.', 'Wissenschaft der Logik I, Erstes Buch, Erster Abschnitt, Erstes Kapitel, C. Werden, 1. Einheit des Seyns und Nichts', 'Das reine Seyn und das reine Nichts ist also dasselbe.', 'de', NULL, 1, 1, 'Fundstelle und Fundtext direkt anhand der deutschsprachigen Primärtextausgabe bei Project Gutenberg verifiziert.', 1),
(16, 15, 4, 'first_citation', 'Bertrand Russell und die Entwicklung der modernen Logik verschieben die Aufmerksamkeit auf die formale Struktur von Aussagen und Relationen. Russell kritisiert die Auffassung, Relationen ließen sich vollständig auf intrinsische Eigenschaften einzelner Gegenstände reduzieren. In seiner relationalen Logik erhalten mehrstellige Beziehungen einen eigenständigen formalen Status  Damit wird eine entscheidende Voraussetzung funktionaler Beschreibung präzisiert: Nicht nur die Elemente eines Systems, sondern auch die Struktur ihrer Verknüpfung muss formal darstellbar sein.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(17, 16, 4, 'first_citation', 'Alfred North Whitehead entwickelt demgegenüber eine ausgeprägte Prozessontologie. Die grundlegenden Einheiten der Wirklichkeit sind für ihn keine dauerhaft bestehenden Substanzen, sondern Ereignisse beziehungsweise „actual occasions“, die in Prozessen des Werdens miteinander verbunden sind. Ein konkretes Geschehen entsteht durch die Aufnahme und Integration vorheriger Ereignisse in eine neue Einheit  Whitehead ersetzt damit das Primat des Objekts durch das Primat des Prozesses und der Relation.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(18, 17, 4, 'first_citation', 'Edmund Husserl untersucht Zeit nicht primär als physikalische Größe, sondern als Struktur des Bewusstseins. Die Wahrnehmung eines zeitlich ausgedehnten Vorgangs setzt ein Zusammenspiel von unmittelbarem Eindruck, Retention des gerade Vergangenen und Protention des Erwarteten voraus (Edmund Husserl: Zur Phänomenologie des inneren Zeitbewusstseins (1893–1917), Husserliana, Band X, herausgegeben von Rudolf Boehm, Den Haag: Martinus Nijhoff, 1966).  Zeitliche Ordnung erscheint damit nicht als Folge isolierter Jetztpunkte, sondern als relationale Struktur, in der Gegenwart nur durch ihre Verbindung zu Nicht-mehr und Noch-nicht bestimmt werden kann.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(19, 18, 4, 'first_citation', 'Ernst Cassirer erweitert die relationale Perspektive zu einer Philosophie symbolischer Formen. Wissenschaftliche Gegenstände werden nicht einfach passiv vorgefunden, sondern durch symbolische und begriffliche Ordnungen bestimmt. Besonders in der modernen Wissenschaft tritt nach Cassirer an die Stelle des Substanzbegriffs zunehmend der Funktionsbegriff  Ein Gegenstand wird danach nicht ausschließlich durch ihm innewohnende Eigenschaften bestimmt, sondern durch seine Stellung in einer systematischen Ordnung von Relationen.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(20, 19, 4, 'first_citation', 'Martin Heidegger kritisiert die traditionelle Behandlung der Zeit als Abfolge vorhandener Jetztpunkte. In Sein und Zeit wird Zeitlichkeit aus der Struktur des Daseins und seiner auf Zukunft, Gewesenheit und Gegenwart bezogenen Existenz interpretiert  Damit wird sichtbar, dass verschiedene Zeitbegriffe unterschiedliche Ebenen betreffen können: messbare Zeit, erlebte Zeit, historische Zeit und existentielle Zeitlichkeit sind nicht ohne Weiteres identisch.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(21, 20, 4, 'first_citation', 'Ludwig Wittgenstein lenkt die Aufmerksamkeit auf die Bedingungen sinnvoller Aussagen. Im Tractatus logico-philosophicus wird die Welt als Gesamtheit von Tatsachen und nicht von Dingen bestimmt; Aussagen erhalten Bedeutung durch ihre logische Struktur und ihre mögliche Beziehung zu Sachverhalten  In den späteren Philosophischen Untersuchungen wird Bedeutung stärker an den regelgeleiteten Gebrauch innerhalb von Sprachspielen gebunden', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(22, 21, 4, 'first_citation', 'Ludwig Wittgenstein lenkt die Aufmerksamkeit auf die Bedingungen sinnvoller Aussagen. Im Tractatus logico-philosophicus wird die Welt als Gesamtheit von Tatsachen und nicht von Dingen bestimmt; Aussagen erhalten Bedeutung durch ihre logische Struktur und ihre mögliche Beziehung zu Sachverhalten  In den späteren Philosophischen Untersuchungen wird Bedeutung stärker an den regelgeleiteten Gebrauch innerhalb von Sprachspielen gebunden', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(23, 22, 4, 'first_citation', 'Rudolf Carnap versucht, wissenschaftliche Begriffe innerhalb expliziter formaler Systeme zu rekonstruieren. In Der logische Aufbau der Welt soll ein System wissenschaftlicher Gegenstände aus einer begrenzten Basis und definierten Konstruktionsregeln aufgebaut werden  Dieser konstruktive Anspruch ist für die Methodik des FRZK besonders wichtig. Begriffe sollen nicht nur erläutert, sondern hinsichtlich ihrer Abhängigkeit von einfacheren Voraussetzungen nachvollziehbar aufgebaut werden.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(24, 23, 4, 'first_citation', 'George Spencer-Brown stellt mit dem Begriff der Unterscheidung eine besonders direkte Verbindung zur Ausgangsfrage her. In Laws of Form beginnt die formale Konstruktion mit der Aufforderung, eine Unterscheidung zu treffen. Durch das Ziehen einer Grenze entstehen eine markierte und eine unmarkierte Seite, auf deren Grundlage weitere Operationen aufgebaut werden können  Die Unterscheidung fungiert damit nicht bloß als Eigenschaft bereits bestehender Objekte, sondern als elementare Operation der Formbildung.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(25, 24, 4, 'first_citation', 'Luciano Floridi entwickelt eine Philosophie der Information, in der Wirklichkeit und Erkenntnis zunehmend unter dem Gesichtspunkt informationeller Strukturen und Relationen untersucht werden. Seine Philosophy of Information bestimmt Information nicht lediglich als technische Größe der Nachrichtenübertragung, sondern als grundlegenden Gegenstand philosophischer Analyse  Für das FRZK ist besonders bedeutsam, dass Information ohne Unterschiede und strukturierte Beziehungen nicht denkbar ist.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(26, 25, 4, 'first_citation', 'Michel Bitbol untersucht die erkenntnistheoretischen Voraussetzungen moderner Physik und betont, dass wissenschaftliche Theorien nicht unabhängig von den Bedingungen ihrer Formulierung, Anwendung und experimentellen Bestätigung verstanden werden können  Seine reflektierende Perspektive mahnt zur Zurückhaltung gegenüber direkten ontologischen Schlüssen aus mathematischen Formalismen. Ein erfolgreiches Modell muss nicht automatisch die Wirklichkeit so darstellen, wie sie unabhängig von jeder möglichen Erkenntnissituation beschaffen ist.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(27, 1, 5, 'historical_context', 'Die klassische Mechanik bietet hierfür den deutlichsten Ausgangspunkt. Isaac Newton unterscheidet in den Principia Mathematica zwischen relativen, messbaren Größen und einem absoluten Raum sowie einer absoluten Zeit, die unabhängig von Körpern, Beobachtern und konkreten Bewegungen bestehen  Die absolute Zeit vergeht nach dieser Auffassung gleichförmig, während der absolute Raum unverändert bleibt. Physikalische Körper bewegen sich innerhalb dieses vorgegebenen Bezugsrahmens, ohne dessen Struktur selbst hervorzubringen oder wesentlich zu verändern.', 'Principia, Definitions, Scholium, I–II; Project Gutenberg edition, p. 77', 'Absolute space, in its own nature, without regard to anything external, remains always similar and immovable.', 'en', NULL, 0, 1, 'Fundstelle und Fundtext direkt anhand der digital verfügbaren Primärquelle (Project Gutenberg, Newton, Principia) verifiziert.', 1),
(28, 26, 5, 'first_citation', 'Ernst Mach richtet seine Kritik genau gegen diese Trennung physikalischer Vorgänge von einem unbeobachtbaren absoluten Hintergrund. Nach seiner Auffassung besitzen nur Beziehungen zwischen wahrnehmbaren Körpern physikalische Bedeutung. Trägheit und Bewegung sollen nicht gegenüber einem abstrakten absoluten Raum bestimmt werden, sondern relativ zur Gesamtheit materieller Körper  Diese relationale Verschiebung erscheint mir für die weitere Entwicklung besonders bedeutsam. Raum verliert seinen Status als vollständig unabhängiger Behälter und wird stärker an die Ordnung physikalischer Beziehungen gebunden.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(29, 27, 5, 'first_citation', 'Einen grundlegenden Bruch mit der klassischen Auffassung vollzieht Albert Einstein in der Speziellen Relativitätstheorie. Ausgehend von der Konstanz der Lichtgeschwindigkeit und der Gleichwertigkeit inertialer Bezugssysteme zeigt er, dass räumliche und zeitliche Abstände nicht unabhängig vom Bewegungszustand des Beobachters bestimmt werden können  Gleichzeitigkeit verliert dadurch ihren absoluten Charakter. Zwei Ereignisse, die in einem Bezugssystem gleichzeitig erscheinen, müssen in einem relativ dazu bewegten System nicht gleichzeitig sein.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(30, 28, 5, 'first_citation', 'Hermann Minkowski führt diese Erkenntnisse zu einer vierdimensionalen Raumzeit zusammen. Raum und Zeit bilden nicht länger zwei voneinander getrennte Bereiche, sondern unterschiedliche Komponenten einer gemeinsamen geometrischen Struktur  Diese Vereinigung verändert den physikalischen Begriff beider Größen grundlegend. Zeit ist nicht mehr ein äußerer Parameter, der unabhängig von räumlichen Beziehungen verläuft, und Raum ist nicht mehr eine starre dreidimensionale Bühne. Ereignisse werden vielmehr durch ihre Position innerhalb einer vierdimensionalen Struktur charakterisiert.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(31, 2, 5, 'historical_context', 'Mit der Allgemeinen Relativitätstheorie geht Einstein einen weiteren Schritt. Die Raumzeit ist nun nicht mehr nur der unveränderliche geometrische Hintergrund physikalischer Prozesse. Ihre Krümmung hängt von der Verteilung von Materie und Energie ab, während diese Krümmung wiederum die Bewegung physikalischer Systeme beeinflusst  Raumzeit wird damit selbst dynamisch. Gravitation erscheint nicht mehr als Kraft im newtonschen Sinn, sondern als Ausdruck der Geometrie.', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(32, 29, 5, 'first_citation', 'Dieser Übergang gehört aus meiner Sicht zu den wichtigsten wissenschaftlichen Veränderungen des Raumbegriffs. Der beschreibende Rahmen und die in ihm enthaltenen physikalischen Vorgänge sind nicht mehr vollständig voneinander getrennt. Geometrie wirkt auf Materie, und Materie wirkt auf Geometrie. Hermann Weyl arbeitet diese Verbindung zwischen Geometrie, Materie und physikalischen Feldern weiter aus und zeigt, wie eng moderne Raum-Zeit-Begriffe mit Symmetrien und Feldstrukturen verbunden sind', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(33, 30, 5, 'first_citation', 'Dennoch bleibt auch die Allgemeine Relativitätstheorie eine Theorie auf einer bereits mathematisch definierten Struktur. Sie setzt eine differenzierbare Mannigfaltigkeit, eine Metrik und weitere mathematische Voraussetzungen voraus, bevor ihre Feldgleichungen formuliert werden können. Die Metrik ist dynamisch, aber die Möglichkeit metrischer und differentialgeometrischer Beschreibung wird nicht selbst hergeleitet. Robert M. Wald macht in seiner systematischen Darstellung deutlich, dass die Theorie auf einer Lorentz-Mannigfaltigkeit aufgebaut wird, deren geometrische Eigenschaften anschließend mit der physikalischen Dynamik verbunden werden  Die Raumzeit ist somit nicht mehr starr, aber sie bleibt Bestandteil des theoretischen Ausgangsrahmens.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(34, 31, 5, 'first_citation', 'Die kosmologischen Anwendungen der Allgemeinen Relativitätstheorie verschärfen diese Frage. Modelle der großräumigen Struktur des Universums beschreiben Expansion, Gravitationskollaps und mögliche Singularitäten innerhalb einer dynamischen Raumzeit  Singularitätssätze zeigen unter bestimmten Voraussetzungen, dass die klassische Beschreibung an Grenzen gelangen kann, an denen geodätische Fortsetzbarkeit verloren geht. Solche Ergebnisse bedeuten nicht unmittelbar, dass Raum und Zeit aufhören zu existieren. Sie zeigen vielmehr, dass die verwendete klassische geometrische Beschreibung in extremen Situationen unvollständig werden kann.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(35, 32, 5, 'first_citation', 'Eine weitere grundlegende Veränderung ergibt sich mit der Quantenmechanik. Anders als in der klassischen Mechanik wird ein physikalischer Zustand nicht durch einen eindeutig bestimmten Ort und Impuls charakterisiert. Er wird durch einen Zustandsvektor beziehungsweise eine Wellenfunktion in einem Hilbertraum beschrieben. Messbare Größen werden durch Operatoren repräsentiert, und die möglichen Messergebnisse ergeben sich probabilistisch aus dem mathematischen Zustand  Paul A. M. Dirac entwickelt hierfür eine abstrakte Formulierung, in der Zustände, Observablen und Transformationen über lineare Strukturen miteinander verbunden werden', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(36, 33, 5, 'first_citation', 'Eine weitere grundlegende Veränderung ergibt sich mit der Quantenmechanik. Anders als in der klassischen Mechanik wird ein physikalischer Zustand nicht durch einen eindeutig bestimmten Ort und Impuls charakterisiert. Er wird durch einen Zustandsvektor beziehungsweise eine Wellenfunktion in einem Hilbertraum beschrieben. Messbare Größen werden durch Operatoren repräsentiert, und die möglichen Messergebnisse ergeben sich probabilistisch aus dem mathematischen Zustand  Paul A. M. Dirac entwickelt hierfür eine abstrakte Formulierung, in der Zustände, Observablen und Transformationen über lineare Strukturen miteinander verbunden werden', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(37, 5, 5, 'historical_context', 'Mit der Quantenfeldtheorie werden Quantenmechanik und Spezielle Relativitätstheorie verbunden. Fundamentale physikalische Größen werden nun als Felder beschrieben, deren Anregungen sich als Teilchen interpretieren lassen. Steven Weinberg zeigt in seiner systematischen Darstellung, dass die Struktur relativistischer Quantenfelder wesentlich durch Symmetrien, Lokalität und quantenmechanische Prinzipien bestimmt wird  Der physikalische Grundbegriff verschiebt sich damit erneut. Teilchen sind nicht mehr zwangsläufig elementare, dauerhaft bestehende Objekte, sondern können als Zustände beziehungsweise Anregungen zugrunde liegender Felder verstanden werden.', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(38, 34, 5, 'first_citation', 'Die Verbindung von Quantenmechanik und Allgemeiner Relativitätstheorie führt schließlich zu einem bis heute nicht abschließend gelösten Grundlagenproblem. Die Allgemeine Relativitätstheorie beschreibt eine dynamische Raumzeitgeometrie, während die Quantenfeldtheorie üblicherweise auf einer bereits gegebenen Raumzeit formuliert wird. In Situationen, in denen auch die Geometrie quantenmechanischen Schwankungen unterliegen müsste, reichen beide Formalismen in ihrer etablierten Form nicht aus. Bryce S. DeWitt arbeitet früh heraus, dass eine Quantisierung der Gravitation nicht nur ein weiteres Feld betrifft, sondern den geometrischen Hintergrund selbst in die Quantentheorie einbeziehen muss', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(39, 3, 5, 'historical_context', 'Die unterschiedlichen Ansätze zur Quantengravitation reagieren auf diese Schwierigkeit auf verschiedene Weise. In der kanonischen und schleifenquantengravitativen Forschung werden geometrische Größen quantisiert und teilweise diskrete Spektren für Flächen- oder Volumenoperatoren untersucht. Carlo Rovelli beschreibt Raum dabei nicht als unveränderliches Kontinuum, sondern als möglicherweise aus quantisierten relationalen Strukturen hervorgehend', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(40, 35, 5, 'first_citation', 'Claus Kiefer stellt demgegenüber die unterschiedlichen quantengravitativen Programme vergleichend dar und betont sowohl ihre mathematische Vielfalt als auch die bislang fehlende empirische Entscheidung zwischen ihnen  Damit wird zugleich eine wesentliche Grenze sichtbar: Die theoretische Möglichkeit einer nichtfundamentalen Raumzeit ist wissenschaftlich ernst zu nehmen, aber bislang nicht durch eine allgemein bestätigte physikalische Theorie abschließend geklärt.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(41, 36, 5, 'first_citation', 'Ein besonders konsequenter Ansatz findet sich in der Causal-Set-Theorie. Dort wird angenommen, dass die fundamentale Struktur nicht zunächst geometrisch, sondern kausal und diskret ist. Eine teilweise geordnete Menge elementarer Ereignisse soll unter geeigneten Bedingungen eine kontinuierliche Raumzeit approximieren können  Raumzeit wäre danach nicht der Ausgangspunkt, sondern eine makroskopische Beschreibung einer tieferen Kausalstruktur.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(42, 37, 5, 'first_citation', 'Ted Jacobson entwickelt einen anderen Zugang, indem er die Einstein-Gleichungen als Zustandsgleichung aus thermodynamischen Beziehungen ableitet  Seine Arbeit legt nahe, dass die klassische Raumzeitdynamik möglicherweise ähnlich wie Temperatur oder Druck eine makroskopische Beschreibung mikroskopischer Freiheitsgrade darstellt. Die Gravitation wäre dann nicht zwangsläufig fundamental, sondern könnte als thermodynamisches Verhalten einer tieferen Struktur erscheinen.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(43, 38, 5, 'first_citation', 'Eine weitere wichtige Forschungsrichtung verbindet Raumzeitgeometrie mit Quanteninformation und Verschränkung. Shinsei Ryu und Tadashi Takayanagi zeigen im Rahmen der holografischen Dualität einen Zusammenhang zwischen Verschränkungsentropie in einer Quantentheorie und geometrischen Flächen in einem höherdimensionalen Raum  Mark Van Raamsdonk entwickelt daraus die Vorstellung weiter, dass die Zusammenhängigkeit einer Raumzeit eng mit der Verschränkungsstruktur des zugrunde liegenden Quantensystems verbunden sein könnte', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(44, 39, 5, 'first_citation', 'Eine weitere wichtige Forschungsrichtung verbindet Raumzeitgeometrie mit Quanteninformation und Verschränkung. Shinsei Ryu und Tadashi Takayanagi zeigen im Rahmen der holografischen Dualität einen Zusammenhang zwischen Verschränkungsentropie in einer Quantentheorie und geometrischen Flächen in einem höherdimensionalen Raum  Mark Van Raamsdonk entwickelt daraus die Vorstellung weiter, dass die Zusammenhängigkeit einer Raumzeit eng mit der Verschränkungsstruktur des zugrunde liegenden Quantensystems verbunden sein könnte', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(45, 40, 5, 'first_citation', 'Daneben existieren Ansätze, in denen Gravitation als entropische oder informationelle Erscheinung interpretiert wird. Erik Verlinde schlägt vor, Gravitationswirkungen aus Änderungen von Information und Entropie abzuleiten  Solche Modelle zeigen, wie weit sich die moderne theoretische Physik vom Bild einer ausschließlich objekt- und kraftbasierten Wirklichkeit entfernt hat. Gleichzeitig sind sie wissenschaftlich umstritten und dürfen nicht als gesicherter Ersatz für die Allgemeine Relativitätstheorie dargestellt werden. Für meine Untersuchung besitzen sie deshalb vor allem heuristische Bedeutung: Sie verdeutlichen, dass physikalische Größen unter bestimmten Modellannahmen als Resultate tieferer Informations- oder Organisationsstrukturen interpretiert werden können.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(46, 13, 6, 'background', 'Diese Spannung zwischen Konstruktion und Wirklichkeitsbezug prägt bereits Immanuel Kants Erkenntnistheorie. Kant unterscheidet zwischen den Bedingungen, unter denen Gegenstände überhaupt erfahren werden können, und den Dingen, wie sie unabhängig von diesen Bedingungen beschaffen sein mögen. Raum und Zeit erscheinen bei ihm nicht als aus Erfahrung gewonnene Eigenschaften äußerer Gegenstände, sondern als Formen der Anschauung, durch die Erfahrung erst möglich und geordnet wird .', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(47, 41, 6, 'first_citation', 'Der wissenschaftliche Erkenntnisprozess ist deshalb als fortlaufende Vermittlung zwischen Beobachtung, Begriff, Modell und Prüfung zu verstehen. Hermann von Helmholtz beschreibt Wahrnehmung nicht als unmittelbare Abbildung äußerer Gegenstände, sondern als Ergebnis unbewusster Schlussprozesse, in denen sensorische Veränderungen auf mögliche Ursachen bezogen werden .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(48, 18, 6, 'background', 'Ernst Cassirer führt diesen Gedanken in seiner Philosophie der symbolischen Formen sowie in seiner Analyse der modernen Physik weiter. Wissenschaftliche Begriffe bilden nach seiner Auffassung keine einfachen Kopien isolierter Dinge, sondern organisieren Beziehungen innerhalb symbolischer Systeme . Ein physikalischer Gegenstand wird dadurch bestimmt, dass er in ein Netz messbarer und gesetzmäßig miteinander verknüpfter Relationen eingeordnet werden kann. Die Bedeutung eines Begriffs ergibt sich daher nicht allein aus einem angenommenen materiellen Träger, sondern aus seiner Funktion innerhalb eines theoretischen Zusammenhangs.', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(49, 22, 6, 'background', 'Eine weitere entscheidende Entwicklung erfolgt im logischen Empirismus. Rudolf Carnap versucht, wissenschaftliche Begriffe durch explizite formale Systeme, Zuordnungsregeln und logische Rekonstruktionen zu klären . Sein Ziel besteht nicht darin, metaphysische Aussagen über eine jenseits aller Erfahrung liegende Wirklichkeit zu formulieren, sondern die logische Struktur wissenschaftlicher Sprache und wissenschaftlicher Theoriebildung transparent zu machen. Für meine Arbeit ist daran besonders bedeutsam, dass die Bedeutung eines theoretischen Ausdrucks nicht isoliert betrachtet werden kann. Sie ergibt sich aus seiner Einbettung in Definitionen, Regeln, Messvorschriften und Ableitungszusammenhänge.', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(50, 42, 6, 'first_citation', 'Gleichzeitig hat die Wissenschaftstheorie gezeigt, dass Beobachtungen nicht vollständig theoriefrei sind. Norwood Russell Hanson argumentiert, dass wissenschaftliches Sehen immer bereits durch Begriffe, Erwartungen und theoretische Zusammenhänge geprägt wird . Zwei Beobachter können denselben visuellen Reiz wahrnehmen und dennoch unterschiedliche wissenschaftliche Sachverhalte darin erkennen, weil sie über verschiedene begriffliche und theoretische Voraussetzungen verfügen.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(51, 43, 6, 'first_citation', 'Thomas S. Kuhn erweitert diesen Gedanken zu einer historischen Theorie wissenschaftlicher Paradigmen. Wissenschaftliche Gemeinschaften arbeiten innerhalb geteilter Beispiele, Methoden, Begriffe und Bewertungsmaßstäbe. Paradigmen beeinflussen, welche Probleme als relevant gelten, welche Beobachtungen als bedeutsam erscheinen und welche Lösungen als wissenschaftlich akzeptiert werden . Wissenschaftliche Entwicklung besteht daher nicht allein aus einer stetigen Anhäufung neuer Erkenntnisse, sondern umfasst auch Phasen tiefgreifender begrifflicher Neuorientierung.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(52, 44, 6, 'first_citation', 'Karl Popper setzt einen anderen Schwerpunkt. Für ihn liegt das entscheidende Kennzeichen wissenschaftlicher Theorien darin, dass sie prinzipiell an möglichen Erfahrungen scheitern können. Wissenschaftliche Aussagen müssen so formuliert sein, dass Bedingungen angegeben werden können, unter denen sie als widerlegt gelten würden . Wissenschaft entwickelt sich demnach nicht durch endgültige Bestätigung von Theorien, sondern durch den fortlaufenden Versuch, sie kritischen Prüfungen auszusetzen.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(53, 45, 6, 'first_citation', 'Imre Lakatos zeigt, dass wissenschaftliche Theorien in der Forschungspraxis häufig nicht bereits durch eine einzelne widersprechende Beobachtung aufgegeben werden. Vielmehr besitzen Forschungsprogramme einen relativ stabilen theoretischen Kern, der durch einen sogenannten Schutzgürtel ergänzender Hilfshypothesen umgeben ist. Wissenschaftlicher Fortschritt entscheidet sich daher nicht allein daran, ob einzelne Aussagen korrigiert werden müssen, sondern daran, ob ein Forschungsprogramm neue Fragestellungen erschließen, überprüfbare Vorhersagen ermöglichen und bislang unerklärte Phänomene erfolgreich integrieren kann (Imre Lakatos: Falsification and the Methodology of Scientific Research Programmes. In: Imre Lakatos; Alan Musgrave (Hrsg.): Criticism and the Growth of Knowledge. Cambridge: Cambridge University Press, 1970, S. 91–196) .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(54, 46, 6, 'first_citation', 'Willard Van Orman Quine stellt darüber hinaus die Vorstellung infrage, wissenschaftliche Aussagen könnten isoliert voneinander empirisch überprüft werden. Nach seiner Auffassung trifft jede Beobachtung auf ein zusammenhängendes Netz theoretischer Annahmen, Definitionen und Hilfshypothesen . Kommt es zu einer Abweichung zwischen Vorhersage und Beobachtung, lässt sich deshalb nicht unmittelbar entscheiden, welcher Bestandteil des theoretischen Systems verändert werden muss. Häufig sind mehrere unterschiedliche Anpassungen denkbar, die mit denselben Beobachtungsdaten vereinbar bleiben.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(55, 47, 6, 'first_citation', 'Pierre Duhem hatte diesen Gedanken bereits für die Physik formuliert. Nach seiner Auffassung prüfen Experimente in der Regel niemals nur eine einzelne Hypothese, sondern stets ein Bündel theoretischer, mathematischer und instrumenteller Voraussetzungen . Die spätere Verbindung dieser Überlegungen mit Quines Wissenschaftstheorie führte zum sogenannten Duhem-Quine-Problem, das die Unterbestimmtheit empirischer Daten durch konkurrierende Theorien beschreibt.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(56, 48, 6, 'first_citation', 'Bas van Fraassen zieht aus diesen Überlegungen eine bewusst zurückhaltende Konsequenz. Der von ihm vertretene konstruktive Empirismus fordert nicht, sämtliche theoretischen Entitäten einer erfolgreichen Theorie zugleich als real existierend anzunehmen. Für den wissenschaftlichen Erfolg genügt zunächst, dass eine Theorie hinsichtlich beobachtbarer Phänomene empirisch angemessen ist . Diese Position erscheint auch für das FRZK methodisch außerordentlich hilfreich. Funktionale Zustände, Kohärenzräume oder Operatorstrukturen können zunächst als theoretische Konstruktionen verstanden werden, sofern sie beobachtbare Zusammenhänge konsistent beschreiben, präzise organisieren und überprüfbare Aussagen ermöglichen.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(57, 49, 6, 'first_citation', 'Ich möchte mich dennoch nicht auf eine rein instrumentelle Auffassung wissenschaftlicher Modelle beschränken. Wissenschaftliche Begriffe können langfristig mehr leisten als bloße Rechenhilfen. Sie können stabile Strukturen der Wirklichkeit erfassen, auch wenn sich ihre konkrete begriffliche Ausgestaltung im Laufe der wissenschaftlichen Entwicklung verändert. Genau an diesem Punkt setzt der wissenschaftliche Strukturenrealismus an. John Worrall vertritt die Auffassung, dass bei tiefgreifenden Theorieumbrüchen häufig nicht sämtliche theoretischen Inhalte erhalten bleiben, wohl aber bestimmte mathematische und relationale Strukturen .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(58, 50, 6, 'first_citation', 'James Ladyman entwickelt diesen Gedanken weiter und formuliert den ontischen Strukturenrealismus. Nach seiner Auffassung könnten Strukturen nicht lediglich erkenntnistheoretisch bevorzugt sein, sondern selbst den ontologisch grundlegenden Bestandteil der Wirklichkeit bilden . Steven French und James Ladyman verbinden diese Position später mit Problemen der modernen Physik, insbesondere mit den Schwierigkeiten klassischer Individualitätsbegriffe innerhalb der Quantenmechanik .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(59, 51, 6, 'first_citation', 'James Ladyman entwickelt diesen Gedanken weiter und formuliert den ontischen Strukturenrealismus. Nach seiner Auffassung könnten Strukturen nicht lediglich erkenntnistheoretisch bevorzugt sein, sondern selbst den ontologisch grundlegenden Bestandteil der Wirklichkeit bilden . Steven French und James Ladyman verbinden diese Position später mit Problemen der modernen Physik, insbesondere mit den Schwierigkeiten klassischer Individualitätsbegriffe innerhalb der Quantenmechanik .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(60, 52, 6, 'first_citation', 'Ein weiteres erkenntnistheoretisches Problem betrifft die Rolle wissenschaftlicher Modelle. Mary Hesse zeigt, dass Modelle grundsätzlich über Analogien zwischen einem bekannten und einem zu untersuchenden Gegenstandsbereich arbeiten. Sie unterscheidet dabei positive, negative und neutrale Analogien und macht deutlich, dass kein Modell seinen Gegenstand vollständig abbildet . Modelle sind stets selektiv. Sie heben bestimmte Eigenschaften hervor, während andere bewusst ausgeblendet werden.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(61, 53, 6, 'first_citation', 'Ronald Giere beschreibt wissenschaftliche Modelle deshalb als bewusst konstruierte Repräsentationen, die unter bestimmten Zielsetzungen ausgewählte Aspekte realer Systeme erfassen . Daraus folgt, dass Modelle niemals den Anspruch erheben müssen, ihren Gegenstand vollständig abzubilden. Ihre wissenschaftliche Qualität bemisst sich vielmehr daran, ob sie den vorgesehenen Anwendungsbereich angemessen beschreiben und zuverlässige Aussagen ermöglichen.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(62, 54, 6, 'first_citation', 'Patrick Suppes vertritt eine modelltheoretische Auffassung wissenschaftlicher Theorien, nach der Theorien weniger als Mengen sprachlicher Aussagen denn als Klassen mathematischer Strukturen verstanden werden . Damit verschiebt sich der Schwerpunkt wissenschaftlicher Beschreibung von einzelnen Formulierungen hin zu den Strukturen, innerhalb derer mathematische Beziehungen erfüllt werden. Für die Mathematik bedeutet dies, dass dieselbe formale Theorie in unterschiedlichen Modellen realisiert werden kann, sofern diese dieselben strukturellen Bedingungen erfüllen.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1);
INSERT INTO `source_usage` (`usage_id`, `source_id`, `section_id`, `usage_type`, `claim_summary`, `exact_location`, `source_excerpt`, `source_excerpt_language`, `source_excerpt_translation`, `is_first_mention`, `citation_checked`, `notes`, `created_revision_id`) VALUES
(63, 55, 6, 'first_citation', 'Eine wesentliche Grundlage für diese Ebenentrennung liefert Alfred Tarski. Mit seiner semantischen Wahrheitstheorie entwickelt er einen formalen Wahrheitsbegriff, der Objekt- und Metasprache strikt voneinander trennt . Aussagen innerhalb eines formalen Systems dürfen danach nicht mit Aussagen über dieses System verwechselt werden. Wahrheit wird stets relativ zu einer festgelegten Interpretation und zu eindeutig definierten Erfüllungsbedingungen bestimmt.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(64, 56, 7, 'first_citation', 'George Boole zeigt bereits im 19. Jahrhundert, dass logische Operationen selbst mathematisch behandelt werden können. Aussagen werden nicht mehr ausschließlich sprachlich verstanden, sondern als Elemente eines formalen Kalküls mit eindeutig definierten Verknüpfungsregeln  Die mathematische Struktur entsteht hier nicht aus räumlichen Eigenschaften, sondern aus eindeutig festgelegten Operationen auf unterscheidbaren Zuständen.', 'Chapter I, §1 (Nature and Design of This Work), p. 1', 'The design of the following treatise is to investigate the fundamental laws of those operations of the mind by which reasoning is performed.', 'en', NULL, 1, 1, 'Fundstelle und Fundtext direkt anhand der digital verfügbaren Primärquelle von George Boole, Laws of Thought, verifiziert.', 1),
(65, 57, 7, 'first_citation', 'Giuseppe Peano entwickelt mit seinen Axiomen eine explizite Konstruktion der natürlichen Zahlen. Bemerkenswert ist dabei weniger die konkrete Definition der Zahlen als vielmehr die Methode ihrer schrittweisen Ableitung aus wenigen Grundannahmen  Mathematik erscheint damit als rekonstruktiver Prozess, dessen Objekte nicht vorausgesetzt, sondern systematisch aufgebaut werden.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(66, 58, 7, 'first_citation', 'Bertrand Russell und Alfred North Whitehead verfolgen dieses Ziel im Principia Mathematica noch konsequenter. Sie versuchen, die gesamte Mathematik auf logisch explizite Grundlagen zurückzuführen  Auch wenn dieses Programm später durch Gödels Unvollständigkeitssätze begrenzt wurde, bleibt die grundlegende methodische Idee bedeutsam: Mathematische Begriffe müssen möglichst aus klar angegebenen Voraussetzungen entwickelt werden.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(67, 59, 7, 'first_citation', 'David Hilbert formuliert mit seinen Grundlagen der Geometrie einen weiteren entscheidenden Schritt. Er verzichtet bewusst auf anschauliche Bedeutungen geometrischer Begriffe und behandelt Punkte, Geraden und Ebenen zunächst ausschließlich als formale Elemente eines Axiomensystems  Entscheidend ist nicht mehr, was ein Punkt „ist“, sondern welche Beziehungen durch die Axiome zwischen den verwendeten Symbolen festgelegt werden.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(68, 60, 7, 'first_citation', 'Mit der Entwicklung der Mengenlehre erhält die Mathematik ein äußerst mächtiges Fundament. Georg Cantor beschreibt Mengen als Zusammenfassungen unterscheidbarer Objekte zu einer Einheit  Die Mengenlehre erlaubt die Konstruktion nahezu aller modernen mathematischen Strukturen. Zugleich setzt sie jedoch bereits die Identifizierbarkeit einzelner Elemente voraus.', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(69, 61, 8, 'first_citation', 'Diese Sichtweise weist eine Nähe zu strukturorientierten Auffassungen moderner Mathematik auf. Saunders Mac Lane betont, dass mathematische Theorien nicht ausschließlich durch die Eigenschaften isolierter Objekte bestimmt werden, sondern wesentlich durch die Beziehungen und Operationen, die zwischen diesen Objekten bestehen .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(70, 62, 8, 'first_citation', 'Eng damit verbunden ist die Forderung nach Strukturerhaltung. Samuel Eilenberg und Saunders Mac Lane entwickelten mit der Kategorientheorie einen mathematischen Rahmen, in dem nicht die isolierten Eigenschaften einzelner Elemente, sondern strukturerhaltende Abbildungen und die Beziehungen zwischen mathematischen Strukturen im Mittelpunkt stehen .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(71, 63, 9, 'first_citation', 'Die moderne Mathematik hat diese Verschiebung in mehreren Entwicklungsschritten vorbereitet. Bereits Gottlob Frege bestimmt Zahlen nicht primär als sinnlich oder räumlich vorstellbare Gegenstände, sondern untersucht ihre logische Bestimmbarkeit innerhalb von Begriffen, Urteilen und Zuordnungen .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(72, 18, 9, 'background', 'Ernst Cassirer entwickelt diese Verschiebung vom Substanz- zum Funktionsbegriff ausdrücklich weiter. Wissenschaftliche Begriffe erfassen Gegenstände nach seiner Analyse zunehmend nicht über isolierte Wesenseigenschaften, sondern über ihre Stellung innerhalb gesetzmäßiger Reihen und relationaler Ordnungen . Ein Element ist wissenschaftlich nicht deshalb bestimmt, weil ihm eine unveränderliche Substanz zugesprochen wird, sondern weil seine Beziehungen zu anderen Elementen innerhalb eines strukturierten Systems angegeben werden können.', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(73, 16, 9, 'background', 'Die Prozessphilosophie Alfred North Whiteheads bietet hierzu einen wichtigen Anschluss. Whitehead kritisiert die Vorstellung, die Wirklichkeit müsse primär aus dauerhaft bestehenden Substanzen zusammengesetzt sein. Stattdessen rückt er Ereignisse, Prozesse und wechselseitige Hervorbringungen in den Mittelpunkt seiner Ontologie .', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(74, 64, 9, 'first_citation', 'Diese Auffassung nähert sich systemtheoretischen Überlegungen an. Ludwig von Bertalanffy beschreibt Systeme nicht als bloße Ansammlungen isolierter Teile, sondern als geordnete Ganzheiten, deren Bestandteile durch Wechselwirkungen miteinander verbunden sind .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(75, 65, 9, 'first_citation', 'Norbert Wiener verbindet diese systemische Perspektive mit der Untersuchung von Steuerung, Kommunikation und Rückkopplung. In der Kybernetik wird das Verhalten eines Systems über Informationsflüsse, Regelkreise und die funktionale Beziehung zwischen Eingängen, internen Zuständen und Ausgängen beschrieben .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(76, 66, 9, 'first_citation', 'Ross W. Ashby untersucht solche rekursiven Zusammenhänge als Zustandsübergänge und Regelungsprozesse. Ein System wird dabei durch mögliche Zustände und die Regeln beschrieben, nach denen es unter bestimmten Bedingungen von einem Zustand in einen anderen übergeht .', 'Chapter 2, §2/3–2/4, pp. 10–11; ergänzend Zustandsfolge in Chapter 3', 'the passage from state to state ... will correspond to the operation of a transformation', 'en', NULL, 1, 1, 'Fundstelle und Fundtext direkt anhand der digital verfügbaren Originalausgabe von W. Ross Ashby, An Introduction to Cybernetics (1956), verifiziert.', 1),
(77, 62, 9, 'background', 'Die moderne Kategorientheorie verstärkt den methodischen Vorrang von Beziehungen und Transformationen. Eilenberg und Mac Lane rückten mit ihrer Theorie natürlicher Äquivalenzen strukturerhaltende Abbildungen in das Zentrum mathematischer Betrachtung . In einer kategorialen Darstellung werden mathematische Objekte wesentlich durch die Morphismen charakterisiert, die zwischen ihnen bestehen. Dadurch verliert die innere stoffliche Beschaffenheit eines Objekts gegenüber seiner strukturellen Einbindung an Bedeutung.', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(78, 61, 9, 'background', 'Saunders Mac Lane beschreibt diese Entwicklung später als eine Mathematik der Formen, Funktionen und Transformationen . Für das FRZK liegt darin eine wichtige methodische Orientierung. Eine mathematische Struktur soll nicht über eine verborgene Substanz erklärt werden, sondern über die Operationen, durch die sie erzeugt, verändert und mit anderen Strukturen verbunden werden kann.', NULL, NULL, NULL, NULL, 0, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(79, 67, 9, 'first_citation', 'Eine ähnliche Grenze besteht innerhalb der mathematischen Strukturalismusdebatte. Michael Resnik vertritt die Auffassung, dass Mathematik primär Strukturen beziehungsweise Muster untersucht und dass mathematische Objekte durch ihre Positionen innerhalb dieser Strukturen bestimmt werden .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(80, 68, 9, 'first_citation', 'Stewart Shapiro formuliert entsprechend, mathematische Gegenstände seien als Stellen in Strukturen zu verstehen, deren Identität durch die jeweiligen Beziehungen festgelegt wird .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(81, 69, 9, 'first_citation', 'Heinz von Foerster hebt in seiner Kybernetik zweiter Ordnung hervor, dass Beobachter und beschreibende Systeme selbst Teil der untersuchten Rückkopplungszusammenhänge sein können .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(82, 70, 9, 'first_citation', 'Niklas Luhmann formuliert für soziale Systeme einen radikalen Funktions- und Operationsbegriff, nach dem Systeme nicht aus Menschen oder Dingen, sondern aus rekursiv anschließenden Operationen bestehen .', NULL, NULL, NULL, NULL, 1, 0, 'Fundstelle und Fundtext nicht aus dem Dissertationstext übernommen. Bis zur externen Verifikation bleiben exact_location und source_excerpt NULL.', 1),
(83, 6, 22, 'background', 'Halmos dient als etablierte Grundlage für Mengen, Elemente, geordnete Paare, Relationen und Funktionen sowie für die Einordnung dieser Begriffe als mathematische Werkzeuge.', 'Vorwort sowie S. 1–12', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits vorhandenen Quelle [6]. Die Fundstelle wurde an der zugänglichen Ausgabe geprüft.', 2),
(84, 59, 22, 'method', 'Tarski dient als methodischer Bezug für die Trennung formaler Sprachebenen und für die kontrollierte Unterscheidung zwischen Definition, formaler Aussage und Interpretation.', NULL, NULL, NULL, NULL, 0, 0, 'Wiederverwendung der bereits vorhandenen Quelle [59]. Für die konkrete Verwendung in 3.2.0 wird keine nicht erneut verifizierte Einzelbelegstelle eingetragen.', 2),
(85, 60, 22, 'background', 'Mac Lane stützt den strukturorientierten und zusammenhängenden Aufbau mathematischer Werkzeuge von Funktionen und Transformationen über lineare Algebra und Raumstrukturen bis zu Mengen, Logik und Kategorien.', 'Functions, Transformations, and Groups: S. 123–149; Linear Algebra: S. 185–218; Forms of Space: S. 219–258; Sets, Logic, and Categories: S. 358–408', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits vorhandenen Quelle [60]. Die Seitenbereiche wurden am realen Inhaltsverzeichnis der Ausgabe geprüft.', 2),
(86, 67, 22, 'background', 'Resnik dient als strukturalistischer Bezug für die Unterscheidung mathematischer Gegenstände von einer unmittelbar vorausgesetzten anschaulichen oder physikalischen Verkörperung.', NULL, NULL, NULL, NULL, 0, 0, 'Wiederverwendung der bereits vorhandenen Quelle [67]. Keine nicht verifizierte Einzelbelegstelle eingetragen.', 2),
(87, 68, 22, 'background', 'Shapiro dient als strukturalistischer Bezug für die Bestimmung mathematischer Gegenstände über ihre Stellung innerhalb mathematischer Strukturen.', NULL, NULL, NULL, NULL, 0, 0, 'Wiederverwendung der bereits vorhandenen Quelle [68]. Keine nicht verifizierte Einzelbelegstelle eingetragen.', 2),
(88, 71, 24, 'first_citation', 'Enderton stützt die systematische Entwicklung von Mengenaxiomen und Mengenoperationen zu geordneten Paaren, Relationen, Funktionen, Äquivalenzrelationen und Ordnungsstrukturen.', 'Kap. 2 S. 17-34; Kap. 3 S. 35-64; Relation S. 40; Äquivalenzrelation S. 56; Partial Orderings Kap. 7 S. 167-170', NULL, NULL, NULL, 1, 1, 'Deep-Research-verifizierter Kurzbeleg auf S. 40: „A relation is a set of ordered pairs.“ Die in 3.2.1 verwendete reflexive partielle Ordnung entspricht der von Enderton auf S. 170 ausdrücklich diskutierten weak-order-Konvention.', 3),
(89, 71, 26, 'definition', 'Enderton stützt den Funktionsbegriff als eindeutige Relation sowie Bild, Injektivität, Surjektivität, Umkehrfunktion, Verkettung und Funktionen mit mehreren Eingangsgrößen.', 'Kap. 3, S. 42-48; one-to-one/onto S. 43; inverse function S. 46-47; composition S. 47; mehrere Eingangsgrößen S. 43-44', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits in 3.2.1 eingeführten Quelle [71]. Die verwendeten Belegbereiche wurden an der zugänglichen Ausgabe geprüft.', 4),
(90, 72, 27, 'first_citation', 'Strang dient als etablierte Grundlage für Vektorraum, Untervektorraum, Vektorkombinationen sowie die Vorbereitung von Unabhängigkeit, Basis und Dimension.', 'Kap. 1 §1.1 ab S. 2; Kap. 3 §3.1 S. 123-134; Kap. 3 §3.4 ab S. 164; Kap. 9 §9.1 ab S. 431', NULL, NULL, NULL, 1, 1, 'Erstnennung der Quelle [72] in 3.2.3. Die angegebenen Kapitel-/Seitenanfänge wurden an der offiziellen Inhaltsübersicht der fünften Auflage verifiziert.', 5),
(91, 72, 28, 'definition', 'Strang dient als etablierte Grundlage für Linearkombinationen, aufgespannte Vektorräume beziehungsweise Unterräume und die Vorbereitung von Erzeugung, Redundanz und linearer Unabhängigkeit.', '§1.1 \"Vectors and Linear Combinations\"; §3.1 \"Spaces of Vectors\"', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits in 3.2.3 eingeführten Quelle [72]. Die angegebenen Gliederungsstellen wurden an der offiziellen MIT-Seite zur fünften Auflage verifiziert; keine ungesicherten Seitenzahlen eingetragen.', 6),
(92, 72, 29, 'theorem', 'Strang dient als etablierte Grundlage für lineare Unabhängigkeit, Basis, eindeutige Koordinatendarstellung und algebraische Dimension sowie für die dimensionsbezogene Einordnung von Unterräumen.', '§3.4 \"Independence, Basis and Dimension\", ab S. 164; §3.5 \"Dimensions of the Four Subspaces\", ab S. 181', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits in 3.2.3 eingeführten Quelle [72]. Die angegebenen Gliederungsstellen und Startseiten wurden an der offiziellen Inhaltsübersicht der fünften Auflage verifiziert.', 7),
(93, 72, 30, 'theorem', 'Strang dient als etablierte Grundlage für lineare Transformationen, Nullraum/Kern, Bild- und Dimensionsbeziehungen sowie die Matrixdarstellung linearer Transformationen bezüglich gewählter Basen.', '§3.2 ab S. 135; §3.5 ab S. 181; §8.1 ab S. 401; §8.2 ab S. 411; §8.3 ab S. 421', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits in 3.2.3 eingeführten Quelle [72]. Gliederung und Startseiten wurden an der offiziellen Inhaltsübersicht der fünften Auflage verifiziert.', 8),
(94, 73, 31, 'first_citation', 'Conway dient als funktionalanalytische Grundlage für Skalarprodukträume, Hilbertraumgeometrie sowie normierte und Banachraumstrukturen und stützt damit die Definitionen und Sätze zu Norm, Skalarprodukt, Orthogonalität und Cauchy-Schwarz.', '\"Hilbert Spaces\", S. 1-25; \"Banach Spaces\", S. 63-98', NULL, NULL, NULL, 1, 1, 'Erstnennung der Quelle [73] in Abschnitt 3.2.7. Kapitelbezeichnungen und Seitenbereiche wurden an Springer verifiziert.', 9),
(95, 72, 31, 'background', 'Strang ergänzt die endlichdimensionale geometrische Darstellung von Vektorlängen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen.', '§1.2 \"Lengths and Dot Products\"; Kap. 4 \"Orthogonality\", §§4.1-4.4', NULL, NULL, NULL, 0, 1, 'Wiederverwendung von Quelle [72]. Es werden nur verifizierte Gliederungsstellen angegeben; keine ungesicherten Seitenzahlen.', 9),
(96, 74, 32, 'first_citation', 'Munkres dient als etablierte Grundlage für topologische Räume, offene und abgeschlossene Mengen, topologische Basen, Abschluss- und Randbegriffe, Stetigkeit, Homeomorphismen sowie die von Metriken induzierte Topologie.', '§12; §13; §17; §18; §20; §21', NULL, NULL, NULL, 1, 1, 'Erstnennung der Quelle [74] in Abschnitt 3.2.8. Es werden ausschließlich verifizierte Abschnittsangaben gespeichert; keine ungesicherten Seitenzahlen.', 10),
(97, 74, 33, 'theorem', 'Munkres dient als etablierte Grundlage für topologische Trennungen und Zusammenhang, Wegzusammenhang, Zusammenhangskomponenten, offene Überdeckungen, Kompaktheit sowie die Erhaltung von Zusammenhang und Kompaktheit unter stetigen Abbildungen.', '§23; §24; §25; §26', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits in 3.2.8 eingeführten Quelle [74]. Es werden ausschließlich verifizierte Abschnittsangaben gespeichert; keine ungesicherten Seitenzahlen.', 11),
(98, 73, 34, 'theorem', 'Conway dient als funktionalanalytische Grundlage für vollständige normierte Räume, Banachräume, Hilberträume und deren Norm- und Skalarproduktstruktur.', '\"Hilbert Spaces\", S. 1-25; \"Banach Spaces\", S. 63-98', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der in 3.2.7 eingeführten Quelle [73].', 12),
(99, 74, 34, 'theorem', 'Munkres dient als topologische und metrische Grundlage für Folgenkonvergenz, vollständige metrische Räume sowie die Beziehung zwischen Kompaktheit und Folgen in metrischen Räumen.', 'Kapitel \"Complete Metric Spaces and Function Spaces\"', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der in 3.2.8 eingeführten Quelle [74]. Es wird keine ungesicherte Seitenangabe gespeichert.', 12),
(100, 73, 35, 'background', 'Conway dient als funktionalanalytische Grundlage für normierte und vollständige lineare Räume, Banach- und Hilbertraumstrukturen sowie lineare Funktionale und Operatoren, die auf Funktionenräumen verwendet werden.', '\"Hilbert Spaces\", S. 1-25; \"Banach Spaces\", S. 63-98', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits in 3.2.7 eingeführten Quelle [73]. Die Fundstelle bleibt auf die zuvor verifizierten Kapitelbereiche beschränkt.', 13),
(101, 74, 35, 'background', 'Munkres dient als Grundlage für Funktionenräume und Konvergenz von Funktionen, insbesondere für vollständige metrische Funktionenräume sowie punktweise und stärkere Konvergenzstrukturen.', 'Kapitel \"Complete Metric Spaces and Function Spaces\"; §43; §46', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits in 3.2.8 eingeführten Quelle [74]. Es werden keine ungesicherten Detailseiten gespeichert.', 13),
(102, 73, 36, 'theorem', 'Conway dient als funktionalanalytische Grundlage für lineare und stetige Funktionale, Dualräume, beschränkte lineare Operatoren, Operatornormen, Operatorräume, Hilbertraumdarstellung, Banachalgebren, spektral vorbereitende Operatorstrukturen und beschränkte inverse Operatoren.', '\"Hilbert Spaces\", S. 1-25; \"Operators on Hilbert Space\", S. 26-62; \"Banach Spaces\", S. 63-98; \"Linear Operators on a Banach Space\", S. 166-186; \"Banach Algebras and Spectral Theory for Operators on a Banach Space\", S. 187-231', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [73]. Die Fundstellen wurden gegen die offizielle Springer-Gliederung der zweiten Ausgabe verifiziert.', 14),
(103, 72, 37, 'theorem', 'Strang dient als Grundlage für Eigenwerte, Eigenvektoren, Eigenräume, charakteristisches Polynom, algebraische und geometrische Vielfachheit sowie Diagonalisierbarkeit in endlichdimensionalen Räumen.', 'Kap. 6; §§6.1-6.5', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [72].', 15),
(104, 73, 37, 'theorem', 'Conway dient als Grundlage für Resolvente, Spektrum, Punktspektrum, Spektralradius, Spektralradiusformel und invariante Teilräume beschränkter Operatoren auf Banach- und Hilberträumen.', '\"Operators on Hilbert Space\", S. 26-62; \"Linear Operators on a Banach Space\", S. 166-186; \"Banach Algebras and Spectral Theory for Operators on a Banach Space\", S. 187-231', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [73].', 15),
(105, 72, 38, 'theorem', 'Strang dient als endlichdimensionale Grundlage für Orthogonalität, Projektionsmatrizen, Projektionen auf Spaltenräume, orthonormale Basen und Dimensionsbeziehungen.', 'Kap. 4; §§4.1-4.4', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [72]; keine ungesicherten Seitenzahlen.', 16),
(106, 73, 38, 'theorem', 'Conway dient als Grundlage für orthogonale Komplemente, Hilbertraumzerlegungen, orthogonale Projektionen, beste Approximation, Projektionsoperatoren und reduzierende Teilräume.', '\"Hilbert Spaces\", S. 1-25; \"Operators on Hilbert Space\", S. 26-62', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [73].', 16),
(107, 75, 39, 'first_citation', 'Teschl dient als Grundlagenquelle für gewöhnliche Differentialgleichungen, Anfangswertprobleme, lokale Existenz und Eindeutigkeit, Fortsetzbarkeit, Abhängigkeit von Anfangsdaten, Gleichgewichtszustände und lineare ODE-Systeme.', NULL, NULL, NULL, NULL, 1, 1, 'Erstnennung der neuen Literaturquelle [76]. Keine ungesicherte Fundstelle in exact_location.', 17),
(108, 76, 39, 'first_citation', 'Evans dient als Grundlagenquelle für partielle Differentialgleichungen, klassische Lösungen, prototypische PDEs, Anfangs- und Randbedingungen, Rand- und Anfangs-Randwertprobleme sowie Wohlgestelltheit.', NULL, NULL, NULL, NULL, 1, 1, 'Erstnennung der neuen Literaturquelle [77]. Keine ungesicherte Fundstelle in exact_location.', 17),
(109, 73, 39, 'background', 'Conway wird für die abstrakte Operatorform von Differentialproblemen, Definitionsbereiche, Kerne und affine Lösungsräume linearer Operatorgleichungen wiederverwendet.', NULL, NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [73]; keine neue Fundstellenbehauptung.', 17),
(110, 75, 40, 'background', 'Teschl dient als Grundlage für dynamische Systeme, diskrete und kontinuierliche Zustandsentwicklungen, Flüsse autonomer Differentialgleichungen, Trajektorien, Orbits, Fixpunkte, Periodizität sowie lineare und nichtautonome Evolutionsstrukturen.', 'Part 2 \"Dynamical systems\"; Chapter 6 \"Dynamical systems\"', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [76]. Fundstelle gegen die AMS-Inhaltsübersicht verifiziert.', 18),
(111, 75, 41, 'theorem', 'Teschl dient als Grundlage für Stabilitätsbegriffe dynamischer Systeme, lokale Stabilitätsanalyse an Fixpunkten, Lyapunov-Methoden, Linearisierung, Hyperbolizität und spektrale Stabilitätskriterien.', 'Part 2 \"Dynamical systems\"; Chapter 9 \"Local behavior near fixed points\"', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [76]. Die Kapitelangabe ist über die AMS-Inhaltsübersicht verifiziert.', 19),
(112, 75, 42, 'theorem', 'Teschl dient als Grundlage für Omega-Grenzmengen, deren Invarianz und Kompaktheitseigenschaften sowie für anziehende Mengen, Einzugsgebiete, Fanggebiete, topologische Transitivität und Attraktoren.', 'Chapter 6 \"Dynamical systems\"; Chapter 8, Section 8.1 \"Attracting sets\"', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [76]. Die angegebenen Themenbereiche wurden in der maßgeblichen Buchfassung beziehungsweise Inhaltsstruktur verifiziert.', 20),
(114, 77, 43, 'first_citation', 'Lee dient als Grundlagenquelle für topologische und glatte Mannigfaltigkeiten, Karten und Atlanten, glatte Abbildungen, Tangentialvektoren, Tangentialräume, Differentiale und Tangentialbündel.', '\"Smooth Manifolds\", S. 1-31; \"Smooth Maps\", S. 32-49; \"Tangent Vectors\", S. 50-76', NULL, NULL, NULL, 1, 1, 'Erstnennung der neuen Literaturquelle [78]. Fundstellen unmittelbar gegen die Springer-Nature-Inhaltsübersicht der zweiten Ausgabe verifiziert.', 21),
(115, 78, 45, 'first_citation', 'O\'Neill dient als Grundlagenquelle für nicht ausgeartete symmetrische Bilinearformen, semi-/pseudo-riemannsche Metriken, riemannsche und lorentzsche Spezialfälle, Index und Signatur, metrische Vektorklassifikation, Kurvenlänge, riemannschen Abstand und Isometrien.', 'Chapter 3 \"Semi-Riemannian Manifolds\", S. 54-96; Chapter 5 \"Riemannian and Lorentz Geometry\", S. 126-157; Chapter \"Isometries\" (Kapitelname verifiziert, Seitenangabe nicht gespeichert)', NULL, NULL, NULL, 1, 1, 'Erstnennung der neuen Literaturquelle [79]. Seitenangaben nur dort gespeichert, wo sie unmittelbar über die Buch-/Verlagsdaten verifiziert wurden.', 23),
(116, 78, 46, 'theorem', 'O\'Neill dient als Grundlagenquelle für Vektorfelder, affine Zusammenhänge, kovariante Ableitung, Torsion, Metrikverträglichkeit, Levi-Civita-Zusammenhang, Christoffel-Symbole, kovariante Ableitung entlang von Kurven und Paralleltransport.', 'Chapter 3 \"Semi-Riemannian Manifolds\", S. 54-96', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [79]. Die Fundstelle ist für den einschlägigen semi-riemannschen Grundlagenbereich verifiziert.', 24),
(117, 78, 47, 'theorem', 'O\'Neill dient als Grundlagenquelle für Geodäten, Exponentialabbildung, normale Umgebungen, Krümmungstensor, Schnittkrümmung, Ricci- und Skalarkrümmung, Jacobi-Felder sowie geodätische Vollständigkeit.', 'Chapter 3 \"Semi-Riemannian Manifolds\", S. 54-96; Chapter 5 \"Riemannian and Lorentz Geometry\", S. 126-157', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [79]. Es werden nur zuvor verifizierte Kapitel-/Seitenbereiche gespeichert.', 25),
(118, 78, 48, 'theorem', 'O\'Neill dient als Grundlagenquelle für Zeitorientierung, kausale und zeitartige Kurven, chronologische und kausale Relationen, globale Kausalitätsbedingungen sowie konforme Eigenschaften der lorentzschen Kausalstruktur.', 'Chapter 14 \"Causality in Lorentz Manifolds\", S. 401-440', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der bereits eingeführten Quelle [79]. Der Kapitelbereich wurde anhand der Verlags-/Inhaltsdaten verifiziert.', 26),
(119, 76, 49, 'theorem', 'Evans dient als Grundlagenquelle für Funktionale, Variationen, notwendige Extremalbedingungen, Euler-Lagrange-Gleichungen und die Variationsrechnung für Integral-Funktionale.', 'Chapter 8 \"The calculus of variations\"', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der Quelle [77]. Der Kapitelname ist über die American Mathematical Society verifiziert; es wird keine ungesicherte Seitenangabe gespeichert.', 27),
(120, 78, 49, 'theorem', 'O\'Neill dient ergänzend als Quelle für die Variationscharakterisierung von Geodäten über ein geodätisches Energie-Funktional.', 'Chapter \"Calculus of Variations\"', NULL, NULL, NULL, 0, 1, 'Wiederverwendung der Quelle [79]. Der Kapitelname ist im Elsevier-Inhaltsverzeichnis verifiziert; mangels belastbar verifizierter Seitenzahl wird keine Seitenangabe gespeichert.', 27);

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
(1, '3.2.1', 29, 'Eindeutige Darstellung bezüglich einer Basis', 'Ist B={b_1,...,b_n} eine Basis eines Vektorraums V, so besitzt jeder Vektor v in V genau eine Darstellung als Linearkombination der Basisvektoren. Sind zwei Darstellungen mit Koeffizienten alpha_i und beta_i gegeben, so stimmen die jeweiligen Koeffizienten überein.', 'forall vin V;exists !,(alpha_1,ldots,alpha_n)inmathbb K^n:;v=sum_{i=1}^{n}alpha_i b_i', 'forall vin V;exists !,(alpha_1,ldots,alpha_n)inmathbb K^n:;v=sum_{i=1}^{n}alpha_i b_i', 'literature', 72, 'mathcal B={b_1,ldots,b_n} ist eine Basis von V.', 'verified', 7),
(2, '3.2.2', 30, 'Injektivitätskriterium für lineare Abbildungen', 'Eine lineare Abbildung T:V nach W ist genau dann injektiv, wenn ihr Kern ausschließlich aus dem Nullvektor des Ausgangsraums besteht.', 'T\\text{ injektiv}\\quad\\Longleftrightarrow\\quad\\ker(T)=\\{0_V\\}', 'T\\text{ injektiv}\\quad\\Longleftrightarrow\\quad\\ker(T)=\\{0_V\\}', 'literature', 72, 'T ist eine lineare Abbildung von V nach W.', 'verified', 8),
(3, '3.2.3', 30, 'Rang-Nullitätssatz', 'Ist V endlichdimensional und T:V nach W linear, so ist die Dimension von V gleich der Summe aus der Dimension des Kerns und der Dimension des Bildes.', '\\dim(V)=\\dim\\bigl(\\ker(T)\\bigr)+\\dim\\bigl(\\operatorname{im}(T)\\bigr)', '\\dim(V)=\\dim\\bigl(\\ker(T)\\bigr)+\\dim\\bigl(\\operatorname{im}(T)\\bigr)', 'literature', 72, 'V ist endlichdimensional und T ist eine lineare Abbildung von V nach W.', 'verified', 8),
(4, '3.2.4', 31, 'Vom Skalarprodukt zur Norm', 'In einem Skalarproduktraum definiert die Quadratwurzel des Skalarprodukts eines Vektors mit sich selbst eine Norm.', '\\|v\\|=\\sqrt{\\langle v,v\\rangle}', '\\|v\\|=\\sqrt{\\langle v,v\\rangle}', 'literature', 73, 'V ist ein reeller oder komplexer Skalarproduktraum.', 'verified', 9),
(5, '3.2.5', 31, 'Cauchy-Schwarz-Ungleichung', 'Für alle Vektoren eines Skalarproduktraums ist der Betrag ihres Skalarprodukts höchstens so groß wie das Produkt ihrer Normen.', '|\\langle u,v\\rangle|\\leq\\|u\\|\\,\\|v\\|', '|\\langle u,v\\rangle|\\leq\\|u\\|\\,\\|v\\|', 'literature', 73, 'u und v liegen in einem Skalarproduktraum; die Norm wird durch das Skalarprodukt induziert.', 'verified', 9),
(6, '3.2.6', 31, 'Pythagoreische Beziehung', 'Sind zwei Vektoren in einem Skalarproduktraum orthogonal, so ist das Quadrat der Norm ihrer Summe gleich der Summe der Quadrate ihrer Normen.', '\\|u+v\\|^2=\\|u\\|^2+\\|v\\|^2', '\\|u+v\\|^2=\\|u\\|^2+\\|v\\|^2', 'literature', 73, 'u und v sind orthogonal; die Norm ist durch das Skalarprodukt induziert.', 'verified', 9),
(7, '3.2.7', 32, 'Stetigkeit der Verkettung', 'Sind f:X nach Y und g:Y nach Z stetige Abbildungen zwischen topologischen Räumen, so ist auch ihre Verkettung g∘f:X nach Z stetig.', 'f,g\\text{ stetig}\\quad\\Longrightarrow\\quad g\\circ f\\text{ stetig}', 'f,g\\text{ stetig}\\quad\\Longrightarrow\\quad g\\circ f\\text{ stetig}', 'literature', 74, 'X, Y und Z sind topologische Räume; f:X nach Y und g:Y nach Z sind stetig.', 'verified', 10),
(8, '3.2.8', 33, 'Charakterisierung des Zusammenhangs', 'Ein topologischer Raum X ist genau dann zusammenhängend, wenn die einzigen Teilmengen von X, die zugleich offen und abgeschlossen sind, die leere Menge und X selbst sind.', 'A\\subseteq X,\\quad A\\text{ offen und abgeschlossen}\\quad\\Longrightarrow\\quad A=\\varnothing\\ \\text{oder}\\ A=X', 'A\\subseteq X,\\quad A\\text{ offen und abgeschlossen}\\quad\\Longrightarrow\\quad A=\\varnothing\\ \\text{oder}\\ A=X', 'literature', 74, 'X ist ein topologischer Raum.', 'verified', 11),
(9, '3.2.9', 33, 'Stetige Bilder zusammenhängender Räume', 'Ist X zusammenhängend und f:X nach Y stetig, dann ist das Bild f(X) als Teilraum von Y zusammenhängend.', 'X\\text{ zusammenhängend}\\land f\\text{ stetig}\\quad\\Longrightarrow\\quad f(X)\\text{ zusammenhängend}', 'X\\text{ zusammenhängend}\\land f\\text{ stetig}\\quad\\Longrightarrow\\quad f(X)\\text{ zusammenhängend}', 'literature', 74, 'X und Y sind topologische Räume; f:X nach Y ist stetig.', 'verified', 11),
(10, '3.2.10', 33, 'Wegzusammenhang impliziert Zusammenhang', 'Jeder wegzusammenhängende topologische Raum ist zusammenhängend. Die Umkehrung gilt im Allgemeinen nicht.', 'X\\text{ wegzusammenhängend}\\quad\\Longrightarrow\\quad X\\text{ zusammenhängend}', 'X\\text{ wegzusammenhängend}\\quad\\Longrightarrow\\quad X\\text{ zusammenhängend}', 'literature', 74, 'X ist ein topologischer Raum.', 'verified', 11),
(11, '3.2.11', 33, 'Abgeschlossene Teilmengen kompakter Räume', 'Ist X kompakt und A eine abgeschlossene Teilmenge von X, dann ist A kompakt.', 'X\\text{ kompakt}\\land A\\subseteq X\\text{ abgeschlossen}\\quad\\Longrightarrow\\quad A\\text{ kompakt}', 'X\\text{ kompakt}\\land A\\subseteq X\\text{ abgeschlossen}\\quad\\Longrightarrow\\quad A\\text{ kompakt}', 'literature', 74, 'X ist ein kompakter topologischer Raum und A ist abgeschlossen in X.', 'verified', 11),
(12, '3.2.12', 33, 'Stetige Bilder kompakter Räume', 'Ist X kompakt und f:X nach Y stetig, dann ist das Bild f(X) kompakt.', 'X\\text{ kompakt}\\land f\\text{ stetig}\\quad\\Longrightarrow\\quad f(X)\\text{ kompakt}', 'X\\text{ kompakt}\\land f\\text{ stetig}\\quad\\Longrightarrow\\quad f(X)\\text{ kompakt}', 'literature', 74, 'X und Y sind topologische Räume; X ist kompakt und f:X nach Y ist stetig.', 'verified', 11),
(13, '3.2.13', 34, 'Eindeutigkeit des Grenzwertes in metrischen Räumen', 'Konvergiert eine Folge in einem metrischen Raum sowohl gegen x als auch gegen y, so sind x und y identisch.', 'x_n\\to x\\land x_n\\to y\\quad\\Longrightarrow\\quad x=y', 'x_n\\to x\\land x_n\\to y\\quad\\Longrightarrow\\quad x=y', 'literature', 74, 'Die Folge liegt in einem metrischen Raum.', 'verified', 12),
(14, '3.2.14', 34, 'Konvergenz impliziert die Cauchy-Eigenschaft', 'Jede konvergente Folge in einem metrischen Raum ist eine Cauchy-Folge.', 'x_n\\to x\\quad\\Longrightarrow\\quad(x_n)\\text{ ist eine Cauchy-Folge}', 'x_n\\to x\\quad\\Longrightarrow\\quad(x_n)\\text{ ist eine Cauchy-Folge}', 'literature', 74, 'Die Folge liegt in einem metrischen Raum.', 'verified', 12),
(15, '3.2.15', 34, 'Vollständigkeit abgeschlossener Teilräume', 'Ist ein metrischer Raum X vollständig und A eine abgeschlossene Teilmenge von X, so ist A bezüglich der eingeschränkten Metrik ebenfalls vollständig.', 'X\\text{ vollständig}\\land A\\subseteq X\\text{ abgeschlossen}\\quad\\Longrightarrow\\quad A\\text{ vollständig}', 'X\\text{ vollständig}\\land A\\subseteq X\\text{ abgeschlossen}\\quad\\Longrightarrow\\quad A\\text{ vollständig}', 'literature', 74, 'X ist ein vollständiger metrischer Raum; A ist abgeschlossen in X.', 'verified', 12),
(16, '3.2.16', 34, 'Hilbertraum als spezieller Banachraum', 'Jeder Hilbertraum ist bezüglich seiner vom Skalarprodukt induzierten Norm ein Banachraum.', 'H\\text{ Hilbertraum}\\quad\\Longrightarrow\\quad(H,\\|\\cdot\\|)\\text{ Banachraum}', 'H\\text{ Hilbertraum}\\quad\\Longrightarrow\\quad(H,\\|\\cdot\\|)\\text{ Banachraum}', 'literature', 73, 'H ist ein Hilbertraum und die Norm wird durch das Skalarprodukt induziert.', 'verified', 12),
(17, '3.2.17', 34, 'Konvergente Teilfolgen in kompakten metrischen Räumen', 'Ist X ein kompakter metrischer Raum, so besitzt jede Folge in X eine Teilfolge, die gegen ein Element von X konvergiert.', 'X\\text{ kompakt}\\quad\\Longrightarrow\\quad\\forall(x_n)\\subseteq X\\;\\exists(x_{n_k}),\\,x\\in X:\\;x_{n_k}\\to x', 'X\\text{ kompakt}\\quad\\Longrightarrow\\quad\\forall(x_n)\\subseteq X\\;\\exists(x_{n_k}),\\,x\\in X:\\;x_{n_k}\\to x', 'literature', 74, 'X ist ein kompakter metrischer Raum.', 'verified', 12),
(18, '3.2.18', 34, 'Kompaktheit impliziert Vollständigkeit in metrischen Räumen', 'Jeder kompakte metrische Raum ist vollständig.', 'X\\text{ kompakt und metrisch}\\quad\\Longrightarrow\\quad X\\text{ vollständig}', 'X\\text{ kompakt und metrisch}\\quad\\Longrightarrow\\quad X\\text{ vollständig}', 'literature', 74, 'X ist ein kompakter metrischer Raum.', 'verified', 12),
(19, '3.2.19', 35, 'Vektorraumstruktur eines Funktionenraumes', 'Ist V ein Vektorraum über K, so bildet der Raum aller Funktionen von X nach V mit punktweiser Addition und Skalarmultiplikation einen Vektorraum über K.', 'V\\text{ Vektorraum über }\\mathbb K\\quad\\Longrightarrow\\quad\\mathcal F(X,V)\\text{ Vektorraum über }\\mathbb K', 'V\\text{ Vektorraum über }\\mathbb K\\quad\\Longrightarrow\\quad\\mathcal F(X,V)\\text{ Vektorraum über }\\mathbb K', 'literature', 73, 'Addition und Skalarmultiplikation in F(X,V) werden punktweise definiert.', 'verified', 13),
(20, '3.2.20', 35, 'Vollständigkeit von B(X,K)', 'Für K gleich R oder C ist der Raum aller beschränkten skalarwertigen Funktionen auf X mit der Supremumsnorm ein Banachraum.', '\\bigl(B(X,\\mathbb K),\\|\\cdot\\|_\\infty\\bigr)\\text{ ist Banachraum}', '\\bigl(B(X,\\mathbb K),\\|\\cdot\\|_\\infty\\bigr)\\text{ ist Banachraum}', 'literature', 73, 'K ist R oder C; B(X,K) enthält alle beschränkten K-wertigen Funktionen auf X.', 'verified', 13),
(21, '3.2.21', 35, 'Gleichmäßige Konvergenz impliziert punktweise Konvergenz', 'Jede gleichmäßig konvergente Funktionenfolge konvergiert auch punktweise gegen denselben Grenzwert.', 'f_n\\to f\\text{ gleichmäßig}\\quad\\Longrightarrow\\quad f_n\\to f\\text{ punktweise}', 'f_n\\to f\\text{ gleichmäßig}\\quad\\Longrightarrow\\quad f_n\\to f\\text{ punktweise}', 'literature', 74, 'f_n und f besitzen denselben Definitionsbereich.', 'verified', 13),
(22, '3.2.22', 35, 'Normkonvergenz und gleichmäßige Konvergenz', 'Für beschränkte skalare Funktionen ist gleichmäßige Konvergenz genau die Konvergenz bezüglich der Supremumsnorm.', 'f_n\\to f\\text{ gleichmäßig}\\quad\\Longleftrightarrow\\quad\\|f_n-f\\|_\\infty\\to0', 'f_n\\to f\\text{ gleichmäßig}\\quad\\Longleftrightarrow\\quad\\|f_n-f\\|_\\infty\\to0', 'literature', 74, 'f_n und f liegen in einem Funktionenraum mit endlicher Supremumsnorm.', 'verified', 13),
(23, '3.2.23', 35, 'Stetigkeit gleichmäßiger Grenzwerte', 'Konvergiert eine Folge stetiger Funktionen gleichmäßig gegen f, so ist auch f stetig.', '\\Bigl(\\forall n:\\;f_n\\text{ stetig}\\Bigr)\\land f_n\\to f\\text{ gleichmäßig}\\quad\\Longrightarrow\\quad f\\text{ stetig}', '\\Bigl(\\forall n:\\;f_n\\text{ stetig}\\Bigr)\\land f_n\\to f\\text{ gleichmäßig}\\quad\\Longrightarrow\\quad f\\text{ stetig}', 'literature', 74, 'Die Funktionen f_n besitzen denselben topologischen Definitionsraum und einen geeigneten metrischen Zielraum.', 'verified', 13),
(24, '3.2.24', 35, 'Vollständigkeit von C(X,K) auf kompaktem X', 'Ist X kompakt und K gleich R oder C, so ist der Raum der stetigen skalarwertigen Funktionen auf X mit der Supremumsnorm ein Banachraum.', 'X\\text{ kompakt}\\quad\\Longrightarrow\\quad\\bigl(C(X,\\mathbb K),\\|\\cdot\\|_\\infty\\bigr)\\text{ ist Banachraum}', 'X\\text{ kompakt}\\quad\\Longrightarrow\\quad\\bigl(C(X,\\mathbb K),\\|\\cdot\\|_\\infty\\bigr)\\text{ ist Banachraum}', 'literature', 73, 'X ist kompakt; K ist R oder C.', 'verified', 13),
(25, '3.2.25', 35, 'Beschränktheit des Auswertungsfunktionals', 'Auf einem nichtleeren skalaren Funktionenraum mit Supremumsnorm, der die konstanten Funktionen enthält, ist das Auswertungsfunktional an einem festen Punkt linear und beschränkt; seine Operatornorm ist eins.', '\\operatorname{ev}_x\\text{ linear und beschränkt},\\qquad\\|\\operatorname{ev}_x\\|=1', '\\operatorname{ev}_x\\text{ linear und beschränkt},\\qquad\\|\\operatorname{ev}_x\\|=1', 'literature', 73, 'Der Funktionenraum ist nichtleer, besitzt die Supremumsnorm und enthält konstante Funktionen; x liegt im Definitionsbereich.', 'verified', 13),
(26, '3.2.26', 36, 'Äquivalenz von Beschränktheit und Stetigkeit', 'Für eine lineare Abbildung T zwischen normierten Vektorräumen sind Beschränktheit und Stetigkeit äquivalent. Für lineare Abbildungen genügt bereits die Stetigkeit im Nullvektor.', 'T\\text{ beschränkt}\\quad\\Longleftrightarrow\\quad T\\text{ stetig}', 'T\\text{ beschränkt}\\quad\\Longleftrightarrow\\quad T\\text{ stetig}', 'literature', 73, 'T:X nach Y ist linear; X und Y sind normierte Vektorräume.', 'verified', 14),
(27, '3.2.27', 36, 'Vollständigkeit von B(X,Y)', 'Ist X ein normierter Vektorraum und Y ein Banachraum, dann ist der Raum B(X,Y) der beschränkten linearen Operatoren mit der Operatornorm ein Banachraum.', '\\bigl(\\mathcal B(X,Y),\\|\\cdot\\|\\bigr)\\text{ ist ein Banachraum}', '\\bigl(\\mathcal B(X,Y),\\|\\cdot\\|\\bigr)\\text{ ist ein Banachraum}', 'literature', 73, 'X ist normiert und Y vollständig.', 'verified', 14),
(28, '3.2.28', 36, 'Vollständigkeit des stetigen Dualraumes', 'Für jeden normierten Vektorraum X ist der stetige Dualraum X* mit der Dualnorm ein Banachraum.', 'X^*\\text{ ist ein Banachraum}', 'X^*\\text{ ist ein Banachraum}', 'literature', 73, 'X ist ein normierter Vektorraum über R oder C.', 'verified', 14),
(29, '3.2.29', 36, 'Geschlossenheit des Kerns eines stetigen Funktionals', 'Der Kern eines stetigen linearen Funktionals ist abgeschlossen. Für ein nichttriviales Funktional besitzt der Kern algebraische Kodimension eins.', '\\ker\\varphi\\text{ ist abgeschlossen in }X', '\\ker\\varphi\\text{ ist abgeschlossen in }X', 'literature', 73, 'varphi liegt in X*; für die Kodimensionsaussage gilt varphi ungleich null.', 'verified', 14),
(30, '3.2.30', 36, 'Rieszscher Darstellungssatz für Hilberträume', 'Für jedes stetige lineare Funktional auf einem Hilbertraum existiert bei der verwendeten Konvention eines im ersten Argument linearen Skalarprodukts genau ein repräsentierender Vektor y, sodass varphi(x)=<x,y> für alle x gilt; die Normen stimmen überein.', '\\varphi(x)=\\langle x,y\\rangle,\\qquad\\|\\varphi\\|=\\|y\\|', '\\varphi(x)=\\langle x,y\\rangle,\\qquad\\|\\varphi\\|=\\|y\\|', 'literature', 73, 'H ist ein Hilbertraum; das Skalarprodukt ist gemäß Kapitelkonvention im ersten Argument linear.', 'verified', 14),
(31, '3.2.31', 36, 'Submultiplikativität der Operatornorm', 'Für zwei komponierbare beschränkte lineare Operatoren ist die Norm ihrer Komposition höchstens das Produkt ihrer Operatornormen.', '\\|S\\circ T\\|\\leq\\|S\\|\\,\\|T\\|', '\\|S\\circ T\\|\\leq\\|S\\|\\,\\|T\\|', 'literature', 73, 'T liegt in B(X,Y) und S in B(Y,Z).', 'verified', 14),
(32, '3.2.32', 36, 'Satz vom beschränkten inversen Operator', 'Ist ein beschränkter linearer Operator zwischen Banachräumen bijektiv, so ist seine inverse Abbildung ebenfalls linear, stetig und beschränkt.', 'T\\in\\mathcal B(X,Y)\\text{ bijektiv}\\quad\\Longrightarrow\\quad T^{-1}\\in\\mathcal B(Y,X)', 'T\\in\\mathcal B(X,Y)\\text{ bijektiv}\\quad\\Longrightarrow\\quad T^{-1}\\in\\mathcal B(Y,X)', 'literature', 73, 'X und Y sind Banachräume; T ist bijektiv und beschränkt linear.', 'verified', 14),
(33, '3.2.33', 37, 'Eigenräume sind lineare Teilräume', 'Für jeden Eigenwert lambda eines linearen Operators ist der zugehörige Eigenraum ein linearer Teilraum des Zustandsraumes.', 'E_\\lambda\\leq X', 'E_\\lambda\\leq X', 'literature', 72, 'lambda ist Eigenwert von T.', 'verified', 15),
(34, '3.2.34', 37, 'Lineare Unabhängigkeit zu verschiedenen Eigenwerten', 'Eigenvektoren zu paarweise verschiedenen Eigenwerten eines linearen Operators sind linear unabhängig.', '\\lambda_i\\neq\\lambda_j\\text{ für }i\\neq j\\Longrightarrow\\{v_1,\\ldots,v_m\\}\\text{ linear unabhängig}', '\\lambda_i\\neq\\lambda_j\\text{ für }i\\neq j\\Longrightarrow\\{v_1,\\ldots,v_m\\}\\text{ linear unabhängig}', 'literature', 72, 'v_i sind Eigenvektoren zu paarweise verschiedenen Eigenwerten lambda_i.', 'verified', 15),
(35, '3.2.35', 37, 'Eigenbasis und Diagonalisierbarkeit', 'Ein endlichdimensionaler linearer Operator ist genau dann diagonalisierbar, wenn der Zustandsraum eine Basis aus Eigenvektoren besitzt.', 'A\\text{ diagonalisierbar}\\Longleftrightarrow X\\text{ besitzt eine Basis aus Eigenvektoren von }A', 'A\\text{ diagonalisierbar}\\Longleftrightarrow X\\text{ besitzt eine Basis aus Eigenvektoren von }A', 'literature', 72, 'X ist endlichdimensional und A ist die Matrixdarstellung des Operators.', 'verified', 15),
(36, '3.2.36', 37, 'Eigenwerte gehören zum Spektrum', 'Jeder Eigenwert eines beschränkten linearen Operators gehört zu dessen Spektrum. In unendlichdimensionalen Räumen muss nicht jeder Spektralwert ein Eigenwert sein.', '\\sigma_p(T)\\subseteq\\sigma(T)', '\\sigma_p(T)\\subseteq\\sigma(T)', 'literature', 73, 'T liegt in B(X) auf einem komplexen Banachraum.', 'verified', 15),
(37, '3.2.37', 37, 'Nichtleere Kompaktheit und Normschranke des Spektrums', 'Für einen beschränkten Operator auf einem nichttrivialen komplexen Banachraum ist das Spektrum nichtleer, kompakt und in der abgeschlossenen Kreisscheibe mit Radius der Operatornorm enthalten.', '\\varnothing\\neq\\sigma(T)\\subseteq\\{\\lambda\\in\\mathbb C\\mid|\\lambda|\\leq\\|T\\|\\}', '\\varnothing\\neq\\sigma(T)\\subseteq\\{\\lambda\\in\\mathbb C\\mid|\\lambda|\\leq\\|T\\|\\}', 'literature', 73, 'X ist nichttrivialer komplexer Banachraum; T liegt in B(X).', 'verified', 15),
(38, '3.2.38', 37, 'Spektralradiusformel', 'Der Spektralradius eines beschränkten Operators auf einem komplexen Banachraum ist der Grenzwert der n-ten Wurzeln der Operatornormen seiner Potenzen.', 'r(T)=\\lim_{n\\to\\infty}\\|T^n\\|^{1/n}', 'r(T)=\\lim_{n\\to\\infty}\\|T^n\\|^{1/n}', 'literature', 73, 'T liegt in B(X) auf einem komplexen Banachraum.', 'verified', 15),
(39, '3.2.39', 37, 'Eigenräume sind invariant', 'Jeder Eigenraum eines linearen Operators ist unter diesem Operator invariant.', 'T(E_\\lambda)\\subseteq E_\\lambda', 'T(E_\\lambda)\\subseteq E_\\lambda', 'literature', 73, 'lambda ist Eigenwert von T.', 'verified', 15),
(40, '3.2.40', 38, 'Geschlossenheit des orthogonalen Komplements', 'Für jede Teilmenge M eines Hilbertraumes ist M^perp ein abgeschlossener linearer Teilraum.', 'M^\\perp\\leq H\\qquad\\text{und}\\qquad M^\\perp\\text{ ist abgeschlossen}', 'M^\\perp\\leq H\\qquad\\text{und}\\qquad M^\\perp\\text{ ist abgeschlossen}', 'literature', 73, 'H ist Hilbertraum; M ist Teilmenge von H.', 'verified', 16),
(41, '3.2.41', 38, 'Orthogonaler Projektionssatz', 'Ist M ein abgeschlossener linearer Teilraum eines Hilbertraumes H, so zerfällt H eindeutig als orthogonale direkte Summe von M und M^perp.', 'H=M\\oplus^\\perp M^\\perp', 'H=M\\oplus^\\perp M^\\perp', 'literature', 73, 'H ist Hilbertraum; M ist abgeschlossener linearer Teilraum.', 'verified', 16),
(42, '3.2.42', 38, 'Normzerlegung orthogonaler Komponenten', 'Für eine orthogonale Zerlegung x=m+n mit m orthogonal n gilt die pythagoreische Normidentität.', '\\|x\\|^2=\\|m\\|^2+\\|n\\|^2', '\\|x\\|^2=\\|m\\|^2+\\|n\\|^2', 'literature', 73, 'H ist Hilbertraum; x=m+n und m ist orthogonal zu n.', 'verified', 16),
(43, '3.2.43', 38, 'Zerlegung durch einen Projektionsoperator', 'Für jede lineare Projektion P zerfällt der Vektorraum algebraisch als direkte Summe aus Bild und Kern von P.', 'X=\\operatorname{ran}P\\oplus\\ker P', 'X=\\operatorname{ran}P\\oplus\\ker P', 'literature', 73, 'P:X nach X ist linear und P^2=P.', 'verified', 16),
(44, '3.2.44', 38, 'Beste Approximation durch orthogonale Projektion', 'Für einen abgeschlossenen Teilraum M eines Hilbertraumes ist P_M x das eindeutig nächstgelegene Element von M zu x.', '\\|x-P_Mx\\|=\\inf_{m\\in M}\\|x-m\\|', '\\|x-P_Mx\\|=\\inf_{m\\in M}\\|x-m\\|', 'literature', 73, 'H ist Hilbertraum; M ist abgeschlossener linearer Teilraum.', 'verified', 16),
(45, '3.2.45', 38, 'Normeigenschaften orthogonaler Projektionen', 'Eine orthogonale Projektion ist kontraktiv; für einen nichttrivialen Projektionsraum besitzt sie Operatornorm eins.', '\\|P_Mx\\|\\leq\\|x\\|,\\qquad M\\neq\\{0\\}\\Longrightarrow\\|P_M\\|=1', '\\|P_Mx\\|\\leq\\|x\\|,\\qquad M\\neq\\{0\\}\\Longrightarrow\\|P_M\\|=1', 'literature', 73, 'M ist abgeschlossener linearer Teilraum eines Hilbertraumes.', 'verified', 16),
(46, '3.2.46', 38, 'Eine invertierbare Projektion ist die Identität', 'Ist eine lineare Projektion invertierbar, so muss sie der Identitätsoperator sein.', 'P^2=P\\land P\\text{ invertierbar}\\Longrightarrow P=I', 'P^2=P\\land P\\text{ invertierbar}\\Longrightarrow P=I', 'literature', 73, 'P ist lineare Projektion.', 'verified', 16),
(47, '3.2.47', 38, 'Kommutationskriterium für reduzierende Teilräume', 'Ein abgeschlossener Teilraum M reduziert einen beschränkten Operator T genau dann, wenn die orthogonale Projektion P_M mit T kommutiert.', 'M\\text{ reduziert }T\\Longleftrightarrow TP_M=P_MT', 'M\\text{ reduziert }T\\Longleftrightarrow TP_M=P_MT', 'literature', 73, 'H ist Hilbertraum; M ist abgeschlossen; T liegt in B(H).', 'verified', 16),
(48, '3.2.55', 39, 'Lokale Existenz und Eindeutigkeit unter einer Lipschitz-Bedingung', 'Ist F in einer Umgebung des Anfangspunktes stetig und bezüglich der Zustandsvariablen lokal Lipschitz-stetig, so besitzt das zugehörige Anfangswertproblem lokal eine eindeutig bestimmte Lösung.', '\\begin{cases}x\'(t)=F(t,x(t)),\\\\x(t_0)=x_0\\end{cases}\\quad\\text{besitzt lokal eine eindeutige Lösung}', '\\begin{cases}x\'(t)=F(t,x(t)),\\\\x(t_0)=x_0\\end{cases}\\quad\\text{besitzt lokal eine eindeutige Lösung}', 'literature', 75, 'F ist lokal stetig und lokal Lipschitz in der Zustandsvariablen.', 'verified', 17),
(49, '3.2.56', 39, 'Ein Gleichgewicht erzeugt eine konstante Lösung', 'Ist F(x_*)=0 in einem autonomen System, so ist die konstante Funktion x(t)=x_* eine Lösung.', 'F(x_*)=0\\Longrightarrow x(t)=x_*\\text{ ist eine Lösung}', 'F(x_*)=0\\Longrightarrow x(t)=x_*\\text{ ist eine Lösung}', 'literature', 75, 'Das System x\'=F(x) ist autonom.', 'verified', 17),
(50, '3.2.57', 39, 'Superpositionsprinzip für homogene lineare ODE-Systeme', 'Linearkombinationen von Lösungen eines homogenen linearen gewöhnlichen Differentialgleichungssystems sind wieder Lösungen.', 'x_1,x_2\\text{ Lösungen}\\Longrightarrow \\alpha x_1+\\beta x_2\\text{ Lösung}', 'x_1,x_2\\text{ Lösungen}\\Longrightarrow \\alpha x_1+\\beta x_2\\text{ Lösung}', 'literature', 75, 'Das System ist homogen und linear; alpha und beta sind Skalare.', 'verified', 17),
(51, '3.2.58', 39, 'Superposition homogener linearer Differentialprobleme', 'Der Kern eines linearen Differentialoperators ist unter Linearkombinationen abgeschlossen; daher ist jede Linearkombination homogener Lösungen wieder eine homogene Lösung.', 'u_1,u_2\\in\\ker A\\Longrightarrow\\alpha u_1+\\beta u_2\\in\\ker A', 'u_1,u_2\\in\\ker A\\Longrightarrow\\alpha u_1+\\beta u_2\\in\\ker A', 'literature', 73, 'A ist ein linearer Operator mit linearem Definitionsbereich.', 'verified', 17),
(52, '3.2.59', 40, 'Flusseigenschaft autonomer eindeutig lösbarer Systeme', 'Für ein autonomes Anfangswertproblem mit eindeutigen Lösungen gilt überall dort, wo beide Seiten definiert sind, die Flusseigenschaft.', '\\Phi(t+s,x)=\\Phi\\left(t,\\Phi(s,x)\\right)', '\\Phi(t+s,x)=\\Phi\\left(t,\\Phi(s,x)\\right)', 'literature', 75, 'Lokale Existenz und Eindeutigkeit des autonomen Anfangswertproblems.', 'verified', 18),
(53, '3.2.60', 40, 'Inverse einer Flussabbildung', 'Bei einem globalen Fluss ist jede Flussabbildung invertierbar und ihre Inverse wird durch den negativen Parameter gegeben.', '\\Phi_t^{-1}=\\Phi_{-t}', '\\Phi_t^{-1}=\\Phi_{-t}', 'literature', 75, 'Phi ist ein globaler Fluss für alle reellen Parameterwerte.', 'verified', 18),
(54, '3.2.61', 40, 'Invarianz eines Orbits unter einem globalen Fluss', 'Der Orbit eines Zustandes wird durch jede Flussabbildung auf sich selbst abgebildet.', '\\Phi_s\\left(\\mathcal O(x)\\right)=\\mathcal O(x)', '\\Phi_s\\left(\\mathcal O(x)\\right)=\\mathcal O(x)', 'literature', 75, 'Phi ist ein globaler Fluss.', 'verified', 18),
(55, '3.2.62', 40, 'Äquivalenz von Gleichgewicht und Flussfixpunkt', 'Für den Fluss eines autonomen Systems ist ein Zustand genau dann Gleichgewicht des Vektorfeldes, wenn er Fixpunkt aller Flussabbildungen ist.', 'f(x_*)=0\\Longleftrightarrow\\Phi_t(x_*)=x_*\\text{ für alle }t', 'f(x_*)=0\\Longleftrightarrow\\Phi_t(x_*)=x_*\\text{ für alle }t', 'literature', 75, 'Phi ist der von x\'=f(x) erzeugte eindeutig bestimmte Fluss.', 'verified', 18),
(56, '3.2.63', 40, 'Eindeutigkeit der Zustandsherkunft bei einem globalen Fluss', 'Bei einem globalen Fluss können zwei verschiedene Anfangszustände unter derselben Flussabbildung nicht auf denselben Zustand abgebildet werden.', '\\Phi_t(x)=\\Phi_t(y)\\Longrightarrow x=y', '\\Phi_t(x)=\\Phi_t(y)\\Longrightarrow x=y', 'literature', 75, 'Phi ist ein globaler Fluss.', 'verified', 18),
(57, '3.2.64', 40, 'Fluss eines linearen autonomen Systems', 'Für das lineare autonome System x\'=Ax wird der Fluss durch die Matrix- beziehungsweise Operatorexponentialfunktion erzeugt.', '\\Phi_t=e^{tA}', '\\Phi_t=e^{tA}', 'literature', 75, 'A ist eine konstante lineare Abbildung beziehungsweise endlichdimensionale Matrix.', 'verified', 18),
(58, '3.2.65', 40, 'Verkettungseigenschaft der Evolutionsoperatoren', 'Bei eindeutiger nichtautonomer Zustandsentwicklung erfüllt der zweiparametrige Evolutionsoperator die Konsistenzrelation U(t,s) o U(s,r)=U(t,r).', 'U(t,s)\\circ U(s,r)=U(t,r)', 'U(t,s)\\circ U(s,r)=U(t,r)', 'literature', 75, 'Die nichtautonome Zustandsentwicklung ist eindeutig bestimmt.', 'verified', 18),
(59, '3.2.66', 41, 'Asymptotische Stabilität impliziert Lyapunov-Stabilität', 'Jedes asymptotisch stabile Gleichgewicht ist insbesondere Lyapunov-stabil.', '\\text{asymptotisch stabil}\\Longrightarrow\\text{Lyapunov-stabil}', '\\text{asymptotisch stabil}\\Longrightarrow\\text{Lyapunov-stabil}', 'literature', 75, 'Asymptotische Stabilität ist gemäß Definition gegeben.', 'verified', 19),
(60, '3.2.67', 41, 'Exponentielle Stabilität impliziert asymptotische Stabilität', 'Eine exponentielle Stabilitätsabschätzung mit positiver Abklingrate impliziert Konvergenz zum Gleichgewicht und damit asymptotische Stabilität.', '\\text{exponentiell stabil}\\Longrightarrow\\text{asymptotisch stabil}', '\\text{exponentiell stabil}\\Longrightarrow\\text{asymptotisch stabil}', 'literature', 75, 'Es existieren C>=1 und alpha>0 mit der exponentiellen Stabilitätsabschätzung.', 'verified', 19),
(61, '3.2.68', 41, 'Lyapunov-Stabilität durch eine nicht zunehmende Lyapunov-Funktion', 'Ist V bezüglich eines Gleichgewichts positiv definit und entlang der Dynamik nicht zunehmend, so liefert V unter den üblichen Regularitätsvoraussetzungen ein Kriterium für Lyapunov-Stabilität.', 'V>0,\\qquad\\dot V\\leq0\\Longrightarrow\\text{Stabilität}', 'V>0,\\qquad\\dot V\\leq0\\Longrightarrow\\text{Stabilität}', 'literature', 75, 'V ist positiv definit bezüglich des Gleichgewichts und hinreichend regulär; die Ableitung entlang der Dynamik ist nicht positiv.', 'verified', 19),
(62, '3.2.69', 41, 'Asymptotische Stabilität durch eine strikt abnehmende Lyapunov-Funktion', 'Ist V positiv definit und ihre Ableitung entlang der Dynamik außerhalb des Gleichgewichts negativ definit, so ist das Gleichgewicht unter geeigneten Regularitätsvoraussetzungen lokal asymptotisch stabil.', 'V(x)>0,\\quad\\dot V(x)<0\\ (x\\neq x_*)\\Longrightarrow x_*\\text{ lokal asymptotisch stabil}', 'V(x)>0,\\quad\\dot V(x)<0\\ (x\\neq x_*)\\Longrightarrow x_*\\text{ lokal asymptotisch stabil}', 'literature', 75, 'V und die Dynamik erfüllen die Voraussetzungen der direkten Lyapunov-Methode.', 'verified', 19),
(63, '3.2.70', 41, 'Spektrales Stabilitätskriterium für lineare autonome Systeme', 'Für ein endlichdimensionales lineares autonomes System sind ausschließlich negative Realteile aller Eigenwerte des Erzeugers hinreichend für exponentielle asymptotische Stabilität; ein positiver Realteil erzeugt eine instabile Richtung.', '\\max_{\\lambda\\in\\sigma(A)}\\operatorname{Re}\\lambda<0\\Longrightarrow\\text{exponentielle asymptotische Stabilität}', '\\max_{\\lambda\\in\\sigma(A)}\\operatorname{Re}\\lambda<0\\Longrightarrow\\text{exponentielle asymptotische Stabilität}', 'literature', 75, 'A ist eine endlichdimensionale Matrix.', 'verified', 19),
(64, '3.2.71', 41, 'Lokale asymptotische Stabilität durch die Linearisierung', 'Besitzen sämtliche Eigenwerte der Jacobi-Matrix am Gleichgewicht negative Realteile, so ist das Gleichgewicht eines hinreichend differenzierbaren endlichdimensionalen Systems lokal asymptotisch stabil.', '\\max_{\\lambda\\in\\sigma(Df(x_*))}\\operatorname{Re}\\lambda<0\\Longrightarrow x_*\\text{ lokal asymptotisch stabil}', '\\max_{\\lambda\\in\\sigma(Df(x_*))}\\operatorname{Re}\\lambda<0\\Longrightarrow x_*\\text{ lokal asymptotisch stabil}', 'literature', 75, 'Das System ist endlichdimensional und hinreichend differenzierbar.', 'verified', 19),
(65, '3.2.72', 41, 'Positive Spektralrichtung impliziert lokale Instabilität', 'Besitzt die Linearisierung am Gleichgewicht mindestens einen Eigenwert mit positivem Realteil, so ist das Gleichgewicht lokal instabil.', '\\exists\\lambda\\in\\sigma(Df(x_*)):\\operatorname{Re}\\lambda>0\\Longrightarrow x_*\\text{ instabil}', '\\exists\\lambda\\in\\sigma(Df(x_*)):\\operatorname{Re}\\lambda>0\\Longrightarrow x_*\\text{ instabil}', 'literature', 75, 'Das System ist endlichdimensional und hinreichend differenzierbar.', 'verified', 19),
(66, '3.2.73', 42, 'Abgeschlossenheit und Invarianz der Grenzmenge', 'Eine definierte positive beziehungsweise negative Omega-Grenzmenge ist abgeschlossen und unter dem betrachteten Fluss invariant.', '\\Phi_s\\left(\\omega^\\pm(x)\\right)=\\omega^\\pm(x)', '\\Phi_s\\left(\\omega^\\pm(x)\\right)=\\omega^\\pm(x)', 'literature', 75, 'Die entsprechende Grenzmenge ist definiert und der Fluss für die benötigten Parameterwerte vorhanden.', 'verified', 20),
(67, '3.2.74', 42, 'Nichtleere kompakte Grenzmenge bei kompakter Orbitbeschränkung', 'Liegt der positive Orbit eines Zustandes in einer kompakten Menge, so ist die positive Omega-Grenzmenge nichtleer und kompakt.', '\\mathcal O^+(x)\\subseteq K,\\quad K\\text{ kompakt}\\Longrightarrow\\omega^+(x)\\neq\\varnothing\\text{ und }\\omega^+(x)\\text{ kompakt}', '\\mathcal O^+(x)\\subseteq K,\\quad K\\text{ kompakt}\\Longrightarrow\\omega^+(x)\\neq\\varnothing\\text{ und }\\omega^+(x)\\text{ kompakt}', 'literature', 75, 'Der positive Orbit ist vollständig in einer kompakten Menge enthalten.', 'verified', 20),
(68, '3.2.75', 42, 'Asymptotische Annäherung an die Omega-Grenzmenge', 'Liegt der positive Orbit eines Zustandes in einer kompakten Menge, so konvergiert der Abstand seiner Trajektorie zur eigenen positiven Omega-Grenzmenge gegen null.', '\\lim_{t\\to\\infty}d\\left(\\Phi_t(x),\\omega^+(x)\\right)=0', '\\lim_{t\\to\\infty}d\\left(\\Phi_t(x),\\omega^+(x)\\right)=0', 'literature', 75, 'Der positive Orbit ist in einer kompakten Menge enthalten.', 'verified', 20),
(69, '3.2.76', 42, 'Fanggebiet erzeugt eine kompakte anziehende Grenzmenge', 'Die positive Omega-Grenzmenge eines Fanggebietes ist unter den betrachteten Voraussetzungen nichtleer, kompakt, invariant, zusammenhängend und anziehend.', '\\Lambda=\\omega^+(E)=\\bigcap_{t\\geq0}\\overline{\\Phi_t(E)}', '\\Lambda=\\omega^+(E)=\\bigcap_{t\\geq0}\\overline{\\Phi_t(E)}', 'literature', 75, 'E ist ein Fanggebiet mit den in Definition 3.2.138 genannten Eigenschaften.', 'verified', 20),
(70, '3.2.77', 43, 'Kartenunabhängigkeit der Glattheit', 'Die Glattheit einer Mannigfaltigkeitsabbildung ist unabhängig von der Wahl kompatibler Karten des festgelegten glatten Atlasses.', '\\widehat F=\\psi\\circ F\\circ\\varphi^{-1}', '\\widehat F=\\psi\\circ F\\circ\\varphi^{-1}', 'literature', 77, 'Die verwendeten Karten sind glatt verträglich.', 'verified', 21),
(71, '3.2.78', 43, 'Verkettung glatter Mannigfaltigkeitsabbildungen', 'Die Verkettung zweier glatter Abbildungen zwischen glatten Mannigfaltigkeiten ist wieder glatt.', 'G\\circ F:M\\longrightarrow P', 'G\\circ F:M\\longrightarrow P', 'literature', 77, 'F:M->N und G:N->P sind glatt.', 'verified', 21),
(72, '3.2.79', 43, 'Dimension des Tangentialraumes', 'Für eine glatte n-Mannigfaltigkeit M besitzt jeder Tangentialraum T_pM die Dimension n.', '\\dim T_pM=n', '\\dim T_pM=n', 'literature', 77, 'M ist eine glatte n-Mannigfaltigkeit.', 'verified', 21),
(73, '3.2.80', 43, 'Transformationsregel der Koordinatenbasis', 'Bei einem glatten Koordinatenwechsel transformiert sich die Koordinatenbasis des Tangentialraumes mit der Jacobi-Matrix des Koordinatenwechsels.', '\\left.\\frac{\\partial}{\\partial x^i}\\right|_p=\\sum_{j=1}^{n}\\left.\\frac{\\partial y^j}{\\partial x^i}\\right|_p\\left.\\frac{\\partial}{\\partial y^j}\\right|_p', '\\left.\\frac{\\partial}{\\partial x^i}\\right|_p=\\sum_{j=1}^{n}\\left.\\frac{\\partial y^j}{\\partial x^i}\\right|_p\\left.\\frac{\\partial}{\\partial y^j}\\right|_p', 'literature', 77, 'x und y sind glatt verträgliche lokale Koordinatensysteme in einer Umgebung von p.', 'verified', 21),
(74, '3.2.81', 43, 'Linearität des Differentials', 'Das Differential einer glatten Mannigfaltigkeitsabbildung ist an jedem Punkt eine lineare Abbildung zwischen den zugehörigen Tangentialräumen.', 'dF_p(\\alpha v+\\beta w)=\\alpha\\,dF_p(v)+\\beta\\,dF_p(w)', 'dF_p(\\alpha v+\\beta w)=\\alpha\\,dF_p(v)+\\beta\\,dF_p(w)', 'literature', 77, 'F ist glatt; v und w liegen in T_pM.', 'verified', 21),
(75, '3.2.82', 43, 'Kettenregel für Differentiale', 'Für glatte Abbildungen F:M->N und G:N->P gilt d(G o F)_p=dG_{F(p)} o dF_p.', 'd(G\\circ F)_p=dG_{F(p)}\\circ dF_p', 'd(G\\circ F)_p=dG_{F(p)}\\circ dF_p', 'literature', 77, 'F und G sind glatt.', 'verified', 21),
(76, '3.2.83', 43, 'Koordinatendarstellung des Differentials', 'In lokalen Koordinaten wird das Differential dF_p durch die Jacobi-Matrix der lokalen Koordinatendarstellung von F repräsentiert.', '[dF_p]=\\left(\\frac{\\partial F^a}{\\partial x^i}(p)\\right)', '[dF_p]=\\left(\\frac{\\partial F^a}{\\partial x^i}(p)\\right)', 'literature', 77, 'Lokale Koordinaten x auf M und y auf N sind gewählt.', 'verified', 21),
(84, '3.2.84', 45, 'Trägheitssatz für symmetrische Bilinearformen', 'Die Anzahl positiver und negativer Diagonaleinträge einer Diagonalisierung einer reellen nicht ausgearteten symmetrischen Bilinearform ist basisunabhängig.', '\\operatorname{ind}(g)=\\text{basisunabhängig}', '\\operatorname{ind}(g)=\\text{basisunabhängig}', 'literature', 78, 'g ist eine reelle nicht ausgeartete symmetrische Bilinearform.', 'verified', 23),
(85, '3.2.85', 45, 'Erhaltung des Index unter Koordinatenwechsel', 'Ein glatter Koordinatenwechsel verändert die Darstellungsmatrix der Metrik, nicht aber den Index der zugrunde liegenden nicht ausgearteten symmetrischen Bilinearform.', '\\operatorname{ind}(\\widetilde G)=\\operatorname{ind}(G)', '\\operatorname{ind}(\\widetilde G)=\\operatorname{ind}(G)', 'literature', 78, 'G und G-Tilde repräsentieren dieselbe Metrik in zwei lokalen Koordinatensystemen.', 'verified', 23),
(86, '3.2.86', 45, 'Isometrien erhalten die metrische Klassifikation', 'Eine Isometrie erhält das metrische Selbstprodukt eines Tangentialvektors und damit im lorentzschen Fall dessen zeitartige, lichtartige oder raumartige Klasse.', 'h_{F(p)}\\bigl(dF_p(v),dF_p(v)\\bigr)=g_p(v,v)', 'h_{F(p)}\\bigl(dF_p(v),dF_p(v)\\bigr)=g_p(v,v)', 'literature', 78, 'F ist eine Isometrie pseudo-riemannscher Mannigfaltigkeiten.', 'verified', 23),
(87, '3.2.87', 46, 'Fundamentalsatz der pseudo-riemannschen Geometrie', 'Auf jeder pseudo-riemannschen Mannigfaltigkeit existiert genau ein Zusammenhang, der torsionsfrei und metrisch verträglich ist. Dieser Zusammenhang heißt Levi-Civita-Zusammenhang.', 'T=0,\\qquad\\nabla g=0', 'T=0,\\qquad\\nabla g=0', 'literature', 78, 'M ist eine pseudo-riemannsche Mannigfaltigkeit.', 'verified', 24),
(88, '3.2.88', 46, 'Koszul-Formel', 'Der Levi-Civita-Zusammenhang wird intrinsisch durch die Metrik und die Lie-Klammer über die Koszul-Formel bestimmt.', '2g(\\nabla_XY,Z)=Xg(Y,Z)+Yg(Z,X)-Zg(X,Y)-g(X,[Y,Z])+g(Y,[Z,X])+g(Z,[X,Y])', '2g(\\nabla_XY,Z)=Xg(Y,Z)+Yg(Z,X)-Zg(X,Y)-g(X,[Y,Z])+g(Y,[Z,X])+g(Z,[X,Y])', 'literature', 78, 'nabla ist der Levi-Civita-Zusammenhang der pseudo-riemannschen Metrik g.', 'verified', 24),
(89, '3.2.89', 46, 'Christoffel-Symbole der Levi-Civita-Verbindung', 'In lokalen Koordinaten werden die Zusammenhangskoeffizienten des Levi-Civita-Zusammenhangs durch die Metrikkoeffizienten und deren erste Ableitungen bestimmt.', '\\Gamma^k_{ij}=\\frac{1}{2}g^{k\\ell}\\left(\\frac{\\partial g_{\\ell j}}{\\partial x^i}+\\frac{\\partial g_{i\\ell}}{\\partial x^j}-\\frac{\\partial g_{ij}}{\\partial x^\\ell}\\right)', '\\Gamma^k_{ij}=\\frac{1}{2}g^{k\\ell}\\left(\\frac{\\partial g_{\\ell j}}{\\partial x^i}+\\frac{\\partial g_{i\\ell}}{\\partial x^j}-\\frac{\\partial g_{ij}}{\\partial x^\\ell}\\right)', 'literature', 78, 'g ist nicht ausgeartet und glatt; lokale Koordinaten sind gewählt.', 'verified', 24),
(90, '3.2.90', 46, 'Linearität des Paralleltransports', 'Für eine feste Kurve ist der Paralleltransport eine lineare Abbildung zwischen den Tangentialräumen an Anfangs- und Endpunkt.', 'P^\\gamma_{a\\to b}(\\alpha v+\\beta w)=\\alpha P^\\gamma_{a\\to b}(v)+\\beta P^\\gamma_{a\\to b}(w)', 'P^\\gamma_{a\\to b}(\\alpha v+\\beta w)=\\alpha P^\\gamma_{a\\to b}(v)+\\beta P^\\gamma_{a\\to b}(w)', 'literature', 78, 'Die Kurve und der Zusammenhang sind festgelegt.', 'verified', 24),
(91, '3.2.91', 46, 'Invertierbarkeit des Paralleltransports', 'Der Paralleltransport entlang einer Kurve ist invertierbar; seine Inverse ist der Paralleltransport entlang der umgekehrt parametrisierten Kurve.', '\\left(P^\\gamma_{a\\to b}\\right)^{-1}=P^{\\bar\\gamma}_{b\\to a}', '\\left(P^\\gamma_{a\\to b}\\right)^{-1}=P^{\\bar\\gamma}_{b\\to a}', 'literature', 78, 'Der Paralleltransport ist entlang der Kurve und ihrer Umkehr definiert.', 'verified', 24),
(92, '3.2.92', 46, 'Erhaltung der Metrik durch Paralleltransport', 'Beim Levi-Civita-Paralleltransport bleibt die metrische Paarung zweier paralleler Vektorfelder entlang derselben Kurve konstant.', 'g_{\\gamma(b)}\\left(P^\\gamma_{a\\to b}v,P^\\gamma_{a\\to b}w\\right)=g_{\\gamma(a)}(v,w)', 'g_{\\gamma(b)}\\left(P^\\gamma_{a\\to b}v,P^\\gamma_{a\\to b}w\\right)=g_{\\gamma(a)}(v,w)', 'literature', 78, 'nabla ist der Levi-Civita-Zusammenhang von g.', 'verified', 24),
(93, '3.2.93', 47, 'Lokale Existenz und Eindeutigkeit von Geodäten', 'Zu jedem Punkt p und jedem Tangentialvektor v in T_pM existiert eine eindeutig bestimmte maximale Geodäte gamma_v mit gamma_v(0)=p und dot gamma_v(0)=v.', '\\gamma_v(0)=p,\\qquad\\dot\\gamma_v(0)=v', '\\gamma_v(0)=p,\\qquad\\dot\\gamma_v(0)=v', 'literature', 78, 'M ist glatt und der Levi-Civita-Zusammenhang besitzt glatte Zusammenhangskoeffizienten.', 'verified', 25),
(94, '3.2.94', 47, 'Konstanz der geodätischen Geschwindigkeit', 'Für eine affin parametrisierte Geodäte ist das metrische Selbstprodukt ihres Tangentialvektors konstant.', '\\frac{d}{dt}g(\\dot\\gamma,\\dot\\gamma)=0', '\\frac{d}{dt}g(\\dot\\gamma,\\dot\\gamma)=0', 'literature', 78, 'gamma ist eine affin parametrisierte Geodäte des Levi-Civita-Zusammenhangs.', 'verified', 25),
(95, '3.2.95', 47, 'Differential der Exponentialabbildung im Nullvektor', 'Das Differential der Exponentialabbildung exp_p im Nullvektor ist die Identität von T_pM.', 'd(\\exp_p)_0=I_{T_pM}', 'd(\\exp_p)_0=I_{T_pM}', 'literature', 78, 'exp_p ist in einer Umgebung des Nullvektors definiert.', 'verified', 25),
(96, '3.2.96', 47, 'Tensorialität des Krümmungsoperators', 'Der Krümmungsoperator ist in seinen Argumenten tensorial; sein Wert an einem Punkt hängt nur von den dortigen Tangentialvektoren ab.', 'R(fX,Y)Z=fR(X,Y)Z', 'R(fX,Y)Z=fR(X,Y)Z', 'literature', 78, 'Ein affiner Zusammenhang ist gegeben.', 'verified', 25),
(97, '3.2.97', 47, 'Algebraische Symmetrien des Krümmungstensors', 'Der vollständig kovariante Krümmungstensor des Levi-Civita-Zusammenhangs besitzt die Antisymmetrien in den beiden Argumentpaaren, die Paarsymmetrie und erfüllt die erste Bianchi-Identität.', 'R(X,Y)Z+R(Y,Z)X+R(Z,X)Y=0', 'R(X,Y)Z+R(Y,Z)X+R(Z,X)Y=0', 'literature', 78, 'nabla ist der Levi-Civita-Zusammenhang.', 'verified', 25),
(98, '3.2.98', 47, 'Basisunabhängigkeit der Schnittkrümmung', 'Die Schnittkrümmung einer nicht ausgearteten zweidimensionalen Tangentialebene hängt nicht von der gewählten Basis dieser Ebene ab.', 'K=K(p,\\Pi)', 'K=K(p,\\Pi)', 'literature', 78, 'Pi ist eine nicht ausgeartete zweidimensionale Tangentialebene.', 'verified', 25),
(99, '3.2.99', 47, 'Jacobi-Gleichung geodätischer Variationen', 'Das Variationsfeld einer glatten Variation durch Geodäten erfüllt die Jacobi-Gleichung.', '\\frac{D^2J}{dt^2}+R(J,\\dot\\gamma)\\dot\\gamma=0', '\\frac{D^2J}{dt^2}+R(J,\\dot\\gamma)\\dot\\gamma=0', 'literature', 78, 'Es liegt eine glatte Variation durch Geodäten vor.', 'verified', 25),
(100, '3.2.100', 48, 'Offenheit von I^±(p)', 'Für jeden Punkt p einer zeitorientierten lorentzschen Mannigfaltigkeit sind die chronologische Zukunft I^+(p) und die chronologische Vergangenheit I^-(p) offen.', 'I^+(p)\\subseteq M\\quad\\text{offen}', 'I^+(p)\\subseteq M\\quad\\text{offen}', 'literature', 78, 'M ist zeitorientiert.', 'verified', 26),
(101, '3.2.101', 48, 'Transitivität der chronologischen Relation', 'Sind p chronologisch vor q und q chronologisch vor r, so ist p chronologisch vor r.', 'p\\ll q,\\quad q\\ll r\\Longrightarrow p\\ll r', 'p\\ll q,\\quad q\\ll r\\Longrightarrow p\\ll r', 'literature', 78, 'M ist zeitorientiert.', 'verified', 26),
(102, '3.2.102', 48, 'Transitivität der kausalen Relation', 'Sind p kausal vor q und q kausal vor r, so ist p kausal vor r.', 'p\\leq q,\\quad q\\leq r\\Longrightarrow p\\leq r', 'p\\leq q,\\quad q\\leq r\\Longrightarrow p\\leq r', 'literature', 78, 'M ist zeitorientiert.', 'verified', 26),
(103, '3.2.103', 48, 'Push-up-Eigenschaft', 'Eine kausale Teilverbindung und eine zeitartige Teilverbindung können unter den üblichen Voraussetzungen zu einer zeitartigen Verbindung zusammengesetzt werden.', 'p\\leq q,\\quad q\\ll r\\Longrightarrow p\\ll r', 'p\\leq q,\\quad q\\ll r\\Longrightarrow p\\ll r', 'literature', 78, 'M ist zeitorientiert; die üblichen Regularitätsvoraussetzungen für die beteiligten Kurven gelten.', 'verified', 26),
(104, '3.2.104', 48, 'Konforme Erhaltung der kausalen Vektorklassen', 'Unter einer positiven konformen Skalierung der Lorentzmetrik bleiben die Vorzeichenklassen der Tangentialvektoren und damit die lokale Lichtkegelstruktur erhalten.', '\\operatorname{sgn}\\widetilde g(v,v)=\\operatorname{sgn}g(v,v)', '\\operatorname{sgn}\\widetilde g(v,v)=\\operatorname{sgn}g(v,v)', 'literature', 78, 'Die Metriken erfüllen \\widetilde g=\\Omega^2g mit \\Omega>0.', 'verified', 26),
(105, '3.2.105', 49, 'Notwendige Stationaritätsbedingung eines inneren Extremums', 'Ist u unter geeigneten Differenzierbarkeits- und Zulässigkeitsvoraussetzungen ein innerer lokaler Minimierer oder Maximierer von J, so verschwindet die erste Variation in jeder zulässigen Richtung.', '\\delta J[u;\\eta]=0', '\\delta J[u;\\eta]=0', 'literature', 76, 'u ist ein inneres lokales Extremum; die erste Variation existiert.', 'verified', 27),
(106, '3.2.106', 49, 'Euler-Lagrange-Gleichung für eindimensionale Funktionale', 'Ist y stationär bezüglich aller hinreichend regulären Variationen mit verschwindenden Randwerten, so erfüllt y unter den üblichen Regularitätsvoraussetzungen die eindimensionale Euler-Lagrange-Gleichung.', '\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y\'}\\right)=0', '\\frac{\\partial L}{\\partial y}-\\frac{d}{dx}\\left(\\frac{\\partial L}{\\partial y\'}\\right)=0', 'literature', 76, 'Feste Randwerte und ausreichende Regularität von L und y.', 'verified', 27),
(107, '3.2.107', 49, 'Euler-Lagrange-Gleichung für skalare Felder', 'Ein hinreichend regulärer stationärer Punkt eines Integral-Funktionals mit Integrand L(x,u,Du) erfüllt die zugehörige Euler-Lagrange-Gleichung.', 'L_u-\\sum_{i=1}^{n}\\frac{\\partial}{\\partial x^i}L_{p_i}=0', 'L_u-\\sum_{i=1}^{n}\\frac{\\partial}{\\partial x^i}L_{p_i}=0', 'literature', 76, 'Geeignete Regularitäts- und Randbedingungen.', 'verified', 27),
(108, '3.2.108', 49, 'Euler-Lagrange-Bedingung stationärer Wirkung', 'Ist eine hinreichend reguläre Kurve unter Variationen mit festen Endpunkten stationär für das Wirkungsfunktional, so erfüllt sie die Euler-Lagrange-Gleichungen.', '\\frac{d}{dt}\\left(\\frac{\\partial L}{\\partial\\dot q^a}\\right)-\\frac{\\partial L}{\\partial q^a}=0', '\\frac{d}{dt}\\left(\\frac{\\partial L}{\\partial\\dot q^a}\\right)-\\frac{\\partial L}{\\partial q^a}=0', 'adapted', 76, 'Feste Endpunkte und ausreichende Regularität.', 'verified', 27),
(109, '3.2.109', 49, 'Notwendige Bedingung zweiter Ordnung für ein lokales Minimum', 'Unter geeigneten Glattheits- und Innerlichkeitsvoraussetzungen ist die zweite Variation an einem lokalen Minimierer in jeder zulässigen Richtung nichtnegativ.', '\\delta^2J[u;\\eta]\\geq0', '\\delta^2J[u;\\eta]\\geq0', 'literature', 76, 'u ist ein innerer lokaler Minimierer; die zweite Variation existiert.', 'verified', 27),
(110, '3.2.110', 49, 'Invarianz der Euler-Lagrange-Gleichungen gegenüber einem totalen Ableitungsterm', 'Lagrange-Funktionen, die sich um die totale Ableitung einer hinreichend regulären Funktion unterscheiden, liefern bei festen Endpunkten dieselben Euler-Lagrange-Gleichungen.', '\\widetilde L=L+\\frac{dF}{dt}\\Longrightarrow\\operatorname{EL}(\\widetilde L)=\\operatorname{EL}(L)', '\\widetilde L=L+\\frac{dF}{dt}\\Longrightarrow\\operatorname{EL}(\\widetilde L)=\\operatorname{EL}(L)', 'adapted', 76, 'Die Endpunkte sind fest; F ist hinreichend regulär.', 'verified', 27),
(111, '3.2.111', 49, 'Variationscharakterisierung von Geodäten', 'Unter Variationen mit festen Endpunkten sind stationäre Kurven des geodätischen Energie-Funktionals genau die affin parametrisierten Geodäten.', '\\delta E[\\gamma]=0\\Longleftrightarrow\\frac{D\\dot\\gamma}{dt}=0', '\\delta E[\\gamma]=0\\Longleftrightarrow\\frac{D\\dot\\gamma}{dt}=0', 'literature', 78, 'gamma ist hinreichend regulär; Endpunkte sind fest; verwendet wird der Levi-Civita-Zusammenhang.', 'verified', 27);

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
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

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
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT für Tabelle `dissertation_sections`
--
ALTER TABLE `dissertation_sections`
  MODIFY `section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

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
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1104;

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
  MODIFY `object_source_link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1510;

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
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=245;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT für Tabelle `symbols`
--
ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `theorems`
--
ALTER TABLE `theorems`
  MODIFY `theorem_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

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
