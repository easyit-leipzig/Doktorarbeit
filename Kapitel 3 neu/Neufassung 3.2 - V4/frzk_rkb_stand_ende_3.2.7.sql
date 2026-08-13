-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 13. Aug 2026 um 02:59
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
(76, 'Conway', 'John B.', 'Conway, John B.', NULL, NULL, NULL, 'Autor der Quelle [73].');

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
(34, '3.2.34', 31, 'Orthogonale Projektion auf eine Richtung', 'Die orthogonale Projektion eines Vektors u auf die von einem von null verschiedenen Vektor v erzeugte Richtung ist das skalare Vielfache von v, dessen Koeffizient durch den Quotienten aus dem Skalarprodukt von u und v und dem Skalarprodukt von v mit sich selbst gegeben ist.', '\\operatorname{proj}_{v}(u)=\\frac{\\langle u,v\\rangle}{\\langle v,v\\rangle}\\,v', '\\operatorname{proj}_{v}(u)=\\frac{\\langle u,v\\rangle}{\\langle v,v\\rangle}\\,v', 'literature', 73, 'u und v liegen in einem Skalarproduktraum und v ist ungleich 0_V.', 'Entspricht Gleichung 3.95.', 'verified', 9);

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
(31, 23, '3.2.7', 'Normen, Abstände und Skalarprodukte', 3, 3.2700, 'final', 0, 'Etablierte Mathematik zu Normen, normierten Vektorräumen, Metriken, Skalarprodukten, Orthogonalität, orthonormalen Systemen und Projektionen. Keine FRZK-spezifische Setzung.', '2026-08-13 00:59:20', '2026-08-13 00:59:20');

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
(97, '3.97', 31, 'Strukturelle Hierarchie von Skalarprodukt, Norm und Metrik', '\\text{Skalarprodukt}\\Longrightarrow\\text{Norm}\\Longrightarrow\\text{Metrik}', '\\text{Skalarprodukt}\\Longrightarrow\\text{Norm}\\Longrightarrow\\text{Metrik}', 'Die Darstellung fasst die logische Strukturrichtung zusammen: Ein Skalarprodukt induziert eine Norm und eine Norm induziert eine Metrik; die Umkehrungen gelten nicht allgemein.', 'schema', 'literature', 73, NULL, 'Die Pfeile bezeichnen strukturelle Implikationen und keine Äquivalenzen.', 'verified', 9);

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
(179, 'equation', 95, 72, 'supporting_source', 'Ergänzende endlichdimensionale Darstellung zu Längen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen; Quelle [72].');

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
('current_section', '3.2.8', '2026-08-13 00:59:20'),
('last_citation_number', '73', '2026-08-13 00:59:20'),
('last_completed_chapter', '3.1', '2026-08-12 11:54:59'),
('last_completed_section', '3.2.7', '2026-08-13 00:59:20'),
('next_citation_number', '74', '2026-08-13 00:59:20');

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
(9, 'RKB-NEU-K3.2.7-ABSCHLUSS-V1', '2026-08-13 02:59:20', 'section', '3.2.7', '3.2.7-Abschluss-v1', 'Abschnitt 3.2.7 „Normen, Abstände und Skalarprodukte“ vollständig aufgenommen: Definitionen 3.2.28 bis 3.2.34, Sätze 3.2.4 bis 3.2.6, Gleichungen 3.81 bis 3.97, neue Quelle [73] Conway und ergänzende Wiederverwendung von [72] Strang.', 'Olaf Thiele / ChatGPT', 8);

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
(69, 9, 'K3_2_7_CITATION_COUNTERS', 'passed', 'last=73; next=74', 'last=73; next=74', '3.2.7 führt Quelle [73] neu ein; die Literaturzähler müssen danach 73/74 betragen.', '2026-08-13 00:59:20');

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
(42, 9, 31, 'status_changed', 'section', '3.2.7-ABSCHLUSS', 'Abschnitt 3.2.7 wurde als vollständig abgeschlossen markiert.', 'draft', 'final', '2026-08-13 00:59:20');

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
(73, 73, 'conway_course_functional_analysis_2e_1990', 'book', 'A Course in Functional Analysis', NULL, NULL, 1990, NULL, 'Springer-Verlag', 'New York', '96', NULL, NULL, 'Second Edition', '10.1007/978-1-4757-4383-8', '978-0-387-97245-9', NULL, 'en', 1, 'textbook', 9, 'verified', '3.2.7', 'Erstnennung zur funktionalanalytischen Grundlegung von Hilbert- und Banachraumstrukturen, insbesondere Skalarprodukt, Norm und Vollständigkeitskontext.', 'Conway, John B.: A Course in Functional Analysis. Second Edition. Graduate Texts in Mathematics 96. New York: Springer-Verlag, 1990. ISBN 978-0-387-97245-9.', 'Conway, A Course in Functional Analysis, 2nd ed. (1990) [73]', 'Bibliografische Angaben über Springer verifiziert. Für 3.2.7 verwendete Fundstellen: \"Hilbert Spaces\", S. 1-25; \"Banach Spaces\", S. 63-98. DOI 10.1007/978-1-4757-4383-8.', 9, '2026-08-13 00:59:20', '2026-08-13 00:59:20');

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
(73, 76, 1, 'author');

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
(95, 72, 31, 'background', 'Strang ergänzt die endlichdimensionale geometrische Darstellung von Vektorlängen, Skalarprodukten, Orthogonalität, Projektionen und orthonormalen Basen.', '§1.2 \"Lengths and Dot Products\"; Kap. 4 \"Orthogonality\", §§4.1-4.4', NULL, NULL, NULL, 0, 1, 'Wiederverwendung von Quelle [72]. Es werden nur verifizierte Gliederungsstellen angegeben; keine ungesicherten Seitenzahlen.', 9);

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
(6, '3.2.6', 31, 'Pythagoreische Beziehung', 'Sind zwei Vektoren in einem Skalarproduktraum orthogonal, so ist das Quadrat der Norm ihrer Summe gleich der Summe der Quadrate ihrer Normen.', '\\|u+v\\|^2=\\|u\\|^2+\\|v\\|^2', '\\|u+v\\|^2=\\|u\\|^2+\\|v\\|^2', 'literature', 73, 'u und v sind orthogonal; die Norm ist durch das Skalarprodukt induziert.', 'verified', 9);

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
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

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
  MODIFY `definition_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT für Tabelle `dissertation_sections`
--
ALTER TABLE `dissertation_sections`
  MODIFY `section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

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
  MODIFY `equation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

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
  MODIFY `object_source_link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

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
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT für Tabelle `source_relations`
--
ALTER TABLE `source_relations`
  MODIFY `relation_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `source_usage`
--
ALTER TABLE `source_usage`
  MODIFY `usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT für Tabelle `symbols`
--
ALTER TABLE `symbols`
  MODIFY `symbol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `theorems`
--
ALTER TABLE `theorems`
  MODIFY `theorem_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
