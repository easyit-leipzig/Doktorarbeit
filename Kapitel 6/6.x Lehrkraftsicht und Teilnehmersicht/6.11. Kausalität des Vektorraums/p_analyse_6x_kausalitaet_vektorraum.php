<?php
/**
 * Analyse 6.x Kausalität des FRZK-Vektorraums
 *
 * Liest die JSON-Datei aus export_6x_kausalitaet_vektorraum.php und erzeugt:
 *  - Markdown-Berichte
 *  - CSV-Tabellen
 *  - SVG-Grafiken
 *
 * Nutzung:
 *   php analyse_6x_kausalitaet_vektorraum.php --input=6x_kausalitaet_vektorraum_export.json --outdir=6x_kausalitaet_vektorraum_output
 */

$DIMENSIONS = ['kognition', 'sozial', 'affektiv', 'motivation', 'methodik', 'performanz', 'regulation'];
$RATING_FIELDS = [
    'mitarbeit', 'absprachen', 'selbststaendigkeit', 'konzentration', 'fleiss', 'lernfortschritt',
    'beherrscht_thema', 'transferdenken', 'basiswissen', 'vorbereitet', 'themenauswahl', 'materialien',
    'methodenvielfalt', 'individualisierung', 'aufforderung', 'zielgruppen'
];
$POSITIVE_RATING_DIRECTION = -1.0;

function cli_option(string $name, $default = null) {
    foreach ($_SERVER['argv'] as $arg) {
        if (strpos($arg, "--$name=") === 0) return substr($arg, strlen($name) + 3);
    }
    return $default;
}

function sf($value, $default = null) {
    if ($value === null || $value === '') return $default;
    return is_numeric($value) ? floatval($value) : $default;
}

function norm_vec(array $v): float {
    $s = 0.0;
    foreach ($v as $x) $s += floatval($x) * floatval($x);
    return sqrt($s);
}

function cosine(array $a, array $b): ?float {
    if (!$a || !$b || count($a) !== count($b)) return null;
    $na = norm_vec($a); $nb = norm_vec($b);
    if ($na == 0.0 || $nb == 0.0) return null;
    $s = 0.0;
    for ($i = 0; $i < count($a); $i++) $s += $a[$i] * $b[$i];
    return $s / ($na * $nb);
}

function euclidean(array $a, array $b): ?float {
    if (!$a || !$b || count($a) !== count($b)) return null;
    $s = 0.0;
    for ($i = 0; $i < count($a); $i++) $s += pow($a[$i] - $b[$i], 2);
    return sqrt($s);
}

function arr_mean(array $v): ?float {
    $vals = array_values(array_filter($v, fn($x) => $x !== null && !is_nan(floatval($x))));
    return count($vals) ? array_sum($vals) / count($vals) : null;
}

function arr_std(array $v): ?float {
    $vals = array_values(array_filter($v, fn($x) => $x !== null && !is_nan(floatval($x))));
    $n = count($vals);
    if ($n < 2) return null;
    $m = array_sum($vals) / $n;
    $s = 0.0;
    foreach ($vals as $x) $s += pow($x - $m, 2);
    return sqrt($s / ($n - 1));
}

function percentile(array $v, float $p): ?float {
    $vals = array_values(array_filter($v, fn($x) => $x !== null && !is_nan(floatval($x))));
    sort($vals);
    if (!count($vals)) return null;
    $k = (count($vals) - 1) * $p;
    $f = floor($k); $c = ceil($k);
    if ($f == $c) return $vals[intval($k)];
    return $vals[$f] + ($vals[$c] - $vals[$f]) * ($k - $f);
}

function pearson(array $x, array $y): ?float {
    $pairs = [];
    for ($i = 0; $i < min(count($x), count($y)); $i++) {
        if ($x[$i] !== null && $y[$i] !== null) $pairs[] = [$x[$i], $y[$i]];
    }
    if (count($pairs) < 3) return null;
    $xs = array_column($pairs, 0); $ys = array_column($pairs, 1);
    $mx = arr_mean($xs); $my = arr_mean($ys);
    $sx = 0.0; $sy = 0.0; $sxy = 0.0;
    foreach ($pairs as [$a, $b]) {
        $sx += pow($a - $mx, 2); $sy += pow($b - $my, 2); $sxy += ($a - $mx) * ($b - $my);
    }
    if ($sx == 0.0 || $sy == 0.0) return null;
    return $sxy / sqrt($sx * $sy);
}

