<?php
// ============================================================================
// 6.x.2 Semantische Dichte – Teilnehmersicht – PHP-Analyse/Auswertung
//
// Liest: 6x2_semantische_dichte_tn.json
// Erzeugt:
//   - 6x2_semantische_dichte_tn_auswertung.md
//   - tab_6x2_gruppenvergleich.csv
//   - einfache PNG-Grafiken über GD, falls GD verfügbar ist
// ============================================================================

header('Content-Type: text/plain; charset=utf-8');
ini_set('display_errors', '1');
error_reporting(E_ALL);
ini_set('memory_limit', '1024M');
set_time_limit(0);

$inputJson = $argv[1] ?? __DIR__ . DIRECTORY_SEPARATOR . '6x2_semantische_dichte_tn.json';
$outDir = $argv[2] ?? __DIR__ . DIRECTORY_SEPARATOR . '6x2_semantische_dichte_tn_output_php';

$dimensions = [
    'kognition',
    'sozial',
    'affektiv',
    'motivation',
    'methodik',
    'performanz',
    'regulation',
];

if (!is_file($inputJson)) {
    throw new RuntimeException("Input-JSON nicht gefunden: $inputJson");
}
if (!is_dir($outDir)) {
    mkdir($outDir, 0777, true);
}

$payload = json_decode(file_get_contents($inputJson), true);
if (!is_array($payload)) {
    throw new RuntimeException('JSON konnte nicht gelesen werden: ' . json_last_error_msg());
}
$rows = $payload['teilnehmer_zustaende'] ?? [];
$meta = $payload['metadata'] ?? [];

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

function fmt($v): string
{
    if ($v === null || !is_numeric($v)) {
        return '';
    }
    return number_format((float)$v, 4, '.', '');
}

function csvWrite(string $file, array $rows): void
{
    $fp = fopen($file, 'w');
    if ($fp === false) {
        throw new RuntimeException("CSV konnte nicht geschrieben werden: $file");
    }
    if (count($rows) > 0) {
        fputcsv($fp, array_keys($rows[0]), ';');
        foreach ($rows as $r) {
            fputcsv($fp, $r, ';');
        }
    }
    fclose($fp);
}

function mdTable(array $rows): string
{
    if (count($rows) === 0) {
        return "_Keine Daten._\n";
    }
    $cols = array_keys($rows[0]);
    $out = [];
    $out[] = '| ' . implode(' | ', $cols) . ' |';
    $out[] = '| ' . implode(' | ', array_fill(0, count($cols), '---')) . ' |';
    foreach ($rows as $r) {
        $line = [];
        foreach ($cols as $c) {
            $line[] = (string)($r[$c] ?? '');
        }
        $out[] = '| ' . implode(' | ', $line) . ' |';
    }
    return implode("\n", $out) . "\n";
}

function drawBarChart(array $labels, array $values, string $file, string $title, string $ylabel): bool
{
    if (!function_exists('imagecreatetruecolor') || count($labels) === 0) {
        return false;
    }
    $w = 1400;
    $h = 850;
    $img = imagecreatetruecolor($w, $h);
    $white = imagecolorallocate($img, 255, 255, 255);
    $black = imagecolorallocate($img, 0, 0, 0);
    $gray = imagecolorallocate($img, 220, 220, 220);
    $bar = imagecolorallocate($img, 80, 120, 180);
    imagefilledrectangle($img, 0, 0, $w, $h, $white);
    imagestring($img, 5, 40, 25, $title, $black);
    imagestring($img, 3, 40, 50, $ylabel, $black);

    $left = 90;
    $right = 50;
    $top = 100;
    $bottom = 120;
    $plotW = $w - $left - $right;
    $plotH = $h - $top - $bottom;
    imagerectangle($img, $left, $top, $left + $plotW, $top + $plotH, $black);

    $valid = array_values(array_filter($values, fn($v) => $v !== null));
    $max = count($valid) ? max($valid) : 1.0;
    $min = count($valid) ? min(0.0, min($valid)) : 0.0;
    $range = max(0.0001, $max - $min);
    $n = count($labels);
    $gap = 12;
    $barW = max(8, ($plotW - ($n + 1) * $gap) / max(1, $n));

    for ($i = 0; $i < $n; $i++) {
        $v = $values[$i] ?? 0.0;
        $x1 = (int)($left + $gap + $i * ($barW + $gap));
        $x2 = (int)($x1 + $barW);
        $y0 = (int)($top + $plotH - ((0.0 - $min) / $range) * $plotH);
        $yVal = (int)($top + $plotH - (($v - $min) / $range) * $plotH);
        imagefilledrectangle($img, $x1, min($y0, $yVal), $x2, max($y0, $yVal), $bar);
        imageline($img, $x1, $y0, $x2, $y0, $black);
        imagestringup($img, 3, $x1 + 5, $h - 30, (string)$labels[$i], $black);
        imagestring($img, 2, $x1, max(80, $yVal - 15), number_format((float)$v, 2), $black);
    }

    for ($i = 0; $i <= 5; $i++) {
        $y = (int)($top + $i * $plotH / 5);
        imageline($img, $left, $y, $left + $plotW, $y, $gray);
    }

    imagepng($img, $file);
    imagedestroy($img);
    return true;
}

