-- ============================================================
-- FRZK-RKB V4 – STABILE DATENBANKBASIS
-- MySQL 8.0+
-- Vollständiges Neuaufbau-Schema für die gesamte Dissertation
-- ============================================================

DROP DATABASE IF EXISTS frzk_rkb;
CREATE DATABASE frzk_rkb
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE frzk_rkb;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ------------------------------------------------------------
-- 1. Dokumente und Kapitel
-- ------------------------------------------------------------
CREATE TABLE documents (
    document_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    file_name VARCHAR(500),
    document_type ENUM('dissertation','chapter','article','book','dataset','appendix','other') NOT NULL DEFAULT 'other',
    version_label VARCHAR(100),
    file_path VARCHAR(1000),
    checksum_sha256 CHAR(64),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_documents_file_version (file_name, version_label)
) ENGINE=InnoDB;

CREATE TABLE dissertation_sections (
    section_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    parent_section_id BIGINT UNSIGNED NULL,
    section_code VARCHAR(50) NOT NULL,
    title VARCHAR(500) NOT NULL,
    chapter_no INT NOT NULL,
    section_order DECIMAL(10,4) NOT NULL,
    status ENUM('planned','draft','review','final') NOT NULL DEFAULT 'planned',
    is_original_contribution BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_section_code (section_code),
    CONSTRAINT fk_sections_parent
      FOREIGN KEY (parent_section_id) REFERENCES dissertation_sections(section_id)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 2. Revisionen und Protokollierung
-- ------------------------------------------------------------
CREATE TABLE repository_revisions (
    revision_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    revision_code VARCHAR(100) NOT NULL,
    revision_date DATETIME NOT NULL,
    scope_type ENUM(
      'repository','chapter','section','source','equation','definition',
      'statement','figure','table','symbol','acronym','axiom',
      'assumption','proof','proposition'
    ) NOT NULL,
    scope_reference VARCHAR(255),
    version_label VARCHAR(100) NOT NULL,
    summary TEXT NOT NULL,
    created_by VARCHAR(255) DEFAULT 'Olaf Thiele / ChatGPT',
    parent_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_revision_code (revision_code),
    CONSTRAINT fk_revision_parent
      FOREIGN KEY (parent_revision_id) REFERENCES repository_revisions(revision_id)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE section_change_log (
    change_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    revision_id BIGINT UNSIGNED NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    change_type ENUM(
      'created','rewritten','edited','renumbered','source_added','source_reused',
      'equation_added','equation_changed','definition_added','statement_added',
      'proof_added','assumption_added','axiom_added','proposition_added',
      'figure_added','table_added','symbol_added','acronym_added',
      'status_changed','other'
    ) NOT NULL,
    object_type VARCHAR(100),
    object_reference VARCHAR(255),
    change_summary TEXT NOT NULL,
    previous_value LONGTEXT,
    new_value LONGTEXT,
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_change_revision (revision_id),
    KEY idx_change_section (section_id),
    CONSTRAINT fk_change_revision
      FOREIGN KEY (revision_id) REFERENCES repository_revisions(revision_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_change_section
      FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE repository_counters (
    counter_key VARCHAR(100) PRIMARY KEY,
    counter_value VARCHAR(100) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE repository_validation_results (
    validation_result_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    revision_id BIGINT UNSIGNED NOT NULL,
    validation_code VARCHAR(100) NOT NULL,
    validation_status ENUM('passed','warning','failed') NOT NULL,
    expected_value VARCHAR(255),
    actual_value VARCHAR(255),
    validation_message TEXT NOT NULL,
    checked_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_validation_revision_code (revision_id, validation_code),
    CONSTRAINT fk_validation_revision
      FOREIGN KEY (revision_id) REFERENCES repository_revisions(revision_id)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 3. Literatur
-- ------------------------------------------------------------
CREATE TABLE sources (
    source_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    citation_number INT UNSIGNED NULL,
    source_key VARCHAR(150) NOT NULL,
    source_type ENUM(
      'journal_article','book','book_chapter','conference_paper','thesis',
      'report','standard','website','historical_work','edited_volume','other'
    ) NOT NULL,
    title VARCHAR(1000) NOT NULL,
    subtitle VARCHAR(1000),
    year_original SMALLINT,
    year_edition SMALLINT,
    journal VARCHAR(500),
    publisher VARCHAR(500),
    place VARCHAR(255),
    volume VARCHAR(100),
    issue VARCHAR(100),
    pages VARCHAR(100),
    edition VARCHAR(100),
    doi VARCHAR(255),
    isbn VARCHAR(100),
    url VARCHAR(1500),
    language_code CHAR(2) DEFAULT 'de',
    priority TINYINT UNSIGNED NOT NULL DEFAULT 3,
    evidence_type ENUM('primary','secondary','review','textbook','historical','reference') NOT NULL DEFAULT 'secondary',
    frzk_relevance TINYINT UNSIGNED NOT NULL DEFAULT 0,
    verification_status ENUM('imported','partially_verified','verified','needs_review') NOT NULL DEFAULT 'imported',
    first_citation_section_code VARCHAR(50),
    full_citation_text TEXT NOT NULL,
    short_citation_text VARCHAR(500),
    notes TEXT,
    created_revision_id BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_sources_citation_number (citation_number),
    UNIQUE KEY uq_sources_source_key (source_key),
    CONSTRAINT fk_sources_revision
      FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE authors (
    author_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    family_name VARCHAR(255) NOT NULL,
    given_names VARCHAR(255),
    normalized_name VARCHAR(500) NOT NULL,
    orcid VARCHAR(50),
    notes TEXT,
    UNIQUE KEY uq_authors_normalized_name (normalized_name)
) ENGINE=InnoDB;

CREATE TABLE source_authors (
    source_id BIGINT UNSIGNED NOT NULL,
    author_id BIGINT UNSIGNED NOT NULL,
    author_order SMALLINT UNSIGNED NOT NULL,
    role ENUM('author','editor','translator') NOT NULL DEFAULT 'author',
    PRIMARY KEY (source_id, author_id, role),
    UNIQUE KEY uq_source_author_order (source_id, role, author_order),
    CONSTRAINT fk_source_authors_source
      FOREIGN KEY (source_id) REFERENCES sources(source_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_source_authors_author
      FOREIGN KEY (author_id) REFERENCES authors(author_id)
      ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE annotations (
    annotation_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    source_id BIGINT UNSIGNED NOT NULL,
    contribution TEXT,
    significance_for_dissertation TEXT,
    citation_reason TEXT,
    adopted_claims TEXT,
    limitations TEXT,
    scientific_discussion TEXT,
    annotation_status ENUM('draft','reviewed','approved') NOT NULL DEFAULT 'draft',
    reviewed_at DATETIME,
    UNIQUE KEY uq_annotation_source (source_id),
    CONSTRAINT fk_annotations_source
      FOREIGN KEY (source_id) REFERENCES sources(source_id)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE pending_sources (
    pending_source_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proposed_source_key VARCHAR(150),
    title VARCHAR(1000) NOT NULL,
    authors_text VARCHAR(1000),
    year_text VARCHAR(50),
    publication_text VARCHAR(1000),
    doi_or_url VARCHAR(1500),
    proposed_section_code VARCHAR(50),
    discovery_context TEXT NOT NULL,
    proposed_claim TEXT,
    priority TINYINT UNSIGNED NOT NULL DEFAULT 3,
    review_status ENUM('open','in_review','accepted','rejected','merged') NOT NULL DEFAULT 'open',
    merged_source_id BIGINT UNSIGNED NULL,
    discovered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reviewed_at DATETIME,
    review_notes TEXT,
    CONSTRAINT fk_pending_merged_source
      FOREIGN KEY (merged_source_id) REFERENCES sources(source_id)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE topics (
    topic_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    parent_topic_id BIGINT UNSIGNED NULL,
    topic_code VARCHAR(100) NOT NULL,
    label VARCHAR(255) NOT NULL,
    description TEXT,
    UNIQUE KEY uq_topic_code (topic_code),
    CONSTRAINT fk_topics_parent
      FOREIGN KEY (parent_topic_id) REFERENCES topics(topic_id)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE source_topics (
    source_id BIGINT UNSIGNED NOT NULL,
    topic_id BIGINT UNSIGNED NOT NULL,
    relevance TINYINT UNSIGNED NOT NULL DEFAULT 3,
    PRIMARY KEY (source_id, topic_id),
    CONSTRAINT fk_source_topics_source
      FOREIGN KEY (source_id) REFERENCES sources(source_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_source_topics_topic
      FOREIGN KEY (topic_id) REFERENCES topics(topic_id)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE source_relations (
    relation_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    source_id_from BIGINT UNSIGNED NOT NULL,
    source_id_to BIGINT UNSIGNED NOT NULL,
    relation_type ENUM(
      'extends','criticizes','formalizes','applies','reviews',
      'historical_predecessor','alternative_to','supports',
      'contradicts','related'
    ) NOT NULL,
    relation_note TEXT,
    UNIQUE KEY uq_source_relation (source_id_from, source_id_to, relation_type),
    CONSTRAINT fk_source_relations_from
      FOREIGN KEY (source_id_from) REFERENCES sources(source_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_source_relations_to
      FOREIGN KEY (source_id_to) REFERENCES sources(source_id)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE source_usage (
    usage_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    source_id BIGINT UNSIGNED NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    usage_type ENUM(
      'first_citation','background','definition','theorem','method',
      'historical_context','state_of_research','critique','research_gap',
      'comparison','equation_source','figure_source','table_source','other'
    ) NOT NULL,
    claim_summary TEXT NOT NULL,
    exact_location VARCHAR(255),
    is_first_mention BOOLEAN NOT NULL DEFAULT FALSE,
    citation_checked BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_source_usage (source_id, section_id, usage_type, exact_location),
    CONSTRAINT fk_source_usage_source
      FOREIGN KEY (source_id) REFERENCES sources(source_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_source_usage_section
      FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_source_usage_revision
      FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE citation_corrections (
    correction_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    old_citation_label VARCHAR(50) NOT NULL,
    corrected_citation_label VARCHAR(50) NOT NULL,
    section_code VARCHAR(50) NOT NULL,
    reason TEXT NOT NULL,
    revision_id BIGINT UNSIGNED NULL,
    corrected_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_citation_correction (old_citation_label, section_code),
    CONSTRAINT fk_citation_correction_revision
      FOREIGN KEY (revision_id) REFERENCES repository_revisions(revision_id)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 4. Gleichungen und Symbole
-- ------------------------------------------------------------
CREATE TABLE equations (
    equation_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    equation_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500),
    equation_latex LONGTEXT NOT NULL,
    word_latex LONGTEXT NOT NULL,
    plain_description LONGTEXT NOT NULL,
    equation_type ENUM('definition','axiom','theorem','lemma','derived','schema','model','metric','other') NOT NULL DEFAULT 'other',
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'original',
    source_id BIGINT UNSIGNED NULL,
    derivation LONGTEXT,
    assumptions LONGTEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_equation_number (equation_number),
    CONSTRAINT fk_equations_section
      FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id)
      ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_equations_source
      FOREIGN KEY (source_id) REFERENCES sources(source_id)
      ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_equations_revision
      FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE equation_symbols (
    equation_symbol_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    equation_id BIGINT UNSIGNED NOT NULL,
    symbol_latex VARCHAR(255) NOT NULL,
    symbol_name VARCHAR(255) NOT NULL,
    definition_text TEXT NOT NULL,
    unit_text VARCHAR(255),
    domain_text VARCHAR(500),
    symbol_order SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    UNIQUE KEY uq_equation_symbol (equation_id, symbol_latex),
    CONSTRAINT fk_equation_symbols_equation
      FOREIGN KEY (equation_id) REFERENCES equations(equation_id)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE equation_dependencies (
    dependency_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    equation_id BIGINT UNSIGNED NOT NULL,
    depends_on_equation_id BIGINT UNSIGNED NOT NULL,
    dependency_type ENUM('derived_from','uses','special_case_of','generalizes','validates','contrasts') NOT NULL,
    dependency_note TEXT,
    UNIQUE KEY uq_equation_dependency (equation_id, depends_on_equation_id, dependency_type),
    CONSTRAINT fk_equation_dependencies_equation
      FOREIGN KEY (equation_id) REFERENCES equations(equation_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_equation_dependencies_parent
      FOREIGN KEY (depends_on_equation_id) REFERENCES equations(equation_id)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE symbols (
    symbol_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    symbol_latex VARCHAR(255) NOT NULL,
    symbol_word_latex VARCHAR(255) NOT NULL,
    symbol_name VARCHAR(255) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    scope_type ENUM('global','chapter','section','equation') NOT NULL DEFAULT 'global',
    first_section_id BIGINT UNSIGNED NULL,
    first_equation_id BIGINT UNSIGNED NULL,
    unit_text VARCHAR(255),
    domain_text VARCHAR(1000),
    codomain_text VARCHAR(1000),
    is_vector BOOLEAN NOT NULL DEFAULT FALSE,
    is_matrix BOOLEAN NOT NULL DEFAULT FALSE,
    is_operator BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_symbol_scope (symbol_latex, scope_type, first_section_id),
    CONSTRAINT fk_symbols_section
      FOREIGN KEY (first_section_id) REFERENCES dissertation_sections(section_id)
      ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_symbols_equation
      FOREIGN KEY (first_equation_id) REFERENCES equations(equation_id)
      ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_symbols_revision
      FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 5. Definitionen, Aussagen, Beweise und Propositionen
-- ------------------------------------------------------------
CREATE TABLE definitions (
    definition_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    definition_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    definition_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT,
    word_latex LONGTEXT,
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'original',
    source_id BIGINT UNSIGNED NULL,
    assumptions TEXT,
    notes TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_definition_number (definition_number),
    CONSTRAINT fk_definitions_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id),
    CONSTRAINT fk_definitions_source FOREIGN KEY (source_id) REFERENCES sources(source_id) ON DELETE SET NULL,
    CONSTRAINT fk_definitions_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE theorems (
    theorem_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    theorem_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT,
    word_latex LONGTEXT,
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'literature',
    source_id BIGINT UNSIGNED NULL,
    assumptions TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_theorem_number (theorem_number),
    CONSTRAINT fk_theorems_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id),
    CONSTRAINT fk_theorems_source FOREIGN KEY (source_id) REFERENCES sources(source_id) ON DELETE SET NULL,
    CONSTRAINT fk_theorems_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE lemmas (
    lemma_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    lemma_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT,
    word_latex LONGTEXT,
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'literature',
    source_id BIGINT UNSIGNED NULL,
    assumptions TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_lemma_number (lemma_number),
    CONSTRAINT fk_lemmas_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id),
    CONSTRAINT fk_lemmas_source FOREIGN KEY (source_id) REFERENCES sources(source_id) ON DELETE SET NULL,
    CONSTRAINT fk_lemmas_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE corollaries (
    corollary_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    corollary_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    statement_text LONGTEXT NOT NULL,
    statement_latex LONGTEXT,
    word_latex LONGTEXT,
    parent_theorem_id BIGINT UNSIGNED NULL,
    parent_lemma_id BIGINT UNSIGNED NULL,
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'literature',
    source_id BIGINT UNSIGNED NULL,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_corollary_number (corollary_number),
    CONSTRAINT fk_corollaries_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id),
    CONSTRAINT fk_corollaries_theorem FOREIGN KEY (parent_theorem_id) REFERENCES theorems(theorem_id) ON DELETE SET NULL,
    CONSTRAINT fk_corollaries_lemma FOREIGN KEY (parent_lemma_id) REFERENCES lemmas(lemma_id) ON DELETE SET NULL,
    CONSTRAINT fk_corollaries_source FOREIGN KEY (source_id) REFERENCES sources(source_id) ON DELETE SET NULL,
    CONSTRAINT fk_corollaries_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE proofs (
    proof_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proof_number VARCHAR(50),
    section_id BIGINT UNSIGNED NOT NULL,
    theorem_id BIGINT UNSIGNED NULL,
    lemma_id BIGINT UNSIGNED NULL,
    corollary_id BIGINT UNSIGNED NULL,
    title VARCHAR(500),
    proof_text LONGTEXT NOT NULL,
    proof_latex LONGTEXT,
    proof_method ENUM('direct','contradiction','induction','construction','equivalence','existence','uniqueness','computational','other') NOT NULL DEFAULT 'direct',
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'original',
    source_id BIGINT UNSIGNED NULL,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    CONSTRAINT fk_proofs_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id),
    CONSTRAINT fk_proofs_theorem FOREIGN KEY (theorem_id) REFERENCES theorems(theorem_id) ON DELETE CASCADE,
    CONSTRAINT fk_proofs_lemma FOREIGN KEY (lemma_id) REFERENCES lemmas(lemma_id) ON DELETE CASCADE,
    CONSTRAINT fk_proofs_corollary FOREIGN KEY (corollary_id) REFERENCES corollaries(corollary_id) ON DELETE CASCADE,
    CONSTRAINT fk_proofs_source FOREIGN KEY (source_id) REFERENCES sources(source_id) ON DELETE SET NULL,
    CONSTRAINT fk_proofs_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE propositions (
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
    UNIQUE KEY uq_proposition_number (proposition_number),
    CONSTRAINT fk_propositions_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id),
    CONSTRAINT fk_propositions_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 6. Annahmen und Axiome
-- ------------------------------------------------------------
CREATE TABLE assumptions (
    assumption_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    assumption_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    assumption_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT,
    word_latex LONGTEXT,
    derivation_from_research_gap LONGTEXT,
    status ENUM('proposed','accepted','rejected','superseded') NOT NULL DEFAULT 'proposed',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_assumption_number (assumption_number),
    CONSTRAINT fk_assumptions_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id),
    CONSTRAINT fk_assumptions_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE axioms (
    axiom_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    axiom_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    axiom_text LONGTEXT NOT NULL,
    formal_latex LONGTEXT,
    word_latex LONGTEXT,
    motivation LONGTEXT,
    independence_note LONGTEXT,
    consistency_note LONGTEXT,
    operationalization_note LONGTEXT,
    source_assumption_id BIGINT UNSIGNED NULL,
    status ENUM('draft','review','accepted','revised','rejected') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_axiom_number (axiom_number),
    CONSTRAINT fk_axioms_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id),
    CONSTRAINT fk_axioms_assumption FOREIGN KEY (source_assumption_id) REFERENCES assumptions(assumption_id) ON DELETE SET NULL,
    CONSTRAINT fk_axioms_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE axiom_dependencies (
    axiom_dependency_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    axiom_id BIGINT UNSIGNED NOT NULL,
    depends_on_axiom_id BIGINT UNSIGNED NOT NULL,
    dependency_type ENUM('depends_on','extends','specializes','contrasts','independent_of') NOT NULL,
    note TEXT,
    UNIQUE KEY uq_axiom_dependency (axiom_id, depends_on_axiom_id, dependency_type),
    CONSTRAINT fk_axiom_dependencies_axiom FOREIGN KEY (axiom_id) REFERENCES axioms(axiom_id) ON DELETE CASCADE,
    CONSTRAINT fk_axiom_dependencies_parent FOREIGN KEY (depends_on_axiom_id) REFERENCES axioms(axiom_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE proposition_dependencies (
    proposition_dependency_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proposition_id BIGINT UNSIGNED NOT NULL,
    axiom_id BIGINT UNSIGNED NULL,
    assumption_id BIGINT UNSIGNED NULL,
    dependency_type ENUM('derived_from','uses','motivated_by','contrasts') NOT NULL DEFAULT 'derived_from',
    note TEXT,
    UNIQUE KEY uq_prop_dependency (proposition_id, axiom_id, assumption_id, dependency_type),
    CONSTRAINT fk_prop_dep_proposition FOREIGN KEY (proposition_id) REFERENCES propositions(proposition_id) ON DELETE CASCADE,
    CONSTRAINT fk_prop_dep_axiom FOREIGN KEY (axiom_id) REFERENCES axioms(axiom_id) ON DELETE CASCADE,
    CONSTRAINT fk_prop_dep_assumption FOREIGN KEY (assumption_id) REFERENCES assumptions(assumption_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 7. Abbildungen, Tabellen, Abkürzungen
-- ------------------------------------------------------------
CREATE TABLE figures (
    figure_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    figure_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    caption LONGTEXT NOT NULL,
    file_name VARCHAR(500),
    file_path VARCHAR(1500),
    alt_text LONGTEXT,
    figure_type ENUM('diagram','plot','photograph','schema','flowchart','network','other') NOT NULL DEFAULT 'other',
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'original',
    source_id BIGINT UNSIGNED NULL,
    generation_method TEXT,
    data_reference TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_figure_number (figure_number),
    CONSTRAINT fk_figures_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id),
    CONSTRAINT fk_figures_source FOREIGN KEY (source_id) REFERENCES sources(source_id) ON DELETE SET NULL,
    CONSTRAINT fk_figures_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE dissertation_tables (
    table_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    table_number VARCHAR(50) NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(500) NOT NULL,
    caption LONGTEXT,
    table_schema_json JSON,
    table_data_json JSON,
    file_name VARCHAR(500),
    file_path VARCHAR(1500),
    provenance ENUM('original','adapted','literature') NOT NULL DEFAULT 'original',
    source_id BIGINT UNSIGNED NULL,
    generation_method TEXT,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_table_number (table_number),
    CONSTRAINT fk_tables_section FOREIGN KEY (section_id) REFERENCES dissertation_sections(section_id),
    CONSTRAINT fk_tables_source FOREIGN KEY (source_id) REFERENCES sources(source_id) ON DELETE SET NULL,
    CONSTRAINT fk_tables_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE acronyms (
    acronym_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    acronym VARCHAR(100) NOT NULL,
    full_form VARCHAR(1000) NOT NULL,
    explanation LONGTEXT,
    first_section_id BIGINT UNSIGNED NULL,
    language_code CHAR(2) NOT NULL DEFAULT 'de',
    category VARCHAR(255),
    is_project_specific BOOLEAN NOT NULL DEFAULT FALSE,
    validation_status ENUM('draft','checked','verified') NOT NULL DEFAULT 'draft',
    created_revision_id BIGINT UNSIGNED NULL,
    UNIQUE KEY uq_acronym (acronym),
    CONSTRAINT fk_acronyms_section FOREIGN KEY (first_section_id) REFERENCES dissertation_sections(section_id) ON DELETE SET NULL,
    CONSTRAINT fk_acronyms_revision FOREIGN KEY (created_revision_id) REFERENCES repository_revisions(revision_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE object_source_links (
    object_source_link_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    object_type ENUM('definition','theorem','lemma','corollary','proof','proposition','equation','figure','table','symbol','acronym','assumption','axiom') NOT NULL,
    object_id BIGINT UNSIGNED NOT NULL,
    source_id BIGINT UNSIGNED NOT NULL,
    usage_type ENUM('primary_source','supporting_source','adapted_from','contrasts','historical_context','verification') NOT NULL,
    note TEXT,
    UNIQUE KEY uq_object_source (object_type, object_id, source_id, usage_type),
    CONSTRAINT fk_object_source_source FOREIGN KEY (source_id) REFERENCES sources(source_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- 8. Views
-- ------------------------------------------------------------
CREATE VIEW v_chapter_bibliography AS
SELECT DISTINCT
  ds.chapter_no,
  s.citation_number,
  s.full_citation_text,
  s.priority,
  s.frzk_relevance,
  s.verification_status
FROM source_usage su
JOIN sources s ON s.source_id=su.source_id
JOIN dissertation_sections ds ON ds.section_id=su.section_id
WHERE s.citation_number IS NOT NULL;

CREATE VIEW v_equation_register AS
SELECT
  e.equation_number,
  ds.section_code,
  ds.title AS section_title,
  e.title,
  e.word_latex,
  e.plain_description,
  e.provenance,
  s.citation_number AS source_citation_number,
  e.validation_status,
  e.created_revision_id
FROM equations e
JOIN dissertation_sections ds ON ds.section_id=e.section_id
LEFT JOIN sources s ON s.source_id=e.source_id;

CREATE VIEW v_definition_register AS
SELECT
  d.definition_number,
  ds.section_code,
  d.title,
  d.definition_text,
  d.word_latex,
  d.provenance,
  s.citation_number,
  d.validation_status
FROM definitions d
JOIN dissertation_sections ds ON ds.section_id=d.section_id
LEFT JOIN sources s ON s.source_id=d.source_id;

CREATE VIEW v_statement_register AS
SELECT 'theorem' AS statement_type, t.theorem_number AS statement_number,
       ds.section_code, t.title, t.statement_text, t.word_latex,
       t.provenance, s.citation_number, t.validation_status
FROM theorems t
JOIN dissertation_sections ds ON ds.section_id=t.section_id
LEFT JOIN sources s ON s.source_id=t.source_id
UNION ALL
SELECT 'lemma', l.lemma_number, ds.section_code, l.title, l.statement_text,
       l.word_latex, l.provenance, s.citation_number, l.validation_status
FROM lemmas l
JOIN dissertation_sections ds ON ds.section_id=l.section_id
LEFT JOIN sources s ON s.source_id=l.source_id
UNION ALL
SELECT 'corollary', c.corollary_number, ds.section_code, c.title, c.statement_text,
       c.word_latex, c.provenance, s.citation_number, c.validation_status
FROM corollaries c
JOIN dissertation_sections ds ON ds.section_id=c.section_id
LEFT JOIN sources s ON s.source_id=c.source_id;

CREATE VIEW v_axiom_register AS
SELECT
  a.axiom_number,
  ds.section_code,
  a.title,
  a.axiom_text,
  a.word_latex,
  a.status,
  asm.assumption_number AS based_on_assumption
FROM axioms a
JOIN dissertation_sections ds ON ds.section_id=a.section_id
LEFT JOIN assumptions asm ON asm.assumption_id=a.source_assumption_id;

CREATE VIEW v_proposition_register AS
SELECT
  p.proposition_number,
  ds.section_code,
  p.title,
  p.statement_text,
  p.word_latex,
  p.based_on_axioms,
  p.status
FROM propositions p
JOIN dissertation_sections ds ON ds.section_id=p.section_id;

CREATE VIEW v_section_inventory AS
SELECT
  ds.section_code,
  ds.title,
  ds.status,
  COUNT(DISTINCT su.source_id) AS source_count,
  COUNT(DISTINCT e.equation_id) AS equation_count,
  COUNT(DISTINCT d.definition_id) AS definition_count,
  COUNT(DISTINCT th.theorem_id) AS theorem_count,
  COUNT(DISTINCT l.lemma_id) AS lemma_count,
  COUNT(DISTINCT c.corollary_id) AS corollary_count,
  COUNT(DISTINCT p.proof_id) AS proof_count,
  COUNT(DISTINCT pr.proposition_id) AS proposition_count,
  COUNT(DISTINCT a.assumption_id) AS assumption_count,
  COUNT(DISTINCT ax.axiom_id) AS axiom_count,
  COUNT(DISTINCT f.figure_id) AS figure_count,
  COUNT(DISTINCT dt.table_id) AS table_count
FROM dissertation_sections ds
LEFT JOIN source_usage su ON su.section_id=ds.section_id
LEFT JOIN equations e ON e.section_id=ds.section_id
LEFT JOIN definitions d ON d.section_id=ds.section_id
LEFT JOIN theorems th ON th.section_id=ds.section_id
LEFT JOIN lemmas l ON l.section_id=ds.section_id
LEFT JOIN corollaries c ON c.section_id=ds.section_id
LEFT JOIN proofs p ON p.section_id=ds.section_id
LEFT JOIN propositions pr ON pr.section_id=ds.section_id
LEFT JOIN assumptions a ON a.section_id=ds.section_id
LEFT JOIN axioms ax ON ax.section_id=ds.section_id
LEFT JOIN figures f ON f.section_id=ds.section_id
LEFT JOIN dissertation_tables dt ON dt.section_id=ds.section_id
GROUP BY ds.section_id, ds.section_code, ds.title, ds.status;

-- ------------------------------------------------------------
-- 9. Basisrevision und Zähler
-- ------------------------------------------------------------
INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary)
VALUES
('RKB-V4-INITIAL',NOW(),'repository','frzk_rkb','4.0',
 'Initialisierung der stabilen FRZK-RKB-V4-Datenbankbasis.');

SET @initial_revision_id=LAST_INSERT_ID();

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('next_citation_number','1'),
('next_equation_number','3.1'),
('last_completed_section',''),
('last_repository_revision','RKB-V4-INITIAL');

SET FOREIGN_KEY_CHECKS = 1;
