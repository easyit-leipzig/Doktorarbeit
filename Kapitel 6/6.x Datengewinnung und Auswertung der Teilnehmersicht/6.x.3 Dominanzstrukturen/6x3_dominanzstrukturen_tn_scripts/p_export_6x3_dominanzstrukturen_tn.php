<?php
// ============================================================================
// 6.x.3 Dominanzstrukturen Teilnehmersicht – PHP-Export
// Erzeugt JSON-Auswertungsdaten ohne Lehrkraftunterscheidung aus
// frzk_semantische_dichte_teilnehmer_7d.
// Ausgabe: 6x3_dominanzstrukturen_tn.json
// ============================================================================

header('Content-Type: text/plain; charset=utf-8');
ini_set('display_errors', '1');
error_reporting(E_ALL);
ini_set('memory_limit', '1024M');
set_time_limit(0);

$pdo = new PDO(
    "mysql:host=127.0.0.1;port=3306;dbname=icas_19_4_2;charset=utf8mb4",
    "root",
    "",
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]
);

$outputFile = __DIR__ . DIRECTORY_SEPARATOR . "6x3_dominanzstrukturen_tn.json";
$dimensions = [
    'kognition',
    'sozial',
    'affektiv',
    'motivation',
    'methodik',
    'performanz',
    'regulation',
];

function fnum($value): ?float {
    if ($value === null || $value === '') return null;
    if (!is_numeric($value)) return null;
    $x = (float)$value;
    if (is_nan($x) || is_infinite($x)) return null;
    return $x;
}

function mean_arr(array $values): ?float {
    $values = array_values(array_filter($values, fn($v) => $v !== null));
    return count($values) ? array_sum($values) / count($values) : null;
}

function std_pop_arr(array $values): ?float {
    $values = array_values(array_filter($values, fn($v) => $v !== null));
    $n = count($values);
    if (!$n) return null;
    $m = array_sum($values) / $n;
    $s = 0.0;
    foreach ($values as $v) $s += ($v - $m) * ($v - $m);
    return sqrt($s / $n);
}

function safe_ratio(int $a, int $b): float {
    return $b > 0 ? $a / $b : 0.0;
}

function inc_counter(array &$counter, string $key): void {
    if (!isset($counter[$key])) $counter[$key] = 0;
    $counter[$key]++;
}

