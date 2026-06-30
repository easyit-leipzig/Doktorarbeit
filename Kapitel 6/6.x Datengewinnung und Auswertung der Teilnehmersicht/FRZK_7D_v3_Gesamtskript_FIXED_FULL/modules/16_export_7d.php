<?php
// ============================================================================
// 16_export_7d.php
// Einheitlicher JSON-Export aller 7D-Tabellen.
// ============================================================================

function frzk7d_export_all(PDO $pdo): void
{
    $tables = [
        'frzk_semantische_dichte_teilnehmer_7d' => 'id',
        'frzk_interdependenz_7d' => 'id',
        'frzk_loops_7d' => 'id',
        'frzk_operatoren_7d' => 'id',
        'frzk_reflexion_7d' => 'id',
        'frzk_transitions_7d' => 'id',
        'frzk_group_semantische_dichte_7d' => 'gruppe_id, zeitpunkt',
        'frzk_group_transitions_7d' => 'gruppe_id, zeitpunkt_von, zeitpunkt_nach',
        'frzk_group_reflexion_7d' => 'gruppe_id, zeitpunkt',
        'frzk_group_loops_7d' => 'gruppe_id, start_zeit, end_zeit',
        'frzk_group_interdependenz_7d' => 'gruppe_id, zeitpunkt',
        'frzk_group_operatoren_7d' => 'gruppe_id, zeitpunkt',
        'frzk_group_emotion_7d' => 'gruppe_id, zeitpunkt',
        'frzk_group_hubs_7d' => 'gruppe_id, zeitpunkt',
        'frzk_group_regulation_7d' => 'gruppe_id'
    ];

    foreach ($tables as $table => $orderBy) {
        exportTable($pdo, $table, $orderBy);
    }
}
?>