function frzk_vector(array $row, array $dims): array {
    if (isset($row['_derived']['lk_vector']) && is_array($row['_derived']['lk_vector'])) {
        return array_map(fn($x) => sf($x, 0.0), $row['_derived']['lk_vector']);
    }
    $v = [];
    foreach ($dims as $d) $v[] = sf($row['x_' . $d] ?? null, 0.0);
    return $v;
}

function rating_vector(array $row, array $fields, float $dir): array {
    $v = [];
    foreach ($fields as $field) {
        $x = sf($row[$field] ?? null, null);
        if ($x !== null) $v[] = $dir * (($x - 2.5) / 2.5);
    }
    return $v;
}

function participant_target_vector(array $row, array $dims, float $dir): array {
    $mapping = [
        'kognition' => ['beherrscht_thema', 'transferdenken', 'basiswissen', 'lernfortschritt'],
        'sozial' => ['mitarbeit', 'absprachen', 'zielgruppen'],
        'affektiv' => ['emotions'],
        'motivation' => ['fleiss', 'mitarbeit', 'lernfortschritt'],
        'methodik' => ['methodenvielfalt', 'materialien', 'themenauswahl', 'individualisierung'],
        'performanz' => ['lernfortschritt', 'beherrscht_thema', 'basiswissen'],
        'regulation' => ['selbststaendigkeit', 'konzentration', 'vorbereitet', 'aufforderung'],
    ];
    $out = [];
    foreach ($dims as $dim) {
        $vals = [];
        foreach ($mapping[$dim] as $field) {
            if ($field === 'emotions') {
                $ids = $row['_derived']['emotion_ids'] ?? [];
                $vals[] = count($ids) ? min(count($ids), 5) / 5.0 : 0.0;
            } else {
                $x = sf($row[$field] ?? null, null);
                if ($x !== null) $vals[] = $dir * (($x - 2.5) / 2.5);
            }
        }
        $out[] = arr_mean($vals) ?? 0.0;
    }
    return $out;
}

function dominant(array $v, array $dims): ?string {
    if (!$v) return null;
    $best = 0;
    for ($i = 1; $i < count($v); $i++) if (abs($v[$i]) > abs($v[$best])) $best = $i;
    return $dims[$best] ?? null;
}

function polarity(array $v): int {
    $s = array_sum($v);
    if ($s > 0) return 1;
    if ($s < 0) return -1;
    return 0;
}

function pairs_for_lag(array $rows, int $lag): array {
    usort($rows, fn($a, $b) => [strval($a['teilnehmer_id'] ?? ''), strval($a['teilnehmer_datum'] ?? ''), strval($a['sdlg_id'] ?? '')] <=> [strval($b['teilnehmer_id'] ?? ''), strval($b['teilnehmer_datum'] ?? ''), strval($b['sdlg_id'] ?? '')]);
    $by = [];
    foreach ($rows as $r) $by[strval($r['teilnehmer_id'] ?? '')][] = $r;
    $pairs = [];
    foreach ($by as $seq) {
        $unique = []; $seen = [];
        foreach ($seq as $r) {
            $key = strval($r['teilnehmer_datum'] ?? '') . '_' . strval($r['id_mtr_rueckkopplung_datenmaske'] ?? '');
            if (!isset($seen[$key])) { $unique[] = $r; $seen[$key] = true; }
        }
        for ($i = 0; $i < count($unique) - $lag; $i++) $pairs[] = [$unique[$i], $unique[$i + $lag]];
    }
    return $pairs;
}

function lag_metrics(array $rows, int $maxLag, array $dims, float $dir): array {
    $result = [];
    for ($lag = 0; $lag <= $maxLag; $lag++) {
        $cos = []; $dist = []; $dom = []; $pol = [];
        $pairs = pairs_for_lag($rows, $lag);
        foreach ($pairs as [$a, $b]) {
            $lv = frzk_vector($a, $dims);
            $tv = participant_target_vector($b, $dims, $dir);
            $c = cosine($lv, $tv); if ($c !== null) $cos[] = $c;
            $d = euclidean($lv, $tv); if ($d !== null) $dist[] = $d;
            $dom[] = dominant($lv, $dims) === dominant($tv, $dims) ? 1 : 0;
            $pol[] = polarity($lv) === polarity($tv) ? 1 : 0;
        }
        $result[] = [
            'lag' => $lag,
            'n_pairs' => count($pairs),
            'cosine_mean' => arr_mean($cos),
            'cosine_std' => arr_std($cos),
            'distance_mean' => arr_mean($dist),
            'dominance_accuracy' => arr_mean($dom),
            'polarity_accuracy' => arr_mean($pol),
        ];
    }
    return $result;
}

