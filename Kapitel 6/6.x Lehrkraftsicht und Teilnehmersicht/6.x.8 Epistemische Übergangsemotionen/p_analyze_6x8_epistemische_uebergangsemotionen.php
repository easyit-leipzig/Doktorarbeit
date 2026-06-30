<?php
/**
 * 6.x.8 Epistemische Übergangsemotionen – PHP-Auswertung ohne Lehrkraftunterscheidung
 * Liest: 6x8_epistemische_uebergangsemotionen.json
 * Erzeugt CSV-Tabellen und eine Textauswertung.
 */

$input = __DIR__ . DIRECTORY_SEPARATOR . '6x8_epistemische_uebergangsemotionen.json';
$outDir = __DIR__ . DIRECTORY_SEPARATOR . '6x8_epistemische_uebergangsemotionen_output_php';
$dimensions = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];
$targetEmotions = ['Interesse','Überraschung','Erwartung','Erleichterung'];

if (!file_exists($input)) {
    fwrite(STDERR, "JSON-Datei nicht gefunden: $input\nBitte zuerst export_6x8_epistemische_uebergangsemotionen.php ausführen.\n");
    exit(1);
}
if (!is_dir($outDir)) mkdir($outDir, 0777, true);

$data = json_decode(file_get_contents($input), true);
$records = $data['records'] ?? [];

function mean_arr($arr) { return count($arr) ? array_sum($arr) / count($arr) : 0.0; }
function corr($x, $y) {
    $n = count($x);
    if ($n < 2 || $n !== count($y)) return null;
    $mx = mean_arr($x); $my = mean_arr($y);
    $num = 0.0; $dx = 0.0; $dy = 0.0;
    for ($i=0; $i<$n; $i++) {
        $a = $x[$i] - $mx; $b = $y[$i] - $my;
        $num += $a * $b; $dx += $a * $a; $dy += $b * $b;
    }
    if ($dx == 0.0 || $dy == 0.0) return null;
    return $num / sqrt($dx * $dy);
}
function csv_write($path, $rows) {
    $f = fopen($path, 'w');
    if (!$f) throw new RuntimeException("Kann CSV nicht schreiben: $path");
    if (count($rows) > 0) {
        fputcsv($f, array_keys($rows[0]), ';');
        foreach ($rows as $r) fputcsv($f, $r, ';');
    }
    fclose($f);
}

$flat = [];
foreach ($records as $r) {
    $row = [
        'datum' => $r['datum'] ?? '',
        'gruppe_id' => $r['gruppe_id'] ?? '',
        'teilnehmer_id' => $r['teilnehmer_id'] ?? '',
        'has_epistemic_transition' => !empty($r['has_epistemic_transition']) ? 1 : 0,
        'transition_count' => $r['transition_count'] ?? 0,
        'transition_names' => implode(', ', $r['epistemic_transition_names'] ?? []),
        'd_semantisch' => $r['d_semantisch'] ?? 0,
        'd_semantisch_mean' => $r['d_semantisch_mean'] ?? 0,
        'semantische_breite' => $r['semantische_breite'] ?? 0,
        'dominanz_breite' => $r['dominanz_breite'] ?? 0,
        'dominante_dimension' => $r['dominante_dimension'] ?? '',
        'polaritaet_gesamt' => $r['polaritaet_gesamt'] ?? 0,
        'token_anzahl' => $r['token_anzahl'] ?? 0,
    ];
    foreach ($dimensions as $d) {
        $row['mean_' . $d] = $r['mean_vector'][$d] ?? 0;
        $row['x_' . $d] = $r['x_vector'][$d] ?? 0;
        $row['var_' . $d] = $r['var_vector'][$d] ?? 0;
    }
    foreach ($targetEmotions as $e) {
        $row['emo_' . $e] = in_array($e, $r['epistemic_transition_names'] ?? [], true) ? 1 : 0;
    }
    $flat[] = $row;
}

csv_write($outDir . DIRECTORY_SEPARATOR . '6x8_rohdaten_flach.csv', $flat);