function drawHeatmap(array $matrix, array $rowLabels, array $colLabels, string $file, string $title): bool
{
    if (!function_exists('imagecreatetruecolor') || count($matrix) === 0) {
        return false;
    }
    $cellW = 120;
    $cellH = 70;
    $left = 150;
    $top = 100;
    $w = $left + count($colLabels) * $cellW + 60;
    $h = $top + count($rowLabels) * $cellH + 80;
    $img = imagecreatetruecolor($w, $h);
    $white = imagecolorallocate($img, 255, 255, 255);
    $black = imagecolorallocate($img, 0, 0, 0);
    imagefilledrectangle($img, 0, 0, $w, $h, $white);
    imagestring($img, 5, 30, 25, $title, $black);

    $vals = [];
    foreach ($matrix as $row) {
        foreach ($row as $v) {
            if ($v !== null) $vals[] = $v;
        }
    }
    $min = count($vals) ? min($vals) : -1.0;
    $max = count($vals) ? max($vals) : 1.0;
    $range = max(0.0001, $max - $min);

    foreach ($colLabels as $j => $label) {
        imagestringup($img, 3, $left + $j * $cellW + 55, $top - 10, $label, $black);
    }
    foreach ($rowLabels as $i => $label) {
        imagestring($img, 3, 20, $top + $i * $cellH + 25, $label, $black);
    }

    foreach ($matrix as $i => $row) {
        foreach ($row as $j => $v) {
            $x1 = $left + $j * $cellW;
            $y1 = $top + $i * $cellH;
            $norm = ($v === null) ? 0.5 : (($v - $min) / $range);
            $shade = (int)round(255 - 180 * $norm);
            $color = imagecolorallocate($img, $shade, $shade, 255);
            imagefilledrectangle($img, $x1, $y1, $x1 + $cellW, $y1 + $cellH, $color);
            imagerectangle($img, $x1, $y1, $x1 + $cellW, $y1 + $cellH, $black);
            imagestring($img, 3, $x1 + 20, $y1 + 25, fmt($v), $black);
        }
    }
    imagepng($img, $file);
    imagedestroy($img);
    return true;
}

$byGroup = [];
$allH = [];
$dichteKlassen = [];
$dominanz = [];
$teilnehmerIds = [];

foreach ($rows as $r) {
    $gid = (int)($r['gruppe_id'] ?? 0);
    if (!isset($byGroup[$gid])) {
        $byGroup[$gid] = [];
    }
    $byGroup[$gid][] = $r;
    $h = fnum($r['h_T'] ?? $r['d_semantisch'] ?? null);
    if ($h !== null) $allH[] = $h;
    $klasse = $r['dichteklasse'] ?? 'ohne Klasse';
    $dichteKlassen[$klasse] = ($dichteKlassen[$klasse] ?? 0) + 1;
    $dom = $r['dominante_dimension'] ?? 'unbestimmt';
    $dominanz[$dom] = ($dominanz[$dom] ?? 0) + 1;
    if (isset($r['teilnehmer_id'])) $teilnehmerIds[(string)$r['teilnehmer_id']] = true;
}
ksort($byGroup, SORT_NUMERIC);

$gruppenVergleich = [];
$heatRows = [];
$heatLabels = [];
foreach ($byGroup as $gid => $items) {
    $hVals = [];
    foreach ($items as $i) {
        $hVals[] = fnum($i['h_T'] ?? $i['d_semantisch'] ?? null);
    }
    $dimMeans = [];
    foreach ($dimensions as $dim) {
        $vals = [];
        foreach ($items as $i) {
            $vals[] = fnum($i['vector_7d'][$dim] ?? $i['x_' . $dim] ?? null);
        }
        $dimMeans[$dim] = meanVal($vals);
    }
    $validH = array_values(array_filter($hVals, fn($v) => $v !== null));
    $gruppenVergleich[] = [
        'gruppe_id' => $gid,
        'n' => count($items),
        'h_T_mean' => fmt(meanVal($hVals)),
        'h_T_std' => fmt(stdPop($hVals)),
        'h_T_min' => count($validH) ? fmt(min($validH)) : '',
        'h_T_max' => count($validH) ? fmt(max($validH)) : '',
    ];
    $heatLabels[] = 'Gruppe ' . $gid;
    $heatRows[] = array_map(fn($dim) => $dimMeans[$dim], $dimensions);
}

usort($gruppenVergleich, function ($a, $b) {
    return (float)$b['h_T_mean'] <=> (float)$a['h_T_mean'];
});

csvWrite($outDir . DIRECTORY_SEPARATOR . 'tab_6x2_gruppenvergleich.csv', $gruppenVergleich);