function permutation_test(array $rows, int $lag, int $nPerm, array $dims, float $dir): array {
    $pairs = pairs_for_lag($rows, $lag);
    $realVals = [];
    $targetVectors = [];
    foreach ($pairs as [$a, $b]) {
        $tv = participant_target_vector($b, $dims, $dir);
        $targetVectors[] = $tv;
        $c = cosine(frzk_vector($a, $dims), $tv);
        if ($c !== null) $realVals[] = $c;
    }
    $realMean = arr_mean($realVals);
    $nullMeans = [];
    for ($p = 0; $p < $nPerm; $p++) {
        $shuffled = $targetVectors;
        shuffle($shuffled);
        $vals = [];
        foreach ($pairs as $i => $pair) {
            $c = cosine(frzk_vector($pair[0], $dims), $shuffled[$i]);
            if ($c !== null) $vals[] = $c;
        }
        $m = arr_mean($vals);
        if ($m !== null) $nullMeans[] = $m;
    }
    $pValue = null; $z = null;
    if ($realMean !== null && count($nullMeans)) {
        $extreme = 0;
        foreach ($nullMeans as $x) if ($x >= $realMean) $extreme++;
        $pValue = ($extreme + 1) / (count($nullMeans) + 1);
        $sd = arr_std($nullMeans) ?? 0.0;
        if ($sd > 0) $z = ($realMean - arr_mean($nullMeans)) / $sd;
    }
    return [
        'lag' => $lag,
        'n_pairs' => count($pairs),
        'n_permutations' => count($nullMeans),
        'real_cosine_mean' => $realMean,
        'null_cosine_mean' => arr_mean($nullMeans),
        'null_p95' => percentile($nullMeans, 0.95),
        'null_p99' => percentile($nullMeans, 0.99),
        'z_score' => $z,
        'p_value_right_tail' => $pValue,
    ];
}

function simple_predict(array $trainX, array $trainY, array $testX): array {
    if (!count($trainX) || !count($trainY)) return array_fill(0, count($testX), 0.0);
    $yMean = arr_mean($trainY) ?? 0.0;
    $weights = [];
    for ($j = 0; $j < count($trainX[0]); $j++) {
        $col = [];
        foreach ($trainX as $x) $col[] = $x[$j] ?? 0.0;
        $weights[] = pearson($col, $trainY) ?? 0.0;
    }
    $den = array_sum(array_map('abs', $weights));
    if ($den == 0.0) $den = 1.0;
    $pred = [];
    foreach ($testX as $x) {
        $s = 0.0;
        foreach ($weights as $j => $w) $s += $w * ($x[$j] ?? 0.0);
        $pred[] = $yMean + $s / $den;
    }
    return $pred;
}

function metrics(array $pred, array $obs): array {
    $abs = []; $sq = [];
    for ($i = 0; $i < count($obs); $i++) { $e = $pred[$i] - $obs[$i]; $abs[] = abs($e); $sq[] = $e * $e; }
    $mae = arr_mean($abs); $rmse = sqrt(arr_mean($sq) ?? 0.0);
    $ybar = arr_mean($obs) ?? 0.0;
    $ssRes = 0.0; $ssTot = 0.0;
    for ($i = 0; $i < count($obs); $i++) { $ssRes += pow($pred[$i] - $obs[$i], 2); $ssTot += pow($obs[$i] - $ybar, 2); }
    return ['MAE' => $mae, 'RMSE' => $rmse, 'R2' => $ssTot > 0 ? 1 - $ssRes / $ssTot : null, 'corr_pred_observed' => pearson($pred, $obs)];
}

function prediction_comparison(array $rows, int $lag, array $dims, array $ratingFields, float $dir): array {
    $pairs = pairs_for_lag($rows, $lag);
    $data = [];
    foreach ($pairs as [$a, $b]) {
        $target = arr_mean(participant_target_vector($b, $dims, $dir));
        if ($target !== null) $data[] = [frzk_vector($a, $dims), rating_vector($a, $ratingFields, $dir), $target];
    }
    if (count($data) < 12) return ['lag' => $lag, 'n' => count($data), 'error' => 'Zu wenige Datenpunkte für Vorhersagevergleich.'];
    $split = max(3, intval(count($data) * 0.75));
    $train = array_slice($data, 0, $split); $test = array_slice($data, $split);
    $yTrain = array_column($train, 2); $yTest = array_column($test, 2);
    $frzkPred = simple_predict(array_column($train, 0), $yTrain, array_column($test, 0));
    $ratingPred = simple_predict(array_column($train, 1), $yTrain, array_column($test, 1));
    $baseline = array_fill(0, count($yTest), arr_mean($yTrain) ?? 0.0);
    return [
        'lag' => $lag, 'n' => count($data), 'train_n' => count($train), 'test_n' => count($test),
        'FRZK_model' => metrics($frzkPred, $yTest),
        'ratings_model' => metrics($ratingPred, $yTest),
        'baseline_model' => metrics($baseline, $yTest),
    ];
}

