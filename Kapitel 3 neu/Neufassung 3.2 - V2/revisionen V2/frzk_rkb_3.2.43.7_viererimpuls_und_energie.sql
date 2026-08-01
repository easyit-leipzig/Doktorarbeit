USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

/* =====================================================================
   FRZK Repository
   Abschnitt 3.2.43.7
   Viererimpuls und relativistische Energie

   Definitionen : 3.2.668–3.2.676
   Sätze        : 3.2.154–3.2.157
   Gleichungen  : (3.3176)–(3.3235)
   Literatur    : [118], [119]

   Dieses Skript setzt den konsolidierten Stand bis 3.2.43.6 voraus.
   ===================================================================== */

INSERT INTO repository_revisions
(
 revision_code,revision_date,scope_type,scope_reference,
 version_label,summary,created_by
)
VALUES
(
 'RKB-NEU-K3.2.43.7-V1',
 NOW(),
 'subsection',
 '3.2.43.7',
 '3.2.43.7-v1',
 'Viererimpuls und relativistische Energie',
 'Olaf Thiele / ChatGPT'
);

-- ---------------------------------------------------------------------
-- Definitionen
-- ---------------------------------------------------------------------
-- 3.2.668 Weltlinie
-- 3.2.669 Vierergeschwindigkeit
-- 3.2.670 Ruhemasse
-- 3.2.671 Viererimpuls
-- 3.2.672 Relativistischer Dreierimpuls
-- 3.2.673 Relativistische Gesamtenergie
-- 3.2.674 Ruheenergie
-- 3.2.675 Kinetische Energie
-- 3.2.676 Masseloser Energie-Impuls-Zustand

-- ---------------------------------------------------------------------
-- Sätze
-- ---------------------------------------------------------------------
-- 3.2.154 Minkowski-Norm der Vierergeschwindigkeit
-- 3.2.155 Energie-Impuls-Beziehung
-- 3.2.156 Ruheenergie als Spezialfall
-- 3.2.157 Klassischer Grenzfall der kinetischen Energie

-- ---------------------------------------------------------------------
-- Gleichungen
-- ---------------------------------------------------------------------
-- (3.3176) bis (3.3235)
-- entsprechend dem Text von Abschnitt 3.2.43.7.

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.43.7'),
('current_section','3.2.43.8'),
('last_definition_number','3.2.676'),
('next_definition_number','3.2.677'),
('last_theorem_number','3.2.157'),
('next_theorem_number','3.2.158'),
('last_equation_number','3.3235'),
('next_equation_number','3.3236'),
('last_citation_number','119'),
('next_citation_number','120')
ON DUPLICATE KEY UPDATE
counter_value=VALUES(counter_value);

COMMIT;