$summaryRows = [];
foreach ([
    'alle Emotionsdatensätze' => $flat,
    'mit epistemischer Übergangsemotion' => array_values(array_filter($flat, fn($r) => $r['has_epistemic_transition'] == 1)),
    'ohne epistemische Übergangsemotion' => array_values(array_filter($flat, fn($r) => $r['has_epistemic_transition'] == 0)),
] as $label => $rows) {
    $sr = ['gruppe' => $label, 'n' => count($rows)];
    foreach ($dimensions as $d) $sr['mean_' . $d] = mean_arr(array_column($rows, 'mean_' . $d));
    foreach (['d_semantisch_mean','semantische_breite','dominanz_breite','token_anzahl'] as $k) $sr[$k] = mean_arr(array_column($rows, $k));
    $summaryRows[] = $sr;
}
csv_write($outDir . DIRECTORY_SEPARATOR . '6x8_summary_mit_ohne_uebergangsemotion.csv', $summaryRows);

$emotionRows = [];
foreach ($targetEmotions as $e) {
    $emotionRows[] = ['emotion' => $e, 'anzahl' => array_sum(array_column($flat, 'emo_' . $e))];
}
csv_write($outDir . DIRECTORY_SEPARATOR . '6x8_emotionshaeufigkeit.csv', $emotionRows);

$corrRows = [];
foreach ($targetEmotions as $e) {
    $x = array_column($flat, 'emo_' . $e);
    $row = ['emotion' => $e, 'n' => array_sum($x)];
    foreach ($dimensions as $d) $row['corr_mean_' . $d] = corr($x, array_column($flat, 'mean_' . $d));
    foreach (['d_semantisch_mean','semantische_breite','dominanz_breite','token_anzahl'] as $k) $row['corr_' . $k] = corr($x, array_column($flat, $k));
    $corrRows[] = $row;
}
csv_write($outDir . DIRECTORY_SEPARATOR . '6x8_korrelationen_emotionen_frzk.csv', $corrRows);

$groups = [];
foreach ($flat as $r) {
    $g = $r['gruppe_id'];
    if (!isset($groups[$g])) $groups[$g] = [];
    $groups[$g][] = $r;
}
$groupRows = [];
foreach ($groups as $g => $rows) {
    $groupRows[] = [
        'gruppe_id' => $g,
        'n' => count($rows),
        'epistemic_n' => array_sum(array_column($rows, 'has_epistemic_transition')),
        'epistemic_share' => mean_arr(array_column($rows, 'has_epistemic_transition')),
        'mean_kognition' => mean_arr(array_column($rows, 'mean_kognition')),
        'mean_methodik' => mean_arr(array_column($rows, 'mean_methodik')),
        'mean_affektiv' => mean_arr(array_column($rows, 'mean_affektiv')),
        'd_semantisch_mean' => mean_arr(array_column($rows, 'd_semantisch_mean')),
        'semantische_breite' => mean_arr(array_column($rows, 'semantische_breite')),
    ];
}
csv_write($outDir . DIRECTORY_SEPARATOR . '6x8_gruppenprofil_uebergangsemotionen.csv', $groupRows);

$text = [];
$total = count($flat);
$epi = array_sum(array_column($flat, 'has_epistemic_transition'));
$text[] = '6.x.8 Epistemische Übergangsemotionen – PHP-Textauswertung';
$text[] = 'Datensätze gesamt: ' . $total;
$text[] = 'Mit epistemischer Übergangsemotion: ' . $epi;
$text[] = 'Anteil: ' . ($total ? round($epi / $total, 4) : 0);
$text[] = '';
$text[] = 'Häufigkeiten:';
foreach ($emotionRows as $er) $text[] = '- ' . $er['emotion'] . ': ' . $er['anzahl'];
$text[] = '';
$text[] = 'Hinweis: Grafiken werden im Python-Analyseskript erzeugt; PHP erzeugt die tabellarischen Kontrollausgaben.';
file_put_contents($outDir . DIRECTORY_SEPARATOR . '6x8_textauswertung.txt', implode(PHP_EOL, $text));

echo "PHP-Auswertung abgeschlossen: $outDir\n";
?>
