<?php
// ============================================================================
// 00_schema_7d.php
// Zentrales Schema fuer die FRZK-7D-v3-Neustruktur.
// Alle neu berechneten Gruppentabellen tragen konsequent den Suffix _7d.
// ============================================================================

function frzk7d_schema(PDO $pdo): void
{
    frzk7d_create_participant_tables($pdo);
    frzk7d_create_group_tables($pdo);
}

function frzk7d_create_participant_tables(PDO $pdo): void
{
    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_semantische_dichte_teilnehmer_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        rueckkopplung_teilnehmer_id INT NULL,
        ue_id INT NULL,
        ue_zuweisung_teilnehmer_id INT NULL,
        teilnehmer_id INT NOT NULL,
        gruppe_id INT NULL,
        zeitpunkt DATETIME NOT NULL,

        x_kognition DOUBLE DEFAULT 0,
        x_sozial DOUBLE DEFAULT 0,
        x_affektiv DOUBLE DEFAULT 0,
        x_motivation DOUBLE DEFAULT 0,
        x_methodik DOUBLE DEFAULT 0,
        x_performanz DOUBLE DEFAULT 0,
        x_regulation DOUBLE DEFAULT 0,

        sum_kognition DOUBLE DEFAULT 0,
        sum_sozial DOUBLE DEFAULT 0,
        sum_affektiv DOUBLE DEFAULT 0,
        sum_motivation DOUBLE DEFAULT 0,
        sum_methodik DOUBLE DEFAULT 0,
        sum_performanz DOUBLE DEFAULT 0,
        sum_regulation DOUBLE DEFAULT 0,

        emotion_ids TEXT NULL,
        emotion_valenz DOUBLE NULL,
        emotion_aktivierung DOUBLE NULL,
        emotion_anzahl INT DEFAULT 0,

        emotion_vector_kognition DOUBLE DEFAULT 0,
        emotion_vector_sozial DOUBLE DEFAULT 0,
        emotion_vector_affektiv DOUBLE DEFAULT 0,
        emotion_vector_motivation DOUBLE DEFAULT 0,
        emotion_vector_methodik DOUBLE DEFAULT 0,
        emotion_vector_performanz DOUBLE DEFAULT 0,
        emotion_vector_regulation DOUBLE DEFAULT 0,

        skala_kognition DOUBLE DEFAULT 0,
        skala_sozial DOUBLE DEFAULT 0,
        skala_affektiv DOUBLE DEFAULT 0,
        skala_motivation DOUBLE DEFAULT 0,
        skala_methodik DOUBLE DEFAULT 0,
        skala_performanz DOUBLE DEFAULT 0,
        skala_regulation DOUBLE DEFAULT 0,

        fusion_alpha DOUBLE DEFAULT NULL,
        fusion_beta DOUBLE DEFAULT NULL,
        fusion_lambda DOUBLE DEFAULT NULL,
        fusion_delta DOUBLE DEFAULT NULL,
        emotion_cosine DOUBLE DEFAULT NULL,

        dominante_dimension VARCHAR(50) NULL,
        dominante_dimension_wert DOUBLE DEFAULT 0,
        polaritaet_gesamt INT DEFAULT 0,
        d_semantisch DOUBLE DEFAULT 0,

        drift_norm DOUBLE DEFAULT NULL,
        d_semantisch_delta DOUBLE DEFAULT NULL,
        dominanzwechsel TINYINT(1) DEFAULT NULL,
        stabilitaet DOUBLE DEFAULT NULL,
        transition_marker VARCHAR(80) DEFAULT NULL,

        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_tn_time (teilnehmer_id, zeitpunkt),
        INDEX idx_group_time (gruppe_id, zeitpunkt)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    frzk7d_add_missing_columns($pdo, 'frzk_semantische_dichte_teilnehmer_7d', [
        'drift_norm' => 'DOUBLE DEFAULT NULL',
        'd_semantisch_delta' => 'DOUBLE DEFAULT NULL',
        'dominanzwechsel' => 'TINYINT(1) DEFAULT NULL',
        'stabilitaet' => 'DOUBLE DEFAULT NULL',
        'transition_marker' => 'VARCHAR(80) DEFAULT NULL',
        'emotion_vector_kognition' => 'DOUBLE DEFAULT 0',
        'emotion_vector_sozial' => 'DOUBLE DEFAULT 0',
        'emotion_vector_affektiv' => 'DOUBLE DEFAULT 0',
        'emotion_vector_motivation' => 'DOUBLE DEFAULT 0',
        'emotion_vector_methodik' => 'DOUBLE DEFAULT 0',
        'emotion_vector_performanz' => 'DOUBLE DEFAULT 0',
        'emotion_vector_regulation' => 'DOUBLE DEFAULT 0',
        'skala_kognition' => 'DOUBLE DEFAULT 0',
        'skala_sozial' => 'DOUBLE DEFAULT 0',
        'skala_affektiv' => 'DOUBLE DEFAULT 0',
        'skala_motivation' => 'DOUBLE DEFAULT 0',
        'skala_methodik' => 'DOUBLE DEFAULT 0',
        'skala_performanz' => 'DOUBLE DEFAULT 0',
        'skala_regulation' => 'DOUBLE DEFAULT 0',
        'fusion_alpha' => 'DOUBLE DEFAULT NULL',
        'fusion_beta' => 'DOUBLE DEFAULT NULL',
        'fusion_lambda' => 'DOUBLE DEFAULT NULL',
        'fusion_delta' => 'DOUBLE DEFAULT NULL',
        'emotion_cosine' => 'DOUBLE DEFAULT NULL'
    ]);

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_interdependenz_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        teilnehmer_id INT NOT NULL,
        gruppe_id INT NULL,
        zeitpunkt DATETIME NOT NULL,
        x_kognition DOUBLE,
        x_sozial DOUBLE,
        x_affektiv DOUBLE,
        x_motivation DOUBLE,
        x_methodik DOUBLE,
        x_performanz DOUBLE,
        x_regulation DOUBLE,
        d_semantisch DOUBLE,
        korrelationsscore DOUBLE,
        kohaerenz_index DOUBLE,
        varianz_7d DOUBLE,
        bemerkung TEXT,
        INDEX idx_tn_time (teilnehmer_id, zeitpunkt)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_loops_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        teilnehmer_id INT NOT NULL,
        start_zeit DATETIME NOT NULL,
        end_zeit DATETIME NOT NULL,
        schleifen_typ VARCHAR(50),
        dauer INT,
        drift_avg DOUBLE,
        verdichtungsgrad DOUBLE,
        stabilitaet DOUBLE,
        pausenmarker VARCHAR(50),
        bemerkung TEXT,
        INDEX idx_tn (teilnehmer_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_operatoren_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        teilnehmer_id INT NOT NULL,
        gruppe_id INT NULL,
        zeitpunkt DATETIME NOT NULL,
        sigma DOUBLE,
        M DOUBLE,
        R DOUBLE,
        E DOUBLE,
        operator_status VARCHAR(80),
        bemerkung TEXT,
        INDEX idx_tn_time (teilnehmer_id, zeitpunkt)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_reflexion_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        teilnehmer_id INT NOT NULL,
        zeitpunkt DATETIME NOT NULL,
        reflexionsgrad DOUBLE,
        meta_kohaerenz DOUBLE,
        selbstbezug_index DOUBLE,
        stabilitaet DOUBLE,
        marker VARCHAR(50),
        bemerkung TEXT,
        INDEX idx_tn (teilnehmer_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_transitions_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        teilnehmer_id INT NOT NULL,
        zeitpunkt_von DATETIME NOT NULL,
        zeitpunkt_nach DATETIME NOT NULL,
        dominante_dimension_von VARCHAR(50),
        dominante_dimension_nach VARCHAR(50),
        d_von DOUBLE,
        d_nach DOUBLE,
        delta DOUBLE,
        transition_typ VARCHAR(80),
        dominanzwechsel TINYINT(1),
        bemerkung TEXT,
        INDEX idx_tn (teilnehmer_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");
}

function frzk7d_create_group_tables(PDO $pdo): void
{
    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_group_semantische_dichte_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        gruppe_id INT NOT NULL,
        zeitpunkt DATE NOT NULL,
        anz_tn INT DEFAULT 0,

        mean_kognition DOUBLE,
        mean_sozial DOUBLE,
        mean_affektiv DOUBLE,
        mean_motivation DOUBLE,
        mean_methodik DOUBLE,
        mean_performanz DOUBLE,
        mean_regulation DOUBLE,

        d_semantisch_mean DOUBLE,
        dominante_dimension VARCHAR(50),
        dominante_dimension_wert DOUBLE,
        polaritaet_gesamt INT,

        gruppen_drift_norm DOUBLE,
        gruppen_stabilitaet DOUBLE,
        gruppen_transition_marker VARCHAR(80),

        mean_emotion_valenz DOUBLE NULL,
        mean_emotion_aktivierung DOUBLE NULL,
        emotion_n INT DEFAULT 0,

        mean_emotion_vector_kognition DOUBLE DEFAULT 0,
        mean_emotion_vector_sozial DOUBLE DEFAULT 0,
        mean_emotion_vector_affektiv DOUBLE DEFAULT 0,
        mean_emotion_vector_motivation DOUBLE DEFAULT 0,
        mean_emotion_vector_methodik DOUBLE DEFAULT 0,
        mean_emotion_vector_performanz DOUBLE DEFAULT 0,
        mean_emotion_vector_regulation DOUBLE DEFAULT 0,

        mean_skala_kognition DOUBLE DEFAULT 0,
        mean_skala_sozial DOUBLE DEFAULT 0,
        mean_skala_affektiv DOUBLE DEFAULT 0,
        mean_skala_motivation DOUBLE DEFAULT 0,
        mean_skala_methodik DOUBLE DEFAULT 0,
        mean_skala_performanz DOUBLE DEFAULT 0,
        mean_skala_regulation DOUBLE DEFAULT 0,

        bemerkung TEXT,
        UNIQUE KEY uq_group_date (gruppe_id, zeitpunkt)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_group_transitions_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        gruppe_id INT NOT NULL,
        zeitpunkt_von DATE NOT NULL,
        zeitpunkt_nach DATE NOT NULL,
        dominante_dimension_von VARCHAR(50),
        dominante_dimension_nach VARCHAR(50),
        d_von DOUBLE,
        d_nach DOUBLE,
        delta DOUBLE,
        transition_typ VARCHAR(80),
        dominanzwechsel TINYINT(1),
        bemerkung TEXT,
        INDEX idx_group_time (gruppe_id, zeitpunkt_von, zeitpunkt_nach)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_group_reflexion_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        gruppe_id INT NOT NULL,
        zeitpunkt DATE NOT NULL,
        reflexionsgrad DOUBLE,
        meta_kohaerenz DOUBLE,
        selbstbezug_index DOUBLE DEFAULT 0,
        stabilitaet DOUBLE,
        marker VARCHAR(50),
        bemerkung TEXT,
        INDEX idx_group_date (gruppe_id, zeitpunkt)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_group_loops_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        gruppe_id INT NOT NULL,
        start_zeit DATE NOT NULL,
        end_zeit DATE NOT NULL,
        schleifen_typ VARCHAR(50),
        dauer INT,
        drift_avg DOUBLE,
        verdichtung DOUBLE DEFAULT NULL,
        verdichtungsgrad DOUBLE DEFAULT NULL,
        stabilitaet DOUBLE,
        pausenmarker VARCHAR(50) DEFAULT NULL,
        bemerkung TEXT,
        INDEX idx_group (gruppe_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_group_interdependenz_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        gruppe_id INT NOT NULL,
        zeitpunkt DATE NOT NULL,
        mean_kognition DOUBLE,
        mean_sozial DOUBLE,
        mean_affektiv DOUBLE,
        mean_motivation DOUBLE,
        mean_methodik DOUBLE,
        mean_performanz DOUBLE,
        mean_regulation DOUBLE,
        d_semantisch_mean DOUBLE,
        korrelationsscore DOUBLE,
        kohaerenz_index DOUBLE,
        varianz_7d DOUBLE,
        bemerkung TEXT,
        INDEX idx_group_date (gruppe_id, zeitpunkt)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_group_operatoren_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        gruppe_id INT NOT NULL,
        zeitpunkt DATE NOT NULL,
        sigma DOUBLE,
        M DOUBLE,
        R DOUBLE,
        E DOUBLE,
        operator_level DOUBLE,
        dominanter_operator VARCHAR(20),
        operator_status VARCHAR(80),
        bemerkung TEXT,
        INDEX idx_group_date (gruppe_id, zeitpunkt)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_group_emotion_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        gruppe_id INT NOT NULL,
        zeitpunkt DATE NOT NULL,
        mean_affektiv DOUBLE,
        mean_emotion_valenz DOUBLE NULL,
        mean_emotion_aktivierung DOUBLE NULL,
        emotion_n INT DEFAULT 0,
        kohaerenz_index DOUBLE,
        stabilitaet DOUBLE,
        dynamik DOUBLE,
        emotionaler_status VARCHAR(80),
        emotionaler_modus VARCHAR(80),
        bemerkung TEXT,
        INDEX idx_group_date (gruppe_id, zeitpunkt)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_group_hubs_7d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        gruppe_id INT NOT NULL,
        zeitpunkt DATE NOT NULL,
        hub_dimension VARCHAR(50),
        hub_wert DOUBLE,
        hub_score DOUBLE,
        hub_typ VARCHAR(80),
        bedeutungszentrum VARCHAR(160),
        stabilitaet DOUBLE,
        bemerkung TEXT,
        INDEX idx_group_date (gruppe_id, zeitpunkt)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    $pdo->exec("CREATE TABLE IF NOT EXISTS frzk_group_regulation_7d (
        gruppe_id INT PRIMARY KEY,
        mean_drift_norm DOUBLE DEFAULT NULL,
        var_drift_norm DOUBLE DEFAULT NULL,
        mean_d_semantisch DOUBLE DEFAULT NULL,
        var_d_semantisch DOUBLE DEFAULT NULL,
        loop_density DOUBLE DEFAULT NULL,
        loop_stabilitaet_mean DOUBLE DEFAULT NULL,
        gruppen_stabilitaet_mean DOUBLE DEFAULT NULL,
        transition_rate DOUBLE DEFAULT NULL,
        regulation_score DOUBLE DEFAULT NULL,
        regulation_typ VARCHAR(80) DEFAULT NULL,
        bemerkung TEXT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");

    // ------------------------------------------------------------------
    // Migrationssicherheit:
    // CREATE TABLE IF NOT EXISTS ergänzt bestehende Tabellen nicht.
    // Deshalb werden alle von den Modulen verwendeten Felder explizit nachgezogen.
    // ------------------------------------------------------------------
    frzk7d_add_missing_columns($pdo, 'frzk_group_semantische_dichte_7d', [
        'anz_tn' => 'INT DEFAULT 0 AFTER zeitpunkt',
        'mean_kognition' => 'DOUBLE DEFAULT NULL',
        'mean_sozial' => 'DOUBLE DEFAULT NULL',
        'mean_affektiv' => 'DOUBLE DEFAULT NULL',
        'mean_motivation' => 'DOUBLE DEFAULT NULL',
        'mean_methodik' => 'DOUBLE DEFAULT NULL',
        'mean_performanz' => 'DOUBLE DEFAULT NULL',
        'mean_regulation' => 'DOUBLE DEFAULT NULL',
        'd_semantisch_mean' => 'DOUBLE DEFAULT NULL',
        'dominante_dimension' => 'VARCHAR(50) DEFAULT NULL',
        'dominante_dimension_wert' => 'DOUBLE DEFAULT NULL',
        'polaritaet_gesamt' => 'INT DEFAULT 0',
        'gruppen_drift_norm' => 'DOUBLE DEFAULT NULL',
        'gruppen_stabilitaet' => 'DOUBLE DEFAULT NULL',
        'gruppen_transition_marker' => 'VARCHAR(80) DEFAULT NULL',
        'mean_emotion_valenz' => 'DOUBLE DEFAULT NULL',
        'mean_emotion_aktivierung' => 'DOUBLE DEFAULT NULL',
        'emotion_n' => 'INT DEFAULT 0',
        'mean_emotion_vector_kognition' => 'DOUBLE DEFAULT 0',
        'mean_emotion_vector_sozial' => 'DOUBLE DEFAULT 0',
        'mean_emotion_vector_affektiv' => 'DOUBLE DEFAULT 0',
        'mean_emotion_vector_motivation' => 'DOUBLE DEFAULT 0',
        'mean_emotion_vector_methodik' => 'DOUBLE DEFAULT 0',
        'mean_emotion_vector_performanz' => 'DOUBLE DEFAULT 0',
        'mean_emotion_vector_regulation' => 'DOUBLE DEFAULT 0',
        'mean_skala_kognition' => 'DOUBLE DEFAULT 0',
        'mean_skala_sozial' => 'DOUBLE DEFAULT 0',
        'mean_skala_affektiv' => 'DOUBLE DEFAULT 0',
        'mean_skala_motivation' => 'DOUBLE DEFAULT 0',
        'mean_skala_methodik' => 'DOUBLE DEFAULT 0',
        'mean_skala_performanz' => 'DOUBLE DEFAULT 0',
        'mean_skala_regulation' => 'DOUBLE DEFAULT 0',
        'bemerkung' => 'TEXT NULL'
    ]);

    frzk7d_add_missing_columns($pdo, 'frzk_group_transitions_7d', [
        'zeitpunkt_von' => 'DATE NULL',
        'zeitpunkt_nach' => 'DATE NULL',
        'dominante_dimension_von' => 'VARCHAR(50) DEFAULT NULL',
        'dominante_dimension_nach' => 'VARCHAR(50) DEFAULT NULL',
        'd_von' => 'DOUBLE DEFAULT NULL',
        'd_nach' => 'DOUBLE DEFAULT NULL',
        'delta' => 'DOUBLE DEFAULT NULL',
        'transition_typ' => 'VARCHAR(80) DEFAULT NULL',
        'dominanzwechsel' => 'TINYINT(1) DEFAULT NULL',
        'bemerkung' => 'TEXT NULL'
    ]);

    frzk7d_add_missing_columns($pdo, 'frzk_group_reflexion_7d', [
        'reflexionsgrad' => 'DOUBLE DEFAULT NULL',
        'meta_kohaerenz' => 'DOUBLE DEFAULT NULL',
        'selbstbezug_index' => 'DOUBLE DEFAULT 0',
        'stabilitaet' => 'DOUBLE DEFAULT NULL',
        'marker' => 'VARCHAR(50) DEFAULT NULL',
        'bemerkung' => 'TEXT NULL'
    ]);

    frzk7d_add_missing_columns($pdo, 'frzk_group_loops_7d', [
        'schleifen_typ' => 'VARCHAR(50) DEFAULT NULL',
        'dauer' => 'INT DEFAULT NULL',
        'drift_avg' => 'DOUBLE DEFAULT NULL',
        'verdichtung' => 'DOUBLE DEFAULT NULL',
        'verdichtungsgrad' => 'DOUBLE DEFAULT NULL',
        'stabilitaet' => 'DOUBLE DEFAULT NULL',
        'pausenmarker' => 'VARCHAR(50) DEFAULT NULL',
        'bemerkung' => 'TEXT NULL'
    ]);

    frzk7d_add_missing_columns($pdo, 'frzk_group_interdependenz_7d', [
        'mean_kognition' => 'DOUBLE DEFAULT NULL',
        'mean_sozial' => 'DOUBLE DEFAULT NULL',
        'mean_affektiv' => 'DOUBLE DEFAULT NULL',
        'mean_motivation' => 'DOUBLE DEFAULT NULL',
        'mean_methodik' => 'DOUBLE DEFAULT NULL',
        'mean_performanz' => 'DOUBLE DEFAULT NULL',
        'mean_regulation' => 'DOUBLE DEFAULT NULL',
        'd_semantisch_mean' => 'DOUBLE DEFAULT NULL',
        'korrelationsscore' => 'DOUBLE DEFAULT NULL',
        'kohaerenz_index' => 'DOUBLE DEFAULT NULL',
        'varianz_7d' => 'DOUBLE DEFAULT NULL',
        'bemerkung' => 'TEXT NULL'
    ]);

    frzk7d_add_missing_columns($pdo, 'frzk_group_operatoren_7d', [
        'sigma' => 'DOUBLE DEFAULT NULL',
        'M' => 'DOUBLE DEFAULT NULL',
        'R' => 'DOUBLE DEFAULT NULL',
        'E' => 'DOUBLE DEFAULT NULL',
        'operator_level' => 'DOUBLE DEFAULT NULL',
        'dominanter_operator' => 'VARCHAR(20) DEFAULT NULL',
        'operator_status' => 'VARCHAR(80) DEFAULT NULL',
        'bemerkung' => 'TEXT NULL'
    ]);

    frzk7d_add_missing_columns($pdo, 'frzk_group_emotion_7d', [
        'mean_affektiv' => 'DOUBLE DEFAULT NULL',
        'mean_emotion_valenz' => 'DOUBLE DEFAULT NULL',
        'mean_emotion_aktivierung' => 'DOUBLE DEFAULT NULL',
        'emotion_n' => 'INT DEFAULT 0',
        'kohaerenz_index' => 'DOUBLE DEFAULT NULL',
        'stabilitaet' => 'DOUBLE DEFAULT NULL',
        'dynamik' => 'DOUBLE DEFAULT NULL',
        'emotionaler_status' => 'VARCHAR(80) DEFAULT NULL',
        'emotionaler_modus' => 'VARCHAR(80) DEFAULT NULL',
        'bemerkung' => 'TEXT NULL'
    ]);

    frzk7d_add_missing_columns($pdo, 'frzk_group_hubs_7d', [
        'hub_dimension' => 'VARCHAR(50) DEFAULT NULL',
        'hub_wert' => 'DOUBLE DEFAULT NULL',
        'hub_score' => 'DOUBLE DEFAULT NULL',
        'hub_typ' => 'VARCHAR(80) DEFAULT NULL',
        'bedeutungszentrum' => 'VARCHAR(160) DEFAULT NULL',
        'stabilitaet' => 'DOUBLE DEFAULT NULL',
        'bemerkung' => 'TEXT NULL'
    ]);

    frzk7d_add_missing_columns($pdo, 'frzk_group_regulation_7d', [
        'mean_drift_norm' => 'DOUBLE DEFAULT NULL',
        'var_drift_norm' => 'DOUBLE DEFAULT NULL',
        'mean_d_semantisch' => 'DOUBLE DEFAULT NULL',
        'var_d_semantisch' => 'DOUBLE DEFAULT NULL',
        'loop_density' => 'DOUBLE DEFAULT NULL',
        'loop_stabilitaet_mean' => 'DOUBLE DEFAULT NULL',
        'gruppen_stabilitaet_mean' => 'DOUBLE DEFAULT NULL',
        'transition_rate' => 'DOUBLE DEFAULT NULL',
        'regulation_score' => 'DOUBLE DEFAULT NULL',
        'regulation_typ' => 'VARCHAR(80) DEFAULT NULL',
        'bemerkung' => 'TEXT NULL'
    ]);
}

function frzk7d_truncate(PDO $pdo): void
{
    $tables = [
        'frzk_interdependenz_7d',
        'frzk_loops_7d',
        'frzk_operatoren_7d',
        'frzk_reflexion_7d',
        'frzk_transitions_7d',
        'frzk_group_semantische_dichte_7d',
        'frzk_group_transitions_7d',
        'frzk_group_reflexion_7d',
        'frzk_group_loops_7d',
        'frzk_group_interdependenz_7d',
        'frzk_group_operatoren_7d',
        'frzk_group_emotion_7d',
        'frzk_group_hubs_7d',
        'frzk_group_regulation_7d',
        'frzk_semantische_dichte_teilnehmer_7d'
    ];

    foreach ($tables as $table) {
        try {
            $pdo->exec("TRUNCATE TABLE `$table`");
        } catch (Throwable $e) {
            $pdo->exec("DELETE FROM `$table`");
        }
    }
}

function frzk7d_add_missing_columns(PDO $pdo, string $table, array $columns): void
{
    foreach ($columns as $column => $definition) {
        addColumnIfMissing($pdo, $table, $column, $definition);
    }
}
?>
