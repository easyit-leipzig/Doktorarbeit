<?php
// ============================================================================
// 6.x.4 Polarität – PHP-Analyse
// Liest 6x4_polaritaet_tn.json und erzeugt eine textuelle Markdown-Auswertung.
// Grafiken bitte mit dem Python-Analyseskript erzeugen; PHP erzeugt CSV/MD.
// ============================================================================

header('Content-Type: text/plain; charset=utf-8');
ini_set('display_errors', '1');
error_reporting(E_ALL);

$inFile = __DIR__ . DIRECTORY_SEPARATOR . '6x4_polaritaet_tn.json';
$outDir = __DIR__ . DIRECTORY_SEPARATOR . 'output_6x4_polaritaet_php';
if (!is_dir($outDir)) mkdir($outDir, 0777, true);

if (!file_exists($inFile)) {
    die("JSON nicht gefunden: {$inFile}\nBitte zuerst 01_export_6x4_polaritaet_tn.php oder .py ausführen.\n");
}

$data = json_decode(file_get_contents($inFile), true);
$group = $data['by_group'] ?? [];
$gt = $data['by_group_time'] ?? [];

function slope($ys) {
    $n = count($ys);
    if ($n < 2) return 0.0;
    $meanX = ($n - 1) / 2.0;
    $meanY = array_sum($ys) / $n;
    $num = 0.0; $den = 0.0;
    for ($i=0; $i<$n; $i++) {
        $num += ($i - $meanX) * (((float)$ys[$i]) - $meanY);
        $den += ($i - $meanX) * ($i - $meanX);
    }
    return $den == 0.0 ? 0.0 : $num / $den;
}

$byGTime = [];
foreach ($gt as $r) {
    $gid = $r['gruppe_id'];
    if (!isset($byGTime[$gid])) $byGTime[$gid] = [];
    $byGTime[$gid][] = $r;
}

$trends = [];
foreach ($byGTime as $gid => $rows) {
    usort($rows, fn($a,$b) => strcmp($a['datum'], $b['datum']));
    $ys = array_map(fn($r) => (float)$r['mean_polaritaet_index'], $rows);
    $trends[$gid] = [
        'trend_slope' => slope($ys),
        'start_index' => count($ys) ? $ys[0] : 0.0,
        'end_index' => count($ys) ? $ys[count($ys)-1] : 0.0,
        'n_zeitpunkte' => count($ys),
    ];
}

foreach ($group as &$g) {
    $gid = $g['gruppe_id'];
    if (isset($trends[$gid])) $g = array_merge($g, $trends[$gid]);
}
unset($g);

usort($group, fn($a,$b) => ($b['mean_polaritaet_index'] <=> $a['mean_polaritaet_index']));
$topPos = array_slice($group, 0, 3);
$topNeg = $group;
usort($topNeg, fn($a,$b) => ($a['mean_polaritaet_index'] <=> $b['mean_polaritaet_index']));
$topNeg = array_slice($topNeg, 0, 3);
$dev = $group;
usort($dev, fn($a,$b) => (($b['trend_slope'] ?? 0) <=> ($a['trend_slope'] ?? 0)));
$dec = $group;
usort($dec, fn($a,$b) => (($a['trend_slope'] ?? 0) <=> ($b['trend_slope'] ?? 0)));

$md = [];
$md[] = "# 6.x.4 Polarität – PHP-Auswertung ohne Lehrkraftunterscheidung\n";
$md[] = "Datengrundlage: " . ($data['meta']['quelle'] ?? '') . " mit " . ($data['meta']['n_records'] ?? 0) . " Teilnehmerzuständen.\n";
$md[] = "## Gruppen mit stärkster positiver Lage";
foreach ($topPos as $r) {
    $md[] = "- Gruppe {$r['gruppe_id']}: mittlerer Index " . number_format($r['mean_polaritaet_index'], 3, '.', '') . ", positiver Anteil " . number_format(100*$r['anteil_positiv'], 1, '.', '') . " %.";
}
$md[] = "\n## Gruppen mit kritischster/negativster Lage";
foreach ($topNeg as $r) {
    $md[] = "- Gruppe {$r['gruppe_id']}: mittlerer Index " . number_format($r['mean_polaritaet_index'], 3, '.', '') . ", negativer Anteil " . number_format(100*$r['anteil_negativ'], 1, '.', '') . " %.";
}
$md[] = "\n## Positive Entwicklungstendenz";
foreach (array_slice($dev, 0, 3) as $r) {
    $md[] = "- Gruppe {$r['gruppe_id']}: Trend " . number_format($r['trend_slope'] ?? 0, 4, '.', '') . ", von " . number_format($r['start_index'] ?? 0, 3, '.', '') . " zu " . number_format($r['end_index'] ?? 0, 3, '.', '') . ".";
}
$md[] = "\n## Negative Entwicklungstendenz";
foreach (array_slice($dec, 0, 3) as $r) {
    $md[] = "- Gruppe {$r['gruppe_id']}: Trend " . number_format($r['trend_slope'] ?? 0, 4, '.', '') . ", von " . number_format($r['start_index'] ?? 0, 3, '.', '') . " zu " . number_format($r['end_index'] ?? 0, 3, '.', '') . ".";
}

file_put_contents($outDir . DIRECTORY_SEPARATOR . '6x4_polaritaet_auswertung_php.md', implode("\n", $md));

$csv = fopen($outDir . DIRECTORY_SEPARATOR . '6x4_polaritaet_gruppen_summary_php.csv', 'w');
fputcsv($csv, ['gruppe_id','n','positiv','negativ','neutral','mean_polaritaet_index','anteil_positiv','anteil_negativ','anteil_neutral','trend_slope','start_index','end_index'], ';');
foreach ($group as $r) {
    fputcsv($csv, [
        $r['gruppe_id'], $r['n'], $r['positiv'], $r['negativ'], $r['neutral'],
        $r['mean_polaritaet_index'], $r['anteil_positiv'], $r['anteil_negativ'], $r['anteil_neutral'],
        $r['trend_slope'] ?? '', $r['start_index'] ?? '', $r['end_index'] ?? ''
    ], ';');
}
fclose($csv);

echo "OK: PHP-Auswertung erzeugt in {$outDir}\n";
