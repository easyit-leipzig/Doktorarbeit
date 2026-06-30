<?php
// ============================================================================
// 6.x.2 Semantische Dichte – Teilnehmersicht – PHP-Export
//
// Exportiert die 7D-Teilnehmerzustände aus frzk_semantische_dichte_teilnehmer_7d
// in dieselbe JSON-Struktur wie das Python-Exportskript.
//
// Ziel-JSON: 6x2_semantische_dichte_tn.json
// ============================================================================

header('Content-Type: text/plain; charset=utf-8');
ini_set('display_errors', '1');
error_reporting(E_ALL);
ini_set('memory_limit', '1024M');
set_time_limit(0);

$outFile = $argv[1] ?? __DIR__ . DIRECTORY_SEPARATOR . '6x2_semantische_dichte_tn.json';
$includeGroupZero = in_array('--include-group-zero', $argv, true);

$dimensions = [
    'kognition',
    'sozial',
    'affektiv',
    'motivation',
    'methodik',
    'performanz',
    'regulation',
];

$pdo = new PDO(
    'mysql:host=127.0.0.1;port=3306;dbname=icas_19_4_2;charset=utf8mb4',
    'root',
    '',
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]
);

function fnum($value): ?float
{
    if ($value === null || $value === '') {
        return null;
    }
    if (!is_numeric($value)) {
        return null;
    }
    $v = (float)$value;
    if (is_nan($v) || is_infinite($v)) {
        return null;
    }
    return $v;
}

function quantile(array $values, float $q): float
{
    $values = array_values(array_filter($values, fn($v) => $v !== null));
    sort($values, SORT_NUMERIC);
    $n = count($values);
    if ($n === 0) {
        return 0.0;
    }
    $pos = ($n - 1) * $q;
    $lo = (int)floor($pos);
    $hi = (int)ceil($pos);
    if ($lo === $hi) {
        return (float)$values[$lo];
    }
    return (float)($values[$lo] + ($values[$hi] - $values[$lo]) * ($pos - $lo));
}

function densityClass(?float $value, float $q33, float $q66): string
{
    if ($value === null) {
        return 'ohne Dichtewert';
    }
    if ($value < $q33) {
        return 'Leerstelle / geringe Dichte';
    }
    if ($value < $q66) {
        return 'mittlere Dichte';
    }
    return 'Verdichtung / hohe Dichte';
}

function meanVal(array $values): ?float
{
    $values = array_values(array_filter($values, fn($v) => $v !== null));
    if (count($values) === 0) {
        return null;
    }
    return array_sum($values) / count($values);
}

function stdPop(array $values): ?float
{
    $values = array_values(array_filter($values, fn($v) => $v !== null));
    $n = count($values);
    if ($n === 0) {
        return null;
    }
    if ($n === 1) {
        return 0.0;
    }
    $m = array_sum($values) / $n;
    $s = 0.0;
    foreach ($values as $v) {
        $s += ($v - $m) * ($v - $m);
    }
    return sqrt($s / $n);
}

function tableExists(PDO $pdo, string $table): bool
{
    $stmt = $pdo->prepare('SHOW TABLES LIKE ?');
    $stmt->execute([$table]);
    return $stmt->fetch() !== false;
}

$where = 'WHERE gruppe_id IS NOT NULL';
if (!$includeGroupZero) {
    $where .= ' AND gruppe_id <> 0';
}

$sql = "
    SELECT
        id,
        rueckkopplung_teilnehmer_id,
        ue_id,
        ue_zuweisung_teilnehmer_id,
        teilnehmer_id,
        gruppe_id,
        zeitpunkt,
        x_kognition,
        x_sozial,
        x_affektiv,
        x_motivation,
        x_methodik,
        x_performanz,
        x_regulation,
        sum_kognition,
        sum_sozial,
        sum_affektiv,
        sum_motivation,
        sum_methodik,
        sum_performanz,
        sum_regulation,
        emotion_ids,
        emotion_valenz,
        emotion_aktivierung,
        emotion_anzahl,
        dominante_dimension,
        dominante_dimension_wert,
        polaritaet_gesamt,
        d_semantisch,
        drift_norm,
        d_semantisch_delta,
        dominanzwechsel,
        stabilitaet,
        transition_marker
    FROM frzk_semantische_dichte_teilnehmer_7d
    $where
    ORDER BY gruppe_id ASC, zeitpunkt ASC, teilnehmer_id ASC, id ASC
";

$raw = $pdo->query($sql)->fetchAll();
$hVals = [];
foreach ($raw as $r) {
    $hVals[] = fnum($r['d_semantisch'] ?? null);
}
$q33 = quantile($hVals, 0.33);
$q66 = quantile($hVals, 0.66);

$rows = [];
foreach ($raw as $r) {
    $vec = [];
    $sumSq = 0.0;
    foreach ($dimensions as $dim) {
        $v = fnum($r['x_' . $dim] ?? null);
        $vec[$dim] = $v;
        $sumSq += ($v ?? 0.0) * ($v ?? 0.0);
    }
    $dCalc = sqrt($sumSq);
    $dRaw = fnum($r['d_semantisch'] ?? null);
    $hT = $dRaw ?? $dCalc;

    $r['vector_7d'] = $vec;
    $r['h_T'] = $hT;
    $r['h_T_berechnet'] = $dCalc;
    $r['dichteklasse'] = densityClass($hT, $q33, $q66);
    $r['zeitpunkt_iso'] = !empty($r['zeitpunkt']) ? date('c', strtotime($r['zeitpunkt'])) : null;
    $rows[] = $r;
}