function flatten_prediction(array $p): array {
    $out = ['lag' => $p['lag'] ?? null, 'n' => $p['n'] ?? null];
    foreach ([['FRZK', 'FRZK_model'], ['ratings', 'ratings_model'], ['baseline', 'baseline_model']] as [$prefix, $key]) {
        $m = is_array($p[$key] ?? null) ? $p[$key] : [];
        $out[$prefix . '_MAE'] = $m['MAE'] ?? null;
        $out[$prefix . '_RMSE'] = $m['RMSE'] ?? null;
        $out[$prefix . '_R2'] = $m['R2'] ?? null;
        $out[$prefix . '_corr'] = $m['corr_pred_observed'] ?? null;
    }
    if (isset($p['error'])) $out['error'] = $p['error'];
    return $out;
}

function write_csv(string $path, array $rows): void {
    if (!count($rows)) return;
    if (!is_dir(dirname($path))) mkdir(dirname($path), 0777, true);
    $f = fopen($path, 'w');
    $fields = array_keys($rows[0]);
    fputcsv($f, $fields, ';');
    foreach ($rows as $row) fputcsv($f, array_map(fn($k) => $row[$k] ?? '', $fields), ';');
    fclose($f);
}

function make_svg_line(string $path, array $series, string $title, string $ylabel): void {
    $w = 820; $h = 500; $pad = 60;
    $allY = [];
    foreach ($series as $s) foreach ($s['y'] as $y) $allY[] = $y ?? 0.0;
    $minY = min($allY); $maxY = max($allY); if ($minY == $maxY) { $minY -= 1; $maxY += 1; }
    $maxX = 3;
    $svg = "<svg xmlns='http://www.w3.org/2000/svg' width='$w' height='$h'>\n";
    $svg .= "<rect width='100%' height='100%' fill='white'/><text x='" . ($w/2) . "' y='30' text-anchor='middle' font-size='18'>$title</text>\n";
    $svg .= "<line x1='$pad' y1='" . ($h-$pad) . "' x2='" . ($w-$pad) . "' y2='" . ($h-$pad) . "' stroke='black'/><line x1='$pad' y1='$pad' x2='$pad' y2='" . ($h-$pad) . "' stroke='black'/>\n";
    $colors = ['black', 'gray', 'darkslategray'];
    foreach ($series as $idx => $s) {
        $pts = [];
        foreach ($s['y'] as $x => $y) {
            $px = $pad + ($x / $maxX) * ($w - 2*$pad);
            $py = ($h-$pad) - (($y - $minY) / ($maxY - $minY)) * ($h - 2*$pad);
            $pts[] = sprintf('%.2f,%.2f', $px, $py);
        }
        $color = $colors[$idx % count($colors)];
        $svg .= "<polyline points='" . implode(' ', $pts) . "' fill='none' stroke='$color' stroke-width='2'/><text x='" . ($w-$pad-130) . "' y='" . (60 + 20*$idx) . "' font-size='13' fill='$color'>" . htmlspecialchars($s['label']) . "</text>\n";
    }
    $svg .= "<text x='" . ($w/2) . "' y='" . ($h-15) . "' text-anchor='middle'>Zeitversatz n</text><text x='20' y='" . ($h/2) . "' transform='rotate(-90 20," . ($h/2) . ")' text-anchor='middle'>$ylabel</text>\n";
    $svg .= "</svg>";
    file_put_contents($path, $svg);
}

function fmt($x): string { return $x === null ? 'n/a' : (is_numeric($x) ? number_format(floatval($x), 4, '.', '') : strval($x)); }
function md_table(array $rows, array $keys): string {
    $out = ['| ' . implode(' | ', $keys) . ' |', '| ' . implode(' | ', array_fill(0, count($keys), '---')) . ' |'];
    foreach ($rows as $r) {
        $line = [];
        foreach ($keys as $k) $line[] = fmt($r[$k] ?? null);
        $out[] = '| ' . implode(' | ', $line) . ' |';
    }
    return implode("\n", $out);
}