function summarize_bucket(array $bucket): array {
    $dims = [];
    $domAbs = [];
    $gaps = [];
    $density = [];
    $wechsel = 0;

    foreach ($bucket as $r) {
        $dim = (string)$r['dominante_dimension'];
        if (!isset($dims[$dim])) $dims[$dim] = 0;
        $dims[$dim]++;
        if ($r['dominanz_abs'] !== null) $domAbs[] = $r['dominanz_abs'];
        if ($r['dominanz_luecke_zur_zweiten_dimension'] !== null) $gaps[] = $r['dominanz_luecke_zur_zweiten_dimension'];
        if ($r['d_semantisch'] !== null) $density[] = $r['d_semantisch'];
        $wechsel += (int)($r['dominanzwechsel'] ?? 0);
    }

    arsort($dims);
    $anteile = [];
    foreach ($dims as $k => $v) $anteile[$k] = safe_ratio($v, count($bucket));

    return [
        'n' => count($bucket),
        'dominante_dimension_haeufigkeit' => $dims,
        'dominante_dimension_anteile' => $anteile,
        'haeufigste_dominanz' => count($dims) ? array_key_first($dims) : null,
        'dominanz_abs_mittel' => mean_arr($domAbs),
        'dominanz_abs_std' => std_pop_arr($domAbs),
        'dominanz_luecke_mittel' => mean_arr($gaps),
        'd_semantisch_mittel' => mean_arr($density),
        'dominanzwechsel_anzahl' => $wechsel,
        'dominanzwechsel_anteil' => safe_ratio($wechsel, count($bucket)),
    ];
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
        dominante_dimension,
        dominante_dimension_wert,
        polaritaet_gesamt,
        d_semantisch,
        drift_norm,
        d_semantisch_delta,
        dominanzwechsel,
        stabilitaet,
        transition_marker,
        emotion_valenz,
        emotion_aktivierung,
        emotion_anzahl
    FROM frzk_semantische_dichte_teilnehmer_7d
    WHERE dominante_dimension IS NOT NULL
    ORDER BY zeitpunkt ASC, gruppe_id ASC, teilnehmer_id ASC, id ASC
";

$rows = $pdo->query($sql)->fetchAll();
$records = [];
$byGroup = [];
$byParticipant = [];
$byDate = [];
$dimensionCounter = [];
$polarityCounter = [];
$dominanceValues = [];
$densityValues = [];
$participants = [];
$groups = [];

foreach ($rows as $r) {
    $dim = strtolower(trim((string)($r['dominante_dimension'] ?? 'unbestimmt')));
    $domValue = fnum($r['dominante_dimension_wert'] ?? null);
    $density = fnum($r['d_semantisch'] ?? null);
    $polarity = (int)(fnum($r['polaritaet_gesamt'] ?? 0) ?? 0);
    $zeitpunkt = (string)$r['zeitpunkt'];
    $dateKey = substr($zeitpunkt, 0, 10);

    $dimensionValues = [];
    $absValues = [];
    foreach ($dimensions as $d) {
        $v = fnum($r['x_' . $d] ?? null);
        $dimensionValues[$d] = $v;
        if ($v !== null) $absValues[$d] = abs($v);
    }
    arsort($absValues);
    $absList = array_values($absValues);
    $secondValue = count($absList) > 1 ? $absList[1] : null;
    $gap = ($domValue !== null && $secondValue !== null) ? abs($domValue) - $secondValue : null;

    $rec = [
        'id' => (int)$r['id'],
        'rueckkopplung_teilnehmer_id' => $r['rueckkopplung_teilnehmer_id'] !== null ? (int)$r['rueckkopplung_teilnehmer_id'] : null,
        'teilnehmer_id' => $r['teilnehmer_id'] !== null ? (int)$r['teilnehmer_id'] : null,
        'gruppe_id' => $r['gruppe_id'] !== null ? (int)$r['gruppe_id'] : null,
        'zeitpunkt' => $zeitpunkt,
        'datum' => $dateKey,
        'dominante_dimension' => $dim,
        'dominante_dimension_wert' => $domValue,
        'dominanz_abs' => $domValue !== null ? abs($domValue) : null,
        'dominanz_luecke_zur_zweiten_dimension' => $gap,
        'polaritaet_gesamt' => $polarity,
        'd_semantisch' => $density,
        'drift_norm' => fnum($r['drift_norm'] ?? null),
        'd_semantisch_delta' => fnum($r['d_semantisch_delta'] ?? null),
        'dominanzwechsel' => (int)(fnum($r['dominanzwechsel'] ?? 0) ?? 0),
        'stabilitaet' => fnum($r['stabilitaet'] ?? null),
        'transition_marker' => $r['transition_marker'] ?? null,
        'emotion_valenz' => fnum($r['emotion_valenz'] ?? null),
        'emotion_aktivierung' => fnum($r['emotion_aktivierung'] ?? null),
        'emotion_anzahl' => (int)(fnum($r['emotion_anzahl'] ?? 0) ?? 0),
        'dimensionen' => $dimensionValues,
    ];

    $records[] = $rec;
    $gid = (string)($rec['gruppe_id'] ?? 0);
    $tid = (string)($rec['teilnehmer_id'] ?? 0);
    if (!isset($byGroup[$gid])) $byGroup[$gid] = [];
    if (!isset($byParticipant[$tid])) $byParticipant[$tid] = [];
    if (!isset($byDate[$dateKey])) $byDate[$dateKey] = [];
    $byGroup[$gid][] = $rec;
    $byParticipant[$tid][] = $rec;
    $byDate[$dateKey][] = $rec;

    inc_counter($dimensionCounter, $dim);
    inc_counter($polarityCounter, (string)$polarity);
    if ($domValue !== null) $dominanceValues[] = abs($domValue);
    if ($density !== null) $densityValues[] = $density;
    if ($rec['teilnehmer_id'] !== null) $participants[(string)$rec['teilnehmer_id']] = true;
    if ($rec['gruppe_id'] !== null) $groups[(string)$rec['gruppe_id']] = true;
}

ksort($byGroup, SORT_NATURAL);
ksort($byParticipant, SORT_NATURAL);
ksort($byDate, SORT_NATURAL);
ksort($dimensionCounter, SORT_NATURAL);
$total = count($records);

$dimensionShares = [];
foreach ($dimensionCounter as $k => $v) $dimensionShares[$k] = safe_ratio($v, $total);

$export = [
    'metadata' => [
        'auswertungspunkt' => '6.x.3 Dominanzstrukturen',
        'perspektive' => 'Teilnehmersicht',
        'lehrkraftunterscheidung' => false,
        'quelle' => 'frzk_semantische_dichte_teilnehmer_7d',
        'created_at' => date('c'),
        'beschreibung' => 'Dominante Dimension und Dominanzwert je Teilnehmerzustand, aggregiert ohne Lehrkraftunterscheidung.',
        'dimensionen' => $dimensions,
    ],
    'summary' => [
        'n_zustaende' => $total,
        'n_teilnehmer' => count($participants),
        'n_gruppen' => count($groups),
        'dominante_dimension_haeufigkeit' => $dimensionCounter,
        'dominante_dimension_anteile' => $dimensionShares,
        'dominanz_abs_mittel' => mean_arr($dominanceValues),
        'dominanz_abs_std' => std_pop_arr($dominanceValues),
        'd_semantisch_mittel' => mean_arr($densityValues),
        'polaritaet_haeufigkeit' => $polarityCounter,
    ],
    'by_group' => array_map('summarize_bucket', $byGroup),
    'by_participant' => array_map('summarize_bucket', $byParticipant),
    'by_date' => array_map('summarize_bucket', $byDate),
    'records' => $records,
];

file_put_contents(
    $outputFile,
    json_encode($export, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)
);

echo "Export abgeschlossen: {$outputFile}\n";
echo "Datensätze: {$total}\n";
