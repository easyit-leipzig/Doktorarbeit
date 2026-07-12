-- ============================================================
-- FRZK-RKB: MIGRATION V3 -> V4
-- Für bestehende Datenbank ohne Datenverlust
-- MySQL 8.0+
-- ============================================================

USE frzk_rkb;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Hilfsprozedur: Spalte nur anlegen, wenn sie fehlt
DROP PROCEDURE IF EXISTS add_column_if_missing;
DELIMITER $$
CREATE PROCEDURE add_column_if_missing(
    IN p_table VARCHAR(64),
    IN p_column VARCHAR(64),
    IN p_definition TEXT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema=DATABASE()
          AND table_name=p_table
          AND column_name=p_column
    ) THEN
        SET @sql_stmt=CONCAT('ALTER TABLE `',p_table,'` ADD COLUMN `',p_column,'` ',p_definition);
        PREPARE stmt FROM @sql_stmt;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$
DELIMITER ;

-- Kritische Spalten
CALL add_column_if_missing('equations','created_revision_id','BIGINT UNSIGNED NULL');
CALL add_column_if_missing('equations','created_at','TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP');
CALL add_column_if_missing('equations','updated_at','TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP');
CALL add_column_if_missing('sources','created_revision_id','BIGINT UNSIGNED NULL');
CALL add_column_if_missing('source_usage','created_revision_id','BIGINT UNSIGNED NULL');
CALL add_column_if_missing('dissertation_sections','created_at','TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP');
CALL add_column_if_missing('dissertation_sections','updated_at','TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP');

-- Neue Tabellen
CREATE TABLE IF NOT EXISTS propositions (
    proposition_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proposition_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT,
    word_latex LONGTEXT,
    logical_derivation LONGTEXT NOT NULL,
    based_on_axioms VARCHAR(255),
    status ENUM('draft','review','accepted','revised','rejected') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_proposition_number (proposition_number)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS proposition_dependencies (
    proposition_dependency_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proposition_id BIGINT UNSIGNED NOT NULL,
    axiom_id BIGINT UNSIGNED NULL,
    assumption_id BIGINT UNSIGNED NULL,
    dependency_type ENUM('derived_from','uses','motivated_by','contrasts') NOT NULL DEFAULT 'derived_from',
    note TEXT,
    UNIQUE KEY uq_prop_dependency (proposition_id, axiom_id, assumption_id, dependency_type)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS citation_corrections (
    correction_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    old_citation_label VARCHAR(50) NOT NULL,
    corrected_citation_label VARCHAR(50) NOT NULL,
    section_code VARCHAR(50) NOT NULL,
    reason TEXT NOT NULL,
    revision_id BIGINT UNSIGNED NULL,
    corrected_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_citation_correction (old_citation_label, section_code)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS repository_counters (
    counter_key VARCHAR(100) PRIMARY KEY,
    counter_value VARCHAR(100) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS repository_validation_results (
    validation_result_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    revision_id BIGINT UNSIGNED NOT NULL,
    validation_code VARCHAR(100) NOT NULL,
    validation_status ENUM('passed','warning','failed') NOT NULL,
    expected_value VARCHAR(255),
    actual_value VARCHAR(255),
    validation_message TEXT NOT NULL,
    checked_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_validation_revision_code (revision_id, validation_code)
) ENGINE=InnoDB;

-- Fremdschlüssel nur ergänzen, wenn nicht vorhanden
SET @fk_exists := (
  SELECT COUNT(*)
  FROM information_schema.referential_constraints
  WHERE constraint_schema=DATABASE()
    AND constraint_name='fk_equations_revision'
);
SET @sql := IF(
  @fk_exists=0,
  'ALTER TABLE equations ADD CONSTRAINT fk_equations_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL ON UPDATE CASCADE',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- V4-Revision
INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary)
VALUES
('RKB-V4-MIGRATION',NOW(),'repository','frzk_rkb','4.0',
 'Migration der bestehenden FRZK-RKB auf die stabile V4-Schemafassung.')
ON DUPLICATE KEY UPDATE
 revision_date=VALUES(revision_date),
 summary=VALUES(summary);

-- Zähler aus aktuellem Bestand ableiten
INSERT INTO repository_counters(counter_key,counter_value)
SELECT 'next_citation_number',
       CAST(COALESCE(MAX(citation_number),0)+1 AS CHAR)
FROM sources
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

INSERT INTO repository_counters(counter_key,counter_value)
SELECT 'next_equation_number',
       CONCAT('3.',COALESCE(MAX(CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED)),0)+1)
FROM equations
WHERE equation_number LIKE '3.%'
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

INSERT INTO repository_counters(counter_key,counter_value)
VALUES ('last_repository_revision','RKB-V4-MIGRATION')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

DROP PROCEDURE IF EXISTS add_column_if_missing;

SET FOREIGN_KEY_CHECKS = 1;

-- Kontrollausgaben
DESCRIBE equations;
SELECT * FROM repository_counters ORDER BY counter_key;