function analyze_scope(string $scope, array $rows, string $outdir, int $nPerm, array $dims, array $ratingFields, float $dir): array {
    $dirPath = $outdir . DIRECTORY_SEPARATOR . $scope;
    if (!is_dir($dirPath)) mkdir($dirPath, 0777, true);
    $lags = lag_metrics($rows, 3, $dims, $dir);
    $perms = [];
    for ($i = 0; $i <= 3; $i++) $perms[] = permutation_test($rows, $i, $nPerm, $dims, $dir);
    $pred = [];
    for ($i = 1; $i <= 3; $i++) $pred[] = prediction_comparison($rows, $i, $dims, $ratingFields, $dir);
    $predFlat = array_map('flatten_prediction', $pred);

    write_csv($dirPath . '/tabelle_zeitversetzte_resonanz.csv', $lags);
    write_csv($dirPath . '/tabelle_permutation_nullmodell.csv', $perms);
    write_csv($dirPath . '/tabelle_vorhersagevergleich.csv', $predFlat);
    make_svg_line($dirPath . '/abb_01_zeitversetzte_resonanz.svg', [['label' => 'echte Kopplung', 'y' => array_column($lags, 'cosine_mean')]], 'Zeitversetzte Resonanzvalidierung L(t) → T(t+n)', 'Kosinusähnlichkeit');
    make_svg_line($dirPath . '/abb_02_permutation_nullmodell.svg', [
        ['label' => 'echte Zuordnung', 'y' => array_column($perms, 'real_cosine_mean')],
        ['label' => 'Nullmodell', 'y' => array_column($perms, 'null_cosine_mean')],
    ], 'FRZK-Kopplung gegen Nullmodell', 'Kosinusähnlichkeit');

    $md = "# 6.x Kausalität des FRZK-Vektorraums – Scope $scope\n\n";
    $md .= "Datensätze: " . count($rows) . "\n\n";
    $md .= "## 1. Zeitversetzte Resonanzvalidierung\n\n" . md_table($lags, ['lag', 'n_pairs', 'cosine_mean', 'distance_mean', 'dominance_accuracy', 'polarity_accuracy']) . "\n\n";
    $md .= "## 2. Permutations-/Nullmodellanalyse\n\n" . md_table($perms, ['lag', 'n_pairs', 'real_cosine_mean', 'null_cosine_mean', 'null_p95', 'z_score', 'p_value_right_tail']) . "\n\n";
    $md .= "## 3. Vorhersagevergleich FRZK vs. klassische Ratings\n\n" . md_table($predFlat, ['lag', 'n', 'FRZK_RMSE', 'FRZK_R2', 'ratings_RMSE', 'ratings_R2', 'baseline_RMSE']) . "\n\n";
    $md .= "## 4. Interpretationsregel\n\nEine starke Stützung entsteht, wenn echte Zuordnungen systematisch über dem permutierten Nullmodell liegen, zeitversetzte Kopplungen bestehen bleiben und das FRZK-Modell im Vorhersagevergleich bessere Fehler- und R²-Werte erreicht als klassische Ratings oder Baseline.\n";
    file_put_contents($dirPath . '/bericht_6x_kausalitaet_vektorraum.md', $md);
    return ['scope' => $scope, 'lag_metrics' => $lags, 'permutation' => $perms, 'prediction' => $predFlat];
}

$input = cli_option('input', '6x_kausalitaet_vektorraum_export.json');
$outdir = cli_option('outdir', '6x_kausalitaet_vektorraum_output');
$nPerm = intval(cli_option('permutations', 1000));

if (!file_exists($input)) {
    fwrite(STDERR, "Eingabedatei fehlt: $input\n");
    exit(1);
}
if (!is_dir($outdir)) mkdir($outdir, 0777, true);
$data = json_decode(file_get_contents($input), true);
if (!is_array($data)) {
    fwrite(STDERR, "JSON konnte nicht gelesen werden.\n");
    exit(1);
}
$summary = ['input' => $input, 'scopes' => []];
foreach (($data['scopes'] ?? []) as $scope => $scopeData) {
    $summary['scopes'][$scope] = analyze_scope($scope, $scopeData['rows'] ?? [], $outdir, $nPerm, $DIMENSIONS, $RATING_FIELDS, $POSITIVE_RATING_DIRECTION);
}
file_put_contents($outdir . '/summary_6x_kausalitaet_vektorraum.json', json_encode($summary, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
echo "Analyse abgeschlossen: " . realpath($outdir) . PHP_EOL;