$figures = [];
$labels = array_map(fn($r) => 'G ' . $r['gruppe_id'], $gruppenVergleich);
$values = array_map(fn($r) => fnum($r['h_T_mean']), $gruppenVergleich);
$barPath = $outDir . DIRECTORY_SEPARATOR . 'abb_6x2_01_gruppenvergleich_hT_php.png';
if (drawBarChart($labels, $values, $barPath, '6.x.2 Semantische Dichte h(T) nach Gruppe', 'mittlere h(T)')) {
    $figures[] = basename($barPath);
}

$heatPath = $outDir . DIRECTORY_SEPARATOR . 'abb_6x2_02_heatmap_7d_gruppenprofil_php.png';
if (drawHeatmap($heatRows, $heatLabels, $dimensions, $heatPath, '6.x.2 7D-Dichteprofil nach Gruppe')) {
    $figures[] = basename($heatPath);
}

$dimOverall = [];
foreach ($dimensions as $dim) {
    $vals = [];
    foreach ($rows as $r) {
        $vals[] = fnum($r['vector_7d'][$dim] ?? $r['x_' . $dim] ?? null);
    }
    $dimOverall[$dim] = meanVal($vals);
}
$profilePath = $outDir . DIRECTORY_SEPARATOR . 'abb_6x2_03_gesamtprofil_7d_php.png';
if (drawBarChart(array_keys($dimOverall), array_values($dimOverall), $profilePath, '6.x.2 Gesamtprofil der sieben FRZK-Dimensionen', 'mittlerer Wert')) {
    $figures[] = basename($profilePath);
}

$md = [];
$md[] = '# 6.x.2 Semantische Dichte – Teilnehmersicht';
$md[] = '';
$md[] = '## Datengrundlage';
$md[] = '- Quelle: `' . ($meta['source_table'] ?? 'frzk_semantische_dichte_teilnehmer_7d') . '`';
$md[] = '- Datensätze: ' . count($rows);
$md[] = '- Teilnehmende: ' . count($teilnehmerIds);
$md[] = '- Gruppen: ' . count($byGroup);
$md[] = '- Definition: ' . ($meta['definition'] ?? 'h(T)=||T||_2');
$md[] = '';
$md[] = '## Kurzbefund';
$md[] = 'Die mittlere semantische Dichte beträgt ' . fmt(meanVal($allH)) . '.';
$md[] = 'Dichteklassen: ' . implode(', ', array_map(fn($k, $v) => "$k: $v", array_keys($dichteKlassen), array_values($dichteKlassen))) . '.';
$md[] = '';
$md[] = '## Gruppenvergleich';
$md[] = mdTable($gruppenVergleich);
$md[] = '';
$md[] = '## Verdichtungen und Leerstellen';
$high = array_slice($gruppenVergleich, 0, 3);
$low = array_reverse(array_slice($gruppenVergleich, -3));
$md[] = '**Stärkste Verdichtungen:** ' . implode(', ', array_map(fn($r) => 'Gruppe ' . $r['gruppe_id'] . ' (h=' . $r['h_T_mean'] . ')', $high)) . '.';
$md[] = '**Deutlichste Leerstellen/diffuseste Gruppen:** ' . implode(', ', array_map(fn($r) => 'Gruppe ' . $r['gruppe_id'] . ' (h=' . $r['h_T_mean'] . ')', $low)) . '.';
$md[] = '';
$md[] = '## 7D-Gesamtprofil';
$profileRows = [];
foreach ($dimOverall as $dim => $v) {
    $profileRows[] = ['dimension' => $dim, 'mean' => fmt($v)];
}
$md[] = mdTable($profileRows);
$md[] = '';
$md[] = '## Dominanzstruktur';
$domRows = [];
arsort($dominanz);
foreach ($dominanz as $dim => $anz) {
    $domRows[] = ['dominante_dimension' => $dim, 'anzahl' => $anz];
}
$md[] = mdTable($domRows);
$md[] = '';
$md[] = '## Interpretation für den Abschnitt';
$md[] = 'Semantische Dichte wird hier als Stärke des Teilnehmerzustands im sieben-dimensionalen FRZK-Raum gelesen. Hohe Werte markieren Verdichtungen; niedrige Werte markieren Leerstellen oder diffuse Zustände. Didaktisch sind Verdichtungen Zonen gebundener Bedeutung, Leerstellen dagegen Hinweise auf fehlende Struktur, unklare Rückbindung oder noch nicht stabilisierte Lernbewegungen.';
$md[] = '';
$md[] = '## Abbildungen';
foreach ($figures as $fig) {
    $md[] = '- `' . $fig . '`';
}
$md[] = '';

$mdFile = $outDir . DIRECTORY_SEPARATOR . '6x2_semantische_dichte_tn_auswertung.md';
file_put_contents($mdFile, implode("\n", $md));

echo "OK: PHP-Auswertung erzeugt in $outDir\n";
echo "Markdown: $mdFile\n";
if (count($figures)) {
    echo "Abbildungen:\n";
    foreach ($figures as $f) echo "- $f\n";
} else {
    echo "Hinweis: Keine PNG-Grafiken erzeugt. GD ist vermutlich nicht aktiviert.\n";
}
