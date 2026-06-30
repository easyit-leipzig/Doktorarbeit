<?php
/**
 * 6.x.10 Emergente Gruppenmuster – Exportskript (PHP)
 * Erzeugt eine JSON-Datei ohne Lehrkraftunterscheidung.
 */

declare(strict_types=1);

$DB_HOST = '127.0.0.1';
$DB_PORT = 3306;
$DB_NAME = 'icas_19_4_2';
$DB_USER = 'root';
$DB_PASS = '';
$OUTFILE = '6x10_emergente_gruppenmuster.json';
$DIMENSIONS = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];

function f_or_null($v): ?float {
    if ($v === null || $v === '') return null;
    return is_numeric($v) ? (float)$v : null;
}
function i_or_null($v): ?int {
    if ($v === null || $v === '') return null;
    return is_numeric($v) ? (int)$v : null;
}
function parse_emotions($raw): array {
    if ($raw === null || trim((string)$raw) === '') return [];
    $out = [];
    foreach (preg_split('/[,;]/', (string)$raw) as $p) {
        $p = trim($p);
        if (ctype_digit($p)) $out[] = (int)$p;
    }
    return $out;
}
function mean_val(array $values): ?float {
    $clean = array_values(array_filter($values, fn($v) => $v !== null && is_finite((float)$v)));
    if (!$clean) return null;
    return array_sum($clean) / count($clean);
}
function vector_from_row(array $r, array $dims): array {
    $v = [];
    foreach ($dims as $d) $v[] = f_or_null($r['x_'.$d] ?? null) ?? 0.0;
    return $v;
}
function euclidean(array $a, array $b): float {
    $s = 0.0;
    foreach ($a as $i => $x) $s += ($x - $b[$i]) ** 2;
    return sqrt($s);
}
function cosine(array $a, array $b): ?float {
    $dot = $na = $nb = 0.0;
    foreach ($a as $i => $x) { $dot += $x * $b[$i]; $na += $x*$x; $nb += $b[$i]*$b[$i]; }
    if ($na <= 0 || $nb <= 0) return null;
    return $dot / (sqrt($na) * sqrt($nb));
}

