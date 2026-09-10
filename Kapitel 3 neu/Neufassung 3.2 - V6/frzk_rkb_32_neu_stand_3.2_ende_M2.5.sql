-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 08. Sep 2026 um 09:28
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
-- Datenbank: `frzk_rkb_32_neu`
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
-- Tabellenstruktur für Tabelle `appendix_modules`
--

CREATE TABLE `appendix_modules` (
  `appendix_module_id` bigint(20) UNSIGNED NOT NULL,
  `appendix_code` varchar(20) NOT NULL,
  `title` varchar(500) NOT NULL,
  `purpose` longtext NOT NULL,
  `sort_order` int(11) NOT NULL,
  `status` enum('planned','draft','review','final') NOT NULL DEFAULT 'planned',
  `created_revision_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `appendix_modules`
--

INSERT INTO `appendix_modules` (`appendix_module_id`, `appendix_code`, `title`, `purpose`, `sort_order`, `status`, `created_revision_id`) VALUES
(1, 'M1', 'Mengentheoretische und funktionale Grundlagen', 'Mengen, Teilmengen, Mengenoperationen, Potenzmengen, geordnete Paare und Tupel, kartesische Produkte, Relationen, Funktionen, Bild und Urbild, Injektivität, Surjektivität, Bijektivität, Komposition sowie mehrstellige, parametrisierte und partielle Funktionen.', 1, 'review', 13),
(2, 'M2', 'Algebraische Grundlagen des Vektorraums', 'Körper, Vektorraumaxiome, Nullvektor, additives Inverses, Unterräume, Linearkombination, Spannraum, lineare Abhängigkeit und Unabhängigkeit, Basis und Dimension.', 2, 'draft', 13),
(3, 'M3', 'Lineare Abbildungen, Matrixdarstellung, Basiswechsel und Determinante', 'Lineare Abbildungen und Operatoren, Identität und Komposition, Koordinaten, Matrixdarstellung, Basiswechsel, Ähnlichkeit, Determinante und Singularität.', 3, 'planned', 13),
(4, 'M4', 'Rang, Kern, Bild und lineare Gleichungssysteme', 'Rang, Bild, Kern, Rang-Nullität, lineare Injektivität und Surjektivität sowie Lösbarkeit und vollständige Lösung linearer Gleichungssysteme.', 4, 'planned', 13),
(5, 'M5', 'Algebraische Eigenstruktur, Diagonalisierung und Spektralrechnung', 'Eigenwerte, Eigenvektoren, Eigenräume, charakteristisches Polynom, algebraische und geometrische Vielfachheit, Diagonalisierbarkeit, algebraische Spektralprojektoren und Matrixfunktionen. Orthogonalität wird hier nicht vorausgesetzt.', 5, 'planned', 13),
(6, 'M6', 'Skalarprodukt, Norm, Orthogonalität, Projektion und Hilbertraumstrukturen', 'Reelle und komplexe Skalarprodukte, induzierte Norm, Cauchy-Schwarz, Abstand und Winkel, Orthogonalität, Gram-Schmidt, orthogonale Komplemente und Projektoren, der orthogonale beziehungsweise selbstadjungierte Spektralfall und Hilbertraumanschluss.', 6, 'planned', 13);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `appendix_objects`
--

CREATE TABLE `appendix_objects` (
  `appendix_object_id` bigint(20) UNSIGNED NOT NULL,
  `appendix_section_id` bigint(20) UNSIGNED NOT NULL,
  `object_anchor` varchar(100) NOT NULL,
  `object_type` enum('definition','statement','theorem','lemma','corollary','proposition','proof','equation','example','symbol','other') NOT NULL,
  `display_number` varchar(50) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `content_text` longtext DEFAULT NULL,
  `formal_latex` longtext DEFAULT NULL,
  `word_latex` longtext DEFAULT NULL,
  `importance_level` enum('core','supporting','derivation','example') NOT NULL DEFAULT 'supporting',
  `equation_role` enum('canonical','derived','proof_step','example') DEFAULT NULL,
  `provenance` enum('literature','adapted','original','mixed') NOT NULL DEFAULT 'literature',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assumptions` longtext DEFAULT NULL,
  `validation_status` enum('draft','checked','verified') NOT NULL DEFAULT 'draft',
  `created_revision_id` bigint(20) UNSIGNED NOT NULL
) ;

--
-- Daten für Tabelle `appendix_objects`
--

INSERT INTO `appendix_objects` (`appendix_object_id`, `appendix_section_id`, `object_anchor`, `object_type`, `display_number`, `title`, `content_text`, `formal_latex`, `word_latex`, `importance_level`, `equation_role`, `provenance`, `source_id`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(1, 2, 'M1-EQ-001', 'equation', 'M1.1', 'Elementzugehörigkeit', 'Die Elementrelation beschreibt die Zugehörigkeit eines Objekts x zur Menge A.', 'x\\in A', 'x\\in A', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 14),
(2, 2, 'M1-EQ-002', 'equation', 'M1.2', 'Nichtzugehörigkeit', 'Die negierte Elementrelation beschreibt, dass x nicht zur Menge A gehört.', 'x\\notin A', 'x\\notin A', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 14),
(3, 2, 'M1-EQ-003', 'equation', 'M1.3', 'Extensionale Mengengleichheit', 'Zwei Mengen sind genau dann gleich, wenn sie dieselben Elemente besitzen.', 'A=B\\iff\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)', 'A=B\\iff\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 14),
(4, 2, 'M1-EQ-004', 'equation', 'M1.4', 'Charakterisierung der leeren Menge', 'Die leere Menge besitzt kein Element.', '\\forall x\\left(x\\notin\\varnothing\\right)', '\\forall x\\left(x\\notin\\varnothing\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 14),
(5, 2, 'M1-EQ-005', 'equation', 'M1.5', 'Mengenbildende Darstellung der leeren Menge', 'Die unerfüllbare Bedingung x ungleich x erzeugt die leere Menge.', '\\varnothing=\\left\\{x\\mid x\\neq x\\right\\}', '\\varnothing=\\left\\{x\\mid x\\neq x\\right\\}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 14),
(6, 2, 'M1-EQ-006', 'equation', 'M1.6', 'Einelementige Menge', 'Die einelementige Menge enthält genau das Objekt a.', '\\left\\{a\\right\\}=\\left\\{x\\mid x=a\\right\\}', '\\left\\{a\\right\\}=\\left\\{x\\mid x=a\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 14),
(7, 2, 'M1-EQ-007', 'equation', 'M1.7', 'Element einer einelementigen Menge', 'Das Objekt a gehört zur einelementigen Menge, die aus a gebildet wird.', 'a\\in\\left\\{a\\right\\}', 'a\\in\\left\\{a\\right\\}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 14),
(8, 2, 'M1-EQ-008', 'equation', 'M1.8', 'Abgrenzung von Element und einelementiger Menge', 'Die dargestellte Gleichheit ist keine allgemeine Folgerung aus der Elementzugehörigkeit und dient der begrifflichen Abgrenzung.', 'a=\\left\\{a\\right\\}', 'a=\\left\\{a\\right\\}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 14),
(9, 2, 'M1-EQ-009', 'equation', 'M1.9', 'Verschachtelte Mengenebene', 'Eine einelementige Menge kann selbst Element einer weiteren Menge sein.', '\\left\\{a\\right\\}\\in\\left\\{\\left\\{a\\right\\}\\right\\}', '\\left\\{a\\right\\}\\in\\left\\{\\left\\{a\\right\\}\\right\\}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 14),
(10, 2, 'M1-EQ-010', 'equation', 'M1.10', 'Zusammenfassung der Mengenebenen', 'Die Gleichung zeigt zwei aufeinanderfolgende Elementbeziehungen auf verschiedenen Mengenebenen.', 'a\\in\\left\\{a\\right\\}\\land\\left\\{a\\right\\}\\in\\left\\{\\left\\{a\\right\\}\\right\\}', 'a\\in\\left\\{a\\right\\}\\land\\left\\{a\\right\\}\\in\\left\\{\\left\\{a\\right\\}\\right\\}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 14),
(11, 3, 'M1-EQ-011', 'equation', 'M1.11', 'Teilmengenrelation', 'Eine Menge A ist genau dann Teilmenge von B, wenn jedes Element von A auch Element von B ist.', 'A\\subseteq B\\iff\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)', 'A\\subseteq B\\iff\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 15),
(12, 3, 'M1-EQ-012', 'equation', 'M1.12', 'Reflexivität der Teilmengenrelation', 'Jede Menge ist Teilmenge ihrer selbst.', 'A\\subseteq A', 'A\\subseteq A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 15),
(13, 3, 'M1-EQ-013', 'equation', 'M1.13', 'Leere Menge als Teilmenge', 'Die leere Menge ist Teilmenge jeder Menge.', '\\varnothing\\subseteq A', '\\varnothing\\subseteq A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 15),
(14, 3, 'M1-EQ-014', 'equation', 'M1.14', 'Mengengleichheit durch gegenseitige Inklusion', 'Zwei Mengen sind genau dann gleich, wenn sie gegenseitig Teilmengen voneinander sind.', 'A=B\\iff\\left(A\\subseteq B\\land B\\subseteq A\\right)', 'A=B\\iff\\left(A\\subseteq B\\land B\\subseteq A\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 15),
(15, 3, 'M1-EQ-015', 'equation', 'M1.15', 'Echte Teilmenge', 'Eine echte Teilmenge ist eine Teilmenge, die nicht mit der Obermenge identisch ist.', 'A\\subsetneq B\\iff\\left(A\\subseteq B\\land A\\neq B\\right)', 'A\\subsetneq B\\iff\\left(A\\subseteq B\\land A\\neq B\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 15),
(16, 3, 'M1-EQ-016', 'equation', 'M1.16', 'Folgerung aus echter Teilmenge', 'Bei echter Inklusion besitzt B mindestens ein Element, das nicht zu A gehört.', 'A\\subsetneq B\\Longrightarrow\\exists x\\left(x\\in B\\land x\\notin A\\right)', 'A\\subsetneq B\\Longrightarrow\\exists x\\left(x\\in B\\land x\\notin A\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 15),
(17, 3, 'M1-EQ-017', 'equation', 'M1.17', 'Transitivität der Teilmengenrelation', 'Mehrstufige Inklusion ist transitiv.', '\\left(A\\subseteq B\\land B\\subseteq C\\right)\\Longrightarrow A\\subseteq C', '\\left(A\\subseteq B\\land B\\subseteq C\\right)\\Longrightarrow A\\subseteq C', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 15),
(18, 3, 'M1-EQ-018', 'equation', 'M1.18', 'Potenzmenge', 'Die Potenzmenge von A enthält genau alle Teilmengen von A.', '\\mathcal{P}(A)=\\left\\{X\\mid X\\subseteq A\\right\\}', '\\mathcal{P}(A)=\\left\\{X\\mid X\\subseteq A\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 15),
(19, 3, 'M1-EQ-019', 'equation', 'M1.19', 'Elemente der Potenzmenge', 'Elemente der Potenzmenge entsprechen genau den Teilmengen der Ausgangsmenge.', 'X\\in\\mathcal{P}(A)\\iff X\\subseteq A', 'X\\in\\mathcal{P}(A)\\iff X\\subseteq A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 15),
(20, 3, 'M1-EQ-020', 'equation', 'M1.20', 'Ausgangsmenge in ihrer Potenzmenge', 'A gehört als Teilmenge seiner selbst zur Potenzmenge.', 'A\\in\\mathcal{P}(A)', 'A\\in\\mathcal{P}(A)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 15),
(21, 3, 'M1-EQ-021', 'equation', 'M1.21', 'Leere Menge in der Potenzmenge', 'Die leere Menge gehört zu jeder Potenzmenge.', '\\varnothing\\in\\mathcal{P}(A)', '\\varnothing\\in\\mathcal{P}(A)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 15),
(22, 3, 'M1-EQ-022', 'equation', 'M1.22', 'Mächtigkeit einer endlichen Potenzmenge', 'Eine endliche n-elementige Menge besitzt 2^n Teilmengen.', '\\left|A\\right|=n\\Longrightarrow\\left|\\mathcal{P}(A)\\right|=2^n', '\\left|A\\right|=n\\Longrightarrow\\left|\\mathcal{P}(A)\\right|=2^n', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 15),
(23, 3, 'M1-EQ-023', 'equation', 'M1.23', 'Beispiel einer Potenzmenge', 'Für eine zweielementige Menge werden alle vier Teilmengen explizit aufgeführt.', '\\mathcal{P}\\left(\\left\\{a,b\\right\\}\\right)=\\left\\{\\varnothing,\\left\\{a\\right\\},\\left\\{b\\right\\},\\left\\{a,b\\right\\}\\right\\}', '\\mathcal{P}\\left(\\left\\{a,b\\right\\}\\right)=\\left\\{\\varnothing,\\left\\{a\\right\\},\\left\\{b\\right\\},\\left\\{a,b\\right\\}\\right\\}', 'example', 'example', 'literature', 3, NULL, 'checked', 15),
(24, 4, 'M1-EQ-024', 'equation', 'M1.24', 'Vereinigung', 'Die Vereinigung enthält genau die Elemente, die in A oder B liegen.', 'A\\cup B=\\left\\{x\\mid x\\in A\\lor x\\in B\\right\\}', 'A\\cup B=\\left\\{x\\mid x\\in A\\lor x\\in B\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 16),
(25, 4, 'M1-EQ-025', 'equation', 'M1.25', 'Inklusion in die Vereinigung', 'A ist Teilmenge der Vereinigung von A und B.', 'A\\subseteq A\\cup B', 'A\\subseteq A\\cup B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(26, 4, 'M1-EQ-026', 'equation', 'M1.26', 'Inklusion in die Vereinigung', 'B ist Teilmenge der Vereinigung von A und B.', 'B\\subseteq A\\cup B', 'B\\subseteq A\\cup B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(27, 4, 'M1-EQ-027', 'equation', 'M1.27', 'Kommutativität der Vereinigung', 'Die Vereinigung ist kommutativ.', 'A\\cup B=B\\cup A', 'A\\cup B=B\\cup A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(28, 4, 'M1-EQ-028', 'equation', 'M1.28', 'Assoziativität der Vereinigung', 'Die Vereinigung ist assoziativ.', '\\left(A\\cup B\\right)\\cup C=A\\cup\\left(B\\cup C\\right)', '\\left(A\\cup B\\right)\\cup C=A\\cup\\left(B\\cup C\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(29, 4, 'M1-EQ-029', 'equation', 'M1.29', 'Neutrales Element der Vereinigung', 'Die leere Menge ist neutrales Element der Vereinigung.', 'A\\cup\\varnothing=A', 'A\\cup\\varnothing=A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(30, 4, 'M1-EQ-030', 'equation', 'M1.30', 'Durchschnitt', 'Der Durchschnitt enthält genau die gemeinsamen Elemente von A und B.', 'A\\cap B=\\left\\{x\\mid x\\in A\\land x\\in B\\right\\}', 'A\\cap B=\\left\\{x\\mid x\\in A\\land x\\in B\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 16),
(31, 4, 'M1-EQ-031', 'equation', 'M1.31', 'Inklusion des Durchschnitts', 'Der Durchschnitt ist Teilmenge von A.', 'A\\cap B\\subseteq A', 'A\\cap B\\subseteq A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(32, 4, 'M1-EQ-032', 'equation', 'M1.32', 'Inklusion des Durchschnitts', 'Der Durchschnitt ist Teilmenge von B.', 'A\\cap B\\subseteq B', 'A\\cap B\\subseteq B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(33, 4, 'M1-EQ-033', 'equation', 'M1.33', 'Kommutativität des Durchschnitts', 'Der Durchschnitt ist kommutativ.', 'A\\cap B=B\\cap A', 'A\\cap B=B\\cap A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(34, 4, 'M1-EQ-034', 'equation', 'M1.34', 'Assoziativität des Durchschnitts', 'Der Durchschnitt ist assoziativ.', '\\left(A\\cap B\\right)\\cap C=A\\cap\\left(B\\cap C\\right)', '\\left(A\\cap B\\right)\\cap C=A\\cap\\left(B\\cap C\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(35, 4, 'M1-EQ-035', 'equation', 'M1.35', 'Idempotenz des Durchschnitts', 'Der Durchschnitt einer Menge mit sich selbst ist die Menge selbst.', 'A\\cap A=A', 'A\\cap A=A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(36, 4, 'M1-EQ-036', 'equation', 'M1.36', 'Durchschnitt mit der leeren Menge', 'Der Durchschnitt mit der leeren Menge ist leer.', 'A\\cap\\varnothing=\\varnothing', 'A\\cap\\varnothing=\\varnothing', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(37, 4, 'M1-EQ-037', 'equation', 'M1.37', 'Disjunktheit', 'Leerer Durchschnitt kennzeichnet fehlende gemeinsame Elemente.', 'A\\cap B=\\varnothing', 'A\\cap B=\\varnothing', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(38, 4, 'M1-EQ-038', 'equation', 'M1.38', 'Mengendifferenz', 'Die Mengendifferenz enthält die Elemente von A, die nicht zu B gehören.', 'A\\setminus B=\\left\\{x\\mid x\\in A\\land x\\notin B\\right\\}', 'A\\setminus B=\\left\\{x\\mid x\\in A\\land x\\notin B\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 16),
(39, 4, 'M1-EQ-039', 'equation', 'M1.39', 'Differenz einer Menge mit sich selbst', 'Die Differenz einer Menge mit sich selbst ist leer.', 'A\\setminus A=\\varnothing', 'A\\setminus A=\\varnothing', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(40, 4, 'M1-EQ-040', 'equation', 'M1.40', 'Differenz mit der leeren Menge', 'Das Entfernen der leeren Menge verändert A nicht.', 'A\\setminus\\varnothing=A', 'A\\setminus\\varnothing=A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(41, 4, 'M1-EQ-041', 'equation', 'M1.41', 'Komplement', 'Das Komplement von A bezüglich U ist die Differenz U ohne A.', 'A^{\\mathrm{c}}=U\\setminus A', 'A^{\\mathrm{c}}=U\\setminus A', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 16),
(42, 4, 'M1-EQ-042', 'equation', 'M1.42', 'Komplement als Mengenbildung', 'Das Komplement enthält die Elemente von U, die nicht zu A gehören.', 'A^{\\mathrm{c}}=\\left\\{x\\in U\\mid x\\notin A\\right\\}', 'A^{\\mathrm{c}}=\\left\\{x\\in U\\mid x\\notin A\\right\\}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(43, 4, 'M1-EQ-043', 'equation', 'M1.43', 'Komplement und Durchschnitt', 'Eine Menge und ihr Komplement sind disjunkt.', 'A\\cap A^{\\mathrm{c}}=\\varnothing', 'A\\cap A^{\\mathrm{c}}=\\varnothing', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(44, 4, 'M1-EQ-044', 'equation', 'M1.44', 'Komplement und Vereinigung', 'Eine Menge und ihr Komplement vereinigen sich zur Grundmenge.', 'A\\cup A^{\\mathrm{c}}=U', 'A\\cup A^{\\mathrm{c}}=U', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(45, 4, 'M1-EQ-045', 'equation', 'M1.45', 'Doppeltes Komplement', 'Das zweimalige Komplementieren liefert die Ausgangsmenge.', '\\left(A^{\\mathrm{c}}\\right)^{\\mathrm{c}}=A', '\\left(A^{\\mathrm{c}}\\right)^{\\mathrm{c}}=A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(46, 4, 'M1-EQ-046', 'equation', 'M1.46', 'De-Morgan für Vereinigungen', 'Das Komplement einer Vereinigung ist der Durchschnitt der Komplemente.', '\\left(A\\cup B\\right)^{\\mathrm{c}}=A^{\\mathrm{c}}\\cap B^{\\mathrm{c}}', '\\left(A\\cup B\\right)^{\\mathrm{c}}=A^{\\mathrm{c}}\\cap B^{\\mathrm{c}}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(47, 4, 'M1-EQ-047', 'equation', 'M1.47', 'De-Morgan für Durchschnitte', 'Das Komplement eines Durchschnitts ist die Vereinigung der Komplemente.', '\\left(A\\cap B\\right)^{\\mathrm{c}}=A^{\\mathrm{c}}\\cup B^{\\mathrm{c}}', '\\left(A\\cap B\\right)^{\\mathrm{c}}=A^{\\mathrm{c}}\\cup B^{\\mathrm{c}}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(48, 4, 'M1-EQ-048', 'equation', 'M1.48', 'Distributivität des Durchschnitts', 'Der Durchschnitt verteilt sich über die Vereinigung.', 'A\\cap\\left(B\\cup C\\right)=\\left(A\\cap B\\right)\\cup\\left(A\\cap C\\right)', 'A\\cap\\left(B\\cup C\\right)=\\left(A\\cap B\\right)\\cup\\left(A\\cap C\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(49, 4, 'M1-EQ-049', 'equation', 'M1.49', 'Distributivität der Vereinigung', 'Die Vereinigung verteilt sich über den Durchschnitt.', 'A\\cup\\left(B\\cap C\\right)=\\left(A\\cup B\\right)\\cap\\left(A\\cup C\\right)', 'A\\cup\\left(B\\cap C\\right)=\\left(A\\cup B\\right)\\cap\\left(A\\cup C\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 16),
(50, 5, 'M1-EQ-050', 'equation', 'M1.50', 'Reihenfolge einer zweielementigen Menge', 'Bei einer gewöhnlichen zweielementigen Menge spielt die Reihenfolge keine Rolle.', '\\left\\{a,b\\right\\}=\\left\\{b,a\\right\\}', '\\left\\{a,b\\right\\}=\\left\\{b,a\\right\\}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(51, 5, 'M1-EQ-051', 'equation', 'M1.51', 'Kuratowski-Darstellung des geordneten Paares', 'Das geordnete Paar wird mengentheoretisch nach Kuratowski dargestellt.', '(a,b)=\\left\\{\\left\\{a\\right\\},\\left\\{a,b\\right\\}\\right\\}', '(a,b)=\\left\\{\\left\\{a\\right\\},\\left\\{a,b\\right\\}\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 17),
(52, 5, 'M1-EQ-052', 'equation', 'M1.52', 'Gleichheit geordneter Paare', 'Geordnete Paare sind genau bei positionsweiser Gleichheit ihrer Komponenten gleich.', '(a,b)=(c,d)\\iff\\left(a=c\\land b=d\\right)', '(a,b)=(c,d)\\iff\\left(a=c\\land b=d\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 17),
(53, 5, 'M1-EQ-053', 'equation', 'M1.53', 'Vertauschung ungleicher Komponenten', 'Bei verschiedenen Komponenten ändert deren Vertauschung das geordnete Paar.', '(a,b)\\neq(b,a)', '(a,b)\\neq(b,a)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(54, 5, 'M1-EQ-054', 'equation', 'M1.54', 'Kartesisches Produkt', 'Das kartesische Produkt enthält alle geordneten Paare mit Komponenten aus den jeweiligen Faktoren.', 'A\\times B=\\left\\{(a,b)\\mid a\\in A\\land b\\in B\\right\\}', 'A\\times B=\\left\\{(a,b)\\mid a\\in A\\land b\\in B\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 17),
(55, 5, 'M1-EQ-055', 'equation', 'M1.55', 'Zugehörigkeit zum kartesischen Produkt', 'Die Paarzugehörigkeit entspricht der Zugehörigkeit beider Komponenten zu ihren Faktoren.', '(a,b)\\in A\\times B\\iff\\left(a\\in A\\land b\\in B\\right)', '(a,b)\\in A\\times B\\iff\\left(a\\in A\\land b\\in B\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(56, 5, 'M1-EQ-056', 'equation', 'M1.56', 'Beispielmengen für ein kartesisches Produkt', 'Zwei endliche Beispielmengen werden für die Produktbildung festgelegt.', 'A=\\left\\{a_1,a_2\\right\\},\\qquad B=\\left\\{b_1,b_2\\right\\}', 'A=\\left\\{a_1,a_2\\right\\},\\qquad B=\\left\\{b_1,b_2\\right\\}', 'example', 'example', 'literature', 3, NULL, 'checked', 17),
(57, 5, 'M1-EQ-057', 'equation', 'M1.57', 'Beispiel eines kartesischen Produkts', 'Das kartesische Produkt der Beispielmengen wird vollständig aufgezählt.', 'A\\times B=\\left\\{(a_1,b_1),(a_1,b_2),(a_2,b_1),(a_2,b_2)\\right\\}', 'A\\times B=\\left\\{(a_1,b_1),(a_1,b_2),(a_2,b_1),(a_2,b_2)\\right\\}', 'example', 'example', 'literature', 3, NULL, 'checked', 17),
(58, 5, 'M1-EQ-058', 'equation', 'M1.58', 'Kardinalität eines endlichen kartesischen Produkts', 'Für endliche Mengen multiplizieren sich die Kardinalitäten.', '\\left|A\\right|=m\\land\\left|B\\right|=n\\Longrightarrow\\left|A\\times B\\right|=mn', '\\left|A\\right|=m\\land\\left|B\\right|=n\\Longrightarrow\\left|A\\times B\\right|=mn', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(59, 5, 'M1-EQ-059', 'equation', 'M1.59', 'Vertauschung der Produktkomponenten', 'Die Vertauschung eines Paares führt in das Produkt mit vertauschten Faktoren.', '(a,b)\\in A\\times B\\Longrightarrow(b,a)\\in B\\times A', '(a,b)\\in A\\times B\\Longrightarrow(b,a)\\in B\\times A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(60, 5, 'M1-EQ-060', 'equation', 'M1.60', 'Kartesisches Produkt mit leerem zweiten Faktor', 'Ein leerer zweiter Faktor erzeugt ein leeres Produkt.', 'A\\times\\varnothing=\\varnothing', 'A\\times\\varnothing=\\varnothing', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(61, 5, 'M1-EQ-061', 'equation', 'M1.61', 'Kartesisches Produkt mit leerem ersten Faktor', 'Ein leerer erster Faktor erzeugt ein leeres Produkt.', '\\varnothing\\times B=\\varnothing', '\\varnothing\\times B=\\varnothing', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(62, 5, 'M1-EQ-062', 'equation', 'M1.62', 'Notation eines n-Tupels', 'Ein n-Tupel besitzt n positionsabhängige Komponenten.', '(a_1,a_2,\\ldots,a_n)', '(a_1,a_2,\\ldots,a_n)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(63, 5, 'M1-EQ-063', 'equation', 'M1.63', 'Gleichheit von n-Tupeln', 'Tupel gleicher Länge sind bei positionsweiser Gleichheit identisch.', '(a_1,\\ldots,a_n)=(b_1,\\ldots,b_n)\\iff\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i=b_i', '(a_1,\\ldots,a_n)=(b_1,\\ldots,b_n)\\iff\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i=b_i', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(64, 5, 'M1-EQ-064', 'equation', 'M1.64', 'Kartesisches Produkt mehrerer Faktoren', 'Das n-fache kartesische Produkt wird als Menge positionsgebundener Tupel definiert.', 'A_1\\times\\cdots\\times A_n=\\left\\{(a_1,\\ldots,a_n)\\mid\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i\\in A_i\\right\\}', 'A_1\\times\\cdots\\times A_n=\\left\\{(a_1,\\ldots,a_n)\\mid\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i\\in A_i\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 17),
(65, 5, 'M1-EQ-065', 'equation', 'M1.65', 'Kompakte Produktschreibweise', 'Die Produktschreibweise fasst das endliche kartesische Produkt zusammen.', '\\prod_{i=1}^{n}A_i=A_1\\times A_2\\times\\cdots\\times A_n', '\\prod_{i=1}^{n}A_i=A_1\\times A_2\\times\\cdots\\times A_n', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(66, 5, 'M1-EQ-066', 'equation', 'M1.66', 'Zugehörigkeit zum n-fachen Produkt', 'Ein Tupel gehört genau dann zum Produkt, wenn jede Komponente im zugehörigen Faktor liegt.', '(a_1,\\ldots,a_n)\\in\\prod_{i=1}^{n}A_i\\iff\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i\\in A_i', '(a_1,\\ldots,a_n)\\in\\prod_{i=1}^{n}A_i\\iff\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i\\in A_i', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(67, 5, 'M1-EQ-067', 'equation', 'M1.67', 'Kartesische Potenz', 'Bei identischen Faktoren wird das n-fache Produkt als kartesische Potenz geschrieben.', 'A^n=\\underbrace{A\\times A\\times\\cdots\\times A}_{n\\ \\mathrm{Faktoren}}', 'A^n=\\underbrace{A\\times A\\times\\cdots\\times A}_{n\\ \\mathrm{Faktoren}}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(68, 5, 'M1-EQ-068', 'equation', 'M1.68', 'Erste Projektion', 'Die erste natürliche Projektion wählt die erste Komponente eines Paares aus.', '\\pi_1:A\\times B\\rightarrow A,\\qquad\\pi_1(a,b)=a', '\\pi_1:A\\times B\\rightarrow A,\\qquad\\pi_1(a,b)=a', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 17),
(69, 5, 'M1-EQ-069', 'equation', 'M1.69', 'Zweite Projektion', 'Die zweite natürliche Projektion wählt die zweite Komponente eines Paares aus.', '\\pi_2:A\\times B\\rightarrow B,\\qquad\\pi_2(a,b)=b', '\\pi_2:A\\times B\\rightarrow B,\\qquad\\pi_2(a,b)=b', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 17),
(70, 5, 'M1-EQ-070', 'equation', 'M1.70', 'Allgemeine Komponentenprojektion', 'Die i-te Projektion wählt die i-te Komponente eines Tupels aus.', '\\pi_i(a_1,\\ldots,a_n)=a_i', '\\pi_i(a_1,\\ldots,a_n)=a_i', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 17),
(71, 6, 'M1-EQ-071', 'equation', 'M1.71', 'Relation als Teilmenge', 'Eine binäre Relation von A nach B ist eine Teilmenge des kartesischen Produktes.', 'R\\subseteq A\\times B', 'R\\subseteq A\\times B', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(72, 6, 'M1-EQ-072', 'equation', 'M1.72', 'Paarzugehörigkeit zur Relation', 'Ein geordnetes Paar gehört zur Relation, wenn es Bestandteil der ausgewählten Teilmenge ist.', '(a,b)\\in R', '(a,b)\\in R', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 18),
(73, 6, 'M1-EQ-073', 'equation', 'M1.73', 'Kompakte Relationsschreibweise', 'Die Schreibweise aRb ist äquivalent zur Paarzugehörigkeit.', 'aRb\\iff(a,b)\\in R', 'aRb\\iff(a,b)\\in R', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(74, 6, 'M1-EQ-074', 'equation', 'M1.74', 'Definitionsbereich einer Relation', 'Der Definitionsbereich enthält die tatsächlich als erste Komponente auftretenden Elemente.', '\\operatorname{dom}(R)=\\left\\{a\\in A\\mid\\exists b\\in B:(a,b)\\in R\\right\\}', '\\operatorname{dom}(R)=\\left\\{a\\in A\\mid\\exists b\\in B:(a,b)\\in R\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(75, 6, 'M1-EQ-075', 'equation', 'M1.75', 'Wertebereich einer Relation', 'Der Wertebereich enthält die tatsächlich als zweite Komponente auftretenden Elemente.', '\\operatorname{ran}(R)=\\left\\{b\\in B\\mid\\exists a\\in A:(a,b)\\in R\\right\\}', '\\operatorname{ran}(R)=\\left\\{b\\in B\\mid\\exists a\\in A:(a,b)\\in R\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(76, 6, 'M1-EQ-076', 'equation', 'M1.76', 'Definitionsbereich als Teilmenge', 'Der Definitionsbereich der Relation liegt im vorgegebenen Ausgangsbereich.', '\\operatorname{dom}(R)\\subseteq A', '\\operatorname{dom}(R)\\subseteq A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 18),
(77, 6, 'M1-EQ-077', 'equation', 'M1.77', 'Wertebereich als Teilmenge', 'Der Wertebereich der Relation liegt im vorgegebenen Zielbereich.', '\\operatorname{ran}(R)\\subseteq B', '\\operatorname{ran}(R)\\subseteq B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 18),
(78, 6, 'M1-EQ-078', 'equation', 'M1.78', 'Relation auf einer Menge', 'Bei einer Relation auf A stammen beide Komponenten aus derselben Menge.', 'R\\subseteq A\\times A', 'R\\subseteq A\\times A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 18),
(79, 6, 'M1-EQ-079', 'equation', 'M1.79', 'Reflexivität', 'Jedes Element steht zu sich selbst in Relation.', '\\forall a\\in A:(a,a)\\in R', '\\forall a\\in A:(a,a)\\in R', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(80, 6, 'M1-EQ-080', 'equation', 'M1.80', 'Irreflexivität', 'Kein Element steht zu sich selbst in Relation.', '\\forall a\\in A:(a,a)\\notin R', '\\forall a\\in A:(a,a)\\notin R', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(81, 6, 'M1-EQ-081', 'equation', 'M1.81', 'Symmetrie', 'Mit jedem Relationspaar gehört auch das vertauschte Paar zur Relation.', '\\forall a,b\\in A:\\left((a,b)\\in R\\Longrightarrow(b,a)\\in R\\right)', '\\forall a,b\\in A:\\left((a,b)\\in R\\Longrightarrow(b,a)\\in R\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(82, 6, 'M1-EQ-082', 'equation', 'M1.82', 'Antisymmetrie', 'Beziehungen in beide Richtungen können nur für identische Elemente auftreten.', '\\forall a,b\\in A:\\left((a,b)\\in R\\land(b,a)\\in R\\Longrightarrow a=b\\right)', '\\forall a,b\\in A:\\left((a,b)\\in R\\land(b,a)\\in R\\Longrightarrow a=b\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(83, 6, 'M1-EQ-083', 'equation', 'M1.83', 'Asymmetrie', 'Aus einer Beziehung in einer Richtung folgt das Nichtbestehen der umgekehrten Beziehung.', '\\forall a,b\\in A:\\left((a,b)\\in R\\Longrightarrow(b,a)\\notin R\\right)', '\\forall a,b\\in A:\\left((a,b)\\in R\\Longrightarrow(b,a)\\notin R\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(84, 6, 'M1-EQ-084', 'equation', 'M1.84', 'Asymmetrie impliziert Irreflexivität', 'Jede asymmetrische Relation ist irreflexiv.', 'R\\ \\mathrm{asymmetrisch}\\Longrightarrow R\\ \\mathrm{irreflexiv}', 'R\\ \\mathrm{asymmetrisch}\\Longrightarrow R\\ \\mathrm{irreflexiv}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 18),
(85, 6, 'M1-EQ-085', 'equation', 'M1.85', 'Transitivität', 'Zwei aufeinanderfolgende Relationspaare erzwingen das entsprechende direkte Paar.', '\\forall a,b,c\\in A:\\left((a,b)\\in R\\land(b,c)\\in R\\Longrightarrow(a,c)\\in R\\right)', '\\forall a,b,c\\in A:\\left((a,b)\\in R\\land(b,c)\\in R\\Longrightarrow(a,c)\\in R\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(86, 6, 'M1-EQ-086', 'equation', 'M1.86', 'Äquivalenzrelation', 'Eine Äquivalenzrelation ist reflexiv, symmetrisch und transitiv.', 'R\\ \\mathrm{Äquivalenzrelation}\\iff R\\ \\mathrm{reflexiv}\\land R\\ \\mathrm{symmetrisch}\\land R\\ \\mathrm{transitiv}', 'R\\ \\mathrm{Äquivalenzrelation}\\iff R\\ \\mathrm{reflexiv}\\land R\\ \\mathrm{symmetrisch}\\land R\\ \\mathrm{transitiv}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(87, 6, 'M1-EQ-087', 'equation', 'M1.87', 'Äquivalenzklasse', 'Die Äquivalenzklasse enthält alle zu a äquivalenten Elemente.', '[a]_R=\\left\\{x\\in A\\mid(x,a)\\in R\\right\\}', '[a]_R=\\left\\{x\\in A\\mid(x,a)\\in R\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(88, 6, 'M1-EQ-088', 'equation', 'M1.88', 'Äquivalenzklassen sind identisch oder disjunkt', 'Zwei Äquivalenzklassen sind identisch oder besitzen keinen gemeinsamen Bestandteil.', '[a]_R=[b]_R\\lor[a]_R\\cap[b]_R=\\varnothing', '[a]_R=[b]_R\\lor[a]_R\\cap[b]_R=\\varnothing', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 18),
(89, 6, 'M1-EQ-089', 'equation', 'M1.89', 'Quotientenmenge', 'Die Quotientenmenge enthält die Äquivalenzklassen als Elemente.', 'A/R=\\left\\{[a]_R\\mid a\\in A\\right\\}', 'A/R=\\left\\{[a]_R\\mid a\\in A\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(90, 6, 'M1-EQ-090', 'equation', 'M1.90', 'Partielle Ordnung', 'Eine partielle Ordnung ist reflexiv, antisymmetrisch und transitiv.', 'R\\ \\mathrm{partielle\\ Ordnung}\\iff R\\ \\mathrm{reflexiv}\\land R\\ \\mathrm{antisymmetrisch}\\land R\\ \\mathrm{transitiv}', 'R\\ \\mathrm{partielle\\ Ordnung}\\iff R\\ \\mathrm{reflexiv}\\land R\\ \\mathrm{antisymmetrisch}\\land R\\ \\mathrm{transitiv}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(91, 6, 'M1-EQ-091', 'equation', 'M1.91', 'Vergleichbarkeit einer totalen Ordnung', 'Für eine totale Ordnung sind je zwei Elemente vergleichbar.', '\\forall a,b\\in A:\\left((a,b)\\in R\\lor(b,a)\\in R\\right)', '\\forall a,b\\in A:\\left((a,b)\\in R\\lor(b,a)\\in R\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(92, 6, 'M1-EQ-092', 'equation', 'M1.92', 'Umkehrrelation', 'Die Umkehrrelation entsteht durch Vertauschung der Komponenten jedes Relationspaares.', 'R^{-1}=\\left\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\right\\}', 'R^{-1}=\\left\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(93, 6, 'M1-EQ-093', 'equation', 'M1.93', 'Paarzugehörigkeit der Umkehrrelation', 'Ein Paar in R entspricht dem vertauschten Paar in der Umkehrrelation.', '(a,b)\\in R\\iff(b,a)\\in R^{-1}', '(a,b)\\in R\\iff(b,a)\\in R^{-1}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 18),
(94, 6, 'M1-EQ-094', 'equation', 'M1.94', 'Doppelte Umkehrrelation', 'Zweimaliges Umkehren liefert die Ausgangsrelation.', '\\left(R^{-1}\\right)^{-1}=R', '\\left(R^{-1}\\right)^{-1}=R', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 18),
(95, 6, 'M1-EQ-095', 'equation', 'M1.95', 'Komposition von Relationen', 'Die Komposition verbindet Paare über ein gemeinsames Zwischenelement.', 'S\\circ R=\\left\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\left((a,b)\\in R\\land(b,c)\\in S\\right)\\right\\}', 'S\\circ R=\\left\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\left((a,b)\\in R\\land(b,c)\\in S\\right)\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 18),
(96, 6, 'M1-EQ-096', 'equation', 'M1.96', 'Assoziativität der Relationskomposition', 'Die Klammerung dreier zueinander passender Relationen verändert die Komposition nicht.', 'T\\circ(S\\circ R)=(T\\circ S)\\circ R', 'T\\circ(S\\circ R)=(T\\circ S)\\circ R', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 18),
(97, 7, 'M1-EQ-097', 'equation', 'M1.97', 'Graph als Relation', 'Der Funktionsgraph ist eine Teilmenge des kartesischen Produktes.', 'G_f\\subseteq A\\times B', 'G_f\\subseteq A\\times B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 19),
(98, 7, 'M1-EQ-098', 'equation', 'M1.98', 'Existenz und Eindeutigkeit des Funktionswertes', 'Jedem Element des Definitionsbereiches ist genau ein Element des Zielbereiches zugeordnet.', '\\forall a\\in A\\ \\exists!b\\in B:(a,b)\\in G_f', '\\forall a\\in A\\ \\exists!b\\in B:(a,b)\\in G_f', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(99, 7, 'M1-EQ-099', 'equation', 'M1.99', 'Existenzbedingung', 'Zu jedem Argument existiert mindestens ein zugeordnetes Zielelement.', '\\forall a\\in A\\ \\exists b\\in B:(a,b)\\in G_f', '\\forall a\\in A\\ \\exists b\\in B:(a,b)\\in G_f', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 19),
(100, 7, 'M1-EQ-100', 'equation', 'M1.100', 'Eindeutigkeitsbedingung', 'Zwei zu demselben Argument gehörende Zielwerte müssen identisch sein.', '\\forall a\\in A\\ \\forall b_1,b_2\\in B:\\left((a,b_1)\\in G_f\\land(a,b_2)\\in G_f\\Longrightarrow b_1=b_2\\right)', '\\forall a\\in A\\ \\forall b_1,b_2\\in B:\\left((a,b_1)\\in G_f\\land(a,b_2)\\in G_f\\Longrightarrow b_1=b_2\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 19),
(101, 7, 'M1-EQ-101', 'equation', 'M1.101', 'Funktionssignatur', 'Eine Funktion ordnet Elemente von A eindeutig Elementen des Zielbereiches B zu.', 'f:A\\rightarrow B', 'f:A\\rightarrow B', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(102, 7, 'M1-EQ-102', 'equation', 'M1.102', 'Zuordnungsschreibweise', 'Die Abbildung eines Arguments wird durch die Zuordnung a nach f(a) notiert.', 'a\\mapsto f(a)', 'a\\mapsto f(a)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(103, 7, 'M1-EQ-103', 'equation', 'M1.103', 'Graphdarstellung einer Funktion', 'Der Graph besteht genau aus den Paaren aus Argument und zugehörigem Funktionswert.', 'G_f=\\left\\{(a,f(a))\\mid a\\in A\\right\\}', 'G_f=\\left\\{(a,f(a))\\mid a\\in A\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(104, 7, 'M1-EQ-104', 'equation', 'M1.104', 'Graph- und Funktionswertäquivalenz', 'Paarzugehörigkeit zum Graphen ist äquivalent zur Gleichheit des Funktionswertes mit der zweiten Komponente.', '(a,b)\\in G_f\\iff f(a)=b', '(a,b)\\in G_f\\iff f(a)=b', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 19),
(105, 7, 'M1-EQ-105', 'equation', 'M1.105', 'Definitionsbereich', 'Bei einer vollständig auf A definierten Funktion ist A der Definitionsbereich.', '\\operatorname{dom}(f)=A', '\\operatorname{dom}(f)=A', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(106, 7, 'M1-EQ-106', 'equation', 'M1.106', 'Zielbereich', 'B ist der festgelegte Zielbereich der Funktion.', '\\operatorname{cod}(f)=B', '\\operatorname{cod}(f)=B', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(107, 7, 'M1-EQ-107', 'equation', 'M1.107', 'Bildmenge', 'Die Bildmenge enthält genau die tatsächlich angenommenen Funktionswerte.', '\\operatorname{im}(f)=\\left\\{f(a)\\mid a\\in A\\right\\}', '\\operatorname{im}(f)=\\left\\{f(a)\\mid a\\in A\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(108, 7, 'M1-EQ-108', 'equation', 'M1.108', 'Bildmenge als Teilmenge des Zielbereiches', 'Die tatsächlich angenommenen Funktionswerte liegen im Zielbereich.', '\\operatorname{im}(f)\\subseteq B', '\\operatorname{im}(f)\\subseteq B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 19),
(109, 7, 'M1-EQ-109', 'equation', 'M1.109', 'Eindeutigkeit für festes Argument', 'Für ein festes Argument können zwei Funktionswerte nur identisch sein.', 'f(a)=b_1\\land f(a)=b_2\\Longrightarrow b_1=b_2', 'f(a)=b_1\\land f(a)=b_2\\Longrightarrow b_1=b_2', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 19),
(110, 7, 'M1-EQ-110', 'equation', 'M1.110', 'Funktionsgleichheit bei gemeinsamem Definitions- und Zielbereich', 'Bei gemeinsam festgelegtem Definitions- und Zielbereich genügt punktweise Gleichheit.', 'f=g\\iff\\forall a\\in A:f(a)=g(a)', 'f=g\\iff\\forall a\\in A:f(a)=g(a)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(111, 7, 'M1-EQ-111', 'equation', 'M1.111', 'Vollständige Funktionsgleichheit', 'Gleiche Funktionen besitzen denselben Definitionsbereich, denselben Zielbereich und stimmen punktweise überein.', 'f=g\\iff\\operatorname{dom}(f)=\\operatorname{dom}(g)\\land\\operatorname{cod}(f)=\\operatorname{cod}(g)\\land\\forall a\\in\\operatorname{dom}(f):f(a)=g(a)', 'f=g\\iff\\operatorname{dom}(f)=\\operatorname{dom}(g)\\land\\operatorname{cod}(f)=\\operatorname{cod}(g)\\land\\forall a\\in\\operatorname{dom}(f):f(a)=g(a)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(112, 7, 'M1-EQ-112', 'equation', 'M1.112', 'Einschränkung einer Funktion', 'Die Einschränkung einer Funktion auf C verwendet C als neuen Definitionsbereich.', 'f|_C:C\\rightarrow B', 'f|_C:C\\rightarrow B', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(113, 7, 'M1-EQ-113', 'equation', 'M1.113', 'Funktionswerte der Einschränkung', 'Auf dem eingeschränkten Definitionsbereich stimmen die Werte mit der ursprünglichen Funktion überein.', 'f|_C(c)=f(c)', 'f|_C(c)=f(c)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(114, 7, 'M1-EQ-114', 'equation', 'M1.114', 'Graph der eingeschränkten Funktion', 'Der Graph der Einschränkung enthält genau die Paare mit Argumenten aus C.', 'G_{f|_C}=\\left\\{(c,f(c))\\mid c\\in C\\right\\}', 'G_{f|_C}=\\left\\{(c,f(c))\\mid c\\in C\\right\\}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 19),
(115, 7, 'M1-EQ-115', 'equation', 'M1.115', 'Identitätsfunktion', 'Die Identitätsfunktion wirkt von A nach A.', '\\operatorname{id}_A:A\\rightarrow A', '\\operatorname{id}_A:A\\rightarrow A', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(116, 7, 'M1-EQ-116', 'equation', 'M1.116', 'Wirkung der Identitätsfunktion', 'Die Identitätsfunktion ordnet jedem Element sich selbst zu.', '\\operatorname{id}_A(a)=a', '\\operatorname{id}_A(a)=a', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(117, 7, 'M1-EQ-117', 'equation', 'M1.117', 'Graph der Identitätsfunktion', 'Der Graph der Identitätsfunktion besteht aus Paaren mit identischen Komponenten.', 'G_{\\operatorname{id}_A}=\\left\\{(a,a)\\mid a\\in A\\right\\}', 'G_{\\operatorname{id}_A}=\\left\\{(a,a)\\mid a\\in A\\right\\}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 19),
(118, 7, 'M1-EQ-118', 'equation', 'M1.118', 'Menge aller Funktionen von A nach B', 'B hoch A bezeichnet die Menge aller Funktionen von A nach B.', 'B^A=\\left\\{f\\mid f:A\\rightarrow B\\right\\}', 'B^A=\\left\\{f\\mid f:A\\rightarrow B\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 19),
(119, 7, 'M1-EQ-119', 'equation', 'M1.119', 'Mitgliedschaft in der Funktionsmenge', 'Eine Funktion ist genau dann Element von B hoch A, wenn sie von A nach B abbildet.', 'f\\in B^A\\iff f:A\\rightarrow B', 'f\\in B^A\\iff f:A\\rightarrow B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 19),
(120, 7, 'M1-EQ-120', 'equation', 'M1.120', 'Anzahl der Funktionen zwischen endlichen Mengen', 'Für endliche Mengen mit m beziehungsweise n Elementen existieren n hoch m Funktionen von A nach B.', '\\left|A\\right|=m\\land\\left|B\\right|=n\\Longrightarrow\\left|B^A\\right|=n^m', '\\left|A\\right|=m\\land\\left|B\\right|=n\\Longrightarrow\\left|B^A\\right|=n^m', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 19),
(121, 8, 'M1-EQ-121', 'equation', 'M1.121', 'Definition der Injektivität', 'Gleiche Funktionswerte dürfen bei einer injektiven Funktion nur von gleichen Argumenten stammen.', '\\forall a_1,a_2\\in A:\\left(f(a_1)=f(a_2)\\Longrightarrow a_1=a_2\\right)', '\\forall a_1,a_2\\in A:\\left(f(a_1)=f(a_2)\\Longrightarrow a_1=a_2\\right)', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 20),
(122, 8, 'M1-EQ-122', 'equation', 'M1.122', 'Kontraposition der Injektivität', 'Verschiedene Argumente besitzen bei einer injektiven Funktion verschiedene Funktionswerte.', '\\forall a_1,a_2\\in A:\\left(a_1\\neq a_2\\Longrightarrow f(a_1)\\neq f(a_2)\\right)', '\\forall a_1,a_2\\in A:\\left(a_1\\neq a_2\\Longrightarrow f(a_1)\\neq f(a_2)\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(123, 8, 'M1-EQ-123', 'equation', 'M1.123', 'Nichtinjektivität', 'Nichtinjektivität liegt vor, wenn verschiedene Argumente denselben Funktionswert besitzen.', '\\exists a_1,a_2\\in A:\\left(a_1\\neq a_2\\land f(a_1)=f(a_2)\\right)', '\\exists a_1,a_2\\in A:\\left(a_1\\neq a_2\\land f(a_1)=f(a_2)\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(124, 8, 'M1-EQ-124', 'equation', 'M1.124', 'Definition der Surjektivität', 'Jedes Element des Zielbereichs besitzt bei einer surjektiven Funktion mindestens ein Urbild.', '\\forall b\\in B\\ \\exists a\\in A:f(a)=b', '\\forall b\\in B\\ \\exists a\\in A:f(a)=b', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 20),
(125, 8, 'M1-EQ-125', 'equation', 'M1.125', 'Surjektivität über die Bildmenge', 'Surjektivität ist äquivalent zur Gleichheit von Bildmenge und Zielbereich.', 'f\\ \\mathrm{surjektiv}\\iff\\operatorname{im}(f)=B', 'f\\ \\mathrm{surjektiv}\\iff\\operatorname{im}(f)=B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(126, 8, 'M1-EQ-126', 'equation', 'M1.126', 'Nichtsurjektivität', 'Nichtsurjektivität liegt vor, wenn mindestens ein Zielelement kein Urbild besitzt.', '\\exists b\\in B\\ \\forall a\\in A:f(a)\\neq b', '\\exists b\\in B\\ \\forall a\\in A:f(a)\\neq b', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(127, 8, 'M1-EQ-127', 'equation', 'M1.127', 'Definition der Bijektivität', 'Bijektivität verbindet Injektivität und Surjektivität.', 'f\\ \\mathrm{bijektiv}\\iff f\\ \\mathrm{injektiv}\\land f\\ \\mathrm{surjektiv}', 'f\\ \\mathrm{bijektiv}\\iff f\\ \\mathrm{injektiv}\\land f\\ \\mathrm{surjektiv}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 20),
(128, 8, 'M1-EQ-128', 'equation', 'M1.128', 'Bijektivität als eindeutige Rückzuordnung', 'Bei einer Bijektion besitzt jedes Zielelement genau ein Urbild.', 'f\\ \\mathrm{bijektiv}\\iff\\forall b\\in B\\ \\exists!a\\in A:f(a)=b', 'f\\ \\mathrm{bijektiv}\\iff\\forall b\\in B\\ \\exists!a\\in A:f(a)=b', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 20),
(129, 8, 'M1-EQ-129', 'equation', 'M1.129', 'Mächtigkeit endlicher Mengen bei Bijektion', 'Eine Bijektion zwischen endlichen Mengen erzwingt gleiche Mächtigkeit.', 'f:A\\rightarrow B\\ \\mathrm{bijektiv}\\Longrightarrow\\left|A\\right|=\\left|B\\right|', 'f:A\\rightarrow B\\ \\mathrm{bijektiv}\\Longrightarrow\\left|A\\right|=\\left|B\\right|', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(130, 8, 'M1-EQ-130', 'equation', 'M1.130', 'Umkehrfunktion', 'Eine bijektive Funktion besitzt eine Umkehrfunktion vom Ziel- in den Definitionsbereich.', 'f^{-1}:B\\rightarrow A', 'f^{-1}:B\\rightarrow A', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 20),
(131, 8, 'M1-EQ-131', 'equation', 'M1.131', 'Charakterisierung der Umkehrfunktion', 'Die inverse Zuordnung entspricht genau der ursprünglichen Zuordnung in Gegenrichtung.', 'f^{-1}(b)=a\\iff f(a)=b', 'f^{-1}(b)=a\\iff f(a)=b', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 20),
(132, 8, 'M1-EQ-132', 'equation', 'M1.132', 'Linksinverse Identität', 'Die Komposition der Umkehrfunktion mit der Funktion ergibt die Identität auf A.', 'f^{-1}\\circ f=\\operatorname{id}_A', 'f^{-1}\\circ f=\\operatorname{id}_A', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 20),
(133, 8, 'M1-EQ-133', 'equation', 'M1.133', 'Rechtsinverse Identität', 'Die Komposition der Funktion mit ihrer Umkehrfunktion ergibt die Identität auf B.', 'f\\circ f^{-1}=\\operatorname{id}_B', 'f\\circ f^{-1}=\\operatorname{id}_B', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 20),
(134, 8, 'M1-EQ-134', 'equation', 'M1.134', 'Bijektivität der Umkehrfunktion', 'Die Umkehrfunktion einer Bijektion ist selbst bijektiv.', 'f\\ \\mathrm{bijektiv}\\Longrightarrow f^{-1}\\ \\mathrm{bijektiv}', 'f\\ \\mathrm{bijektiv}\\Longrightarrow f^{-1}\\ \\mathrm{bijektiv}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(135, 8, 'M1-EQ-135', 'equation', 'M1.135', 'Doppelte Umkehrung', 'Die erneute Inversion führt zur ursprünglichen Funktion zurück.', '\\left(f^{-1}\\right)^{-1}=f', '\\left(f^{-1}\\right)^{-1}=f', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(136, 8, 'M1-EQ-136', 'equation', 'M1.136', 'Punktweise Rückführung auf A', 'Die inverse Funktion hebt die Funktion punktweise auf dem Definitionsbereich auf.', 'f^{-1}(f(a))=a\\qquad\\forall a\\in A', 'f^{-1}(f(a))=a\\qquad\\forall a\\in A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(137, 8, 'M1-EQ-137', 'equation', 'M1.137', 'Punktweise Rückführung auf B', 'Die Funktion hebt ihre Inverse punktweise auf dem Zielbereich auf.', 'f(f^{-1}(b))=b\\qquad\\forall b\\in B', 'f(f^{-1}(b))=b\\qquad\\forall b\\in B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(138, 8, 'M1-EQ-138', 'equation', 'M1.138', 'Komposition von Bijektionen', 'Die Komposition zweier zueinander passender Bijektionen ist wieder bijektiv.', 'f\\ \\mathrm{bijektiv}\\land g\\ \\mathrm{bijektiv}\\Longrightarrow g\\circ f\\ \\mathrm{bijektiv}', 'f\\ \\mathrm{bijektiv}\\land g\\ \\mathrm{bijektiv}\\Longrightarrow g\\circ f\\ \\mathrm{bijektiv}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(139, 8, 'M1-EQ-139', 'equation', 'M1.139', 'Inverse einer Komposition', 'Bei der Inversion einer Funktionskomposition kehrt sich die Reihenfolge der Faktoren um.', '(g\\circ f)^{-1}=f^{-1}\\circ g^{-1}', '(g\\circ f)^{-1}=f^{-1}\\circ g^{-1}', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 20),
(140, 9, 'M1-EQ-140', 'equation', 'M1.140', 'Definition des Bildes einer Teilmenge', 'Das Bild einer Teilmenge besteht aus den Funktionswerten ihrer Elemente.', 'f(C)=\\left\\{f(c)\\mid c\\in C\\right\\}', 'f(C)=\\left\\{f(c)\\mid c\\in C\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 21),
(141, 9, 'M1-EQ-141', 'equation', 'M1.141', 'Bild liegt in der Gesamtbildmenge', 'Das Bild einer Teilmenge liegt in der Bildmenge der gesamten Funktion.', 'f(C)\\subseteq\\operatorname{im}(f)', 'f(C)\\subseteq\\operatorname{im}(f)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(142, 9, 'M1-EQ-142', 'equation', 'M1.142', 'Bild liegt im Zielbereich', 'Das Bild jeder Teilmenge des Definitionsbereichs liegt im Zielbereich.', 'f(C)\\subseteq B', 'f(C)\\subseteq B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(143, 9, 'M1-EQ-143', 'equation', 'M1.143', 'Bild der Definitionsmenge', 'Das Bild der gesamten Definitionsmenge ist die Bildmenge der Funktion.', 'f(A)=\\operatorname{im}(f)', 'f(A)=\\operatorname{im}(f)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(144, 9, 'M1-EQ-144', 'equation', 'M1.144', 'Bild der leeren Menge', 'Das Bild der leeren Menge ist leer.', 'f(\\varnothing)=\\varnothing', 'f(\\varnothing)=\\varnothing', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(145, 9, 'M1-EQ-145', 'equation', 'M1.145', 'Monotonie der Bildbildung', 'Teilmengeneinschluss bleibt unter der Bildbildung erhalten.', 'C\\subseteq D\\Longrightarrow f(C)\\subseteq f(D)', 'C\\subseteq D\\Longrightarrow f(C)\\subseteq f(D)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(146, 9, 'M1-EQ-146', 'equation', 'M1.146', 'Bild einer Vereinigung', 'Die direkte Bildbildung erhält binäre Vereinigungen.', 'f(C\\cup D)=f(C)\\cup f(D)', 'f(C\\cup D)=f(C)\\cup f(D)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(147, 9, 'M1-EQ-147', 'equation', 'M1.147', 'Bild beliebiger Vereinigungen', 'Die direkte Bildbildung erhält beliebige Vereinigungen.', 'f\\left(\\bigcup_{i\\in I}C_i\\right)=\\bigcup_{i\\in I}f(C_i)', 'f\\left(\\bigcup_{i\\in I}C_i\\right)=\\bigcup_{i\\in I}f(C_i)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(148, 9, 'M1-EQ-148', 'equation', 'M1.148', 'Bild eines Durchschnitts', 'Das Bild eines Durchschnitts liegt im Durchschnitt der Bilder.', 'f(C\\cap D)\\subseteq f(C)\\cap f(D)', 'f(C\\cap D)\\subseteq f(C)\\cap f(D)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(149, 9, 'M1-EQ-149', 'equation', 'M1.149', 'Durchschnittsbild bei Injektivität', 'Bei injektiver Funktion wird der Durchschnitt exakt erhalten.', 'f\\ \\mathrm{injektiv}\\Longrightarrow f(C\\cap D)=f(C)\\cap f(D)', 'f\\ \\mathrm{injektiv}\\Longrightarrow f(C\\cap D)=f(C)\\cap f(D)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(150, 9, 'M1-EQ-150', 'equation', 'M1.150', 'Bild und Mengendifferenz', 'Die Differenz der Bilder liegt im Bild der Mengendifferenz.', 'f(C)\\setminus f(D)\\subseteq f(C\\setminus D)', 'f(C)\\setminus f(D)\\subseteq f(C\\setminus D)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(151, 9, 'M1-EQ-151', 'equation', 'M1.151', 'Differenzbild bei Injektivität', 'Bei injektiver Funktion wird die Mengendifferenz exakt erhalten.', 'f\\ \\mathrm{injektiv}\\Longrightarrow f(C\\setminus D)=f(C)\\setminus f(D)', 'f\\ \\mathrm{injektiv}\\Longrightarrow f(C\\setminus D)=f(C)\\setminus f(D)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(152, 9, 'M1-EQ-152', 'equation', 'M1.152', 'Definition des Urbildes einer Teilmenge', 'Das Urbild einer Zielteilmenge enthält genau die Argumente mit Funktionswert in dieser Menge.', 'f^{-1}(D)=\\left\\{a\\in A\\mid f(a)\\in D\\right\\}', 'f^{-1}(D)=\\left\\{a\\in A\\mid f(a)\\in D\\right\\}', 'supporting', 'canonical', 'literature', 3, NULL, 'checked', 21),
(153, 9, 'M1-EQ-153', 'equation', 'M1.153', 'Urbild liegt im Definitionsbereich', 'Jede Urbildmenge liegt im Definitionsbereich.', 'f^{-1}(D)\\subseteq A', 'f^{-1}(D)\\subseteq A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(154, 9, 'M1-EQ-154', 'equation', 'M1.154', 'Urbild des Zielbereichs', 'Das Urbild des gesamten Zielbereichs ist der Definitionsbereich.', 'f^{-1}(B)=A', 'f^{-1}(B)=A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(155, 9, 'M1-EQ-155', 'equation', 'M1.155', 'Urbild der leeren Menge', 'Das Urbild der leeren Menge ist leer.', 'f^{-1}(\\varnothing)=\\varnothing', 'f^{-1}(\\varnothing)=\\varnothing', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(156, 9, 'M1-EQ-156', 'equation', 'M1.156', 'Monotonie der Urbildbildung', 'Teilmengeneinschluss bleibt unter der Urbildbildung erhalten.', 'D\\subseteq E\\Longrightarrow f^{-1}(D)\\subseteq f^{-1}(E)', 'D\\subseteq E\\Longrightarrow f^{-1}(D)\\subseteq f^{-1}(E)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(157, 9, 'M1-EQ-157', 'equation', 'M1.157', 'Urbild einer Vereinigung', 'Die Urbildbildung erhält binäre Vereinigungen exakt.', 'f^{-1}(D\\cup E)=f^{-1}(D)\\cup f^{-1}(E)', 'f^{-1}(D\\cup E)=f^{-1}(D)\\cup f^{-1}(E)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21);
INSERT INTO `appendix_objects` (`appendix_object_id`, `appendix_section_id`, `object_anchor`, `object_type`, `display_number`, `title`, `content_text`, `formal_latex`, `word_latex`, `importance_level`, `equation_role`, `provenance`, `source_id`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(158, 9, 'M1-EQ-158', 'equation', 'M1.158', 'Urbild eines Durchschnitts', 'Die Urbildbildung erhält binäre Durchschnitte exakt.', 'f^{-1}(D\\cap E)=f^{-1}(D)\\cap f^{-1}(E)', 'f^{-1}(D\\cap E)=f^{-1}(D)\\cap f^{-1}(E)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(159, 9, 'M1-EQ-159', 'equation', 'M1.159', 'Urbild beliebiger Vereinigungen', 'Die Urbildbildung erhält beliebige Vereinigungen exakt.', 'f^{-1}\\left(\\bigcup_{i\\in I}D_i\\right)=\\bigcup_{i\\in I}f^{-1}(D_i)', 'f^{-1}\\left(\\bigcup_{i\\in I}D_i\\right)=\\bigcup_{i\\in I}f^{-1}(D_i)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(160, 9, 'M1-EQ-160', 'equation', 'M1.160', 'Urbild beliebiger Durchschnitte', 'Die Urbildbildung erhält beliebige Durchschnitte exakt.', 'f^{-1}\\left(\\bigcap_{i\\in I}D_i\\right)=\\bigcap_{i\\in I}f^{-1}(D_i)', 'f^{-1}\\left(\\bigcap_{i\\in I}D_i\\right)=\\bigcap_{i\\in I}f^{-1}(D_i)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(161, 9, 'M1-EQ-161', 'equation', 'M1.161', 'Urbild einer Mengendifferenz', 'Die Urbildbildung erhält Mengendifferenzen exakt.', 'f^{-1}(D\\setminus E)=f^{-1}(D)\\setminus f^{-1}(E)', 'f^{-1}(D\\setminus E)=f^{-1}(D)\\setminus f^{-1}(E)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(162, 9, 'M1-EQ-162', 'equation', 'M1.162', 'Urbild eines Komplements', 'Das Urbild des relativen Komplements ist das relative Komplement des Urbildes.', 'f^{-1}(B\\setminus D)=A\\setminus f^{-1}(D)', 'f^{-1}(B\\setminus D)=A\\setminus f^{-1}(D)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(163, 9, 'M1-EQ-163', 'equation', 'M1.163', 'Teilmenge nach Bild und Urbild', 'Eine Ausgangsteilmenge liegt stets in ihrem Urbild nach vorheriger Bildbildung.', 'C\\subseteq f^{-1}(f(C))', 'C\\subseteq f^{-1}(f(C))', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(164, 9, 'M1-EQ-164', 'equation', 'M1.164', 'Rückgewinnung bei Injektivität', 'Bei Injektivität wird eine Ausgangsteilmenge nach Bild- und Urbildbildung exakt zurückgewonnen.', 'f\\ \\mathrm{injektiv}\\Longrightarrow f^{-1}(f(C))=C', 'f\\ \\mathrm{injektiv}\\Longrightarrow f^{-1}(f(C))=C', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(165, 9, 'M1-EQ-165', 'equation', 'M1.165', 'Bild nach Urbild', 'Bild nach Urbild liefert den Schnitt mit der Gesamtbildmenge.', 'f(f^{-1}(D))=D\\cap\\operatorname{im}(f)', 'f(f^{-1}(D))=D\\cap\\operatorname{im}(f)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(166, 9, 'M1-EQ-166', 'equation', 'M1.166', 'Rückgewinnung bei Surjektivität', 'Bei Surjektivität wird eine Zielteilmenge nach Urbild- und Bildbildung exakt zurückgewonnen.', 'f\\ \\mathrm{surjektiv}\\Longrightarrow f(f^{-1}(D))=D', 'f\\ \\mathrm{surjektiv}\\Longrightarrow f(f^{-1}(D))=D', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 21),
(167, 10, 'M1-EQ-167', 'equation', 'M1.167', 'Signatur der Funktionskomposition', 'Signatur der Funktionskomposition.', 'g\\circ f:A\\rightarrow C', 'g\\circ f:A\\rightarrow C', 'core', 'canonical', 'literature', 3, NULL, 'checked', 22),
(168, 10, 'M1-EQ-168', 'equation', 'M1.168', 'Punktweise Definition der Funktionskomposition', 'Punktweise Definition der Funktionskomposition.', '(g\\circ f)(a)=g(f(a))', '(g\\circ f)(a)=g(f(a))', 'core', 'canonical', 'literature', 3, NULL, 'checked', 22),
(169, 10, 'M1-EQ-169', 'equation', 'M1.169', 'Strukturkette der Komposition', 'Strukturkette der Komposition.', 'A\\xrightarrow{f}B\\xrightarrow{g}C', 'A\\xrightarrow{f}B\\xrightarrow{g}C', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 22),
(170, 10, 'M1-EQ-170', 'equation', 'M1.170', 'Allgemeinere Kompositionsbedingung', 'Allgemeinere Kompositionsbedingung.', '\\operatorname{im}(f)\\subseteq D', '\\operatorname{im}(f)\\subseteq D', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 22),
(171, 10, 'M1-EQ-171', 'equation', 'M1.171', 'Linke Identität', 'Linke Identität.', '\\operatorname{id}_B\\circ f=f', '\\operatorname{id}_B\\circ f=f', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 22),
(172, 10, 'M1-EQ-172', 'equation', 'M1.172', 'Punktweise linke Identität', 'Punktweise linke Identität.', '(\\operatorname{id}_B\\circ f)(a)=\\operatorname{id}_B(f(a))=f(a)', '(\\operatorname{id}_B\\circ f)(a)=\\operatorname{id}_B(f(a))=f(a)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 22),
(173, 10, 'M1-EQ-173', 'equation', 'M1.173', 'Rechte Identität', 'Rechte Identität.', 'f\\circ\\operatorname{id}_A=f', 'f\\circ\\operatorname{id}_A=f', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 22),
(174, 10, 'M1-EQ-174', 'equation', 'M1.174', 'Punktweise rechte Identität', 'Punktweise rechte Identität.', '(f\\circ\\operatorname{id}_A)(a)=f(\\operatorname{id}_A(a))=f(a)', '(f\\circ\\operatorname{id}_A)(a)=f(\\operatorname{id}_A(a))=f(a)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 22),
(175, 10, 'M1-EQ-175', 'equation', 'M1.175', 'Dreifache Funktionskette', 'Dreifache Funktionskette.', 'f:A\\rightarrow B,\\qquad g:B\\rightarrow C,\\qquad h:C\\rightarrow D', 'f:A\\rightarrow B,\\qquad g:B\\rightarrow C,\\qquad h:C\\rightarrow D', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 22),
(176, 10, 'M1-EQ-176', 'equation', 'M1.176', 'Assoziativität der Funktionskomposition', 'Assoziativität der Funktionskomposition.', 'h\\circ(g\\circ f)=(h\\circ g)\\circ f', 'h\\circ(g\\circ f)=(h\\circ g)\\circ f', 'core', 'canonical', 'literature', 3, NULL, 'checked', 22),
(177, 10, 'M1-EQ-177', 'equation', 'M1.177', 'Punktweise Assoziativität', 'Punktweise Assoziativität.', '(h\\circ(g\\circ f))(a)=h(g(f(a)))=((h\\circ g)\\circ f)(a)', '(h\\circ(g\\circ f))(a)=h(g(f(a)))=((h\\circ g)\\circ f)(a)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 22),
(178, 10, 'M1-EQ-178', 'equation', 'M1.178', 'Injektivität einer Komposition', 'Injektivität einer Komposition.', 'f\\ \\mathrm{injektiv}\\land g\\ \\mathrm{injektiv}\\Longrightarrow g\\circ f\\ \\mathrm{injektiv}', 'f\\ \\mathrm{injektiv}\\land g\\ \\mathrm{injektiv}\\Longrightarrow g\\circ f\\ \\mathrm{injektiv}', 'supporting', 'derived', 'literature', 3, 'Injektivität gemäß M1.7 und passende Definitions-/Zielbereiche.', 'checked', 22),
(179, 10, 'M1-EQ-179', 'equation', 'M1.179', 'Ausgangspunkt des Injektivitätsnachweises', 'Ausgangspunkt des Injektivitätsnachweises.', 'g(f(a_1))=g(f(a_2))', 'g(f(a_1))=g(f(a_2))', 'derivation', 'proof_step', 'literature', 3, NULL, 'checked', 22),
(180, 10, 'M1-EQ-180', 'equation', 'M1.180', 'Zwischenschritt des Injektivitätsnachweises', 'Zwischenschritt des Injektivitätsnachweises.', 'f(a_1)=f(a_2)', 'f(a_1)=f(a_2)', 'derivation', 'proof_step', 'literature', 3, NULL, 'checked', 22),
(181, 10, 'M1-EQ-181', 'equation', 'M1.181', 'Abschluss des Injektivitätsnachweises', 'Abschluss des Injektivitätsnachweises.', 'a_1=a_2', 'a_1=a_2', 'derivation', 'proof_step', 'literature', 3, NULL, 'checked', 22),
(182, 10, 'M1-EQ-182', 'equation', 'M1.182', 'Injektive Komposition erzwingt injektiven ersten Faktor', 'Injektive Komposition erzwingt injektiven ersten Faktor.', 'g\\circ f\\ \\mathrm{injektiv}\\Longrightarrow f\\ \\mathrm{injektiv}', 'g\\circ f\\ \\mathrm{injektiv}\\Longrightarrow f\\ \\mathrm{injektiv}', 'supporting', 'derived', 'literature', 3, 'Injektivität gemäß M1.7 und passende Definitions-/Zielbereiche.', 'checked', 22),
(183, 10, 'M1-EQ-183', 'equation', 'M1.183', 'Surjektivität einer Komposition', 'Surjektivität einer Komposition.', 'f\\ \\mathrm{surjektiv}\\land g\\ \\mathrm{surjektiv}\\Longrightarrow g\\circ f\\ \\mathrm{surjektiv}', 'f\\ \\mathrm{surjektiv}\\land g\\ \\mathrm{surjektiv}\\Longrightarrow g\\circ f\\ \\mathrm{surjektiv}', 'supporting', 'derived', 'literature', 3, 'Surjektivität gemäß M1.7 und passende Definitions-/Zielbereiche.', 'checked', 22),
(184, 10, 'M1-EQ-184', 'equation', 'M1.184', 'Surjektive Komposition erzwingt surjektiven zweiten Faktor', 'Surjektive Komposition erzwingt surjektiven zweiten Faktor.', 'g\\circ f\\ \\mathrm{surjektiv}\\Longrightarrow g\\ \\mathrm{surjektiv}', 'g\\circ f\\ \\mathrm{surjektiv}\\Longrightarrow g\\ \\mathrm{surjektiv}', 'supporting', 'derived', 'literature', 3, 'Surjektivität gemäß M1.7 und passende Definitions-/Zielbereiche.', 'checked', 22),
(185, 10, 'M1-EQ-185', 'equation', 'M1.185', 'Bijektivität einer Komposition', 'Bijektivität einer Komposition.', 'f\\ \\mathrm{bijektiv}\\land g\\ \\mathrm{bijektiv}\\Longrightarrow g\\circ f\\ \\mathrm{bijektiv}', 'f\\ \\mathrm{bijektiv}\\land g\\ \\mathrm{bijektiv}\\Longrightarrow g\\circ f\\ \\mathrm{bijektiv}', 'supporting', 'derived', 'literature', 3, 'Bijektivität der beteiligten Funktionen und passende Definitions-/Zielbereiche.', 'checked', 22),
(186, 10, 'M1-EQ-186', 'equation', 'M1.186', 'Inverse einer Komposition', 'Inverse einer Komposition.', '(g\\circ f)^{-1}=f^{-1}\\circ g^{-1}', '(g\\circ f)^{-1}=f^{-1}\\circ g^{-1}', 'supporting', 'derived', 'literature', 3, 'Bijektivität der beteiligten Funktionen und passende Definitions-/Zielbereiche.', 'checked', 22),
(187, 10, 'M1-EQ-187', 'equation', 'M1.187', 'Linke Identitätsprüfung der inversen Komposition', 'Linke Identitätsprüfung der inversen Komposition.', '(f^{-1}\\circ g^{-1})\\circ(g\\circ f)=\\operatorname{id}_A', '(f^{-1}\\circ g^{-1})\\circ(g\\circ f)=\\operatorname{id}_A', 'supporting', 'derived', 'literature', 3, 'Bijektivität der beteiligten Funktionen und passende Definitions-/Zielbereiche.', 'checked', 22),
(188, 10, 'M1-EQ-188', 'equation', 'M1.188', 'Rechte Identitätsprüfung der inversen Komposition', 'Rechte Identitätsprüfung der inversen Komposition.', '(g\\circ f)\\circ(f^{-1}\\circ g^{-1})=\\operatorname{id}_C', '(g\\circ f)\\circ(f^{-1}\\circ g^{-1})=\\operatorname{id}_C', 'supporting', 'derived', 'literature', 3, 'Bijektivität der beteiligten Funktionen und passende Definitions-/Zielbereiche.', 'checked', 22),
(189, 11, 'M1-EQ-189', 'equation', 'M1.189', 'Zweistellige Funktionssignatur', 'Zweistellige Funktionssignatur.', 'f:A\\times B\\rightarrow C', 'f:A\\times B\\rightarrow C', 'core', 'canonical', 'literature', 3, NULL, 'checked', 23),
(190, 11, 'M1-EQ-190', 'equation', 'M1.190', 'Wertebereich einer zweistelligen Funktion', 'Wertebereich einer zweistelligen Funktion.', 'f(a,b)\\in C', 'f(a,b)\\in C', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(191, 11, 'M1-EQ-191', 'equation', 'M1.191', 'Paarargument einer zweistelligen Funktion', 'Paarargument einer zweistelligen Funktion.', 'f(a,b)=f\\left((a,b)\\right)', 'f(a,b)=f\\left((a,b)\\right)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(192, 11, 'M1-EQ-192', 'equation', 'M1.192', 'Mehrstellige Funktionssignatur', 'Mehrstellige Funktionssignatur.', 'f:A_1\\times A_2\\times\\cdots\\times A_n\\rightarrow B', 'f:A_1\\times A_2\\times\\cdots\\times A_n\\rightarrow B', 'core', 'canonical', 'literature', 3, NULL, 'checked', 23),
(193, 11, 'M1-EQ-193', 'equation', 'M1.193', 'Tupelzugehörigkeit', 'Tupelzugehörigkeit.', '(a_1,\\ldots,a_n)\\in A_1\\times\\cdots\\times A_n', '(a_1,\\ldots,a_n)\\in A_1\\times\\cdots\\times A_n', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(194, 11, 'M1-EQ-194', 'equation', 'M1.194', 'Funktionswert einer mehrstelligen Funktion', 'Funktionswert einer mehrstelligen Funktion.', 'f(a_1,\\ldots,a_n)\\in B', 'f(a_1,\\ldots,a_n)\\in B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(195, 11, 'M1-EQ-195', 'equation', 'M1.195', 'Mehrstellige Funktion bei identischen Faktoren', 'Mehrstellige Funktion bei identischen Faktoren.', 'f:A^n\\rightarrow B', 'f:A^n\\rightarrow B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(196, 11, 'M1-EQ-196', 'equation', 'M1.196', 'Ausgangsfunktion zur Argumentfixierung', 'Ausgangsfunktion zur Argumentfixierung.', 'f:A\\times B\\rightarrow C', 'f:A\\times B\\rightarrow C', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(197, 11, 'M1-EQ-197', 'equation', 'M1.197', 'Teilfunktion bei fixiertem ersten Argument', 'Teilfunktion bei fixiertem ersten Argument.', 'f_{a_0}:B\\rightarrow C', 'f_{a_0}:B\\rightarrow C', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(198, 11, 'M1-EQ-198', 'equation', 'M1.198', 'Definition bei fixiertem ersten Argument', 'Definition bei fixiertem ersten Argument.', 'f_{a_0}(b)=f(a_0,b)', 'f_{a_0}(b)=f(a_0,b)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(199, 11, 'M1-EQ-199', 'equation', 'M1.199', 'Teilfunktion bei fixiertem zweiten Argument', 'Teilfunktion bei fixiertem zweiten Argument.', 'f^{b_0}:A\\rightarrow C', 'f^{b_0}:A\\rightarrow C', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(200, 11, 'M1-EQ-200', 'equation', 'M1.200', 'Definition bei fixiertem zweiten Argument', 'Definition bei fixiertem zweiten Argument.', 'f^{b_0}(a)=f(a,b_0)', 'f^{b_0}(a)=f(a,b_0)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(201, 11, 'M1-EQ-201', 'equation', 'M1.201', 'Parametrisierte Funktionsfamilie', 'Parametrisierte Funktionsfamilie.', '\\left\\{f_\\theta\\mid\\theta\\in\\Theta\\right\\}', '\\left\\{f_\\theta\\mid\\theta\\in\\Theta\\right\\}', 'core', 'canonical', 'literature', 3, NULL, 'checked', 23),
(202, 11, 'M1-EQ-202', 'equation', 'M1.202', 'Gemeinsame Signatur einer Funktionsfamilie', 'Gemeinsame Signatur einer Funktionsfamilie.', 'f_\\theta:A\\rightarrow B\\qquad\\forall\\theta\\in\\Theta', 'f_\\theta:A\\rightarrow B\\qquad\\forall\\theta\\in\\Theta', 'core', 'canonical', 'literature', 3, NULL, 'checked', 23),
(203, 11, 'M1-EQ-203', 'equation', 'M1.203', 'Produktdarstellung einer Funktionsfamilie', 'Produktdarstellung einer Funktionsfamilie.', 'F:\\Theta\\times A\\rightarrow B', 'F:\\Theta\\times A\\rightarrow B', 'core', 'canonical', 'literature', 3, NULL, 'checked', 23),
(204, 11, 'M1-EQ-204', 'equation', 'M1.204', 'Äquivalenz von Familien- und Produktdarstellung', 'Äquivalenz von Familien- und Produktdarstellung.', 'F(\\theta,a)=f_\\theta(a)', 'F(\\theta,a)=f_\\theta(a)', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(205, 11, 'M1-EQ-205', 'equation', 'M1.205', 'Tatsächlicher Definitionsbereich einer partiellen Funktion', 'Tatsächlicher Definitionsbereich einer partiellen Funktion.', 'D\\subseteq A', 'D\\subseteq A', 'core', 'canonical', 'literature', 3, NULL, 'checked', 23),
(206, 11, 'M1-EQ-206', 'equation', 'M1.206', 'Signatur einer partiellen Funktion', 'Signatur einer partiellen Funktion.', 'f:D\\rightarrow B', 'f:D\\rightarrow B', 'core', 'canonical', 'literature', 3, NULL, 'checked', 23),
(207, 11, 'M1-EQ-207', 'equation', 'M1.207', 'Funktionsbedingung auf dem tatsächlichen Definitionsbereich', 'Funktionsbedingung auf dem tatsächlichen Definitionsbereich.', '\\forall d\\in D\\ \\exists!b\\in B:f(d)=b', '\\forall d\\in D\\ \\exists!b\\in B:f(d)=b', 'core', 'canonical', 'literature', 3, NULL, 'checked', 23),
(208, 11, 'M1-EQ-208', 'equation', 'M1.208', 'Definitionsbereich einer partiellen Funktion', 'Definitionsbereich einer partiellen Funktion.', '\\operatorname{dom}(f)=D\\subseteq A', '\\operatorname{dom}(f)=D\\subseteq A', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(209, 11, 'M1-EQ-209', 'equation', 'M1.209', 'Einschränkung als partielle Betrachtung', 'Einschränkung als partielle Betrachtung.', 'f|_D:D\\rightarrow B', 'f|_D:D\\rightarrow B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(210, 11, 'M1-EQ-210', 'equation', 'M1.210', 'Bedingung einer Erweiterung', 'Bedingung einer Erweiterung.', 'F|_D=f', 'F|_D=f', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(211, 11, 'M1-EQ-211', 'equation', 'M1.211', 'Graph einer partiellen Funktion', 'Graph einer partiellen Funktion.', 'G_f=\\left\\{(d,f(d))\\mid d\\in D\\right\\}\\subseteq A\\times B', 'G_f=\\left\\{(d,f(d))\\mid d\\in D\\right\\}\\subseteq A\\times B', 'supporting', 'derived', 'literature', 3, NULL, 'checked', 23),
(212, 12, 'M1-RES-001', 'statement', NULL, 'Ergebnisbestand Mengenstruktur', 'Elementzugehörigkeit, Mengengleichheit, Teilmengen und Potenzmengen bilden die elementare Mengenstruktur von M1.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(213, 12, 'M1-RES-002', 'statement', NULL, 'Ergebnisbestand Mengenoperationen', 'Vereinigung, Durchschnitt, Differenz, Komplement, De-Morgan-Beziehungen und Distributivität bilden die in M1 benötigte Operationsstruktur auf Mengen.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(214, 12, 'M1-RES-003', 'statement', NULL, 'Ergebnisbestand geordnete Strukturen', 'Geordnete Paare, Tupel, kartesische Produkte und Projektionen stellen positionsabhängige Komponentenstrukturen bereit.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(215, 12, 'M1-RES-004', 'statement', NULL, 'Ergebnisbestand Relationen', 'Relationen sind ausgewählte Teilmengen kartesischer Produkte; ihre Eigenschaften, Umkehrung und Komposition sind in M1 bestimmt.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(216, 12, 'M1-RES-005', 'statement', NULL, 'Ergebnisbestand Funktionen', 'Funktionen entstehen aus Relationen durch vollständige Existenz und Eindeutigkeit auf dem Definitionsbereich.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(217, 12, 'M1-RES-006', 'statement', NULL, 'Ergebnisbestand Injektivität, Surjektivität und Bijektivität', 'Injektivität, Surjektivität und Bijektivität unterscheiden Rückschlussfähigkeit, Zielbereichsabdeckung und eindeutige Umkehrbarkeit.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(218, 12, 'M1-RES-007', 'statement', NULL, 'Ergebnisbestand Bild und Urbild', 'Bild- und Urbildbildung übertragen Funktionen auf Teilmengen und besitzen unterschiedliche Erhaltungseigenschaften gegenüber Mengenoperationen.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(219, 12, 'M1-RES-008', 'statement', NULL, 'Ergebnisbestand Funktionskomposition', 'Funktionskomposition ist bereichsabhängig, assoziativ und nicht allgemein kommutativ; Identitäten wirken neutral.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(220, 12, 'M1-RES-009', 'statement', NULL, 'Ergebnisbestand mehrstellige Funktionen', 'Mehrstellige Funktionen sind gewöhnliche Funktionen auf kartesischen Produktbereichen.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(221, 12, 'M1-RES-010', 'statement', NULL, 'Ergebnisbestand parametrisierte Funktionsfamilien', 'Parametrisierte Funktionsfamilien unterscheiden Funktionsobjekte durch Parameter, ohne dem Parameter bereits eine physikalische Bedeutung zuzuweisen.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(222, 12, 'M1-RES-011', 'statement', NULL, 'Ergebnisbestand partielle Funktionen', 'Partielle Funktionen sind vollständige Funktionen auf ihrem tatsächlichen Definitionsbereich innerhalb eines größeren Grundbereichs.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(223, 12, 'M1-RES-012', 'statement', NULL, 'Abhängigkeitsstruktur M1', 'M1 ordnet Mengen, geordnete Strukturen, Relationen und Funktionen in eine explizite Voraussetzungskette.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(224, 12, 'M1-BOUNDARY-001', 'statement', NULL, 'Aussagegrenzen M1', 'M1 begründet weder Vektorraumstruktur noch Geometrie, Kausalität, Zeitentwicklung, physikalische Reversibilität oder unabhängige Dimensionen.', NULL, NULL, 'supporting', NULL, 'mixed', NULL, NULL, 'checked', 24),
(225, 12, 'M1-HANDOFF-M2', 'statement', NULL, 'Übergabe M1 an M2', 'M2 übernimmt aus M1 die gesicherte Mengen- und Funktionsstruktur und ergänzt darauf Vektoraddition und Skalarmultiplikation als neue algebraische Struktur.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(226, 12, 'M1-HANDOFF-MAINTEXT', 'statement', NULL, 'Übergabe M1 an den späteren Haupttext', 'Der spätere Haupttext übernimmt nach Abschluss der mathematischen Anlagen ausschließlich benötigte Ergebnisse aus M1; der Haupttext ist keine Quelle für M1.', NULL, NULL, 'core', NULL, 'mixed', NULL, NULL, 'checked', 24),
(227, 13, 'M2-IN-M1', 'other', NULL, 'Eingangsstelle M1 → M2', 'M2 übernimmt ausschließlich den geprüften Mengen-, Relations- und Funktionsbestand aus M1. Algebraische Operationen werden erst in M2 eingeführt.', NULL, NULL, 'core', NULL, 'original', NULL, NULL, 'checked', 25),
(228, 13, 'M2-PLAN-001', 'other', NULL, 'Innere Abhängigkeitsstruktur von M2', 'Körper und Skalare → Vektorraum und Vektorraumaxiome → Nullvektor und additives Inverses → abgeleitete Nullbeziehungen → Untervektorräume → Linearkombinationen → Spannraum → lineare Abhängigkeit und Unabhängigkeit → Erzeugendensystem → Basis → Dimension → Koordinatendarstellung bezüglich einer Basis.', NULL, NULL, 'core', NULL, 'original', NULL, NULL, 'checked', 25),
(229, 13, 'M2-HANDOFF-M3', 'other', NULL, 'Übergabe M2 → M3', 'Nach Abschluss von M2 übernimmt M3 Vektorräume, Basen und Koordinatendarstellungen als geprüfte Voraussetzungen für lineare Abbildungen und Matrixdarstellungen.', NULL, NULL, 'core', NULL, 'original', NULL, NULL, 'checked', 25),
(230, 13, 'M2-HANDOFF-MAINTEXT', 'other', NULL, 'Übergabe M2 → späterer Haupttext', 'Der spätere Haupttext übernimmt ausschließlich aus dem geprüften M2-Ergebnisbestand; er ist keine Quelle für M2.', NULL, NULL, 'core', NULL, 'original', NULL, NULL, 'checked', 25),
(231, 13, 'M2-HANDOFF-M2.1', 'other', NULL, 'Weitergabestelle M2.0 → M2.1', 'M2.1 bestimmt zunächst Körper und Skalare als Voraussetzung der Skalarmultiplikation und der anschließenden Vektorraumdefinition.', NULL, NULL, 'supporting', NULL, 'original', NULL, NULL, 'checked', 25),
(232, 13, 'M2-BOUNDARY-001', 'other', NULL, 'Aussagegrenze von M2.0', 'M2.0 führt noch keine Geometrie, Länge, Winkel oder Orthogonalität ein; diese Strukturen benötigen später ein Skalarprodukt.', NULL, NULL, 'core', NULL, 'original', NULL, NULL, 'checked', 25),
(233, 14, 'M2-EQ-001', 'equation', 'M2.1', 'Addition als innere Körperoperation', 'Addition als innere Körperoperation.', '+:K\\times K\\rightarrow K', '+:K\\times K\\rightarrow K', 'core', 'canonical', 'literature', 50, NULL, 'checked', 26),
(234, 14, 'M2-EQ-002', 'equation', 'M2.2', 'Additionsschreibweise', 'Additionsschreibweise.', '(a,b)\\mapsto a+b', '(a,b)\\mapsto a+b', 'supporting', 'derived', 'literature', 50, NULL, 'checked', 26),
(235, 14, 'M2-EQ-003', 'equation', 'M2.3', 'Multiplikation als innere Körperoperation', 'Multiplikation als innere Körperoperation.', '\\cdot:K\\times K\\rightarrow K', '\\cdot:K\\times K\\rightarrow K', 'core', 'canonical', 'literature', 50, NULL, 'checked', 26),
(236, 14, 'M2-EQ-004', 'equation', 'M2.4', 'Multiplikationsschreibweise', 'Multiplikationsschreibweise.', '(a,b)\\mapsto ab', '(a,b)\\mapsto ab', 'supporting', 'derived', 'literature', 50, NULL, 'checked', 26),
(237, 14, 'M2-EQ-005', 'equation', 'M2.5', 'Assoziativität der Addition', 'Assoziativität der Addition.', '(a+b)+c=a+(b+c)', '(a+b)+c=a+(b+c)', 'core', 'canonical', 'literature', 50, 'a,b,c\\in K', 'checked', 26),
(238, 14, 'M2-EQ-006', 'equation', 'M2.6', 'Kommutativität der Addition', 'Kommutativität der Addition.', 'a+b=b+a', 'a+b=b+a', 'core', 'canonical', 'literature', 50, 'a,b\\in K', 'checked', 26),
(239, 14, 'M2-EQ-007', 'equation', 'M2.7', 'Existenz des additiven neutralen Elements', 'Existenz des additiven neutralen Elements.', '\\exists 0_K\\in K\\ \\forall a\\in K:a+0_K=a', '\\exists 0_K\\in K\\ \\forall a\\in K:a+0_K=a', 'core', 'canonical', 'literature', 50, NULL, 'checked', 26),
(240, 14, 'M2-EQ-008', 'equation', 'M2.8', 'Existenz additiver Inverser', 'Existenz additiver Inverser.', '\\forall a\\in K\\ \\exists(-a)\\in K:a+(-a)=0_K', '\\forall a\\in K\\ \\exists(-a)\\in K:a+(-a)=0_K', 'core', 'canonical', 'literature', 50, NULL, 'checked', 26),
(241, 14, 'M2-EQ-009', 'equation', 'M2.9', 'Subtraktion als abgeleitete Operation', 'Subtraktion als abgeleitete Operation.', 'a-b=a+(-b)', 'a-b=a+(-b)', 'supporting', 'derived', 'literature', 50, NULL, 'checked', 26),
(242, 14, 'M2-EQ-010', 'equation', 'M2.10', 'Assoziativität der Multiplikation', 'Assoziativität der Multiplikation.', '(ab)c=a(bc)', '(ab)c=a(bc)', 'core', 'canonical', 'literature', 50, 'a,b,c\\in K', 'checked', 26),
(243, 14, 'M2-EQ-011', 'equation', 'M2.11', 'Kommutativität der Multiplikation', 'Kommutativität der Multiplikation.', 'ab=ba', 'ab=ba', 'core', 'canonical', 'literature', 50, 'a,b\\in K', 'checked', 26),
(244, 14, 'M2-EQ-012', 'equation', 'M2.12', 'Existenz des multiplikativen neutralen Elements', 'Existenz des multiplikativen neutralen Elements.', '\\exists 1_K\\in K\\ \\forall a\\in K:1_Ka=a', '\\exists 1_K\\in K\\ \\forall a\\in K:1_Ka=a', 'core', 'canonical', 'literature', 50, NULL, 'checked', 26),
(245, 14, 'M2-EQ-013', 'equation', 'M2.13', 'Verschiedenheit der neutralen Elemente', 'Verschiedenheit der neutralen Elemente.', '1_K\\neq 0_K', '1_K\\neq 0_K', 'core', 'canonical', 'literature', 50, NULL, 'checked', 26),
(246, 14, 'M2-EQ-014', 'equation', 'M2.14', 'Existenz multiplikativer Inverser', 'Existenz multiplikativer Inverser.', '\\forall a\\in K\\setminus\\left\\{0_K\\right\\}\\ \\exists a^{-1}\\in K:aa^{-1}=1_K', '\\forall a\\in K\\setminus\\left\\{0_K\\right\\}\\ \\exists a^{-1}\\in K:aa^{-1}=1_K', 'core', 'canonical', 'literature', 50, NULL, 'checked', 26),
(247, 14, 'M2-EQ-015', 'equation', 'M2.15', 'Division als abgeleitete Operation', 'Division als abgeleitete Operation.', '\\frac{a}{b}=ab^{-1}', '\\frac{a}{b}=ab^{-1}', 'supporting', 'derived', 'literature', 50, 'b\\neq 0_K', 'checked', 26),
(248, 14, 'M2-EQ-016', 'equation', 'M2.16', 'Distributivgesetz', 'Distributivgesetz.', 'a(b+c)=ab+ac', 'a(b+c)=ab+ac', 'core', 'canonical', 'literature', 50, 'a,b,c\\in K', 'checked', 26),
(249, 14, 'M2-EQ-017', 'equation', 'M2.17', 'Rechtes Distributivgesetz', 'Rechtes Distributivgesetz.', '(a+b)c=ac+bc', '(a+b)c=ac+bc', 'supporting', 'derived', 'literature', 50, 'a,b,c\\in K', 'checked', 26),
(250, 14, 'M2-EQ-018', 'equation', 'M2.18', 'Eindeutigkeit des additiven neutralen Elements', 'Eindeutigkeit des additiven neutralen Elements.', '0_K=0_K+0\'_K=0\'_K', '0_K=0_K+0\'_K=0\'_K', 'derivation', 'proof_step', 'literature', 50, NULL, 'checked', 26),
(251, 14, 'M2-EQ-019', 'equation', 'M2.19', 'Eindeutigkeit des multiplikativen neutralen Elements', 'Eindeutigkeit des multiplikativen neutralen Elements.', '1_K=1_K1\'_K=1\'_K', '1_K=1_K1\'_K=1\'_K', 'derivation', 'proof_step', 'literature', 50, NULL, 'checked', 26),
(252, 14, 'M2-EQ-020', 'equation', 'M2.20', 'Eindeutigkeit des additiven Inversen', 'Eindeutigkeit des additiven Inversen.', 'b=b+0_K=b+(a+c)=(b+a)+c=0_K+c=c', 'b=b+0_K=b+(a+c)=(b+a)+c=0_K+c=c', 'derivation', 'proof_step', 'literature', 50, NULL, 'checked', 26),
(253, 14, 'M2-EQ-021', 'equation', 'M2.21', 'Eindeutigkeit des multiplikativen Inversen', 'Eindeutigkeit des multiplikativen Inversen.', 'b=b1_K=b(ac)=(ba)c=1_Kc=c', 'b=b1_K=b(ac)=(ba)c=1_Kc=c', 'derivation', 'proof_step', 'literature', 50, 'a\\neq 0_K', 'checked', 26),
(254, 14, 'M2-EQ-022', 'equation', 'M2.22', 'Nullabsorption im Körper', 'Nullabsorption im Körper.', 'a0_K=0_K', 'a0_K=0_K', 'supporting', 'derived', 'literature', 50, 'a\\in K', 'checked', 26),
(255, 14, 'M2-EQ-023', 'equation', 'M2.23', 'Herleitung der Nullabsorption', 'Herleitung der Nullabsorption.', 'a0_K=a(0_K+0_K)=a0_K+a0_K', 'a0_K=a(0_K+0_K)=a0_K+a0_K', 'derivation', 'proof_step', 'literature', 50, 'a\\in K', 'checked', 26),
(256, 14, 'M2-EQ-024', 'equation', 'M2.24', 'Schluss der Nullabsorptionsherleitung', 'Schluss der Nullabsorptionsherleitung.', 'a0_K=0_K', 'a0_K=0_K', 'derivation', 'proof_step', 'literature', 50, 'a\\in K', 'checked', 26),
(257, 14, 'M2-EQ-025', 'equation', 'M2.25', 'Nichtnullskalare', 'Nichtnullskalare.', 'K^\\times=K\\setminus\\left\\{0_K\\right\\}', 'K^\\times=K\\setminus\\left\\{0_K\\right\\}', 'supporting', 'derived', 'literature', 50, NULL, 'checked', 26),
(258, 14, 'M2-EQ-026', 'equation', 'M2.26', 'Reeller oder komplexer Skalarkörper', 'Reeller oder komplexer Skalarkörper.', 'K=\\mathbb{R}\\qquad\\mathrm{oder}\\qquad K=\\mathbb{C}', 'K=\\mathbb{R}\\qquad\\mathrm{oder}\\qquad K=\\mathbb{C}', 'example', 'example', 'literature', 51, NULL, 'checked', 26),
(259, 14, 'M2-EQ-027', 'equation', 'M2.27', 'Übergang zu den Vektorraumoperationen', 'Übergang zu den Vektorraumoperationen.', '+:V\\times V\\rightarrow V,\\qquad\\cdot:K\\times V\\rightarrow V', '+:V\\times V\\rightarrow V,\\qquad\\cdot:K\\times V\\rightarrow V', 'core', 'canonical', 'literature', 50, NULL, 'checked', 26),
(260, 14, 'M2-HANDOFF-M2.2', 'statement', NULL, 'Weitergabestelle M2.1 → M2.2', 'Übergabe des Skalarkörpers K, seiner Operationen, neutralen Elemente und Rechenregeln an M2.2 Vektorraum und Vektorraumaxiome.', NULL, NULL, 'core', NULL, 'original', NULL, NULL, 'checked', 26),
(289, 16, 'M2-EQ-028', 'equation', 'M2.28', 'Vektoraddition als innere Verknüpfung', 'Vektoraddition als innere Verknüpfung.', '+:V\\times V\\rightarrow V', '+:V\\times V\\rightarrow V', 'core', 'canonical', 'literature', 50, '[[71]]; M2.1 Körper K', 'checked', 28),
(290, 16, 'M2-EQ-029', 'equation', 'M2.29', 'Auswertung der Vektoraddition', 'Auswertung der Vektoraddition.', '(u,v)\\mapsto u+v', '(u,v)\\mapsto u+v', 'supporting', 'canonical', 'literature', 50, 'u,v\\in V', 'checked', 28),
(291, 16, 'M2-EQ-030', 'equation', 'M2.30', 'Skalarmultiplikation', 'Skalarmultiplikation.', '\\cdot:K\\times V\\rightarrow V', '\\cdot:K\\times V\\rightarrow V', 'core', 'canonical', 'literature', 50, 'K Körper; V Menge', 'checked', 28),
(292, 16, 'M2-EQ-031', 'equation', 'M2.31', 'Auswertung der Skalarmultiplikation', 'Auswertung der Skalarmultiplikation.', '(\\lambda,v)\\mapsto\\lambda v', '(\\lambda,v)\\mapsto\\lambda v', 'supporting', 'canonical', 'literature', 50, '\\lambda\\in K; v\\in V', 'checked', 28),
(293, 16, 'M2-EQ-032', 'equation', 'M2.32', 'Assoziativität der Vektoraddition', 'Assoziativität der Vektoraddition.', '(u+v)+w=u+(v+w)', '(u+v)+w=u+(v+w)', 'core', 'canonical', 'literature', 50, 'u,v,w\\in V', 'checked', 28),
(294, 16, 'M2-EQ-033', 'equation', 'M2.33', 'Kommutativität der Vektoraddition', 'Kommutativität der Vektoraddition.', 'u+v=v+u', 'u+v=v+u', 'core', 'canonical', 'literature', 50, 'u,v\\in V', 'checked', 28),
(295, 16, 'M2-EQ-034', 'equation', 'M2.34', 'Existenz des Nullvektors', 'Existenz des Nullvektors.', '\\exists 0_V\\in V\\ \\forall v\\in V:v+0_V=v', '\\exists 0_V\\in V\\ \\forall v\\in V:v+0_V=v', 'core', 'canonical', 'literature', 50, 'Vektoraddition', 'checked', 28),
(296, 16, 'M2-EQ-035', 'equation', 'M2.35', 'Existenz additiver Inverser', 'Existenz additiver Inverser.', '\\forall v\\in V\\ \\exists(-v)\\in V:v+(-v)=0_V', '\\forall v\\in V\\ \\exists(-v)\\in V:v+(-v)=0_V', 'core', 'canonical', 'literature', 50, 'v\\in V', 'checked', 28),
(297, 16, 'M2-EQ-036', 'equation', 'M2.36', 'Verträglichkeit mit der Körpermultiplikation', 'Verträglichkeit mit der Körpermultiplikation.', '(\\lambda\\mu)v=\\lambda(\\mu v)', '(\\lambda\\mu)v=\\lambda(\\mu v)', 'core', 'canonical', 'literature', 50, '\\lambda,\\mu\\in K; v\\in V', 'checked', 28),
(298, 16, 'M2-EQ-037', 'equation', 'M2.37', 'Wirkung des skalaren Einselements', 'Wirkung des skalaren Einselements.', '1_Kv=v\\qquad\\forall v\\in V', '1_Kv=v\\qquad\\forall v\\in V', 'core', 'canonical', 'literature', 50, '1_K Körper-Eins', 'checked', 28),
(299, 16, 'M2-EQ-038', 'equation', 'M2.38', 'Distributivität über der Vektoraddition', 'Distributivität über der Vektoraddition.', '\\lambda(u+v)=\\lambda u+\\lambda v', '\\lambda(u+v)=\\lambda u+\\lambda v', 'core', 'canonical', 'literature', 50, '\\lambda\\in K; u,v\\in V', 'checked', 28),
(300, 16, 'M2-EQ-039', 'equation', 'M2.39', 'Distributivität über der Skalaraddition', 'Distributivität über der Skalaraddition.', '(\\lambda+\\mu)v=\\lambda v+\\mu v', '(\\lambda+\\mu)v=\\lambda v+\\mu v', 'core', 'canonical', 'literature', 50, '\\lambda,\\mu\\in K; v\\in V', 'checked', 28),
(301, 16, 'M2-EQ-040', 'equation', 'M2.40', 'Axiombestand: Assoziativität', 'Axiombestand: Assoziativität.', '(u+v)+w=u+(v+w)', '(u+v)+w=u+(v+w)', 'supporting', 'canonical', 'literature', 50, 'Zusammenfassung M2.32-M2.39', 'checked', 28),
(302, 16, 'M2-EQ-041', 'equation', 'M2.41', 'Axiombestand: Kommutativität', 'Axiombestand: Kommutativität.', 'u+v=v+u', 'u+v=v+u', 'supporting', 'canonical', 'literature', 50, 'Zusammenfassung M2.32-M2.39', 'checked', 28),
(303, 16, 'M2-EQ-042', 'equation', 'M2.42', 'Axiombestand: additives Neutrum', 'Axiombestand: additives Neutrum.', 'v+0_V=v', 'v+0_V=v', 'supporting', 'canonical', 'literature', 50, 'Zusammenfassung M2.32-M2.39', 'checked', 28),
(304, 16, 'M2-EQ-043', 'equation', 'M2.43', 'Axiombestand: additives Inverses', 'Axiombestand: additives Inverses.', 'v+(-v)=0_V', 'v+(-v)=0_V', 'supporting', 'canonical', 'literature', 50, 'Zusammenfassung M2.32-M2.39', 'checked', 28),
(305, 16, 'M2-EQ-044', 'equation', 'M2.44', 'Axiombestand: skalare Assoziativität', 'Axiombestand: skalare Assoziativität.', '(\\lambda\\mu)v=\\lambda(\\mu v)', '(\\lambda\\mu)v=\\lambda(\\mu v)', 'supporting', 'canonical', 'literature', 50, 'Zusammenfassung M2.32-M2.39', 'checked', 28),
(306, 16, 'M2-EQ-045', 'equation', 'M2.45', 'Axiombestand: skalare Eins', 'Axiombestand: skalare Eins.', '1_Kv=v', '1_Kv=v', 'supporting', 'canonical', 'literature', 50, 'Zusammenfassung M2.32-M2.39', 'checked', 28),
(307, 16, 'M2-EQ-046', 'equation', 'M2.46', 'Axiombestand: Distributivität über V', 'Axiombestand: Distributivität über V.', '\\lambda(u+v)=\\lambda u+\\lambda v', '\\lambda(u+v)=\\lambda u+\\lambda v', 'supporting', 'canonical', 'literature', 50, 'Zusammenfassung M2.32-M2.39', 'checked', 28),
(308, 16, 'M2-EQ-047', 'equation', 'M2.47', 'Axiombestand: Distributivität über K', 'Axiombestand: Distributivität über K.', '(\\lambda+\\mu)v=\\lambda v+\\mu v', '(\\lambda+\\mu)v=\\lambda v+\\mu v', 'supporting', 'canonical', 'literature', 50, 'Zusammenfassung M2.32-M2.39', 'checked', 28),
(309, 16, 'M2-EQ-048', 'equation', 'M2.48', 'Vektorraum über einem Körper', 'Vektorraum über einem Körper.', 'V\\ \\mathrm{ist\\ ein\\ Vektorraum\\ über}\\ K', 'V\\ \\mathrm{ist\\ ein\\ Vektorraum\\ über}\\ K', 'core', 'canonical', 'literature', 50, 'K Körper; V mit Vektorraumoperationen', 'checked', 28),
(310, 16, 'M2-EQ-049', 'equation', 'M2.49', 'Reeller Vektorraum', 'Reeller Vektorraum.', 'K=\\mathbb{R}\\Longrightarrow V\\ \\mathrm{reeller\\ Vektorraum}', 'K=\\mathbb{R}\\Longrightarrow V\\ \\mathrm{reeller\\ Vektorraum}', 'example', 'example', 'literature', 51, 'K=\\mathbb{R}', 'checked', 28),
(311, 16, 'M2-EQ-050', 'equation', 'M2.50', 'Komplexer Vektorraum', 'Komplexer Vektorraum.', 'K=\\mathbb{C}\\Longrightarrow V\\ \\mathrm{komplexer\\ Vektorraum}', 'K=\\mathbb{C}\\Longrightarrow V\\ \\mathrm{komplexer\\ Vektorraum}', 'example', 'example', 'literature', 51, 'K=\\mathbb{C}', 'checked', 28),
(312, 16, 'M2-EQ-051', 'equation', 'M2.51', 'Zulässige Vektoraddition', 'Zulässige Vektoraddition.', '+:V\\times V\\rightarrow V', '+:V\\times V\\rightarrow V', 'core', 'canonical', 'literature', 50, 'Vektorraum', 'checked', 28),
(313, 16, 'M2-EQ-052', 'equation', 'M2.52', 'Zulässige Skalarmultiplikation', 'Zulässige Skalarmultiplikation.', '\\cdot:K\\times V\\rightarrow V', '\\cdot:K\\times V\\rightarrow V', 'core', 'canonical', 'literature', 50, 'Vektorraum über K', 'checked', 28),
(314, 16, 'M2-EQ-053', 'equation', 'M2.53', 'Keine allgemeine Vektormultiplikation', 'Keine allgemeine Vektormultiplikation.', 'V\\times V\\rightarrow V', 'V\\times V\\rightarrow V', 'supporting', 'derived', 'original', NULL, 'Nicht Bestandteil der allgemeinen Vektorraumaxiome', 'checked', 28),
(315, 16, 'M2-EQ-054', 'equation', 'M2.54', 'Abgeleitete Nullbeziehung I', 'Abgeleitete Nullbeziehung I.', '0_Kv=0_V', '0_Kv=0_V', 'supporting', 'derived', 'literature', 50, 'Nicht als Axiom; Beweis in M2.3', 'checked', 28),
(316, 16, 'M2-EQ-055', 'equation', 'M2.55', 'Abgeleitete Nullbeziehung II', 'Abgeleitete Nullbeziehung II.', '\\lambda0_V=0_V', '\\lambda0_V=0_V', 'supporting', 'derived', 'literature', 50, 'Nicht als Axiom; Beweis in M2.3', 'checked', 28),
(317, 16, 'M2-EQ-056', 'equation', 'M2.56', 'Abgeleitete Vorzeichenbeziehung', 'Abgeleitete Vorzeichenbeziehung.', '(-1_K)v=-v', '(-1_K)v=-v', 'supporting', 'derived', 'literature', 50, 'Nicht als Axiom; Beweis in M2.3', 'checked', 28),
(318, 16, 'M2-HANDOFF-M2.3', 'statement', NULL, 'Weitergabestelle M2.2 → M2.3', 'Übergabe des vollständigen Vektorraumaxiombestands an M2.3 Nullvektor, additive Inverse und abgeleitete Nullbeziehungen.', NULL, NULL, 'core', NULL, 'original', NULL, NULL, 'checked', 28),
(319, 17, 'M2-EQ-057', 'equation', 'M2.57', 'Eindeutigkeit des Nullvektors', 'Eindeutigkeit des Nullvektors.', '0_V=0_V+0\'_V=0\'_V', '0_V=0_V+0\'_V=0\'_V', 'core', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(320, 17, 'M2-EQ-058', 'equation', 'M2.58', 'Voraussetzung additive Inverse', 'Voraussetzung additive Inverse.', 'v+u=0_V\\qquad\\mathrm{und}\\qquad v+w=0_V', 'v+u=0_V\\qquad\\mathrm{und}\\qquad v+w=0_V', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(321, 17, 'M2-EQ-059', 'equation', 'M2.59', 'Eindeutigkeit des additiven Inversen', 'Eindeutigkeit des additiven Inversen.', 'u=u+0_V=u+(v+w)=(u+v)+w=0_V+w=w', 'u=u+0_V=u+(v+w)=(u+v)+w=0_V+w=w', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(322, 17, 'M2-EQ-060', 'equation', 'M2.60', 'Inverses des Nullvektors', 'Inverses des Nullvektors.', '-0_V=0_V', '-0_V=0_V', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(323, 17, 'M2-EQ-061', 'equation', 'M2.61', 'Definition der Vektorsubtraktion', 'Definition der Vektorsubtraktion.', 'u-v=u+(-v)', 'u-v=u+(-v)', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(324, 17, 'M2-EQ-062', 'equation', 'M2.62', 'Selbstsubtraktion', 'Selbstsubtraktion.', 'v-v=0_V', 'v-v=0_V', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(325, 17, 'M2-EQ-063', 'equation', 'M2.63', 'Subtraktion des Nullvektors', 'Subtraktion des Nullvektors.', 'v-0_V=v', 'v-0_V=v', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(326, 17, 'M2-EQ-064', 'equation', 'M2.64', 'Ausgangsgleichung additives Kürzen', 'Ausgangsgleichung additives Kürzen.', 'u+w=v+w', 'u+w=v+w', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(327, 17, 'M2-EQ-065', 'equation', 'M2.65', 'Addition des inversen Summanden', 'Addition des inversen Summanden.', '(u+w)+(-w)=(v+w)+(-w)', '(u+w)+(-w)=(v+w)+(-w)', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(328, 17, 'M2-EQ-066', 'equation', 'M2.66', 'Additives Kürzungsergebnis', 'Additives Kürzungsergebnis.', 'u=v', 'u=v', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(329, 17, 'M2-EQ-067', 'equation', 'M2.67', 'Distributiver Nullschritt', 'Distributiver Nullschritt.', '(0_K+0_K)v=0_Kv+0_Kv', '(0_K+0_K)v=0_Kv+0_Kv', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(330, 17, 'M2-EQ-068', 'equation', 'M2.68', 'Skalare Nullgleichung', 'Skalare Nullgleichung.', '0_Kv=0_Kv+0_Kv', '0_Kv=0_Kv+0_Kv', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(331, 17, 'M2-EQ-069', 'equation', 'M2.69', 'Nullvektor aus skalarem Nullprodukt', 'Nullvektor aus skalarem Nullprodukt.', '0_V=0_Kv', '0_V=0_Kv', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(332, 17, 'M2-EQ-070', 'equation', 'M2.70', 'Wirkung der skalaren Null', 'Wirkung der skalaren Null.', '0_Kv=0_V\\qquad\\forall v\\in V', '0_Kv=0_V\\qquad\\forall v\\in V', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(333, 17, 'M2-EQ-071', 'equation', 'M2.71', 'Distributiver Nullvektorschritt', 'Distributiver Nullvektorschritt.', '\\lambda(0_V+0_V)=\\lambda0_V+\\lambda0_V', '\\lambda(0_V+0_V)=\\lambda0_V+\\lambda0_V', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(334, 17, 'M2-EQ-072', 'equation', 'M2.72', 'Nullvektorgleichung', 'Nullvektorgleichung.', '\\lambda0_V=\\lambda0_V+\\lambda0_V', '\\lambda0_V=\\lambda0_V+\\lambda0_V', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(335, 17, 'M2-EQ-073', 'equation', 'M2.73', 'Skalarmultiplikation des Nullvektors', 'Skalarmultiplikation des Nullvektors.', '\\lambda0_V=0_V\\qquad\\forall\\lambda\\in K', '\\lambda0_V=0_V\\qquad\\forall\\lambda\\in K', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(336, 17, 'M2-EQ-074', 'equation', 'M2.74', 'Additives Inverses der Eins', 'Additives Inverses der Eins.', '1_K+(-1_K)=0_K', '1_K+(-1_K)=0_K', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(337, 17, 'M2-EQ-075', 'equation', 'M2.75', 'Skalierung der Einssumme', 'Skalierung der Einssumme.', '(1_K+(-1_K))v=0_Kv', '(1_K+(-1_K))v=0_Kv', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(338, 17, 'M2-EQ-076', 'equation', 'M2.76', 'Additive Inversenbeziehung', 'Additive Inversenbeziehung.', 'v+(-1_K)v=0_V', 'v+(-1_K)v=0_V', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(339, 17, 'M2-EQ-077', 'equation', 'M2.77', 'Wirkung von minus eins', 'Wirkung von minus eins.', '(-1_K)v=-v', '(-1_K)v=-v', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(340, 17, 'M2-EQ-078', 'equation', 'M2.78', 'Negativer Skalar', 'Negativer Skalar.', '(-\\lambda)v=-(\\lambda v)', '(-\\lambda)v=-(\\lambda v)', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(341, 17, 'M2-EQ-079', 'equation', 'M2.79', 'Negativer Vektor', 'Negativer Vektor.', '\\lambda(-v)=-(\\lambda v)', '\\lambda(-v)=-(\\lambda v)', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(342, 17, 'M2-EQ-080', 'equation', 'M2.80', 'Äquivalenz negativer Faktoren', 'Äquivalenz negativer Faktoren.', '(-\\lambda)v=\\lambda(-v)', '(-\\lambda)v=\\lambda(-v)', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(343, 17, 'M2-EQ-081', 'equation', 'M2.81', 'Doppelte Negation', 'Doppelte Negation.', '(-\\lambda)(-v)=\\lambda v', '(-\\lambda)(-v)=\\lambda v', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(344, 17, 'M2-EQ-082', 'equation', 'M2.82', 'Ausgangsgleichung Nullprodukt', 'Ausgangsgleichung Nullprodukt.', '\\lambda v=0_V', '\\lambda v=0_V', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(345, 17, 'M2-EQ-083', 'equation', 'M2.83', 'Multiplikation mit Skalarinversen', 'Multiplikation mit Skalarinversen.', '\\lambda^{-1}(\\lambda v)=\\lambda^{-1}0_V', '\\lambda^{-1}(\\lambda v)=\\lambda^{-1}0_V', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(346, 17, 'M2-EQ-084', 'equation', 'M2.84', 'Reduktion des Skalarprodukts', 'Reduktion des Skalarprodukts.', '(\\lambda^{-1}\\lambda)v=0_V', '(\\lambda^{-1}\\lambda)v=0_V', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(347, 17, 'M2-EQ-085', 'equation', 'M2.85', 'Folgerung Nullvektor', 'Folgerung Nullvektor.', 'v=0_V', 'v=0_V', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(348, 17, 'M2-EQ-086', 'equation', 'M2.86', 'Nullproduktimplikation', 'Nullproduktimplikation.', '\\lambda v=0_V\\Longrightarrow\\lambda=0_K\\lor v=0_V', '\\lambda v=0_V\\Longrightarrow\\lambda=0_K\\lor v=0_V', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(349, 17, 'M2-EQ-087', 'equation', 'M2.87', 'Nullproduktäquivalenz', 'Nullproduktäquivalenz.', '\\lambda v=0_V\\iff\\lambda=0_K\\lor v=0_V', '\\lambda v=0_V\\iff\\lambda=0_K\\lor v=0_V', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(350, 17, 'M2-EQ-088', 'equation', 'M2.88', 'Ausgangsgleichung skalares Kürzen', 'Ausgangsgleichung skalares Kürzen.', '\\lambda u=\\lambda v', '\\lambda u=\\lambda v', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(351, 17, 'M2-EQ-089', 'equation', 'M2.89', 'Multiplikation mit Skalarinversen', 'Multiplikation mit Skalarinversen.', '\\lambda^{-1}(\\lambda u)=\\lambda^{-1}(\\lambda v)', '\\lambda^{-1}(\\lambda u)=\\lambda^{-1}(\\lambda v)', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(352, 17, 'M2-EQ-090', 'equation', 'M2.90', 'Kürzungsergebnis', 'Kürzungsergebnis.', 'u=v', 'u=v', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(353, 17, 'M2-EQ-091', 'equation', 'M2.91', 'Skalares Kürzungsgesetz', 'Skalares Kürzungsgesetz.', '\\lambda\\neq0_K\\land\\lambda u=\\lambda v\\Longrightarrow u=v', '\\lambda\\neq0_K\\land\\lambda u=\\lambda v\\Longrightarrow u=v', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(354, 17, 'M2-EQ-092', 'equation', 'M2.92', 'Ausgangsgleichung Vektorkürzung', 'Ausgangsgleichung Vektorkürzung.', '\\lambda v=\\mu v', '\\lambda v=\\mu v', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(355, 17, 'M2-EQ-093', 'equation', 'M2.93', 'Differenzform', 'Differenzform.', '(\\lambda-\\mu)v=0_V', '(\\lambda-\\mu)v=0_V', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(356, 17, 'M2-EQ-094', 'equation', 'M2.94', 'Skalardifferenz ist Null', 'Skalardifferenz ist Null.', '\\lambda-\\mu=0_K', '\\lambda-\\mu=0_K', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(357, 17, 'M2-EQ-095', 'equation', 'M2.95', 'Skalargleichheit', 'Skalargleichheit.', '\\lambda=\\mu', '\\lambda=\\mu', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(358, 17, 'M2-EQ-096', 'equation', 'M2.96', 'Kürzung an Nichtnullvektor', 'Kürzung an Nichtnullvektor.', 'v\\neq0_V\\land\\lambda v=\\mu v\\Longrightarrow\\lambda=\\mu', 'v\\neq0_V\\land\\lambda v=\\mu v\\Longrightarrow\\lambda=\\mu', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(359, 17, 'M2-EQ-097', 'equation', 'M2.97', 'Skalarmultiplikationsabbildung', 'Skalarmultiplikationsabbildung.', '\\varphi_v:K\\rightarrow V,\\qquad\\varphi_v(\\lambda)=\\lambda v', '\\varphi_v:K\\rightarrow V,\\qquad\\varphi_v(\\lambda)=\\lambda v', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(360, 17, 'M2-EQ-098', 'equation', 'M2.98', 'Injektivität der Skalarmultiplikationsabbildung', 'Injektivität der Skalarmultiplikationsabbildung.', 'v\\neq0_V\\Longrightarrow\\varphi_v\\ \\mathrm{injektiv}', 'v\\neq0_V\\Longrightarrow\\varphi_v\\ \\mathrm{injektiv}', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß jeweiligem Herleitungsschritt.', 'checked', 29),
(403, 17, 'M2-HANDOFF-M2.4', 'statement', NULL, 'Weitergabestelle M2.3 → M2.4', 'M2.3 übergibt den vollständigen Axiomen-Folgebestand an M2.4 Untervektorräume und Unterraumkriterium.', NULL, NULL, 'core', NULL, 'original', NULL, 'M2.3 vollständig validiert', 'checked', 29);
INSERT INTO `appendix_objects` (`appendix_object_id`, `appendix_section_id`, `object_anchor`, `object_type`, `display_number`, `title`, `content_text`, `formal_latex`, `word_latex`, `importance_level`, `equation_role`, `provenance`, `source_id`, `assumptions`, `validation_status`, `created_revision_id`) VALUES
(404, 19, 'M2-EQ-099', 'equation', 'M2.99', 'Untervektorraumrelation', 'Untervektorraumrelation.', 'U\\leq V', 'U\\leq V', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(405, 19, 'M2-EQ-100', 'equation', 'M2.100', 'Additionsabschluss auf U', 'Additionsabschluss auf U.', '+:U\\times U\\rightarrow U', '+:U\\times U\\rightarrow U', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(406, 19, 'M2-EQ-101', 'equation', 'M2.101', 'Skalarmultiplikationsabschluss auf U', 'Skalarmultiplikationsabschluss auf U.', '\\cdot:K\\times U\\rightarrow U', '\\cdot:K\\times U\\rightarrow U', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(407, 19, 'M2-EQ-102', 'equation', 'M2.102', 'Nullvektor im Unterraum', 'Nullvektor im Unterraum.', 'U\\leq V\\Longrightarrow 0_V\\in U', 'U\\leq V\\Longrightarrow 0_V\\in U', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(408, 19, 'M2-EQ-103', 'equation', 'M2.103', 'Nichtleere des Unterraums', 'Nichtleere des Unterraums.', 'U\\leq V\\Longrightarrow U\\neq\\varnothing', 'U\\leq V\\Longrightarrow U\\neq\\varnothing', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(409, 19, 'M2-EQ-104', 'equation', 'M2.104', 'Abgeschlossenheit der Addition', 'Abgeschlossenheit der Addition.', 'u,v\\in U\\Longrightarrow u+v\\in U', 'u,v\\in U\\Longrightarrow u+v\\in U', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(410, 19, 'M2-EQ-105', 'equation', 'M2.105', 'Abgeschlossenheit der Skalarmultiplikation', 'Abgeschlossenheit der Skalarmultiplikation.', '\\lambda u\\in U', '\\lambda u\\in U', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(411, 19, 'M2-EQ-106', 'equation', 'M2.106', 'Skalierung mit minus eins', 'Skalierung mit minus eins.', 'u\\in U\\Longrightarrow(-1_K)u\\in U', 'u\\in U\\Longrightarrow(-1_K)u\\in U', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(412, 19, 'M2-EQ-107', 'equation', 'M2.107', 'Additives Inverses im Unterraum', 'Additives Inverses im Unterraum.', 'u\\in U\\Longrightarrow -u\\in U', 'u\\in U\\Longrightarrow -u\\in U', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(413, 19, 'M2-EQ-108', 'equation', 'M2.108', 'Unterraumkriterium mit drei Bedingungen', 'Unterraumkriterium mit drei Bedingungen.', 'U\\leq V\\iff\\left(0_V\\in U\\land\\forall u,v\\in U:u+v\\in U\\land\\forall\\lambda\\in K\\ \\forall u\\in U:\\lambda u\\in U\\right)', 'U\\leq V\\iff\\left(0_V\\in U\\land\\forall u,v\\in U:u+v\\in U\\land\\forall\\lambda\\in K\\ \\forall u\\in U:\\lambda u\\in U\\right)', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(414, 19, 'M2-EQ-109', 'equation', 'M2.109', 'Abschluss unter Linearkombination zweier Vektoren', 'Abschluss unter Linearkombination zweier Vektoren.', '\\lambda u+\\mu v\\in U', '\\lambda u+\\mu v\\in U', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(415, 19, 'M2-EQ-110', 'equation', 'M2.110', 'Verkürztes Unterraumkriterium', 'Verkürztes Unterraumkriterium.', 'U\\leq V\\iff\\left(U\\neq\\varnothing\\land\\forall u,v\\in U\\ \\forall\\lambda,\\mu\\in K:\\lambda u+\\mu v\\in U\\right)', 'U\\leq V\\iff\\left(U\\neq\\varnothing\\land\\forall u,v\\in U\\ \\forall\\lambda,\\mu\\in K:\\lambda u+\\mu v\\in U\\right)', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(416, 19, 'M2-EQ-111', 'equation', 'M2.111', 'Nullvektor aus verkürztem Kriterium', 'Nullvektor aus verkürztem Kriterium.', '0_Ku+0_Ku=0_V\\in U', '0_Ku+0_Ku=0_V\\in U', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(417, 19, 'M2-EQ-112', 'equation', 'M2.112', 'Additionsabschluss aus verkürztem Kriterium', 'Additionsabschluss aus verkürztem Kriterium.', 'u+v\\in U', 'u+v\\in U', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(418, 19, 'M2-EQ-113', 'equation', 'M2.113', 'Skalarabschluss aus verkürztem Kriterium', 'Skalarabschluss aus verkürztem Kriterium.', '\\lambda u+0_Kv=\\lambda u\\in U', '\\lambda u+0_Kv=\\lambda u\\in U', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(419, 19, 'M2-EQ-114', 'equation', 'M2.114', 'Differenzabschluss', 'Differenzabschluss.', 'u-v\\in U', 'u-v\\in U', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(420, 19, 'M2-EQ-115', 'equation', 'M2.115', 'Skalarabschluss im Differenzkriterium', 'Skalarabschluss im Differenzkriterium.', '\\forall\\lambda\\in K\\ \\forall u\\in U:\\lambda u\\in U', '\\forall\\lambda\\in K\\ \\forall u\\in U:\\lambda u\\in U', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(421, 19, 'M2-EQ-116', 'equation', 'M2.116', 'Nullvektor aus Differenzabschluss', 'Nullvektor aus Differenzabschluss.', '0_V\\in U', '0_V\\in U', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(422, 19, 'M2-EQ-117', 'equation', 'M2.117', 'Addition aus Differenzabschluss', 'Addition aus Differenzabschluss.', 'u-(-v)=u+v\\in U', 'u-(-v)=u+v\\in U', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(423, 19, 'M2-EQ-118', 'equation', 'M2.118', 'Nullraum als trivialer Unterraum', 'Nullraum als trivialer Unterraum.', '\\left\\{0_V\\right\\}\\leq V', '\\left\\{0_V\\right\\}\\leq V', 'example', 'example', 'original', NULL, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(424, 19, 'M2-EQ-119', 'equation', 'M2.119', 'V als trivialer Unterraum', 'V als trivialer Unterraum.', 'V\\leq V', 'V\\leq V', 'example', 'example', 'original', NULL, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(425, 19, 'M2-EQ-120', 'equation', 'M2.120', 'Nichttrivialer Unterraum', 'Nichttrivialer Unterraum.', '\\left\\{0_V\\right\\}\\subsetneq U\\subsetneq V', '\\left\\{0_V\\right\\}\\subsetneq U\\subsetneq V', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(426, 19, 'M2-EQ-121', 'equation', 'M2.121', 'Schnitt zweier Unterräume', 'Schnitt zweier Unterräume.', 'U_1\\leq V\\land U_2\\leq V\\Longrightarrow U_1\\cap U_2\\leq V', 'U_1\\leq V\\land U_2\\leq V\\Longrightarrow U_1\\cap U_2\\leq V', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(427, 19, 'M2-EQ-122', 'equation', 'M2.122', 'Nullvektor im Schnitt', 'Nullvektor im Schnitt.', '0_V\\in U_1\\cap U_2', '0_V\\in U_1\\cap U_2', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(428, 19, 'M2-EQ-123', 'equation', 'M2.123', 'Additionsabschluss im Schnitt', 'Additionsabschluss im Schnitt.', 'u+v\\in U_1\\cap U_2', 'u+v\\in U_1\\cap U_2', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(429, 19, 'M2-EQ-124', 'equation', 'M2.124', 'Skalarabschluss im Schnitt', 'Skalarabschluss im Schnitt.', '\\lambda u\\in U_1\\cap U_2', '\\lambda u\\in U_1\\cap U_2', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(430, 19, 'M2-EQ-125', 'equation', 'M2.125', 'Beliebiger Schnitt von Unterräumen', 'Beliebiger Schnitt von Unterräumen.', '\\bigcap_{i\\in I}U_i\\leq V', '\\bigcap_{i\\in I}U_i\\leq V', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(431, 19, 'M2-EQ-126', 'equation', 'M2.126', 'Vereinigung im Allgemeinen nicht abgeschlossen', 'Vereinigung im Allgemeinen nicht abgeschlossen.', 'u+v\\notin U_1\\cup U_2', 'u+v\\notin U_1\\cup U_2', 'example', 'example', 'original', NULL, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(432, 19, 'M2-EQ-127', 'equation', 'M2.127', 'Charakterisierung der Unterraumvereinigung', 'Charakterisierung der Unterraumvereinigung.', 'U_1\\cup U_2\\leq V\\iff U_1\\subseteq U_2\\lor U_2\\subseteq U_1', 'U_1\\cup U_2\\leq V\\iff U_1\\subseteq U_2\\lor U_2\\subseteq U_1', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(433, 19, 'M2-EQ-128', 'equation', 'M2.128', 'Skalarmultiplikation auf dem Unterraum', 'Skalarmultiplikation auf dem Unterraum.', '\\cdot:K\\times U\\rightarrow U', '\\cdot:K\\times U\\rightarrow U', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(434, 19, 'M2-EQ-129', 'equation', 'M2.129', 'Ausgangsmenge von Erzeugern', 'Ausgangsmenge von Erzeugern.', '\\left\\{v_1,\\ldots,v_n\\right\\}', '\\left\\{v_1,\\ldots,v_n\\right\\}', 'example', 'example', 'original', NULL, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.3 und jeweils im Text genannte Teilmengen-/Unterraumannahmen.', 'checked', 31),
(435, 19, 'M2-HANDOFF-M2.5', 'statement', NULL, 'Weitergabestelle M2.4 → M2.5', 'M2.4 übergibt Untervektorraumbegriff, Unterraumkriterien und Schnittstabilität an M2.5 Linearkombinationen und Spannraum.', NULL, NULL, 'core', NULL, 'original', NULL, 'M2.4 vollständig validiert', 'checked', 31),
(436, 20, 'M2-EQ-130', 'equation', 'M2.130', 'Linearkombination endlich vieler Vektoren', 'Linearkombination endlich vieler Vektoren.', '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n', '\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(437, 20, 'M2-EQ-131', 'equation', 'M2.131', 'Summenschreibweise der Linearkombination', 'Summenschreibweise der Linearkombination.', '\\sum_{i=1}^{n}\\lambda_iv_i', '\\sum_{i=1}^{n}\\lambda_iv_i', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(438, 20, 'M2-EQ-132', 'equation', 'M2.132', 'Abgeschlossenheit der Linearkombination', 'Abgeschlossenheit der Linearkombination.', '\\sum_{i=1}^{n}\\lambda_iv_i\\in V', '\\sum_{i=1}^{n}\\lambda_iv_i\\in V', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(439, 20, 'M2-EQ-133', 'equation', 'M2.133', 'Einzelner skalierter Summand', 'Einzelner skalierter Summand.', '\\lambda_iv_i\\in V', '\\lambda_iv_i\\in V', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(440, 20, 'M2-EQ-134', 'equation', 'M2.134', 'Nullkoeffizient', 'Nullkoeffizient.', '0_Kv_i=0_V', '0_Kv_i=0_V', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(441, 20, 'M2-EQ-135', 'equation', 'M2.135', 'Triviale Linearkombination', 'Triviale Linearkombination.', '0_Kv_1+\\cdots+0_Kv_n=0_V', '0_Kv_1+\\cdots+0_Kv_n=0_V', 'example', 'example', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(442, 20, 'M2-EQ-136', 'equation', 'M2.136', 'Spannraum einer endlichen Vektormenge', 'Spannraum einer endlichen Vektormenge.', '\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}=\\left\\{\\sum_{i=1}^{n}\\lambda_iv_i\\mid\\lambda_1,\\ldots,\\lambda_n\\in K\\right\\}', '\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}=\\left\\{\\sum_{i=1}^{n}\\lambda_iv_i\\mid\\lambda_1,\\ldots,\\lambda_n\\in K\\right\\}', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(443, 20, 'M2-EQ-137', 'equation', 'M2.137', 'Äquivalente Spannraumschreibweise', 'Äquivalente Spannraumschreibweise.', '\\operatorname{span}(v_1,\\ldots,v_n)=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', '\\operatorname{span}(v_1,\\ldots,v_n)=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(444, 20, 'M2-EQ-138', 'equation', 'M2.138', 'Darstellung eines Erzeugers', 'Darstellung eines Erzeugers.', 'v_j=0_Kv_1+\\cdots+1_Kv_j+\\cdots+0_Kv_n', 'v_j=0_Kv_1+\\cdots+1_Kv_j+\\cdots+0_Kv_n', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(445, 20, 'M2-EQ-139', 'equation', 'M2.139', 'Erzeuger im Spannraum', 'Erzeuger im Spannraum.', 'v_j\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'v_j\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(446, 20, 'M2-EQ-140', 'equation', 'M2.140', 'Erzeugermenge im Spannraum', 'Erzeugermenge im Spannraum.', '\\left\\{v_1,\\ldots,v_n\\right\\}\\subseteq\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', '\\left\\{v_1,\\ldots,v_n\\right\\}\\subseteq\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(447, 20, 'M2-EQ-141', 'equation', 'M2.141', 'Nullvektor im Spannraum', 'Nullvektor im Spannraum.', '0_V\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', '0_V\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(448, 20, 'M2-EQ-142', 'equation', 'M2.142', 'Zwei Vektoren im Spannraum', 'Zwei Vektoren im Spannraum.', 'x=\\sum_{i=1}^{n}\\lambda_iv_i,\\qquad y=\\sum_{i=1}^{n}\\mu_iv_i', 'x=\\sum_{i=1}^{n}\\lambda_iv_i,\\qquad y=\\sum_{i=1}^{n}\\mu_iv_i', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(449, 20, 'M2-EQ-143', 'equation', 'M2.143', 'Additionsabschluss des Spannraums', 'Additionsabschluss des Spannraums.', 'x+y=\\sum_{i=1}^{n}(\\lambda_i+\\mu_i)v_i', 'x+y=\\sum_{i=1}^{n}(\\lambda_i+\\mu_i)v_i', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(450, 20, 'M2-EQ-144', 'equation', 'M2.144', 'Summe im Spannraum', 'Summe im Spannraum.', 'x+y\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'x+y\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(451, 20, 'M2-EQ-145', 'equation', 'M2.145', 'Skalarabschluss des Spannraums', 'Skalarabschluss des Spannraums.', '\\alpha x=\\alpha\\sum_{i=1}^{n}\\lambda_iv_i=\\sum_{i=1}^{n}(\\alpha\\lambda_i)v_i', '\\alpha x=\\alpha\\sum_{i=1}^{n}\\lambda_iv_i=\\sum_{i=1}^{n}(\\alpha\\lambda_i)v_i', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(452, 20, 'M2-EQ-146', 'equation', 'M2.146', 'Skalares Vielfaches im Spannraum', 'Skalares Vielfaches im Spannraum.', '\\alpha x\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', '\\alpha x\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(453, 20, 'M2-EQ-147', 'equation', 'M2.147', 'Spannraum ist Untervektorraum', 'Spannraum ist Untervektorraum.', '\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\leq V', '\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\leq V', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(454, 20, 'M2-EQ-148', 'equation', 'M2.148', 'Allgemeiner Spannraum', 'Allgemeiner Spannraum.', '\\operatorname{span}(S)=\\left\\{\\sum_{i=1}^{n}\\lambda_is_i\\mid n\\in\\mathbb{N},\\ s_i\\in S,\\ \\lambda_i\\in K\\right\\}', '\\operatorname{span}(S)=\\left\\{\\sum_{i=1}^{n}\\lambda_is_i\\mid n\\in\\mathbb{N},\\ s_i\\in S,\\ \\lambda_i\\in K\\right\\}', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(455, 20, 'M2-EQ-149', 'equation', 'M2.149', 'Spannraum der leeren Menge', 'Spannraum der leeren Menge.', '\\operatorname{span}(\\varnothing)=\\left\\{0_V\\right\\}', '\\operatorname{span}(\\varnothing)=\\left\\{0_V\\right\\}', 'supporting', 'canonical', 'literature', 51, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(456, 20, 'M2-EQ-150', 'equation', 'M2.150', 'Erzeugermenge im allgemeinen Spannraum', 'Erzeugermenge im allgemeinen Spannraum.', 'S\\subseteq\\operatorname{span}(S)', 'S\\subseteq\\operatorname{span}(S)', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(457, 20, 'M2-EQ-151', 'equation', 'M2.151', 'Unterraum enthält Erzeugermenge', 'Unterraum enthält Erzeugermenge.', 'S\\subseteq U', 'S\\subseteq U', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(458, 20, 'M2-EQ-152', 'equation', 'M2.152', 'Minimalität des Spannraums', 'Minimalität des Spannraums.', '\\operatorname{span}(S)\\subseteq U', '\\operatorname{span}(S)\\subseteq U', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(459, 20, 'M2-EQ-153', 'equation', 'M2.153', 'Spannraum als Schnitt aller enthaltenden Unterräume', 'Spannraum als Schnitt aller enthaltenden Unterräume.', '\\operatorname{span}(S)=\\bigcap_{\\substack{U\\leq V\\\\S\\subseteq U}}U', '\\operatorname{span}(S)=\\bigcap_{\\substack{U\\leq V\\\\S\\subseteq U}}U', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(460, 20, 'M2-EQ-154', 'equation', 'M2.154', 'Voraussetzung der Monotonie', 'Voraussetzung der Monotonie.', 'S\\subseteq T', 'S\\subseteq T', 'derivation', 'proof_step', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(461, 20, 'M2-EQ-155', 'equation', 'M2.155', 'Monotonie des Spannraums', 'Monotonie des Spannraums.', '\\operatorname{span}(S)\\subseteq\\operatorname{span}(T)', '\\operatorname{span}(S)\\subseteq\\operatorname{span}(T)', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(462, 20, 'M2-EQ-156', 'equation', 'M2.156', 'Hinzufügen eines redundanten Erzeugers', 'Hinzufügen eines redundanten Erzeugers.', '\\operatorname{span}(S\\cup\\left\\{v\\right\\})=\\operatorname{span}(S)', '\\operatorname{span}(S\\cup\\left\\{v\\right\\})=\\operatorname{span}(S)', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(463, 20, 'M2-EQ-157', 'equation', 'M2.157', 'Idempotenz des Spannraums', 'Idempotenz des Spannraums.', '\\operatorname{span}(\\operatorname{span}(S))=\\operatorname{span}(S)', '\\operatorname{span}(\\operatorname{span}(S))=\\operatorname{span}(S)', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(464, 20, 'M2-EQ-158', 'equation', 'M2.158', 'Spannraum einer Vereinigung', 'Spannraum einer Vereinigung.', '\\operatorname{span}(S\\cup T)=\\operatorname{span}\\left(\\operatorname{span}(S)\\cup\\operatorname{span}(T)\\right)', '\\operatorname{span}(S\\cup T)=\\operatorname{span}\\left(\\operatorname{span}(S)\\cup\\operatorname{span}(T)\\right)', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(465, 20, 'M2-EQ-159', 'equation', 'M2.159', 'Summe zweier Unterräume', 'Summe zweier Unterräume.', 'U+W=\\left\\{u+w\\mid u\\in U,\\ w\\in W\\right\\}', 'U+W=\\left\\{u+w\\mid u\\in U,\\ w\\in W\\right\\}', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(466, 20, 'M2-EQ-160', 'equation', 'M2.160', 'Unterraumsumme als Spannraum', 'Unterraumsumme als Spannraum.', 'U+W=\\operatorname{span}(U\\cup W)', 'U+W=\\operatorname{span}(U\\cup W)', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(467, 20, 'M2-EQ-161', 'equation', 'M2.161', 'Erzeugendensystem', 'Erzeugendensystem.', '\\operatorname{span}(S)=V', '\\operatorname{span}(S)=V', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(468, 20, 'M2-EQ-162', 'equation', 'M2.162', 'Endliches Erzeugendensystem', 'Endliches Erzeugendensystem.', 'V=\\left\\{\\sum_{i=1}^{n}\\lambda_iv_i\\mid\\lambda_1,\\ldots,\\lambda_n\\in K\\right\\}', 'V=\\left\\{\\sum_{i=1}^{n}\\lambda_iv_i\\mid\\lambda_1,\\ldots,\\lambda_n\\in K\\right\\}', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(469, 20, 'M2-EQ-163', 'equation', 'M2.163', 'Endlich erzeugter Vektorraum', 'Endlich erzeugter Vektorraum.', 'V=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'V=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(470, 20, 'M2-EQ-164', 'equation', 'M2.164', 'Redundanzbedingung', 'Redundanzbedingung.', 'v_j\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_{j-1},v_{j+1},\\ldots,v_n\\right\\}', 'v_j\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_{j-1},v_{j+1},\\ldots,v_n\\right\\}', 'core', 'canonical', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(471, 20, 'M2-EQ-165', 'equation', 'M2.165', 'Entfernung eines redundanten Erzeugers', 'Entfernung eines redundanten Erzeugers.', '\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}=\\operatorname{span}\\left\\{v_1,\\ldots,v_{j-1},v_{j+1},\\ldots,v_n\\right\\}', '\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}=\\operatorname{span}\\left\\{v_1,\\ldots,v_{j-1},v_{j+1},\\ldots,v_n\\right\\}', 'core', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(472, 20, 'M2-EQ-166', 'equation', 'M2.166', 'Erzeugung des gesamten Vektorraums', 'Erzeugung des gesamten Vektorraums.', 'V=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'V=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(473, 20, 'M2-EQ-167', 'equation', 'M2.167', 'Darstellung durch ein Erzeugendensystem', 'Darstellung durch ein Erzeugendensystem.', 'v=\\sum_{i=1}^{n}\\lambda_iv_i', 'v=\\sum_{i=1}^{n}\\lambda_iv_i', 'supporting', 'derived', 'literature', 50, 'Vektorraum V über Körper K; Voraussetzungen gemäß M2.1–M2.4 und jeweils im Text genannte Mengen-/Unterraumannahmen.', 'checked', 32),
(474, 20, 'M2-HANDOFF-M2.6', 'statement', NULL, 'Weitergabestelle M2.5 → M2.6', 'M2.5 übergibt Linearkombinationen, Spannraum, Erzeugendensystem und Redundanzkriterium an M2.6 Lineare Abhängigkeit und lineare Unabhängigkeit.', NULL, NULL, 'core', NULL, 'original', NULL, 'M2.5 vollständig validiert', 'checked', 32);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `appendix_sections`
--

CREATE TABLE `appendix_sections` (
  `appendix_section_id` bigint(20) UNSIGNED NOT NULL,
  `appendix_module_id` bigint(20) UNSIGNED NOT NULL,
  `parent_appendix_section_id` bigint(20) UNSIGNED DEFAULT NULL,
  `section_code` varchar(50) NOT NULL,
  `title` varchar(500) NOT NULL,
  `sort_order` decimal(12,4) NOT NULL,
  `status` enum('planned','draft','review','final') NOT NULL DEFAULT 'planned',
  `notes` longtext DEFAULT NULL,
  `created_revision_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `appendix_sections`
--

INSERT INTO `appendix_sections` (`appendix_section_id`, `appendix_module_id`, `parent_appendix_section_id`, `section_code`, `title`, `sort_order`, `status`, `notes`, `created_revision_id`) VALUES
(1, 1, NULL, 'M1.0', 'Gegenstand, methodischer Ausgangspunkt und Aufbau', 1.0000, 'review', 'Erster inhaltlicher Abschnitt des mathematischen Anlagenaufbaus. Die Anlage wird vor dem späteren Haupttext erarbeitet; ihre Ergebnisse werden erst nach Abschluss in den Haupttext übernommen.', 13),
(2, 1, 1, 'M1.1', 'Mengen, Elemente und Mengengleichheit', 2.0000, 'review', 'Erster mathematischer Einzelabschnitt des Reset-Neuaufbaus von M1. Aufbau ausschließlich aus etablierter Mengenlehre; Weitergabe an M1.2.', 14),
(3, 1, 1, 'M1.2', 'Teilmengen, echte Teilmengen und Potenzmengen', 3.0000, 'review', 'Reset-Abschnitt von M1. Aufbau ausschließlich auf M1.1 und etablierter Mengenlehre; Weitergabe an M1.3 Mengenoperationen.', 15),
(4, 1, 1, 'M1.3', 'Mengenoperationen', 4.0000, 'review', 'Reset-Abschnitt von M1. Aufbau auf M1.2; Vereinigung, Durchschnitt, Mengendifferenz, Komplement, De-Morgan-Beziehungen und Distributivität; Weitergabe an M1.4.', 16),
(5, 1, 1, 'M1.4', 'Geordnete Paare, Tupel und kartesische Produkte', 5.0000, 'review', 'Reset-Abschnitt von M1. Aufbau auf M1.3; geordnete Paare, kartesische Produkte, Tupel und Projektionen; Weitergabe an M1.5.', 17),
(6, 1, 1, 'M1.5', 'Relationen und ihre grundlegenden Eigenschaften', 6.0000, 'review', 'Reset-Abschnitt von M1. Aufbau auf M1.4; Relationseigenschaften, Äquivalenz- und Ordnungsrelationen, Umkehrung und Komposition; Weitergabe an M1.6.', 18),
(7, 1, 1, 'M1.6', 'Funktionen als eindeutig bestimmte Relationen', 7.0000, 'review', 'Reset-Abschnitt von M1. Aufbau auf M1.5; Existenz und Eindeutigkeit, Funktionsgraph, Definitions-, Ziel- und Bildbereich, Einschränkung, Identität und Funktionsmengen; Weitergabe an M1.7.', 19),
(8, 1, 1, 'M1.7', 'Injektivität, Surjektivität und Bijektivität', 8.0000, 'review', 'Reset-Abschnitt von M1. Aufbau auf M1.6; Injektivität, Surjektivität, Bijektivität, Umkehrfunktion und Komposition von Bijektionen; Weitergabe an M1.8.', 20),
(9, 1, 1, 'M1.8', 'Bilder und Urbilder von Mengen', 9.0000, 'review', 'Reset-Abschnitt von M1. Aufbau auf M1.7; Bild- und Urbildbildung auf Teilmengen sowie deren Verträglichkeit mit Mengenoperationen; Weitergabe an M1.9.', 21),
(10, 1, 1, 'M1.9', 'Identität, Komposition und inverse Verkettung von Funktionen', 10.0000, 'review', 'Reset-Abschnitt von M1. Aufbau auf M1.8; Funktionskomposition, Identität, Assoziativität, Eigenschaftserhaltung und inverse Verkettung; Weitergabe an M1.10.', 22),
(11, 1, 1, 'M1.10', 'Mehrstellige, parametrisierte und partielle Funktionen', 11.0000, 'review', 'Reset-Abschnitt von M1. Aufbau auf M1.9; mehrstellige Funktionen, Argumentfixierung, parametrisierte Funktionsfamilien und partielle Funktionen; Weitergabe an M1.11.', 23),
(12, 1, 1, 'M1.11', 'Ergebnisbestand und Übergabe von M1', 12.0000, 'review', 'Abschlussabschnitt von M1; bündelt Ergebnisbestand, Voraussetzungen, Aussagegrenzen sowie die Übergaben M1 → M2 und M1 → späterer Haupttext.', 24),
(13, 2, NULL, 'M2.0', 'Gegenstand, Eingangsstelle und algebraische Erweiterung', 1.0000, 'draft', 'Erster Abschnitt von M2. Eingang ausschließlich aus dem geprüften M1-Ergebnisbestand; keine Haupttextquelle. Bereitet Körper, Vektorraumaxiome, Unterräume, Linearkombinationen, Unabhängigkeit, Basis, Dimension und Koordinaten vor.', 25),
(14, 2, 13, 'M2.1', 'Körper und Skalare', 2.0000, 'draft', 'Reset-Abschnitt von M2. Aufbau auf M2.0; Skalarkörper, Körperaxiome, abgeleitete Rechenregeln und Weitergabe an M2.2 Vektorraum und Vektorraumaxiome.', 26),
(16, 2, 14, 'M2.2', 'Vektorraum und Vektorraumaxiome', 3.0000, 'draft', 'Reset-Abschnitt M2.2; Definition der Vektorraumoperationen und -axiome sowie Übergabe an M2.3.', 28),
(17, 2, 16, 'M2.3', 'Nullvektor, additive Inverse und abgeleitete Nullbeziehungen', 4.0000, 'draft', 'Reset-Abschnitt M2.3; vollständige Herleitung der elementaren algebraischen Folgerungen und Übergabe an M2.4.', 29),
(19, 2, 17, 'M2.4', 'Untervektorräume und Unterraumkriterium', 5.0000, 'draft', 'Reset-Abschnitt M2.4; Unterraumstruktur, Kriterien, Schnitt, Vereinigung und Übergabe an M2.5.', 31),
(20, 2, 19, 'M2.5', 'Linearkombinationen und Spannraum', 6.0000, 'draft', 'Reset-Abschnitt M2.5; Linearkombinationen, Spannraum, Erzeugung, Minimalität und Redundanz; Übergabe an M2.6.', 32);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `appendix_section_versions`
--

CREATE TABLE `appendix_section_versions` (
  `appendix_section_version_id` bigint(20) UNSIGNED NOT NULL,
  `appendix_section_id` bigint(20) UNSIGNED NOT NULL,
  `revision_id` bigint(20) UNSIGNED NOT NULL,
  `version_kind` enum('draft','review','final','superseded') NOT NULL DEFAULT 'draft',
  `body_markdown` longtext NOT NULL,
  `checksum_sha256` char(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `notes` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `appendix_section_versions`
--

INSERT INTO `appendix_section_versions` (`appendix_section_version_id`, `appendix_section_id`, `revision_id`, `version_kind`, `body_markdown`, `checksum_sha256`, `notes`) VALUES
(1, 1, 13, 'draft', '# Anlage M1 – Mengentheoretische und funktionale Grundlagen\n\n## M1.0 Gegenstand, methodischer Ausgangspunkt und Aufbau\n\nMit M1 beginne ich die mathematische Grundlegung auf der elementarsten Strukturebene, die ich für den weiteren Aufbau benötige. Ich setze dabei bewusst noch keinen Vektorraum, keine geometrische Struktur und keine physikalische Interpretation voraus. Mein Ausgangspunkt ist wesentlich zurückhaltender: Ich muss zunächst mathematisch unterscheiden können, welche Objekte zu einem betrachteten Bereich gehören, wie Beziehungen zwischen solchen Objekten formuliert werden können und unter welcher zusätzlichen Bedingung aus einer allgemeinen Beziehung eine eindeutige Zuordnung entsteht.\n\nDiese Reihenfolge ist für mich nicht nur eine Frage der Darstellung. Sie bestimmt, welche Voraussetzungen in einer mathematischen Aussage tatsächlich enthalten sind. Wenn ich beispielsweise lediglich eine Menge `(A)` voraussetze, kann ich entscheiden, ob ein Objekt `(x)` zu dieser Menge gehört, also ob `(x\\in A)` gilt. Daraus folgt aber noch keine Beziehung zwischen zwei verschiedenen Elementen. Erst mit einer Relation kann ich ausgewählte geordnete Paare miteinander in Beziehung setzen. Und auch eine Relation legt noch nicht notwendig fest, dass einem Ausgangselement genau ein Zielelement zugeordnet wird. Erst diese zusätzliche Eindeutigkeitsforderung führt zum Funktionsbegriff.\n\nFür die elementare mengentheoretische Grundlage orientiere ich mich an Halmos, dessen Darstellung Mengen, Teilmengen, geordnete Paare, Relationen und Funktionen als aufeinander aufbauende Strukturen behandelt. `{[[Halmos, Paul R. (1974): Naive Set Theory. New York: Springer-Verlag, insbesondere S. 1–12.]]}[[6]]` Für mich ist daran besonders hilfreich, dass die verwendeten mathematischen Objekte nicht über eine anschauliche Bedeutung eingeführt werden müssen. Entscheidend ist zunächst ausschließlich ihre formale Struktur.\n\nDiese Zurückhaltung möchte ich durch die gesamte Anlage beibehalten. Eine Menge ist für mich an dieser Stelle noch kein physikalischer Zustandsraum. Eine Relation ist noch keine Wechselwirkung. Eine Funktion ist noch kein zeitlicher Prozess. Ein Parameter ist noch keine Zeitvariable. Sobald eine solche Bedeutung später benötigt wird, muss sie zusätzlich begründet werden. M1 stellt ausschließlich den mathematischen Bestand bereit, auf den eine solche spätere Interpretation überhaupt erst kontrolliert aufbauen kann.\n\nGleichzeitig möchte ich die Mathematik nicht auf eine Sammlung voneinander unabhängiger Definitionen reduzieren. Für meinen weiteren Aufbau ist entscheidend, wie die Begriffe voneinander abhängen. Eine Relation benötigt geordnete Paare. Geordnete Paare führen zum kartesischen Produkt. Eine Funktion kann als Relation mit einer zusätzlichen Existenz- und Eindeutigkeitsbedingung verstanden werden. Bild und Urbild setzen wiederum eine Funktion voraus. Komposition benötigt zueinander passende Definitions- und Zielbereiche. Jede zusätzliche Struktur soll deshalb genau dort eingeführt werden, wo die bisher vorhandene Struktur für die nächste Aussage nicht mehr ausreicht.\n\nFür diese strukturorientierte Sicht verwende ich ergänzend Mac Lane. `{[[Mac Lane, Saunders: Mathematics: Form and Function. New York: Springer, 1986.]]}[[60]]` Seine Betrachtung mathematischer Gegenstände über Formen, Operationen und Beziehungen unterstützt die für mich wichtige Trennung zwischen einem mathematischen Objekt und seiner jeweiligen Darstellung oder späteren Interpretation. Ich übernehme daraus keine zusätzliche Theorie für M1, sondern nutze diese Perspektive als methodischen Rahmen für den Aufbau der Begriffe.\n\nDie erste Aufgabe besteht deshalb darin, Mengen und Elementzugehörigkeit eindeutig zu bestimmen. Dabei muss ich insbesondere zwischen einem Element `(a)`, der einelementigen Menge `(\\left\\{a\\right\\})` und einer Menge, welche wiederum `(\\left\\{a\\right\\})` als Element enthält, unterscheiden. Diese Ebenentrennung erscheint zunächst elementar, wird später aber unmittelbar relevant. Relationen sind Mengen geordneter Paare; Funktionen können wiederum selbst Elemente von Funktionsmengen sein. Ohne eine saubere Unterscheidung der jeweiligen Strukturebenen würden solche Konstruktionen mehrdeutig.\n\nAnschließend benötige ich Teilmengen und Mengenoperationen. Mit einer Teilmengenbeziehung kann ich ausdrücken, dass der vollständige Elementbestand einer Menge in einer anderen enthalten ist. Vereinigung, Durchschnitt und Differenz erlauben es mir, aus vorhandenen Mengen neue Mengen zu konstruieren. Mit der Potenzmenge kann ich schließlich die Gesamtheit aller Teilmengen einer gegebenen Menge wiederum als neues mathematisches Objekt behandeln. Diese Konstruktionen bleiben vollständig innerhalb der Mengenlehre. [[6]]\n\nDer nächste Schritt verändert die Struktur qualitativ. Eine gewöhnliche Menge bewahrt keine Reihenfolge ihrer Elemente. Für eine Relation muss ich jedoch unterscheiden können, ob `(a)` an erster und `(b)` an zweiter Stelle steht oder umgekehrt. Deshalb führe ich geordnete Paare und anschließend Tupel ein. Aus zwei Mengen `(A)` und `(B)` entsteht mit dem kartesischen Produkt `(A\\times B)` die Menge aller formal möglichen geordneten Paarungen ihrer Elemente. Noch ist damit keine bestimmte Beziehung ausgezeichnet. Das kartesische Produkt stellt lediglich den Möglichkeitsraum solcher Paarungen bereit. [[6]]\n\nErst aus einer ausgewählten Teilmenge dieses Produktes entsteht eine Relation. Eine Relation `(R\\subseteq A\\times B)` legt fest, welche der möglichen Paare tatsächlich zur betrachteten Beziehungsstruktur gehören. Diese Definition erlaubt zunächst ausdrücklich Mehrdeutigkeit: Zu einem Element `(a)` können kein, genau ein oder mehrere Elemente `(b)` in Relation stehen. Genau deshalb kann ich den Funktionsbegriff nicht mit dem Relationsbegriff gleichsetzen.\n\nDie Funktion entsteht erst durch eine zusätzliche Forderung. Für eine Funktion `(f:A\\rightarrow B)` muss jedem Element des Definitionsbereiches genau ein Element des Zielbereiches zugeordnet sein. Diese Eindeutigkeit bezieht sich zunächst nur auf die Richtung vom Argument zum Funktionswert. Verschiedene Argumente können weiterhin denselben Wert besitzen. Erst Injektivität, Surjektivität und Bijektivität unterscheiden zusätzliche Eigenschaften dieser Zuordnung.\n\nAn diesem Punkt wird für mich eine weitere begriffliche Trennung wichtig. Definitionsbereich, Zielbereich und tatsächlich angenommene Bildmenge sind nicht dasselbe. Ebenso ist das Urbild einer Menge nicht mit einer Umkehrfunktion zu verwechseln. Ein Urbild kann für jede Funktion bestimmt werden, während eine inverse Funktion zusätzliche Voraussetzungen benötigt. Diese Unterschiede sollen in M1 nicht nur notiert, sondern so entwickelt werden, dass die jeweilige Voraussetzung unmittelbar sichtbar bleibt.\n\nIm letzten Teil der Anlage erweitere ich den Funktionsbegriff, ohne seine Grundstruktur zu verlassen. Funktionen können miteinander komponiert werden. Mehrere Eingangsgrößen lassen sich über kartesische Produkte zu einem gemeinsamen Argumentbereich zusammenfassen. Eine Parametermenge kann eine ganze Familie von Funktionen indizieren. Partielle Funktionen erlauben schließlich eine eindeutige Zuordnung auf einem tatsächlichen Definitionsbereich, der nur eine Teilmenge eines zunächst betrachteten Grundbereichs bildet. Auch hier möchte ich eine Nichtdefiniertheit nicht stillschweigend mit einem besonderen Funktionswert gleichsetzen.\n\nDamit besitzt M1 eine eindeutige innere Abhängigkeitsstruktur. Ich entwickle sie in der Reihenfolge:\n\nMenge und Elementzugehörigkeit → Teilmengen und Potenzmengen → Mengenoperationen → geordnete Paare und kartesische Produkte → Relationen → Funktionen → Bild und Urbild → Injektivität, Surjektivität und Bijektivität → Identität und Komposition → mehrstellige, parametrisierte und partielle Funktionen.\n\nDiese Reihenfolge ist für mich verbindlich, weil jeder Schritt auf Strukturen aufbaut, die zuvor bereits mathematisch bestimmt wurden. Ich möchte dadurch vermeiden, dass eine spätere Eigenschaft unbemerkt in einen früheren Begriff hineingelesen wird.\n\nDie **Eingangsstelle von M1** besteht damit ausschließlich aus der etablierten mengentheoretischen und funktionalen Mathematik. Es wird keine bereits entwickelte theoretische Konstruktion vorausgesetzt.\n\nDie **Rückgabe- und Übergabestelle von M1** entsteht erst nach Abschluss der gesamten Anlage. Dann steht ein geprüfter mathematischer Ergebnisbestand zur Verfügung, aus dem ein später zu formulierender Haupttext gezielt diejenigen Definitionen und Beziehungen übernehmen kann, die für seinen Argumentationsweg tatsächlich benötigt werden. Die Begründungsrichtung bleibt dabei ausschließlich **von M1 zum späteren Haupttext**.\n\nDie **Weitergabestelle M1.0 → M1.1** ist nun eindeutig bestimmt. Bevor Teilmengen, Relationen oder Funktionen aufgebaut werden können, muss zunächst geklärt werden, was unter einer Menge, einem Element, Elementzugehörigkeit und Mengengleichheit verstanden wird und wie unterschiedliche Mengenebenen voneinander zu unterscheiden sind. Genau diese Aufgabe übernimmt **M1.1 Mengen, Elemente und Mengengleichheit**.', '404c1b80240e28c42a8b754c02d149d75d5473df533b53801252fbadb57b5057', 'Kanonischer M1.0-Text des neuen Anlagenaufbaus.'),
(2, 2, 14, 'draft', '## M1.1 Mengen, Elemente und Mengengleichheit\n\nAm Anfang des formalen Aufbaus brauche ich zunächst eine Möglichkeit, mathematische Objekte zu einem eindeutig bestimmten Bereich zusammenzufassen. Dafür verwende ich den Mengenbegriff. Entscheidend ist für mich dabei weniger eine anschauliche Vorstellung davon, was eine Menge „ist“, als die präzise Unterscheidung zwischen einem mathematischen Objekt und der Aussage, dass dieses Objekt zu einer bestimmten Menge gehört. Genau diese Trennung bildet die Voraussetzung für alle späteren Konstruktionen in M1. [[6]]\n\nIch bezeichne eine Menge beispielsweise mit `(A)` und ein betrachtetes mathematisches Objekt mit `(x)`. Gehört `(x)` zur Menge `(A)`, schreibe ich:\n\n\\[\nx\\in A\\tag{M1.1}\n\\]\n\nWord-LaTeX: `x\\in A`\n\nGehört `(x)` nicht zu `(A)`, verwende ich entsprechend:\n\n\\[\nx\\notin A\\tag{M1.2}\n\\]\n\nWord-LaTeX: `x\\notin A`\n\nMit diesen beiden Aussagen ist zunächst nur die Zugehörigkeit zu einem festgelegten Objektbereich bestimmt. Aus `(x\\in A)` folgt noch nicht, welche Eigenschaften `(x)` besitzt, ob `(x)` selbst eine Menge ist oder in welchen weiteren Beziehungen `(x)` steht. Diese Zurückhaltung ist für mich wichtig, weil spätere mathematische Strukturen nicht bereits in den elementaren Mengenbegriff hineingelesen werden dürfen.\n\nGerade an dieser Stelle wird die erste Ebenentrennung sichtbar. Ein Objekt `(a)` kann Element einer Menge sein. Ebenso kann aber auch eine Menge selbst Element einer anderen Menge sein. Die Elementrelation `( \\in )` sagt deshalb nicht, welcher mathematischen Art ein Element ist; sie beschreibt ausschließlich seine Zugehörigkeit.\n\nFür die Identität zweier Mengen ist nicht ihre Bezeichnung entscheidend, sondern ihr Elementbestand. Zwei Mengen `(A)` und `(B)` sind genau dann gleich, wenn sie dieselben Elemente enthalten. Ich fasse diese extensionale Bestimmung in der Form zusammen:\n\n\\[\nA=B\\iff\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)\\tag{M1.3}\n\\]\n\nWord-LaTeX: `A=B\\iff\\forall x\\left(x\\in A\\Longleftrightarrow x\\in B\\right)`\n\nDamit kann ich die Gleichheit zweier Mengen vollständig über die Elementzugehörigkeit prüfen. Unterschiedliche Namen erzeugen keine unterschiedlichen Mengen, wenn der Elementbestand identisch ist. Umgekehrt reicht bereits ein einziges Element, das nur zu einer der beiden Mengen gehört, aus, um `(A=B)` auszuschließen. [[6]]\n\nFür mich ergibt sich daraus bereits eine wichtige methodische Konsequenz. Die Bezeichnung eines mathematischen Objekts darf nicht mit seiner Struktur verwechselt werden. Wenn ich eine Menge anders benenne, aber keinen ihrer Bestandteile verändere, entsteht dadurch kein neues mathematisches Objekt.\n\nEine besondere Rolle besitzt die leere Menge. Ich bezeichne sie mit `(\\varnothing)`. Sie ist dadurch bestimmt, dass kein Objekt ihr Element ist:\n\n\\[\n\\forall x\\left(x\\notin\\varnothing\\right)\\tag{M1.4}\n\\]\n\nWord-LaTeX: `\\forall x\\left(x\\notin\\varnothing\\right)`\n\nDie leere Menge ist damit nicht das Fehlen eines mathematischen Objekts. Sie ist selbst ein eindeutig bestimmtes mathematisches Objekt, dessen Elementbestand leer ist. Diese Unterscheidung ist für den weiteren Aufbau unverzichtbar, weil `(\\varnothing)` später selbst Element anderer Mengen sein kann.\n\nEine äquivalente mengenbildende Darstellung erhält man über eine Bedingung, die kein Objekt erfüllen kann:\n\n\\[\n\\varnothing=\\left\\{x\\mid x\\neq x\\right\\}\\tag{M1.5}\n\\]\n\nWord-LaTeX: `\\varnothing=\\left\\{x\\mid x\\neq x\\right\\}`\n\nDer Ausdruck `(x\\neq x)` bezeichnet dabei eine Bedingung, während `(\\left\\{x\\mid x\\neq x\\right\\})` die Menge aller Objekte bezeichnet, die diese Bedingung erfüllen würden. Da kein `(x)` von sich selbst verschieden ist, enthält diese Menge kein Element. Bedingung und durch die Bedingung bestimmte Menge dürfen deshalb nicht miteinander verwechselt werden.\n\nAus einem einzelnen mathematischen Objekt `(a)` kann ich eine einelementige Menge bilden:\n\n\\[\n\\left\\{a\\right\\}=\\left\\{x\\mid x=a\\right\\}\\tag{M1.6}\n\\]\n\nWord-LaTeX: `\\left\\{a\\right\\}=\\left\\{x\\mid x=a\\right\\}`\n\nDamit entsteht bereits eine neue mathematische Ebene. Das Objekt `(a)` und die Menge `(\\left\\{a\\right\\})` sind nicht dasselbe. Es gilt zwar:\n\n\\[\na\\in\\left\\{a\\right\\}\\tag{M1.7}\n\\]\n\nWord-LaTeX: `a\\in\\left\\{a\\right\\}`\n\naber daraus folgt nicht:\n\n\\[\na=\\left\\{a\\right\\}\\tag{M1.8}\n\\]\n\nWord-LaTeX: `a=\\left\\{a\\right\\}`\n\nDie Aussage (M1.8) ist im allgemeinen Aufbau nicht zulässig. Elementzugehörigkeit `( \\in )` und Gleichheit `( = )` beschreiben unterschiedliche mathematische Beziehungen. Für mich ist diese Unterscheidung deshalb grundlegend, weil spätere Konstruktionen unmittelbar darauf angewiesen sind.\n\nDie Ebenen können weiter verschachtelt werden. Die Menge `(\\left\\{a\\right\\})` kann ihrerseits Element einer weiteren Menge sein:\n\n\\[\n\\left\\{a\\right\\}\\in\\left\\{\\left\\{a\\right\\}\\right\\}\\tag{M1.9}\n\\]\n\nWord-LaTeX: `\\left\\{a\\right\\}\\in\\left\\{\\left\\{a\\right\\}\\right\\}`\n\nDamit stehen `(a)`, `(\\left\\{a\\right\\})` und `(\\left\\{\\left\\{a\\right\\}\\right\\})` auf drei unterscheidbaren mathematischen Ebenen. Die zusätzliche Mengenbildung ist deshalb keine bloße Änderung der Schreibweise, sondern erzeugt jeweils ein neues mathematisches Objekt.\n\nDiese Ebenentrennung lässt sich kompakt zusammenfassen:\n\n\\[\na\\in\\left\\{a\\right\\}\\land\\left\\{a\\right\\}\\in\\left\\{\\left\\{a\\right\\}\\right\\}\\tag{M1.10}\n\\]\n\nWord-LaTeX: `a\\in\\left\\{a\\right\\}\\land\\left\\{a\\right\\}\\in\\left\\{\\left\\{a\\right\\}\\right\\}`\n\nFür den weiteren Aufbau halte ich aus M1.1 damit drei Punkte fest. Erstens wird die Identität einer Menge durch ihren Elementbestand bestimmt. Zweitens müssen Elementzugehörigkeit und Gleichheit strikt getrennt werden. Drittens kann eine Mengenbildung neue Strukturebenen erzeugen, auf denen Mengen selbst wieder als Elemente auftreten.\n\nGerade diese dritte Eigenschaft wird in den folgenden Abschnitten immer wieder benötigt. Eine Potenzmenge enthält Teilmengen als Elemente. Ein kartesisches Produkt enthält geordnete Paare als Elemente. Eine Relation ist wiederum eine Menge solcher Paare, und eine Funktion kann später selbst Element einer Funktionsmenge sein. Ohne die jetzt eingeführte Ebenentrennung wären diese Konstruktionen nicht sauber voneinander zu unterscheiden.\n\nDie **Weitergabestelle M1.1 → M1.2** liegt deshalb bei der Beziehung zwischen vollständigen Mengen. Nachdem geklärt ist, wann ein einzelnes Objekt `(x)` Element einer Menge `(A)` ist und wann zwei Mengen `(A)` und `(B)` identisch sind, kann als Nächstes bestimmt werden, unter welcher Bedingung der gesamte Elementbestand einer Menge in einer anderen enthalten ist. Darauf baut **M1.2 Teilmengen, echte Teilmengen und Potenzmengen** auf.', '4743b3e22ca470b3d4cb4ab408a664695133565116246eda951d347801e7ba36', 'Kanonischer M1.1-Text des Reset-Neuaufbaus. Formeln im Fließtext stehen linear in runden Klammern; Word-LaTeX-Zeilen enthalten keine Gleichungsnummer.'),
(3, 3, 15, 'draft', '## M1.2 Teilmengen, echte Teilmengen und Potenzmengen\n\nNachdem in M1.1 die Elementzugehörigkeit und die Mengengleichheit voneinander getrennt wurden, kann ich nun eine Beziehung zwischen vollständigen Mengen betrachten. Für den weiteren Aufbau reicht es nicht aus zu wissen, ob ein einzelnes Objekt `(x)` Element einer Menge `(A)` ist. Ich muss ebenso ausdrücken können, ob jedes Element einer Menge `(A)` zugleich in einer anderen Menge `(B)` enthalten ist. Genau diese Beziehung beschreibt die Teilmengenrelation. [[6]]\n\nEine Menge `(A)` ist Teilmenge einer Menge `(B)`, wenn jedes Element von `(A)` auch Element von `(B)` ist.\n\n\\[\nA\\subseteq B\\iff\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)\\tag{M1.11}\n\\]\n\nWord-LaTeX: `A\\subseteq B\\iff\\forall x\\left(x\\in A\\Longrightarrow x\\in B\\right)`\n\nFür mich ist dabei die Unterscheidung zur Elementrelation wesentlich. Die Aussage `(x\\in A)` verbindet ein einzelnes mathematisches Objekt mit einer Menge. Die Aussage `(A\\subseteq B)` verbindet dagegen zwei Mengen miteinander und beschreibt, wie ihre vollständigen Elementbestände zueinander liegen. Beide Beziehungen dürfen deshalb nicht gegeneinander ausgetauscht werden.\n\nAus der Definition folgt unmittelbar, dass jede Menge Teilmenge ihrer selbst ist.\n\n\\[\nA\\subseteq A\\tag{M1.12}\n\\]\n\nWord-LaTeX: `A\\subseteq A`\n\nDiese Reflexivität der Teilmengenrelation benötigt keine zusätzliche Annahme. Für jedes `(x\\in A)` gilt selbstverständlich wieder `(x\\in A)`.\n\nEbenso ist die leere Menge `(\\varnothing)` Teilmenge jeder Menge `(A)`.\n\n\\[\n\\varnothing\\subseteq A\\tag{M1.13}\n\\]\n\nWord-LaTeX: `\\varnothing\\subseteq A`\n\nDiese Aussage wirkt zunächst ungewöhnlich, folgt aber unmittelbar aus der Definition. Damit `(\\varnothing\\subseteq A)` falsch wäre, müsste ein Element existieren, das zur leeren Menge gehört, aber nicht zu `(A)`. Ein solches Element kann es nicht geben, weil `(\\varnothing)` definitionsgemäß überhaupt kein Element enthält. [[6]]\n\nDie Teilmengenrelation liefert zugleich eine zweite Möglichkeit, Mengengleichheit zu charakterisieren. Zwei Mengen sind genau dann gleich, wenn sie gegenseitig Teilmengen voneinander sind.\n\n\\[\nA=B\\iff\\left(A\\subseteq B\\land B\\subseteq A\\right)\\tag{M1.14}\n\\]\n\nWord-LaTeX: `A=B\\iff\\left(A\\subseteq B\\land B\\subseteq A\\right)`\n\nDiese Beziehung ist für mich praktisch besonders wichtig. Wenn ich später die Gleichheit zweier komplizierter Mengen zeigen möchte, kann ich den Nachweis in zwei überschaubare Richtungen zerlegen. Ich zeige zunächst `(A\\subseteq B)` und danach `(B\\subseteq A)`. Aus beiden Aussagen folgt dann `(A=B)`.\n\nDie gewöhnliche Teilmengenrelation `(A\\subseteq B)` lässt ausdrücklich den Fall `(A=B)` zu. Wenn ich dagegen sagen möchte, dass `(A)` vollständig in `(B)` enthalten ist, aber `(B)` mindestens ein weiteres Element besitzt, benötige ich die echte Teilmengenrelation.\n\n\\[\nA\\subsetneq B\\iff\\left(A\\subseteq B\\land A\\neq B\\right)\\tag{M1.15}\n\\]\n\nWord-LaTeX: `A\\subsetneq B\\iff\\left(A\\subseteq B\\land A\\neq B\\right)`\n\nDamit folgt aus `(A\\subsetneq B)`, dass in `(B)` wenigstens ein Element vorkommt, das nicht zu `(A)` gehört.\n\n\\[\nA\\subsetneq B\\Longrightarrow\\exists x\\left(x\\in B\\land x\\notin A\\right)\\tag{M1.16}\n\\]\n\nWord-LaTeX: `A\\subsetneq B\\Longrightarrow\\exists x\\left(x\\in B\\land x\\notin A\\right)`\n\nFür mich markiert diese Unterscheidung einen wichtigen strukturellen Unterschied. Die Aussage `(A\\subseteq B)` beschreibt lediglich vollständige Einbettung. Die stärkere Aussage `(A\\subsetneq B)` sagt zusätzlich, dass durch `(B)` tatsächlich ein größerer Elementbestand vorliegt.\n\nAuch mehrstufige Einbettungen lassen sich kontrolliert zusammenführen. Ist `(A)` Teilmenge von `(B)` und `(B)` Teilmenge von `(C)`, dann ist `(A)` notwendigerweise Teilmenge von `(C)`.\n\n\\[\n\\left(A\\subseteq B\\land B\\subseteq C\\right)\\Longrightarrow A\\subseteq C\\tag{M1.17}\n\\]\n\nWord-LaTeX: `\\left(A\\subseteq B\\land B\\subseteq C\\right)\\Longrightarrow A\\subseteq C`\n\nDiese Transitivität erlaubt mir später, längere Einschlussketten zu behandeln, ohne für jede entfernte Beziehung erneut auf die Ebene einzelner Elemente zurückgehen zu müssen. [[6]]\n\nMit der Teilmengenrelation kann ich nun eine neue Menge bilden, deren Elemente selbst Mengen sind. Zu einer gegebenen Menge `(A)` definiere ich die Potenzmenge `(\\mathcal{P}(A))` als die Menge aller Teilmengen von `(A)`.\n\n\\[\n\\mathcal{P}(A)=\\left\\{X\\mid X\\subseteq A\\right\\}\\tag{M1.18}\n\\]\n\nWord-LaTeX: `\\mathcal{P}(A)=\\left\\{X\\mid X\\subseteq A\\right\\}`\n\nAn dieser Definition wird die in M1.1 eingeführte Ebenentrennung unmittelbar sichtbar. Ein Element von `(\\mathcal{P}(A))` ist selbst eine Menge. Die Aussage `(X\\in\\mathcal{P}(A))` ist deshalb genau dann erfüllt, wenn `(X)` eine Teilmenge von `(A)` ist.\n\n\\[\nX\\in\\mathcal{P}(A)\\iff X\\subseteq A\\tag{M1.19}\n\\]\n\nWord-LaTeX: `X\\in\\mathcal{P}(A)\\iff X\\subseteq A`\n\nFür mich ist diese Gleichung besonders anschaulich, weil sie zeigt, wie dieselbe mathematische Struktur auf zwei unterschiedlichen Ebenen beschrieben wird. Gegenüber `(A)` steht `(X)` in einer Teilmengenbeziehung. Gegenüber `(\\mathcal{P}(A))` ist `(X)` dagegen ein Element.\n\nDa jede Menge Teilmenge ihrer selbst ist, gehört `(A)` zu ihrer eigenen Potenzmenge.\n\n\\[\nA\\in\\mathcal{P}(A)\\tag{M1.20}\n\\]\n\nWord-LaTeX: `A\\in\\mathcal{P}(A)`\n\nEbenso gehört die leere Menge `(\\varnothing)` zu jeder Potenzmenge.\n\n\\[\n\\varnothing\\in\\mathcal{P}(A)\\tag{M1.21}\n\\]\n\nWord-LaTeX: `\\varnothing\\in\\mathcal{P}(A)`\n\nDabei ist mir wichtig, die Aussage `(\\varnothing\\in\\mathcal{P}(A))` nicht mit `(\\varnothing\\subseteq\\mathcal{P}(A))` zu verwechseln. Im ersten Fall ist `(\\varnothing)` ein Element der Potenzmenge, weil sie Teilmenge von `(A)` ist. Im zweiten Fall wird dagegen untersucht, ob sämtliche Elemente der leeren Menge in `(\\mathcal{P}(A))` enthalten sind. Diese zweite Aussage ist zwar ebenfalls wahr, aber aus einem anderen Grund.\n\nFür endliche Mengen kann ich zusätzlich bestimmen, wie viele Elemente die Potenzmenge besitzt. Hat `(A)` genau `(n)` Elemente, dann besitzt `(\\mathcal{P}(A))` genau `(2^n)` Elemente.\n\n\\[\n\\left|A\\right|=n\\Longrightarrow\\left|\\mathcal{P}(A)\\right|=2^n\\tag{M1.22}\n\\]\n\nWord-LaTeX: `\\left|A\\right|=n\\Longrightarrow\\left|\\mathcal{P}(A)\\right|=2^n`\n\nDer Grund ist einfach zu verstehen. Für jedes der `(n)` Elemente von `(A)` gibt es bei der Bildung einer Teilmenge genau zwei Möglichkeiten: Das Element wird aufgenommen oder nicht aufgenommen. Die unabhängige Kombination dieser Entscheidungen erzeugt insgesamt `(2^n)` verschiedene Teilmengen. [[6]]\n\nEin kleines Beispiel macht die entstehende neue Strukturebene sichtbar. Für `(A=\\left\\{a,b\\right\\})` besteht die Potenzmenge aus vier Elementen:\n\n\\[\n\\mathcal{P}\\left(\\left\\{a,b\\right\\}\\right)=\\left\\{\\varnothing,\\left\\{a\\right\\},\\left\\{b\\right\\},\\left\\{a,b\\right\\}\\right\\}\\tag{M1.23}\n\\]\n\nWord-LaTeX: `\\mathcal{P}\\left(\\left\\{a,b\\right\\}\\right)=\\left\\{\\varnothing,\\left\\{a\\right\\},\\left\\{b\\right\\},\\left\\{a,b\\right\\}\\right\\}`\n\nHier besitzt die Ausgangsmenge `(A)` zwei Elemente. Die Potenzmenge enthält dagegen vier Elemente, und jedes dieser vier Elemente ist selbst wieder eine Menge. Für meinen weiteren Aufbau ist genau diese Verschiebung der Strukturebene wichtig. Später werden nicht nur Mengen von Elementen, sondern auch Mengen von Relationen und Mengen von Funktionen betrachtet.\n\nAus M1.2 halte ich deshalb vier Ergebnisse fest. Erstens beschreibt `(A\\subseteq B)` die vollständige Einbettung des Elementbestandes von `(A)` in `(B)`. Zweitens ergänzt `(A\\subsetneq B)` diese Beziehung um die Forderung `(A\\neq B)`. Drittens ist Mengengleichheit durch gegenseitige Teilmengenbeziehung charakterisierbar. Viertens erzeugt die Potenzmenge `(\\mathcal{P}(A))` eine neue mathematische Ebene, auf der Teilmengen von `(A)` selbst zu Elementen werden.\n\nDie **Weitergabestelle M1.2 → M1.3** liegt nun bei der Konstruktion neuer Mengen aus bereits gegebenen Mengen. Teilmengen und Potenzmengen beschreiben Einschluss- und Ebenenbeziehungen. Als Nächstes benötige ich Operationen, mit denen Elementbestände zusammengeführt, gemeinsam ausgewählt oder voneinander getrennt werden können. Diese Aufgabe übernimmt **M1.3 Mengenoperationen**.', 'ce8c8b890357f16d6645484515353048ac67fa4c5f53522297867ad6035eb8ed', 'Kanonischer Reset-Text M1.2; persönlicher wissenschaftlicher Schreibstil und Ich-Form.'),
(4, 4, 16, 'draft', '## M1.3 Mengenoperationen\n\nMit Teilmengen und Potenzmengen kann ich beschreiben, wie Mengen hinsichtlich ihres Elementbestandes zueinander liegen. Für den weiteren Aufbau reicht mir diese statische Beziehung jedoch noch nicht aus. Ich benötige ebenso Operationen, mit denen aus bereits gegebenen Mengen neue Mengen entstehen. Dabei möchte ich auch hier keine zusätzliche Bedeutung voraussetzen: Eine Mengenoperation verändert zunächst ausschließlich den betrachteten Elementbestand. Sie beschreibt weder einen zeitlichen Vorgang noch eine physikalische Transformation. [[6]]\n\n### M1.3.1 Vereinigung\n\nSeien `(A)` und `(B)` zwei Mengen. Ihre Vereinigung `(A\\cup B)` enthält genau diejenigen Elemente, die mindestens einer der beiden Mengen angehören.\n\n\\[\nA\\cup B=\\left\\{x\\mid x\\in A\\lor x\\in B\\right\\}\\tag{M1.24}\n\\]\n\nWord-LaTeX: `A\\cup B=\\left\\{x\\mid x\\in A\\lor x\\in B\\right\\}`\n\nDie logische Verknüpfung `( \\lor )` schließt dabei ausdrücklich den Fall ein, dass `(x)` sowohl Element von `(A)` als auch von `(B)` ist. Ein gemeinsames Element erscheint in der resultierenden Menge dennoch nicht mehrfach. Für die Mengenidentität zählt allein, ob ein Element enthalten ist.\n\nAus der Definition folgt unmittelbar, dass beide Ausgangsmengen Teilmengen ihrer Vereinigung sind.\n\n\\[\nA\\subseteq A\\cup B\\tag{M1.25}\n\\]\n\nWord-LaTeX: `A\\subseteq A\\cup B`\n\nund\n\n\\[\nB\\subseteq A\\cup B\\tag{M1.26}\n\\]\n\nWord-LaTeX: `B\\subseteq A\\cup B`\n\nDie Reihenfolge der beiden Mengen verändert die Vereinigung nicht.\n\n\\[\nA\\cup B=B\\cup A\\tag{M1.27}\n\\]\n\nWord-LaTeX: `A\\cup B=B\\cup A`\n\nDie Vereinigung ist damit kommutativ. Ebenso kann ich bei mehreren Vereinigungen die Klammerung verändern, ohne den Elementbestand der resultierenden Menge zu verändern.\n\n\\[\n\\left(A\\cup B\\right)\\cup C=A\\cup\\left(B\\cup C\\right)\\tag{M1.28}\n\\]\n\nWord-LaTeX: `\\left(A\\cup B\\right)\\cup C=A\\cup\\left(B\\cup C\\right)`\n\nFür die leere Menge gilt schließlich:\n\n\\[\nA\\cup\\varnothing=A\\tag{M1.29}\n\\]\n\nWord-LaTeX: `A\\cup\\varnothing=A`\n\nDamit wirkt `(\\varnothing)` bezüglich der Vereinigung als neutrales Element. Da die leere Menge kein zusätzliches Element beiträgt, bleibt der Elementbestand von `(A)` unverändert.\n\n### M1.3.2 Durchschnitt\n\nWährend die Vereinigung alle Elemente erfasst, die mindestens einer Ausgangsmenge angehören, interessiert mich beim Durchschnitt genau der gemeinsame Anteil. Der Durchschnitt `(A\\cap B)` enthält diejenigen Elemente, die gleichzeitig in `(A)` und `(B)` liegen.\n\n\\[\nA\\cap B=\\left\\{x\\mid x\\in A\\land x\\in B\\right\\}\\tag{M1.30}\n\\]\n\nWord-LaTeX: `A\\cap B=\\left\\{x\\mid x\\in A\\land x\\in B\\right\\}`\n\nDie logische Verknüpfung `( \\land )` verlangt damit beide Zugehörigkeiten gleichzeitig.\n\nAus der Definition folgt:\n\n\\[\nA\\cap B\\subseteq A\\tag{M1.31}\n\\]\n\nWord-LaTeX: `A\\cap B\\subseteq A`\n\nund\n\n\\[\nA\\cap B\\subseteq B\\tag{M1.32}\n\\]\n\nWord-LaTeX: `A\\cap B\\subseteq B`\n\nAuch der Durchschnitt ist kommutativ.\n\n\\[\nA\\cap B=B\\cap A\\tag{M1.33}\n\\]\n\nWord-LaTeX: `A\\cap B=B\\cap A`\n\nEbenso gilt die Assoziativität:\n\n\\[\n\\left(A\\cap B\\right)\\cap C=A\\cap\\left(B\\cap C\\right)\\tag{M1.34}\n\\]\n\nWord-LaTeX: `\\left(A\\cap B\\right)\\cap C=A\\cap\\left(B\\cap C\\right)`\n\nFür jede Menge gilt außerdem:\n\n\\[\nA\\cap A=A\\tag{M1.35}\n\\]\n\nWord-LaTeX: `A\\cap A=A`\n\nund für die leere Menge:\n\n\\[\nA\\cap\\varnothing=\\varnothing\\tag{M1.36}\n\\]\n\nWord-LaTeX: `A\\cap\\varnothing=\\varnothing`\n\nBesitzen zwei Mengen keine gemeinsamen Elemente, ist ihr Durchschnitt leer.\n\n\\[\nA\\cap B=\\varnothing\\tag{M1.37}\n\\]\n\nWord-LaTeX: `A\\cap B=\\varnothing`\n\nIn diesem Fall bezeichne ich `(A)` und `(B)` als disjunkt. Für mich ist dabei wichtig, Disjunktheit nicht als neue Mengenart zu behandeln. Sie beschreibt ausschließlich eine Beziehung zwischen den Elementbeständen zweier Mengen.\n\n### M1.3.3 Mengendifferenz\n\nNeben gemeinsamen und zusammengeführten Elementen muss ich auch ausdrücken können, welche Elemente einer Menge nach Ausschluss einer zweiten Menge verbleiben. Dazu definiere ich die Mengendifferenz `(A\\setminus B)`.\n\n\\[\nA\\setminus B=\\left\\{x\\mid x\\in A\\land x\\notin B\\right\\}\\tag{M1.38}\n\\]\n\nWord-LaTeX: `A\\setminus B=\\left\\{x\\mid x\\in A\\land x\\notin B\\right\\}`\n\nDie Reihenfolge ist hierbei wesentlich. `(A\\setminus B)` betrachtet zunächst den Elementbestand von `(A)` und entfernt daraus diejenigen Elemente, die zugleich zu `(B)` gehören. `(B\\setminus A)` beginnt dagegen beim Elementbestand von `(B)`. Im Allgemeinen entstehen deshalb verschiedene Mengen.\n\nFür die Differenz einer Menge mit sich selbst gilt:\n\n\\[\nA\\setminus A=\\varnothing\\tag{M1.39}\n\\]\n\nWord-LaTeX: `A\\setminus A=\\varnothing`\n\nEntferne ich dagegen die leere Menge, bleibt `(A)` unverändert.\n\n\\[\nA\\setminus\\varnothing=A\\tag{M1.40}\n\\]\n\nWord-LaTeX: `A\\setminus\\varnothing=A`\n\n### M1.3.4 Komplement bezüglich einer Grundmenge\n\nDie Mengendifferenz erlaubt mir auch, ein Komplement zu definieren. Dafür muss jedoch zunächst eine übergeordnete Grundmenge `(U)` festgelegt sein und `(A\\subseteq U)` gelten. Erst dann ist eindeutig bestimmt, welche Elemente als „nicht zu `(A)` gehörend“ betrachtet werden.\n\nIch definiere das Komplement von `(A)` bezüglich `(U)` durch:\n\n\\[\nA^{\\mathrm{c}}=U\\setminus A\\tag{M1.41}\n\\]\n\nWord-LaTeX: `A^{\\mathrm{c}}=U\\setminus A`\n\nÄquivalent kann ich schreiben:\n\n\\[\nA^{\\mathrm{c}}=\\left\\{x\\in U\\mid x\\notin A\\right\\}\\tag{M1.42}\n\\]\n\nWord-LaTeX: `A^{\\mathrm{c}}=\\left\\{x\\in U\\mid x\\notin A\\right\\}`\n\nDie Grundmenge `(U)` gehört damit zur Definition des Komplements. Ohne sie wäre nicht festgelegt, aus welchem Gesamtbereich die nicht zu `(A)` gehörenden Elemente ausgewählt werden sollen. Diese Relativität möchte ich ausdrücklich sichtbar halten. [[6]]\n\nAus der Definition folgen unmittelbar zwei Beziehungen:\n\n\\[\nA\\cap A^{\\mathrm{c}}=\\varnothing\\tag{M1.43}\n\\]\n\nWord-LaTeX: `A\\cap A^{\\mathrm{c}}=\\varnothing`\n\nund\n\n\\[\nA\\cup A^{\\mathrm{c}}=U\\tag{M1.44}\n\\]\n\nWord-LaTeX: `A\\cup A^{\\mathrm{c}}=U`\n\nDas zweimalige Bilden des Komplements führt wieder zur Ausgangsmenge.\n\n\\[\n\\left(A^{\\mathrm{c}}\\right)^{\\mathrm{c}}=A\\tag{M1.45}\n\\]\n\nWord-LaTeX: `\\left(A^{\\mathrm{c}}\\right)^{\\mathrm{c}}=A`\n\n### M1.3.5 De-Morgan-Beziehungen\n\nVereinigung, Durchschnitt und Komplement stehen nicht unabhängig nebeneinander. Besonders deutlich wird ihre Verbindung durch die De-Morgan-Beziehungen.\n\nFür das Komplement einer Vereinigung gilt:\n\n\\[\n\\left(A\\cup B\\right)^{\\mathrm{c}}=A^{\\mathrm{c}}\\cap B^{\\mathrm{c}}\\tag{M1.46}\n\\]\n\nWord-LaTeX: `\\left(A\\cup B\\right)^{\\mathrm{c}}=A^{\\mathrm{c}}\\cap B^{\\mathrm{c}}`\n\nDas Komplement eines Durchschnitts erfüllt entsprechend:\n\n\\[\n\\left(A\\cap B\\right)^{\\mathrm{c}}=A^{\\mathrm{c}}\\cup B^{\\mathrm{c}}\\tag{M1.47}\n\\]\n\nWord-LaTeX: `\\left(A\\cap B\\right)^{\\mathrm{c}}=A^{\\mathrm{c}}\\cup B^{\\mathrm{c}}`\n\nFür mich zeigen diese beiden Beziehungen besonders gut, dass Mengenoperationen ein zusammenhängendes System bilden. Der Wechsel von Vereinigung zu Durchschnitt wird beim Komplementieren durch den entsprechenden Wechsel der logischen Bedingung begleitet. [[6]]\n\n### M1.3.6 Distributivität\n\nAuch Vereinigung und Durchschnitt sind strukturell miteinander verbunden. Der Durchschnitt verteilt sich über die Vereinigung:\n\n\\[\nA\\cap\\left(B\\cup C\\right)=\\left(A\\cap B\\right)\\cup\\left(A\\cap C\\right)\\tag{M1.48}\n\\]\n\nWord-LaTeX: `A\\cap\\left(B\\cup C\\right)=\\left(A\\cap B\\right)\\cup\\left(A\\cap C\\right)`\n\nUmgekehrt verteilt sich die Vereinigung über den Durchschnitt:\n\n\\[\nA\\cup\\left(B\\cap C\\right)=\\left(A\\cup B\\right)\\cap\\left(A\\cup C\\right)\\tag{M1.49}\n\\]\n\nWord-LaTeX: `A\\cup\\left(B\\cap C\\right)=\\left(A\\cup B\\right)\\cap\\left(A\\cup C\\right)`\n\nDiese beiden Beziehungen sind für mich später deshalb nützlich, weil komplexere Mengenbedingungen umgeformt werden können, ohne dass sich der zugrunde liegende Elementbestand verändert.\n\n### M1.3.7 Ergebnis und Weitergabestelle\n\nMit den Mengenoperationen kann ich nun aus vorhandenen Mengen neue Mengen bilden, ohne den grundlegenden Mengenbegriff zu verlassen. Die Vereinigung `(A\\cup B)` fasst Elementbestände zusammen. Der Durchschnitt `(A\\cap B)` isoliert gemeinsame Elemente. Die Differenz `(A\\setminus B)` entfernt aus einem gegebenen Elementbestand diejenigen Elemente, die zugleich einer zweiten Menge angehören. Das Komplement `(A^{\\mathrm{c}})` ist eine solche Differenz relativ zu einer ausdrücklich bestimmten Grundmenge `(U)`.\n\nFür meinen weiteren Aufbau ist darüber hinaus entscheidend, dass diese Operationen keine Reihenfolge zwischen einzelnen Elementen erzeugen. Auch wenn ich mehrere Mengen miteinander verknüpfe, bleibt eine gewöhnliche Menge hinsichtlich der Anordnung ihrer Elemente ungeordnet. Genau an dieser Grenze benötige ich die nächste Struktur.\n\nDie **Weitergabestelle M1.3 → M1.4** liegt deshalb bei der Einführung geordneter Komponenten. Um Relationen zwischen Elementen später eindeutig als Mengen von Paaren formulieren zu können, muss ich zunächst mathematisch unterscheiden können, welches Element an erster und welches an zweiter Position steht. Diese Aufgabe übernimmt **M1.4 Geordnete Paare, Tupel und kartesische Produkte**.', '58a50330b87f43a076f3e369e1b2f02735c97a0a0cbf00267bd82c0f389cfe9e', 'Kanonischer Reset-Text M1.3; persönlicher wissenschaftlicher Schreibstil und Ich-Form.'),
(5, 5, 17, 'draft', '## M1.4 Geordnete Paare, Tupel und kartesische Produkte\n\nMit den bisherigen Mengenoperationen kann ich Elementbestände bilden, miteinander vergleichen und aus bereits vorhandenen Mengen neue Mengen konstruieren. Eine Eigenschaft fehlt mir jedoch noch: Eine gewöhnliche Menge unterscheidet nicht danach, **an welcher Position** ein Element innerhalb einer Zusammenstellung steht. Für die spätere Definition von Relationen reicht das nicht aus. Dort muss ich beispielsweise unterscheiden können, ob `(a)` an erster und `(b)` an zweiter Stelle steht oder ob beide Positionen vertauscht sind. Genau deshalb benötige ich geordnete Paare. [[6]]\n\n### M1.4.1 Vom ungeordneten zum geordneten Paar\n\nBei einer gewöhnlichen zweielementigen Menge spielt die Reihenfolge ihrer Elemente keine Rolle.\n\n\\[\n\\left\\{a,b\\right\\}=\\left\\{b,a\\right\\}\\tag{M1.50}\n\\]\n\nWord-LaTeX: `\\left\\{a,b\\right\\}=\\left\\{b,a\\right\\}`\n\nFür eine geordnete Struktur ist diese Eigenschaft gerade nicht ausreichend. Wenn `(a)` die erste und `(b)` die zweite Komponente bezeichnet, muss diese Position mathematisch erhalten bleiben.\n\nEine klassische mengentheoretische Konstruktion des geordneten Paares ist die Kuratowski-Darstellung. [[6]]\n\n\\[\n(a,b)=\\left\\{\\left\\{a\\right\\},\\left\\{a,b\\right\\}\\right\\}\\tag{M1.51}\n\\]\n\nWord-LaTeX: `(a,b)=\\left\\{\\left\\{a\\right\\},\\left\\{a,b\\right\\}\\right\\}`\n\nFür mich ist an dieser Konstruktion besonders wichtig, dass ich damit kein neues mathematisches Grundobjekt voraussetzen muss. Das geordnete Paar wird vollständig aus bereits eingeführten Mengen aufgebaut. Die einelementige Menge `(\\left\\{a\\right\\})` zeichnet dabei die erste Komponente aus, während `(\\left\\{a,b\\right\\})` beide Komponenten enthält.\n\nDie entscheidende Eigenschaft eines geordneten Paares lautet:\n\n\\[\n(a,b)=(c,d)\\iff\\left(a=c\\land b=d\\right)\\tag{M1.52}\n\\]\n\nWord-LaTeX: `(a,b)=(c,d)\\iff\\left(a=c\\land b=d\\right)`\n\nDamit ist die Positionsinformation mathematisch eindeutig bestimmt. Zwei geordnete Paare sind nicht bereits dann gleich, wenn sie dieselben Komponenten enthalten. Entscheidend ist zusätzlich, dass die Komponenten an denselben Positionen übereinstimmen.\n\nFür `(a\\neq b)` folgt deshalb:\n\n\\[\n(a,b)\\neq(b,a)\\tag{M1.53}\n\\]\n\nWord-LaTeX: `(a,b)\\neq(b,a)`\n\nGenau darin liegt für mich der strukturelle Unterschied zur gewöhnlichen Menge `(\\left\\{a,b\\right\\})`. Die Menge hält lediglich fest, welche Elemente enthalten sind. Das geordnete Paar speichert darüber hinaus, welche Komponente zuerst und welche anschließend steht.\n\nDiese Reihenfolge besitzt zunächst ausschließlich mathematische Bedeutung. Aus der ersten und zweiten Position folgt weder eine zeitliche Reihenfolge noch eine räumliche Richtung oder eine kausale Beziehung. Eine solche Interpretation müsste zusätzlich eingeführt werden.\n\n### M1.4.2 Kartesisches Produkt\n\nSind zwei Mengen `(A)` und `(B)` gegeben, kann ich nun die Menge aller geordneten Paare bilden, deren erste Komponente aus `(A)` und deren zweite Komponente aus `(B)` stammt. Diese Menge bezeichne ich als kartesisches Produkt. [[6]]\n\n\\[\nA\\times B=\\left\\{(a,b)\\mid a\\in A\\land b\\in B\\right\\}\\tag{M1.54}\n\\]\n\nWord-LaTeX: `A\\times B=\\left\\{(a,b)\\mid a\\in A\\land b\\in B\\right\\}`\n\nDie Zugehörigkeit eines bestimmten Paares zum kartesischen Produkt ist damit genau dann gegeben, wenn beide Komponenten den jeweils vorgesehenen Mengen angehören.\n\n\\[\n(a,b)\\in A\\times B\\iff\\left(a\\in A\\land b\\in B\\right)\\tag{M1.55}\n\\]\n\nWord-LaTeX: `(a,b)\\in A\\times B\\iff\\left(a\\in A\\land b\\in B\\right)`\n\nAn dieser Stelle entsteht erneut eine neue Strukturebene. Die Elemente von `(A\\times B)` sind nicht die einzelnen Objekte `(a)` oder `(b)`, sondern die geordneten Paare `(a,b)`.\n\nAus `(a\\in A)` und `(b\\in B)` folgt deshalb zunächst die Paarzugehörigkeit `((a,b)\\in A\\times B)`. Dagegen folgt im Allgemeinen weder `(a\\in A\\times B)` noch `(b\\in A\\times B)`.\n\nEin einfaches Beispiel macht diese Struktur unmittelbar sichtbar. Seien:\n\n\\[\nA=\\left\\{a_1,a_2\\right\\},\\qquad B=\\left\\{b_1,b_2\\right\\}\\tag{M1.56}\n\\]\n\nWord-LaTeX: `A=\\left\\{a_1,a_2\\right\\},\\qquad B=\\left\\{b_1,b_2\\right\\}`\n\nDann ergibt sich:\n\n\\[\nA\\times B=\\left\\{(a_1,b_1),(a_1,b_2),(a_2,b_1),(a_2,b_2)\\right\\}\\tag{M1.57}\n\\]\n\nWord-LaTeX: `A\\times B=\\left\\{(a_1,b_1),(a_1,b_2),(a_2,b_1),(a_2,b_2)\\right\\}`\n\nJede mögliche erste Komponente wird dabei mit jeder möglichen zweiten Komponente kombiniert. Das kartesische Produkt stellt somit den vollständigen Raum der formal möglichen Paarungen zwischen `(A)` und `(B)` bereit.\n\nFür endliche Mengen kann ich die Anzahl dieser Paarungen unmittelbar bestimmen. Besitzt `(A)` genau `(m)` und `(B)` genau `(n)` Elemente, dann besitzt das kartesische Produkt `(mn)` Elemente.\n\n\\[\n\\left|A\\right|=m\\land\\left|B\\right|=n\\Longrightarrow\\left|A\\times B\\right|=mn\\tag{M1.58}\n\\]\n\nWord-LaTeX: `\\left|A\\right|=m\\land\\left|B\\right|=n\\Longrightarrow\\left|A\\times B\\right|=mn`\n\nFür jede der `(m)` möglichen ersten Komponenten stehen unabhängig `(n)` mögliche zweite Komponenten zur Verfügung.\n\n### M1.4.3 Bedeutung der Faktorfolge\n\nDie Reihenfolge der Faktoren gehört zur Struktur des kartesischen Produktes. In `(A\\times B)` stammt die erste Komponente aus `(A)` und die zweite aus `(B)`. In `(B\\times A)` ist diese Zuordnung vertauscht.\n\nAus einem Paar `((a,b)\\in A\\times B)` entsteht durch Vertauschung der Komponenten das Paar `((b,a)\\in B\\times A)`.\n\n\\[\n(a,b)\\in A\\times B\\Longrightarrow(b,a)\\in B\\times A\\tag{M1.59}\n\\]\n\nWord-LaTeX: `(a,b)\\in A\\times B\\Longrightarrow(b,a)\\in B\\times A`\n\nDamit besteht zwischen beiden Produkten zwar eine natürliche Zuordnung, sie sind jedoch nicht allein aufgrund derselben beteiligten Mengen als identische Strukturen zu behandeln. Nur unter zusätzlichen Bedingungen können ihre Elementmengen tatsächlich übereinstimmen.\n\nDiese Unterscheidung wird später wichtig, weil bei einer Relation erste und zweite Komponente unterschiedliche Rollen besitzen können. Ein Vertauschen der Positionen verändert dann im Allgemeinen auch die betrachtete Relation.\n\n### M1.4.4 Leere Faktoren\n\nDas kartesische Produkt benötigt für jedes seiner Elemente eine erste und eine zweite Komponente. Ist einer der beiden Faktoren leer, kann deshalb kein geordnetes Paar gebildet werden.\n\n\\[\nA\\times\\varnothing=\\varnothing\\tag{M1.60}\n\\]\n\nWord-LaTeX: `A\\times\\varnothing=\\varnothing`\n\nEbenso gilt:\n\n\\[\n\\varnothing\\times B=\\varnothing\\tag{M1.61}\n\\]\n\nWord-LaTeX: `\\varnothing\\times B=\\varnothing`\n\nDiese Beziehungen folgen unmittelbar aus der Definition des kartesischen Produktes. Ein Element `(a,b)` kann nur existieren, wenn sowohl ein zulässiges `(a)` als auch ein zulässiges `(b)` vorhanden ist.\n\n### M1.4.5 Tupel mit mehr als zwei Komponenten\n\nFür spätere Funktionen mit mehreren Eingangsgrößen reicht ein geordnetes Paar nicht immer aus. Deshalb erweitere ich die Positionsstruktur auf beliebig viele endlich viele Komponenten.\n\nEin geordnetes `(n)`-Tupel besitzt die Form:\n\n\\[\n(a_1,a_2,\\ldots,a_n)\\tag{M1.62}\n\\]\n\nWord-LaTeX: `(a_1,a_2,\\ldots,a_n)`\n\nJede Komponente `(a_i)` besitzt dabei eine eindeutig bestimmte Position `(i)`.\n\nZwei Tupel gleicher Länge sind genau dann gleich, wenn ihre Komponenten positionsweise übereinstimmen.\n\n\\[\n(a_1,\\ldots,a_n)=(b_1,\\ldots,b_n)\\iff\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i=b_i\\tag{M1.63}\n\\]\n\nWord-LaTeX: `(a_1,\\ldots,a_n)=(b_1,\\ldots,b_n)\\iff\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i=b_i`\n\nDamit verallgemeinert sich die Gleichheitsbedingung des geordneten Paares unmittelbar auf beliebig lange endliche Tupel.\n\nFür Mengen `(A_1,\\ldots,A_n)` kann ich entsprechend das kartesische Produkt mehrerer Faktoren definieren.\n\n\\[\nA_1\\times\\cdots\\times A_n=\\left\\{(a_1,\\ldots,a_n)\\mid\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i\\in A_i\\right\\}\\tag{M1.64}\n\\]\n\nWord-LaTeX: `A_1\\times\\cdots\\times A_n=\\left\\{(a_1,\\ldots,a_n)\\mid\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i\\in A_i\\right\\}`\n\nDie kompakte Produktschreibweise lautet:\n\n\\[\n\\prod_{i=1}^{n}A_i=A_1\\times A_2\\times\\cdots\\times A_n\\tag{M1.65}\n\\]\n\nWord-LaTeX: `\\prod_{i=1}^{n}A_i=A_1\\times A_2\\times\\cdots\\times A_n`\n\nFür ein Element dieses Produktes gilt entsprechend:\n\n\\[\n(a_1,\\ldots,a_n)\\in\\prod_{i=1}^{n}A_i\\iff\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i\\in A_i\\tag{M1.66}\n\\]\n\nWord-LaTeX: `(a_1,\\ldots,a_n)\\in\\prod_{i=1}^{n}A_i\\iff\\forall i\\in\\left\\{1,\\ldots,n\\right\\}:a_i\\in A_i`\n\nSind alle Faktoren mit derselben Menge `(A)` identisch, verwende ich die Potenzschreibweise `(A^n)`.\n\n\\[\nA^n=\\underbrace{A\\times A\\times\\cdots\\times A}_{n\\ \\mathrm{Faktoren}}\\tag{M1.67}\n\\]\n\nWord-LaTeX: `A^n=\\underbrace{A\\times A\\times\\cdots\\times A}_{n\\ \\mathrm{Faktoren}}`\n\nDamit bezeichnet `(A^n)` die Menge aller geordneten `(n)`-Tupel, deren sämtliche Komponenten aus `(A)` stammen.\n\n### M1.4.6 Projektionen auf einzelne Komponenten\n\nDa die Positionen eines Tupels erhalten bleiben, kann ich einzelne Komponenten eindeutig auswählen. Für das Produkt `(A\\times B)` definiere ich zunächst die beiden natürlichen Projektionen.\n\nDie erste Projektion wählt die erste Komponente aus:\n\n\\[\n\\pi_1:A\\times B\\rightarrow A,\\qquad\\pi_1(a,b)=a\\tag{M1.68}\n\\]\n\nWord-LaTeX: `\\pi_1:A\\times B\\rightarrow A,\\qquad\\pi_1(a,b)=a`\n\nDie zweite Projektion wählt entsprechend die zweite Komponente aus:\n\n\\[\n\\pi_2:A\\times B\\rightarrow B,\\qquad\\pi_2(a,b)=b\\tag{M1.69}\n\\]\n\nWord-LaTeX: `\\pi_2:A\\times B\\rightarrow B,\\qquad\\pi_2(a,b)=b`\n\nFür ein allgemeines `(n)`-Tupel kann ich diese Konstruktion fortsetzen:\n\n\\[\n\\pi_i(a_1,\\ldots,a_n)=a_i\\tag{M1.70}\n\\]\n\nWord-LaTeX: `\\pi_i(a_1,\\ldots,a_n)=a_i`\n\nMit diesen Projektionen wird die Positionsstruktur nicht nur in der Schreibweise sichtbar. Jede einzelne Komponente kann durch eine eindeutig bestimmte Funktion wieder aus dem Tupel herausgelöst werden.\n\nFür mich ist diese Eigenschaft besonders wichtig, weil spätere Relationen und mehrstellige Funktionen zusammengesetzte Argumente besitzen können. Die einzelnen Komponenten bleiben trotzdem mathematisch eindeutig adressierbar.\n\n### M1.4.7 Ergebnis und Weitergabestelle\n\nMit den geordneten Paaren ist nun erstmals eine Struktur vorhanden, in der nicht nur der enthaltene Elementbestand, sondern auch die Position einzelner Komponenten mathematisch erhalten bleibt. Das kartesische Produkt `(A\\times B)` fasst sämtliche formal möglichen geordneten Paarungen von Elementen aus `(A)` und `(B)` zu einer neuen Menge zusammen. Die Erweiterung auf Tupel und Produkte `(A_1\\times\\cdots\\times A_n)` ermöglicht entsprechend Strukturen mit mehreren unterscheidbaren Komponenten. [[6]]\n\nFür meinen weiteren Aufbau sind dabei vier Ergebnisse entscheidend. Erstens wird ein geordnetes Paar durch seine beiden positionsabhängigen Komponenten bestimmt. Zweitens ist das kartesische Produkt eine Menge solcher geordneten Paare. Drittens lässt sich diese Konstruktion auf beliebig lange endliche Tupel erweitern. Viertens können die einzelnen Komponenten über Projektionen `(\\pi_i)` wieder eindeutig ausgewählt werden.\n\nDamit steht jetzt genau die mathematische Struktur bereit, die ich für Relationen benötige. Das kartesische Produkt enthält zunächst alle formal möglichen Paare. Eine Relation wird im nächsten Schritt festlegen, **welche** dieser Paare zu einer bestimmten Beziehungsstruktur gehören.\n\nDie **Weitergabestelle M1.4 → M1.5** liegt deshalb bei der Auswahl innerhalb eines kartesischen Produktes. Aufbauend auf `(A\\times B)` führt **M1.5 Relationen und ihre grundlegenden Eigenschaften** eine Relation als Teilmenge dieses Produktes ein und untersucht anschließend, welche zusätzlichen strukturellen Eigenschaften solche Relationen besitzen können.', '7633ec9f4fc611df6bd7dd537b7ac0a7f4b9082585153c81edd98b25503e9343', 'Kanonischer M1.4-Text des neuen Anlagenaufbaus.');
INSERT INTO `appendix_section_versions` (`appendix_section_version_id`, `appendix_section_id`, `revision_id`, `version_kind`, `body_markdown`, `checksum_sha256`, `notes`) VALUES
(6, 6, 18, 'draft', '## M1.5 Relationen und ihre grundlegenden Eigenschaften\n\nMit dem kartesischen Produkt steht mir nun eine Menge aller formal möglichen geordneten Paare zur Verfügung. Für den weiteren Aufbau genügt diese vollständige Paarmenge jedoch noch nicht. Wenn ich eine bestimmte Beziehung zwischen Elementen beschreiben möchte, muss ich aus diesen möglichen Paaren genau diejenigen auswählen, die zu dieser Beziehung gehören. Genau diese Auswahl führt mich zum Relationsbegriff. [[6]]\n\nFür mich ist dabei eine methodische Trennung besonders wichtig. Das kartesische Produkt beschreibt zunächst lediglich, welche Paarungen aufgrund der gewählten Ausgangsmengen überhaupt möglich sind. Eine Relation legt anschließend fest, welche dieser Paarungen tatsächlich zur betrachteten mathematischen Struktur gehören. Aus der bloßen Möglichkeit eines Paares folgt deshalb noch nicht, dass zwischen seinen Komponenten bereits eine ausgezeichnete Beziehung besteht.\n\n### M1.5.1 Relation als Teilmenge eines kartesischen Produktes\n\nSeien `(A)` und `(B)` Mengen. Eine binäre Relation `(R)` von `(A)` nach `(B)` ist eine Teilmenge des kartesischen Produktes `(A\\times B)`.\n\n\\[\nR\\subseteq A\\times B\\tag{M1.71}\n\\]\n\nWord-LaTeX: `R\\subseteq A\\times B`\n\nEin geordnetes Paar `((a,b))` gehört genau dann zur Relation, wenn es Bestandteil dieser ausgewählten Teilmenge ist.\n\n\\[\n(a,b)\\in R\\tag{M1.72}\n\\]\n\nWord-LaTeX: `(a,b)\\in R`\n\nFür die gleiche Aussage verwende ich häufig die kompaktere Relationsschreibweise:\n\n\\[\naRb\\iff(a,b)\\in R\\tag{M1.73}\n\\]\n\nWord-LaTeX: `aRb\\iff(a,b)\\in R`\n\nDie Schreibweise `(aRb)` fügt der Relation keine neue mathematische Eigenschaft hinzu. Sie ist lediglich eine verkürzte Darstellung der Paarzugehörigkeit `((a,b)\\in R)`.\n\nDiese Definition lässt ausdrücklich offen, wie viele Beziehungen zu einem bestimmten Ausgangselement bestehen. Zu einem `(a\\in A)` kann kein Element von `(B)`, genau ein Element oder eine beliebige Anzahl von Elementen in Relation stehen. Eine Relation enthält deshalb noch keine Funktionsbedingung.\n\n### M1.5.2 Definitionsbereich und Wertebereich einer Relation\n\nObwohl eine Relation als Teilmenge von `(A\\times B)` definiert ist, müssen nicht sämtliche Elemente von `(A)` tatsächlich als erste Komponente eines Relationspaares auftreten. Ebenso müssen nicht sämtliche Elemente von `(B)` tatsächlich als zweite Komponente vorkommen.\n\nDen tatsächlichen Definitionsbereich einer Relation beschreibe ich deshalb durch:\n\n\\[\n\\operatorname{dom}(R)=\\left\\{a\\in A\\mid\\exists b\\in B:(a,b)\\in R\\right\\}\\tag{M1.74}\n\\]\n\nWord-LaTeX: `\\operatorname{dom}(R)=\\left\\{a\\in A\\mid\\exists b\\in B:(a,b)\\in R\\right\\}`\n\nDen tatsächlich auftretenden Wertebereich der zweiten Komponenten definiere ich entsprechend als:\n\n\\[\n\\operatorname{ran}(R)=\\left\\{b\\in B\\mid\\exists a\\in A:(a,b)\\in R\\right\\}\\tag{M1.75}\n\\]\n\nWord-LaTeX: `\\operatorname{ran}(R)=\\left\\{b\\in B\\mid\\exists a\\in A:(a,b)\\in R\\right\\}`\n\nDamit gilt unmittelbar:\n\n\\[\n\\operatorname{dom}(R)\\subseteq A\\tag{M1.76}\n\\]\n\nWord-LaTeX: `\\operatorname{dom}(R)\\subseteq A`\n\nund\n\n\\[\n\\operatorname{ran}(R)\\subseteq B\\tag{M1.77}\n\\]\n\nWord-LaTeX: `\\operatorname{ran}(R)\\subseteq B`\n\nFür mich ist diese Unterscheidung wichtig, weil bereits hier dieselbe Struktur sichtbar wird, die später beim Funktionsbegriff zwischen formal vorgegebenem Zielbereich und tatsächlich angenommenen Werten wiederkehrt.\n\n### M1.5.3 Relationen auf einer Menge\n\nViele strukturelle Eigenschaften von Relationen lassen sich besonders klar untersuchen, wenn Ausgangs- und Zielmenge identisch sind. Ich betrachte dafür eine Relation `(R)` auf `(A)`.\n\n\\[\nR\\subseteq A\\times A\\tag{M1.78}\n\\]\n\nWord-LaTeX: `R\\subseteq A\\times A`\n\nErst in dieser Situation kann ich Eigenschaften wie Reflexivität, Symmetrie oder Transitivität sinnvoll als Beziehungen zwischen Elementen derselben Menge formulieren.\n\n### M1.5.4 Reflexivität und Irreflexivität\n\nEine Relation `(R)` auf `(A)` heißt reflexiv, wenn jedes Element zu sich selbst in Relation steht.\n\n\\[\n\\forall a\\in A:(a,a)\\in R\\tag{M1.79}\n\\]\n\nWord-LaTeX: `\\forall a\\in A:(a,a)\\in R`\n\nReflexivität verlangt damit nicht nur die Existenz einzelner Selbstbeziehungen. Sie fordert sie für jedes Element des betrachteten Bereichs.\n\nDemgegenüber heißt `(R)` irreflexiv, wenn kein Element zu sich selbst in Relation steht.\n\n\\[\n\\forall a\\in A:(a,a)\\notin R\\tag{M1.80}\n\\]\n\nWord-LaTeX: `\\forall a\\in A:(a,a)\\notin R`\n\nReflexivität und Irreflexivität sind damit unterschiedliche globale Anforderungen an die Diagonale des kartesischen Produktes `(A\\times A)`.\n\n### M1.5.5 Symmetrie, Antisymmetrie und Asymmetrie\n\nEine Relation ist symmetrisch, wenn mit jedem Paar auch das vertauschte Paar zur Relation gehört.\n\n\\[\n\\forall a,b\\in A:\\left((a,b)\\in R\\Longrightarrow(b,a)\\in R\\right)\\tag{M1.81}\n\\]\n\nWord-LaTeX: `\\forall a,b\\in A:\\left((a,b)\\in R\\Longrightarrow(b,a)\\in R\\right)`\n\nFür mich bedeutet Symmetrie damit nicht, dass `(a)` und `(b)` gleich sein müssen. Sie verlangt lediglich, dass eine vorhandene Beziehung in beiden Richtungen besteht.\n\nEine andere Eigenschaft ist die Antisymmetrie. Eine Relation heißt antisymmetrisch, wenn Beziehungen in beide Richtungen nur für identische Elemente auftreten können.\n\n\\[\n\\forall a,b\\in A:\\left((a,b)\\in R\\land(b,a)\\in R\\Longrightarrow a=b\\right)\\tag{M1.82}\n\\]\n\nWord-LaTeX: `\\forall a,b\\in A:\\left((a,b)\\in R\\land(b,a)\\in R\\Longrightarrow a=b\\right)`\n\nAntisymmetrie ist deshalb nicht das Gegenteil von Symmetrie. Eine Relation kann unter geeigneten Umständen sogar beide Eigenschaften gleichzeitig besitzen.\n\nStrenger ist die Asymmetrie. Besteht die Relation von `(a)` nach `(b)`, darf die umgekehrte Relation nicht gleichzeitig bestehen.\n\n\\[\n\\forall a,b\\in A:\\left((a,b)\\in R\\Longrightarrow(b,a)\\notin R\\right)\\tag{M1.83}\n\\]\n\nWord-LaTeX: `\\forall a,b\\in A:\\left((a,b)\\in R\\Longrightarrow(b,a)\\notin R\\right)`\n\nAus der Asymmetrie folgt unmittelbar die Irreflexivität.\n\n\\[\nR\\ \\mathrm{asymmetrisch}\\Longrightarrow R\\ \\mathrm{irreflexiv}\\tag{M1.84}\n\\]\n\nWord-LaTeX: `R\\ \\mathrm{asymmetrisch}\\Longrightarrow R\\ \\mathrm{irreflexiv}`\n\nDenn würde `((a,a)\\in R)` gelten, verlangte die Asymmetrie zugleich `((a,a)\\notin R)`. Damit wäre die Relationsbedingung widersprüchlich.\n\n### M1.5.6 Transitivität\n\nEine Relation ist transitiv, wenn eine Beziehung von `(a)` nach `(b)` und eine Beziehung von `(b)` nach `(c)` gemeinsam eine Beziehung von `(a)` nach `(c)` erzwingen.\n\n\\[\n\\forall a,b,c\\in A:\\left((a,b)\\in R\\land(b,c)\\in R\\Longrightarrow(a,c)\\in R\\right)\\tag{M1.85}\n\\]\n\nWord-LaTeX: `\\forall a,b,c\\in A:\\left((a,b)\\in R\\land(b,c)\\in R\\Longrightarrow(a,c)\\in R\\right)`\n\nFür mich ist wichtig, dass Transitivität keine konkrete Aussage darüber trifft, **warum** eine solche Beziehung besteht. Sie bezeichnet ausschließlich eine formale Schließungseigenschaft der Relation.\n\n### M1.5.7 Äquivalenzrelationen und Äquivalenzklassen\n\nBestimmte Kombinationen der bisher eingeführten Eigenschaften erzeugen besonders wichtige Relationsstrukturen. Eine Äquivalenzrelation ist eine Relation, die reflexiv, symmetrisch und transitiv ist.\n\n\\[\nR\\ \\mathrm{Äquivalenzrelation}\\iff R\\ \\mathrm{reflexiv}\\land R\\ \\mathrm{symmetrisch}\\land R\\ \\mathrm{transitiv}\\tag{M1.86}\n\\]\n\nWord-LaTeX: `R\\ \\mathrm{Äquivalenzrelation}\\iff R\\ \\mathrm{reflexiv}\\land R\\ \\mathrm{symmetrisch}\\land R\\ \\mathrm{transitiv}`\n\nZu einem Element `(a\\in A)` kann ich dann seine Äquivalenzklasse bilden.\n\n\\[\n[a]_R=\\left\\{x\\in A\\mid(x,a)\\in R\\right\\}\\tag{M1.87}\n\\]\n\nWord-LaTeX: `[a]_R=\\left\\{x\\in A\\mid(x,a)\\in R\\right\\}`\n\nDie Äquivalenzklasse enthält genau diejenigen Elemente, die bezüglich `(R)` zu `(a)` äquivalent sind.\n\nEine charakteristische Eigenschaft solcher Klassen besteht darin, dass zwei Äquivalenzklassen entweder identisch beziehungsweise überlappend identisch sind oder keinen gemeinsamen Bestandteil besitzen. Ich kann dies kompakt schreiben als:\n\n\\[\n[a]_R=[b]_R\\lor[a]_R\\cap[b]_R=\\varnothing\\tag{M1.88}\n\\]\n\nWord-LaTeX: `[a]_R=[b]_R\\lor[a]_R\\cap[b]_R=\\varnothing`\n\nDie Gesamtheit aller Äquivalenzklassen bildet die Quotientenmenge:\n\n\\[\nA/R=\\left\\{[a]_R\\mid a\\in A\\right\\}\\tag{M1.89}\n\\]\n\nWord-LaTeX: `A/R=\\left\\{[a]_R\\mid a\\in A\\right\\}`\n\nDamit wird erneut eine neue Mengenebene sichtbar. Die Elemente von `(A/R)` sind nicht mehr die ursprünglichen Elemente von `(A)`, sondern Äquivalenzklassen, also selbst wieder Mengen.\n\n### M1.5.8 Ordnungsrelationen\n\nEine andere wichtige Kombination entsteht aus Reflexivität, Antisymmetrie und Transitivität. Erfüllt eine Relation diese drei Eigenschaften, liegt eine partielle Ordnung vor.\n\n\\[\nR\\ \\mathrm{partielle\\ Ordnung}\\iff R\\ \\mathrm{reflexiv}\\land R\\ \\mathrm{antisymmetrisch}\\land R\\ \\mathrm{transitiv}\\tag{M1.90}\n\\]\n\nWord-LaTeX: `R\\ \\mathrm{partielle\\ Ordnung}\\iff R\\ \\mathrm{reflexiv}\\land R\\ \\mathrm{antisymmetrisch}\\land R\\ \\mathrm{transitiv}`\n\nDie Bezeichnung „partiell“ ist für mich dabei wesentlich. Nicht jedes Paar verschiedener Elemente muss miteinander vergleichbar sein.\n\nWird zusätzlich verlangt, dass für jedes Paar `(a,b)` mindestens eine der beiden Richtungen gilt, erhält man eine totale beziehungsweise lineare Ordnung.\n\n\\[\n\\forall a,b\\in A:\\left((a,b)\\in R\\lor(b,a)\\in R\\right)\\tag{M1.91}\n\\]\n\nWord-LaTeX: `\\forall a,b\\in A:\\left((a,b)\\in R\\lor(b,a)\\in R\\right)`\n\nDiese zusätzliche Vergleichbarkeitsbedingung unterscheidet die totale Ordnung von der allgemeinen partiellen Ordnung.\n\n### M1.5.9 Umkehrrelation\n\nDa Relationen auf geordneten Paaren beruhen, kann ich die Reihenfolge der Komponenten systematisch vertauschen. Zu einer Relation `(R\\subseteq A\\times B)` definiere ich die Umkehrrelation `(R^{-1})` durch:\n\n\\[\nR^{-1}=\\left\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\right\\}\\tag{M1.92}\n\\]\n\nWord-LaTeX: `R^{-1}=\\left\\{(b,a)\\in B\\times A\\mid(a,b)\\in R\\right\\}`\n\nDamit gilt:\n\n\\[\n(a,b)\\in R\\iff(b,a)\\in R^{-1}\\tag{M1.93}\n\\]\n\nWord-LaTeX: `(a,b)\\in R\\iff(b,a)\\in R^{-1}`\n\nWende ich diese Umkehrung zweimal an, erhalte ich wieder die Ausgangsrelation.\n\n\\[\n\\left(R^{-1}\\right)^{-1}=R\\tag{M1.94}\n\\]\n\nWord-LaTeX: `\\left(R^{-1}\\right)^{-1}=R`\n\nFür mich ist hier bereits eine wichtige Grenze sichtbar: Eine Umkehrrelation existiert für jede Relation. Das bedeutet noch nicht, dass später auch jede Funktion eine Umkehrfunktion besitzt. Die Umkehrfunktion wird eine wesentlich stärkere Eindeutigkeitsbedingung benötigen.\n\n### M1.5.10 Komposition von Relationen\n\nRelationen können schließlich miteinander verkettet werden. Sei `(R\\subseteq A\\times B)` und `(S\\subseteq B\\times C)`. Dann definiere ich die Komposition `(S\\circ R)` durch:\n\n\\[\nS\\circ R=\\left\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\left((a,b)\\in R\\land(b,c)\\in S\\right)\\right\\}\\tag{M1.95}\n\\]\n\nWord-LaTeX: `S\\circ R=\\left\\{(a,c)\\in A\\times C\\mid\\exists b\\in B:\\left((a,b)\\in R\\land(b,c)\\in S\\right)\\right\\}`\n\nDie Reihenfolge in `(S\\circ R)` halte ich bewusst fest. Zunächst wird die Beziehung `(R)` von `(A)` nach `(B)` verwendet und anschließend `(S)` von `(B)` nach `(C)`.\n\nIm Allgemeinen darf ich die Reihenfolge nicht vertauschen. Selbst wenn beide Kompositionen formal definiert sind, müssen sie nicht dieselbe Relation ergeben.\n\nFür drei zueinander passende Relationen bleibt dagegen die Klammerung ohne Einfluss auf das Ergebnis.\n\n\\[\nT\\circ(S\\circ R)=(T\\circ S)\\circ R\\tag{M1.96}\n\\]\n\nWord-LaTeX: `T\\circ(S\\circ R)=(T\\circ S)\\circ R`\n\nDie Relationskomposition ist damit assoziativ. [[6]]\n\n### M1.5.11 Ergebnis und Weitergabestelle\n\nMit dem Relationsbegriff kann ich jetzt aus dem vollständigen Möglichkeitsraum eines kartesischen Produktes diejenigen geordneten Paare auswählen, die eine bestimmte mathematische Beziehungsstruktur bilden. Die Relation `(R\\subseteq A\\times B)` enthält dabei noch keinerlei Forderung, dass zu jedem Ausgangselement genau ein Zielelement gehören muss. Gerade diese Offenheit unterscheidet sie von der Funktion.\n\nFür meinen weiteren Aufbau sind besonders fünf Ergebnisse wichtig. Erstens ist eine Relation selbst eine Menge geordneter Paare. Zweitens können Definitions- und Wertebereich einer Relation kleiner sein als die Mengen, zwischen denen die Relation ursprünglich betrachtet wird. Drittens beschreiben Reflexivität, Symmetrie, Antisymmetrie, Asymmetrie und Transitivität unterschiedliche strukturelle Eigenschaften einer Relation. Viertens erzeugen besondere Kombinationen dieser Eigenschaften Äquivalenz- und Ordnungsrelationen. Fünftens lassen sich Relationen umkehren und miteinander komponieren, ohne dass dadurch bereits die strengere Struktur einer Funktion entsteht.\n\nGenau an dieser Stelle erreiche ich die Grenze des allgemeinen Relationsbegriffs. Für eine eindeutige mathematische Zuordnung muss ich nun zusätzlich verlangen, dass **jedem zulässigen Ausgangselement genau ein Zielelement zugeordnet wird**.\n\nDie **Weitergabestelle M1.5 → M1.6** liegt deshalb bei dieser zusätzlichen Existenz- und Eindeutigkeitsforderung. **M1.6 Funktionen als eindeutig bestimmte Relationen** übernimmt den Relationsbegriff und ergänzt ihn genau um die Bedingungen, durch die aus einer allgemeinen Relation eine Funktion entsteht.', '4684760a2895c9c10814d4925586adf18480a9b2fceb7659857f9da1a17cafcc', 'Kanonischer M1.5-Text des neuen Anlagenaufbaus.'),
(7, 7, 19, 'draft', '## M1.6 Funktionen als eindeutig bestimmte Relationen\n\nMit dem Relationsbegriff kann ich beliebige ausgewählte Paarungen zwischen zwei Mengen beschreiben. Für viele spätere mathematische Konstruktionen genügt mir diese Offenheit jedoch nicht. Sobald ein Ausgangselement eindeutig weiterverarbeitet werden soll, muss festgelegt sein, welches Zielelement ihm zugeordnet wird. Genau an dieser Stelle ergänze ich die Relation um eine Existenz- und eine Eindeutigkeitsbedingung. Dadurch entsteht der Funktionsbegriff. [[6]]\n\nFür mich ist wichtig, diesen Übergang nicht als Wechsel zu einem völlig neuen mathematischen Objekt zu verstehen. Eine Funktion kann weiterhin über ihren Graphen als Relation beschrieben werden. Neu ist ausschließlich, dass für jedes zulässige Argument genau ein zugeordnetes Ergebnis existieren muss.\n\n### M1.6.1 Graph einer Funktion\n\nSeien `(A)` und `(B)` Mengen. Zu einer Funktion `(f:A\\rightarrow B)` kann ich ihren Graphen `(G_f)` als Teilmenge des kartesischen Produktes `(A\\times B)` auffassen.\n\n\\[\nG_f\\subseteq A\\times B\\tag{M1.97}\n\\]\n\nWord-LaTeX: `G_f\\subseteq A\\times B`\n\nDamit bleibt der Funktionsgraph zunächst eine Relation. Die zusätzliche Funktionsbedingung lautet jedoch:\n\n\\[\n\\forall a\\in A\\ \\exists!b\\in B:(a,b)\\in G_f\\tag{M1.98}\n\\]\n\nWord-LaTeX: `\\forall a\\in A\\ \\exists!b\\in B:(a,b)\\in G_f`\n\nDas Eindeutigkeitssymbol `(\\exists!)` fasst für mich zwei unterschiedliche Aussagen zusammen. Erstens muss zu jedem `(a\\in A)` mindestens ein `(b\\in B)` existieren. Zweitens darf es zu demselben `(a)` nicht zwei verschiedene Funktionswerte geben.\n\nDie Existenzforderung kann ich getrennt schreiben als:\n\n\\[\n\\forall a\\in A\\ \\exists b\\in B:(a,b)\\in G_f\\tag{M1.99}\n\\]\n\nWord-LaTeX: `\\forall a\\in A\\ \\exists b\\in B:(a,b)\\in G_f`\n\nDie Eindeutigkeitsforderung lautet entsprechend:\n\n\\[\n\\forall a\\in A\\ \\forall b_1,b_2\\in B:\\left((a,b_1)\\in G_f\\land(a,b_2)\\in G_f\\Longrightarrow b_1=b_2\\right)\\tag{M1.100}\n\\]\n\nWord-LaTeX: `\\forall a\\in A\\ \\forall b_1,b_2\\in B:\\left((a,b_1)\\in G_f\\land(a,b_2)\\in G_f\\Longrightarrow b_1=b_2\\right)`\n\nGerade diese Trennung ist für mich wesentlich. Eine Relation kann die Existenzbedingung erfüllen, aber dennoch mehreren Zielwerten zugeordnet sein. Ebenso kann eine Relation lokal eindeutig sein, aber für bestimmte Ausgangselemente überhaupt kein Ziel besitzen. Erst beide Bedingungen gemeinsam erzeugen die Funktion auf dem vollständigen Definitionsbereich `(A)`.\n\n### M1.6.2 Funktionsschreibweise\n\nDie übliche Funktionsschreibweise fasst Definitions- und Zielbereich kompakt zusammen:\n\n\\[\nf:A\\rightarrow B\\tag{M1.101}\n\\]\n\nWord-LaTeX: `f:A\\rightarrow B`\n\nDabei bezeichnet `(A)` den Definitionsbereich und `(B)` den Zielbereich.\n\nDie Zuordnung eines einzelnen Arguments schreibe ich als:\n\n\\[\na\\mapsto f(a)\\tag{M1.102}\n\\]\n\nWord-LaTeX: `a\\mapsto f(a)`\n\nDamit ist `(f(a))` der eindeutig bestimmte Funktionswert zum Argument `(a)`.\n\nDer Graph der Funktion kann nun explizit aus dieser Zuordnung aufgebaut werden:\n\n\\[\nG_f=\\left\\{(a,f(a))\\mid a\\in A\\right\\}\\tag{M1.103}\n\\]\n\nWord-LaTeX: `G_f=\\left\\{(a,f(a))\\mid a\\in A\\right\\}`\n\nZwischen Graphschreibweise und Funktionswert besteht damit die Äquivalenz:\n\n\\[\n(a,b)\\in G_f\\iff f(a)=b\\tag{M1.104}\n\\]\n\nWord-LaTeX: `(a,b)\\in G_f\\iff f(a)=b`\n\nFür mich ist damit die Verbindung zur Relation vollständig erhalten. Die Funktion ist nicht von der mengentheoretischen Struktur abgelöst, sondern wird durch eine besonders eingeschränkte Relationsform beschrieben. [[6]]\n\n### M1.6.3 Definitionsbereich, Zielbereich und Bild\n\nFür eine vollständig definierte Funktion `(f:A\\rightarrow B)` ist der Definitionsbereich gerade `(A)`.\n\n\\[\n\\operatorname{dom}(f)=A\\tag{M1.105}\n\\]\n\nWord-LaTeX: `\\operatorname{dom}(f)=A`\n\nDer Zielbereich gehört ebenfalls zur Festlegung der Funktion:\n\n\\[\n\\operatorname{cod}(f)=B\\tag{M1.106}\n\\]\n\nWord-LaTeX: `\\operatorname{cod}(f)=B`\n\nDavon unterscheide ich ausdrücklich die tatsächlich angenommene Bildmenge.\n\n\\[\n\\operatorname{im}(f)=\\left\\{f(a)\\mid a\\in A\\right\\}\\tag{M1.107}\n\\]\n\nWord-LaTeX: `\\operatorname{im}(f)=\\left\\{f(a)\\mid a\\in A\\right\\}`\n\nFür jede Funktion gilt deshalb:\n\n\\[\n\\operatorname{im}(f)\\subseteq B\\tag{M1.108}\n\\]\n\nWord-LaTeX: `\\operatorname{im}(f)\\subseteq B`\n\nDiese Unterscheidung ist für den weiteren Aufbau wichtig. Der Zielbereich `(B)` wird mit der Funktion festgelegt. Die Bildmenge `(\\operatorname{im}(f))` ergibt sich dagegen erst aus den tatsächlich angenommenen Funktionswerten. Beide Mengen müssen deshalb nicht identisch sein.\n\n### M1.6.4 Eindeutigkeit betrifft den Ausgangswert\n\nDie Eindeutigkeitsforderung des Funktionsbegriffs bezieht sich auf jedes einzelne Argument. Für ein festes `(a)` können nicht zwei verschiedene Funktionswerte auftreten.\n\n\\[\nf(a)=b_1\\land f(a)=b_2\\Longrightarrow b_1=b_2\\tag{M1.109}\n\\]\n\nWord-LaTeX: `f(a)=b_1\\land f(a)=b_2\\Longrightarrow b_1=b_2`\n\nAus unterschiedlichen Argumenten folgt dagegen zunächst noch nicht, dass unterschiedliche Funktionswerte entstehen müssen.\n\nIch halte diese Aussage bewusst ohne Negationspfeil fest, weil die Funktionsdefinition lediglich Eindeutigkeit **für dasselbe Argument** fordert. Es ist daher durchaus möglich, dass für `(a_1\\neq a_2)` trotzdem `(f(a_1)=f(a_2))` gilt.\n\nGenau diese noch offene Eigenschaft wird später durch die Injektivität zusätzlich eingeschränkt.\n\n### M1.6.5 Gleichheit von Funktionen\n\nAuch bei Funktionen möchte ich zwischen Bezeichnung und mathematischer Identität unterscheiden. Zwei Funktionen sind nicht schon deshalb gleich, weil sie dieselbe Zuordnungsvorschrift in einer bestimmten Schreibweise verwenden. Für die Gleichheit müssen ihre vollständigen strukturellen Bestandteile übereinstimmen.\n\nSind Definitionsbereich und Zielbereich bereits gemeinsam festgelegt, genügt:\n\n\\[\nf=g\\iff\\forall a\\in A:f(a)=g(a)\\tag{M1.110}\n\\]\n\nWord-LaTeX: `f=g\\iff\\forall a\\in A:f(a)=g(a)`\n\nIn der vollständig expliziten Form schreibe ich:\n\n\\[\nf=g\\iff\\operatorname{dom}(f)=\\operatorname{dom}(g)\\land\\operatorname{cod}(f)=\\operatorname{cod}(g)\\land\\forall a\\in\\operatorname{dom}(f):f(a)=g(a)\\tag{M1.111}\n\\]\n\nWord-LaTeX: `f=g\\iff\\operatorname{dom}(f)=\\operatorname{dom}(g)\\land\\operatorname{cod}(f)=\\operatorname{cod}(g)\\land\\forall a\\in\\operatorname{dom}(f):f(a)=g(a)`\n\nDamit bleibt auch beim Funktionsbegriff die extensionale Grundidee erhalten: Entscheidend ist die vollständige mathematische Struktur und nicht allein ihre Benennung.\n\n### M1.6.6 Einschränkung einer Funktion\n\nHäufig möchte ich eine bereits definierte Funktion nur auf einem Teil ihres Definitionsbereiches betrachten. Sei deshalb `(C\\subseteq A)`. Die Einschränkung von `(f)` auf `(C)` bezeichne ich mit `(f|_C)`.\n\n\\[\nf|_C:C\\rightarrow B\\tag{M1.112}\n\\]\n\nWord-LaTeX: `f|_C:C\\rightarrow B`\n\nFür jedes `(c\\in C)` gilt:\n\n\\[\nf|_C(c)=f(c)\\tag{M1.113}\n\\]\n\nWord-LaTeX: `f|_C(c)=f(c)`\n\nDer Graph der eingeschränkten Funktion ist damit:\n\n\\[\nG_{f|_C}=\\left\\{(c,f(c))\\mid c\\in C\\right\\}\\tag{M1.114}\n\\]\n\nWord-LaTeX: `G_{f|_C}=\\left\\{(c,f(c))\\mid c\\in C\\right\\}`\n\nDie Einschränkung verändert also nicht die Zuordnung auf den verbleibenden Elementen. Sie verändert lediglich den betrachteten Definitionsbereich.\n\n### M1.6.7 Identitätsfunktion\n\nEine besonders einfache Funktion ist die Identitätsfunktion auf `(A)`.\n\n\\[\n\\operatorname{id}_A:A\\rightarrow A\\tag{M1.115}\n\\]\n\nWord-LaTeX: `\\operatorname{id}_A:A\\rightarrow A`\n\nSie ordnet jedem Element sich selbst zu.\n\n\\[\n\\operatorname{id}_A(a)=a\\tag{M1.116}\n\\]\n\nWord-LaTeX: `\\operatorname{id}_A(a)=a`\n\nIhr Graph besteht deshalb genau aus den Paaren mit identischen Komponenten:\n\n\\[\nG_{\\operatorname{id}_A}=\\left\\{(a,a)\\mid a\\in A\\right\\}\\tag{M1.117}\n\\]\n\nWord-LaTeX: `G_{\\operatorname{id}_A}=\\left\\{(a,a)\\mid a\\in A\\right\\}`\n\nDiese Funktion wird später bei der Funktionskomposition und bei inversen Funktionen eine zentrale Rolle übernehmen.\n\n### M1.6.8 Menge aller Funktionen\n\nDa Funktionen selbst mathematische Objekte sind, kann ich sie wiederum zu Mengen zusammenfassen. Die Menge aller Funktionen von `(A)` nach `(B)` bezeichne ich mit `(B^A)`.\n\n\\[\nB^A=\\left\\{f\\mid f:A\\rightarrow B\\right\\}\\tag{M1.118}\n\\]\n\nWord-LaTeX: `B^A=\\left\\{f\\mid f:A\\rightarrow B\\right\\}`\n\nDamit gilt:\n\n\\[\nf\\in B^A\\iff f:A\\rightarrow B\\tag{M1.119}\n\\]\n\nWord-LaTeX: `f\\in B^A\\iff f:A\\rightarrow B`\n\nHier wird erneut die Ebenenstruktur aus M1.1 sichtbar. Die Elemente von `(B^A)` sind selbst Funktionen.\n\nFür endliche Mengen lässt sich auch die Anzahl dieser Funktionen bestimmen. Besitzt `(A)` genau `(m)` Elemente und `(B)` genau `(n)` Elemente, dann gilt:\n\n\\[\n\\left|A\\right|=m\\land\\left|B\\right|=n\\Longrightarrow\\left|B^A\\right|=n^m\\tag{M1.120}\n\\]\n\nWord-LaTeX: `\\left|A\\right|=m\\land\\left|B\\right|=n\\Longrightarrow\\left|B^A\\right|=n^m`\n\nDer Grund liegt darin, dass für jedes der `(m)` Argumente unabhängig einer von `(n)` möglichen Funktionswerten gewählt werden kann. [[6]]\n\n### M1.6.9 Methodische Grenze des Funktionsbegriffs\n\nMit `(f:A\\rightarrow B)` habe ich jetzt eine eindeutige mathematische Zuordnung. Mehr folgt aus dieser Schreibweise zunächst nicht.\n\nEine Funktion besitzt allein aufgrund ihrer Definition keine zeitliche Richtung, keine Kausalität und keine physikalische Dynamik. Ebenso muss `(A)` kein Zustandsraum und `(B)` kein Ergebnisraum eines realen Prozesses sein. Der Pfeil `(\\rightarrow)` bezeichnet hier ausschließlich die Richtung der mathematischen Zuordnung vom Definitions- zum Zielbereich.\n\nFür mich ist diese Grenze wesentlich, weil die Funktionsnotation sehr leicht eine stärkere Interpretation nahelegt, als die Mathematik tatsächlich liefert. Eine solche Bedeutung soll später nur dort entstehen, wo zusätzliche theoretische Voraussetzungen ausdrücklich eingeführt werden.\n\n### M1.6.10 Ergebnis und Weitergabestelle\n\nMit dem Funktionsbegriff habe ich die allgemeine Relation um genau zwei Bedingungen erweitert: vollständige Existenz auf dem Definitionsbereich und Eindeutigkeit des Funktionswertes. Der Graph `(G_f)` bleibt eine Teilmenge von `(A\\times B)`, besitzt aber nun für jedes `(a\\in A)` genau ein zugeordnetes `(b\\in B)`.\n\nFür meinen weiteren Aufbau sind insbesondere fünf Ergebnisse wichtig. Erstens kann eine Funktion als eindeutig bestimmte Relation verstanden werden. Zweitens müssen Definitionsbereich, Zielbereich und Bildmenge voneinander getrennt bleiben. Drittens bezieht sich die Funktionsbedingung nur auf die eindeutige Zuordnung eines Ergebnisses zu einem gegebenen Argument. Viertens können Funktionen eingeschränkt und selbst wieder als Elemente von Funktionsmengen behandelt werden. Fünftens besitzt die Identitätsfunktion eine besondere neutrale Struktur, die später bei Komposition und Umkehrung benötigt wird.\n\nNoch ist damit nicht entschieden, ob verschiedene Argumente auch verschiedene Funktionswerte besitzen oder ob der gesamte Zielbereich tatsächlich erreicht wird. Diese beiden Fragen benötigen zusätzliche Eigenschaften.\n\nDie **Weitergabestelle M1.6 → M1.7** liegt deshalb bei der Unterscheidung von **Injektivität, Surjektivität und Bijektivität**. M1.7 untersucht, unter welchen zusätzlichen Bedingungen verschiedene Ausgangselemente unterscheidbar bleiben, der vollständige Zielbereich erreicht wird und schließlich eine eindeutig bestimmte Umkehrfunktion existiert.\n', '00d09ac9a236de1e354e7e954414b1742e45e23abf19776d837b5ea032ac422c', 'Kanonischer M1.6-Text des neuen Anlagenaufbaus.'),
(8, 8, 20, 'draft', '## M1.7 Injektivität, Surjektivität und Bijektivität\n\nMit der Funktionsdefinition ist festgelegt, dass jedem Element des Definitionsbereichs genau ein Funktionswert zugeordnet wird. Damit ist die Zuordnung in Vorwärtsrichtung eindeutig. Für meinen weiteren Aufbau reicht diese Eigenschaft jedoch noch nicht aus. Ich muss zusätzlich unterscheiden können, ob verschiedene Ausgangselemente auch verschiedene Ergebnisse besitzen, ob der gesamte Zielbereich tatsächlich erreicht wird und unter welchen Bedingungen eine eindeutige Umkehrung möglich ist. Genau diese drei Fragen führen zu Injektivität, Surjektivität und Bijektivität. [[6]]\n\nFür mich ist dabei wichtig, diese Eigenschaften nicht als Varianten derselben Aussage zu behandeln. Injektivität betrifft die Unterscheidbarkeit der Ausgangselemente anhand ihrer Funktionswerte. Surjektivität betrifft die vollständige Abdeckung des Zielbereichs. Erst die Bijektivität verbindet beide Eigenschaften.\n\n### M1.7.1 Injektivität\n\nSei `(f:A\\rightarrow B)` eine Funktion. Ich bezeichne `(f)` als injektiv, wenn gleiche Funktionswerte nur von gleichen Argumenten stammen können.\n\n\\[\n\\forall a_1,a_2\\in A:\\left(f(a_1)=f(a_2)\\Longrightarrow a_1=a_2\\right)\\tag{M1.121}\n\\]\n\nWord-LaTeX: `\\forall a_1,a_2\\in A:\\left(f(a_1)=f(a_2)\\Longrightarrow a_1=a_2\\right)`\n\nFür mich ist diese Form besonders klar, weil sie direkt die Rückschlussrichtung ausdrückt. Wenn zwei Funktionswerte übereinstimmen, müssen bereits die zugehörigen Argumente identisch gewesen sein.\n\nÄquivalent dazu kann ich die Injektivität auch in kontrapositiver Form beschreiben:\n\n\\[\n\\forall a_1,a_2\\in A:\\left(a_1\\neq a_2\\Longrightarrow f(a_1)\\neq f(a_2)\\right)\\tag{M1.122}\n\\]\n\nWord-LaTeX: `\\forall a_1,a_2\\in A:\\left(a_1\\neq a_2\\Longrightarrow f(a_1)\\neq f(a_2)\\right)`\n\nDamit wird die Bedeutung der Injektivität unmittelbar sichtbar: Verschiedene Ausgangselemente bleiben durch ihre Funktionswerte unterscheidbar.\n\nIst eine Funktion nicht injektiv, existieren dagegen mindestens zwei verschiedene Argumente mit demselben Funktionswert.\n\n\\[\n\\exists a_1,a_2\\in A:\\left(a_1\\neq a_2\\land f(a_1)=f(a_2)\\right)\\tag{M1.123}\n\\]\n\nWord-LaTeX: `\\exists a_1,a_2\\in A:\\left(a_1\\neq a_2\\land f(a_1)=f(a_2)\\right)`\n\nIch möchte diese mathematische Aussage bewusst nicht stärker interpretieren. Aus fehlender Injektivität folgt zunächst nur, dass eine eindeutige Rückzuordnung vom Funktionswert zum ursprünglichen Argument nicht möglich ist. Ob dies in einer späteren Anwendung als Informationsverlust zu deuten wäre, ist keine Aussage der Funktionstheorie selbst.\n\n### M1.7.2 Surjektivität\n\nDie Surjektivität beantwortet eine andere Frage. Hier untersuche ich nicht, ob verschiedene Argumente voneinander unterscheidbar bleiben, sondern ob jedes Element des Zielbereichs tatsächlich als Funktionswert auftritt.\n\nEine Funktion `(f:A\\rightarrow B)` heißt surjektiv, wenn zu jedem `(b\\in B)` mindestens ein `(a\\in A)` existiert, das auf `(b)` abgebildet wird.\n\n\\[\n\\forall b\\in B\\ \\exists a\\in A:f(a)=b\\tag{M1.124}\n\\]\n\nWord-LaTeX: `\\forall b\\in B\\ \\exists a\\in A:f(a)=b`\n\nMit der in M1.6 eingeführten Bildmenge kann ich dieselbe Eigenschaft besonders kompakt ausdrücken.\n\n\\[\nf\\ \\mathrm{surjektiv}\\iff\\operatorname{im}(f)=B\\tag{M1.125}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{surjektiv}\\iff\\operatorname{im}(f)=B`\n\nDiese Beziehung zeigt für mich sehr deutlich, warum Zielbereich und Bildmenge voneinander getrennt werden müssen. Der Zielbereich `(B)` wird bereits bei der Definition der Funktion festgelegt. Die Surjektivität beantwortet erst anschließend die Frage, ob sämtliche Elemente dieses Zielbereichs tatsächlich erreicht werden.\n\nIst `(f)` nicht surjektiv, bleibt mindestens ein Element des Zielbereichs ohne Urbild.\n\n\\[\n\\exists b\\in B\\ \\forall a\\in A:f(a)\\neq b\\tag{M1.126}\n\\]\n\nWord-LaTeX: `\\exists b\\in B\\ \\forall a\\in A:f(a)\\neq b`\n\nAuch hier bleibt die Aussage vollständig mathematisch. Ein Element des Zielbereichs, das nicht im Bild liegt, ist im Sinne dieser Funktion nicht erreicht. Daraus folgt noch keine Aussage über physikalische oder reale Erreichbarkeit.\n\n### M1.7.3 Unabhängigkeit von Injektivität und Surjektivität\n\nInjektivität und Surjektivität beschreiben unterschiedliche Eigenschaften und können unabhängig voneinander auftreten.\n\nEine Funktion kann injektiv sein, ohne surjektiv zu sein. Dann werden verschiedene Ausgangselemente auf verschiedene Werte abgebildet, aber nicht alle Elemente des Zielbereichs erreicht.\n\nEbenso kann eine Funktion surjektiv sein, ohne injektiv zu sein. Dann wird zwar jedes Element des Zielbereichs erreicht, aber mindestens ein Funktionswert besitzt mehrere verschiedene Urbilder.\n\nFür mich ist diese Trennung besonders wichtig, weil eine eindeutige Vorwärtszuordnung bereits durch den Funktionsbegriff gegeben ist. Injektivität erweitert diese Struktur um eindeutige Rückschlüsse auf die Argumente, während Surjektivität die vollständige Ausschöpfung des Zielbereichs beschreibt.\n\n### M1.7.4 Bijektivität\n\nEine Funktion heißt bijektiv, wenn sie gleichzeitig injektiv und surjektiv ist.\n\n\\[\nf\\ \\mathrm{bijektiv}\\iff f\\ \\mathrm{injektiv}\\land f\\ \\mathrm{surjektiv}\\tag{M1.127}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{bijektiv}\\iff f\\ \\mathrm{injektiv}\\land f\\ \\mathrm{surjektiv}`\n\nDamit gilt für jedes `(b\\in B)` nicht nur die Existenz eines Urbildes, sondern dessen Eindeutigkeit.\n\n\\[\nf\\ \\mathrm{bijektiv}\\iff\\forall b\\in B\\ \\exists!a\\in A:f(a)=b\\tag{M1.128}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{bijektiv}\\iff\\forall b\\in B\\ \\exists!a\\in A:f(a)=b`\n\nDie Bijektivität stellt damit eine symmetrische Eindeutigkeit zwischen beiden Mengen her. Jedem `(a\\in A)` ist genau ein `(b\\in B)` zugeordnet, und jedes `(b\\in B)` besitzt genau ein zugehöriges `(a\\in A)`.\n\nFür endliche Mengen ergibt sich daraus unmittelbar eine Beziehung ihrer Mächtigkeiten.\n\n\\[\nf:A\\rightarrow B\\ \\mathrm{bijektiv}\\Longrightarrow\\left|A\\right|=\\left|B\\right|\\tag{M1.129}\n\\]\n\nWord-LaTeX: `f:A\\rightarrow B\\ \\mathrm{bijektiv}\\Longrightarrow\\left|A\\right|=\\left|B\\right|`\n\nBei endlichen Mengen beschreibt eine Bijektion damit eine vollständige paarweise Zuordnung ohne Wiederholungen und ohne ausgelassene Elemente.\n\n### M1.7.5 Umkehrfunktion\n\nErst die Bijektivität erlaubt mir, die Zuordnung vollständig umzukehren.\n\nIst `(f:A\\rightarrow B)` bijektiv, dann existiert eine eindeutig bestimmte Umkehrfunktion:\n\n\\[\nf^{-1}:B\\rightarrow A\\tag{M1.130}\n\\]\n\nWord-LaTeX: `f^{-1}:B\\rightarrow A`\n\nSie ist dadurch charakterisiert, dass sie jeden Funktionswert wieder auf sein eindeutig bestimmtes Ausgangselement abbildet.\n\n\\[\nf^{-1}(b)=a\\iff f(a)=b\\tag{M1.131}\n\\]\n\nWord-LaTeX: `f^{-1}(b)=a\\iff f(a)=b`\n\nFür die Komposition mit der ursprünglichen Funktion gilt:\n\n\\[\nf^{-1}\\circ f=\\operatorname{id}_A\\tag{M1.132}\n\\]\n\nWord-LaTeX: `f^{-1}\\circ f=\\operatorname{id}_A`\n\nund in der Gegenrichtung:\n\n\\[\nf\\circ f^{-1}=\\operatorname{id}_B\\tag{M1.133}\n\\]\n\nWord-LaTeX: `f\\circ f^{-1}=\\operatorname{id}_B`\n\nDiese beiden Beziehungen zeigen für mich besonders klar, was mathematische Umkehrbarkeit bedeutet. Die Hin- und Rückabbildung heben sich durch Komposition gegenseitig auf und führen jeweils zur entsprechenden Identitätsfunktion.\n\nDaraus folgt zugleich, dass die Umkehrfunktion einer Bijektion selbst wieder bijektiv ist.\n\n\\[\nf\\ \\mathrm{bijektiv}\\Longrightarrow f^{-1}\\ \\mathrm{bijektiv}\\tag{M1.134}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{bijektiv}\\Longrightarrow f^{-1}\\ \\mathrm{bijektiv}`\n\nWende ich die Umkehrung erneut an, erhalte ich die ursprüngliche Funktion zurück.\n\n\\[\n\\left(f^{-1}\\right)^{-1}=f\\tag{M1.135}\n\\]\n\nWord-LaTeX: `\\left(f^{-1}\\right)^{-1}=f`\n\n### M1.7.6 Umkehrrelation, Umkehrfunktion und Urbild\n\nAn dieser Stelle muss ich drei Begriffe ausdrücklich voneinander trennen, weil ihre Schreibweisen leicht miteinander verwechselt werden können.\n\nFür jede Relation `(R)` existiert eine Umkehrrelation `(R^{-1})`, weil lediglich die Komponenten jedes geordneten Paares vertauscht werden.\n\nFür jede Funktion `(f:A\\rightarrow B)` kann außerdem das Urbild einer Teilmenge `(D\\subseteq B)` gebildet werden. Dafür ist keine Bijektivität erforderlich.\n\nEine Umkehrfunktion `(f^{-1}:B\\rightarrow A)` existiert dagegen nur dann, wenn `(f)` bijektiv ist.\n\nDiese drei Aussagen sind mathematisch verschieden. Insbesondere ist `(f^{-1}(D))` als Urbild einer Menge auch dann sinnvoll, wenn gar keine inverse Funktion `(f^{-1})` existiert. Welche Bedeutung das Symbol `(f^{-1})` besitzt, ergibt sich deshalb immer aus dem mathematischen Zusammenhang.\n\nFür die inverse Funktion gilt außerdem:\n\n\\[\nf^{-1}(f(a))=a\\qquad\\forall a\\in A\\tag{M1.136}\n\\]\n\nWord-LaTeX: `f^{-1}(f(a))=a\\qquad\\forall a\\in A`\n\nund:\n\n\\[\nf(f^{-1}(b))=b\\qquad\\forall b\\in B\\tag{M1.137}\n\\]\n\nWord-LaTeX: `f(f^{-1}(b))=b\\qquad\\forall b\\in B`\n\nDiese punktweisen Beziehungen entsprechen den Kompositionsgleichungen (M1.132) und (M1.133).\n\n### M1.7.7 Zusammensetzung bijektiver Funktionen\n\nSeien `(f:A\\rightarrow B)` und `(g:B\\rightarrow C)` bijektiv. Dann ist auch ihre Komposition bijektiv.\n\n\\[\nf\\ \\mathrm{bijektiv}\\land g\\ \\mathrm{bijektiv}\\Longrightarrow g\\circ f\\ \\mathrm{bijektiv}\\tag{M1.138}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{bijektiv}\\land g\\ \\mathrm{bijektiv}\\Longrightarrow g\\circ f\\ \\mathrm{bijektiv}`\n\nDie Umkehrfunktion der Komposition erhält man dabei in umgekehrter Reihenfolge.\n\n\\[\n(g\\circ f)^{-1}=f^{-1}\\circ g^{-1}\\tag{M1.139}\n\\]\n\nWord-LaTeX: `(g\\circ f)^{-1}=f^{-1}\\circ g^{-1}`\n\nDiese Reihenfolge ist für mich wichtig. Um die Wirkung `(g\\circ f)` rückgängig zu machen, muss zunächst `(g)` und anschließend `(f)` umgekehrt werden. Die Umkehrung kehrt damit zugleich die Reihenfolge der ursprünglichen Komposition um. [[6]]\n\n### M1.7.8 Methodische Grenze der Bijektivität\n\nEine bijektive Funktion besitzt eine eindeutige mathematische Umkehrfunktion. Daraus folgt jedoch noch keine Aussage darüber, ob ein realer Prozess reversibel ist.\n\nFür mich ist diese Abgrenzung besonders wichtig, weil die Gleichungen (M1.132) und (M1.133) eine vollständige mathematische Rückführbarkeit beschreiben. Diese Eigenschaft betrifft ausschließlich die verwendete Abbildung. Eine zeitliche Rückwärtsentwicklung, physikalische Reversibilität oder Wiederherstellbarkeit eines realen Zustands wäre eine zusätzliche Interpretation, die aus der Bijektivität allein nicht folgt.\n\n### M1.7.9 Ergebnis und Weitergabestelle\n\nMit Injektivität, Surjektivität und Bijektivität kann ich die allgemeine Funktionsstruktur nun wesentlich genauer unterscheiden. Die Injektivität stellt sicher, dass verschiedene Argumente verschiedene Funktionswerte besitzen. Die Surjektivität verlangt, dass jeder Wert des Zielbereichs tatsächlich angenommen wird. Die Bijektivität verbindet beide Bedingungen und schafft damit eine eindeutige Zuordnung in beiden Richtungen.\n\nFür meinen weiteren Aufbau sind vier Ergebnisse besonders wichtig. Erstens ist die Eindeutigkeit einer Funktion nicht mit Injektivität gleichzusetzen. Die Funktionsdefinition garantiert genau einen Wert für jedes Argument; die Injektivität verlangt zusätzlich, dass verschiedene Argumente nicht auf denselben Wert fallen. Zweitens ist Surjektivität eine Aussage über die Beziehung zwischen Bild- und Zielmenge. Drittens existiert eine Umkehrfunktion genau im bijektiven Fall. Viertens müssen Umkehrfunktion und Urbild weiterhin strikt voneinander getrennt bleiben.\n\nDamit sind die grundlegenden Eigenschaften einer einzelnen Funktion bestimmt. Noch fehlt mir jedoch eine systematische Betrachtung dessen, was mit **ganzen Teilmengen** unter einer Funktion geschieht und wie sich Bild- und Urbildbildung gegenüber Vereinigung, Durchschnitt und Komplement verhalten.\n\nDie **Weitergabestelle M1.7 → M1.8** liegt deshalb bei der Übertragung der bereits eingeführten Mengenoperationen auf Funktionen. **M1.8 Bilder und Urbilder von Mengen** untersucht, wie Teilmengen des Definitions- und Zielbereichs durch eine Funktion miteinander verknüpft werden und welche mengentheoretischen Beziehungen dabei allgemein erhalten bleiben.', 'c627cd1f2d92373639b209eec23f43ef448da5a9588e7262fb448267a13ee848', 'Kanonischer M1.7-Text des neuen Anlagenaufbaus.');
INSERT INTO `appendix_section_versions` (`appendix_section_version_id`, `appendix_section_id`, `revision_id`, `version_kind`, `body_markdown`, `checksum_sha256`, `notes`) VALUES
(9, 9, 21, 'draft', '## M1.8 Bilder und Urbilder von Mengen\n\nMit Injektivität, Surjektivität und Bijektivität habe ich in M1.7 Eigenschaften einer Funktion als Ganzes untersucht. Für den weiteren Aufbau reicht mir jedoch nicht nur die Frage, wie einzelne Argumente abgebildet werden. Ebenso wichtig ist, was mit **ganzen Teilmengen** des Definitions- oder Zielbereichs geschieht. Gerade an dieser Stelle verbinden sich die zuvor getrennt entwickelten Mengenoperationen mit dem Funktionsbegriff. [[6]]\n\nIch unterscheide dabei zwei Richtungen bewusst voneinander. Beim **Bild** gehe ich von einer Teilmenge des Definitionsbereichs aus und frage, welche Funktionswerte daraus entstehen. Beim **Urbild** beginne ich dagegen mit einer Teilmenge des Zielbereichs und frage, welche Argumente auf Elemente dieser Menge abgebildet werden. Beide Konstruktionen existieren für jede Funktion; weder Injektivität noch Surjektivität oder Bijektivität sind dafür erforderlich.\n\n### M1.8.1 Bild einer Teilmenge\n\nSei `(f:A\\rightarrow B)` eine Funktion und `(C\\subseteq A)`. Das Bild von `(C)` unter `(f)` definiere ich durch:\n\n\\[\nf(C)=\\left\\{f(c)\\mid c\\in C\\right\\}\\tag{M1.140}\n\\]\n\nWord-LaTeX: `f(C)=\\left\\{f(c)\\mid c\\in C\\right\\}`\n\nDas Bild von `(C)` besteht damit genau aus denjenigen Elementen des Zielbereichs, die durch Argumente aus `(C)` tatsächlich angenommen werden.\n\nFür jede Teilmenge `(C\\subseteq A)` gilt deshalb:\n\n\\[\nf(C)\\subseteq\\operatorname{im}(f)\\tag{M1.141}\n\\]\n\nWord-LaTeX: `f(C)\\subseteq\\operatorname{im}(f)`\n\nDa `(\\operatorname{im}(f)\\subseteq B)` gilt, folgt außerdem:\n\n\\[\nf(C)\\subseteq B\\tag{M1.142}\n\\]\n\nWord-LaTeX: `f(C)\\subseteq B`\n\nFür die gesamte Definitionsmenge erhalte ich genau die bereits eingeführte Bildmenge der Funktion:\n\n\\[\nf(A)=\\operatorname{im}(f)\\tag{M1.143}\n\\]\n\nWord-LaTeX: `f(A)=\\operatorname{im}(f)`\n\nAuch für die leere Menge ist die Bildbildung eindeutig bestimmt.\n\n\\[\nf(\\varnothing)=\\varnothing\\tag{M1.144}\n\\]\n\nWord-LaTeX: `f(\\varnothing)=\\varnothing`\n\nFür mich ist diese Beziehung selbstverständlich, aber strukturell wichtig. Da `(\\varnothing)` kein Argument enthält, kann aus ihr auch kein Funktionswert entstehen.\n\n### M1.8.2 Monotonie der Bildbildung\n\nIst eine Teilmenge vollständig in einer anderen enthalten, kann ihre Bildmenge nicht über das Bild der größeren Menge hinausreichen.\n\nSeien `(C,D\\subseteq A)` und `(C\\subseteq D)`. Dann gilt:\n\n\\[\nC\\subseteq D\\Longrightarrow f(C)\\subseteq f(D)\\tag{M1.145}\n\\]\n\nWord-LaTeX: `C\\subseteq D\\Longrightarrow f(C)\\subseteq f(D)`\n\nDiese Monotonie folgt direkt daraus, dass jedes Element von `(C)` zugleich Element von `(D)` ist. Jeder Funktionswert, der aus `(C)` erzeugt wird, tritt deshalb auch im Bild von `(D)` auf.\n\n### M1.8.3 Bild von Vereinigungen\n\nDie Bildbildung verträgt sich vollständig mit der Vereinigung.\n\nFür `(C,D\\subseteq A)` gilt:\n\n\\[\nf(C\\cup D)=f(C)\\cup f(D)\\tag{M1.146}\n\\]\n\nWord-LaTeX: `f(C\\cup D)=f(C)\\cup f(D)`\n\nDiese Gleichheit gilt ohne zusätzliche Voraussetzung an `(f)`. Ein Funktionswert gehört genau dann zum Bild von `(C\\cup D)`, wenn sein Argument aus `(C)` oder aus `(D)` stammt.\n\nAuch für eine Familie von Teilmengen `((C_i)_{i\\in I})` kann ich diese Eigenschaft erweitern:\n\n\\[\nf\\left(\\bigcup_{i\\in I}C_i\\right)=\\bigcup_{i\\in I}f(C_i)\\tag{M1.147}\n\\]\n\nWord-LaTeX: `f\\left(\\bigcup_{i\\in I}C_i\\right)=\\bigcup_{i\\in I}f(C_i)`\n\nDamit bleibt die Vereinigung auch bei beliebig vielen Teilmengen unter der direkten Bildbildung vollständig erhalten. [[6]]\n\n### M1.8.4 Bild von Durchschnitten\n\nBeim Durchschnitt ist die Situation anders. Aus `(x\\in C\\cap D)` folgt zwar, dass `(f(x))` sowohl zu `(f(C))` als auch zu `(f(D))` gehört. Deshalb gilt immer:\n\n\\[\nf(C\\cap D)\\subseteq f(C)\\cap f(D)\\tag{M1.148}\n\\]\n\nWord-LaTeX: `f(C\\cap D)\\subseteq f(C)\\cap f(D)`\n\nDie umgekehrte Inklusion gilt im Allgemeinen jedoch nicht.\n\nDer Grund liegt für mich genau in der fehlenden Injektivität. Ein Wert `(y)` kann zugleich in `(f(C))` und `(f(D))` liegen, weil es verschiedene Argumente `(c\\in C)` und `(d\\in D)` mit demselben Funktionswert gibt. Daraus folgt noch nicht, dass ein gemeinsames Argument in `(C\\cap D)` existiert.\n\nIst `(f)` dagegen injektiv, fällt diese Mehrdeutigkeit weg. Dann gilt:\n\n\\[\nf\\ \\mathrm{injektiv}\\Longrightarrow f(C\\cap D)=f(C)\\cap f(D)\\tag{M1.149}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{injektiv}\\Longrightarrow f(C\\cap D)=f(C)\\cap f(D)`\n\nAn dieser Beziehung wird für mich besonders klar, welche zusätzliche mathematische Leistung die Injektivität erbringt. Sie erhält nicht nur die Unterscheidbarkeit einzelner Argumente, sondern erlaubt auch eine stärkere Übertragung mengentheoretischer Schnittstrukturen auf ihre Bilder.\n\n### M1.8.5 Bild von Mengendifferenzen\n\nAuch bei der Mengendifferenz muss ich vorsichtig sein. Allgemein gilt zunächst:\n\n\\[\nf(C)\\setminus f(D)\\subseteq f(C\\setminus D)\\tag{M1.150}\n\\]\n\nWord-LaTeX: `f(C)\\setminus f(D)\\subseteq f(C\\setminus D)`\n\nDie umgekehrte Inklusion kann scheitern. Ein Element aus `(C\\setminus D)` kann denselben Funktionswert besitzen wie ein anderes Argument aus `(D)`. Dieser Funktionswert liegt dann zwar in `(f(C\\setminus D))`, aber nicht in `(f(C)\\setminus f(D))`.\n\nIst die Funktion injektiv, kann eine solche Zusammenführung verschiedener Argumente nicht auftreten. Dann gilt:\n\n\\[\nf\\ \\mathrm{injektiv}\\Longrightarrow f(C\\setminus D)=f(C)\\setminus f(D)\\tag{M1.151}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{injektiv}\\Longrightarrow f(C\\setminus D)=f(C)\\setminus f(D)`\n\nAuch hier erkenne ich dieselbe Struktur wie beim Durchschnitt: Die direkte Bildbildung erhält bestimmte Mengenoperationen erst unter zusätzlicher Injektivität vollständig.\n\n### M1.8.6 Urbild einer Teilmenge\n\nNun kehre ich die Blickrichtung um. Sei `(D\\subseteq B)`. Das Urbild von `(D)` unter `(f)` besteht aus allen Argumenten, deren Funktionswert in `(D)` liegt.\n\n\\[\nf^{-1}(D)=\\left\\{a\\in A\\mid f(a)\\in D\\right\\}\\tag{M1.152}\n\\]\n\nWord-LaTeX: `f^{-1}(D)=\\left\\{a\\in A\\mid f(a)\\in D\\right\\}`\n\nDiese Definition benötigt ausdrücklich **keine Umkehrfunktion**. Das Symbol `(f^{-1}(D))` bezeichnet hier die Urbildmenge. Sie ist für jede Funktion `(f:A\\rightarrow B)` und jede Teilmenge `(D\\subseteq B)` definiert.\n\nEs gilt stets:\n\n\\[\nf^{-1}(D)\\subseteq A\\tag{M1.153}\n\\]\n\nWord-LaTeX: `f^{-1}(D)\\subseteq A`\n\nFür den gesamten Zielbereich erhalte ich:\n\n\\[\nf^{-1}(B)=A\\tag{M1.154}\n\\]\n\nWord-LaTeX: `f^{-1}(B)=A`\n\nDenn jeder Funktionswert einer Funktion `(f:A\\rightarrow B)` liegt definitionsgemäß in `(B)`.\n\nFür die leere Menge gilt entsprechend:\n\n\\[\nf^{-1}(\\varnothing)=\\varnothing\\tag{M1.155}\n\\]\n\nWord-LaTeX: `f^{-1}(\\varnothing)=\\varnothing`\n\nKein Argument kann einen Funktionswert besitzen, der Element der leeren Menge ist.\n\n### M1.8.7 Monotonie der Urbildbildung\n\nAuch die Urbildbildung ist monoton. Sind `(D,E\\subseteq B)` und `(D\\subseteq E)`, dann gilt:\n\n\\[\nD\\subseteq E\\Longrightarrow f^{-1}(D)\\subseteq f^{-1}(E)\\tag{M1.156}\n\\]\n\nWord-LaTeX: `D\\subseteq E\\Longrightarrow f^{-1}(D)\\subseteq f^{-1}(E)`\n\nJedes Argument, dessen Funktionswert in `(D)` liegt, besitzt damit automatisch einen Funktionswert in `(E)`.\n\n### M1.8.8 Urbild von Vereinigungen und Durchschnitten\n\nIm Unterschied zur direkten Bildbildung erhält die Urbildbildung sowohl Vereinigungen als auch Durchschnitte **ohne zusätzliche Voraussetzung**.\n\nFür `(D,E\\subseteq B)` gilt:\n\n\\[\nf^{-1}(D\\cup E)=f^{-1}(D)\\cup f^{-1}(E)\\tag{M1.157}\n\\]\n\nWord-LaTeX: `f^{-1}(D\\cup E)=f^{-1}(D)\\cup f^{-1}(E)`\n\nEbenso gilt:\n\n\\[\nf^{-1}(D\\cap E)=f^{-1}(D)\\cap f^{-1}(E)\\tag{M1.158}\n\\]\n\nWord-LaTeX: `f^{-1}(D\\cap E)=f^{-1}(D)\\cap f^{-1}(E)`\n\nFür mich ist dieser Unterschied zur Bildbildung besonders wichtig. Beim Urbild frage ich lediglich, ob ein bestimmter Funktionswert eine Mengenbedingung erfüllt. Eine mögliche Zusammenführung verschiedener Argumente unter `(f)` verändert diese logische Prüfung nicht.\n\nFür beliebige Mengenfamilien erweitert sich dies zu:\n\n\\[\nf^{-1}\\left(\\bigcup_{i\\in I}D_i\\right)=\\bigcup_{i\\in I}f^{-1}(D_i)\\tag{M1.159}\n\\]\n\nWord-LaTeX: `f^{-1}\\left(\\bigcup_{i\\in I}D_i\\right)=\\bigcup_{i\\in I}f^{-1}(D_i)`\n\nund:\n\n\\[\nf^{-1}\\left(\\bigcap_{i\\in I}D_i\\right)=\\bigcap_{i\\in I}f^{-1}(D_i)\\tag{M1.160}\n\\]\n\nWord-LaTeX: `f^{-1}\\left(\\bigcap_{i\\in I}D_i\\right)=\\bigcap_{i\\in I}f^{-1}(D_i)`\n\n### M1.8.9 Urbild von Differenz und Komplement\n\nAuch die Mengendifferenz wird durch die Urbildbildung exakt erhalten:\n\n\\[\nf^{-1}(D\\setminus E)=f^{-1}(D)\\setminus f^{-1}(E)\\tag{M1.161}\n\\]\n\nWord-LaTeX: `f^{-1}(D\\setminus E)=f^{-1}(D)\\setminus f^{-1}(E)`\n\nBesonders wichtig ist für mich daraus die Komplementbeziehung. Das Komplement auf der Zielseite muss dabei relativ zum Zielbereich `(B)` und das Komplement auf der Definitionsseite relativ zu `(A)` verstanden werden.\n\nFür `(D\\subseteq B)` gilt:\n\n\\[\nf^{-1}(B\\setminus D)=A\\setminus f^{-1}(D)\\tag{M1.162}\n\\]\n\nWord-LaTeX: `f^{-1}(B\\setminus D)=A\\setminus f^{-1}(D)`\n\nDamit erhält die Urbildbildung die grundlegenden booleschen Mengenoperationen vollständig.\n\n### M1.8.10 Bild nach Urbild und Urbild nach Bild\n\nBesonders aufschlussreich ist für mich die Frage, was geschieht, wenn Bild- und Urbildbildung unmittelbar nacheinander angewendet werden.\n\nBeginne ich mit einer Teilmenge `(C\\subseteq A)`, bilde zunächst `(f(C))` und anschließend deren Urbild, dann erhalte ich mindestens wieder `(C)`:\n\n\\[\nC\\subseteq f^{-1}(f(C))\\tag{M1.163}\n\\]\n\nWord-LaTeX: `C\\subseteq f^{-1}(f(C))`\n\nDie resultierende Menge kann jedoch größer sein. Neben den ursprünglichen Elementen aus `(C)` können weitere Argumente denselben Funktionswert besitzen und deshalb ebenfalls im Urbild von `(f(C))` liegen.\n\nIst `(f)` injektiv, ist dies ausgeschlossen. Dann gilt:\n\n\\[\nf\\ \\mathrm{injektiv}\\Longrightarrow f^{-1}(f(C))=C\\tag{M1.164}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{injektiv}\\Longrightarrow f^{-1}(f(C))=C`\n\nIn der Gegenrichtung beginne ich mit `(D\\subseteq B)`. Zunächst bilde ich das Urbild `(f^{-1}(D))` und anschließend dessen Bild. Dabei können nur diejenigen Elemente von `(D)` zurückgewonnen werden, die überhaupt im Bild der Funktion liegen.\n\n\\[\nf(f^{-1}(D))=D\\cap\\operatorname{im}(f)\\tag{M1.165}\n\\]\n\nWord-LaTeX: `f(f^{-1}(D))=D\\cap\\operatorname{im}(f)`\n\nIst `(f)` surjektiv, gilt `(\\operatorname{im}(f)=B)`. Für jedes `(D\\subseteq B)` folgt dann:\n\n\\[\nf\\ \\mathrm{surjektiv}\\Longrightarrow f(f^{-1}(D))=D\\tag{M1.166}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{surjektiv}\\Longrightarrow f(f^{-1}(D))=D`\n\nDamit zeigen Bild und Urbild erneut sehr präzise, welche Rollen Injektivität und Surjektivität übernehmen. Die Injektivität garantiert die vollständige Rückgewinnung einer Teilmenge des Definitionsbereichs nach Bild- und Urbildbildung. Die Surjektivität garantiert entsprechend die vollständige Rückgewinnung einer Teilmenge des Zielbereichs nach Urbild- und Bildbildung. [[6]]\n\n### M1.8.11 Ergebnis und Weitergabestelle\n\nMit Bild- und Urbildbildung kann ich die Wirkung einer Funktion nun nicht mehr nur punktweise, sondern auf ganzen Teilmengen untersuchen. Für mich zeigt sich dabei eine wichtige Asymmetrie. Die direkte Bildbildung erhält Vereinigungen allgemein, Durchschnitte und Differenzen jedoch nur unter zusätzlichen Bedingungen vollständig. Die Urbildbildung erhält dagegen Vereinigung, Durchschnitt, Differenz und Komplement bereits für jede Funktion exakt.\n\nInjektivität und Surjektivität erhalten dadurch eine zweite, strukturell besonders aufschlussreiche Bedeutung. Injektivität verhindert, dass beim Übergang zum Bild verschiedene Elemente so zusammengeführt werden, dass Mengenunterschiede verloren gehen. Surjektivität stellt sicher, dass auf der Zielseite keine Elemente außerhalb des tatsächlich erreichbaren Bildes verbleiben.\n\nDamit ist die mengentheoretische Wirkung einer einzelnen Funktion ausreichend bestimmt. Für den nächsten Schritt benötige ich nun die systematische **Verknüpfung mehrerer Funktionen**. Die Identitätsfunktion wurde bereits eingeführt; jetzt muss geklärt werden, unter welchen Bedingungen zwei Funktionen komponiert werden können, welche Reihenfolge dabei gilt und wie sich Eigenschaften wie Injektivität, Surjektivität und Bijektivität unter der Komposition verhalten.\n\nDie **Weitergabestelle M1.8 → M1.9** liegt deshalb bei **Identität, Komposition und inverser Verkettung von Funktionen**. M1.9 baut auf den bereits bestimmten Definitions- und Zielbereichen auf und untersucht die algebraische Struktur, die durch die Verkettung zueinander passender Funktionen entsteht.', 'be4c23e53ab4968b3b572a7ec9275426999fec696adadaf6e2a7e194b56ff0e0', 'Kanonischer M1.8-Text des neuen Anlagenaufbaus.'),
(10, 10, 22, 'draft', '## M1.9 Identität, Komposition und inverse Verkettung von Funktionen\n\nNachdem Bild und Urbild einer Funktion bestimmt sind, kann ich nun mehrere Funktionen systematisch miteinander verknüpfen. Für mich ist dabei zunächst eine einfache Voraussetzung entscheidend: Die Ausgabe der zuerst angewendeten Funktion muss als zulässige Eingabe der anschließend angewendeten Funktion verwendet werden können. Erst wenn diese Bereichsbeziehung geklärt ist, ist die Komposition mathematisch eindeutig definiert. [[6]]\n\nDie Komposition ist deshalb für mich nicht nur eine verkürzte Schreibweise für „zwei Funktionen hintereinander“. Sie besitzt eine genaue Typstruktur. Definitionsbereich, Zwischenbereich und Zielbereich müssen zueinander passen, und die Reihenfolge der beteiligten Funktionen gehört zur mathematischen Aussage.\n\n### M1.9.1 Definition der Funktionskomposition\n\nSeien `(f:A\\rightarrow B)` und `(g:B\\rightarrow C)` Funktionen. Dann definiere ich ihre Komposition `(g\\circ f)` durch:\n\n\\[\ng\\circ f:A\\rightarrow C\\tag{M1.167}\n\\]\n\nWord-LaTeX: `g\\circ f:A\\rightarrow C`\n\nFür jedes `(a\\in A)` gilt:\n\n\\[\n(g\\circ f)(a)=g(f(a))\\tag{M1.168}\n\\]\n\nWord-LaTeX: `(g\\circ f)(a)=g(f(a))`\n\nDie Reihenfolge dieser Schreibweise halte ich bewusst fest. Zuerst wirkt `(f)` auf `(a)`. Das Ergebnis `(f(a))` liegt in `(B)` und kann deshalb anschließend als Argument von `(g)` verwendet werden.\n\nFür mich ist es hilfreich, diese Richtung ausdrücklich als Strukturkette zu lesen:\n\n\\[\nA\\xrightarrow{f}B\\xrightarrow{g}C\\tag{M1.169}\n\\]\n\nWord-LaTeX: `A\\xrightarrow{f}B\\xrightarrow{g}C`\n\nDie zusammengesetzte Funktion überspringt in ihrer äußeren Signatur den Zwischenbereich `(B)`, ohne ihn mathematisch zu beseitigen.\n\n### M1.9.2 Allgemeinere Kompositionsbedingung\n\nFür die Komposition ist nicht zwingend erforderlich, dass der Zielbereich von `(f)` exakt mit dem Definitionsbereich von `(g)` identisch ist. Es genügt, dass sämtliche tatsächlich durch `(f)` erzeugten Werte im Definitionsbereich von `(g)` liegen.\n\nIst `(f:A\\rightarrow B)` gegeben und `(g:D\\rightarrow C)` mit:\n\n\\[\n\\operatorname{im}(f)\\subseteq D\\tag{M1.170}\n\\]\n\nWord-LaTeX: `\\operatorname{im}(f)\\subseteq D`\n\ndann ist `(g\\circ f)` ebenfalls wohldefiniert.\n\nFür meinen Aufbau verwende ich jedoch bevorzugt die typmäßig klarere Form `(f:A\\rightarrow B)` und `(g:B\\rightarrow C)`, weil damit die Komponierbarkeit bereits an den Funktionssignaturen sichtbar wird.\n\n### M1.9.3 Identitätsfunktion als neutrales Element\n\nDie in M1.6 eingeführte Identitätsfunktion erhält bei der Komposition ihre eigentliche strukturelle Bedeutung. Für `(f:A\\rightarrow B)` gilt auf der Zielseite:\n\n\\[\n\\operatorname{id}_B\\circ f=f\\tag{M1.171}\n\\]\n\nWord-LaTeX: `\\operatorname{id}_B\\circ f=f`\n\nDenn für jedes `(a\\in A)` gilt:\n\n\\[\n(\\operatorname{id}_B\\circ f)(a)=\\operatorname{id}_B(f(a))=f(a)\\tag{M1.172}\n\\]\n\nWord-LaTeX: `(\\operatorname{id}_B\\circ f)(a)=\\operatorname{id}_B(f(a))=f(a)`\n\nEntsprechend gilt auf der Definitionsseite:\n\n\\[\nf\\circ\\operatorname{id}_A=f\\tag{M1.173}\n\\]\n\nWord-LaTeX: `f\\circ\\operatorname{id}_A=f`\n\nund punktweise:\n\n\\[\n(f\\circ\\operatorname{id}_A)(a)=f(\\operatorname{id}_A(a))=f(a)\\tag{M1.174}\n\\]\n\nWord-LaTeX: `(f\\circ\\operatorname{id}_A)(a)=f(\\operatorname{id}_A(a))=f(a)`\n\nDamit besitzt die Identitätsfunktion bezüglich der Komposition eine neutrale Wirkung. [[6]]\n\nFür mich ist dabei interessant, dass die Identitätsfunktion vom jeweiligen Objektbereich abhängt. `(\\operatorname{id}_A)` und `(\\operatorname{id}_B)` erfüllen dieselbe strukturelle Rolle, sind aber bei unterschiedlichen Mengen nicht dieselbe Funktion.\n\n### M1.9.4 Assoziativität der Komposition\n\nSeien nun drei zueinander passende Funktionen gegeben:\n\n\\[\nf:A\\rightarrow B,\\qquad g:B\\rightarrow C,\\qquad h:C\\rightarrow D\\tag{M1.175}\n\\]\n\nWord-LaTeX: `f:A\\rightarrow B,\\qquad g:B\\rightarrow C,\\qquad h:C\\rightarrow D`\n\nDann gilt:\n\n\\[\nh\\circ(g\\circ f)=(h\\circ g)\\circ f\\tag{M1.176}\n\\]\n\nWord-LaTeX: `h\\circ(g\\circ f)=(h\\circ g)\\circ f`\n\nPunktweise wird diese Gleichheit unmittelbar sichtbar:\n\n\\[\n(h\\circ(g\\circ f))(a)=h(g(f(a)))=((h\\circ g)\\circ f)(a)\\tag{M1.177}\n\\]\n\nWord-LaTeX: `(h\\circ(g\\circ f))(a)=h(g(f(a)))=((h\\circ g)\\circ f)(a)`\n\nDie Funktionskomposition ist damit assoziativ. Bei einer längeren Kette zueinander passender Funktionen kann ich deshalb die Klammerung verändern, ohne die resultierende Funktion zu verändern.\n\nDas bedeutet jedoch nicht, dass die Reihenfolge beliebig wäre.\n\n### M1.9.5 Reihenfolge und fehlende allgemeine Kommutativität\n\nFür `(g\\circ f)` wird zuerst `(f)` und danach `(g)` angewendet. Eine Vertauschung führt zu `(f\\circ g)`, sofern diese Komposition überhaupt definiert ist.\n\nBereits die Bereichsstruktur kann verhindern, dass beide Reihenfolgen zulässig sind. Ist etwa `(f:A\\rightarrow B)` und `(g:B\\rightarrow C)` gegeben, ist `(g\\circ f)` definiert. Für `(f\\circ g)` müsste dagegen `(g)` Werte erzeugen, die zulässige Argumente von `(f)` sind. Das folgt aus den ursprünglichen Signaturen nicht.\n\nSelbst wenn beide Kompositionen definiert sind, folgt daraus keine Gleichheit. Ich halte deshalb lediglich fest, dass Kommutativität **keine allgemeine Eigenschaft** der Funktionskomposition ist.\n\nDiese Formulierung ist mir wichtig. Die Aussage soll nicht fälschlich bedeuten, dass `(g\\circ f)` und `(f\\circ g)` niemals gleich sein können. Für bestimmte Funktionen können beide Kompositionen durchaus übereinstimmen. Es existiert lediglich kein allgemeines Kommutativgesetz.\n\n### M1.9.6 Injektivität unter Komposition\n\nSind beide beteiligten Funktionen injektiv, bleibt die Injektivität unter der Komposition erhalten.\n\n\\[\nf\\ \\mathrm{injektiv}\\land g\\ \\mathrm{injektiv}\\Longrightarrow g\\circ f\\ \\mathrm{injektiv}\\tag{M1.178}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{injektiv}\\land g\\ \\mathrm{injektiv}\\Longrightarrow g\\circ f\\ \\mathrm{injektiv}`\n\nFür mich lässt sich diese Aussage unmittelbar aus der Rückschlussstruktur der Injektivität verstehen. Gelte:\n\n\\[\ng(f(a_1))=g(f(a_2))\\tag{M1.179}\n\\]\n\nWord-LaTeX: `g(f(a_1))=g(f(a_2))`\n\nAus der Injektivität von `(g)` folgt zunächst:\n\n\\[\nf(a_1)=f(a_2)\\tag{M1.180}\n\\]\n\nWord-LaTeX: `f(a_1)=f(a_2)`\n\nund aus der Injektivität von `(f)` anschließend:\n\n\\[\na_1=a_2\\tag{M1.181}\n\\]\n\nWord-LaTeX: `a_1=a_2`\n\nDamit ist die Komposition injektiv.\n\nAuch die umgekehrte Schlussrichtung liefert eine nützliche Teilinformation. Ist `(g\\circ f)` injektiv, muss `(f)` injektiv sein.\n\n\\[\ng\\circ f\\ \\mathrm{injektiv}\\Longrightarrow f\\ \\mathrm{injektiv}\\tag{M1.182}\n\\]\n\nWord-LaTeX: `g\\circ f\\ \\mathrm{injektiv}\\Longrightarrow f\\ \\mathrm{injektiv}`\n\nFür `(g)` folgt daraus dagegen im Allgemeinen keine Injektivität auf seinem gesamten Definitionsbereich, weil die Komposition möglicherweise nur den Teilbereich `(\\operatorname{im}(f))` von `(B)` tatsächlich verwendet.\n\n### M1.9.7 Surjektivität unter Komposition\n\nAuch die Surjektivität wird durch die Komposition erhalten, wenn beide Funktionen surjektiv sind.\n\n\\[\nf\\ \\mathrm{surjektiv}\\land g\\ \\mathrm{surjektiv}\\Longrightarrow g\\circ f\\ \\mathrm{surjektiv}\\tag{M1.183}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{surjektiv}\\land g\\ \\mathrm{surjektiv}\\Longrightarrow g\\circ f\\ \\mathrm{surjektiv}`\n\nFür jedes `(c\\in C)` liefert die Surjektivität von `(g)` zunächst mindestens ein `(b\\in B)` mit `(g(b)=c)`. Da `(f)` ebenfalls surjektiv ist, existiert mindestens ein `(a\\in A)` mit `(f(a)=b)`. Damit folgt `(g(f(a))=c)`.\n\nAuch hier ergibt sich eine einseitige Folgerung aus einer surjektiven Komposition:\n\n\\[\ng\\circ f\\ \\mathrm{surjektiv}\\Longrightarrow g\\ \\mathrm{surjektiv}\\tag{M1.184}\n\\]\n\nWord-LaTeX: `g\\circ f\\ \\mathrm{surjektiv}\\Longrightarrow g\\ \\mathrm{surjektiv}`\n\nFür `(f)` folgt daraus dagegen im Allgemeinen keine Surjektivität auf den gesamten Zwischenbereich `(B)`. Die Funktion `(f)` muss lediglich genügend Werte erzeugen, damit `(g)` über diese Werte den gesamten Zielbereich `(C)` erreicht.\n\nDie beiden Beziehungen (M1.182) und (M1.184) machen für mich deutlich, dass die Reihenfolge der Komposition auch bei strukturellen Eigenschaften relevant bleibt.\n\n### M1.9.8 Bijektivität unter Komposition\n\nSind `(f)` und `(g)` beide bijektiv, dann ist ihre Komposition ebenfalls bijektiv.\n\n\\[\nf\\ \\mathrm{bijektiv}\\land g\\ \\mathrm{bijektiv}\\Longrightarrow g\\circ f\\ \\mathrm{bijektiv}\\tag{M1.185}\n\\]\n\nWord-LaTeX: `f\\ \\mathrm{bijektiv}\\land g\\ \\mathrm{bijektiv}\\Longrightarrow g\\circ f\\ \\mathrm{bijektiv}`\n\nDiese Aussage folgt unmittelbar daraus, dass sowohl Injektivität als auch Surjektivität unter den genannten Voraussetzungen erhalten bleiben.\n\nDamit bildet die Komposition bijektiver Funktionen wiederum eine eindeutig umkehrbare Zuordnung.\n\n### M1.9.9 Umkehrung einer Komposition\n\nFür bijektive Funktionen `(f:A\\rightarrow B)` und `(g:B\\rightarrow C)` muss bei der Umkehrung nicht nur jede einzelne Funktion invertiert, sondern zugleich ihre Reihenfolge vertauscht werden.\n\n\\[\n(g\\circ f)^{-1}=f^{-1}\\circ g^{-1}\\tag{M1.186}\n\\]\n\nWord-LaTeX: `(g\\circ f)^{-1}=f^{-1}\\circ g^{-1}`\n\nDie Reihenfolge wird für mich unmittelbar verständlich, wenn ich mit einem `(c\\in C)` beginne. Um zum ursprünglichen `(a\\in A)` zurückzukehren, muss ich zuerst die zuletzt ausgeführte Abbildung `(g)` rückgängig machen und danach `(f)`.\n\nDie Komposition mit der vorgeschlagenen inversen Funktion bestätigt diese Struktur:\n\n\\[\n(f^{-1}\\circ g^{-1})\\circ(g\\circ f)=\\operatorname{id}_A\\tag{M1.187}\n\\]\n\nWord-LaTeX: `(f^{-1}\\circ g^{-1})\\circ(g\\circ f)=\\operatorname{id}_A`\n\nIn der Gegenrichtung gilt:\n\n\\[\n(g\\circ f)\\circ(f^{-1}\\circ g^{-1})=\\operatorname{id}_C\\tag{M1.188}\n\\]\n\nWord-LaTeX: `(g\\circ f)\\circ(f^{-1}\\circ g^{-1})=\\operatorname{id}_C`\n\nDamit ist die inverse Verkettung vollständig bestimmt. [[6]]\n\n### M1.9.10 Strukturelle Einordnung\n\nMit Identität und Komposition entsteht bereits eine sehr allgemeine Struktur. Funktionen können nacheinander ausgeführt werden, die Identitätsfunktion verändert eine Zuordnung bei der Komposition nicht, und die Klammerung mehrerer Kompositionen ist aufgrund der Assoziativität unerheblich.\n\nIch möchte daraus jedoch noch keine weitergehende algebraische Struktur voraussetzen. Insbesondere sind die hier betrachteten Funktionen zunächst beliebige Abbildungen zwischen Mengen. Begriffe wie Addition von Funktionen, lineare Kombination oder linearer Operator gehören noch nicht zu M1. Sie benötigen zusätzliche algebraische Voraussetzungen, die erst in M2 und den darauf aufbauenden Anlagen eingeführt werden.\n\nAuch die Schreibweise einer Funktionskette enthält weiterhin keine zeitliche Aussage. `(g\\circ f)` bedeutet mathematisch, dass der Funktionswert von `(f)` als Argument von `(g)` verwendet wird. Ob diese Reihenfolge später zeitlich interpretiert werden darf, ist eine davon unabhängige theoretische Frage.\n\n### M1.9.11 Ergebnis und Weitergabestelle\n\nMit der Funktionskomposition kann ich nun mehrere eindeutige Zuordnungen zu einer neuen Funktion verbinden. Die Bereichsstruktur legt fest, wann eine solche Verkettung zulässig ist. Die Identitätsfunktion wirkt dabei neutral, und die Komposition ist assoziativ, aber nicht allgemein kommutativ.\n\nFür meinen weiteren Aufbau sind insbesondere fünf Ergebnisse wichtig. Erstens besitzt die Funktionskomposition eine feste Reihenfolge. Zweitens bleibt die Klammerung einer zulässigen Funktionskette aufgrund der Assoziativität ohne Einfluss. Drittens bleiben Injektivität, Surjektivität und Bijektivität erhalten, wenn die jeweils komponierten Funktionen dieselbe Eigenschaft besitzen. Viertens erlaubt die Struktur einer injektiven beziehungsweise surjektiven Komposition bestimmte einseitige Rückschlüsse auf ihre Faktoren. Fünftens kehrt sich bei der Inversion einer Komposition die Reihenfolge der beteiligten Funktionen um.\n\nDamit ist die Struktur gewöhnlicher Funktionen zwischen zwei Mengen weitgehend bestimmt. Für den Abschluss von M1 muss ich den Funktionsbegriff nun noch in drei Richtungen erweitern, ohne seine Eindeutigkeitsbedingung aufzugeben: auf **mehrere Eingangsgrößen**, auf **Familien von Funktionen, die durch Parameter unterschieden werden**, und auf **Funktionen, die nur auf einem Teil eines zunächst betrachteten Grundbereichs definiert sind**.\n\nDie **Weitergabestelle M1.9 → M1.10** liegt deshalb bei diesen Erweiterungen. **M1.10 Mehrstellige, parametrisierte und partielle Funktionen** führt die dafür notwendigen Strukturen ein und bereitet anschließend den abschließenden Ergebnisbestand von M1 vor.', '55be0a697b3b27e0c25fab135c7d8306d0f3702948b72d00a14799989f647d5a', 'Vollständiger Reset-Neuaufsatz M1.9; persönlicher wissenschaftlicher Schreibstil und Ich-Form; Halmos nur als Folgezitation [[6]].'),
(11, 11, 23, 'draft', '## M1.10 Mehrstellige, parametrisierte und partielle Funktionen\n\nMit der Komposition habe ich in M1.9 untersucht, wie mehrere Funktionen nacheinander zu einer neuen Funktion verbunden werden können. Für den Abschluss der funktionalen Grundlagen benötige ich nun drei Erweiterungen, die auf den bisher eingeführten Strukturen aufbauen, ohne den Funktionsbegriff selbst zu verändern. Eine Funktion kann mehrere Eingangsgrößen besitzen, eine ganze Familie von Funktionen kann durch zusätzliche Parameter unterschieden werden, und eine Zuordnung kann nur auf einem Teil eines zunächst betrachteten Grundbereichs definiert sein.\n\nFür mich ist dabei eine begriffliche Trennung wichtig. Mehrere Eingangsgrößen verändern die Struktur des Definitionsbereichs. Ein Parameter unterscheidet dagegen verschiedene Funktionen innerhalb einer Familie. Eine partielle Funktion schließlich verändert den Bereich, auf dem die Zuordnung überhaupt definiert ist. Diese drei Fälle dürfen nicht allein aufgrund ähnlicher Schreibweisen miteinander vermischt werden. [[6]]\n\n### M1.10.1 Funktionen mit mehreren Eingangsgrößen\n\nEine Funktion mit zwei Eingangsgrößen kann ich vollständig innerhalb des bereits eingeführten Funktionsbegriffs behandeln. Ich verwende dazu das kartesische Produkt als Definitionsbereich.\n\nSeien `(A)`, `(B)` und `(C)` Mengen. Eine zweistellige Funktion besitzt die Form:\n\n\\[\nf:A\\times B\\rightarrow C\\tag{M1.189}\n\\]\n\nWord-LaTeX: `f:A\\times B\\rightarrow C`\n\nIhr Argument ist nicht `(a)` oder `(b)` einzeln, sondern das geordnete Paar `((a,b))`.\n\nFür `(a\\in A)` und `(b\\in B)` gilt:\n\n\\[\nf(a,b)\\in C\\tag{M1.190}\n\\]\n\nWord-LaTeX: `f(a,b)\\in C`\n\nDie Schreibweise `(f(a,b))` verstehe ich dabei als übliche Kurzform für die Anwendung von `(f)` auf das Paar `((a,b))`.\n\n\\[\nf(a,b)=f\\left((a,b)\\right)\\tag{M1.191}\n\\]\n\nWord-LaTeX: `f(a,b)=f\\left((a,b)\\right)`\n\nDamit benötige ich für mehrstellige Funktionen keine neue Form von Eindeutigkeit. Die Funktion ordnet weiterhin jedem Element ihres Definitionsbereichs genau einen Funktionswert zu. Lediglich die Elemente des Definitionsbereichs sind nun selbst geordnete Paare.\n\nDiese Struktur lässt sich unmittelbar auf beliebig viele endlich viele Eingangsgrößen erweitern. Für Mengen `(A_1,\\ldots,A_n)` und `(B)` schreibe ich:\n\n\\[\nf:A_1\\times A_2\\times\\cdots\\times A_n\\rightarrow B\\tag{M1.192}\n\\]\n\nWord-LaTeX: `f:A_1\\times A_2\\times\\cdots\\times A_n\\rightarrow B`\n\nDas Argument ist dann ein `(n)`-Tupel:\n\n\\[\n(a_1,\\ldots,a_n)\\in A_1\\times\\cdots\\times A_n\\tag{M1.193}\n\\]\n\nWord-LaTeX: `(a_1,\\ldots,a_n)\\in A_1\\times\\cdots\\times A_n`\n\nund der zugehörige Funktionswert liegt in `(B)`:\n\n\\[\nf(a_1,\\ldots,a_n)\\in B\\tag{M1.194}\n\\]\n\nWord-LaTeX: `f(a_1,\\ldots,a_n)\\in B`\n\nSind sämtliche Eingangsbereiche identisch mit `(A)`, kann ich die Signatur kompakt mit `(A^n)` schreiben.\n\n\\[\nf:A^n\\rightarrow B\\tag{M1.195}\n\\]\n\nWord-LaTeX: `f:A^n\\rightarrow B`\n\nFür mich ist damit ein wichtiger Punkt geklärt: Eine Funktion mit `(n)` Eingangsgrößen ist weiterhin eine Funktion **eines** Arguments, wenn das vollständige geordnete `(n)`-Tupel als Argument betrachtet wird. Die Mehrstelligkeit beschreibt die innere Struktur dieses Arguments.\n\n### M1.10.2 Fixierung einzelner Argumente\n\nAus einer mehrstelligen Funktion kann ich neue Funktionen gewinnen, indem ich einzelne Komponenten festhalte.\n\nSei beispielsweise:\n\n\\[\nf:A\\times B\\rightarrow C\\tag{M1.196}\n\\]\n\nWord-LaTeX: `f:A\\times B\\rightarrow C`\n\nund sei ein bestimmtes `(a_0\\in A)` fest gewählt. Dann kann ich eine Funktion auf `(B)` definieren durch:\n\n\\[\nf_{a_0}:B\\rightarrow C\\tag{M1.197}\n\\]\n\nWord-LaTeX: `f_{a_0}:B\\rightarrow C`\n\nmit:\n\n\\[\nf_{a_0}(b)=f(a_0,b)\\tag{M1.198}\n\\]\n\nWord-LaTeX: `f_{a_0}(b)=f(a_0,b)`\n\nEntsprechend kann ich bei festem `(b_0\\in B)` eine Funktion auf `(A)` betrachten:\n\n\\[\nf^{b_0}:A\\rightarrow C\\tag{M1.199}\n\\]\n\nWord-LaTeX: `f^{b_0}:A\\rightarrow C`\n\nmit:\n\n\\[\nf^{b_0}(a)=f(a,b_0)\\tag{M1.200}\n\\]\n\nWord-LaTeX: `f^{b_0}(a)=f(a,b_0)`\n\nFür mich ist diese Konstruktion deshalb wichtig, weil sie eine klare Trennung zwischen einer variablen Eingangsgröße und einer festgehaltenen Größe ermöglicht. Die Fixierung verändert die betrachtete Funktion, obwohl sie aus derselben ursprünglichen Zuordnung hervorgeht.\n\n### M1.10.3 Parametrisierte Funktionsfamilien\n\nVon der Fixierung eines Arguments unterscheide ich eine parametrisierte Funktionsfamilie. Dabei betrachte ich von Anfang an eine Menge von Funktionen, die durch einen Parameter unterschieden werden.\n\nSei `(\\Theta)` eine Parametermenge. Eine durch `(\\theta\\in\\Theta)` indizierte Funktionsfamilie schreibe ich als:\n\n\\[\n\\left\\{f_\\theta\\mid\\theta\\in\\Theta\\right\\}\\tag{M1.201}\n\\]\n\nWord-LaTeX: `\\left\\{f_\\theta\\mid\\theta\\in\\Theta\\right\\}`\n\nBesitzen alle Funktionen denselben Definitions- und Zielbereich, gilt:\n\n\\[\nf_\\theta:A\\rightarrow B\\qquad\\forall\\theta\\in\\Theta\\tag{M1.202}\n\\]\n\nWord-LaTeX: `f_\\theta:A\\rightarrow B\\qquad\\forall\\theta\\in\\Theta`\n\nDamit ordnet jeder feste Parameterwert `(\\theta)` eine bestimmte Funktion `(f_\\theta)` aus der Familie zu.\n\nIch kann dieselbe Familie auch durch eine einzige Funktion auf einem Produktbereich beschreiben:\n\n\\[\nF:\\Theta\\times A\\rightarrow B\\tag{M1.203}\n\\]\n\nWord-LaTeX: `F:\\Theta\\times A\\rightarrow B`\n\nmit der Beziehung:\n\n\\[\nF(\\theta,a)=f_\\theta(a)\\tag{M1.204}\n\\]\n\nWord-LaTeX: `F(\\theta,a)=f_\\theta(a)`\n\nDiese beiden Darstellungen möchte ich auseinanderhalten. In `(\\left\\{f_\\theta\\mid\\theta\\in\\Theta\\right\\})` steht der Parameter für die Auswahl eines Funktionsobjekts. In `(F(\\theta,a))` erscheint er dagegen als eine Komponente eines zusammengesetzten Arguments.\n\nMathematisch lassen sich beide Sichtweisen miteinander verbinden. Begrifflich erfüllen `(\\theta)` und `(a)` jedoch unterschiedliche Rollen: `(\\theta)` kennzeichnet die betrachtete Funktion innerhalb der Familie, während `(a)` das Argument dieser Funktion ist.\n\n### M1.10.4 Parameter besitzen keine vorgegebene Interpretation\n\nGerade bei parametrisierten Funktionen möchte ich eine methodische Grenze ausdrücklich festhalten. Aus der Schreibweise `(f_\\theta)` folgt keine besondere Bedeutung des Parameters `(\\theta)`.\n\nDer Parameter kann eine Zahl, ein Index, ein Vektor oder ein Element einer beliebigen geeigneten Menge sein. Er kann eine geometrische, statistische oder andere mathematische Rolle erhalten. Eine zeitliche oder physikalische Interpretation folgt daraus jedoch nicht.\n\nInsbesondere darf aus einer Familie `(f_t)` nicht allein aufgrund des Symbols `(t)` geschlossen werden, dass eine zeitliche Entwicklung vorliegt. Die mathematische Struktur liefert zunächst nur eine durch `(t)` indizierte Familie von Funktionen.\n\nDiese Zurückhaltung ist für mich wichtig, weil Parametrisierung und Dynamik leicht miteinander verwechselt werden können. Eine Dynamik benötigt zusätzliche Aussagen darüber, welche Bedeutung der Parameter besitzt und welche Beziehungen zwischen unterschiedlichen Parameterwerten gelten.\n\n### M1.10.5 Partielle Funktionen\n\nBislang habe ich Funktionen `(f:A\\rightarrow B)` so definiert, dass zu jedem `(a\\in A)` genau ein Funktionswert existiert. Es gibt jedoch Situationen, in denen zunächst ein größerer Grundbereich `(A)` betrachtet wird, die eigentliche Zuordnung aber nur auf einem Teilbereich `(D\\subseteq A)` definiert ist.\n\nIch beschreibe eine solche partielle Funktion auf `(A)` durch:\n\n\\[\nD\\subseteq A\\tag{M1.205}\n\\]\n\nWord-LaTeX: `D\\subseteq A`\n\nund:\n\n\\[\nf:D\\rightarrow B\\tag{M1.206}\n\\]\n\nWord-LaTeX: `f:D\\rightarrow B`\n\nDie Funktion selbst ist damit weiterhin eine gewöhnliche Funktion auf ihrem tatsächlichen Definitionsbereich `(D)`. Das Wort „partiell“ bezieht sich ausschließlich darauf, dass `(D)` nur ein Teil des ursprünglich betrachteten Grundbereichs `(A)` ist.\n\nFür jedes `(d\\in D)` gilt daher weiterhin die vollständige Funktionsbedingung:\n\n\\[\n\\forall d\\in D\\ \\exists!b\\in B:f(d)=b\\tag{M1.207}\n\\]\n\nWord-LaTeX: `\\forall d\\in D\\ \\exists!b\\in B:f(d)=b`\n\nFür `(a\\in A\\setminus D)` ist dagegen innerhalb dieser Funktion kein Funktionswert definiert.\n\nDiese Nichtdefiniertheit möchte ich nicht mit einem besonderen Wert in `(B)` gleichsetzen. Wenn ein zusätzliches Symbol für „nicht definiert“ in den Zielbereich aufgenommen wird, entsteht eine andere, nun auf `(A)` vollständig definierte Funktion. Das ist eine mathematische Erweiterung und keine bloße alternative Schreibweise.\n\n### M1.10.6 Definitionsbereich einer partiellen Funktion\n\nDie tatsächliche Definitionsmenge kann ich aus einer partiellen Zuordnung heraus ausdrücklich kennzeichnen:\n\n\\[\n\\operatorname{dom}(f)=D\\subseteq A\\tag{M1.208}\n\\]\n\nWord-LaTeX: `\\operatorname{dom}(f)=D\\subseteq A`\n\nDie Unterscheidung zwischen `(A)` und `(D)` besitzt damit eine ähnliche Funktion wie die frühere Trennung zwischen Zielbereich `(B)` und Bildmenge `(\\operatorname{im}(f))`.\n\n`(A)` bezeichnet den zunächst betrachteten Grundbereich möglicher Eingaben. `(D)` bezeichnet dagegen genau diejenigen Eingaben, für welche die betrachtete Funktion tatsächlich definiert ist.\n\nFür mich ergibt sich daraus eine wichtige methodische Regel: Sobald eine Funktion nur auf einem Teilbereich definiert ist, muss dieser tatsächliche Definitionsbereich ausdrücklich bekannt sein. Andernfalls wäre nicht entscheidbar, für welche Argumente die Funktionsschreibweise überhaupt zulässig ist.\n\n### M1.10.7 Einschränkung und partielle Funktion\n\nDie bereits in M1.6 eingeführte Einschränkung einer Funktion liefert unmittelbar ein Beispiel für eine partielle Betrachtung bezüglich eines größeren Grundbereichs.\n\nIst `(f:A\\rightarrow B)` vollständig definiert und `(D\\subseteq A)`, dann gilt:\n\n\\[\nf|_D:D\\rightarrow B\\tag{M1.209}\n\\]\n\nWord-LaTeX: `f|_D:D\\rightarrow B`\n\nDiese Einschränkung kann als partielle Funktion bezüglich des größeren Grundbereichs `(A)` betrachtet werden.\n\nUmgekehrt folgt aus einer partiellen Funktion `(f:D\\rightarrow B)` jedoch nicht automatisch, dass eine Erweiterung auf den gesamten Grundbereich `(A)` existiert oder eindeutig bestimmt ist.\n\nEine Erweiterung wäre eine Funktion `(F:A\\rightarrow B)`, für die gelten müsste:\n\n\\[\nF|_D=f\\tag{M1.210}\n\\]\n\nWord-LaTeX: `F|_D=f`\n\nOb eine solche Funktion existiert und wie sie außerhalb von `(D)` festgelegt wird, ist eine zusätzliche mathematische Frage.\n\n### M1.10.8 Partielle Funktionen als spezielle Relationen\n\nAuch eine partielle Funktion kann ich weiterhin relational beschreiben. Ihr Graph liegt in `(A\\times B)`, obwohl seine tatsächlich auftretenden ersten Komponenten nur aus `(D)` stammen.\n\n\\[\nG_f=\\left\\{(d,f(d))\\mid d\\in D\\right\\}\\subseteq A\\times B\\tag{M1.211}\n\\]\n\nWord-LaTeX: `G_f=\\left\\{(d,f(d))\\mid d\\in D\\right\\}\\subseteq A\\times B`\n\nFür jedes Element von `(D)` existiert genau ein entsprechendes Paar, während für Elemente aus `(A\\setminus D)` kein Paar im Graphen vorhanden ist.\n\nDamit wird die Verbindung zum Ausgangspunkt von M1 erneut sichtbar. Die partielle Funktion bleibt eine Relation mit eindeutiger zweiter Komponente für jede tatsächlich vorkommende erste Komponente. Der Unterschied zur vollständig auf `(A)` definierten Funktion besteht in der fehlenden Existenzforderung für Elemente außerhalb von `(D)`. [[6]]\n\n### M1.10.9 Ergebnis und Weitergabestelle\n\nMit mehrstelligen, parametrisierten und partiellen Funktionen habe ich den allgemeinen Funktionsbegriff in drei Richtungen erweitert, ohne seine grundlegende Eindeutigkeitsstruktur aufzugeben.\n\nMehrere Eingangsgrößen fasse ich als Komponenten eines geordneten Tupels zusammen. Eine mehrstellige Funktion ist deshalb eine gewöhnliche Funktion auf einem kartesischen Produkt. Durch Fixierung einzelner Komponenten können daraus Funktionen mit weniger variablen Argumenten entstehen.\n\nEine parametrisierte Familie besteht dagegen aus mehreren Funktionen, die über einen Parameter unterschieden werden. Der Parameter wählt ein Funktionsobjekt aus der Familie aus. Seine mathematische Bezeichnung begründet noch keine zeitliche, physikalische oder andere zusätzliche Interpretation.\n\nBei einer partiellen Funktion unterscheide ich schließlich zwischen einem zunächst betrachteten Grundbereich `(A)` und dem tatsächlichen Definitionsbereich `(D\\subseteq A)`. Die Funktionsbedingung gilt vollständig auf `(D)`; außerhalb von `(D)` wird kein Funktionswert vorausgesetzt.\n\nDamit ist der funktionale Aufbau von M1 inhaltlich geschlossen. Ausgehend von Mengen und Elementzugehörigkeit habe ich Teilmengen, Potenzmengen und Mengenoperationen entwickelt, anschließend über geordnete Paare und kartesische Produkte den Relationsbegriff aufgebaut und daraus Funktionen durch Existenz und Eindeutigkeit gewonnen. Injektivität, Surjektivität und Bijektivität haben zusätzliche Zuordnungseigenschaften bestimmt. Bild und Urbild haben die Funktionswirkung auf Teilmengen übertragen, und die Komposition hat mehrere Funktionen zu strukturierten Funktionsketten verbunden. Mehrstellige, parametrisierte und partielle Funktionen vervollständigen diesen Bestand.\n\nDie **Weitergabestelle M1.10 → M1.11** liegt deshalb nicht mehr bei der Einführung einer weiteren mathematischen Grundstruktur. **M1.11 Ergebnisbestand und Übergabe von M1** bündelt im nächsten Schritt die tatsächlich erarbeiteten Resultate, ordnet ihre Voraussetzungen und Aussagegrenzen und bestimmt ausdrücklich, welche mathematischen Strukturen M1 an M2 und an den erst später zu erarbeitenden Haupttext weitergibt.', 'e064b52b902a2c040fe31d696ce1a6aba77f4f7ebe7453c08ef3999dd8147fb8', 'Vollständiger Reset-Neuaufsatz M1.10; persönlicher wissenschaftlicher Schreibstil und Ich-Form; Halmos nur als Folgezitation [[6]].');
INSERT INTO `appendix_section_versions` (`appendix_section_version_id`, `appendix_section_id`, `revision_id`, `version_kind`, `body_markdown`, `checksum_sha256`, `notes`) VALUES
(12, 12, 24, 'review', '## M1.11 Ergebnisbestand und Übergabe von M1\n\nMit M1 ist die erste mathematische Grundschicht abgeschlossen. Ich habe bewusst bei der elementarsten Struktur begonnen und jeden weiteren Begriff erst dann eingeführt, wenn die zuvor vorhandenen Mittel für die nächste Aussage nicht mehr ausreichten. Dadurch ist aus Mengen, geordneten Strukturen, Relationen und Funktionen kein bloßes Nebeneinander von Definitionen entstanden, sondern eine klar erkennbare Abhängigkeitsordnung.\n\nFür mich ist dieser Abschluss besonders wichtig, weil M1 nicht nur festhalten soll, **welche** mathematischen Werkzeuge nun zur Verfügung stehen. Ebenso muss eindeutig erkennbar sein, **welche Voraussetzungen** zu diesen Werkzeugen gehören, **welche Aussagen daraus tatsächlich folgen** und **welche weitergehenden Bedeutungen gerade noch nicht enthalten sind**. Genau dieser geprüfte Ergebnisbestand bildet die Übergabe an die nächsten mathematischen Anlagen und später an den Haupttext.\n\n### M1.11.1 Ergebnisbestand der Mengenstruktur\n\nAm Anfang steht die Mengenebene. Mit einer Menge `(A)` kann ich einen mathematischen Objektbereich bestimmen und mit `(x\\in A)` ausdrücken, dass ein Objekt diesem Bereich angehört. Die Elementrelation und die Gleichheit mathematischer Objekte bleiben dabei strikt getrennt.\n\nDie Identität einer Menge wird durch ihren Elementbestand bestimmt. Zwei Mengen `(A)` und `(B)` sind genau dann gleich, wenn sie dieselben Elemente besitzen. Daraus ergibt sich zugleich die wechselseitige Teilmengencharakterisierung der Mengengleichheit.\n\nMit `(A\\subseteq B)` kann ich anschließend ausdrücken, dass sämtliche Elemente von `(A)` auch zu `(B)` gehören. Die echte Teilmengenbeziehung ergänzt diese Aussage um `(A\\neq B)`. Teilmengenbeziehungen bilden damit eine eigene Struktur zwischen Mengen und dürfen nicht mit Elementbeziehungen verwechselt werden.\n\nDie Potenzmenge `(\\mathcal{P}(A))` hebt diese Ebenentrennung noch deutlicher hervor. Ihre Elemente sind selbst Mengen, nämlich sämtliche Teilmengen von `(A)`. Damit steht bereits auf der elementaren Ebene eine Struktur zur Verfügung, in der mathematische Objekte höherer Ordnung auftreten können.\n\nFür den weiteren Aufbau nehme ich daraus mit, dass zwischen `(a)`, `(\\left\\{a\\right\\})`, einer Teilmenge `(A\\subseteq B)` und einer Menge von Mengen jeweils unterschiedliche Strukturebenen bestehen. Diese Ebenen dürfen später nicht allein aufgrund ähnlicher Notationen ineinander überführt werden.\n\n### M1.11.2 Ergebnisbestand der Mengenoperationen\n\nMit Vereinigung, Durchschnitt, Differenz und Komplement kann ich aus vorhandenen Mengen neue Mengen konstruieren. Die Vereinigung erfasst diejenigen Elemente, die mindestens einer der betrachteten Mengen angehören. Der Durchschnitt isoliert den gemeinsamen Elementbestand. Die Differenz entfernt aus einer Menge diejenigen Elemente, die zugleich einer zweiten Menge angehören.\n\nFür das Komplement muss zusätzlich eine Grundmenge festgelegt sein. Diese Abhängigkeit ist für mich ein wichtiges Beispiel dafür, dass mathematische Begriffe häufig nur relativ zu einer bereits bestimmten Struktur vollständig definiert sind.\n\nDie De-Morgan-Beziehungen sowie die Distributivgesetze zeigen, dass die Mengenoperationen nicht unabhängig voneinander stehen. Sie bilden ein zusammenhängendes logisches System, innerhalb dessen komplexere Mengenbedingungen kontrolliert umgeformt werden können.\n\nAus diesen Operationen folgt jedoch noch keine Ordnung der Elemente. Auch eine durch mehrere Operationen konstruierte Menge bleibt hinsichtlich der Position ihrer Elemente ungeordnet.\n\n### M1.11.3 Ergebnisbestand geordneter Strukturen\n\nDiese Grenze wird durch geordnete Paare überschritten. Das geordnete Paar `((a,b))` erhält nicht nur die beiden beteiligten Komponenten, sondern auch ihre Positionen. Damit kann ich zwischen `((a,b))` und `((b,a))` unterscheiden, sofern `(a\\neq b)` gilt.\n\nDas kartesische Produkt `(A\\times B)` fasst sämtliche formal möglichen geordneten Paare mit erster Komponente aus `(A)` und zweiter Komponente aus `(B)` zusammen. Für mich ist dabei entscheidend, dass das kartesische Produkt noch keine ausgezeichnete Beziehung zwischen seinen Elementen enthält. Es beschreibt lediglich den vollständigen Möglichkeitsraum der Paarungen.\n\nDie Erweiterung auf `(n)`-Tupel und Produkte `(A_1\\times\\cdots\\times A_n)` erlaubt es, beliebig viele endlich viele Komponenten positionsabhängig zusammenzufassen. Über die Projektionen `(\\pi_i)` können die einzelnen Komponenten anschließend wieder eindeutig ausgewählt werden.\n\nDamit steht die Struktur bereit, auf der Relationen und mehrstellige Funktionen aufbauen.\n\n### M1.11.4 Ergebnisbestand der Relationen\n\nEine Relation `(R\\subseteq A\\times B)` wählt aus den formal möglichen Paaren genau diejenigen aus, die zur betrachteten Beziehungsstruktur gehören. Damit entsteht erstmals eine mathematische Verbindung zwischen ausgewählten Elementen zweier Mengen.\n\nDer Relationsbegriff bleibt bewusst allgemein. Ein Ausgangselement kann mit keinem, einem oder mehreren Zielelementen in Relation stehen. Existenz und Eindeutigkeit sind noch nicht vorausgesetzt.\n\nFür Relationen auf einer Menge `(A)` stehen zusätzlich strukturelle Eigenschaften wie Reflexivität, Irreflexivität, Symmetrie, Antisymmetrie, Asymmetrie und Transitivität zur Verfügung. Bestimmte Kombinationen dieser Eigenschaften erzeugen Äquivalenzrelationen und Ordnungsrelationen.\n\nMit Äquivalenzklassen kann ich Elemente eines Objektbereichs entsprechend einer festgelegten Äquivalenzrelation zu Klassen zusammenfassen. Die Quotientenmenge `(A/R)` enthält anschließend diese Klassen als neue Elemente. Auch hier entsteht also erneut eine höhere Strukturebene.\n\nRelationen können außerdem umgekehrt und miteinander komponiert werden. Die Umkehrrelation existiert für jede Relation, während die Komposition passende Zwischenbereiche voraussetzt. Diese beiden Operationen dürfen später nicht mit der stärkeren Struktur inverser Funktionen verwechselt werden.\n\n### M1.11.5 Ergebnisbestand des Funktionsbegriffs\n\nEine Funktion entsteht aus dem Relationsbegriff durch die zusätzliche Forderung vollständiger Existenz und Eindeutigkeit auf ihrem Definitionsbereich. Für `(f:A\\rightarrow B)` muss zu jedem `(a\\in A)` genau ein `(b\\in B)` existieren.\n\nDamit kann ich die Funktion weiterhin relational über ihren Graphen `(G_f)` behandeln, ohne die mengentheoretische Grundlage zu verlassen.\n\nFür mich ist die Trennung zwischen Definitionsbereich `(A)`, Zielbereich `(B)` und Bildmenge `(\\operatorname{im}(f))` dabei wesentlich. Der Definitions- und Zielbereich gehören zur Festlegung der Funktion. Das Bild entsteht dagegen aus den tatsächlich angenommenen Funktionswerten.\n\nAuch die Gleichheit von Funktionen setzt mehr voraus als eine äußerlich gleiche Funktionsvorschrift. Definitionsbereich, Zielbereich und sämtliche Funktionswerte müssen übereinstimmen.\n\nMit Einschränkungen kann eine Funktion auf einen Teil ihres Definitionsbereichs begrenzt werden. Die Identitätsfunktion liefert eine besondere Funktion, die jedes Element unverändert lässt und später als neutrales Element der Komposition dient.\n\nSchließlich können Funktionen selbst wieder Elemente von Mengen sein. Mit `(B^A)` steht die Menge aller Funktionen von `(A)` nach `(B)` zur Verfügung. Damit setzt sich die bereits bei Potenzmengen sichtbare Ebenenstruktur auf der Funktionsebene fort.\n\n### M1.11.6 Ergebnisbestand von Injektivität, Surjektivität und Bijektivität\n\nDie gewöhnliche Funktionsdefinition garantiert nur, dass jedes Argument genau einen Funktionswert besitzt. Sie garantiert noch nicht, dass unterschiedliche Argumente unterschiedliche Werte besitzen.\n\nDiese zusätzliche Eigenschaft liefert die Injektivität. Sie ermöglicht den eindeutigen Rückschluss von einem Funktionswert auf das zugehörige Argument, sofern der Funktionswert tatsächlich im Bild liegt.\n\nDie Surjektivität betrifft dagegen die Beziehung zwischen Bild und Zielbereich. Sie verlangt, dass jedes Element des Zielbereichs tatsächlich angenommen wird.\n\nErst die Bijektivität verbindet beide Eigenschaften. In diesem Fall besitzt jedes Zielelement genau ein Urbild, und die Funktion kann durch eine eindeutig bestimmte Umkehrfunktion invertiert werden.\n\nFür mich bleibt dabei die Grenze zur Interpretation wesentlich: mathematische Invertierbarkeit ist zunächst ausschließlich eine Eigenschaft der Zuordnung. Sie enthält keine Aussage über zeitliche oder physikalische Reversibilität.\n\n### M1.11.7 Ergebnisbestand von Bild und Urbild\n\nMit Bild- und Urbildbildung kann ich die Wirkung einer Funktion auf ganzen Teilmengen untersuchen.\n\nFür `(C\\subseteq A)` erzeugt `(f(C))` eine Teilmenge des Zielbereichs. Für `(D\\subseteq B)` liefert `(f^{-1}(D))` dagegen diejenigen Elemente des Definitionsbereichs, deren Funktionswert in `(D)` liegt.\n\nDie beiden Richtungen besitzen unterschiedliche strukturelle Eigenschaften. Die direkte Bildbildung erhält Vereinigungen allgemein, Durchschnitte und Differenzen jedoch nur unter zusätzlichen Voraussetzungen vollständig. Die Urbildbildung erhält Vereinigung, Durchschnitt, Differenz und Komplement dagegen ohne Injektivitäts- oder Surjektivitätsannahme exakt.\n\nInjektivität und Surjektivität erhalten dadurch eine zusätzliche mengentheoretische Bedeutung. Die Injektivität ermöglicht die vollständige Rückgewinnung einer Teilmenge des Definitionsbereichs nach Bild- und Urbildbildung. Die Surjektivität ermöglicht entsprechend die vollständige Rückgewinnung einer Teilmenge des Zielbereichs nach Urbild- und Bildbildung.\n\n### M1.11.8 Ergebnisbestand der Funktionskomposition\n\nDie Komposition `(g\\circ f)` verbindet zwei zueinander passende Funktionen zu einer neuen Funktion. Entscheidend ist dabei die Bereichsstruktur: Der Funktionswert der zuerst angewendeten Funktion muss ein zulässiges Argument der folgenden Funktion sein.\n\nDie Identitätsfunktion wirkt bezüglich dieser Komposition neutral. Die Komposition ist assoziativ, aber nicht allgemein kommutativ. Die Reihenfolge der Funktionen bleibt damit Bestandteil der mathematischen Struktur.\n\nInjektivität, Surjektivität und Bijektivität bleiben erhalten, wenn Funktionen mit derselben jeweiligen Eigenschaft komponiert werden.\n\nFür bijektive Funktionen kehrt die inverse Funktion einer Komposition die Reihenfolge der ursprünglichen Verkettung um. Auch dies folgt vollständig aus der mathematischen Kompositionsstruktur und besitzt noch keine zeitliche Interpretation.\n\n### M1.11.9 Ergebnisbestand mehrstelliger Funktionen\n\nMehrere Eingangsgrößen benötigen keinen neuen Funktionsbegriff. Sie werden durch ein kartesisches Produkt zu einem einzigen zusammengesetzten Argumentbereich zusammengefasst.\n\nEine Funktion `(f:A_1\\times\\cdots\\times A_n\\rightarrow B)` ist damit weiterhin eine gewöhnliche Funktion. Ihre Argumente sind lediglich `(n)`-Tupel.\n\nDiese Sicht ist für mich besonders wichtig, weil sie verhindert, dass Mehrstelligkeit fälschlich als zusätzliche mathematische Grundstruktur behandelt wird. Die eigentliche Erweiterung liegt bereits vollständig in der zuvor eingeführten Tupel- und Produktstruktur.\n\nDurch Fixierung einzelner Komponenten können aus einer mehrstelligen Funktion neue Funktionen mit weniger variablen Argumenten entstehen. Damit steht eine kontrollierte Möglichkeit zur Verfügung, verschiedene Rollen innerhalb eines zusammengesetzten Arguments voneinander zu trennen.\n\n### M1.11.10 Ergebnisbestand parametrisierter Funktionsfamilien\n\nEine parametrisierte Familie `(\\left\\{f_\\theta\\mid\\theta\\in\\Theta\\right\\})` fasst mehrere Funktionen zusammen, die durch einen Parameterwert `(\\theta)` unterschieden werden.\n\nDiese Struktur kann äquivalent über eine Funktion `(F:\\Theta\\times A\\rightarrow B)` beschrieben werden. Begrifflich möchte ich dennoch unterscheiden, ob `(\\theta)` ein Funktionsobjekt innerhalb einer Familie auswählt oder als Komponente eines zusammengesetzten Arguments betrachtet wird.\n\nBesonders wichtig ist mir hier die Aussagegrenze: Ein Parameter besitzt zunächst keine vorgegebene physikalische Bedeutung. Insbesondere folgt aus einem Symbol wie `(t)` keine Zeitentwicklung. Eine solche Interpretation benötigt zusätzliche Voraussetzungen.\n\n### M1.11.11 Ergebnisbestand partieller Funktionen\n\nBei einer partiellen Funktion unterscheide ich zwischen einem zunächst betrachteten Grundbereich `(A)` und dem tatsächlichen Definitionsbereich `(D\\subseteq A)`.\n\nDie Funktion `(f:D\\rightarrow B)` ist auf `(D)` eine gewöhnliche vollständig definierte Funktion. „Partiell“ bezeichnet ausschließlich ihre Beziehung zum größeren Grundbereich `(A)`.\n\nFür Elemente aus `(A\\setminus D)` wird kein Funktionswert vorausgesetzt. Diese Nichtdefiniertheit ist nicht mit einem besonderen Element des Zielbereichs gleichzusetzen.\n\nDamit ist auch hier der Definitionsbereich Bestandteil der mathematischen Aussage. Eine Funktion kann nur dort angewendet werden, wo ihre Definition tatsächlich besteht.\n\n### M1.11.12 Abhängigkeitsstruktur von M1\n\nAus allen Einzelergebnissen ergibt sich für mich nun eine eindeutige Abhängigkeitsordnung.\n\nEine Relation benötigt geordnete Paare. Geordnete Paare setzen unterscheidbare Mengenebenen voraus. Eine Funktion benötigt eine Relation und ergänzt sie um Existenz und Eindeutigkeit. Injektivität, Surjektivität und Bijektivität setzen bereits eine Funktion voraus. Bild und Urbild bauen auf Funktion und Mengenoperationen auf. Komposition benötigt Funktionen mit kompatiblen Bereichen. Mehrstellige Funktionen benötigen kartesische Produkte, parametrisierte Familien benötigen Mengen von Funktionen oder Produktbereiche, und partielle Funktionen benötigen die Unterscheidung zwischen Grundbereich und tatsächlichem Definitionsbereich.\n\nDiese Reihenfolge ist für mich nicht beliebig. Sie legt fest, welche mathematischen Voraussetzungen später vorhanden sein müssen, bevor ein bestimmter Begriff sinnvoll verwendet werden kann.\n\n### M1.11.13 Aussagegrenzen von M1\n\nEbenso wichtig wie der positive Ergebnisbestand sind die Grenzen dessen, was M1 gerade **nicht** liefert.\n\nEine Menge ist noch kein Vektorraum.\n\nEin kartesisches Produkt ist noch kein geometrischer Raum.\n\nEine Relation ist noch keine kausale Beziehung.\n\nEine Funktion ist noch kein zeitlicher Prozess.\n\nEine Bijektion ist noch keine physikalische Reversibilität.\n\nEine Funktionskomposition ist noch keine zeitliche Entwicklung.\n\nEin Parameter ist noch keine Zeit.\n\nMehrere Argumente sind noch keine unabhängigen Dimensionen.\n\nEine Funktionsfamilie ist noch kein dynamisches System.\n\nDiese Abgrenzungen halte ich bewusst fest, weil die folgenden Anlagen zusätzliche Strukturen einführen werden. Keine dieser späteren Eigenschaften darf rückwirkend so behandelt werden, als wäre sie bereits Bestandteil der mengentheoretischen und funktionalen Grundlage.\n\n### M1.11.14 Übergabe M1 → M2\n\nMit M1 kann ich mathematische Objektbereiche bestimmen, Beziehungen zwischen ihren Elementen formulieren und eindeutige Zuordnungen zwischen solchen Bereichen beschreiben. Was weiterhin fehlt, ist eine algebraische Struktur **innerhalb** eines Objektbereichs.\n\nInsbesondere kann ich mit den bisher eingeführten Mitteln noch nicht allgemein zwei Elemente `(x)` und `(y)` zu einem neuen Element `(x+y)` kombinieren. Ebenso ist keine Skalarmultiplikation `(\\lambda x)` vorausgesetzt. Begriffe wie Linearkombination, Spannraum, lineare Abhängigkeit, Basis oder Dimension stehen deshalb noch nicht zur Verfügung.\n\nGenau diese Grenze bestimmt die **Übergabestelle M1 → M2**.\n\n**M2 – Algebraische Grundlagen des Vektorraums** übernimmt aus M1 ausschließlich die bereits gesicherte Mengen- und Funktionsstruktur. Ein Vektorraum wird dort zunächst als besondere Menge von Elementen behandelt, auf der zusätzliche Operationen definiert werden. Erst M2 führt Vektoraddition und Skalarmultiplikation ein und prüft die dafür notwendigen Axiome.\n\nDie Übergaberichtung lautet damit ausdrücklich:\n\n**M1 – Mengen, Relationen und Funktionen → M2 – zusätzliche algebraische Struktur auf einem Objektbereich.**\n\nM2 darf die in M1 festgelegten Begriffe verwenden. Es darf jedoch keine algebraische Eigenschaft so behandeln, als wäre sie bereits aus dem Mengen- oder Funktionsbegriff entstanden.\n\n### M1.11.15 Übergabe von M1 an den späteren Haupttext\n\nNeben der unmittelbaren Übergabe an M2 besitzt M1 eine zweite, zeitlich spätere Rückgabestelle. Nach Abschluss der mathematischen Anlagen steht der hier geprüfte Ergebnisbestand dem später zu formulierenden Haupttext zur Verfügung.\n\nDer Haupttext muss M1 dabei nicht vollständig wiederholen. Er kann genau diejenigen Begriffe und Beziehungen übernehmen, die für seinen eigenen Argumentationsweg benötigt werden. Die mathematische Herleitung und die hier festgehaltenen Aussagegrenzen bleiben jedoch in M1 vollständig referenzierbar.\n\nDie Richtung bleibt eindeutig:\n\n**M1 → geprüfter Ergebnisbestand → späterer Haupttext.**\n\nDer Haupttext ist deshalb keine Quelle für M1. Er übernimmt später aus M1. Auf diese Weise bleibt erkennbar, welche Mathematik bereits unabhängig erarbeitet wurde und an welcher Stelle erst eine theoretische Auswahl oder Interpretation beginnt.\n\nMit dieser Übergabe ist **Anlage M1 – Mengentheoretische und funktionale Grundlagen** inhaltlich abgeschlossen. Der nächste mathematische Neuaufbau beginnt mit **M2 – Algebraische Grundlagen des Vektorraums**.', 'd1ad9ff3bfab373fb063c3e7ef8c0e6ba49fa5a185a27dd7831e3670c42169fa', 'Geprüfter Reset-Abschlussabschnitt von M1 ohne dargestellte Gleichungen; alle mathematischen Detailgleichungen liegen in M1.1 bis M1.10.'),
(13, 13, 25, 'draft', '# Anlage M2 – Algebraische Grundlagen des Vektorraums\n\n## M2.0 Gegenstand, Eingangsstelle und algebraische Erweiterung\n\nMit M1 steht mir eine mathematische Grundlage zur Verfügung, auf der ich Objektbereiche als Mengen behandeln, Beziehungen durch Relationen beschreiben und eindeutige Zuordnungen durch Funktionen formulieren kann. Diese Strukturen reichen jedoch noch nicht aus, sobald ich Elemente eines betrachteten Bereichs **miteinander verrechnen** möchte. Aus der bloßen Zugehörigkeit `(x\\in V)` folgt weder, dass ich zwei Elemente `(x)` und `(y)` addieren darf, noch dass ein Ausdruck wie `(\\lambda x)` überhaupt definiert ist. Genau an dieser Grenze beginnt M2.\n\nDie **Eingangsstelle M1 → M2** ist deshalb eindeutig bestimmt. M2 übernimmt aus M1 ausschließlich die bereits gesicherte Mengen- und Funktionsstruktur. Ich darf also Mengen, Teilmengen, Funktionen, kartesische Produkte und die dort bestimmten logischen Beziehungen verwenden. Eine Addition von Vektoren, eine Skalarmultiplikation, lineare Unabhängigkeit oder eine Dimension gehören dagegen noch nicht zum übernommenen Bestand. Diese Strukturen werden erst in M2 zusätzlich eingeführt.\n\nFür die algebraische Grundlegung orientiere ich mich zunächst an Serge Lang. `{[[Lang, Serge: Algebra. Revised Third Edition. New York: Springer, 2002, insbesondere Kapitel III „Modules“, Abschnitte zu Modulen und Vektorräumen.]]}[[71]]` Seine Darstellung ist für meinen Aufbau deshalb geeignet, weil der Vektorraum dort als algebraische Struktur über einem Körper erscheint und damit klar von einer bestimmten Koordinatendarstellung getrennt bleibt.\n\nErgänzend verwende ich Gilbert Strang. `{[[Strang, Gilbert: Introduction to Linear Algebra. Fifth Edition. Wellesley, MA: Wellesley-Cambridge Press, 2016, insbesondere Kapitel 3 „Vector Spaces and Subspaces“.]]}[[72]]` Für mich ist besonders hilfreich, dass dort Spannräume, lineare Unabhängigkeit, Basis und Dimension unmittelbar aus der algebraischen Struktur heraus entwickelt werden. Diese Begriffe bilden genau die Abhängigkeitskette, die ich in M2 benötige.\n\nIch beginne bewusst nicht mit Koordinatenvektoren wie `((x_1,\\ldots,x_n))`. Eine solche Darstellung wäre bereits eine spezielle Realisierung eines Vektorraums. Mein Ausgangspunkt soll allgemeiner sein. Ein Vektor ist zunächst ein Element `(v\\in V)` eines Objektbereichs `(V)`, auf dem zwei zusätzliche Operationen definiert werden. Erst wenn diese Operationen bestimmte Axiome erfüllen, darf ich `(V)` als Vektorraum bezeichnen.\n\nDiese Unterscheidung ist für mich wesentlich, weil der Begriff „Vektor“ leicht mit einem geometrischen Pfeil oder einer Spalte aus Zahlen gleichgesetzt wird. Beides sind wichtige Darstellungen, aber keine Definition des abstrakten mathematischen Objekts. Ein Element eines Funktionenraums kann ebenso ein Vektor sein wie eine Zahlenfolge oder eine Matrix, sofern der betrachtete Objektbereich mit geeigneter Addition und Skalarmultiplikation die Vektorraumaxiome erfüllt.\n\nDamit verschiebt sich die mathematische Fragestellung gegenüber M1. Dort musste ich zunächst entscheiden, **welche Objekte** zu einem Bereich gehören und **wie sie einander zugeordnet** werden können. In M2 frage ich nun, **welche algebraischen Operationen innerhalb dieses Bereichs zulässig sind** und welche Folgerungen aus ihren Axiomen entstehen.\n\nDie erste dieser Operationen ist eine innere Addition. Sie muss zwei Elemente des Vektorraums wieder auf ein Element desselben Vektorraums abbilden. Die zweite Operation verbindet einen Skalar mit einem Vektor. Dafür benötige ich neben `(V)` eine weitere algebraische Struktur, den Skalarkörper `(K)`. Schon an dieser Stelle wird sichtbar, dass ein Vektorraum nicht nur aus einer Menge von Vektoren besteht. Zu seiner vollständigen Festlegung gehören ebenso der verwendete Körper und die beiden Operationen.\n\nDie Wahl des Skalarkörpers möchte ich nicht stillschweigend treffen. Ein Vektorraum kann beispielsweise über den reellen Zahlen `(\\mathbb{R})` oder über den komplexen Zahlen `(\\mathbb{C})` definiert sein. Welche dieser Möglichkeiten später verwendet wird, kann mathematisch relevant werden. Insbesondere verändern sich bestimmte Aussagen über Eigenwerte und Spektren abhängig vom zugrunde liegenden Körper. In M2 selbst behandle ich den Vektorraum deshalb zunächst allgemein über einem Körper `(K)` und verwende konkrete reelle Beispiele erst dort, wo sie dem Verständnis einer allgemeinen Aussage dienen.\n\nAuf der Grundlage der Vektorraumaxiome kann ich anschließend Beziehungen ableiten, die nicht als zusätzliche Axiome eingeführt werden müssen. Dazu gehören beispielsweise die Eindeutigkeit des Nullvektors und des additiven Inversen sowie Beziehungen zwischen dem skalaren Nullelement `(0_K)` und dem Nullvektor `(0_V)`. Für mich ist diese Unterscheidung zwischen **Axiom** und **Folgerung** besonders wichtig. Eine mathematische Struktur soll nicht durch zusätzliche Voraussetzungen aufgebläht werden, wenn eine Aussage bereits aus den vorhandenen Axiomen folgt.\n\nDanach kann ich Teilmengen eines Vektorraums untersuchen. Eine beliebige Teilmenge `(U\\subseteq V)` ist noch kein Vektorraum. Erst wenn die relevanten Operationen innerhalb von `(U)` abgeschlossen bleiben, entsteht ein Untervektorraum. Damit verbindet sich die in M1 entwickelte Teilmengenstruktur erstmals mit den neuen algebraischen Operationen.\n\nDer nächste Schritt besteht für mich darin, nicht mehr nur einzelne Additionen oder Skalarmultiplikationen zu betrachten, sondern beide Operationen in Linearkombinationen zusammenzuführen. Aus Vektoren `(v_1,\\ldots,v_n)` und Skalaren `(\\lambda_1,\\ldots,\\lambda_n)` kann dadurch ein neuer Vektor erzeugt werden. Die Gesamtheit aller auf diese Weise erzeugbaren Vektoren führt zum Spannraum.\n\nErst an dieser Stelle wird die Frage nach Redundanz sinnvoll. Mehrere notierte Vektoren bedeuten noch nicht, dass jeder von ihnen eine zusätzliche algebraische Richtung beiträgt. Wenn ein Vektor bereits als Linearkombination der anderen dargestellt werden kann, erweitert er den erzeugten Raum nicht. Genau diese Unterscheidung führt zu linearer Abhängigkeit und linearer Unabhängigkeit.\n\nFür meinen weiteren mathematischen Aufbau ist dieser Punkt besonders wichtig. Ich möchte die Anzahl notierter Größen nicht mit der Anzahl unabhängiger Richtungen verwechseln. Erst die lineare Unabhängigkeit liefert das algebraische Kriterium, mit dem ich entscheiden kann, ob ein zusätzlicher Vektor tatsächlich eine neue Erzeugungsrichtung bereitstellt.\n\nBasis und Dimension dürfen deshalb erst **nach** Spannraum und linearer Unabhängigkeit eingeführt werden. Eine Basis verbindet zwei Eigenschaften: Sie erzeugt den gesamten Vektorraum und enthält zugleich keine lineare Redundanz. Erst wenn eine solche Basis endlich ist, kann ich ihre Anzahl als Dimension des Vektorraums verwenden.\n\nDamit erhält auch der Dimensionsbegriff eine klar begrenzte Bedeutung. Dimension ist in diesem Zusammenhang keine allgemeine Anzahl von Variablen, Merkmalen oder beobachteten Größen. Sie bezeichnet die Anzahl der Elemente einer Basis eines endlichdimensionalen Vektorraums. Wenn später eine zusätzliche mathematische Dimension behauptet werden soll, muss deshalb tatsächlich eine zusätzliche unabhängige Richtung nachgewiesen werden.\n\nKoordinaten entstehen erst **nach** der Basis. Ein Vektor `(v)` ist nicht sein Koordinatenvektor. Erst bezüglich einer gewählten Basis erhält `(v)` eine eindeutige Darstellung durch Skalarkoeffizienten. Diese Trennung werde ich in M2 bereits vorbereiten, ihre vollständige Bedeutung für Matrixdarstellungen und Basiswechsel gehört jedoch erst in M3.\n\nEbenso führe ich in M2 noch keine Längen, Winkel oder Orthogonalitätsbegriffe ein. Ein allgemeiner Vektorraum besitzt diese Strukturen nicht automatisch. Dazu wird später ein Skalarprodukt benötigt. Ich möchte deshalb auch anschauliche Begriffe wie „Richtung“ in M2 ausschließlich algebraisch verstehen: Eine unabhängige Richtung bezeichnet hier einen von den übrigen betrachteten Vektoren linear unabhängigen Beitrag zum Spannraum, noch keine geometrisch ausgezeichnete Raumrichtung.\n\nDamit ergibt sich für M2 folgende innere Abhängigkeitsstruktur:\n\n**Körper und Skalare → Vektorraum und Vektorraumaxiome → Nullvektor und additives Inverses → abgeleitete Nullbeziehungen → Untervektorräume → Linearkombinationen → Spannraum → lineare Abhängigkeit und Unabhängigkeit → Erzeugendensystem → Basis → Dimension → Koordinatendarstellung bezüglich einer Basis.**\n\nDiese Reihenfolge ist für mich verbindlich. Jeder nachfolgende Begriff setzt die zuvor benötigte Struktur voraus. Ich möchte insbesondere verhindern, dass Koordinaten, Dimension oder geometrische Vorstellungen bereits in die Definition des Vektorraums hineinwirken.\n\nDie **Rückgabe- und Übergabestelle von M2** wird nach Abschluss der Anlage aus einem geprüften algebraischen Ergebnisbestand bestehen. Dieser Bestand muss anschließend zwei Aufgaben erfüllen. Einerseits übernimmt M3 daraus Vektorräume, Basen und Koordinatendarstellungen als Voraussetzungen für lineare Abbildungen und deren Matrixdarstellungen. Andererseits steht der vollständige Ergebnisbestand später dem neu zu formulierenden Haupttext zur Verfügung.\n\nDie Begründungsrichtung bleibt damit:\n\n**M1 → M2 → geprüfter algebraischer Ergebnisbestand → M3 und späterer Haupttext.**\n\nDie **Weitergabestelle M2.0 → M2.1** liegt bei derjenigen Struktur, die noch vor dem eigentlichen Vektorraum geklärt werden muss. Eine Skalarmultiplikation setzt voraus, dass die verwendeten Skalare selbst aus einem mathematisch bestimmten Bereich stammen und dort die benötigten algebraischen Operationen besitzen. **M2.1 Körper und Skalare** bestimmt deshalb zunächst den Skalarkörper `(K)` und schafft damit die Voraussetzung für die anschließende vollständige Definition des Vektorraums.', 'b257bfdd24f3d1aab2cf766cbeef8c634f8316840dc7b2b94f760781538166c8', 'Kanonischer Reset-Text von M2.0; vollständig in Ich-Form und ohne Rückverweis auf ältere Fassungen.'),
(14, 14, 26, 'draft', '## M2.1 Körper und Skalare\n\nBevor ich einen Vektorraum definieren kann, muss ich den Bereich bestimmen, aus dem die Skalare stammen. Die Skalarmultiplikation eines Vektorraums verbindet später ein Element des Vektorraums mit einem Skalar. Damit diese Operation algebraisch kontrolliert werden kann, dürfen die Skalare nicht lediglich eine beliebige Menge bilden. Sie benötigen selbst eine Struktur, in der Addition, Multiplikation, additive Inversen und – mit Ausnahme der Null – multiplikative Inversen eindeutig definiert sind.\n\nIch bezeichne diesen Skalarkörper mit `(K)`. Seine Elemente nenne ich Skalare. Die Bezeichnung „Skalar“ beschreibt dabei zunächst ausschließlich die Rolle eines Elements des Körpers innerhalb der späteren Vektorraumstruktur. Sie enthält noch keine Aussage darüber, ob es sich beispielsweise um eine reelle oder komplexe Zahl handelt. [[71]]\n\n### M2.1.1 Die beiden Körperoperationen\n\nAuf `(K)` benötige ich zunächst zwei innere Verknüpfungen. Die Addition ist eine Funktion:\n\n\\[\n+:K\\times K\\rightarrow K\\tag{M2.1}\n\\]\n\nWord-LaTeX: `+:K\\times K\\rightarrow K`\n\nFür `(a,b\\in K)` schreibe ich das Ergebnis dieser Operation als:\n\n\\[\n(a,b)\\mapsto a+b\\tag{M2.2}\n\\]\n\nWord-LaTeX: `(a,b)\\mapsto a+b`\n\nDie Multiplikation ist ebenfalls eine innere Verknüpfung:\n\n\\[\n\\cdot:K\\times K\\rightarrow K\\tag{M2.3}\n\\]\n\nWord-LaTeX: `\\cdot:K\\times K\\rightarrow K`\n\nund wird geschrieben als:\n\n\\[\n(a,b)\\mapsto ab\\tag{M2.4}\n\\]\n\nWord-LaTeX: `(a,b)\\mapsto ab`\n\nBereits die Funktionssignaturen enthalten eine wesentliche Aussage. Werden zwei Elemente aus `(K)` addiert oder multipliziert, liegt das Ergebnis erneut in `(K)`. Die Abgeschlossenheit beider Operationen muss deshalb nicht als davon unabhängige zusätzliche Eigenschaft formuliert werden; sie ist bereits Bestandteil der Festlegung der beiden inneren Verknüpfungen.\n\n### M2.1.2 Additive Struktur des Körpers\n\nBezüglich der Addition muss `(K)` eine kommutative Gruppenstruktur besitzen. Für alle `(a,b,c\\in K)` gilt zunächst die Assoziativität:\n\n\\[\n(a+b)+c=a+(b+c)\\tag{M2.5}\n\\]\n\nWord-LaTeX: `(a+b)+c=a+(b+c)`\n\nAußerdem ist die Addition kommutativ:\n\n\\[\na+b=b+a\\tag{M2.6}\n\\]\n\nWord-LaTeX: `a+b=b+a`\n\nEs existiert ein additives neutrales Element, das ich mit `(0_K)` kennzeichne:\n\n\\[\n\\exists 0_K\\in K\\ \\forall a\\in K:a+0_K=a\\tag{M2.7}\n\\]\n\nWord-LaTeX: `\\exists 0_K\\in K\\ \\forall a\\in K:a+0_K=a`\n\nZu jedem Skalar existiert ein additives inverses Element:\n\n\\[\n\\forall a\\in K\\ \\exists(-a)\\in K:a+(-a)=0_K\\tag{M2.8}\n\\]\n\nWord-LaTeX: `\\forall a\\in K\\ \\exists(-a)\\in K:a+(-a)=0_K`\n\nDamit kann ich die Subtraktion als abgeleitete Operation verstehen:\n\n\\[\na-b=a+(-b)\\tag{M2.9}\n\\]\n\nWord-LaTeX: `a-b=a+(-b)`\n\nFür mich ist diese Reihenfolge wichtig. Die Subtraktion ist kein zusätzliches unabhängiges Grundaxiom des Körpers. Sie wird durch Addition und additives Inverses vollständig bestimmt.\n\n### M2.1.3 Multiplikative Struktur\n\nFür die Multiplikation benötige ich ebenfalls eine assoziative und kommutative Struktur. Für alle `(a,b,c\\in K)` gilt:\n\n\\[\n(ab)c=a(bc)\\tag{M2.10}\n\\]\n\nWord-LaTeX: `(ab)c=a(bc)`\n\nund:\n\n\\[\nab=ba\\tag{M2.11}\n\\]\n\nWord-LaTeX: `ab=ba`\n\nEs existiert ein multiplikatives neutrales Element `(1_K)`:\n\n\\[\n\\exists 1_K\\in K\\ \\forall a\\in K:1_Ka=a\\tag{M2.12}\n\\]\n\nWord-LaTeX: `\\exists 1_K\\in K\\ \\forall a\\in K:1_Ka=a`\n\nDabei muss gelten:\n\n\\[\n1_K\\neq 0_K\\tag{M2.13}\n\\]\n\nWord-LaTeX: `1_K\\neq 0_K`\n\nDiese Unterscheidung verhindert, dass die Körperstruktur auf ein einziges Element zusammenfällt.\n\nFür jedes von Null verschiedene Element existiert ein multiplikatives Inverses:\n\n\\[\n\\forall a\\in K\\setminus\\left\\{0_K\\right\\}\\ \\exists a^{-1}\\in K:aa^{-1}=1_K\\tag{M2.14}\n\\]\n\nWord-LaTeX: `\\forall a\\in K\\setminus\\left\\{0_K\\right\\}\\ \\exists a^{-1}\\in K:aa^{-1}=1_K`\n\nDie Null ist davon ausdrücklich ausgeschlossen. Ein multiplikatives Inverses von `(0_K)` ist in einem Körper nicht definiert.\n\nDamit kann ich für `(b\\neq 0_K)` die Division als abgeleitete Operation schreiben:\n\n\\[\n\\frac{a}{b}=ab^{-1}\\tag{M2.15}\n\\]\n\nWord-LaTeX: `\\frac{a}{b}=ab^{-1}`\n\nAuch die Division ist damit keine zusätzliche primitive Körperoperation, sondern folgt aus Multiplikation und multiplikativer Inversenbildung.\n\n### M2.1.4 Distributivgesetz als Verbindung beider Operationen\n\nAddition und Multiplikation dürfen nicht als zwei voneinander unabhängige Strukturen nebeneinanderstehen. Sie werden durch das Distributivgesetz miteinander verbunden.\n\nFür alle `(a,b,c\\in K)` gilt:\n\n\\[\na(b+c)=ab+ac\\tag{M2.16}\n\\]\n\nWord-LaTeX: `a(b+c)=ab+ac`\n\nAufgrund der Kommutativität der Multiplikation folgt entsprechend:\n\n\\[\n(a+b)c=ac+bc\\tag{M2.17}\n\\]\n\nWord-LaTeX: `(a+b)c=ac+bc`\n\nDamit ist diejenige algebraische Grundstruktur vorhanden, die ich für die spätere Skalarmultiplikation benötige. [[71]]\n\n### M2.1.5 Eindeutigkeit der neutralen Elemente\n\nEinige Eigenschaften möchte ich nicht als zusätzliche Körperaxiome voraussetzen, weil sie aus der bereits festgelegten Struktur folgen.\n\nAngenommen, `(0_K)` und `(0\'_K)` seien beide additive neutrale Elemente. Dann gilt:\n\n\\[\n0_K=0_K+0\'_K=0\'_K\\tag{M2.18}\n\\]\n\nWord-LaTeX: `0_K=0_K+0\'_K=0\'_K`\n\nDas additive neutrale Element ist daher eindeutig.\n\nEntsprechend seien `(1_K)` und `(1\'_K)` zwei multiplikative neutrale Elemente. Dann gilt:\n\n\\[\n1_K=1_K1\'_K=1\'_K\\tag{M2.19}\n\\]\n\nWord-LaTeX: `1_K=1_K1\'_K=1\'_K`\n\nAuch das multiplikative neutrale Element ist eindeutig.\n\nFür mich ist diese Unterscheidung zwischen Axiom und abgeleiteter Eigenschaft methodisch wesentlich. Die Existenz eines neutralen Elements gehört zur Strukturdefinition; seine Eindeutigkeit folgt daraus.\n\n### M2.1.6 Eindeutigkeit inverser Elemente\n\nAuch das additive Inverse eines Elements ist eindeutig. Seien `(b,c\\in K)` beide additive Inverse von `(a)`. Dann gilt `(a+b=0_K)` und `(a+c=0_K)`. Daraus folgt:\n\n\\[\nb=b+0_K=b+(a+c)=(b+a)+c=0_K+c=c\\tag{M2.20}\n\\]\n\nWord-LaTeX: `b=b+0_K=b+(a+c)=(b+a)+c=0_K+c=c`\n\nDamit ist `(-a)` eindeutig bestimmt.\n\nFür ein von Null verschiedenes `(a)` gilt dasselbe für das multiplikative Inverse. Sind `(b)` und `(c)` beide multiplikative Inverse von `(a)`, folgt:\n\n\\[\nb=b1_K=b(ac)=(ba)c=1_Kc=c\\tag{M2.21}\n\\]\n\nWord-LaTeX: `b=b1_K=b(ac)=(ba)c=1_Kc=c`\n\nDamit ist auch `(a^{-1})` eindeutig.\n\nDiese Eindeutigkeit ist später wichtig, weil Ausdrücke wie `(-a)` und `(a^{-1})` dadurch tatsächlich jeweils ein eindeutig bestimmtes Element bezeichnen.\n\n### M2.1.7 Multiplikation mit der skalaren Null\n\nEine weitere Beziehung, die ich nicht als Axiom einführe, ist das Verhalten der Null unter Multiplikation. Für jedes `(a\\in K)` gilt:\n\n\\[\na0_K=0_K\\tag{M2.22}\n\\]\n\nWord-LaTeX: `a0_K=0_K`\n\nDie Aussage folgt aus dem Distributivgesetz:\n\n\\[\na0_K=a(0_K+0_K)=a0_K+a0_K\\tag{M2.23}\n\\]\n\nWord-LaTeX: `a0_K=a(0_K+0_K)=a0_K+a0_K`\n\nDurch Addition des additiven Inversen von `(a0_K)` auf beiden Seiten bleibt:\n\n\\[\na0_K=0_K\\tag{M2.24}\n\\]\n\nWord-LaTeX: `a0_K=0_K`\n\nDiese Beziehung wird später bei der Skalarmultiplikation eine unmittelbare Entsprechung besitzen. Ich halte jedoch bereits hier fest, dass die hier auftretende Null `(0_K)` ein Element des Skalarkörpers ist.\n\n### M2.1.8 Der Bereich der von Null verschiedenen Skalare\n\nDa jedes von Null verschiedene Element multiplikativ invertierbar ist, kann ich die Menge dieser Elemente gesondert schreiben:\n\n\\[\nK^\\times=K\\setminus\\left\\{0_K\\right\\}\\tag{M2.25}\n\\]\n\nWord-LaTeX: `K^\\times=K\\setminus\\left\\{0_K\\right\\}`\n\nAuf `(K^\\times)` bildet die Multiplikation eine kommutative Gruppe. Für die spätere Vektorraumdefinition benötige ich diese Gruppenstruktur nicht als eigenständigen neuen Begriff, aber sie macht deutlich, warum Skalare ungleich Null algebraisch rückgängig gemacht werden können.\n\n### M2.1.9 Reelle und komplexe Skalarkörper\n\nFür die späteren mathematischen Anlagen sind insbesondere zwei Skalarkörper von Bedeutung:\n\n\\[\nK=\\mathbb{R}\\qquad\\mathrm{oder}\\qquad K=\\mathbb{C}\\tag{M2.26}\n\\]\n\nWord-LaTeX: `K=\\mathbb{R}\\qquad\\mathrm{oder}\\qquad K=\\mathbb{C}`\n\nBeide erfüllen die zuvor formulierten Körperaxiome. [[72]]\n\nIch möchte ihre Rollen dennoch nicht vorschnell gleichsetzen. Ein reeller Vektorraum verwendet Skalare aus `(\\mathbb{R})`, ein komplexer Vektorraum Skalare aus `(\\mathbb{C})`. Ein und dieselbe zugrunde liegende Menge kann deshalb je nach gewähltem Skalarkörper eine unterschiedliche Vektorraumstruktur besitzen.\n\nGerade für spätere Eigenwertprobleme ist diese Unterscheidung wesentlich. Eine algebraische Gleichung kann über `(\\mathbb{R})` keine Lösung besitzen, über `(\\mathbb{C})` dagegen sehr wohl. Der Skalarkörper gehört deshalb zur vollständigen mathematischen Spezifikation und darf nicht als nebensächliche Notationsentscheidung behandelt werden.\n\n### M2.1.10 Skalare und Vektoren sind verschiedene Strukturrollen\n\nNoch bevor ich den Vektorraum selbst einführe, möchte ich eine Notationsgrenze festlegen, die im weiteren Aufbau wichtig bleibt.\n\nElemente des Körpers `(K)` sind Skalare. Elemente des späteren Vektorraums `(V)` sind Vektoren. Auch wenn in einem konkreten Beispiel sowohl Skalare als auch Vektorkomponenten durch Zahlen dargestellt werden können, erfüllen sie mathematisch unterschiedliche Rollen.\n\nDeshalb werde ich den skalaren Nullwert mit `(0_K)` und den später einzuführenden Nullvektor zunächst mit `(0_V)` kennzeichnen. Erst wenn aus dem Zusammenhang zweifelsfrei hervorgeht, welche Null gemeint ist, kann die Notation verkürzt werden.\n\nDiese Trennung verhindert insbesondere, dass die später zu beweisende Beziehung `(0_Kv=0_V)` wie eine bloße Identität zweier Nullen behandelt wird. Links steht die Wirkung des skalaren Nullelements auf einen Vektor, rechts ein Element des Vektorraums. Dass beide Seiten miteinander übereinstimmen, wird erst aus den Vektorraumaxiomen folgen.\n\n### M2.1.11 Was der Körper noch nicht liefert\n\nMit `(K)` besitze ich nun einen algebraisch geschlossenen Skalarenbereich für die benötigten Grundoperationen. Daraus entsteht jedoch noch kein Vektorraum.\n\nInsbesondere enthält der Körper keine Aussage darüber, welche Objekte später als Vektoren betrachtet werden. Auch eine Vektoraddition oder eine Skalarmultiplikation ist noch nicht festgelegt.\n\nDer Ausdruck `(\\lambda v)` erhält deshalb erst dann mathematische Bedeutung, wenn eine entsprechende Funktion `(K\\times V\\rightarrow V)` definiert wurde.\n\nEbenso folgt aus der Existenz der Multiplikation zweier Skalare `(ab)` keine Multiplikation zweier Vektoren. Eine solche Operation gehört nicht zu den allgemeinen Vektorraumaxiomen und darf später nur eingeführt werden, wenn zusätzliche Struktur ausdrücklich vorhanden ist.\n\nFür mich ist diese Grenze besonders wichtig: Ein Vektorraum besitzt allgemein **Vektoraddition und Skalarmultiplikation**, aber keine notwendige Vektormultiplikation.\n\n### M2.1.12 Ergebnis und Weitergabestelle\n\nMit M2.1 steht der Skalarkörper `(K)` als erste algebraische Voraussetzung von M2 fest. Er besitzt zwei innere Operationen, Addition und Multiplikation. Die Addition bildet eine kommutative Gruppenstruktur auf `(K)`, die von Null verschiedenen Elemente bilden unter der Multiplikation ebenfalls eine kommutative Gruppe, und beide Operationen sind durch das Distributivgesetz miteinander verbunden.\n\nSubtraktion und Division habe ich dabei nicht als zusätzliche primitive Operationen eingeführt. Sie entstehen aus den jeweils vorhandenen inversen Elementen. Ebenso habe ich die Eindeutigkeit neutraler und inverser Elemente sowie die Beziehung `(a0_K=0_K)` als Folgen der Körperaxiome behandelt und nicht als zusätzliche Voraussetzungen.\n\nFür die folgenden Abschnitte ist außerdem festgelegt, dass der Skalarkörper Bestandteil der vollständigen Vektorraumstruktur ist. Insbesondere kann ich später zwischen reellen und komplexen Vektorräumen unterscheiden, ohne den Vektorbegriff selbst auf Zahlenvektoren reduzieren zu müssen.\n\nDie **Weitergabestelle M2.1 → M2.2** besteht damit aus dem Körper `(K)`, seinen beiden Operationen, den ausgezeichneten Elementen `(0_K)` und `(1_K)` sowie den daraus folgenden Rechenregeln.\n\nIn **M2.2 Vektorraum und Vektorraumaxiome** führe ich nun zusätzlich eine Menge `(V)` ein und definiere auf ihr die Vektoraddition sowie die Skalarmultiplikation:\n\n\\[\n+:V\\times V\\rightarrow V,\\qquad\\cdot:K\\times V\\rightarrow V\\tag{M2.27}\n\\]\n\nWord-LaTeX: `+:V\\times V\\rightarrow V,\\qquad\\cdot:K\\times V\\rightarrow V`\n\nErst wenn diese beiden Operationen die zugehörigen Vektorraumaxiome erfüllen, werde ich `(V)` als Vektorraum über `(K)` bezeichnen.', '6b38de46c5a0c21994e5fa6adfa3aa9458e5bc9d0dd9584d6befca45f567ad0f', 'Freigegebener Reset-Volltext M2.1 mit Gleichungen M2.1 bis M2.27 und Weitergabestelle M2.1 → M2.2.');
INSERT INTO `appendix_section_versions` (`appendix_section_version_id`, `appendix_section_id`, `revision_id`, `version_kind`, `body_markdown`, `checksum_sha256`, `notes`) VALUES
(15, 16, 28, 'draft', '## M2.2 Vektorraum und Vektorraumaxiome\n\nMit M2.1 steht der Skalarkörper `(K)` vollständig zur Verfügung. Ich kann daher nun eine zweite Menge `(V)` einführen, deren Elemente ich als Vektoren bezeichne. Allein die Existenz dieser Menge genügt jedoch noch nicht, um von einem Vektorraum zu sprechen. Entscheidend ist, dass auf `(V)` zwei Operationen definiert sind und dass diese Operationen mit der Körperstruktur von `(K)` in einer genau bestimmten Weise zusammenwirken. [[71]]\n\nDie erste Operation ist die Vektoraddition:\n\n\\[\n+:V\\times V\\rightarrow V\\tag{M2.28}\n\\]\n\nWord-LaTeX: `+:V\\times V\\rightarrow V`\n\nFür `(u,v\\in V)` schreibe ich:\n\n\\[\n(u,v)\\mapsto u+v\\tag{M2.29}\n\\]\n\nWord-LaTeX: `(u,v)\\mapsto u+v`\n\nDie zweite Operation ist die Skalarmultiplikation:\n\n\\[\n\\cdot:K\\times V\\rightarrow V\\tag{M2.30}\n\\]\n\nWord-LaTeX: `\\cdot:K\\times V\\rightarrow V`\n\nFür `(\\lambda\\in K)` und `(v\\in V)` schreibe ich:\n\n\\[\n(\\lambda,v)\\mapsto\\lambda v\\tag{M2.31}\n\\]\n\nWord-LaTeX: `(\\lambda,v)\\mapsto\\lambda v`\n\nBereits an diesen Signaturen wird für mich deutlich, dass die beiden Operationen verschiedene Rollen besitzen. Die Vektoraddition verknüpft zwei Elemente aus `(V)`. Die Skalarmultiplikation verbindet dagegen ein Element des Körpers `(K)` mit einem Element aus `(V)`. Das Ergebnis liegt in beiden Fällen wieder in `(V)`.\n\n### M2.2.1 Additive Struktur des Vektorraums\n\nBezüglich der Vektoraddition muss `(V)` eine kommutative Gruppe bilden.\n\nFür alle `(u,v,w\\in V)` gilt zunächst die Assoziativität:\n\n\\[\n(u+v)+w=u+(v+w)\\tag{M2.32}\n\\]\n\nWord-LaTeX: `(u+v)+w=u+(v+w)`\n\nAußerdem gilt die Kommutativität:\n\n\\[\nu+v=v+u\\tag{M2.33}\n\\]\n\nWord-LaTeX: `u+v=v+u`\n\nEs existiert ein additives neutrales Element in `(V)`, das ich zunächst ausdrücklich mit `(0_V)` bezeichne:\n\n\\[\n\\exists 0_V\\in V\\ \\forall v\\in V:v+0_V=v\\tag{M2.34}\n\\]\n\nWord-LaTeX: `\\exists 0_V\\in V\\ \\forall v\\in V:v+0_V=v`\n\nZu jedem Vektor existiert ein additives inverses Element:\n\n\\[\n\\forall v\\in V\\ \\exists(-v)\\in V:v+(-v)=0_V\\tag{M2.35}\n\\]\n\nWord-LaTeX: `\\forall v\\in V\\ \\exists(-v)\\in V:v+(-v)=0_V`\n\nDamit besitzt `(V)` bezüglich der Addition dieselbe grundlegende Gruppenstruktur, die ich bereits bei der Addition im Skalarkörper verwendet habe. Der Unterschied liegt ausschließlich darin, dass nun Vektoren und nicht Skalare addiert werden.\n\n### M2.2.2 Verträglichkeit der Skalarmultiplikation mit der Körpermultiplikation\n\nDie Skalarmultiplikation darf nicht unabhängig von der Multiplikation im Körper `(K)` festgelegt werden. Für `(\\lambda,\\mu\\in K)` und `(v\\in V)` muss gelten:\n\n\\[\n(\\lambda\\mu)v=\\lambda(\\mu v)\\tag{M2.36}\n\\]\n\nWord-LaTeX: `(\\lambda\\mu)v=\\lambda(\\mu v)`\n\nDiese Beziehung verbindet die multiplikative Struktur des Körpers mit der äußeren Skalarmultiplikation auf `(V)`.\n\nFür mich ist dabei die Ebenentrennung wichtig. Im Ausdruck `(\\lambda\\mu)` findet eine Multiplikation **innerhalb des Körpers** statt. Im Ausdruck `(\\mu v)` wird dagegen ein Skalar mit einem Vektor verknüpft. Dass beide Strukturen in (M2.36) miteinander kompatibel sind, gehört zu den grundlegenden Vektorraumaxiomen.\n\n### M2.2.3 Wirkung des multiplikativen Einselements\n\nDas multiplikative Einselement des Körpers muss auf jeden Vektor neutral wirken:\n\n\\[\n1_Kv=v\\qquad\\forall v\\in V\\tag{M2.37}\n\\]\n\nWord-LaTeX: `1_Kv=v\\qquad\\forall v\\in V`\n\nAuch hier möchte ich `(1_K)` zunächst ausdrücklich mit seinem Strukturindex schreiben. Es handelt sich um das Einselement des Skalarkörpers und nicht um ein ausgezeichnetes Element des Vektorraums.\n\nDiese Beziehung stellt sicher, dass die Skalarmultiplikation die bereits im Körper vorhandene neutrale Multiplikationsstruktur korrekt auf `(V)` überträgt.\n\n### M2.2.4 Distributivität bezüglich der Vektoraddition\n\nDie Skalarmultiplikation muss sich mit der Addition von Vektoren vertragen.\n\nFür `(\\lambda\\in K)` und `(u,v\\in V)` gilt:\n\n\\[\n\\lambda(u+v)=\\lambda u+\\lambda v\\tag{M2.38}\n\\]\n\nWord-LaTeX: `\\lambda(u+v)=\\lambda u+\\lambda v`\n\nFür mich bedeutet dieses Axiom, dass die Wirkung eines festen Skalars auf eine Summe von Vektoren mit der Summe der einzeln skalierten Vektoren übereinstimmt.\n\nDamit ist die Skalarmultiplikation bezüglich der Vektoraddition distributiv.\n\n### M2.2.5 Distributivität bezüglich der Skalaraddition\n\nZusätzlich muss die Skalarmultiplikation auch mit der Addition im Körper kompatibel sein.\n\nFür `(\\lambda,\\mu\\in K)` und `(v\\in V)` gilt:\n\n\\[\n(\\lambda+\\mu)v=\\lambda v+\\mu v\\tag{M2.39}\n\\]\n\nWord-LaTeX: `(\\lambda+\\mu)v=\\lambda v+\\mu v`\n\nDiese Gleichung verbindet nun die additive Struktur des Skalarkörpers mit der additiven Struktur des Vektorraums.\n\nDamit werden beide Grundoperationen des Körpers systematisch mit den Operationen auf `(V)` verknüpft. Genau diese Wechselwirkung unterscheidet den Vektorraum von einer bloßen kommutativen Gruppe von Vektoren.\n\n### M2.2.6 Vollständige Vektorraumdefinition\n\nIch kann die einzelnen Voraussetzungen nun zusammenfassen.\n\nEine Menge `(V)` heißt Vektorraum über dem Körper `(K)`, wenn auf `(V)` eine Vektoraddition und eine Skalarmultiplikation definiert sind und für alle `(u,v,w\\in V)` sowie alle `(\\lambda,\\mu\\in K)` die zuvor aufgeführten Axiome gelten. [[71]]\n\nIn kompakter Form benötige ich damit folgende Beziehungen:\n\n\\[\n(u+v)+w=u+(v+w)\\tag{M2.40}\n\\]\n\nWord-LaTeX: `(u+v)+w=u+(v+w)`\n\n\\[\nu+v=v+u\\tag{M2.41}\n\\]\n\nWord-LaTeX: `u+v=v+u`\n\n\\[\nv+0_V=v\\tag{M2.42}\n\\]\n\nWord-LaTeX: `v+0_V=v`\n\n\\[\nv+(-v)=0_V\\tag{M2.43}\n\\]\n\nWord-LaTeX: `v+(-v)=0_V`\n\n\\[\n(\\lambda\\mu)v=\\lambda(\\mu v)\\tag{M2.44}\n\\]\n\nWord-LaTeX: `(\\lambda\\mu)v=\\lambda(\\mu v)`\n\n\\[\n1_Kv=v\\tag{M2.45}\n\\]\n\nWord-LaTeX: `1_Kv=v`\n\n\\[\n\\lambda(u+v)=\\lambda u+\\lambda v\\tag{M2.46}\n\\]\n\nWord-LaTeX: `\\lambda(u+v)=\\lambda u+\\lambda v`\n\n\\[\n(\\lambda+\\mu)v=\\lambda v+\\mu v\\tag{M2.47}\n\\]\n\nWord-LaTeX: `(\\lambda+\\mu)v=\\lambda v+\\mu v`\n\nDiese Zusammenfassung enthält keine neuen mathematischen Aussagen gegenüber (M2.32) bis (M2.39). Ich verwende sie lediglich, um den vollständigen Axiombestand an einer Stelle sichtbar zu machen.\n\n### M2.2.7 Vektorraum über einem Körper\n\nDie vollständige Struktur hängt sowohl von `(V)` als auch von `(K)` ab. Ich schreibe deshalb:\n\n\\[\nV\\ \\mathrm{ist\\ ein\\ Vektorraum\\ über}\\ K\\tag{M2.48}\n\\]\n\nWord-LaTeX: `V\\ \\mathrm{ist\\ ein\\ Vektorraum\\ über}\\ K`\n\nDiese Formulierung ist für mich nicht nur eine sprachliche Ergänzung. Der Skalarkörper gehört zur Struktur.\n\nEin und dieselbe Menge kann prinzipiell unterschiedliche Vektorraumstrukturen tragen, wenn unterschiedliche Skalarkörper oder unterschiedliche Operationen verwendet werden. Die zugrunde liegende Menge allein bestimmt den Vektorraum daher nicht vollständig.\n\nInsbesondere gilt:\n\n\\[\nK=\\mathbb{R}\\Longrightarrow V\\ \\mathrm{reeller\\ Vektorraum}\\tag{M2.49}\n\\]\n\nWord-LaTeX: `K=\\mathbb{R}\\Longrightarrow V\\ \\mathrm{reeller\\ Vektorraum}`\n\nund:\n\n\\[\nK=\\mathbb{C}\\Longrightarrow V\\ \\mathrm{komplexer\\ Vektorraum}\\tag{M2.50}\n\\]\n\nWord-LaTeX: `K=\\mathbb{C}\\Longrightarrow V\\ \\mathrm{komplexer\\ Vektorraum}`\n\nDamit ist die spätere Unterscheidung zwischen reellen und komplexen Vektorräumen bereits begrifflich vorbereitet.\n\n### M2.2.8 Vektoren sind keine Koordinatenlisten\n\nAn dieser Stelle möchte ich eine methodische Grenze ausdrücklich festhalten. Aus `(v\\in V)` folgt keine bestimmte Darstellung des Vektors.\n\nEin Vektor kann später durch eine Koordinatenliste dargestellt werden, wenn eine Basis gewählt wurde. Diese Koordinaten gehören dann aber zur **Darstellung des Vektors bezüglich einer Basis** und nicht zur abstrakten Definition des Vektors selbst.\n\nDeshalb verwende ich in M2.2 bewusst noch keine allgemeine Schreibweise:\n\n`(v=(v_1,\\ldots,v_n))`\n\nals Definition eines Vektors. Eine solche Gleichsetzung wäre nur für bestimmte konkrete Vektorräume oder nach einer bereits gewählten Basis zulässig.\n\nFür mich ist diese Trennung deshalb zentral, weil spätere Basiswechsel nur dann sauber formuliert werden können, wenn das mathematische Objekt `(v)` von seiner jeweiligen Koordinatendarstellung unterschieden bleibt. [[72]]\n\n### M2.2.9 Ein Vektorraum ist noch kein geometrischer Raum\n\nAus den Vektorraumaxiomen folgen ebenfalls keine Längen oder Winkel.\n\nFür `(u,v\\in V)` ist daher ein Ausdruck wie:\n\n`(\\langle u,v\\rangle)`\n\nin M2 noch nicht allgemein definiert.\n\nEbenso steht keine Norm `(\\|v\\|)` zur Verfügung und es ist noch nicht festgelegt, wann zwei Vektoren orthogonal sind.\n\nDiese Strukturen werden erst später durch zusätzliche Voraussetzungen eingeführt. Der allgemeine Vektorraum ist deshalb zunächst eine **algebraische**, nicht notwendig eine metrische oder euklidische Struktur.\n\nAuch Begriffe wie „senkrecht“, „Länge“ oder „Winkel“ dürfen daher aus den Vektorraumaxiomen allein nicht abgeleitet werden.\n\n### M2.2.10 Keine allgemeine Vektormultiplikation\n\nEine weitere Grenze ergibt sich aus der Art der definierten Operationen.\n\nIm Vektorraum kann ich zwei Vektoren addieren:\n\n\\[\n+:V\\times V\\rightarrow V\\tag{M2.51}\n\\]\n\nWord-LaTeX: `+:V\\times V\\rightarrow V`\n\nund ich kann einen Skalar mit einem Vektor multiplizieren:\n\n\\[\n\\cdot:K\\times V\\rightarrow V\\tag{M2.52}\n\\]\n\nWord-LaTeX: `\\cdot:K\\times V\\rightarrow V`\n\nDaraus folgt jedoch keine allgemeine Operation:\n\n\\[\nV\\times V\\rightarrow V\\tag{M2.53}\n\\]\n\nWord-LaTeX: `V\\times V\\rightarrow V`\n\nEine Multiplikation zweier Vektoren gehört nicht zu den Vektorraumaxiomen.\n\nWenn in einer späteren Struktur ein Produkt zweier Vektoren definiert wird, handelt es sich deshalb um zusätzliche mathematische Struktur. Das gilt beispielsweise ebenso für Skalarprodukte wie für andere bilineare oder algebraische Produkte.\n\n### M2.2.11 Axiome und abgeleitete Aussagen\n\nBis zu diesem Punkt habe ich ausschließlich diejenigen Eigenschaften verwendet, die zur Definition des Vektorraums gehören. Nun muss ich sorgfältig zwischen diesen Axiomen und den daraus folgenden Sätzen unterscheiden.\n\nBeispielsweise werde ich nicht zusätzlich fordern:\n\n\\[\n0_Kv=0_V\\tag{M2.54}\n\\]\n\nWord-LaTeX: `0_Kv=0_V`\n\nEbenso werde ich nicht als Axiom voraussetzen:\n\n\\[\n\\lambda0_V=0_V\\tag{M2.55}\n\\]\n\nWord-LaTeX: `\\lambda0_V=0_V`\n\noder:\n\n\\[\n(-1_K)v=-v\\tag{M2.56}\n\\]\n\nWord-LaTeX: `(-1_K)v=-v`\n\nDiese Beziehungen sollen im folgenden Abschnitt aus den bereits eingeführten Axiomen hergeleitet werden.\n\nFür mich ist diese Trennung wichtig, weil sie zeigt, welche Aussagen die Struktur **definieren** und welche Aussagen aufgrund dieser Definition **notwendig gelten**.\n\n### M2.2.12 Ergebnis und Weitergabestelle\n\nMit M2.2 ist der abstrakte Vektorraum über einem Körper `(K)` definiert. Die Menge `(V)` wird durch eine innere Vektoraddition und eine äußere Skalarmultiplikation mit `(K)` ausgestattet. Die Vektoraddition bildet eine kommutative Gruppenstruktur, während die Skalarmultiplikation mit Addition und Multiplikation des Körpers sowie mit der Vektoraddition verträglich ist.\n\nDamit besitze ich nun erstmals eine mathematische Struktur, in der Ausdrücke wie `(u+v)` und `(\\lambda v)` allgemein definiert sind.\n\nGleichzeitig sind die Aussagegrenzen festgelegt. Ein Vektor ist noch keine Koordinatenliste. Ein Vektorraum besitzt noch keine allgemeine Länge, keinen Winkel, keine Orthogonalität und keine notwendige Multiplikation zweier Vektoren.\n\nFür den weiteren Aufbau muss ich nun diejenigen Eigenschaften bestimmen, die aus den Vektorraumaxiomen selbst folgen. Dazu gehören insbesondere die Eindeutigkeit des Nullvektors, die Eindeutigkeit des additiven inversen Vektors sowie die Beziehungen zwischen `(0_K)`, `(0_V)`, `(-1_K)` und der Skalarmultiplikation.\n\nDie **Weitergabestelle M2.2 → M2.3** besteht deshalb aus dem vollständigen Axiombestand des Vektorraums.\n\n**M2.3 Nullvektor, additive Inverse und abgeleitete Nullbeziehungen** verwendet ausschließlich diese Axiome und den bereits definierten Skalarkörper, um die grundlegenden Folgerungen der Vektorraumstruktur herzuleiten.', 'cafa51b0a21a2d67f61a5974b0c45e530f5e88f27615352aaa16b15747f25993', 'Freigegebener Reset-Volltext M2.2 mit Gleichungen M2.28 bis M2.56 und Weitergabestelle M2.2 → M2.3.'),
(16, 17, 29, 'draft', '## M2.3 Nullvektor, additive Inverse und abgeleitete Nullbeziehungen\n\nMit M2.2 ist der Vektorraum `(V)` über dem Körper `(K)` vollständig durch seine Axiome bestimmt. Für den weiteren Aufbau möchte ich nun ausdrücklich unterscheiden, welche Aussagen Bestandteil dieser Definition waren und welche Aussagen daraus erst folgen. Diese Trennung ist für mich wichtig, weil spätere Begriffe wie Linearkombination, Spannraum oder lineare Unabhängigkeit auf Rechenregeln zurückgreifen werden, die nicht zusätzlich vorausgesetzt werden müssen. [[71]]\n\nIch beginne mit den beiden ausgezeichneten additiven Strukturen des Vektorraums: dem Nullvektor und dem additiven Inversen. Anschließend leite ich die Wirkung der skalaren Null, die Wirkung des Nullvektors unter Skalarmultiplikation und die Beziehungen zu negativen Skalaren her.\n\n### M2.3.1 Eindeutigkeit des Nullvektors\n\nDie Vektorraumaxiome fordern zunächst nur die **Existenz** eines additiven neutralen Elements. Seine Eindeutigkeit folgt daraus.\n\nAngenommen, `(0_V)` und `(0\'_V)` seien beide additive neutrale Elemente von `(V)`. Dann gilt aufgrund ihrer jeweiligen Neutralität:\n\n\\[\n0_V=0_V+0\'_V=0\'_V\\tag{M2.57}\n\\]\n\nWord-LaTeX: `0_V=0_V+0\'_V=0\'_V`\n\nDamit besitzt jeder Vektorraum genau einen Nullvektor.\n\nDiese Eindeutigkeit erlaubt es mir, künftig von **dem** Nullvektor des Vektorraums zu sprechen. Die Kennzeichnung `(0_V)` bleibt zunächst erhalten, damit die Unterscheidung vom skalaren Nullelement `(0_K)` sichtbar bleibt.\n\n### M2.3.2 Eindeutigkeit des additiven Inversen\n\nEbenso fordert die Vektorraumdefinition zu jedem `(v\\in V)` zunächst nur die Existenz eines additiven inversen Vektors.\n\nSeien `(u,w\\in V)` zwei additive Inverse von `(v)`. Dann gilt:\n\n\\[\nv+u=0_V\\qquad\\mathrm{und}\\qquad v+w=0_V\\tag{M2.58}\n\\]\n\nWord-LaTeX: `v+u=0_V\\qquad\\mathrm{und}\\qquad v+w=0_V`\n\nAus den Vektorraumaxiomen folgt:\n\n\\[\nu=u+0_V=u+(v+w)=(u+v)+w=0_V+w=w\\tag{M2.59}\n\\]\n\nWord-LaTeX: `u=u+0_V=u+(v+w)=(u+v)+w=0_V+w=w`\n\nDamit ist das additive Inverse jedes Vektors eindeutig bestimmt. Ich kann es deshalb eindeutig mit `(-v)` bezeichnen.\n\nFür den Nullvektor selbst folgt unmittelbar:\n\n\\[\n-0_V=0_V\\tag{M2.60}\n\\]\n\nWord-LaTeX: `-0_V=0_V`\n\nDenn der Nullvektor ist sein eigenes additives Inverses.\n\n### M2.3.3 Vektorsubtraktion als abgeleitete Operation\n\nWie bereits bei den Skalaren führe ich auch die Subtraktion von Vektoren nicht als eigenständige Grundoperation ein. Für `(u,v\\in V)` definiere ich:\n\n\\[\nu-v=u+(-v)\\tag{M2.61}\n\\]\n\nWord-LaTeX: `u-v=u+(-v)`\n\nDie Subtraktion ist damit vollständig durch Vektoraddition und additives Inverses bestimmt.\n\nDaraus folgt insbesondere:\n\n\\[\nv-v=0_V\\tag{M2.62}\n\\]\n\nWord-LaTeX: `v-v=0_V`\n\nund:\n\n\\[\nv-0_V=v\\tag{M2.63}\n\\]\n\nWord-LaTeX: `v-0_V=v`\n\nDamit steht für spätere algebraische Umformungen eine Subtraktionsschreibweise zur Verfügung, ohne die zugrunde liegende Axiomstruktur zu erweitern.\n\n### M2.3.4 Additives Kürzungsgesetz\n\nAus der Existenz eindeutiger additiver Inverser folgt ein Kürzungsgesetz.\n\nSeien `(u,v,w\\in V)` und gelte:\n\n\\[\nu+w=v+w\\tag{M2.64}\n\\]\n\nWord-LaTeX: `u+w=v+w`\n\nDann addiere ich auf beiden Seiten `(-w)`:\n\n\\[\n(u+w)+(-w)=(v+w)+(-w)\\tag{M2.65}\n\\]\n\nWord-LaTeX: `(u+w)+(-w)=(v+w)+(-w)`\n\nMit Assoziativität und der Definition des additiven Inversen folgt:\n\n\\[\nu=v\\tag{M2.66}\n\\]\n\nWord-LaTeX: `u=v`\n\nDiese Beziehung werde ich später mehrfach verwenden, wenn aus Gleichungen gemeinsame Vektoranteile entfernt werden müssen.\n\n### M2.3.5 Wirkung des skalaren Nullelements\n\nNun kann ich die in M2.2 angekündigte Beziehung zwischen der skalaren Null `(0_K)` und dem Nullvektor `(0_V)` herleiten.\n\nFür jedes `(v\\in V)` gilt zunächst aufgrund des Distributivgesetzes:\n\n\\[\n(0_K+0_K)v=0_Kv+0_Kv\\tag{M2.67}\n\\]\n\nWord-LaTeX: `(0_K+0_K)v=0_Kv+0_Kv`\n\nDa `(0_K+0_K=0_K)` gilt, folgt:\n\n\\[\n0_Kv=0_Kv+0_Kv\\tag{M2.68}\n\\]\n\nWord-LaTeX: `0_Kv=0_Kv+0_Kv`\n\nDurch Addition des additiven Inversen von `(0_Kv)` auf beiden Seiten erhalte ich:\n\n\\[\n0_V=0_Kv\\tag{M2.69}\n\\]\n\nWord-LaTeX: `0_V=0_Kv`\n\nDamit gilt für jeden Vektor:\n\n\\[\n0_Kv=0_V\\qquad\\forall v\\in V\\tag{M2.70}\n\\]\n\nWord-LaTeX: `0_Kv=0_V\\qquad\\forall v\\in V`\n\nDiese Beziehung ist für mich ein gutes Beispiel für die notwendige Unterscheidung der beiden Nullen. `(0_K)` und `(0_V)` sind nicht dasselbe mathematische Objekt. Erst die Skalarmultiplikation verbindet sie durch die Aussage, dass die skalare Null jeden Vektor auf den Nullvektor abbildet.\n\n### M2.3.6 Wirkung eines Skalars auf den Nullvektor\n\nEntsprechend kann ich untersuchen, was geschieht, wenn ein beliebiger Skalar auf den Nullvektor wirkt.\n\nFür `(\\lambda\\in K)` gilt:\n\n\\[\n\\lambda(0_V+0_V)=\\lambda0_V+\\lambda0_V\\tag{M2.71}\n\\]\n\nWord-LaTeX: `\\lambda(0_V+0_V)=\\lambda0_V+\\lambda0_V`\n\nDa `(0_V+0_V=0_V)` ist, folgt:\n\n\\[\n\\lambda0_V=\\lambda0_V+\\lambda0_V\\tag{M2.72}\n\\]\n\nWord-LaTeX: `\\lambda0_V=\\lambda0_V+\\lambda0_V`\n\nDurch additive Kürzung ergibt sich:\n\n\\[\n\\lambda0_V=0_V\\qquad\\forall\\lambda\\in K\\tag{M2.73}\n\\]\n\nWord-LaTeX: `\\lambda0_V=0_V\\qquad\\forall\\lambda\\in K`\n\nDamit wirken sowohl die skalare Null auf jeden Vektor als auch jeder Skalar auf den Nullvektor in eindeutig bestimmter Weise.\n\n### M2.3.7 Wirkung des Skalars minus eins\n\nDie Beziehung zwischen dem skalaren Element `(-1_K)` und dem additiven Inversen eines Vektors lässt sich ebenfalls aus den Axiomen herleiten.\n\nZunächst gilt:\n\n\\[\n1_K+(-1_K)=0_K\\tag{M2.74}\n\\]\n\nWord-LaTeX: `1_K+(-1_K)=0_K`\n\nMultipliziere ich diese Skalargleichung mit `(v)`, folgt:\n\n\\[\n(1_K+(-1_K))v=0_Kv\\tag{M2.75}\n\\]\n\nWord-LaTeX: `(1_K+(-1_K))v=0_Kv`\n\nMit den bereits bewiesenen Beziehungen ergibt sich:\n\n\\[\nv+(-1_K)v=0_V\\tag{M2.76}\n\\]\n\nWord-LaTeX: `v+(-1_K)v=0_V`\n\nDa das additive Inverse von `(v)` eindeutig ist, folgt:\n\n\\[\n(-1_K)v=-v\\tag{M2.77}\n\\]\n\nWord-LaTeX: `(-1_K)v=-v`\n\nDamit ist die übliche Schreibweise `(-v)` vollständig mit der Skalarmultiplikation vereinbar.\n\n### M2.3.8 Negative Skalare und additive Inverse\n\nDiese Beziehung lässt sich auf beliebige Skalare übertragen.\n\nFür `(\\lambda\\in K)` gilt:\n\n\\[\n(-\\lambda)v=-(\\lambda v)\\tag{M2.78}\n\\]\n\nWord-LaTeX: `(-\\lambda)v=-(\\lambda v)`\n\nEbenso gilt:\n\n\\[\n\\lambda(-v)=-(\\lambda v)\\tag{M2.79}\n\\]\n\nWord-LaTeX: `\\lambda(-v)=-(\\lambda v)`\n\nDamit erhalte ich:\n\n\\[\n(-\\lambda)v=\\lambda(-v)\\tag{M2.80}\n\\]\n\nWord-LaTeX: `(-\\lambda)v=\\lambda(-v)`\n\nWirken sowohl ein negativer Skalar als auch ein additiv inverser Vektor zusammen, heben sich beide Vorzeichen auf:\n\n\\[\n(-\\lambda)(-v)=\\lambda v\\tag{M2.81}\n\\]\n\nWord-LaTeX: `(-\\lambda)(-v)=\\lambda v`\n\nDiese Beziehungen sind keine zusätzlichen Regeln, die ich unabhängig voraussetzen muss. Sie folgen vollständig aus den Vektorraumaxiomen und der Körperstruktur. [[71]]\n\n### M2.3.9 Wann kann ein skalares Vielfaches der Nullvektor sein?\n\nFür die spätere Untersuchung linearer Unabhängigkeit benötige ich eine besonders wichtige Folgerung.\n\nSeien `(\\lambda\\in K)` und `(v\\in V)` und es gelte:\n\n\\[\n\\lambda v=0_V\\tag{M2.82}\n\\]\n\nWord-LaTeX: `\\lambda v=0_V`\n\nIst `(\\lambda=0_K)`, ist die Gleichung aufgrund von (M2.70) bereits erfüllt.\n\nNehme ich dagegen `(\\lambda\\neq0_K)` an, besitzt `(\\lambda)` im Körper ein multiplikatives Inverses `(\\lambda^{-1})`. Dann gilt:\n\n\\[\n\\lambda^{-1}(\\lambda v)=\\lambda^{-1}0_V\\tag{M2.83}\n\\]\n\nWord-LaTeX: `\\lambda^{-1}(\\lambda v)=\\lambda^{-1}0_V`\n\nMit der Verträglichkeit der Skalarmultiplikation folgt:\n\n\\[\n(\\lambda^{-1}\\lambda)v=0_V\\tag{M2.84}\n\\]\n\nWord-LaTeX: `(\\lambda^{-1}\\lambda)v=0_V`\n\nund damit:\n\n\\[\nv=0_V\\tag{M2.85}\n\\]\n\nWord-LaTeX: `v=0_V`\n\nSomit gilt insgesamt:\n\n\\[\n\\lambda v=0_V\\Longrightarrow\\lambda=0_K\\lor v=0_V\\tag{M2.86}\n\\]\n\nWord-LaTeX: `\\lambda v=0_V\\Longrightarrow\\lambda=0_K\\lor v=0_V`\n\nDie umgekehrte Richtung folgt bereits aus (M2.70) und (M2.73). Deshalb kann ich die Aussage auch als Äquivalenz formulieren:\n\n\\[\n\\lambda v=0_V\\iff\\lambda=0_K\\lor v=0_V\\tag{M2.87}\n\\]\n\nWord-LaTeX: `\\lambda v=0_V\\iff\\lambda=0_K\\lor v=0_V`\n\nDiese Nullproduktbeziehung gehört für mich zu den zentralen algebraischen Folgerungen dieses Abschnitts.\n\n### M2.3.10 Kürzung eines von Null verschiedenen Skalars\n\nAus derselben Struktur folgt ein skalares Kürzungsgesetz.\n\nSei `(\\lambda\\neq0_K)` und gelte:\n\n\\[\n\\lambda u=\\lambda v\\tag{M2.88}\n\\]\n\nWord-LaTeX: `\\lambda u=\\lambda v`\n\nDann multipliziere ich beide Seiten mit `(\\lambda^{-1})`:\n\n\\[\n\\lambda^{-1}(\\lambda u)=\\lambda^{-1}(\\lambda v)\\tag{M2.89}\n\\]\n\nWord-LaTeX: `\\lambda^{-1}(\\lambda u)=\\lambda^{-1}(\\lambda v)`\n\nDaraus folgt:\n\n\\[\nu=v\\tag{M2.90}\n\\]\n\nWord-LaTeX: `u=v`\n\nSomit gilt:\n\n\\[\n\\lambda\\neq0_K\\land\\lambda u=\\lambda v\\Longrightarrow u=v\\tag{M2.91}\n\\]\n\nWord-LaTeX: `\\lambda\\neq0_K\\land\\lambda u=\\lambda v\\Longrightarrow u=v`\n\nEin von Null verschiedener Skalar kann daher bei einer Vektorgleichung gekürzt werden.\n\n### M2.3.11 Kürzung eines von Null verschiedenen Vektors\n\nAuch in der umgekehrten Rollenverteilung ergibt sich eine nützliche Aussage.\n\nSei `(v\\neq0_V)` und gelte:\n\n\\[\n\\lambda v=\\mu v\\tag{M2.92}\n\\]\n\nWord-LaTeX: `\\lambda v=\\mu v`\n\nDann folgt durch Subtraktion:\n\n\\[\n(\\lambda-\\mu)v=0_V\\tag{M2.93}\n\\]\n\nWord-LaTeX: `(\\lambda-\\mu)v=0_V`\n\nDa `(v\\neq0_V)` vorausgesetzt ist, folgt aus (M2.87):\n\n\\[\n\\lambda-\\mu=0_K\\tag{M2.94}\n\\]\n\nWord-LaTeX: `\\lambda-\\mu=0_K`\n\nund damit:\n\n\\[\n\\lambda=\\mu\\tag{M2.95}\n\\]\n\nWord-LaTeX: `\\lambda=\\mu`\n\nZusammengefasst gilt:\n\n\\[\nv\\neq0_V\\land\\lambda v=\\mu v\\Longrightarrow\\lambda=\\mu\\tag{M2.96}\n\\]\n\nWord-LaTeX: `v\\neq0_V\\land\\lambda v=\\mu v\\Longrightarrow\\lambda=\\mu`\n\nDiese Aussage wird später wichtig, wenn Koeffizienten einer Darstellung auf Eindeutigkeit untersucht werden.\n\n### M2.3.12 Eindeutigkeit elementarer Skalardarstellungen\n\nFür einen festen Vektor `(v\\neq0_V)` bedeutet (M2.96), dass zwei verschiedene Skalare nicht denselben skalaren Vielfachen dieses Vektors erzeugen können.\n\nDie Abbildung:\n\n\\[\n\\varphi_v:K\\rightarrow V,\\qquad\\varphi_v(\\lambda)=\\lambda v\\tag{M2.97}\n\\]\n\nWord-LaTeX: `\\varphi_v:K\\rightarrow V,\\qquad\\varphi_v(\\lambda)=\\lambda v`\n\nist für `(v\\neq0_V)` injektiv:\n\n\\[\nv\\neq0_V\\Longrightarrow\\varphi_v\\ \\mathrm{injektiv}\\tag{M2.98}\n\\]\n\nWord-LaTeX: `v\\neq0_V\\Longrightarrow\\varphi_v\\ \\mathrm{injektiv}`\n\nDamit wird bereits auf einfachster Ebene sichtbar, wie die in M1 entwickelte Funktionsstruktur mit der neuen algebraischen Struktur zusammenwirkt. Ein fester von Null verschiedener Vektor erzeugt über die Skalarmultiplikation eine injektive Zuordnung der Skalare zu seinen skalaren Vielfachen.\n\n### M2.3.13 Was aus diesen Beziehungen noch nicht folgt\n\nTrotz der nun verfügbaren Rechenregeln kann ich aus zwei beliebigen Vektoren noch keine Aussage über ihre gegenseitige Unabhängigkeit treffen. Auch die Tatsache, dass `(u\\neq v)` gilt, bedeutet nicht, dass `(u)` und `(v)` linear unabhängig sind.\n\nEbenso bedeutet `(v\\neq0_V)` noch nicht, dass `(v)` zusammen mit beliebigen weiteren Vektoren eine Basis bildet oder eine zusätzliche Dimension erzeugt.\n\nFür solche Aussagen benötige ich zunächst einen Begriff dafür, welche Teilmengen eines Vektorraums unter den beiden Vektorraumoperationen selbst wieder abgeschlossen bleiben. Erst danach kann ich systematisch untersuchen, welche Vektoren durch andere Vektoren erzeugt werden.\n\n### M2.3.14 Ergebnis und Weitergabestelle\n\nMit M2.3 sind die grundlegenden Folgerungen der Vektorraumaxiome bestimmt. Der Nullvektor ist eindeutig, ebenso das additive Inverse jedes Vektors. Die Vektorsubtraktion ist als Addition des additiven Inversen definiert, und für die Vektoraddition steht ein Kürzungsgesetz zur Verfügung.\n\nDie zunächst lediglich angekündigten Nullbeziehungen sind nun aus den Axiomen hergeleitet. Für jeden `(v\\in V)` gilt `(0_Kv=0_V)`, und für jeden `(\\lambda\\in K)` gilt `(\\lambda0_V=0_V)`. Außerdem entspricht die Multiplikation mit `(-1_K)` genau der Bildung des additiven inversen Vektors.\n\nVon besonderer Bedeutung für den weiteren Aufbau ist die Äquivalenz `(\\lambda v=0_V\\iff\\lambda=0_K\\lor v=0_V)`. Sie erlaubt die Kürzung von Nichtnullskalaren und liefert bei einem von Null verschiedenen Vektor die Eindeutigkeit seines skalaren Koeffizienten.\n\nDamit steht die elementare algebraische Rechenstruktur des Vektorraums vollständig zur Verfügung. Was noch fehlt, ist die Frage, wann eine Teilmenge `(U\\subseteq V)` diese Struktur selbst trägt.\n\nDie **Weitergabestelle M2.3 → M2.4** liegt deshalb bei der Untersuchung solcher Teilmengen. **M2.4 Untervektorräume und Unterraumkriterium** bestimmt, welche Bedingungen eine Teilmenge eines Vektorraums erfüllen muss, damit Vektoraddition und Skalarmultiplikation vollständig innerhalb dieser Teilmenge verbleiben und `(U)` selbst einen Vektorraum über demselben Körper `(K)` bildet.', '118c1640ba6984ae6d20acc91cfa35edb9b65d6139b2d40a457569fc04cacab6', 'Freigegebener Reset-Volltext M2.3 mit Gleichungen M2.57 bis M2.98 und Weitergabestelle M2.3 → M2.4.'),
(18, 19, 31, 'draft', '## M2.4 Untervektorräume und Unterraumkriterium\n\nMit M2.3 steht die elementare Rechenstruktur eines Vektorraums `(V)` über dem Körper `(K)` vollständig zur Verfügung. Nun kann ich untersuchen, wann eine Teilmenge `(U\\subseteq V)` nicht nur einige Vektoren enthält, sondern unter denselben algebraischen Operationen selbst wieder einen Vektorraum bildet.\n\nFür mich ist dabei die in M1 entwickelte Teilmengenstruktur unmittelbar wichtig. Aus `(U\\subseteq V)` folgt zunächst lediglich, dass jedes Element von `(U)` auch ein Element von `(V)` ist. Daraus folgt noch nicht, dass die Summe zweier Elemente aus `(U)` wieder in `(U)` liegt oder dass ein skalares Vielfaches eines Elements aus `(U)` weiterhin zu `(U)` gehört. Genau diese zusätzliche Abgeschlossenheit entscheidet darüber, ob `(U)` ein Untervektorraum ist. [[71]]\n\n### M2.4.1 Definition des Untervektorraums\n\nSei `(V)` ein Vektorraum über dem Körper `(K)` und `(U\\subseteq V)`.\n\nIch bezeichne `(U)` als Untervektorraum von `(V)`, wenn `(U)` mit der von `(V)` übernommenen Vektoraddition und Skalarmultiplikation selbst ein Vektorraum über demselben Körper `(K)` ist.\n\nIch schreibe:\n\n\\[\nU\\leq V\\tag{M2.99}\n\\]\n\nWord-LaTeX: `U\\leq V`\n\nDabei bedeutet `(U\\leq V)` ausdrücklich mehr als `(U\\subseteq V)`. Die erste Schreibweise enthält zusätzlich die algebraische Aussage, dass die Vektorraumstruktur von `(V)` auf `(U)` erhalten bleibt.\n\nDie Operationen auf `(U)` werden nicht neu erfunden. Sie sind Einschränkungen der bereits auf `(V)` definierten Operationen:\n\n\\[\n+:U\\times U\\rightarrow U\\tag{M2.100}\n\\]\n\nWord-LaTeX: `+:U\\times U\\rightarrow U`\n\nund:\n\n\\[\n\\cdot:K\\times U\\rightarrow U\\tag{M2.101}\n\\]\n\nWord-LaTeX: `\\cdot:K\\times U\\rightarrow U`\n\nDamit wird bereits sichtbar, welche beiden Abgeschlossenheitsbedingungen später entscheidend sein werden.\n\n### M2.4.2 Der Nullvektor muss im Untervektorraum liegen\n\nDa `(U)` selbst ein Vektorraum sein soll, muss `(U)` einen Nullvektor besitzen.\n\nDieser Nullvektor kann nicht von `(0_V)` verschieden sein. Aus der Eindeutigkeit des Nullvektors folgt daher:\n\n\\[\nU\\leq V\\Longrightarrow 0_V\\in U\\tag{M2.102}\n\\]\n\nWord-LaTeX: `U\\leq V\\Longrightarrow 0_V\\in U`\n\nFür mich ist diese Beziehung besonders nützlich, weil sie sofort eine notwendige Bedingung liefert: Eine Teilmenge, die den Nullvektor nicht enthält, kann kein Untervektorraum sein.\n\nDamit folgt zugleich:\n\n\\[\nU\\leq V\\Longrightarrow U\\neq\\varnothing\\tag{M2.103}\n\\]\n\nWord-LaTeX: `U\\leq V\\Longrightarrow U\\neq\\varnothing`\n\nDie Nichtleere eines Untervektorraums ist also keine zusätzliche unabhängige Eigenschaft, sondern folgt bereits aus der notwendigen Zugehörigkeit des Nullvektors.\n\n### M2.4.3 Abgeschlossenheit bezüglich der Vektoraddition\n\nSind `(u,v\\in U)`, muss ihre Summe wieder Element von `(U)` sein:\n\n\\[\nu,v\\in U\\Longrightarrow u+v\\in U\\tag{M2.104}\n\\]\n\nWord-LaTeX: `u,v\\in U\\Longrightarrow u+v\\in U`\n\nDiese Bedingung verhindert, dass die Vektoraddition aus der Teilmenge herausführt.\n\nDie Tatsache, dass `(u+v\\in V)` gilt, reicht nicht aus. Das folgt bereits daraus, dass `(V)` ein Vektorraum ist. Für einen Untervektorraum benötige ich die stärkere Aussage `(u+v\\in U)`.\n\n### M2.4.4 Abgeschlossenheit bezüglich der Skalarmultiplikation\n\nEntsprechend muss für jedes `(\\lambda\\in K)` und jedes `(u\\in U)` gelten:\n\n\\[\n\\lambda u\\in U\\tag{M2.105}\n\\]\n\nWord-LaTeX: `\\lambda u\\in U`\n\nAuch hier reicht nicht aus, dass `(\\lambda u\\in V)` gilt. Die skalare Multiplikation muss innerhalb von `(U)` abgeschlossen bleiben.\n\nDiese Forderung hat unmittelbar zur Folge, dass mit jedem Vektor aus `(U)` auch sein additives Inverses in `(U)` liegt. Denn mit `(\\lambda=-1_K)` folgt:\n\n\\[\nu\\in U\\Longrightarrow(-1_K)u\\in U\\tag{M2.106}\n\\]\n\nWord-LaTeX: `u\\in U\\Longrightarrow(-1_K)u\\in U`\n\nMit (M2.77) ergibt sich:\n\n\\[\nu\\in U\\Longrightarrow -u\\in U\\tag{M2.107}\n\\]\n\nWord-LaTeX: `u\\in U\\Longrightarrow -u\\in U`\n\nDamit muss die Existenz additiver Inverser innerhalb von `(U)` nicht zusätzlich geprüft werden, wenn die Skalarmultiplikation bereits abgeschlossen ist.\n\n### M2.4.5 Unterraumkriterium mit drei Bedingungen\n\nDie bisherigen Beobachtungen erlauben mir, die Prüfung eines Untervektorraums wesentlich zu verkürzen.\n\nSei `(U\\subseteq V)`. Dann gilt:\n\n\\[\nU\\leq V\\iff\n\\left(\n0_V\\in U\n\\land\n\\forall u,v\\in U:u+v\\in U\n\\land\n\\forall\\lambda\\in K\\ \\forall u\\in U:\\lambda u\\in U\n\\right)\\tag{M2.108}\n\\]\n\nWord-LaTeX: `U\\leq V\\iff\\left(0_V\\in U\\land\\forall u,v\\in U:u+v\\in U\\land\\forall\\lambda\\in K\\ \\forall u\\in U:\\lambda u\\in U\\right)`\n\nFür mich ist dieses Kriterium deshalb wichtig, weil ich nicht sämtliche Vektorraumaxiome noch einmal für `(U)` prüfen muss.\n\nAssoziativität und Kommutativität der Addition, die Distributivgesetze, die Verträglichkeit der Skalarmultiplikation mit der Körpermultiplikation und die Wirkung von `(1_K)` werden von `(V)` geerbt. Sie gelten für Elemente aus `(U)` automatisch, weil diese zugleich Elemente aus `(V)` sind.\n\nZu prüfen bleibt deshalb nur, ob die erforderlichen Ergebnisse der Operationen innerhalb von `(U)` bleiben und ob der Nullvektor vorhanden ist.\n\n### M2.4.6 Verkürztes Unterraumkriterium\n\nDas Kriterium kann noch weiter verdichtet werden.\n\nIst `(U)` nicht leer und gilt für alle `(u,v\\in U)` sowie `(\\lambda,\\mu\\in K)`:\n\n\\[\n\\lambda u+\\mu v\\in U\\tag{M2.109}\n\\]\n\nWord-LaTeX: `\\lambda u+\\mu v\\in U`\n\ndann ist `(U)` ein Untervektorraum von `(V)`.\n\nIch kann dies als Äquivalenz formulieren:\n\n\\[\nU\\leq V\\iff\n\\left(\nU\\neq\\varnothing\n\\land\n\\forall u,v\\in U\\ \\forall\\lambda,\\mu\\in K:\n\\lambda u+\\mu v\\in U\n\\right)\\tag{M2.110}\n\\]\n\nWord-LaTeX: `U\\leq V\\iff\\left(U\\neq\\varnothing\\land\\forall u,v\\in U\\ \\forall\\lambda,\\mu\\in K:\\lambda u+\\mu v\\in U\\right)`\n\nDie Rückrichtung lässt sich unmittelbar aus geeigneten Skalaren gewinnen.\n\nWähle `(\\lambda=\\mu=0_K)`. Da `(U)` nicht leer ist, existiert mindestens ein `(u\\in U)`. Dann folgt:\n\n\\[\n0_Ku+0_Ku=0_V\\in U\\tag{M2.111}\n\\]\n\nWord-LaTeX: `0_Ku+0_Ku=0_V\\in U`\n\nWähle anschließend `(\\lambda=\\mu=1_K)`. Dann ergibt sich für `(u,v\\in U)`:\n\n\\[\nu+v\\in U\\tag{M2.112}\n\\]\n\nWord-LaTeX: `u+v\\in U`\n\nUnd mit `(\\mu=0_K)` folgt für beliebiges `(\\lambda\\in K)`:\n\n\\[\n\\lambda u+0_Kv=\\lambda u\\in U\\tag{M2.113}\n\\]\n\nWord-LaTeX: `\\lambda u+0_Kv=\\lambda u\\in U`\n\nDamit enthält die Bedingung (M2.109) sowohl die Abgeschlossenheit der Addition als auch die Abgeschlossenheit der Skalarmultiplikation.\n\n### M2.4.7 Unterraumkriterium über Differenzen und Skalarmultiplikation\n\nEine weitere nützliche Form ergibt sich aus der bereits verfügbaren Subtraktion.\n\nSei `(U\\neq\\varnothing)`. Wenn für alle `(u,v\\in U)` gilt:\n\n\\[\nu-v\\in U\\tag{M2.114}\n\\]\n\nWord-LaTeX: `u-v\\in U`\n\nund zusätzlich:\n\n\\[\n\\forall\\lambda\\in K\\ \\forall u\\in U:\\lambda u\\in U\\tag{M2.115}\n\\]\n\nWord-LaTeX: `\\forall\\lambda\\in K\\ \\forall u\\in U:\\lambda u\\in U`\n\ndann ist `(U)` ebenfalls ein Untervektorraum.\n\nAus `(u-u\\in U)` folgt zunächst:\n\n\\[\n0_V\\in U\\tag{M2.116}\n\\]\n\nWord-LaTeX: `0_V\\in U`\n\nDa mit `(v\\in U)` auch `((-v)\\in U)` gilt, kann ich durch die Differenzbildung die Addition zurückgewinnen:\n\n\\[\nu-(-v)=u+v\\in U\\tag{M2.117}\n\\]\n\nWord-LaTeX: `u-(-v)=u+v\\in U`\n\nDamit sind auch in dieser Form sämtliche notwendigen Unterraumbedingungen enthalten.\n\n### M2.4.8 Die trivialen Untervektorräume\n\nJeder Vektorraum besitzt mindestens zwei besonders einfache Untervektorräume.\n\nDie Menge, die nur den Nullvektor enthält, ist ein Untervektorraum:\n\n\\[\n\\left\\{0_V\\right\\}\\leq V\\tag{M2.118}\n\\]\n\nWord-LaTeX: `\\left\\{0_V\\right\\}\\leq V`\n\nEbenso ist der gesamte Vektorraum Untervektorraum seiner selbst:\n\n\\[\nV\\leq V\\tag{M2.119}\n\\]\n\nWord-LaTeX: `V\\leq V`\n\nDiese beiden Strukturen bezeichne ich als triviale Untervektorräume.\n\nEin nichttrivialer Untervektorraum `(U)` erfüllt dagegen:\n\n\\[\n\\left\\{0_V\\right\\}\\subsetneq U\\subsetneq V\\tag{M2.120}\n\\]\n\nWord-LaTeX: `\\left\\{0_V\\right\\}\\subsetneq U\\subsetneq V`\n\nFür mich ist diese Einordnung hilfreich, weil sie zeigt, dass die Unterraumstruktur eines Vektorraums zwischen dem minimalen algebraisch abgeschlossenen Bereich `(\\left\\{0_V\\right\\})` und dem vollständigen Raum `(V)` liegt.\n\n### M2.4.9 Schnitt von Untervektorräumen\n\nEine besonders wichtige Stabilitätseigenschaft betrifft den Durchschnitt.\n\nSeien `(U_1)` und `(U_2)` Untervektorräume von `(V)`. Dann ist auch ihr Durchschnitt ein Untervektorraum:\n\n\\[\nU_1\\leq V\\land U_2\\leq V\\Longrightarrow U_1\\cap U_2\\leq V\\tag{M2.121}\n\\]\n\nWord-LaTeX: `U_1\\leq V\\land U_2\\leq V\\Longrightarrow U_1\\cap U_2\\leq V`\n\nDer Nullvektor liegt in beiden Untervektorräumen und damit in ihrem Durchschnitt:\n\n\\[\n0_V\\in U_1\\cap U_2\\tag{M2.122}\n\\]\n\nWord-LaTeX: `0_V\\in U_1\\cap U_2`\n\nSind `(u,v\\in U_1\\cap U_2)`, dann liegen beide Vektoren sowohl in `(U_1)` als auch in `(U_2)`. Wegen der jeweiligen Abgeschlossenheit gilt daher:\n\n\\[\nu+v\\in U_1\\cap U_2\\tag{M2.123}\n\\]\n\nWord-LaTeX: `u+v\\in U_1\\cap U_2`\n\nEbenso gilt für jedes `(\\lambda\\in K)`:\n\n\\[\n\\lambda u\\in U_1\\cap U_2\\tag{M2.124}\n\\]\n\nWord-LaTeX: `\\lambda u\\in U_1\\cap U_2`\n\nDamit erfüllt der Durchschnitt das Unterraumkriterium.\n\n### M2.4.10 Beliebige Durchschnitte von Untervektorräumen\n\nDie Aussage lässt sich auf beliebige Familien von Untervektorräumen erweitern.\n\nSei `((U_i)_{i\\in I})` eine Familie von Untervektorräumen von `(V)`. Dann gilt:\n\n\\[\n\\bigcap_{i\\in I}U_i\\leq V\\tag{M2.125}\n\\]\n\nWord-LaTeX: `\\bigcap_{i\\in I}U_i\\leq V`\n\nVorausgesetzt ist dabei eine nichtleere Indexmenge `(I)`. Jeder `(U_i)` enthält den Nullvektor und ist unter Vektoraddition und Skalarmultiplikation abgeschlossen. Deshalb besitzt auch ihr gemeinsamer Durchschnitt genau diese Eigenschaften.\n\nDiese Beziehung ist für den späteren Spannraum besonders bedeutsam. Sie erlaubt es mir, den kleinsten Untervektorraum zu konstruieren, der eine vorgegebene Menge von Vektoren enthält.\n\n### M2.4.11 Die Vereinigung zweier Untervektorräume\n\nBeim Durchschnitt bleibt die Unterraumstruktur stets erhalten. Für Vereinigungen gilt dies dagegen nicht allgemein.\n\nSeien `(U_1,U_2\\leq V)`. Dann ist `(U_1\\cup U_2)` im Allgemeinen kein Untervektorraum.\n\nDer entscheidende Grund liegt in der Addition. Ist `(u\\in U_1\\setminus U_2)` und `(v\\in U_2\\setminus U_1)`, muss `(u+v)` weder in `(U_1)` noch in `(U_2)` liegen. Dann gilt:\n\n\\[\nu+v\\notin U_1\\cup U_2\\tag{M2.126}\n\\]\n\nWord-LaTeX: `u+v\\notin U_1\\cup U_2`\n\nEine genaue Charakterisierung ist möglich. Die Vereinigung zweier Untervektorräume ist genau dann wieder ein Untervektorraum, wenn einer der beiden vollständig im anderen enthalten ist:\n\n\\[\nU_1\\cup U_2\\leq V\\iff U_1\\subseteq U_2\\lor U_2\\subseteq U_1\\tag{M2.127}\n\\]\n\nWord-LaTeX: `U_1\\cup U_2\\leq V\\iff U_1\\subseteq U_2\\lor U_2\\subseteq U_1`\n\nDiese Aussage zeigt für mich erneut, dass mengentheoretische Vereinigung und algebraischer Abschluss unterschiedliche Operationen sind. Die bloße Vereinigung mehrerer Unterräume erzeugt im Allgemeinen noch keinen Unterraum.\n\n### M2.4.12 Untervektorraum und Gleichungsbedingungen\n\nEine wichtige Klasse von Untervektorräumen entsteht dadurch, dass Elemente eines Vektorraums zusätzliche homogene algebraische Bedingungen erfüllen.\n\nFür den allgemeinen Aufbau möchte ich hier jedoch noch keine linearen Abbildungen voraussetzen; diese werden erst später systematisch eingeführt. Ich beschränke mich deshalb auf die strukturelle Beobachtung:\n\nEine Teilmenge ist genau dann als Untervektorraum geeignet, wenn ihre definierende Bedingung mit der Vektoraddition und der Skalarmultiplikation verträglich ist.\n\nFür mich ergibt sich daraus ein praktisches Prüfschema:\n\n1. Enthält die Menge den Nullvektor?\n2. Bleibt die definierende Bedingung bei Addition zweier zulässiger Vektoren erhalten?\n3. Bleibt sie bei Multiplikation eines zulässigen Vektors mit einem beliebigen Skalar erhalten?\n\nErst wenn alle drei Fragen positiv beantwortet werden können, ist ein Untervektorraum nachgewiesen.\n\n### M2.4.13 Untervektorräume verändern den Skalarkörper nicht\n\nEin Untervektorraum `(U\\leq V)` verwendet denselben Skalarkörper `(K)` wie `(V)`.\n\nDie Skalarmultiplikation besitzt deshalb die Signatur:\n\n\\[\n\\cdot:K\\times U\\rightarrow U\\tag{M2.128}\n\\]\n\nWord-LaTeX: `\\cdot:K\\times U\\rightarrow U`\n\nIch möchte diese Voraussetzung ausdrücklich festhalten. Eine Teilmenge kann bezüglich eines anderen Körpers unter Umständen eine andere algebraische Struktur besitzen. Eine solche Änderung des Skalarkörpers ist jedoch nicht Teil der gewöhnlichen Untervektorraumbeziehung `(U\\leq V)`.\n\n### M2.4.14 Untervektorraum ist noch kein erzeugter Raum\n\nMit dem Unterraumbegriff kann ich nun entscheiden, ob eine bereits gegebene Teilmenge selbst einen Vektorraum bildet. Noch nicht beantwortet ist jedoch die umgekehrte Frage:\n\n**Welcher Untervektorraum entsteht aus vorgegebenen Vektoren?**\n\nSind beispielsweise `(v_1,\\ldots,v_n\\in V)` gegeben, reicht ihre bloße Menge:\n\n\\[\n\\left\\{v_1,\\ldots,v_n\\right\\}\\tag{M2.129}\n\\]\n\nWord-LaTeX: `\\left\\{v_1,\\ldots,v_n\\right\\}`\n\nim Allgemeinen nicht aus, um einen Untervektorraum zu bilden. Ich muss zusätzlich sämtliche Vektoren aufnehmen, die durch zulässige Additionen und Skalarmultiplikationen aus ihnen entstehen.\n\nGenau diese Frage führt zur Linearkombination.\n\n### M2.4.15 Ergebnis und Weitergabestelle\n\nMit M2.4 kann ich nun zwischen einer beliebigen Teilmenge eines Vektorraums und einem algebraisch abgeschlossenen Untervektorraum unterscheiden.\n\nEin Untervektorraum enthält den Nullvektor und bleibt sowohl unter Vektoraddition als auch unter Skalarmultiplikation abgeschlossen. Alle übrigen Vektorraumaxiome werden aus dem umgebenden Vektorraum geerbt. Dadurch genügt für die Prüfung einer Teilmenge das Unterraumkriterium; eine vollständige erneute Prüfung sämtlicher Vektorraumaxiome ist nicht erforderlich. [[71]]\n\nBesonders wichtig für den weiteren Aufbau ist die Stabilität beliebiger Durchschnitte von Untervektorräumen. Dadurch kann später aus einer gegebenen Menge von Vektoren ein eindeutig bestimmter kleinster Untervektorraum gewonnen werden, der diese Menge enthält. Die einfache Vereinigung von Untervektorräumen besitzt diese Eigenschaft dagegen im Allgemeinen nicht.\n\nDamit ist nun bekannt, **wann eine Teilmenge bereits einen Untervektorraum bildet**. Noch fehlt jedoch die konstruktive Beschreibung der Vektoren, die aus einer vorgegebenen Menge durch die Vektorraumoperationen erzeugt werden können.\n\nDie **Weitergabestelle M2.4 → M2.5** liegt deshalb bei der Kombination von Vektoraddition und Skalarmultiplikation.\n\n**M2.5 Linearkombinationen und Spannraum** führt Ausdrücke der Form `(\\lambda_1v_1+\\cdots+\\lambda_nv_n)` ein und bestimmt anschließend den kleinsten Untervektorraum, der eine gegebene Vektormenge enthält.', '75b25e1cb8e9fc9e1a8406c53cfebfb0dc3778dcac43e0e1d9c59963dbccbbe0', 'Freigegebener Reset-Volltext M2.4 mit Gleichungen M2.99 bis M2.129 und Weitergabestelle M2.4 → M2.5.');
INSERT INTO `appendix_section_versions` (`appendix_section_version_id`, `appendix_section_id`, `revision_id`, `version_kind`, `body_markdown`, `checksum_sha256`, `notes`) VALUES
(19, 20, 32, 'draft', '## M2.5 Linearkombinationen und Spannraum\n\nMit M2.4 kann ich entscheiden, ob eine bereits vorgegebene Teilmenge `(U\\subseteq V)` ein Untervektorraum ist. Für den weiteren Aufbau benötige ich nun die umgekehrte Blickrichtung. Ausgangspunkt soll nicht mehr ein bereits abgeschlossener Unterraum sein, sondern eine Menge ausgewählter Vektoren. Ich möchte bestimmen, welche Vektoren sich aus diesen Ausgangsvektoren allein durch die beiden zulässigen Vektorraumoperationen erzeugen lassen.\n\nGenau dafür verbinde ich Vektoraddition und Skalarmultiplikation zur **Linearkombination**. Der daraus entstehende Spannraum wird anschließend der kleinste Untervektorraum sein, der die vorgegebenen Vektoren enthält. [[71]]\n\n### M2.5.1 Linearkombination endlich vieler Vektoren\n\nSeien `(v_1,\\ldots,v_n\\in V)` und `(\\lambda_1,\\ldots,\\lambda_n\\in K)`. Dann bezeichne ich den Vektor\n\n\\[\n\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n\\tag{M2.130}\n\\]\n\nWord-LaTeX: `\\lambda_1v_1+\\lambda_2v_2+\\cdots+\\lambda_nv_n`\n\nals Linearkombination der Vektoren `(v_1,\\ldots,v_n)` mit den Koeffizienten `(\\lambda_1,\\ldots,\\lambda_n)`.\n\nIn Summenschreibweise kann ich denselben Ausdruck schreiben als:\n\n\\[\n\\sum_{i=1}^{n}\\lambda_iv_i\\tag{M2.131}\n\\]\n\nWord-LaTeX: `\\sum_{i=1}^{n}\\lambda_iv_i`\n\nFür mich ist dabei wesentlich, dass sämtliche verwendeten Skalare aus demselben Körper `(K)` stammen und sämtliche Vektoren demselben Vektorraum `(V)` angehören.\n\nDa `(V)` unter Addition und Skalarmultiplikation abgeschlossen ist, gilt:\n\n\\[\n\\sum_{i=1}^{n}\\lambda_iv_i\\in V\\tag{M2.132}\n\\]\n\nWord-LaTeX: `\\sum_{i=1}^{n}\\lambda_iv_i\\in V`\n\nDie Linearkombination führt also nicht aus dem Vektorraum heraus.\n\n### M2.5.2 Koeffizienten und erzeugende Vektoren besitzen unterschiedliche Rollen\n\nIn einer Linearkombination möchte ich die Rollen der beteiligten Größen ausdrücklich unterscheiden.\n\nDie Skalare `(\\lambda_i)` bestimmen, mit welchem Faktor die Vektoren `(v_i)` in die Kombination eingehen. Die Vektoren selbst sind die algebraischen Erzeugungselemente.\n\nEin einzelner Summand besitzt die Form:\n\n\\[\n\\lambda_iv_i\\in V\\tag{M2.133}\n\\]\n\nWord-LaTeX: `\\lambda_iv_i\\in V`\n\nund die anschließende Addition dieser Summanden bleibt wiederum in `(V)`.\n\nFür mich ist wichtig, dass ein Koeffizient auch gleich `(0_K)` sein darf. Dann trägt der betreffende Vektor zu dieser konkreten Linearkombination nichts bei:\n\n\\[\n0_Kv_i=0_V\\tag{M2.134}\n\\]\n\nWord-LaTeX: `0_Kv_i=0_V`\n\nDie bloße Aufnahme eines Vektors in eine aufgeschriebene Liste bedeutet daher noch nicht, dass er für jede Linearkombination tatsächlich wirksam wird.\n\n### M2.5.3 Die triviale Linearkombination\n\nWähle ich sämtliche Koeffizienten gleich Null, erhalte ich:\n\n\\[\n0_Kv_1+\\cdots+0_Kv_n=0_V\\tag{M2.135}\n\\]\n\nWord-LaTeX: `0_Kv_1+\\cdots+0_Kv_n=0_V`\n\nDiese Darstellung bezeichne ich als triviale Linearkombination der Vektoren `(v_1,\\ldots,v_n)`.\n\nDer Nullvektor ist damit immer als Linearkombination beliebiger endlich vieler Vektoren darstellbar.\n\nDiese Beobachtung wird später für die Definition linearer Abhängigkeit und Unabhängigkeit entscheidend sein. Dort wird nicht die bloße Darstellbarkeit des Nullvektors untersucht, sondern die Frage, ob außer der trivialen Koeffizientenwahl weitere Darstellungen des Nullvektors existieren.\n\n### M2.5.4 Lineare Hülle einer endlichen Vektormenge\n\nSeien `(v_1,\\ldots,v_n\\in V)`. Ich definiere die Menge aller Linearkombinationen dieser Vektoren als:\n\n\\[\n\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}=\\left\\{\\sum_{i=1}^{n}\\lambda_iv_i\\mid\\lambda_1,\\ldots,\\lambda_n\\in K\\right\\}\\tag{M2.136}\n\\]\n\nWord-LaTeX: `\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}=\\left\\{\\sum_{i=1}^{n}\\lambda_iv_i\\mid\\lambda_1,\\ldots,\\lambda_n\\in K\\right\\}`\n\nDiese Menge bezeichne ich als Spannraum oder lineare Hülle der Vektoren.\n\nÄquivalent kann ich schreiben:\n\n\\[\n\\operatorname{span}(v_1,\\ldots,v_n)=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\tag{M2.137}\n\\]\n\nWord-LaTeX: `\\operatorname{span}(v_1,\\ldots,v_n)=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}`\n\nDie erste Schreibweise betont stärker die Menge der Erzeuger, die zweite ihre Auflistung. Inhaltlich bezeichne ich damit denselben Unterraum.\n\n### M2.5.5 Jeder Erzeuger liegt im eigenen Spannraum\n\nJeder der Ausgangsvektoren ist selbst Element des erzeugten Spannraums.\n\nFür `(j\\in\\left\\{1,\\ldots,n\\right\\})` wähle ich die Koeffizienten so, dass nur der `(j)`-te Koeffizient gleich `(1_K)` ist. Dann gilt:\n\n\\[\nv_j=0_Kv_1+\\cdots+1_Kv_j+\\cdots+0_Kv_n\\tag{M2.138}\n\\]\n\nWord-LaTeX: `v_j=0_Kv_1+\\cdots+1_Kv_j+\\cdots+0_Kv_n`\n\nDaraus folgt:\n\n\\[\nv_j\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\tag{M2.139}\n\\]\n\nWord-LaTeX: `v_j\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}`\n\nund damit insgesamt:\n\n\\[\n\\left\\{v_1,\\ldots,v_n\\right\\}\\subseteq\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\tag{M2.140}\n\\]\n\nWord-LaTeX: `\\left\\{v_1,\\ldots,v_n\\right\\}\\subseteq\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}`\n\nDer Spannraum enthält also mindestens sämtliche ursprünglichen Erzeuger.\n\n### M2.5.6 Der Spannraum ist ein Untervektorraum\n\nNun muss ich prüfen, ob die Menge aller Linearkombinationen tatsächlich einen Untervektorraum bildet.\n\nZunächst enthält sie den Nullvektor aufgrund der trivialen Linearkombination:\n\n\\[\n0_V\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\tag{M2.141}\n\\]\n\nWord-LaTeX: `0_V\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}`\n\nSeien nun:\n\n\\[\nx=\\sum_{i=1}^{n}\\lambda_iv_i,\\qquad y=\\sum_{i=1}^{n}\\mu_iv_i\\tag{M2.142}\n\\]\n\nWord-LaTeX: `x=\\sum_{i=1}^{n}\\lambda_iv_i,\\qquad y=\\sum_{i=1}^{n}\\mu_iv_i`\n\nzwei Elemente des Spannraums.\n\nDann gilt:\n\n\\[\nx+y=\\sum_{i=1}^{n}(\\lambda_i+\\mu_i)v_i\\tag{M2.143}\n\\]\n\nWord-LaTeX: `x+y=\\sum_{i=1}^{n}(\\lambda_i+\\mu_i)v_i`\n\nDa `(\\lambda_i+\\mu_i\\in K)` gilt, ist `(x+y)` erneut eine Linearkombination derselben Erzeuger:\n\n\\[\nx+y\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\tag{M2.144}\n\\]\n\nWord-LaTeX: `x+y\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}`\n\nFür einen beliebigen Skalar `(\\alpha\\in K)` gilt außerdem:\n\n\\[\n\\alpha x=\\alpha\\sum_{i=1}^{n}\\lambda_iv_i=\\sum_{i=1}^{n}(\\alpha\\lambda_i)v_i\\tag{M2.145}\n\\]\n\nWord-LaTeX: `\\alpha x=\\alpha\\sum_{i=1}^{n}\\lambda_iv_i=\\sum_{i=1}^{n}(\\alpha\\lambda_i)v_i`\n\nDamit folgt:\n\n\\[\n\\alpha x\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\tag{M2.146}\n\\]\n\nWord-LaTeX: `\\alpha x\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}`\n\nNach dem Unterraumkriterium ist deshalb:\n\n\\[\n\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\leq V\\tag{M2.147}\n\\]\n\nWord-LaTeX: `\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\leq V`\n\nDamit ist der Spannraum tatsächlich ein Untervektorraum.\n\n### M2.5.7 Allgemeiner Spannraum einer Teilmenge\n\nDie Konstruktion soll nicht auf endlich vorgegebene Listen beschränkt bleiben.\n\nSei `(S\\subseteq V)` eine beliebige Teilmenge. Dann definiere ich `(\\operatorname{span}(S))` als die Menge sämtlicher **endlicher** Linearkombinationen von Elementen aus `(S)`:\n\n\\[\n\\operatorname{span}(S)=\\left\\{\\sum_{i=1}^{n}\\lambda_is_i\\mid n\\in\\mathbb{N},\\ s_i\\in S,\\ \\lambda_i\\in K\\right\\}\\tag{M2.148}\n\\]\n\nWord-LaTeX: `\\operatorname{span}(S)=\\left\\{\\sum_{i=1}^{n}\\lambda_is_i\\mid n\\in\\mathbb{N},\\ s_i\\in S,\\ \\lambda_i\\in K\\right\\}`\n\nFür mich ist das Wort **endlich** an dieser Stelle wesentlich. Auch wenn `(S)` unendlich viele Elemente enthält, verwendet eine einzelne Linearkombination im rein algebraischen Vektorraum nur endlich viele davon.\n\nUnendliche Summen benötigen zusätzliche Konvergenz- oder topologische Strukturen. Diese stehen in M2 nicht zur Verfügung und dürfen deshalb nicht stillschweigend in den Spannraumbegriff aufgenommen werden.\n\n### M2.5.8 Spannraum der leeren Menge\n\nFür die leere Erzeugermenge benötigt die Definition eine konsistente Randfestlegung.\n\nIch setze:\n\n\\[\n\\operatorname{span}(\\varnothing)=\\left\\{0_V\\right\\}\\tag{M2.149}\n\\]\n\nWord-LaTeX: `\\operatorname{span}(\\varnothing)=\\left\\{0_V\\right\\}`\n\nDamit ist auch der Spannraum der leeren Menge ein Untervektorraum.\n\nDiese Festlegung entspricht der Idee, dass ohne vorhandene Erzeuger nur die leere beziehungsweise triviale Linearkombination zur Verfügung steht und damit ausschließlich der Nullvektor erzeugt wird. [[72]]\n\n### M2.5.9 Der Spannraum als kleinster Untervektorraum\n\nDie zentrale Bedeutung des Spannraums ergibt sich für mich aus seiner Minimalität.\n\nSei `(S\\subseteq V)`. Dann gilt zunächst:\n\n\\[\nS\\subseteq\\operatorname{span}(S)\\tag{M2.150}\n\\]\n\nWord-LaTeX: `S\\subseteq\\operatorname{span}(S)`\n\nSei nun `(U\\leq V)` ein beliebiger Untervektorraum mit:\n\n\\[\nS\\subseteq U\\tag{M2.151}\n\\]\n\nWord-LaTeX: `S\\subseteq U`\n\nDa `(U)` unter Skalarmultiplikation und Addition abgeschlossen ist, enthält `(U)` jede endliche Linearkombination von Elementen aus `(S)`. Deshalb gilt:\n\n\\[\n\\operatorname{span}(S)\\subseteq U\\tag{M2.152}\n\\]\n\nWord-LaTeX: `\\operatorname{span}(S)\\subseteq U`\n\nDamit ist `(\\operatorname{span}(S))` der kleinste Untervektorraum von `(V)`, der `(S)` enthält.\n\nIch kann diese Aussage kompakt schreiben als:\n\n\\[\n\\operatorname{span}(S)=\\bigcap_{\\substack{U\\leq V\\\\S\\subseteq U}}U\\tag{M2.153}\n\\]\n\nWord-LaTeX: `\\operatorname{span}(S)=\\bigcap_{\\substack{U\\leq V\\\\S\\subseteq U}}U`\n\nHier zeigt sich unmittelbar, warum die Stabilität von Untervektorräumen unter Durchschnitten aus M2.4 wichtig war.\n\n### M2.5.10 Monotonie des Spannraums\n\nAus der Minimalität folgt eine wichtige Ordnungseigenschaft.\n\nSeien `(S,T\\subseteq V)` und gelte:\n\n\\[\nS\\subseteq T\\tag{M2.154}\n\\]\n\nWord-LaTeX: `S\\subseteq T`\n\nDann gilt:\n\n\\[\n\\operatorname{span}(S)\\subseteq\\operatorname{span}(T)\\tag{M2.155}\n\\]\n\nWord-LaTeX: `\\operatorname{span}(S)\\subseteq\\operatorname{span}(T)`\n\nEine größere Erzeugermenge kann den erzeugten Unterraum also nicht verkleinern.\n\nFür mich bedeutet das jedoch nicht, dass jeder zusätzlich aufgenommene Vektor den Spannraum tatsächlich vergrößert. Liegt ein neuer Vektor bereits im bisherigen Spannraum, bleibt der erzeugte Unterraum unverändert.\n\n### M2.5.11 Hinzufügen eines bereits erzeugbaren Vektors\n\nSei `(v\\in\\operatorname{span}(S))`. Dann gilt:\n\n\\[\n\\operatorname{span}(S\\cup\\left\\{v\\right\\})=\\operatorname{span}(S)\\tag{M2.156}\n\\]\n\nWord-LaTeX: `\\operatorname{span}(S\\cup\\left\\{v\\right\\})=\\operatorname{span}(S)`\n\nDiese Aussage ist für den folgenden Abschnitt besonders wichtig.\n\nEin zusätzlicher Vektor vergrößert den Spannraum nur dann, wenn er noch **nicht** aus den vorhandenen Erzeugern linear kombinierbar ist.\n\nDamit entsteht erstmals ein präzises Kriterium dafür, wann ein zusätzlich aufgeschriebenes Element algebraisch tatsächlich neue Erzeugungsmöglichkeiten liefert.\n\n### M2.5.12 Idempotenz der Spannraumbildung\n\nDa `(\\operatorname{span}(S))` bereits ein Untervektorraum ist, erzeugt seine erneute lineare Hülle keinen größeren Raum:\n\n\\[\n\\operatorname{span}(\\operatorname{span}(S))=\\operatorname{span}(S)\\tag{M2.157}\n\\]\n\nWord-LaTeX: `\\operatorname{span}(\\operatorname{span}(S))=\\operatorname{span}(S)`\n\nFür mich zeigt diese Beziehung besonders klar den Abschlusscharakter der Spannraumbildung. Nach einmaliger Bildung sind bereits alle durch endliche Linearkombinationen erzeugbaren Vektoren enthalten.\n\n### M2.5.13 Spannraum einer Vereinigung\n\nSeien `(S,T\\subseteq V)`. Der Spannraum ihrer Vereinigung ist der kleinste Untervektorraum, der sowohl `(S)` als auch `(T)` enthält:\n\n\\[\n\\operatorname{span}(S\\cup T)=\\operatorname{span}\\left(\\operatorname{span}(S)\\cup\\operatorname{span}(T)\\right)\\tag{M2.158}\n\\]\n\nWord-LaTeX: `\\operatorname{span}(S\\cup T)=\\operatorname{span}\\left(\\operatorname{span}(S)\\cup\\operatorname{span}(T)\\right)`\n\nDabei muss ich zwischen der bloßen Vereinigung `(\\operatorname{span}(S)\\cup\\operatorname{span}(T))` und ihrem algebraischen Abschluss unterscheiden. Wie in M2.4 gezeigt, ist die Vereinigung zweier Untervektorräume im Allgemeinen noch kein Untervektorraum.\n\nFür zwei Untervektorräume `(U,W\\leq V)` kann ich deshalb die Menge aller Summen eines Vektors aus `(U)` und eines Vektors aus `(W)` betrachten:\n\n\\[\nU+W=\\left\\{u+w\\mid u\\in U,\\ w\\in W\\right\\}\\tag{M2.159}\n\\]\n\nWord-LaTeX: `U+W=\\left\\{u+w\\mid u\\in U,\\ w\\in W\\right\\}`\n\nDiese Menge ist ein Untervektorraum und erfüllt:\n\n\\[\nU+W=\\operatorname{span}(U\\cup W)\\tag{M2.160}\n\\]\n\nWord-LaTeX: `U+W=\\operatorname{span}(U\\cup W)`\n\nDamit steht neben dem Durchschnitt auch eine algebraisch abgeschlossene Form des Zusammenführens zweier Unterräume zur Verfügung.\n\n### M2.5.14 Erzeugendensystem\n\nEine Teilmenge `(S\\subseteq V)` nenne ich ein Erzeugendensystem von `(V)`, wenn ihr Spannraum der gesamte Vektorraum ist:\n\n\\[\n\\operatorname{span}(S)=V\\tag{M2.161}\n\\]\n\nWord-LaTeX: `\\operatorname{span}(S)=V`\n\nFür eine endliche Menge `(S=\\left\\{v_1,\\ldots,v_n\\right\\})` bedeutet dies:\n\n\\[\nV=\\left\\{\\sum_{i=1}^{n}\\lambda_iv_i\\mid\\lambda_1,\\ldots,\\lambda_n\\in K\\right\\}\\tag{M2.162}\n\\]\n\nWord-LaTeX: `V=\\left\\{\\sum_{i=1}^{n}\\lambda_iv_i\\mid\\lambda_1,\\ldots,\\lambda_n\\in K\\right\\}`\n\nDann kann jeder Vektor des Raums als Linearkombination der Erzeuger dargestellt werden.\n\nDabei ist noch nicht gefordert, dass diese Darstellung eindeutig ist. Ein Erzeugendensystem kann mehr Vektoren enthalten, als tatsächlich für die Erzeugung des Raums erforderlich sind.\n\n### M2.5.15 Endlich erzeugte Vektorräume\n\nExistiert eine endliche Menge von Vektoren `(v_1,\\ldots,v_n)` mit:\n\n\\[\nV=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\tag{M2.163}\n\\]\n\nWord-LaTeX: `V=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}`\n\ndann ist `(V)` endlich erzeugt.\n\nDiese Aussage darf ich noch nicht mit Endlichdimensionalität gleichsetzen, solange die Basis und ihre Eigenschaften noch nicht entwickelt wurden. Später werde ich zeigen, wie aus einem endlichen Erzeugendensystem durch Entfernung linear redundanter Vektoren eine Basis gewonnen werden kann.\n\n### M2.5.16 Redundanz innerhalb eines Erzeugendensystems\n\nNun kann ich die zuvor nur qualitativ angesprochene Redundanz präzise formulieren.\n\nSeien `(v_1,\\ldots,v_n\\in V)` und gelte für ein bestimmtes `(j)`:\n\n\\[\nv_j\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_{j-1},v_{j+1},\\ldots,v_n\\right\\}\\tag{M2.164}\n\\]\n\nWord-LaTeX: `v_j\\in\\operatorname{span}\\left\\{v_1,\\ldots,v_{j-1},v_{j+1},\\ldots,v_n\\right\\}`\n\nDann trägt `(v_j)` keine zusätzliche Erzeugungsfähigkeit bei. Es gilt:\n\n\\[\n\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}=\\operatorname{span}\\left\\{v_1,\\ldots,v_{j-1},v_{j+1},\\ldots,v_n\\right\\}\\tag{M2.165}\n\\]\n\nWord-LaTeX: `\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}=\\operatorname{span}\\left\\{v_1,\\ldots,v_{j-1},v_{j+1},\\ldots,v_n\\right\\}`\n\nDamit habe ich erstmals ein exaktes mathematisches Kriterium dafür, wann ein Vektor aus einem Erzeugendensystem entfernt werden kann, ohne den erzeugten Raum zu verändern.\n\n### M2.5.17 Erzeugung ist noch keine eindeutige Darstellung\n\nAus:\n\n\\[\nV=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}\\tag{M2.166}\n\\]\n\nWord-LaTeX: `V=\\operatorname{span}\\left\\{v_1,\\ldots,v_n\\right\\}`\n\nfolgt zunächst nur, dass für jedes `(v\\in V)` mindestens eine Koeffizientenfolge `(\\lambda_1,\\ldots,\\lambda_n)` existiert mit:\n\n\\[\nv=\\sum_{i=1}^{n}\\lambda_iv_i\\tag{M2.167}\n\\]\n\nWord-LaTeX: `v=\\sum_{i=1}^{n}\\lambda_iv_i`\n\nEs folgt daraus noch nicht, dass diese Koeffizienten eindeutig bestimmt sind.\n\nGenau an dieser Stelle erreicht der Spannraumbegriff seine Grenze. Er beantwortet die Frage, **welche Vektoren erzeugbar sind**, aber noch nicht, ob die verwendeten Erzeuger algebraisch voneinander unabhängig sind.\n\n### M2.5.18 Ergebnis und Weitergabestelle\n\nMit M2.5 steht die Linearkombination als grundlegende algebraische Erzeugungsoperation zur Verfügung. Aus einer Menge `(S\\subseteq V)` kann ich durch sämtliche endlichen Linearkombinationen den Spannraum `(\\operatorname{span}(S))` bilden.\n\nDieser Spannraum ist ein Untervektorraum, enthält die ursprüngliche Menge `(S)` und ist der kleinste Untervektorraum mit dieser Eigenschaft. Die Spannraumbildung ist monoton und idempotent. Ein Vektor, der bereits im Spannraum einer Erzeugermenge liegt, kann dieser Menge hinzugefügt werden, ohne den erzeugten Unterraum zu verändern.\n\nDamit kann ich nun auch Erzeugendensysteme präzise definieren. Ein Erzeugendensystem erzeugt den gesamten Vektorraum, muss aber weder minimal sein noch eine eindeutige Darstellung der Vektoren liefern.\n\nGenau diese noch offene Redundanzfrage bestimmt den nächsten Schritt. Ich muss entscheiden können, wann ein Vektor bereits als Linearkombination anderer Vektoren darstellbar ist und wann keine solche algebraische Abhängigkeit besteht.\n\nDie **Weitergabestelle M2.5 → M2.6** liegt deshalb bei der Darstellung des Nullvektors durch Linearkombinationen.\n\n**M2.6 Lineare Abhängigkeit und lineare Unabhängigkeit** untersucht, ob eine Gleichung der Form `(\\lambda_1v_1+\\cdots+\\lambda_nv_n=0_V)` ausschließlich durch die triviale Koeffizientenwahl gelöst werden kann oder ob nichttriviale Koeffizienten existieren. Erst diese Unterscheidung erlaubt später die Einführung von Basis und Dimension.', '1d21ad0a535e69b2d174057672785017ac697c5c7e3ca0fb3c2d444336aebd2b', 'Freigegebener Reset-Volltext M2.5 mit Gleichungen M2.130 bis M2.167 und Weitergabestelle M2.5 → M2.6.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `appendix_source_usage`
--

CREATE TABLE `appendix_source_usage` (
  `appendix_usage_id` bigint(20) UNSIGNED NOT NULL,
  `appendix_section_id` bigint(20) UNSIGNED NOT NULL,
  `source_id` bigint(20) UNSIGNED NOT NULL,
  `usage_type` enum('first_citation','background','definition','theorem','method','equation_source','other') NOT NULL,
  `claim_summary` longtext NOT NULL,
  `exact_location` varchar(500) DEFAULT NULL,
  `is_first_mention` tinyint(1) NOT NULL DEFAULT 0,
  `citation_checked` tinyint(1) NOT NULL DEFAULT 0,
  `notes` longtext DEFAULT NULL,
  `created_revision_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `appendix_source_usage`
--

INSERT INTO `appendix_source_usage` (`appendix_usage_id`, `appendix_section_id`, `source_id`, `usage_type`, `claim_summary`, `exact_location`, `is_first_mention`, `citation_checked`, `notes`, `created_revision_id`) VALUES
(1, 1, 3, 'first_citation', 'Mengentheoretische Grundlage für Mengen, Teilmengen, geordnete Paare, Relationen und Funktionen.', 'M1.0, erste Literaturverwendung in Anlage M1', 1, 1, 'Erstnennung in M1 exakt in der Form {[[genaue Literaturangabe]]}[[6]]; weitere Nennungen in M1 nur [[6]].', 13),
(2, 1, 39, 'first_citation', 'Strukturorientierter methodischer Rahmen für die Trennung mathematischer Objekte, Operationen, Beziehungen und späterer Interpretation.', 'M1.0, erste Literaturverwendung in Anlage M1', 1, 1, 'Erstnennung in M1 exakt in der Form {[[genaue Literaturangabe]]}[[60]]; weitere Nennungen in M1 nur [[60]].', 13),
(3, 2, 3, 'definition', 'Halmos stützt die elementaren Begriffe Menge, Elementzugehörigkeit, extensionale Mengengleichheit, leere Menge und die Unterscheidung von Element- und Mengenebenen.', 'M1.1; Fortsetzungsnennung innerhalb derselben Anlage M1 nach der Erstnennung in M1.0.', 0, 1, 'Gemäß Anlagenregel wird Halmos in M1.1 nur mit [[6]] fortzitiert; die vollständige Erstnennung steht bereits in M1.0.', 14),
(4, 3, 3, 'background', 'Teilmengen, echte Teilmengen, Transitivität, Potenzmenge und Mächtigkeit endlicher Potenzmengen.', 'M1.2, Fortführung der in M1.0 begonnenen Literaturverwendung', 0, 1, 'Keine bibliografische Erstnennung in M1.2; im Fließtext ausschließlich [[6]].', 15),
(5, 4, 3, 'background', 'Vereinigung, Durchschnitt, Mengendifferenz, Komplement, De-Morgan-Beziehungen und Distributivität.', NULL, 0, 1, 'Keine bibliografische Erstnennung in M1.3; im Fließtext ausschließlich [[6]].', 16),
(6, 5, 3, 'background', 'Mengentheoretische Grundlage für geordnete Paare, kartesische Produkte, Tupel und Funktionen.', 'M1.4, Folgezitation innerhalb von Anlage M1', 0, 1, 'Halmos wurde in M1.0 erstmals vollständig genannt; in M1.4 ist ausschließlich die Folgezitation [[6]] zulässig.', 17),
(7, 6, 3, 'background', 'Mengentheoretische Grundlage für Relationen, Relationsklassen, Umkehrrelationen und Relationskomposition.', 'M1.5, Folgezitation innerhalb von Anlage M1', 0, 1, 'Halmos wurde in M1.0 erstmals vollständig genannt; in M1.5 ist ausschließlich die Folgezitation [[6]] zulässig.', 18),
(8, 7, 3, 'definition', 'Mengentheoretische und funktionale Grundlage für Funktionsgraph, Existenz und Eindeutigkeit, Definitions- und Zielbereich, Bild, Einschränkung, Identitätsfunktion und Funktionsmengen.', 'M1.6, Folgezitation innerhalb von Anlage M1', 0, 1, 'Halmos wurde in M1.0 erstmals vollständig genannt; in M1.6 ist ausschließlich die Folgezitation [[6]] zulässig.', 19),
(9, 8, 3, 'definition', 'Mengentheoretische und funktionale Grundlage für Injektivität, Surjektivität, Bijektivität, Umkehrfunktionen und Komposition bijektiver Funktionen.', 'M1.7, Folgezitation innerhalb von Anlage M1', 0, 1, 'Halmos wurde in M1.0 erstmals vollständig genannt; in M1.7 ist ausschließlich die Folgezitation [[6]] zulässig.', 20),
(10, 9, 3, 'definition', 'Mengentheoretische und funktionale Grundlage für direkte Bildbildung, Urbildbildung und deren Beziehungen zu Mengenoperationen.', 'M1.8, Folgezitation innerhalb von Anlage M1', 0, 1, 'Halmos wurde in M1.0 erstmals vollständig genannt; in M1.8 ist ausschließlich die Folgezitation [[6]] zulässig.', 21),
(11, 11, 3, 'background', 'Mengentheoretische und funktionale Grundlage für mehrstellige, parametrisierte und partielle Funktionen.', 'M1.10, insbesondere M1.10.1 bis M1.10.8', 0, 1, 'Halmos wurde in M1.0 erstmals vollständig genannt; hier ausschließlich Folgezitation [[6]].', 23),
(12, 13, 50, 'first_citation', 'Algebraische Grundlegung des Vektorraums über einem Körper; Trennung abstrakter Struktur und Koordinatendarstellung.', 'M2.0, erste Literaturverwendung in Anlage M2; Kapitel III „Modules“, Abschnitte zu Modulen und Vektorräumen.', 1, 1, 'Erstnennung in M2 exakt als {[[genaue Literaturangabe]]}[[71]]; weitere Nennungen derselben Quelle in M2 nur [[71]].', 25),
(13, 13, 51, 'first_citation', 'Aufbau von Spannraum, linearer Unabhängigkeit, Basis und Dimension aus der Vektorraumstruktur.', 'M2.0, erste Literaturverwendung in Anlage M2; Kapitel 3 „Vector Spaces and Subspaces“.', 1, 1, 'Erstnennung in M2 exakt als {[[genaue Literaturangabe]]}[[72]]; weitere Nennungen derselben Quelle in M2 nur [[72]].', 25),
(14, 14, 50, 'definition', 'Folgezitation Lang [[71]] für Körperaxiome, abgeleitete Rechenregeln und den Vektorraumübergang.', 'Kapitel III: Modules; Vektorraeume und Koerperstruktur', 0, 1, 'Folgezitation in M2.1; Erstnennung erfolgte in M2.0.', 26),
(15, 14, 51, 'background', 'Folgezitation Strang [[72]] für die Einordnung reeller und komplexer Skalarkörper.', 'Kapitel 3: Vector Spaces and Subspaces', 0, 1, 'Folgezitation in M2.1; Erstnennung erfolgte in M2.0.', 26),
(16, 16, 50, 'definition', 'Folgezitation Lang [[71]] für abstrakte Vektorraumdefinition und Axiombestand.', 'Kapitel III: Modules; Vektorraeume', 0, 1, 'Folgezitation in M2.2; Erstnennung erfolgte in M2.0.', 28),
(17, 16, 51, 'background', 'Folgezitation Strang [[72]] für die Trennung von abstraktem Vektor und Koordinatendarstellung.', 'Kapitel 3: Vector Spaces and Subspaces', 0, 1, 'Folgezitation in M2.2; Erstnennung erfolgte in M2.0.', 28),
(18, 17, 50, '', 'Vektorraumaxiome und daraus abgeleitete algebraische Standardfolgen.', 'M2.3; Folgezitation [[71]]', 0, 1, 'Lang wurde bereits in M2.0 erstmals vollständig bibliografisch eingeführt.', 29),
(20, 19, 50, '', 'Untervektorräume, Unterraumkriterium und elementare Unterraumoperationen.', 'Lang, Algebra, Kapitel III zu Modulen und Vektorräumen.', 0, 1, 'Folgezitation [[71]]; Erstnennung bereits in M2.0.', 31),
(21, 20, 50, '', 'Linearkombinationen, Spannraum, Minimalität, Erzeugendensysteme und Redundanz.', 'Lang, Algebra, Kapitel III zu Modulen und Vektorräumen.', 0, 1, 'Folgezitation [[71]]; Erstnennung bereits in M2.0.', 32),
(22, 20, 51, '', 'Randfall des Spannraums der leeren Menge.', 'Strang, Introduction to Linear Algebra, Kapitel 3 Vector Spaces and Subspaces.', 0, 1, 'Folgezitation [[72]]; Erstnennung bereits in M2.0.', 32);

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
(55, 'Lang', 'Serge', 'Lang, Serge', NULL, NULL, NULL, 'Autor der kanonischen Quelle [[71]] für M2.'),
(56, 'Strang', 'Gilbert', 'Strang, Gilbert', NULL, NULL, NULL, 'Autor der kanonischen Quelle [[72]] für M2.');

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
(12, 'RKB-NEU-K3.1.7-ABSCHLUSS-V1', '2026-07-26 19:31:39', 'section', '3.1.7', '3.1.7-Abschluss-v1', 'Vollständiger Abschluss des Abschnitts 3.1.7 „Forschungsstand, Forschungslücke und wissenschaftliche Zielsetzung“. Zugleich Abschluss des Kapitels 3.1. Keine neuen Literaturstellen und keine nummerierten Gleichungen.', 'Olaf Thiele / ChatGPT', 11),
(13, 'RKB32-RESET-M1.0-2026-09-07', '2026-09-07 12:00:00', 'section', 'M1.0', 'M1.0-reset-v1', 'Initialer kanonischer Aufbau der mathematischen Anlagen M1 bis M6 und Aufnahme von M1.0 als erster Anlagenabschnitt. Die Anlagen werden vor dem spaeteren Haupttext erarbeitet.', 'Olaf Thiele / ChatGPT', 12),
(14, 'RKB32-RESET-M1.1-2026-09-07', '2026-09-07 12:30:00', 'section', 'M1.1', 'M1.1-reset-v1', 'Neuaufbau von M1.1 Mengen, Elemente und Mengengleichheit auf der Reset-Basis M1.0. Registrierung der Gleichungen M1.1 bis M1.10 und des Literaturbezugs Halmos [[6]].', 'Olaf Thiele / ChatGPT', 13),
(15, 'RKB32-RESET-M1.2-2026-09-07', '2026-09-07 12:28:14', 'section', 'M1.2', 'M1.2-reset-v1', 'Neuaufbau von M1.2 Teilmengen, echte Teilmengen und Potenzmengen auf der Reset-Basis M1.0/M1.1. Registrierung der Gleichungen M1.11 bis M1.23 und Fortführung des Literaturbezugs Halmos [[6]].', 'Olaf Thiele / ChatGPT', 14),
(16, 'RKB32-RESET-M1.3-2026-09-07', '2026-09-07 12:46:11', 'section', 'M1.3', 'M1.3-reset-v1', 'Neuaufbau von M1.3 Mengenoperationen auf der Reset-Basis M1.0 bis M1.2. Registrierung der Gleichungen M1.24 bis M1.49 und Fortführung des Literaturbezugs Halmos [[6]].', 'Olaf Thiele / ChatGPT', 15),
(17, 'RKB32-RESET-M1.4-2026-09-07', '2026-09-07 12:55:02', 'section', 'M1.4', 'M1.4-reset-v1', 'Neuaufbau von M1.4 Geordnete Paare, Tupel und kartesische Produkte auf der Reset-Basis M1.0 bis M1.3. Registrierung der Gleichungen M1.50 bis M1.70 und Fortführung des Literaturbezugs Halmos [[6]].', 'Olaf Thiele / ChatGPT', 16),
(18, 'RKB32-RESET-M1.5-2026-09-07', '2026-09-07 13:06:16', 'section', 'M1.5', 'M1.5-reset-v1', 'Neuaufbau von M1.5 Relationen und ihre grundlegenden Eigenschaften auf der Reset-Basis M1.0 bis M1.4. Registrierung der Gleichungen M1.71 bis M1.96 und Fortführung des Literaturbezugs Halmos [[6]].', 'Olaf Thiele / ChatGPT', 17),
(19, 'RKB32-RESET-M1.6-2026-09-07', '2026-09-07 13:15:14', 'section', 'M1.6', 'M1.6-reset-v1', 'Neuaufbau von M1.6 Funktionen als eindeutig bestimmte Relationen auf der Reset-Basis M1.0 bis M1.5. Registrierung der Gleichungen M1.97 bis M1.120 und Fortführung des Literaturbezugs Halmos [[6]].', 'Olaf Thiele / ChatGPT', 18),
(20, 'RKB32-RESET-M1.7-2026-09-07', '2026-09-07 13:24:02', 'section', 'M1.7', 'M1.7-reset-v1', 'Neuaufbau von M1.7 Injektivität, Surjektivität und Bijektivität auf der Reset-Basis M1.0 bis M1.6. Registrierung der Gleichungen M1.121 bis M1.139 und Fortführung des Literaturbezugs Halmos [[6]].', 'Olaf Thiele / ChatGPT', 19),
(21, 'RKB32-RESET-M1.8-2026-09-07', '2026-09-07 14:00:50', 'section', 'M1.8', 'M1.8-reset-v1', 'Neuaufbau von M1.8 Bilder und Urbilder von Mengen auf der Reset-Basis M1.0 bis M1.7. Registrierung der Gleichungen M1.140 bis M1.166 und Fortführung des Literaturbezugs Halmos [[6]].', 'Olaf Thiele / ChatGPT', 20),
(22, 'RKB32-RESET-M1.9-2026-09-07', '2026-09-07 14:08:05', 'section', 'M1.9', 'M1.9-reset-v1', 'Neuaufbau von M1.9 Identität, Komposition und inverse Verkettung von Funktionen auf der Reset-Basis M1.0 bis M1.8. Registrierung der Gleichungen M1.167 bis M1.188 und Fortführung des Literaturbezugs Halmos [[6]].', 'Olaf Thiele / ChatGPT', 21),
(23, 'RKB32-RESET-M1.10-2026-09-07', '2026-09-07 14:31:12', 'section', 'M1.10', 'M1.10-reset-v1', 'Neuaufbau von M1.10 Mehrstellige, parametrisierte und partielle Funktionen auf der Reset-Basis M1.0 bis M1.9. Registrierung der Gleichungen M1.189 bis M1.211 und Fortführung des Literaturbezugs Halmos [[6]].', 'Olaf Thiele / ChatGPT', 22),
(24, 'RKB32-RESET-M1.11-2026-09-07', '2026-09-07 14:48:24', 'section', 'M1.11', 'M1.11-reset-v1', 'Abschluss von M1 mit Ergebnisinventar, Aussagegrenzen und expliziten Übergaben an M2 sowie an den späteren Haupttext. Der Haupttext ist keine Quelle für M1.', 'Olaf Thiele / ChatGPT', 23),
(25, 'RKB32-RESET-M2.0-2026-09-08', '2026-09-08 08:36:03', 'section', 'M2.0', 'M2.0-reset-v1', 'Beginn der Anlage M2 auf dem abgeschlossenen M1-Ergebnisbestand. M2.0 bestimmt Eingangsstelle, algebraische Erweiterung, Literaturbasis, innere Abhängigkeitsstruktur sowie die Übergaben an M3 und den späteren Haupttext. Der Haupttext ist keine Quelle für M2.', 'Olaf Thiele / ChatGPT', 24),
(26, 'RKB32-RESET-M2.1-2026-09-08', '2026-09-08 08:41:25', 'section', 'M2.1', 'M2.1-reset-v1', 'Neuaufbau von M2.1 Körper und Skalare auf der Reset-Basis M2.0. Registrierung der Körperoperationen und -axiome, der daraus abgeleiteten Rechenregeln, der skalaren Nullbeziehungen, der reellen und komplexen Skalarkörper sowie der Weitergabe an M2.2.', 'Olaf Thiele / ChatGPT', 25),
(28, 'RKB32-RESET-M2.2-2026-09-08', '2026-09-08 09:02:10', 'section', 'M2.2', 'M2.2-reset-v1', 'Neuaufbau von M2.2 Vektorraum und Vektorraumaxiome auf der korrigierten Reset-Basis M2.1; vollständiger Axiombestand, Aussagegrenzen und Weitergabe an M2.3.', 'Olaf Thiele / ChatGPT', 26),
(29, 'RKB32-RESET-M2.3-2026-09-08', '2026-09-08 09:07:51', 'section', 'M2.3', 'M2.3-reset-v1', 'Neuaufbau von M2.3 mit Herleitung der Nullvektor-, Inversen- und Kürzungsbeziehungen aus den Vektorraumaxiomen sowie Übergabe an M2.4.', 'Olaf Thiele / ChatGPT', 28),
(31, 'RKB32-RESET-M2.4-2026-09-08', '2026-09-08 09:17:10', 'section', 'M2.4', 'M2.4-reset-v1', 'Neuaufbau von M2.4 mit Untervektorraumdefinition, Unterraumkriterien, Schnitt- und Vereinigungsstruktur sowie Übergabe an M2.5.', 'Olaf Thiele / ChatGPT', 29),
(32, 'RKB32-RESET-M2.5-2026-09-08', '2026-09-08 09:27:57', 'section', 'M2.5', 'M2.5-reset-v1', 'Neuaufbau von M2.5 mit Linearkombinationen, Spannraum, Minimalität, Erzeugendensystemen und Redundanz sowie Übergabe an M2.6.', 'Olaf Thiele / ChatGPT', 31);

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
(40, 12, 'K3_1_7_LAST_CITATION', 'passed', '70', '70', 'Die letzte vergebene Literaturstelle muss nach Abschnitt 3.1.7 weiterhin [70] sein.', '2026-07-26 17:31:40'),
(41, 13, 'RKB32-M10-MODULES', 'passed', '6', '6', 'Die sechs mathematischen Anlagenmodule M1 bis M6 müssen registriert sein.', '2026-09-07 10:12:20'),
(42, 13, 'RKB32-M10-SECTION', 'passed', '1', '1', 'M1.0 muss genau einmal als Anlagenabschnitt vorhanden sein.', '2026-09-07 10:12:20'),
(43, 13, 'RKB32-M10-BODY', 'passed', '404c1b80240e28c42a8b754c02d149d75d5473df533b53801252fbadb57b5057', '404c1b80240e28c42a8b754c02d149d75d5473df533b53801252fbadb57b5057', 'Der gespeicherte M1.0-Text muss byteidentisch zum freigegebenen Anlagenabschnitt sein.', '2026-09-07 10:12:20'),
(44, 13, 'RKB32-M10-SOURCES', 'passed', '2', '2', 'Die kanonischen Literaturquellen Halmos [[6]] und Mac Lane [[60]] müssen vorhanden sein.', '2026-09-07 10:12:20'),
(45, 13, 'RKB32-M10-FIRST-CITATIONS', 'passed', '2', '2', 'Halmos [[6]] und Mac Lane [[60]] müssen in M1.0 als geprüfte Erstnennungen der Anlage M1 registriert sein.', '2026-09-07 10:12:20'),
(46, 13, 'RKB32-M10-CITATION-FORMAT', 'passed', '1', '1', 'Die Erstnennungen in M1.0 müssen exakt {[[vollständige DB-Literaturangabe]]}[[Literaturnummer]] entsprechen.', '2026-09-07 10:12:20'),
(47, 13, 'RKB32-M10-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.0 darf keine textlichen Rückverweise auf Vorgängerfassungen oder eine Auslagerungslogik enthalten.', '2026-09-07 10:12:20'),
(48, 13, 'RKB32-M10-NO-EQUATIONS', 'passed', '0', '0', 'M1.0 enthält bewusst noch keine nummerierte Gleichung. Die Word-LaTeX-Regel greift ab dem ersten Gleichungsobjekt.', '2026-09-07 10:12:20'),
(49, 14, 'RKB32-M11-RESET-BASE', 'passed', 'M1.0 + M1', 'M1.0=1; M1=1', 'M1.1 setzt den erfolgreichen Reset-Aufbau von M1.0 und das Anlagenmodul M1 voraus.', '2026-09-07 10:18:52'),
(50, 14, 'RKB32-M11-SECTION', 'passed', '1', '1', 'M1.1 muss genau einmal als Anlagenabschnitt vorhanden sein.', '2026-09-07 10:18:52'),
(51, 14, 'RKB32-M11-BODY', 'passed', '4743b3e22ca470b3d4cb4ab408a664695133565116246eda951d347801e7ba36', '4743b3e22ca470b3d4cb4ab408a664695133565116246eda951d347801e7ba36', 'Der gespeicherte M1.1-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-07 10:18:52'),
(52, 14, 'RKB32-M11-EQUATION-COUNT', 'passed', '10', '10', 'M1.1 muss genau die zehn Gleichungsobjekte M1.1 bis M1.10 enthalten.', '2026-09-07 10:18:52'),
(53, 14, 'RKB32-M11-WORDLATEX-EXACT', 'passed', '10', '10', 'Für alle M1.1-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 10:18:52'),
(54, 14, 'RKB32-M11-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keiner Word-LaTeX-Zeile beziehungsweise keinem word_latex-Feld darf eine Gleichungsnummer als 	ag{...} gespeichert sein.', '2026-09-07 10:18:53'),
(55, 14, 'RKB32-M11-WORDLATEX-IN-BODY', 'passed', '10', '10', 'Alle zehn gespeicherten word_latex-Formeln müssen als exakte Word-LaTeX-Zeile im M1.1-Fließtext vorkommen.', '2026-09-07 10:18:53'),
(56, 14, 'RKB32-M11-HALMOS-CONTINUATION', 'passed', '>=1', '2.00000000000000000000000000000000000000', 'Nach der Erstnennung in M1.0 wird Halmos in M1.1 ausschließlich als [[6]] fortzitiert.', '2026-09-07 10:18:53'),
(57, 14, 'RKB32-M11-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.1 darf keine Rückverweise auf Vorgängerfassungen oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 10:18:53'),
(58, 15, 'RKB32-M12-RESET-BASE', 'passed', 'M1.0 + M1.1 + M1.10 + M1', 'M1.0=1; M1.1=2; M1.10=10; M1=1', 'M1.2 setzt den erfolgreichen Reset-Aufbau M1.0/M1.1 und die fortlaufende Gleichungsnummerierung bis M1.10 voraus.', '2026-09-07 10:28:14'),
(59, 15, 'RKB32-M12-SECTION', 'passed', '1', '1', 'M1.2 muss genau einmal als Anlagenabschnitt vorhanden sein.', '2026-09-07 10:28:14'),
(60, 15, 'RKB32-M12-BODY', 'passed', 'ce8c8b890357f16d6645484515353048ac67fa4c5f53522297867ad6035eb8ed', 'ce8c8b890357f16d6645484515353048ac67fa4c5f53522297867ad6035eb8ed', 'Der gespeicherte M1.2-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-07 10:28:14'),
(61, 15, 'RKB32-M12-EQUATION-COUNT', 'passed', '13', '13', 'M1.2 muss genau die dreizehn Gleichungsobjekte M1.11 bis M1.23 enthalten.', '2026-09-07 10:28:14'),
(62, 15, 'RKB32-M12-EQUATION-NUMBERS', 'passed', 'M1.11..M1.23', 'M1.11..M1.23; count=13', 'Die Gleichungsnummern von M1.2 müssen lückenlos M1.11 bis M1.23 belegen.', '2026-09-07 10:28:14'),
(63, 15, 'RKB32-M12-WORDLATEX-EXACT', 'passed', '13', '13', 'Für alle M1.2-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 10:28:14'),
(64, 15, 'RKB32-M12-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keinem word_latex-Feld darf eine Gleichungsnummer als \\tag{...} gespeichert sein.', '2026-09-07 10:28:14'),
(65, 15, 'RKB32-M12-WORDLATEX-IN-BODY', 'passed', '13', '13', 'Alle dreizehn gespeicherten word_latex-Formeln müssen als exakte Word-LaTeX-Zeile im M1.2-Fließtext vorkommen.', '2026-09-07 10:28:14'),
(66, 15, 'RKB32-M12-HALMOS-CONTINUATION', 'passed', '[[6]] only', 'short=4.00000000000000000000000000000000000000; first=0', 'Halmos wurde in M1.0 erstmals vollständig genannt; M1.2 darf deshalb nur die Folgezitation [[6]] verwenden.', '2026-09-07 10:28:14'),
(67, 15, 'RKB32-M12-ICH-FORM', 'passed', '>=4', '55.00000000000000000000000000000000000000', 'Der Anlagenabschnitt soll den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar beibehalten.', '2026-09-07 10:28:14'),
(68, 15, 'RKB32-M12-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.2 darf keine Rückverweise auf Vorgängerfassungen oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 10:28:14'),
(69, 15, 'RKB32-M12-EXAMPLE-ROLE', 'passed', 'M1.23=example', 'example_count=1; M1.23_ok=1', 'Nur M1.23 ist in M1.2 als konkretes Beispiel klassifiziert.', '2026-09-07 10:28:14'),
(70, 16, 'RKB32-M13-RESET-BASE', 'passed', 'M1.0 + M1.2 + M1.23 + M1', 'M1.0=1; M1.2=3; M1.23=23; M1=1', 'M1.3 setzt den erfolgreichen Reset-Aufbau bis M1.2 und die fortlaufende Gleichungsnummerierung bis M1.23 voraus.', '2026-09-07 10:46:11'),
(71, 16, 'RKB32-M13-SECTION', 'passed', '1', '1', 'Der Abschnitt M1.3 muss genau einmal in appendix_sections vorhanden sein.', '2026-09-07 10:46:11'),
(72, 16, 'RKB32-M13-BODY', 'passed', '58a50330b87f43a076f3e369e1b2f02735c97a0a0cbf00267bd82c0f389cfe9e', '58a50330b87f43a076f3e369e1b2f02735c97a0a0cbf00267bd82c0f389cfe9e', 'Der gespeicherte M1.3-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-07 10:46:11'),
(73, 16, 'RKB32-M13-EQUATION-COUNT', 'passed', '26', '26', 'M1.3 muss genau die sechsundzwanzig Gleichungsobjekte M1.24 bis M1.49 enthalten.', '2026-09-07 10:46:11'),
(74, 16, 'RKB32-M13-EQUATION-NUMBERS', 'passed', 'M1.24..M1.49', 'M1.24..M1.49; count=26', 'Die Gleichungsnummern von M1.3 müssen lückenlos M1.24 bis M1.49 belegen.', '2026-09-07 10:46:11'),
(75, 16, 'RKB32-M13-WORDLATEX-EXACT', 'passed', '26', '26', 'Für alle M1.3-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 10:46:11'),
(76, 16, 'RKB32-M13-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keinem word_latex-Feld darf eine Gleichungsnummer als \\tag{...} gespeichert sein.', '2026-09-07 10:46:11'),
(77, 16, 'RKB32-M13-WORDLATEX-IN-BODY', 'passed', '26', '26', 'Alle sechsundzwanzig gespeicherten word_latex-Formeln müssen als exakte Word-LaTeX-Zeile im M1.3-Fließtext vorkommen.', '2026-09-07 10:46:11'),
(78, 16, 'RKB32-M13-HALMOS-CONTINUATION', 'passed', '[[6]] only', 'short=3.00000000000000000000000000000000000000; first=0', 'Halmos wurde in M1.0 erstmals vollständig genannt; M1.3 darf deshalb nur die Folgezitation [[6]] verwenden.', '2026-09-07 10:46:11'),
(79, 16, 'RKB32-M13-ICH-FORM', 'passed', '>=6', '58.00000000000000000000000000000000000000', 'Der Anlagenabschnitt soll den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar beibehalten.', '2026-09-07 10:46:11'),
(80, 16, 'RKB32-M13-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.3 darf keine Rückverweise auf Vorgängerfassungen, frühere Haupttexte oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 10:46:11'),
(81, 16, 'RKB32-M13-EQUATION-ROLES', 'passed', 'canonical=4; derived=22; proof/example=0', 'canonical=4; derived=22; other=0', 'M1.24, M1.30, M1.38 und M1.41 sind die vier definitorischen Kernobjekte; alle übrigen Beziehungen sind abgeleitet.', '2026-09-07 10:46:11'),
(82, 17, 'RKB32-M14-RESET-BASE', 'passed', 'M1.0 + M1.3 + M1.49 + M1', 'M1.0=1; M1.3=4; M1.49=49; M1=1', 'M1.4 setzt den erfolgreichen Reset-Aufbau bis M1.3 und die fortlaufende Gleichungsnummerierung bis M1.49 voraus.', '2026-09-07 10:55:02'),
(83, 17, 'RKB32-M14-SECTION', 'passed', '1', '1', 'Der Abschnitt M1.4 muss genau einmal vorhanden sein.', '2026-09-07 10:55:02'),
(84, 17, 'RKB32-M14-BODY', 'passed', '7633ec9f4fc611df6bd7dd537b7ac0a7f4b9082585153c81edd98b25503e9343', '7633ec9f4fc611df6bd7dd537b7ac0a7f4b9082585153c81edd98b25503e9343', 'Der gespeicherte M1.4-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-07 10:55:02'),
(85, 17, 'RKB32-M14-EQUATION-COUNT', 'passed', '21', '21', 'M1.4 muss genau die einundzwanzig Gleichungsobjekte M1.50 bis M1.70 enthalten.', '2026-09-07 10:55:02'),
(86, 17, 'RKB32-M14-EQUATION-NUMBERS', 'passed', 'M1.50..M1.70', 'M1.50..M1.70; count=21', 'Die Gleichungsnummern von M1.4 müssen lückenlos M1.50 bis M1.70 belegen.', '2026-09-07 10:55:02'),
(87, 17, 'RKB32-M14-WORDLATEX-EXACT', 'passed', '21', '21', 'Für alle M1.4-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 10:55:02'),
(88, 17, 'RKB32-M14-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keinem word_latex-Feld darf eine Gleichungsnummer als \\tag{...} gespeichert sein.', '2026-09-07 10:55:02'),
(89, 17, 'RKB32-M14-WORDLATEX-IN-BODY', 'passed', '21', '21', 'Alle einundzwanzig gespeicherten word_latex-Formeln müssen als exakte Word-LaTeX-Zeile im M1.4-Fließtext vorkommen.', '2026-09-07 10:55:02'),
(90, 17, 'RKB32-M14-HALMOS-CONTINUATION', 'passed', '[[6]] only', 'short=4.00000000000000000000000000000000000000; first=0', 'Halmos wurde in M1.0 erstmals vollständig genannt; M1.4 darf deshalb nur die Folgezitation [[6]] verwenden.', '2026-09-07 10:55:02'),
(91, 17, 'RKB32-M14-ICH-FORM', 'passed', '>=6', '77.00000000000000000000000000000000000000', 'Der Anlagenabschnitt soll den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar beibehalten.', '2026-09-07 10:55:02'),
(92, 17, 'RKB32-M14-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.4 darf keine Rückverweise auf Vorgängerfassungen, frühere Haupttexte oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 10:55:02'),
(93, 17, 'RKB32-M14-EQUATION-ROLES', 'passed', 'canonical=6; derived=13; example=2; proof=0', 'canonical=6; derived=13; example=2; proof=0', 'M1.51, M1.52, M1.54, M1.64, M1.68 und M1.69 sind kanonische Strukturbeziehungen; M1.56 und M1.57 sind Beispiele; die übrigen Gleichungen sind abgeleitet.', '2026-09-07 10:55:02'),
(94, 17, 'RKB32-M14-FINAL-GATE', 'passed', '0 failed', '0', 'M1.4 ist nur freigegeben, wenn keine der Einzelvalidierungen fehlschlägt.', '2026-09-07 10:55:02'),
(95, 18, 'RKB32-M15-RESET-BASE', 'passed', 'M1.0 + M1.4 + M1.70 + M1', 'M1.0=1; M1.4=5; M1.70=70; M1=1', 'M1.5 setzt den erfolgreichen Reset-Aufbau bis M1.4 und die fortlaufende Gleichungsnummerierung bis M1.70 voraus.', '2026-09-07 11:06:16'),
(96, 18, 'RKB32-M15-SECTION', 'passed', '1', '1', 'Der Abschnitt M1.5 muss genau einmal vorhanden sein.', '2026-09-07 11:06:16'),
(97, 18, 'RKB32-M15-BODY', 'passed', '4684760a2895c9c10814d4925586adf18480a9b2fceb7659857f9da1a17cafcc', '4684760a2895c9c10814d4925586adf18480a9b2fceb7659857f9da1a17cafcc', 'Der gespeicherte M1.5-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-07 11:06:16'),
(98, 18, 'RKB32-M15-EQUATION-COUNT', 'passed', '26', '26', 'M1.5 muss genau die sechsundzwanzig Gleichungsobjekte M1.71 bis M1.96 enthalten.', '2026-09-07 11:06:16'),
(99, 18, 'RKB32-M15-EQUATION-NUMBERS', 'passed', 'M1.71..M1.96', 'M1.71..M1.96; count=26', 'Die Gleichungsnummern von M1.5 müssen lückenlos M1.71 bis M1.96 belegen.', '2026-09-07 11:06:16'),
(100, 18, 'RKB32-M15-WORDLATEX-EXACT', 'passed', '26', '26', 'Für alle M1.5-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 11:06:16'),
(101, 18, 'RKB32-M15-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keinem word_latex-Feld darf eine Gleichungsnummer als \\tag{...} gespeichert sein.', '2026-09-07 11:06:16'),
(102, 18, 'RKB32-M15-WORDLATEX-IN-BODY', 'passed', '26', '26', 'Alle sechsundzwanzig gespeicherten word_latex-Formeln müssen als exakte Word-LaTeX-Zeile im M1.5-Fließtext vorkommen.', '2026-09-07 11:06:16'),
(103, 18, 'RKB32-M15-HALMOS-CONTINUATION', 'passed', '[[6]] only', 'short=2.00000000000000000000000000000000000000; first=0', 'Halmos wurde in M1.0 erstmals vollständig genannt; M1.5 darf deshalb nur die Folgezitation [[6]] verwenden.', '2026-09-07 11:06:16'),
(104, 18, 'RKB32-M15-ICH-FORM', 'passed', '>=8', '103.00000000000000000000000000000000000000', 'Der Anlagenabschnitt soll den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar beibehalten.', '2026-09-07 11:06:16'),
(105, 18, 'RKB32-M15-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.5 darf keine Rückverweise auf Vorgängerfassungen, frühere Haupttexte oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 11:06:16'),
(106, 18, 'RKB32-M15-EQUATION-ROLES', 'passed', 'canonical=17; derived=9; example=0; proof=0', 'canonical=17; derived=9; example=0; proof=0', 'M1.5 trennt definitorische Relationsstrukturen von unmittelbar abgeleiteten Beziehungen.', '2026-09-07 11:06:16'),
(107, 18, 'RKB32-M15-FINAL-GATE', 'passed', '0 failed', '0', 'M1.5 ist nur freigegeben, wenn keine der Einzelvalidierungen fehlschlägt.', '2026-09-07 11:06:16'),
(108, 19, 'RKB32-M16-RESET-BASE', 'passed', 'M1.0 + M1.5 + M1.96 + M1', 'M1.0=1; M1.5=6; M1.96=96; M1=1', 'M1.6 setzt den erfolgreichen Reset-Aufbau bis M1.5 und die fortlaufende Gleichungsnummerierung bis M1.96 voraus.', '2026-09-07 11:15:14'),
(109, 19, 'RKB32-M16-SECTION', 'passed', '1', '1', 'Der Abschnitt M1.6 muss genau einmal vorhanden sein.', '2026-09-07 11:15:14'),
(110, 19, 'RKB32-M16-BODY', 'passed', '00d09ac9a236de1e354e7e954414b1742e45e23abf19776d837b5ea032ac422c', '00d09ac9a236de1e354e7e954414b1742e45e23abf19776d837b5ea032ac422c', 'Der gespeicherte M1.6-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-07 11:15:14'),
(111, 19, 'RKB32-M16-EQUATION-COUNT', 'passed', '24', '24', 'M1.6 muss genau die vierundzwanzig Gleichungsobjekte M1.97 bis M1.120 enthalten.', '2026-09-07 11:15:14'),
(112, 19, 'RKB32-M16-EQUATION-NUMBERS', 'passed', 'M1.97..M1.120', 'M1.100..M1.99; count=24', 'Die Gleichungsnummern von M1.6 müssen lückenlos M1.97 bis M1.120 belegen.', '2026-09-07 11:15:14'),
(113, 19, 'RKB32-M16-WORDLATEX-EXACT', 'passed', '24', '24', 'Für alle M1.6-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 11:15:14'),
(114, 19, 'RKB32-M16-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keinem word_latex-Feld darf eine Gleichungsnummer als \\tag{...} gespeichert sein.', '2026-09-07 11:15:14'),
(115, 19, 'RKB32-M16-WORDLATEX-IN-BODY', 'passed', '24', '24', 'Alle vierundzwanzig gespeicherten word_latex-Formeln müssen als exakte Word-LaTeX-Zeile im M1.6-Fließtext vorkommen.', '2026-09-07 11:15:14'),
(116, 19, 'RKB32-M16-HALMOS-CONTINUATION', 'passed', '[[6]] only', 'short=3.00000000000000000000000000000000000000; first=0', 'Halmos wurde in M1.0 erstmals vollständig genannt; M1.6 darf deshalb nur die Folgezitation [[6]] verwenden.', '2026-09-07 11:15:14'),
(117, 19, 'RKB32-M16-ICH-FORM', 'passed', '>=8', '98.00000000000000000000000000000000000000', 'Der Anlagenabschnitt soll den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar beibehalten.', '2026-09-07 11:15:14'),
(118, 19, 'RKB32-M16-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.6 darf keine Rückverweise auf Vorgängerfassungen, frühere Haupttexte oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 11:15:14'),
(119, 19, 'RKB32-M16-EQUATION-ROLES', 'passed', 'canonical=14; derived=10; example=0; proof=0', 'canonical=14; derived=10; example=0; proof=0', 'M1.6 trennt kanonische Funktionsdefinitionen von unmittelbar abgeleiteten Beziehungen.', '2026-09-07 11:15:14'),
(120, 19, 'RKB32-M16-FINAL-GATE', 'passed', '0 failed', '0', 'M1.6 ist nur freigegeben, wenn keine der Einzelvalidierungen fehlschlägt.', '2026-09-07 11:15:14'),
(121, 20, 'RKB32-M17-RESET-BASE', 'passed', 'M1.0 + M1.6 + M1.120 + M1', 'M1.0=1; M1.6=7; M1.120=120; M1=1', 'M1.7 setzt den erfolgreichen Reset-Aufbau bis M1.6 und die fortlaufende Gleichungsnummerierung bis M1.120 voraus.', '2026-09-07 11:24:02'),
(122, 20, 'RKB32-M17-SECTION', 'passed', '1', '1', 'Der Abschnitt M1.7 muss genau einmal vorhanden sein.', '2026-09-07 11:24:02'),
(123, 20, 'RKB32-M17-BODY', 'passed', 'c627cd1f2d92373639b209eec23f43ef448da5a9588e7262fb448267a13ee848', 'c627cd1f2d92373639b209eec23f43ef448da5a9588e7262fb448267a13ee848', 'Der gespeicherte M1.7-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-07 11:24:02'),
(124, 20, 'RKB32-M17-EQUATION-COUNT', 'passed', '19', '19', 'M1.7 muss genau die neunzehn Gleichungsobjekte M1.121 bis M1.139 enthalten.', '2026-09-07 11:24:02'),
(125, 20, 'RKB32-M17-EQUATION-NUMBERS', 'passed', 'M1.121..M1.139', 'M1.121..M1.139; count=19', 'Die Gleichungsnummern von M1.7 müssen lückenlos M1.121 bis M1.139 belegen.', '2026-09-07 11:24:02'),
(126, 20, 'RKB32-M17-WORDLATEX-EXACT', 'passed', '19', '19', 'Für alle M1.7-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 11:24:02'),
(127, 20, 'RKB32-M17-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keinem word_latex-Feld darf eine Gleichungsnummer als \\tag{...} gespeichert sein.', '2026-09-07 11:24:02'),
(128, 20, 'RKB32-M17-WORDLATEX-IN-BODY', 'passed', '19', '19', 'Alle neunzehn gespeicherten word_latex-Formeln müssen als exakte Word-LaTeX-Zeile im M1.7-Fließtext vorkommen.', '2026-09-07 11:24:02'),
(129, 20, 'RKB32-M17-HALMOS-CONTINUATION', 'passed', '[[6]] only', 'short=2.00000000000000000000000000000000000000; first=0', 'Halmos wurde in M1.0 erstmals vollständig genannt; M1.7 darf deshalb nur die Folgezitation [[6]] verwenden.', '2026-09-07 11:24:02'),
(130, 20, 'RKB32-M17-ICH-FORM', 'passed', '>=8', '98.00000000000000000000000000000000000000', 'Der Anlagenabschnitt soll den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar beibehalten.', '2026-09-07 11:24:02'),
(131, 20, 'RKB32-M17-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.7 darf keine Rückverweise auf Vorgängerfassungen, frühere Haupttexte oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 11:24:02'),
(132, 20, 'RKB32-M17-EQUATION-ROLES', 'passed', 'canonical=8; derived=11; example=0; proof=0', 'canonical=8; derived=11; example=0; proof=0', 'M1.7 trennt definitorische Funktionsklassen und Umkehrstruktur von unmittelbar abgeleiteten Folgerungen.', '2026-09-07 11:24:02'),
(133, 20, 'RKB32-M17-FINAL-GATE', 'passed', '0 failed', '0', 'M1.7 ist nur freigegeben, wenn keine der Einzelvalidierungen fehlschlägt.', '2026-09-07 11:24:02'),
(134, 21, 'RKB32-M18-RESET-BASE', 'passed', 'M1.0 + M1.7 + M1.139 + M1', 'M1.0=1; M1.7=8; M1.139=139; M1=1', 'M1.8 setzt den erfolgreichen Reset-Aufbau bis M1.7 und die fortlaufende Gleichungsnummerierung bis M1.139 voraus.', '2026-09-07 12:00:50'),
(135, 21, 'RKB32-M18-SECTION', 'passed', '1', '1', 'Der Abschnitt M1.8 muss genau einmal vorhanden sein.', '2026-09-07 12:00:50'),
(136, 21, 'RKB32-M18-BODY', 'passed', 'be4c23e53ab4968b3b572a7ec9275426999fec696adadaf6e2a7e194b56ff0e0', 'be4c23e53ab4968b3b572a7ec9275426999fec696adadaf6e2a7e194b56ff0e0', 'Der gespeicherte M1.8-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-07 12:00:50'),
(137, 21, 'RKB32-M18-EQUATION-COUNT', 'passed', '27', '27', 'M1.8 muss genau die 27 Gleichungsobjekte M1.140 bis M1.166 enthalten.', '2026-09-07 12:00:50'),
(138, 21, 'RKB32-M18-EQUATION-NUMBERS', 'passed', 'M1.140..M1.166', 'M1.140..M1.166; count=27', 'Die Gleichungsnummern von M1.8 müssen lückenlos M1.140 bis M1.166 belegen.', '2026-09-07 12:00:50'),
(139, 21, 'RKB32-M18-WORDLATEX-EXACT', 'passed', '27', '27', 'Für alle M1.8-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 12:00:50'),
(140, 21, 'RKB32-M18-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keinem word_latex-Feld darf eine Gleichungsnummer als 	ag{...} gespeichert sein.', '2026-09-07 12:00:50'),
(141, 21, 'RKB32-M18-WORDLATEX-IN-BODY', 'passed', '27', '27', 'Alle 27 gespeicherten word_latex-Formeln müssen als exakte Word-LaTeX-Zeile im M1.8-Fließtext vorkommen.', '2026-09-07 12:00:50'),
(142, 21, 'RKB32-M18-HALMOS-CONTINUATION', 'passed', '[[6]] only', 'short=3.00000000000000000000000000000000000000; first=0', 'Halmos wurde in M1.0 erstmals vollständig genannt; M1.8 darf deshalb nur die Folgezitation [[6]] verwenden.', '2026-09-07 12:00:50'),
(143, 21, 'RKB32-M18-ICH-FORM', 'passed', '>=8', '80.00000000000000000000000000000000000000', 'Der Anlagenabschnitt soll den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar beibehalten.', '2026-09-07 12:00:50'),
(144, 21, 'RKB32-M18-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.8 darf keine Rückverweise auf Vorgängerfassungen, frühere Haupttexte oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 12:00:50'),
(145, 21, 'RKB32-M18-EQUATION-ROLES', 'passed', 'canonical=2; derived=25; example=0; proof=0', 'canonical=2; derived=25; example=0; proof=0', 'M1.8 führt Bild und Urbild als kanonische Konstruktionen; die übrigen Gleichungen sind daraus abgeleitete Mengenbeziehungen.', '2026-09-07 12:00:50'),
(146, 21, 'RKB32-M18-PREIMAGE-NOT-INVERSE', 'passed', 'present', 'present', 'M1.8 muss ausdrücklich festhalten, dass die Urbildbildung keine Umkehrfunktion voraussetzt.', '2026-09-07 12:00:50'),
(147, 21, 'RKB32-M18-FINAL-GATE', 'passed', '0 failed', '0', 'M1.8 ist nur freigegeben, wenn keine der Einzelvalidierungen fehlschlägt.', '2026-09-07 12:00:50'),
(148, 22, 'RKB32-M19-RESET-BASE', 'passed', 'M1.0 + M1.8 + M1.166 + M1', 'M1.0=1; M1.8=9; M1.166=166; M1=1', 'M1.9 setzt den erfolgreichen Reset-Aufbau bis M1.8 und die fortlaufende Gleichungsnummerierung bis M1.166 voraus.', '2026-09-07 12:08:05'),
(149, 22, 'RKB32-M19-SECTION', 'passed', '1', '1', 'Der Abschnitt M1.9 muss genau einmal vorhanden sein.', '2026-09-07 12:08:05'),
(150, 22, 'RKB32-M19-BODY', 'passed', '55be0a697b3b27e0c25fab135c7d8306d0f3702948b72d00a14799989f647d5a', '55be0a697b3b27e0c25fab135c7d8306d0f3702948b72d00a14799989f647d5a', 'Der gespeicherte M1.9-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-07 12:08:05'),
(151, 22, 'RKB32-M19-EQUATION-COUNT', 'passed', '22', '22', 'M1.9 muss genau die 22 Gleichungsobjekte M1.167 bis M1.188 enthalten.', '2026-09-07 12:08:05'),
(152, 22, 'RKB32-M19-EQUATION-NUMBERS', 'passed', 'M1.167..M1.188', 'M1.167..M1.188; count=22', 'Die Gleichungsnummern von M1.9 müssen lückenlos M1.167 bis M1.188 belegen.', '2026-09-07 12:08:05'),
(153, 22, 'RKB32-M19-WORDLATEX-EXACT', 'passed', '22', '22', 'Für alle M1.9-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 12:08:05'),
(154, 22, 'RKB32-M19-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keinem word_latex-Feld darf eine Gleichungsnummer als 	ag{...} gespeichert sein.', '2026-09-07 12:08:05'),
(155, 22, 'RKB32-M19-WORDLATEX-IN-BODY', 'passed', '22', '22', 'Alle 22 gespeicherten word_latex-Formeln müssen als exakte Word-LaTeX-Zeile im M1.9-Fließtext vorkommen.', '2026-09-07 12:08:05'),
(156, 22, 'RKB32-M19-HALMOS-CONTINUATION', 'passed', '[[6]] only', 'short=3.00000000000000000000000000000000000000; first=0', 'Halmos wurde in M1.0 erstmals vollständig genannt; M1.9 darf deshalb nur die Folgezitation [[6]] verwenden.', '2026-09-07 12:08:05'),
(157, 22, 'RKB32-M19-ICH-FORM', 'passed', '>=8', '82.00000000000000000000000000000000000000', 'Der Anlagenabschnitt soll den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar beibehalten.', '2026-09-07 12:08:05'),
(158, 22, 'RKB32-M19-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.9 darf keine Rückverweise auf Vorgängerfassungen, frühere Haupttexte oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 12:08:05'),
(159, 22, 'RKB32-M19-EQUATION-ROLES', 'passed', 'canonical=3; derived=16; proof=3; example=0', 'canonical=3; derived=16; proof=3; example=0', 'M1.9 führt Komposition und Assoziativität als kanonische Strukturen; Identitäts-, Eigenschafts- und Inversionsbeziehungen sind abgeleitet, M1.179 bis M1.181 bilden den expliziten Injektivitätsnachweis.', '2026-09-07 12:08:05'),
(160, 22, 'RKB32-M19-COMPOSITION-NONCOMMUTATIVE-CAUTION', 'passed', 'caution present', 'present', 'M1.9 muss ausdrücklich vermeiden, die fehlende allgemeine Kommutativität als universelle Ungleichheit zu formulieren.', '2026-09-07 12:08:05'),
(161, 22, 'RKB32-M19-FINAL-GATE', 'passed', '0 failed', '0', 'M1.9 ist nur freigegeben, wenn keine der Einzelvalidierungen fehlschlägt.', '2026-09-07 12:08:05'),
(162, 23, 'RKB32-M110-RESET-BASE', 'passed', 'M1.0 + M1.9 + M1.188 + M1 + [[6]]', 'M1.0=1; M1.9=10; M1.188=188; M1=1; Halmos=3', 'M1.10 setzt den erfolgreichen Reset-Aufbau bis M1.9, die fortlaufende Gleichungsnummerierung bis M1.188 und Halmos [[6]] voraus.', '2026-09-07 12:31:12'),
(163, 23, 'RKB32-M110-SECTION', 'passed', '1', '1', 'Der Abschnitt M1.10 muss genau einmal vorhanden sein.', '2026-09-07 12:31:12'),
(164, 23, 'RKB32-M110-BODY', 'passed', 'e064b52b902a2c040fe31d696ce1a6aba77f4f7ebe7453c08ef3999dd8147fb8', 'e064b52b902a2c040fe31d696ce1a6aba77f4f7ebe7453c08ef3999dd8147fb8', 'Der gespeicherte M1.10-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-07 12:31:12'),
(165, 23, 'RKB32-M110-EQUATION-COUNT', 'passed', '23', '23', 'M1.10 muss genau die 23 Gleichungsobjekte M1.189 bis M1.211 enthalten.', '2026-09-07 12:31:12'),
(166, 23, 'RKB32-M110-EQUATION-NUMBERS', 'passed', 'M1.189..M1.211', 'M1.189..M1.211; count=23', 'Die Gleichungsnummern von M1.10 müssen lückenlos M1.189 bis M1.211 belegen.', '2026-09-07 12:31:12'),
(167, 23, 'RKB32-M110-WORDLATEX-EXACT', 'passed', '23', '23', 'Für alle M1.10-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 12:31:12'),
(168, 23, 'RKB32-M110-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keinem word_latex-Feld darf eine Gleichungsnummer als 	ag{...} gespeichert sein.', '2026-09-07 12:31:12'),
(169, 23, 'RKB32-M110-WORDLATEX-IN-BODY', 'passed', '23', '23', 'Alle 23 gespeicherten word_latex-Formeln müssen als exakte Word-LaTeX-Zeile im M1.10-Fließtext vorkommen.', '2026-09-07 12:31:12'),
(170, 23, 'RKB32-M110-HALMOS-CONTINUATION', 'passed', '[[6]] only', 'short=2.00000000000000000000000000000000000000; first=0', 'Halmos wurde in M1.0 erstmals vollständig genannt; M1.10 darf deshalb nur die Folgezitation [[6]] verwenden.', '2026-09-07 12:31:12'),
(171, 23, 'RKB32-M110-ICH-FORM', 'passed', '>=8', '126.00000000000000000000000000000000000000', 'Der Anlagenabschnitt soll den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar beibehalten.', '2026-09-07 12:31:12'),
(172, 23, 'RKB32-M110-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.10 darf keine Rückverweise auf Vorgängerfassungen, frühere Haupttexte oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 12:31:12'),
(173, 23, 'RKB32-M110-EQUATION-ROLES', 'passed', 'canonical=8; derived=15; proof=0; example=0', 'canonical=8; derived=15; proof=0; example=0', 'M1.10 führt die mehrstellige Funktionssignatur, parametrisierte Familien und die partielle Funktionsbedingung als kanonische Strukturen; Fixierungs-, Darstellungs-, Einschränkungs- und Graphbeziehungen sind abgeleitet.', '2026-09-07 12:31:12'),
(174, 23, 'RKB32-M110-PARAMETER-INTERPRETATION-BOUNDARY', 'passed', 'boundary present', 'present', 'M1.10 muss ausdrücklich sichern, dass ein Parameter allein keine zeitliche oder physikalische Interpretation begründet.', '2026-09-07 12:31:12'),
(175, 23, 'RKB32-M110-PARTIAL-DOMAIN-BOUNDARY', 'passed', 'domain boundary present', 'present', 'M1.10 muss die partielle Funktion als vollständige Funktion auf D mit ausdrücklicher Nichtdefiniertheit außerhalb von D beschreiben.', '2026-09-07 12:31:12'),
(176, 23, 'RKB32-M110-FINAL-GATE', 'passed', '0 failed', '0', 'M1.10 ist nur freigegeben, wenn keine der Einzelvalidierungen fehlschlägt.', '2026-09-07 12:31:12'),
(177, 24, 'RKB32-M111-RESET-BASE', 'passed', 'M1.0 + M1.10 + M1.211 + M1', 'M1.0=1; M1.10=11; M1.211=211; M1=1', 'M1.11 setzt den vollständigen Reset-Aufbau bis M1.10 und die fortlaufende Gleichungsnummerierung bis M1.211 voraus.', '2026-09-07 12:48:24'),
(178, 24, 'RKB32-M111-SECTION', 'passed', '1', '1', 'Der Abschnitt M1.11 muss genau einmal vorhanden sein.', '2026-09-07 12:48:24'),
(179, 24, 'RKB32-M111-BODY', 'passed', 'd1ad9ff3bfab373fb063c3e7ef8c0e6ba49fa5a185a27dd7831e3670c42169fa', 'd1ad9ff3bfab373fb063c3e7ef8c0e6ba49fa5a185a27dd7831e3670c42169fa', 'Der gespeicherte M1.11-Text muss byteidentisch zum freigegebenen Abschlussabschnitt sein.', '2026-09-07 12:48:24'),
(180, 24, 'RKB32-M111-NO-EQUATIONS', 'passed', '0', '0', 'M1.11 ist ein Ergebnis- und Übergabeabschnitt und darf keine neue Gleichung einführen.', '2026-09-07 12:48:24'),
(181, 24, 'RKB32-M111-RESULT-INVENTORY', 'passed', '15', '15', 'M1.11 muss zwölf Ergebnis-/Abhängigkeitsobjekte, eine Aussagegrenze und zwei explizite Übergabeobjekte registrieren.', '2026-09-07 12:48:24'),
(182, 24, 'RKB32-M111-ICH-FORM', 'passed', '>=8', '160.00000000000000000000000000000000000000', 'Der Abschlussabschnitt muss den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar beibehalten.', '2026-09-07 12:48:24'),
(183, 24, 'RKB32-M111-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M1.11 darf keine Rückverweise auf Vorgängerfassungen, frühere Haupttexte als Quellen oder eine frühere Auslagerungslogik enthalten.', '2026-09-07 12:48:24'),
(184, 24, 'RKB32-M111-HANDOFFS', 'passed', 'M1→M2 + M1→later main text + main text not source', 'M2=1; main=1; not_source=1', 'M1.11 muss beide Übergaberichtungen explizit benennen und den späteren Haupttext ausdrücklich von der Quellenrolle für M1 ausschließen.', '2026-09-07 12:48:24'),
(185, 24, 'RKB32-M1-SECTION-COVERAGE', 'passed', '12', '12', 'M1 muss die Abschnitte M1.0 bis M1.11 vollständig enthalten.', '2026-09-07 12:48:24'),
(186, 24, 'RKB32-M1-EQUATION-COVERAGE', 'passed', 'M1.1..M1.211', 'count=211; distinct=211; min=M1.1; max=M1.99', 'Der abgeschlossene M1-Bestand muss die Gleichungsnummern M1.1 bis M1.211 lückenlos und eindeutig enthalten.', '2026-09-07 12:48:24'),
(187, 24, 'RKB32-M1-WORDLATEX-EXACT', 'passed', '211', '211', 'Für alle 211 M1-Gleichungen muss Word-LaTeX byteidentisch zum eigentlichen Formeltext sein.', '2026-09-07 12:48:24'),
(188, 24, 'RKB32-M1-WORDLATEX-NO-TAG', 'passed', '0', '0', 'In keinem M1-word_latex-Feld darf eine Gleichungsnummer als 	ag{...} gespeichert sein.', '2026-09-07 12:48:24'),
(189, 24, 'RKB32-M1-RESULT-ANCHORS', 'passed', '15', '15', 'Alle 15 Abschluss-, Grenz- und Übergabeanker von M1 müssen vorhanden sein.', '2026-09-07 12:48:24'),
(190, 24, 'RKB32-M111-FINAL-GATE', 'passed', '0 failed', '0', 'M1.11 und der M1-Abschluss sind nur freigegeben, wenn keine Einzelvalidierung fehlschlägt.', '2026-09-07 12:48:24'),
(191, 25, 'RKB32-M20-RESET-BASE', 'passed', 'M1 + M1.11 + M1.211 + M2', 'M1=1; M1.11=12; M1.211=211; M2=2', 'M2.0 darf erst nach vollständigem M1-Abschluss beginnen.', '2026-09-08 06:36:03'),
(192, 25, 'RKB32-M20-SOURCES', 'passed', '[[71]] Lang + [[72]] Strang', 'count=2; citations=71,72', 'Die beiden kanonischen M2-Literaturquellen müssen unter [[71]] und [[72]] registriert sein.', '2026-09-08 06:36:03'),
(193, 25, 'RKB32-M20-SECTION', 'passed', '1', '1', 'Der Abschnitt M2.0 muss genau einmal vorhanden sein.', '2026-09-08 06:36:03'),
(194, 25, 'RKB32-M20-BODY', 'passed', 'b257bfdd24f3d1aab2cf766cbeef8c634f8316840dc7b2b94f760781538166c8', 'b257bfdd24f3d1aab2cf766cbeef8c634f8316840dc7b2b94f760781538166c8', 'Der gespeicherte M2.0-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-08 06:36:03'),
(195, 25, 'RKB32-M20-EQUATION-COUNT', 'passed', '0', '0', 'M2.0 ist ein Struktur- und Übergabeabschnitt und enthält noch keine nummerierten Gleichungen.', '2026-09-08 06:36:03'),
(196, 25, 'RKB32-M20-FIRST-CITATIONS', 'passed', '2 checked first citations', 'count=2; first=2; checked=2', 'Lang [[71]] und Strang [[72]] müssen in M2.0 als geprüfte Erstnennungen registriert sein.', '2026-09-08 06:36:03'),
(197, 25, 'RKB32-M20-ICH-FORM', 'passed', '>=12', '96.00000000000000000000000000000000000000', 'M2.0 muss den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar tragen.', '2026-09-08 06:36:03'),
(198, 25, 'RKB32-M20-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M2.0 darf keine Rückverweise auf Vorgängerfassungen oder eine frühere Haupttext-Auslagerungslogik enthalten.', '2026-09-08 06:36:03'),
(199, 25, 'RKB32-M20-HANDOFFS', 'passed', 'M1→M2 + M2→M3/later main text + M2.0→M2.1', 'in=1; out=1; chain=1; next=1', 'M2.0 muss Eingang, spätere Rückgabe und Weitergabe an M2.1 ausdrücklich benennen.', '2026-09-08 06:36:03'),
(200, 25, 'RKB32-M20-STRUCTURE-ANCHORS', 'passed', '6', '6', 'M2.0 muss seine sechs Struktur-, Grenz- und Übergabeanker vollständig registrieren.', '2026-09-08 06:36:03'),
(201, 25, 'RKB32-M20-FINAL-GATE', 'passed', '0 failed', '0', 'M2.0 ist nur freigegeben, wenn keine Einzelvalidierung fehlschlägt.', '2026-09-08 06:36:03'),
(202, 26, 'RKB32-M21-PREREQUISITE', 'passed', 'M2.0 present/versioned', 'section=13; versions=1', 'M2.1 darf nur auf dem versionierten M2.0-Resetbestand aufbauen.', '2026-09-08 06:44:42'),
(203, 26, 'RKB32-M21-SECTION', 'passed', '1', '1', 'Der Abschnitt M2.1 muss genau einmal vorhanden sein.', '2026-09-08 06:44:42'),
(206, 26, 'RKB32-M21-BODY', 'passed', '6b38de46c5a0c21994e5fa6adfa3aa9458e5bc9d0dd9584d6befca45f567ad0f', '6b38de46c5a0c21994e5fa6adfa3aa9458e5bc9d0dd9584d6befca45f567ad0f', 'Der gespeicherte M2.1-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-08 06:44:42'),
(207, 26, 'RKB32-M21-EQUATION-COUNT', 'passed', '27', '27', 'M2.1 muss genau 27 Gleichungsobjekte M2.1 bis M2.27 enthalten.', '2026-09-08 06:44:42'),
(208, 26, 'RKB32-M21-EQUATION-RANGE', 'passed', 'M2.1..M2.27', 'count=27; first=1; last=1', 'Die Gleichungsnummerierung von M2.1 muss vollständig und lückenfrei im vorgesehenen Bereich liegen.', '2026-09-08 06:44:42'),
(209, 26, 'RKB32-M21-WORD-LATEX-BYTE-EXACT', 'passed', '27/27 byte exact', '27/27', 'formal_latex und word_latex müssen für jede Gleichung byteidentisch sein.', '2026-09-08 06:44:42'),
(210, 26, 'RKB32-M21-WORD-LATEX-NO-TAG', 'passed', '0', '0', 'word_latex darf niemals eine Gleichungsnummer als 	ag{...} enthalten.', '2026-09-08 06:44:42'),
(211, 26, 'RKB32-M21-WORD-LATEX-BODY-LINES', 'passed', '27', '27', 'Alle 27 Word-LaTeX-Zeilen müssen im gespeicherten Volltext exakt vorhanden sein.', '2026-09-08 06:44:42'),
(212, 26, 'RKB32-M21-SOURCE-USAGE', 'passed', '[[71]] + [[72]] follow citations', 'count=2; citations=71,72; first=0; checked=2', 'M2.1 darf Lang und Strang nur als bereits in M2.0 eingeführte Folgezitationen verwenden.', '2026-09-08 06:44:42'),
(213, 26, 'RKB32-M21-CITATION-TEXT', 'passed', '[[71]] x2; [[72]] x1', '[[71]]=2.000000000; [[72]]=1.000000000', 'Der Volltext muss ausschließlich die vorgesehenen Folgezitationen enthalten.', '2026-09-08 06:44:42'),
(214, 26, 'RKB32-M21-EQUATION-ROLES', 'passed', '13 canonical; 7 derived; 6 proof_step; 1 example', '13 canonical; 7 derived; 6 proof_step; 1 example', 'Die Rollenverteilung muss Körperaxiome, abgeleitete Beziehungen, Beweisschritte und die Feldbeispiele unterscheiden.', '2026-09-08 06:44:42'),
(215, 26, 'RKB32-M21-ICH-FORM', 'passed', '>=10', '82.00000000000000000000000000000000000000', 'M2.1 muss den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar tragen.', '2026-09-08 06:44:42'),
(216, 26, 'RKB32-M21-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M2.1 darf keine Rückverweise auf Vorgängerfassungen oder eine frühere Haupttext-Auslagerungslogik enthalten.', '2026-09-08 06:44:42'),
(217, 26, 'RKB32-M21-HANDOFF', 'passed', 'M2.1→M2.2', 'body=1; object=1', 'M2.1 muss die Übergabe des Skalarkörpers an M2.2 ausdrücklich im Text und als Repository-Anker registrieren.', '2026-09-08 06:44:42'),
(218, 26, 'RKB32-M21-FINAL-GATE', 'passed', '0 failed', '0', 'M2.1 ist nur freigegeben, wenn keine Einzelvalidierung fehlschlägt.', '2026-09-08 06:44:42'),
(219, 28, 'RKB32-M22-PREREQUISITE', 'passed', 'M2.1 present/versioned', 'section=14; versions=1', 'M2.2 darf nur auf dem versionierten M2.1-Resetbestand aufbauen.', '2026-09-08 07:02:10'),
(220, 28, 'RKB32-M22-SECTION', 'passed', '1', '1', 'Der Abschnitt M2.2 muss genau einmal vorhanden sein.', '2026-09-08 07:02:10'),
(221, 28, 'RKB32-M22-BODY', 'passed', 'cafa51b0a21a2d67f61a5974b0c45e530f5e88f27615352aaa16b15747f25993', 'cafa51b0a21a2d67f61a5974b0c45e530f5e88f27615352aaa16b15747f25993', 'Der gespeicherte M2.2-Text muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-08 07:02:10'),
(222, 28, 'RKB32-M22-EQUATION-COUNT', 'passed', '29', '29', 'M2.2 muss genau 29 Gleichungsobjekte M2.28 bis M2.56 enthalten.', '2026-09-08 07:02:10'),
(223, 28, 'RKB32-M22-EQUATION-RANGE', 'passed', 'M2.28..M2.56', 'M2.28..M2.56; distinct=29', 'Die Gleichungsnummerierung muss lückenlos M2.28 bis M2.56 umfassen.', '2026-09-08 07:02:10'),
(224, 28, 'RKB32-M22-WORD-LATEX-EQUAL', 'passed', '29', '29', 'formal_latex und word_latex müssen für alle M2.2-Gleichungen byteidentisch sein.', '2026-09-08 07:02:10'),
(225, 28, 'RKB32-M22-WORD-LATEX-NO-TAG', 'passed', '0', '0', 'word_latex darf keine Gleichungsnummer-Tags enthalten.', '2026-09-08 07:02:10'),
(226, 28, 'RKB32-M22-WORD-LATEX-BODY-LINES', 'passed', '29', '29', 'Alle 29 Word-LaTeX-Zeilen müssen im gespeicherten Volltext exakt vorhanden sein.', '2026-09-08 07:02:10'),
(227, 28, 'RKB32-M22-SOURCE-USAGE', 'passed', '[[71]] + [[72]] follow citations', 'count=2; citations=71,72; first=0; checked=2', 'M2.2 darf Lang und Strang nur als bereits in M2.0 eingeführte Folgezitationen verwenden.', '2026-09-08 07:02:10'),
(228, 28, 'RKB32-M22-CITATION-TEXT', 'passed', '[[71]] x2; [[72]] x1', '[[71]]=2.000000000; [[72]]=1.000000000', 'Der Volltext muss ausschließlich die vorgesehenen Folgezitationen enthalten.', '2026-09-08 07:02:10'),
(229, 28, 'RKB32-M22-EQUATION-ROLES', 'passed', '23 canonical; 4 derived; 0 proof_step; 2 example', '23 canonical; 4 derived; 0 proof_step; 2 example', 'Die Rollenverteilung muss Axiome und Operationssignaturen, vorbereitete Folgerungen und die reell/komplexen Beispiele unterscheiden.', '2026-09-08 07:02:10'),
(230, 28, 'RKB32-M22-ICH-FORM', 'passed', '>=8', '80.00000000000000000000000000000000000000', 'M2.2 muss den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar tragen.', '2026-09-08 07:02:10'),
(231, 28, 'RKB32-M22-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M2.2 darf keine Rückverweise auf Vorgängerfassungen oder eine frühere Haupttext-Auslagerungslogik enthalten.', '2026-09-08 07:02:10'),
(232, 28, 'RKB32-M22-HANDOFF', 'passed', 'M2.2→M2.3', 'body=1; object=1', 'M2.2 muss die Übergabe des vollständigen Vektorraumaxiombestands an M2.3 ausdrücklich registrieren.', '2026-09-08 07:02:10'),
(233, 28, 'RKB32-M22-DERIVED-NOT-AXIOMS', 'passed', 'M2.54-M2.56 all derived', 'count=3; derived=3', 'Die drei angekündigten Folgerungen M2.54-M2.56 dürfen in M2.2 nicht als Vektorraumaxiome registriert werden.', '2026-09-08 07:02:10'),
(234, 28, 'RKB32-M22-FINAL-GATE', 'passed', '0 failed', '0', 'M2.2 ist nur freigegeben, wenn keine Einzelvalidierung fehlschlägt.', '2026-09-08 07:02:10'),
(235, 29, 'RKB32-M23-PREREQUISITE', 'passed', 'M2.2 versioniert', 'versions=1', 'M2.3 darf nur auf einer versionierten M2.2-Basis aufgebaut werden.', '2026-09-08 07:12:08'),
(236, 29, 'RKB32-M23-ENUM-REPAIR', 'passed', 'vorhandene M2.1/M2.2-Altobjekte besitzen nur kanonische ENUM-Werte', 'handoffs=2; repaired=2; M2.53=original', 'Repariert freie/nichtkanonische ENUM-Werte aus frühen M2-Skripten ohne das Schema zu verändern.', '2026-09-08 07:12:08'),
(238, 29, 'RKB32-M23-BODY', 'passed', '118c1640ba6984ae6d20acc91cfa35edb9b65d6139b2d40a457569fc04cacab6', '118c1640ba6984ae6d20acc91cfa35edb9b65d6139b2d40a457569fc04cacab6', 'Der gespeicherte M2.3-Volltext muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-08 07:12:08'),
(239, 29, 'RKB32-M23-EQUATION-COUNT', 'passed', '42; M2.57-M2.98', 'count=42; min=57; max=98', 'M2.3 muss exakt die Gleichungsfolge M2.57 bis M2.98 enthalten.', '2026-09-08 07:12:08'),
(240, 29, 'RKB32-M23-WORD-LATEX-EXACT', 'passed', '42/42 byte exact', 'count=42; exact=42', 'formal_latex und word_latex müssen für alle M2.3-Gleichungen byteidentisch sein.', '2026-09-08 07:12:08'),
(241, 29, 'RKB32-M23-WORD-LATEX-NO-TAG', 'passed', '0', '0', 'word_latex darf keine Gleichungsnummerierung enthalten.', '2026-09-08 07:12:08'),
(242, 29, 'RKB32-M23-WORD-LATEX-BODY-LINES', 'passed', '42', '42', 'Alle 42 Word-LaTeX-Zeilen müssen im gespeicherten Volltext exakt vorhanden sein.', '2026-09-08 07:12:08'),
(243, 29, 'RKB32-M23-SOURCE-USAGE', 'passed', '[[71]] follow citation', 'count=1; citations=71; first=0; checked=1', 'M2.3 darf Lang [[71]] nur als bereits in M2.0 eingeführte Folgezitation verwenden.', '2026-09-08 07:12:08'),
(244, 29, 'RKB32-M23-CITATION-TEXT', 'passed', '[[71]] x2', '[[71]]=2.000000000', 'Der Volltext muss genau die vorgesehenen beiden Haltepunkte der Lang-Folgezitation enthalten.', '2026-09-08 07:12:08'),
(245, 29, 'RKB32-M23-EQUATION-ROLES', 'passed', '2 canonical; 18 derived; 22 proof_step; 0 example', '2 canonical; 18 derived; 22 proof_step; 0 example', 'M2.3 muss Definitionen, bewiesene Folgerungen und explizite Beweisschritte technisch unterscheiden.', '2026-09-08 07:12:08'),
(246, 29, 'RKB32-M23-ICH-FORM', 'passed', '>=8', '61.00000000000000000000000000000000000000', 'M2.3 muss den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar tragen.', '2026-09-08 07:12:08'),
(247, 29, 'RKB32-M23-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M2.3 darf keine Rückverweise auf Vorgängerfassungen oder eine frühere Haupttext-Auslagerungslogik enthalten.', '2026-09-08 07:12:08'),
(248, 29, 'RKB32-M23-HANDOFF', 'passed', 'M2.3→M2.4 statement / equation_role NULL / original', 'body=1; object=1', 'M2.3 muss die Übergabe des abgeleiteten Rechenbestands an M2.4 ausdrücklich registrieren.', '2026-09-08 07:12:08'),
(249, 29, 'RKB32-M23-KEY-DERIVED-RESULTS', 'passed', 'M2.70,M2.73,M2.77,M2.87,M2.91,M2.96,M2.98 derived', 'count=7; derived=7', 'Die zentralen Folgerungen aus den Vektorraumaxiomen müssen als abgeleitete Resultate und nicht als Axiome registriert sein.', '2026-09-08 07:12:08'),
(250, 29, 'RKB32-M23-FINAL-GATE', 'passed', '0 failed', '0', 'M2.3 ist nur freigegeben, wenn keine Einzelvalidierung fehlschlägt.', '2026-09-08 07:12:08'),
(251, 31, 'RKB32-M24-BODY', 'passed', '75b25e1cb8e9fc9e1a8406c53cfebfb0dc3778dcac43e0e1d9c59963dbccbbe0', '75b25e1cb8e9fc9e1a8406c53cfebfb0dc3778dcac43e0e1d9c59963dbccbbe0', 'Der gespeicherte M2.4-Volltext muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-08 07:17:10'),
(252, 31, 'RKB32-M24-EQUATION-COUNT', 'passed', '31; M2.99-M2.129', 'count=31; min=99; max=129', 'M2.4 muss exakt die Gleichungsfolge M2.99 bis M2.129 enthalten.', '2026-09-08 07:17:10'),
(253, 31, 'RKB32-M24-WORD-LATEX-EXACT', 'passed', '31/31 byte exact', 'count=31; exact=31', 'formal_latex und word_latex müssen für alle M2.4-Gleichungen byteidentisch sein.', '2026-09-08 07:17:10'),
(254, 31, 'RKB32-M24-WORD-LATEX-NO-TAG', 'passed', '0', '0', 'word_latex darf keine Gleichungsnummerierung enthalten.', '2026-09-08 07:17:10'),
(255, 31, 'RKB32-M24-WORD-LATEX-BODY', 'passed', '31', '31', 'Jede M2.4-Gleichung muss ihre exakte Word-LaTeX-Zeile im Volltext besitzen.', '2026-09-08 07:17:10'),
(256, 31, 'RKB32-M24-SOURCE-71', 'passed', '[[71]] follow citation; first=0; checked=1', 'count=1; citations=71; first=0; checked=1', 'M2.4 darf Lang [[71]] nur als Folgezitation verwenden.', '2026-09-08 07:17:10'),
(257, 31, 'RKB32-M24-CITATION-TEXT', 'passed', '[[71]] x2', '[[71]]=2.000000000', 'Der Volltext muss genau die beiden vorgesehenen Lang-Folgezitationen enthalten.', '2026-09-08 07:17:10'),
(258, 31, 'RKB32-M24-EQUATION-ROLES', 'passed', '10 canonical; 8 derived; 9 proof_step; 4 example', '10 canonical; 8 derived; 9 proof_step; 4 example', 'M2.4 muss Definitionen, Folgerungen, Beweisschritte und Beispiele technisch unterscheiden.', '2026-09-08 07:17:10'),
(259, 31, 'RKB32-M24-ICH-FORM', 'passed', '>=6', '93.00000000000000000000000000000000000000', 'M2.4 muss den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar tragen.', '2026-09-08 07:17:10');
INSERT INTO `repository_validation_results` (`validation_result_id`, `revision_id`, `validation_code`, `validation_status`, `expected_value`, `actual_value`, `validation_message`, `checked_at`) VALUES
(260, 31, 'RKB32-M24-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M2.4 darf keine Rückverweise auf Vorgängerfassungen oder frühere Haupttext-Auslagerungslogik enthalten.', '2026-09-08 07:17:10'),
(261, 31, 'RKB32-M24-HANDOFF', 'passed', 'M2.4→M2.5 statement / equation_role NULL / original', 'body=1; object=1', 'M2.4 muss die Übergabe an M2.5 ausdrücklich registrieren.', '2026-09-08 07:17:10'),
(262, 31, 'RKB32-M24-OBJECT-CONSTRAINTS', 'passed', '0 violations', 'eq-null-role=0; noneq-role=0; provenance=0', 'Alle M2.4-Objekte müssen die kanonischen equation_role- und provenance-Constraints erfüllen.', '2026-09-08 07:17:10'),
(263, 31, 'RKB32-M24-FINAL-GATE', 'passed', '0 failed', '0', 'M2.4 ist nur freigegeben, wenn keine Einzelvalidierung fehlschlägt.', '2026-09-08 07:17:10'),
(264, 32, 'RKB32-M25-BODY-HASH', 'passed', '1d21ad0a535e69b2d174057672785017ac697c5c7e3ca0fb3c2d444336aebd2b', '1d21ad0a535e69b2d174057672785017ac697c5c7e3ca0fb3c2d444336aebd2b', 'Der gespeicherte Volltext muss byteidentisch zum freigegebenen Abschnitt sein.', '2026-09-08 07:27:57'),
(265, 32, 'RKB32-M25-EQUATION-COUNT', 'passed', '38; M2.130-M2.167', 'count=38; min=130; max=167', 'M2.5 muss exakt die Gleichungsfolge M2.130 bis M2.167 enthalten.', '2026-09-08 07:27:57'),
(266, 32, 'RKB32-M25-WORD-LATEX-EXACT', 'passed', '38/38 byte exact', 'count=38; exact=38', 'formal_latex und word_latex müssen für alle M2.5-Gleichungen byteidentisch sein.', '2026-09-08 07:27:57'),
(267, 32, 'RKB32-M25-WORD-LATEX-NO-TAG', 'passed', '0', '0', 'word_latex darf keine Gleichungsnummerierung enthalten.', '2026-09-08 07:27:57'),
(268, 32, 'RKB32-M25-WORD-LATEX-BODY', 'passed', '38', '38', 'Jede M2.5-Gleichung muss ihre exakte Word-LaTeX-Zeile im Volltext besitzen.', '2026-09-08 07:27:57'),
(269, 32, 'RKB32-M25-SOURCE-71', 'passed', '[[71]] follow citation; first=0; checked=1', 'count=1; citations=71; first=0; checked=1', 'M2.5 darf Quelle [[71]] nur als Folgezitation verwenden.', '2026-09-08 07:27:57'),
(270, 32, 'RKB32-M25-CITATION-71-TEXT', 'passed', '[[71]] x1', '[[71]]=1.000000000', 'Der Volltext muss die vorgesehene Anzahl der Folgezitationen [[71]] enthalten.', '2026-09-08 07:27:57'),
(271, 32, 'RKB32-M25-SOURCE-72', 'passed', '[[72]] follow citation; first=0; checked=1', 'count=1; citations=72; first=0; checked=1', 'M2.5 darf Quelle [[72]] nur als Folgezitation verwenden.', '2026-09-08 07:27:57'),
(272, 32, 'RKB32-M25-CITATION-72-TEXT', 'passed', '[[72]] x1', '[[72]]=1.000000000', 'Der Volltext muss die vorgesehene Anzahl der Folgezitationen [[72]] enthalten.', '2026-09-08 07:27:57'),
(273, 32, 'RKB32-M25-EQUATION-ROLES', 'passed', '9 canonical; 21 derived; 7 proof_step; 1 example', '9 canonical; 21 derived; 7 proof_step; 1 example', 'M2.5 muss Definitionen, Folgerungen, Beweisschritte und die triviale Linearkombination technisch unterscheiden.', '2026-09-08 07:27:57'),
(274, 32, 'RKB32-M25-NO-LEGACY-REFERENCES', 'passed', '0', '0', 'M2.5 darf keine Rückverweise auf Vorgängerfassungen oder alte Haupttext-Auslagerungslogik enthalten.', '2026-09-08 07:27:57'),
(275, 32, 'RKB32-M25-ICH-FORM', 'passed', '>=6', '117.00000000000000000000000000000000000000', 'M2.5 muss den persönlichen wissenschaftlichen Schreibstil und die Ich-Form sichtbar tragen.', '2026-09-08 07:27:57'),
(276, 32, 'RKB32-M25-HANDOFF', 'passed', 'M2.5→M2.6 statement / equation_role NULL / original', 'body=1; object=1', 'M2.5 muss die Übergabe an M2.6 ausdrücklich registrieren.', '2026-09-08 07:27:57'),
(277, 32, 'RKB32-M25-OBJECT-CONSTRAINTS', 'passed', '0 violations', 'eq-null-role=0; noneq-role=0; provenance=0', 'Alle M2.5-Objekte müssen die kanonischen equation_role- und provenance-Constraints erfüllen.', '2026-09-08 07:27:57'),
(278, 32, 'RKB32-M25-FINAL-GATE', 'passed', '0 failed', '0', 'M2.5 ist nur freigegeben, wenn keine Einzelvalidierung fehlschlägt.', '2026-09-08 07:27:57');

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
(49, 70, 'luhmann_soziale_systeme_1984', 'book', 'Soziale Systeme', 'Grundriß einer allgemeinen Theorie', 1984, 1984, NULL, 'Suhrkamp', 'Frankfurt am Main', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'de', 1, 'primary', 8, 'verified', '3.1.6', 'Systembestand durch rekursiv anschließende Operationen statt dauerhafter Bestandteile.', 'Luhmann, Niklas: Soziale Systeme. Grundriß einer allgemeinen Theorie. Frankfurt am Main: Suhrkamp, 1984.', 'Luhmann, Soziale Systeme [70]', 'Quelle zur operativen Geschlossenheit und Anschlussfähigkeit.', 11, '2026-07-26 17:26:06', '2026-07-26 17:26:06'),
(50, 71, 'lang_algebra_rev3_2002', 'book', 'Algebra', NULL, 2002, 2002, NULL, 'Springer', 'New York', NULL, NULL, NULL, 'Revised Third Edition', NULL, '978-0-387-95385-4', NULL, 'en', 1, 'textbook', 9, 'verified', 'M2.0', 'Erstnennung in Anlage M2 zur algebraischen Grundlegung von Körpern, Modulen und Vektorräumen.', 'Lang, Serge: Algebra. Revised Third Edition. New York: Springer, 2002, insbesondere Kapitel III „Modules“, Abschnitte zu Modulen und Vektorräumen.', 'Lang, Algebra [[71]]', 'Kanonische Literaturquelle für die abstrakte algebraische Vektorraumstruktur in M2.', 25, '2026-09-08 06:36:03', '2026-09-08 06:36:03'),
(51, 72, 'strang_introduction_linear_algebra_5_2016', 'book', 'Introduction to Linear Algebra', NULL, 2016, 2016, NULL, 'Wellesley-Cambridge Press', 'Wellesley, MA', NULL, NULL, NULL, 'Fifth Edition', NULL, '978-0-9802327-7-6', NULL, 'en', 1, 'textbook', 9, 'verified', 'M2.0', 'Erstnennung in Anlage M2 zu Vektorräumen, Unterräumen, Spannräumen, linearer Unabhängigkeit, Basis und Dimension.', 'Strang, Gilbert: Introduction to Linear Algebra. Fifth Edition. Wellesley, MA: Wellesley-Cambridge Press, 2016, insbesondere Kapitel 3 „Vector Spaces and Subspaces“.', 'Strang, Introduction to Linear Algebra [[72]]', 'Kanonische Literaturquelle für den linearen Aufbau von Spannraum, Unabhängigkeit, Basis und Dimension in M2.', 25, '2026-09-08 06:36:03', '2026-09-08 06:36:03');

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
(50, 55, 1, 'author'),
(51, 56, 1, 'author');

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
-- Stellvertreter-Struktur des Views `v_appendix_inventory`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `v_appendix_inventory` (
`appendix_code` varchar(20)
,`appendix_title` varchar(500)
,`section_code` varchar(50)
,`section_title` varchar(500)
,`object_anchor` varchar(100)
,`object_type` enum('definition','statement','theorem','lemma','corollary','proposition','proof','equation','example','symbol','other')
,`display_number` varchar(50)
,`object_title` varchar(500)
,`importance_level` enum('core','supporting','derivation','example')
,`equation_role` enum('canonical','derived','proof_step','example')
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
-- Struktur des Views `v_appendix_inventory`
--
DROP TABLE IF EXISTS `v_appendix_inventory`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_appendix_inventory`  AS SELECT `am`.`appendix_code` AS `appendix_code`, `am`.`title` AS `appendix_title`, `asec`.`section_code` AS `section_code`, `asec`.`title` AS `section_title`, `ao`.`object_anchor` AS `object_anchor`, `ao`.`object_type` AS `object_type`, `ao`.`display_number` AS `display_number`, `ao`.`title` AS `object_title`, `ao`.`importance_level` AS `importance_level`, `ao`.`equation_role` AS `equation_role`, `ao`.`validation_status` AS `validation_status` FROM ((`appendix_modules` `am` left join `appendix_sections` `asec` on(`asec`.`appendix_module_id` = `am`.`appendix_module_id`)) left join `appendix_objects` `ao` on(`ao`.`appendix_section_id` = `asec`.`appendix_section_id`)) ;

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
-- Indizes für die Tabelle `appendix_modules`
--
ALTER TABLE `appendix_modules`
  ADD PRIMARY KEY (`appendix_module_id`),
  ADD UNIQUE KEY `uq_appendix_module_code` (`appendix_code`),
  ADD KEY `fk_a32_module_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `appendix_objects`
--
ALTER TABLE `appendix_objects`
  ADD PRIMARY KEY (`appendix_object_id`),
  ADD UNIQUE KEY `uq_appendix_object_anchor` (`object_anchor`),
  ADD UNIQUE KEY `uq_appendix_display_number` (`display_number`),
  ADD KEY `idx_appendix_object_section` (`appendix_section_id`,`object_type`),
  ADD KEY `idx_appendix_object_source` (`source_id`),
  ADD KEY `fk_a32_object_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `appendix_sections`
--
ALTER TABLE `appendix_sections`
  ADD PRIMARY KEY (`appendix_section_id`),
  ADD UNIQUE KEY `uq_appendix_section_code` (`section_code`),
  ADD KEY `idx_appendix_section_module` (`appendix_module_id`,`sort_order`),
  ADD KEY `fk_a32_section_parent` (`parent_appendix_section_id`),
  ADD KEY `fk_a32_section_revision` (`created_revision_id`);

--
-- Indizes für die Tabelle `appendix_section_versions`
--
ALTER TABLE `appendix_section_versions`
  ADD PRIMARY KEY (`appendix_section_version_id`),
  ADD UNIQUE KEY `uq_appendix_section_version` (`appendix_section_id`,`revision_id`,`version_kind`),
  ADD KEY `idx_appendix_versions_section` (`appendix_section_id`),
  ADD KEY `fk_a32_version_revision` (`revision_id`);

--
-- Indizes für die Tabelle `appendix_source_usage`
--
ALTER TABLE `appendix_source_usage`
  ADD PRIMARY KEY (`appendix_usage_id`),
  ADD UNIQUE KEY `uq_appendix_source_usage` (`appendix_section_id`,`source_id`,`usage_type`),
  ADD KEY `idx_appendix_usage_source` (`source_id`),
  ADD KEY `fk_a32_usage_revision` (`created_revision_id`);

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
-- AUTO_INCREMENT für Tabelle `appendix_modules`
--
ALTER TABLE `appendix_modules`
  MODIFY `appendix_module_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `appendix_objects`
--
ALTER TABLE `appendix_objects`
  MODIFY `appendix_object_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `appendix_sections`
--
ALTER TABLE `appendix_sections`
  MODIFY `appendix_section_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT für Tabelle `appendix_section_versions`
--
ALTER TABLE `appendix_section_versions`
  MODIFY `appendix_section_version_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT für Tabelle `appendix_source_usage`
--
ALTER TABLE `appendix_source_usage`
  MODIFY `appendix_usage_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT für Tabelle `assumptions`
--
ALTER TABLE `assumptions`
  MODIFY `assumption_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

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
  MODIFY `revision_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT für Tabelle `repository_validation_results`
--
ALTER TABLE `repository_validation_results`
  MODIFY `validation_result_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=279;

--
-- AUTO_INCREMENT für Tabelle `section_change_log`
--
ALTER TABLE `section_change_log`
  MODIFY `change_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT für Tabelle `sources`
--
ALTER TABLE `sources`
  MODIFY `source_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

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
-- Constraints der Tabelle `appendix_modules`
--
ALTER TABLE `appendix_modules`
  ADD CONSTRAINT `fk_a32_module_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `appendix_objects`
--
ALTER TABLE `appendix_objects`
  ADD CONSTRAINT `fk_a32_object_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_a32_object_section` FOREIGN KEY (`appendix_section_id`) REFERENCES `appendix_sections` (`appendix_section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_a32_object_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `appendix_sections`
--
ALTER TABLE `appendix_sections`
  ADD CONSTRAINT `fk_a32_section_module` FOREIGN KEY (`appendix_module_id`) REFERENCES `appendix_modules` (`appendix_module_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_a32_section_parent` FOREIGN KEY (`parent_appendix_section_id`) REFERENCES `appendix_sections` (`appendix_section_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_a32_section_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `appendix_section_versions`
--
ALTER TABLE `appendix_section_versions`
  ADD CONSTRAINT `fk_a32_version_revision` FOREIGN KEY (`revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_a32_version_section` FOREIGN KEY (`appendix_section_id`) REFERENCES `appendix_sections` (`appendix_section_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `appendix_source_usage`
--
ALTER TABLE `appendix_source_usage`
  ADD CONSTRAINT `fk_a32_usage_revision` FOREIGN KEY (`created_revision_id`) REFERENCES `repository_revisions` (`revision_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_a32_usage_section` FOREIGN KEY (`appendix_section_id`) REFERENCES `appendix_sections` (`appendix_section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_a32_usage_source` FOREIGN KEY (`source_id`) REFERENCES `sources` (`source_id`) ON UPDATE CASCADE;

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