$byGroupDate = [];
foreach ($rows as $r) {
    $date = substr((string)($r['zeitpunkt_iso'] ?? $r['zeitpunkt'] ?? ''), 0, 10);
    $key = (int)$r['gruppe_id'] . '|' . $date;
    if (!isset($byGroupDate[$key])) {
        $byGroupDate[$key] = [];
    }
    $byGroupDate[$key][] = $r;
}
ksort($byGroupDate);

$gruppenZeit = [];
foreach ($byGroupDate as $key => $items) {
    [$gid, $date] = explode('|', $key, 2);
    $dimMeans = [];
    $dimStd = [];
    foreach ($dimensions as $dim) {
        $vals = [];
        foreach ($items as $i) {
            $vals[] = fnum($i['vector_7d'][$dim] ?? null);
        }
        $dimMeans[$dim] = meanVal($vals);
        $dimStd[$dim] = stdPop($vals);
    }
    $dVals = array_map(fn($i) => fnum($i['h_T'] ?? null), $items);
    $teilnehmerIds = array_values(array_unique(array_map(fn($i) => (int)$i['teilnehmer_id'], $items)));
    sort($teilnehmerIds, SORT_NUMERIC);

    $dominant = $dimensions[0];
    foreach ($dimensions as $dim) {
        if (abs($dimMeans[$dim] ?? 0.0) > abs($dimMeans[$dominant] ?? 0.0)) {
            $dominant = $dim;
        }
    }

    $gruppenZeit[] = [
        'gruppe_id' => (int)$gid,
        'datum' => $date,
        'n' => count($items),
        'teilnehmer_ids' => $teilnehmerIds,
        'h_T_mean' => meanVal($dVals),
        'h_T_std' => stdPop($dVals),
        'h_T_min' => count(array_filter($dVals, fn($v) => $v !== null)) ? min(array_filter($dVals, fn($v) => $v !== null)) : null,
        'h_T_max' => count(array_filter($dVals, fn($v) => $v !== null)) ? max(array_filter($dVals, fn($v) => $v !== null)) : null,
        'dimensions_mean' => $dimMeans,
        'dimensions_std' => $dimStd,
        'dominante_dimension_gruppe' => $dominant,
    ];
}

$byGroup = [];
foreach ($rows as $r) {
    $gid = (int)$r['gruppe_id'];
    if (!isset($byGroup[$gid])) {
        $byGroup[$gid] = [];
    }
    $byGroup[$gid][] = $r;
}
ksort($byGroup);

$gruppenAgg = [];
foreach ($byGroup as $gid => $items) {
    $dimMeans = [];
    foreach ($dimensions as $dim) {
        $vals = [];
        foreach ($items as $i) {
            $vals[] = fnum($i['vector_7d'][$dim] ?? null);
        }
        $dimMeans[$dim] = meanVal($vals);
    }
    $dVals = array_map(fn($i) => fnum($i['h_T'] ?? null), $items);
    $teilnehmerIds = array_values(array_unique(array_map(fn($i) => (int)$i['teilnehmer_id'], $items)));

    $dominant = $dimensions[0];
    foreach ($dimensions as $dim) {
        if (abs($dimMeans[$dim] ?? 0.0) > abs($dimMeans[$dominant] ?? 0.0)) {
            $dominant = $dim;
        }
    }

    $validD = array_values(array_filter($dVals, fn($v) => $v !== null));
    $gruppenAgg[] = [
        'gruppe_id' => (int)$gid,
        'n' => count($items),
        'n_teilnehmer' => count($teilnehmerIds),
        'h_T_mean' => meanVal($dVals),
        'h_T_std' => stdPop($dVals),
        'h_T_min' => count($validD) ? min($validD) : null,
        'h_T_max' => count($validD) ? max($validD) : null,
        'dimensions_mean' => $dimMeans,
        'dominante_dimension_gruppe' => $dominant,
    ];
}

$existingGroupRows = [];
if (tableExists($pdo, 'frzk_group_semantische_dichte_7d')) {
    $existingGroupRows = $pdo->query('SELECT * FROM frzk_group_semantische_dichte_7d ORDER BY gruppe_id ASC')->fetchAll();
}

$payload = [
    'metadata' => [
        'kapitel' => '6.x.2',
        'titel' => 'Semantische Dichte – Teilnehmersicht im 7D-FRZK-Raum',
        'generated_at' => date('c'),
        'source_table' => 'frzk_semantische_dichte_teilnehmer_7d',
        'group_table_optional' => 'frzk_group_semantische_dichte_7d',
        'exclude_group_zero' => !$includeGroupZero,
        'dimensions' => $dimensions,
        'definition' => 'h(T)=||T||_2 bzw. d_semantisch, sofern in der Datenbank vorhanden',
        'density_quantiles' => ['q33' => $q33, 'q66' => $q66],
        'record_count' => count($rows),
    ],
    'teilnehmer_zustaende' => $rows,
    'gruppen_zeit_aggregation' => $gruppenZeit,
    'gruppen_aggregation' => $gruppenAgg,
    'frzk_group_semantische_dichte_7d_existing' => $existingGroupRows,
];

$json = json_encode($payload, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
if ($json === false) {
    throw new RuntimeException('JSON konnte nicht erzeugt werden: ' . json_last_error_msg());
}
file_put_contents($outFile, $json);
echo "OK: " . count($rows) . " Datensätze exportiert: $outFile\n";