$pdo = new PDO("mysql:host=$DB_HOST;port=$DB_PORT;dbname=$DB_NAME;charset=utf8mb4", $DB_USER, $DB_PASS, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$sql = "
SELECT
    gruppe_id, teilnehmer_id, teilnehmer_feedback_id, teilnehmer_datum, erfasst_am, emotions,
    id_mtr_rueckkopplung_datenmaske, datum, satzanzahl,
    mean_kognition, mean_sozial, mean_affektiv, mean_motivation, mean_methodik, mean_performanz, mean_regulation,
    var_kognition, var_sozial, var_affektiv, var_motivation, var_methodik, var_performanz, var_regulation,
    d_semantisch_mean, d_semantisch_std, semantische_breite, dominanz_breite,
    sdlg_id, sdlg_type, sdlg_ue_id,
    x_kognition, x_sozial, x_affektiv, x_motivation, x_methodik, x_performanz, x_regulation,
    dominante_dimension, dominante_dimension_wert, polaritaet_gesamt, d_semantisch,
    token_anzahl, funktionsklassen_anzahl_gesamt
FROM match_tn_daten_analyze_lehrkraft
WHERE gruppe_id IS NOT NULL AND sdlg_type = 1
ORDER BY gruppe_id, datum, teilnehmer_id, sdlg_id";
$rows = $pdo->query($sql)->fetchAll();

$emotionRows = $pdo->query("SELECT id, type_name, fine_label, emotion, valenz, aktivierung FROM _mtr_emotionen")->fetchAll();
$emotions = [];
foreach ($emotionRows as $e) $emotions[(int)$e['id']] = $e;

$byGroup = [];
foreach ($rows as $r) {
    $gid = i_or_null($r['gruppe_id']);
    if ($gid !== null) $byGroup[$gid][] = $r;
}
ksort($byGroup);

$groups = [];
$allVectors = [];
$globalDominance = [];
$globalEmotions = [];

foreach ($byGroup as $gid => $items) {
    $vectors = array_map(fn($r) => vector_from_row($r, $DIMENSIONS), $items);
    foreach ($vectors as $v) $allVectors[] = $v;
    $centroid = [];
    foreach ($DIMENSIONS as $idx => $d) $centroid[$d] = mean_val(array_map(fn($v) => $v[$idx], $vectors)) ?? 0.0;

    $dominanceCounts = [];
    foreach ($items as $r) {
        $dd = $r['dominante_dimension'] ?: 'unbekannt';
        $dominanceCounts[$dd] = ($dominanceCounts[$dd] ?? 0) + 1;
        $globalDominance[$dd] = ($globalDominance[$dd] ?? 0) + 1;
    }

    $dates = array_map(fn($r) => (string)($r['datum'] ?: $r['teilnehmer_datum']), $items);
    $drift = [];
    for ($i=1; $i<count($vectors); $i++) {
        $drift[] = [
            'from_index' => $i-1,
            'to_index' => $i,
            'from_date' => $dates[$i-1],
            'to_date' => $dates[$i],
            'euclidean_drift' => euclidean($vectors[$i-1], $vectors[$i]),
            'cosine_similarity' => cosine($vectors[$i-1], $vectors[$i]),
        ];
    }

    $pairCos = [];
    for ($i=0; $i<count($vectors); $i++) {
        for ($j=$i+1; $j<min(count($vectors), $i+51); $j++) {
            $c = cosine($vectors[$i], $vectors[$j]);
            if ($c !== null) $pairCos[] = $c;
        }
    }
    $emotionCounts = [];
    $emotionVals = [];
    $emotionActs = [];
    foreach ($items as $r) {
        foreach (parse_emotions($r['emotions']) as $eid) {
            if (!isset($emotions[$eid])) continue;
            $emotionCounts[(string)$eid] = ($emotionCounts[(string)$eid] ?? 0) + 1;
            $globalEmotions[(string)$eid] = ($globalEmotions[(string)$eid] ?? 0) + 1;
            $emotionVals[] = f_or_null($emotions[$eid]['valenz']) ?? 0.0;
            $emotionActs[] = f_or_null($emotions[$eid]['aktivierung']) ?? 0.0;
        }
    }

    $dominantAxis = null; $maxAbs = -1;
    foreach ($centroid as $d => $v) { if (abs($v) > $maxAbs) { $maxAbs = abs($v); $dominantAxis = $d; } }

    $groups[(string)$gid] = [
        'gruppe_id' => $gid,
        'n_records' => count($items),
        'n_participants' => count(array_unique(array_map(fn($r) => $r['teilnehmer_id'], $items))),
        'date_min' => min($dates),
        'date_max' => max($dates),
        'centroid_7d' => $centroid,
        'dominant_axis' => $dominantAxis,
        'mean_d_semantisch' => mean_val(array_map(fn($r) => f_or_null($r['d_semantisch']), $items)),
        'mean_d_semantisch_mean' => mean_val(array_map(fn($r) => f_or_null($r['d_semantisch_mean']), $items)),
        'mean_semantische_breite' => mean_val(array_map(fn($r) => f_or_null($r['semantische_breite']), $items)),
        'mean_dominanz_breite' => mean_val(array_map(fn($r) => f_or_null($r['dominanz_breite']), $items)),
        'mean_polaritaet' => mean_val(array_map(fn($r) => f_or_null($r['polaritaet_gesamt']), $items)),
        'dominance_counts' => $dominanceCounts,
        'drift' => $drift,
        'drift_summary' => [
            'mean_euclidean_drift' => mean_val(array_map(fn($d) => $d['euclidean_drift'], $drift)),
            'mean_cosine_transition' => mean_val(array_map(fn($d) => $d['cosine_similarity'], $drift)),
        ],
        'attractor_summary' => [
            'mean_pairwise_cosine_limited_window' => mean_val($pairCos),
            'share_cosine_ge_0_95' => count($pairCos) ? count(array_filter($pairCos, fn($c) => $c >= 0.95)) / count($pairCos) : null,
            'n_pairwise_cosine' => count($pairCos),
        ],
        'emotion_summary' => [
            'emotion_counts' => $emotionCounts,
            'mean_valenz' => mean_val($emotionVals),
            'mean_aktivierung' => mean_val($emotionActs),
            'n_emotion_mentions' => array_sum($emotionCounts),
        ],
        'records' => array_map(function($r) use ($DIMENSIONS) {
            return [
                'gruppe_id' => i_or_null($r['gruppe_id']),
                'teilnehmer_id' => i_or_null($r['teilnehmer_id']),
                'datum' => (string)($r['datum'] ?: $r['teilnehmer_datum']),
                'vector_7d' => array_combine($DIMENSIONS, vector_from_row($r, $DIMENSIONS)),
                'dominante_dimension' => $r['dominante_dimension'],
                'dominante_dimension_wert' => f_or_null($r['dominante_dimension_wert']),
                'polaritaet_gesamt' => i_or_null($r['polaritaet_gesamt']),
                'd_semantisch' => f_or_null($r['d_semantisch']),
                'emotions' => parse_emotions($r['emotions']),
            ];
        }, $items),
    ];
}

$globalCentroid = [];
foreach ($DIMENSIONS as $idx => $d) $globalCentroid[$d] = mean_val(array_map(fn($v) => $v[$idx], $allVectors)) ?? 0.0;
$emotionLookup = [];
foreach ($emotions as $id => $e) {
    $emotionLookup[(string)$id] = [
        'emotion' => $e['emotion'], 'type_name' => $e['type_name'], 'fine_label' => $e['fine_label'],
        'valenz' => f_or_null($e['valenz']), 'aktivierung' => f_or_null($e['aktivierung'])
    ];
}

$out = [
    'meta' => [
        'auswertung' => '6.x.10 Emergente Gruppenmuster',
        'created_at' => date('c'),
        'database' => $DB_NAME,
        'source_view' => 'match_tn_daten_analyze_lehrkraft',
        'source_emotions' => '_mtr_emotionen',
        'lehrkraftunterscheidung' => false,
        'dimensions' => $DIMENSIONS,
        'description' => 'Gruppenbezogene Emergenzanalyse aus 7D-Vektoren, Dominanzachsen, Drift, Attraktorähnlichkeit und Emotionsclustern.'
    ],
    'global_summary' => [
        'n_records' => count($rows),
        'n_groups' => count($groups),
        'global_centroid_7d' => $globalCentroid,
        'global_dominance_counts' => $globalDominance,
        'global_emotion_counts' => $globalEmotions,
    ],
    'groups' => $groups,
    'emotion_lookup' => $emotionLookup,
];

file_put_contents($OUTFILE, json_encode($out, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
echo "OK: $OUTFILE geschrieben\n";
echo "Datensätze: ".count($rows)." | Gruppen: ".count($groups)."\n";
