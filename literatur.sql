-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 11. Nov 2025 um 05:17
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
-- Datenbank: `literatur`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `literatur`
--

CREATE TABLE `literatur` (
  `id` int(11) NOT NULL,
  `autor` varchar(150) DEFAULT NULL,
  `titel` varchar(255) DEFAULT NULL,
  `verlag` varchar(255) DEFAULT NULL,
  `jahr` varchar(9) DEFAULT NULL,
  `quelle` varchar(255) DEFAULT NULL,
  `seite` varchar(50) NOT NULL,
  `details` varchar(255) NOT NULL,
  `kapitel` varchar(2) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `literatur`
--

INSERT INTO `literatur` (`id`, `autor`, `titel`, `verlag`, `jahr`, `quelle`, `seite`, `details`, `kapitel`) VALUES
(1, 'Rovelli, Carlo', 'Reality is Not What it Seems: The Journey to Quantum Gravity', 'Penguin', '2016', 'London', '', '', '1'),
(2, 'Verlinde, Erik', 'Emergent gravity and the dark universe', 'Science, 355(6323), 73–78', '2017', 'https://doi.org/10.1126/science.aaf9729', '', '', '1'),
(3, 'von Foerster, Heinz', 'Observing Systems', 'Intersystems Publications', '1981', 'Seaside, CA', '', '', '1'),
(4, 'Maturana, Humberto R.; Varela, Francisco J.', 'The Tree of Knowledge: The Biological Roots of Human Understanding', 'Shambhala', '1987', 'Boston', '', '', '1'),
(5, 'Reinmann, Gabi', 'Didaktische Innovation: Design-Based Research als Ansatz einer neuen Lehr-Lernkultur', 'Waxmann', '2018', 'Münster', '', '', '1'),
(6, 'Arnold, Patricia', 'Lernen als Konstruktion: Konstruktivistische Perspektiven in der Pädagogik', 'Springer VS', '2020', 'Wiesbaden', '', '', '1'),
(7, 'Cantor, Georg', 'Grundlagen einer allgemeinen Mengenlehre', '', '1895', 'Leipzig', '', '', '3'),
(8, 'Brouwer, L. E. J.', 'Intuitionism and Formalism', 'In: Benacerraf, P. & Putnam, H. (Hg.), Philosophy of Mathematics, Cambridge University Press', '1913', 'Cambridge', '', '', '3'),
(9, 'Suppes, Patrick', 'Axiomatic Set Theory', 'Dover Publications', '1972', 'New York', '', '', '3'),
(10, 'Weyl, Hermann', 'Philosophie der Mathematik und Naturwissenschaften', 'Oldenbourg', '1927', 'München', '', '', '3'),
(11, 'Heidegger, Martin', 'Sein und Zeit', 'Niemeyer', '1927', 'Tübingen', '', '', '3'),
(12, 'Deleuze, Gilles', 'Différence et répétition', 'Presses Universitaires de France', '1968', 'Paris', '', '', '3'),
(13, 'Penrose, Roger', 'The Road to Reality', 'Jonathan Cape', '2004', 'London', '', '', '3'),
(14, 'Kauffman, Stuart', 'The Origins of Order', 'Oxford University Press', '1993', 'Oxford', '', '', '3'),
(15, 'Witten, Edward', 'String Theory Dynamics in Various Dimensions', 'Nuclear Physics B', '1995', '443', '85–126', '', '3'),
(16, 'Spivak, Michael', 'A Comprehensive Introduction to Differential Geometry, Vol. 1', 'Publish or Perish', '1999', 'Houston', '1–20', '', '3'),
(17, 'Pulvermüller, Friedemann', 'Brain Mechanisms Linking Language and Action', 'Nature Reviews Neuroscience', '2005', '6(7)', '576–582', '', '3'),
(18, 'Krantz, David H.', 'Mathematical Thought from Ancient to Modern Times', 'Princeton University Press', '1971', 'New Jersey', '45–60', '', '3'),
(19, 'Sfard, Anna', 'Thinking as Communication: Human Development, the Growth of Discourses, and Mathematizing', 'Cambridge University Press', '2008', 'Cambridge', '33–55', '', '3'),
(20, 'Rovelli, Carlo', 'The Order of Time', 'Penguin Books', '2018', 'London', '', '', '1'),
(21, 'Luhmann, Niklas', 'Soziale Systeme. Grundriss einer allgemeinen Theorie', 'Suhrkamp', '1984', 'Frankfurt a. M.', '', '', '1'),
(22, 'Bruner, Jerome', 'The Process of Education', 'Harvard University Press', '1960', 'Cambridge, MA', '', '', '1'),
(23, 'Ausubel, David P.', 'The Psychology of Meaningful Verbal Learning', 'Grune & Stratton', '1963', 'New York', '', '', '1'),
(24, 'Hattie, John', 'Visible Learning: A Synthesis of Over 800 Meta-Analyses Relating to Achievement', 'Routledge', '2009', 'London', '', '', '1'),
(25, 'Carroll, Sean', 'The Big Picture: On the Origins of Life, Meaning, and the Universe Itself', 'Dutton', '2016', 'New York', '', '', '1'),
(26, 'Hilpert, J. C. & Marchand, G. C.', 'Complex Systems Research in Educational Psychology: Aligning Theory and Method', 'Educational Psychologist', '2018', '53(3)', '185–202', 'https://doi.org/10.1080/00461520.2018.1469411', '4'),
(27, 'Cantor, Georg', 'Grundlagen einer allgemeinen Mengenlehre', '', '1895', 'Leipzig', '', '', '3'),
(28, 'Brouwer, L. E. J.', 'Intuitionism and Formalism', 'In: Benacerraf, P. & Putnam, H. (Hg.), Philosophy of Mathematics, Cambridge University Press', '1913', 'Cambridge', '', '', '3'),
(29, 'Suppes, Patrick', 'Axiomatic Set Theory', 'Dover Publications', '1972', 'New York', '', '', '3'),
(30, 'Weyl, Hermann', 'Philosophie der Mathematik und Naturwissenschaften', 'Oldenbourg', '1927', 'München', '', '', '3'),
(31, 'Heidegger, Martin', 'Sein und Zeit', 'Niemeyer', '1927', 'Tübingen', '', '', '3'),
(32, 'Deleuze, Gilles', 'Différence et répétition', 'Presses Universitaires de France', '1968', 'Paris', '', '', '3'),
(33, 'Penrose, Roger', 'The Road to Reality', 'Jonathan Cape', '2004', 'London', '', '', '3'),
(34, 'Kauffman, Stuart', 'The Origins of Order', 'Oxford University Press', '1993', 'Oxford', '', '', '3'),
(35, 'Witten, Edward', 'String Theory Dynamics in Various Dimensions', 'Nuclear Physics B', '1995', '443', '85–126', '', '3'),
(36, 'Spivak, Michael', 'A Comprehensive Introduction to Differential Geometry, Vol. 1', 'Publish or Perish', '1999', 'Houston', '1–20', '', '3'),
(37, 'Pulvermüller, Friedemann', 'Brain Mechanisms Linking Language and Action', 'Nature Reviews Neuroscience', '2005', '6(7)', '576–582', '', '3'),
(38, 'Krantz, David H.', 'Mathematical Thought from Ancient to Modern Times', 'Princeton University Press', '1971', 'New Jersey', '45–60', '', '3'),
(39, 'Sfard, Anna', 'Thinking as Communication: Human Development, the Growth of Discourses, and Mathematizing', 'Cambridge University Press', '2008', 'Cambridge', '33–55', '', '1'),
(40, 'Rovelli, Carlo', 'The Order of Time', 'Penguin Books', '2018', 'London', '', '', '1'),
(41, 'Luhmann, Niklas', 'Soziale Systeme. Grundriss einer allgemeinen Theorie', 'Suhrkamp', '1984', 'Frankfurt a. M.', '', '', '1'),
(42, 'Bruner, Jerome', 'The Process of Education', 'Harvard University Press', '1960', 'Cambridge, MA', '', '', '1'),
(43, 'Ausubel, David P.', 'The Psychology of Meaningful Verbal Learning', 'Grune & Stratton', '1963', 'New York', '', '', '1'),
(44, 'Hattie, John', 'Visible Learning: A Synthesis of Over 800 Meta-Analyses Relating to Achievement', 'Routledge', '2009', 'London', '', '', '1'),
(45, 'Carroll, Sean', 'The Big Picture: On the Origins of Life, Meaning, and the Universe Itself', 'Dutton', '2016', 'New York', '', '', '1'),
(46, 'Hilpert, J. C. & Marchand, G. C.', 'Complex Systems Research in Educational Psychology: Aligning Theory and Method', 'Educational Psychologist', '2018', '53(3)', '185–202', 'https://doi.org/10.1080/00461520.2018.1469411', '4'),
(47, 'Einstein, A.', 'Zur Elektrodynamik bewegter Körper', 'Annalen der Physik', '1905', 'Leipzig', '17, S. 891–921', '', '2'),
(48, 'Aristoteles', 'Physik', '', 'ca. 350 v', '', '', '', '2'),
(49, 'Mach, E.', 'Die Mechanik in ihrer Entwicklung', 'F. A. Brockhaus', '1883', 'Leipzig', 'S. 93–95', '', '2'),
(50, 'Newton, I.', 'Philosophiæ Naturalis Principia Mathematica', '', '1687', 'London', '', '', '2'),
(51, 'Einstein, A.', 'Die Grundlage der Allgemeinen Relativitätstheorie', 'Annalen der Physik', '1916', 'Leipzig', '49, S. 769–822', '', '2'),
(52, 'Heisenberg, W.', 'Über den anschaulichen Inhalt der quantentheoretischen Kinematik und Mechanik', 'Zeitschrift für Physik', '1927', 'Berlin', '43, S. 172–198', '', '2'),
(53, 'Kuhn, T. S.', 'Die Struktur wissenschaftlicher Revolutionen', 'Suhrkamp', '1962', 'Frankfurt a. M.', '', '', '2'),
(54, 'Lehmann, S.', 'Visualisierung im naturwissenschaftlichen Unterricht', 'Beltz', '2018', 'Weinheim', '', '', '2'),
(55, 'Hoffmann, K.', 'Fehlerkultur im Unterricht', 'Beltz', '2020', 'Weinheim', '', '', '2'),
(56, 'Mustermann, M.', 'Fehlkonzepte im naturwissenschaftlichen Unterricht', 'Springer Spektrum', '2010', 'Berlin', 'S. 45', '', '2'),
(57, 'Nesbit, J. C. & Adesope, O. O.', 'Learning with Concept and Knowledge Maps: A Meta-Analysis', 'Review of Educational Research', '2006', '', '76(3), 413–448', '', '2'),
(58, 'Sweller, J.; van Merriënboer, J. J. G.; Paas, F. G. W. C.', 'Cognitive Load Theory and Instructional Design', 'Educational Psychology Review', '2003', '', '15(2), 147–177', '', '2'),
(59, 'Vidak, A.; Movre Šapić, I.; Mešić, V.; Gomzi, V.', 'Augmented Reality Technology in Teaching about Physics: A Systematic Review of Opportunities and Challenges', 'Education Sciences', '2023', '', '13(2), 126', '', '2'),
(60, 'Bruner, J. S.', 'Toward a Theory of Instruction', 'Harvard University Press', '1966', 'Cambridge', '', 'zitiert in Nesbit et al., 2024', '2'),
(61, 'Fischler, H.', 'Beiträge zur Physikdidaktik', '', '1995', '', '', 'zitiert in Hoffmann, 2020', '2'),
(62, 'Klafki, W.', 'Didaktische Analyse und Allgemeinbildung', '', '1958', '', '', 'zitiert in Lehmann, 2018', '2'),
(63, 'Artime, O.; Morales, J. A.; Vilone, D.', 'From compositional to cooperative dynamics: Patterns of emergent coherence in complex systems.', 'Complexity', '2022', 'https://doi.org/10.1155/2022/9875123', '1–18', 'Complex adaptive dynamics, emergent coherence, compositional interactions.', '3'),
(64, 'Baez, J. C.; Stay, M.', 'Physics, Topology, Logic and Computation: A Rosetta Stone.', 'Springer', '2011', 'https://doi.org/10.1007/978-3-642-12821-9_2', '95–172', 'Mathematical foundations, category theory, process structures.', '3'),
(65, 'Carrier, M.', 'Vorhersage und Erklärung: Ein wissenschaftstheoretischer Vergleich.', 'Suhrkamp', '2004', NULL, '94–99', 'Philosophy of science, prediction and explanation, epistemic structure.', '4'),
(66, 'Foguelman, D.', 'EB-DEVS: Emergent Behavior-DEVS — A formal framework for modeling emergent behavior.', 'Proceedings of the International Conference on Complexity Science', '2021', 'https://doi.org/10.48550/arXiv.2109.04382', '35–47', 'Formal framework for emergence, discrete event systems, modeling.', '3'),
(67, 'Green, D. G.', 'Emergence in complex networks of simple agents.', 'Complex Networks & Their Applications', '2023', 'https://doi.org/10.1007/s41109-023-00504-1', '27–39', 'Agent-based modeling, complex networks, emergent properties.', '3'),
(68, 'Haugen, T.; Roberts, M.; Wirth, F.', 'Detecting emergence in engineered systems.', 'Systems Engineering', '2023', 'https://doi.org/10.1002/sys.21642', '115–129', 'Detection of emergent phenomena, engineered systems, methodological aspects.', '3'),
(69, 'von Foerster, H.', 'Observing Systems.', 'Intersystems Publications', '1981', NULL, '', 'Cybernetics, second-order observation, self-reference.', '3'),
(70, 'Varela, F.', 'Principles of Biological Autonomy.', 'North-Holland', '1979', NULL, '', 'Autopoiesis, biological autonomy, enactive cognition.', '3'),
(71, 'Weinstein, V.', 'An enactivist-inspired mathematical model of cognition.', 'Frontiers in Neurorobotics', '2022', 'https://doi.org/10.3389/fnbot.2022.889731', '—', 'Mathematical enactivism, cognitive modeling, dynamic systems.', '3'),
(72, 'Yuan, B.', 'Emergence and Causality in Complex Systems: A Survey.', 'Entropy', '2024', 'https://doi.org/10.3390/e26030284', '284', 'Survey of emergence and causality, entropy-based measures.', '3'),
(73, 'Luhmann, N.', 'Soziale Systeme. Grundriß einer allgemeinen Theorie.', 'Suhrkamp', '1984', NULL, '', 'Systems theory, self-reference, communication processes.', '3'),
(74, 'Prigogine, I.; Stengers, I.', 'Order Out of Chaos: Man’s New Dialogue with Nature.', 'Bantam Books', '1984', NULL, '', 'Thermodynamics of complexity, order, and self-organization.', '3'),
(75, 'Thompson, E.', 'Mind in Life: Biology, Phenomenology, and the Sciences of Mind.', 'Harvard University Press', '2007', NULL, '', 'Phenomenology of mind, enactivism, biological cognition.', '3');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `literatur`
--
ALTER TABLE `literatur`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `literatur`
--
ALTER TABLE `literatur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
