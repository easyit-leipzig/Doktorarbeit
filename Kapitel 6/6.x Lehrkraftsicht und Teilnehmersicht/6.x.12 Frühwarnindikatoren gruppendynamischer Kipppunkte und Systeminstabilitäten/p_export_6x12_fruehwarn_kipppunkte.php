<?php
/**
 * 6.x.12 Frühwarnindikatoren gruppendynamischer Kipppunkte und Systeminstabilitäten
 * Exportskript PHP
 *
 * Erzeugt: 6x12_fruehwarn_kipppunkte.json
 */

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$db = [
    'host' => '127.0.0.1',
    'user' => 'root',
    'pass' => '',
    'name' => 'icas_19_4_2',
    'port' => 3306,
];

$outfile = __DIR__ . DIRECTORY_SEPARATOR . '6x12_fruehwarn_kipppunkte.json';
$dimensions = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];
$scopes = [
    'alle_lehrkraefte' => '1=1',
    'lehrkraft_1' => 'lehrkraft_id = 1',
    'ohne_lehrkraft_1' => 'lehrkraft_id <> 1',
];

function fetchAllAssoc(mysqli $conn, string $sql): array {
    $res = $conn->query($sql);
    $rows = [];
    while ($row = $res->fetch_assoc()) {
        $rows[] = $row;
    }
    return $rows;
}

function tableExists(mysqli $conn, string $table): bool {
    $stmt = $conn->prepare("SELECT COUNT(*) AS c FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = ?");
    $stmt->bind_param('s', $table);
    $stmt->execute();
    $row = $stmt->get_result()->fetch_assoc();
    return intval($row['c']) > 0;
}

function exportScope(mysqli $conn, string $scopeName, string $whereClause, array $dimensions): array {
    $parts = [];
    foreach ($dimensions as $d) {
        $parts[] = "AVG(mean_$d) AS mean_$d, AVG(var_$d) AS var_$d, AVG(range_$d) AS range_$d";
    }
    $dimSelect = implode(",\n            ", $parts);

    $sqlLehrkraft = "
        SELECT
            gruppe_id,
            datum,
            COUNT(*) AS n_lehrkraft_records,
            SUM(satzanzahl) AS satzanzahl_sum,
            AVG(semantische_breite) AS semantische_breite,
            AVG(d_semantisch_mean) AS d_semantisch_mean,
            AVG(d_semantisch_std) AS d_semantisch_std,
            AVG(polaritaet_index) AS polaritaet_index,
            AVG(dominanz_breite) AS dominanz_breite,
            $dimSelect
        FROM analyze_lehrkraftdaten
        WHERE gruppe_id IS NOT NULL AND datum IS NOT NULL AND $whereClause
        GROUP BY gruppe_id, datum
        ORDER BY gruppe_id, datum
    ";

    $lehrkraftDaily = fetchAllAssoc($conn, $sqlLehrkraft);

    $groupEmotion = [];
    if (tableExists($conn, 'frzk_group_emotion')) {
        $groupEmotion = fetchAllAssoc($conn, "
            SELECT
                gruppe_id,
                zeitpunkt,
                z_affektiv,
                `kohärenz` AS kohaerenz,
                stabilitaet,
                dynamik,
                emotionaler_status,
                emotionaler_modus,
                bemerkung
            FROM frzk_group_emotion
            WHERE gruppe_id IS NOT NULL AND zeitpunkt IS NOT NULL
            ORDER BY gruppe_id, zeitpunkt
        ");
    }

    $teilnehmerDaily = [];
    if (tableExists($conn, 'frzk_semantische_dichte_teilnehmer_7d')) {
        $teilnehmerDaily = fetchAllAssoc($conn, "
            SELECT
                gruppe_id,
                zeitpunkt AS datum,
                COUNT(*) AS n_teilnehmer_records,
                AVG(x_kognition) AS tn_mean_kognition,
                AVG(x_sozial) AS tn_mean_sozial,
                AVG(x_affektiv) AS tn_mean_affektiv,
                AVG(x_motivation) AS tn_mean_motivation,
                AVG(x_methodik) AS tn_mean_methodik,
                AVG(x_performanz) AS tn_mean_performanz,
                AVG(x_regulation) AS tn_mean_regulation,
                AVG(d_semantisch) AS tn_d_semantisch_mean,
                AVG(emotion_valenz) AS emotion_valenz_mean,
                AVG(emotion_aktivierung) AS emotion_aktivierung_mean,
                AVG(emotion_anzahl) AS emotion_anzahl_mean,
                AVG(polaritaet_gesamt) AS tn_polaritaet_mean,
                COUNT(DISTINCT dominante_dimension) AS tn_dominanz_breite
            FROM frzk_semantische_dichte_teilnehmer_7d
            WHERE gruppe_id IS NOT NULL AND zeitpunkt IS NOT NULL
            GROUP BY gruppe_id, zeitpunkt
            ORDER BY gruppe_id, zeitpunkt
        ");
    }

    $summary = fetchAllAssoc($conn, "
        SELECT
            gruppe_id,
            COUNT(*) AS n_records,
            COUNT(DISTINCT datum) AS n_termine,
            MIN(datum) AS datum_min,
            MAX(datum) AS datum_max,
            AVG(semantische_breite) AS semantische_breite_mean,
            AVG(d_semantisch_std) AS d_semantisch_std_mean,
            AVG(polaritaet_index) AS polaritaet_index_mean,
            AVG(dominanz_breite) AS dominanz_breite_mean
        FROM analyze_lehrkraftdaten
        WHERE gruppe_id IS NOT NULL AND datum IS NOT NULL AND $whereClause
        GROUP BY gruppe_id
        ORDER BY gruppe_id
    ");

    return [
        'scope' => $scopeName,
        'where_clause' => $whereClause,
        'group_summary' => $summary,
        'lehrkraft_daily' => $lehrkraftDaily,
        'group_emotion' => $groupEmotion,
        'teilnehmer_daily' => $teilnehmerDaily,
    ];
}

$conn = new mysqli($db['host'], $db['user'], $db['pass'], $db['name'], $db['port']);
$conn->set_charset('utf8mb4');

$payload = [
    'meta' => [
        'auswertung' => '6.x.12 Frühwarnindikatoren gruppendynamischer Kipppunkte und Systeminstabilitäten',
        'created_at' => date('c'),
        'database' => $db['name'],
        'dimensions' => $dimensions,
        'definition' => [
            'drift' => 'Euklidische Distanz zwischen aufeinanderfolgenden Gruppenzuständen',
            'varianzlast' => 'Mittel der sieben Varianzdimensionen aus analyze_lehrkraftdaten',
            'kohaerenzverlust' => 'fallende Kohärenz bzw. steigende semantische Breite/Drift',
            'dominanzwechsel' => 'Wechsel der stärksten Dimension zwischen aufeinanderfolgenden Gruppenzuständen',
            'risiko_score' => 'gewichteter Frühwarnindex aus Drift, Varianzlast, Dichte-Std, semantischer Breite, Polaritätsbelastung, Dominanzwechsel und optional Gruppendynamik/Emotionen',
        ],
    ],
    'scopes' => [],
];

foreach ($scopes as $scopeName => $whereClause) {
    $payload['scopes'][$scopeName] = exportScope($conn, $scopeName, $whereClause, $dimensions);
}

file_put_contents($outfile, json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
echo "OK: JSON exportiert nach $outfile\n";
