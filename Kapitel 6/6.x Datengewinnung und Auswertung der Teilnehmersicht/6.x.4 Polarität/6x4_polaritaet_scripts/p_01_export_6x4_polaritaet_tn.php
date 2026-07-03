<?php
// ============================================================================
// 6.x.4 Polarität – PHP-Export
// Erzeugt JSON-Daten ohne Lehrkraftunterscheidung aus frzk_semantische_dichte_teilnehmer_7d.
// Ausgabe: 6x4_polaritaet_tn.json
// ============================================================================

header('Content-Type: text/plain; charset=utf-8');
ini_set('display_errors', '1');
error_reporting(E_ALL);

$dbHost = getenv('FRZK_DB_HOST') ?: 'localhost';
$dbName = getenv('FRZK_DB_NAME') ?: 'icas_19_4_2';
$dbUser = getenv('FRZK_DB_USER') ?: 'root';
$dbPass = getenv('FRZK_DB_PASS') ?: '';
$outFile = __DIR__ . DIRECTORY_SEPARATOR . '6x4_polaritaet_tn.json';

$pdo = new PDO("mysql:host={$dbHost};dbname={$dbName};charset=utf8mb4", $dbUser, $dbPass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$dimensions = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];
$dimCols = implode(', ', array_map(fn($d) => "x_{$d}", $dimensions));

$sql = "
    SELECT
        id, rueckkopplung_teilnehmer_id, ue_id, teilnehmer_id, gruppe_id, zeitpunkt,
        {$dimCols}, dominante_dimension, dominante_dimension_wert,
        polaritaet_gesamt, d_semantisch, drift_norm, d_semantisch_delta,
        dominanzwechsel, stabilitaet, transition_marker
    FROM frzk_semantische_dichte_teilnehmer_7d
    WHERE zeitpunkt IS NOT NULL
    ORDER BY gruppe_id, teilnehmer_id, zeitpunkt, id
";

$rows = $pdo->query($sql)->fetchAll();

function polClass($sign) {
    if ($sign > 0) return 'positiv';
    if ($sign < 0) return 'negativ';
    return 'neutral';
}

$records = [];
foreach ($rows as $r) {
    global $dimensions;
    $sum = 0.0;
    foreach ($dimensions as $d) {
        $sum += (float)($r["x_{$d}"] ?? 0.0);
    }
    $idx = $sum / count($dimensions);
    $sign = isset($r['polaritaet_gesamt']) ? (int)$r['polaritaet_gesamt'] : ($idx > 0 ? 1 : ($idx < 0 ? -1 : 0));
    $r['polaritaet_index'] = $idx;
    $r['polaritaet_klasse'] = polClass($sign);
    $records[] = $r;
}

function addAgg(&$bucket, $key, $record, $extra) {
    if (!isset($bucket[$key])) {
        $bucket[$key] = array_merge($extra, [
            'n' => 0, 'positiv' => 0, 'negativ' => 0, 'neutral' => 0, 'sum_index' => 0.0
        ]);
    }
    $bucket[$key]['n']++;
    $bucket[$key][$record['polaritaet_klasse']]++;
    $bucket[$key]['sum_index'] += (float)$record['polaritaet_index'];
}

$byGroup = [];
$byTime = [];
$byGroupTime = [];

foreach ($records as $r) {
    $gid = $r['gruppe_id'];
    $day = substr((string)$r['zeitpunkt'], 0, 10);
    addAgg($byGroup, (string)$gid, $r, ['gruppe_id' => $gid]);
    addAgg($byTime, $day, $r, ['datum' => $day]);
    addAgg($byGroupTime, $gid . '|' . $day, $r, ['gruppe_id' => $gid, 'datum' => $day]);
}

foreach ([$byGroup, $byTime, $byGroupTime] as &$bucket) {
    foreach ($bucket as &$b) {
        $n = max(1, (int)$b['n']);
        $b['mean_polaritaet_index'] = $b['sum_index'] / $n;
        $b['anteil_positiv'] = $b['positiv'] / $n;
        $b['anteil_negativ'] = $b['negativ'] / $n;
        $b['anteil_neutral'] = $b['neutral'] / $n;
        unset($b['sum_index']);
    }
}

$output = [
    'meta' => [
        'auswertung' => '6.x.4 Polarität',
        'scope' => 'Teilnehmersicht ohne Lehrkraftunterscheidung',
        'quelle' => 'frzk_semantische_dichte_teilnehmer_7d',
        'dimensionen' => $dimensions,
        'n_records' => count($records),
    ],
    'records' => $records,
    'by_group' => array_values($byGroup),
    'by_time' => array_values($byTime),
    'by_group_time' => array_values($byGroupTime),
];

file_put_contents($outFile, json_encode($output, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
echo "OK: {$outFile} (" . count($records) . " Datensätze)\n";
