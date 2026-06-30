<?php
// ============================================================================
// 6.x.3 Dominanzstrukturen Teilnehmersicht – PHP-Analyse/Auswertung
// Liest 6x3_dominanzstrukturen_tn.json und erzeugt textuelle Auswertungen
// plus CSV-Dateien für Tabellenkalkulation/Diagramme.
// ============================================================================

header('Content-Type: text/plain; charset=utf-8');
ini_set('display_errors', '1');
error_reporting(E_ALL);

$baseDir = __DIR__;
$inputFile = $baseDir . DIRECTORY_SEPARATOR . "6x3_dominanzstrukturen_tn.json";
$outDir = $baseDir . DIRECTORY_SEPARATOR . "6x3_dominanzstrukturen_tn_analyse_php";

if (!file_exists($inputFile)) {
    die("JSON-Datei nicht gefunden: {$inputFile}. Bitte zuerst Export-Skript ausführen.\n");
}
if (!is_dir($outDir)) mkdir($outDir, 0777, true);

$dimensions = [
    'kognition',
    'sozial',
    'affektiv',
    'motivation',
    'methodik',
    'performanz',
    'regulation',
];

$data = json_decode(file_get_contents($inputFile), true);
if (!is_array($data) || !isset($data['records'])) {
    die("Ungültige JSON-Struktur. Erwartet wird ein Objekt mit records.\n");
}

$records = $data['records'];
$total = count($records);

function fnum($v): ?float {
    if ($v === null || $v === '') return null;
    if (!is_numeric($v)) return null;
    $x = (float)$v;
    return (is_nan($x) || is_infinite($x)) ? null : $x;
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

function pct(int|float $part, int|float $total): string {
    return $total > 0 ? number_format(($part / $total) * 100, 1, ',', '.') . " %" : "0,0 %";
}

function csv_write(string $file, array $rows, array $header): void {
    $fh = fopen($file, 'w');
    fwrite($fh, "\xEF\xBB\xBF");
    fputcsv($fh, $header, ';');
    foreach ($rows as $row) {
        $line = [];
        foreach ($header as $h) $line[] = $row[$h] ?? null;
        fputcsv($fh, $line, ';');
    }
    fclose($fh);
}

$counts = array_fill_keys($dimensions, 0);
$domAbs = [];
$gaps = [];
$density = [];
$wechsel = 0;
$participants = [];
$groups = [];
$byGroup = [];
$byDate = [];

foreach ($records as $r) {
    $dim = strtolower(trim((string)($r['dominante_dimension'] ?? 'unbestimmt')));
    if (!array_key_exists($dim, $counts)) $counts[$dim] = 0;
    $counts[$dim]++;
    $da = fnum($r['dominanz_abs'] ?? null);
    $gap = fnum($r['dominanz_luecke_zur_zweiten_dimension'] ?? null);
    $ds = fnum($r['d_semantisch'] ?? null);
    if ($da !== null) $domAbs[] = $da;
    if ($gap !== null) $gaps[] = $gap;
    if ($ds !== null) $density[] = $ds;
    $wechsel += (int)($r['dominanzwechsel'] ?? 0);

    if (isset($r['teilnehmer_id'])) $participants[(string)$r['teilnehmer_id']] = true;
    if (isset($r['gruppe_id'])) $groups[(string)$r['gruppe_id']] = true;

    $gid = (string)($r['gruppe_id'] ?? 0);
    $datum = (string)($r['datum'] ?? substr((string)($r['zeitpunkt'] ?? ''), 0, 10));
    if (!isset($byGroup[$gid])) $byGroup[$gid] = [];
    if (!isset($byDate[$datum])) $byDate[$datum] = [];
    $byGroup[$gid][] = $r;
    $byDate[$datum][] = $r;
}

arsort($counts);
$topDim = count($counts) ? array_key_first($counts) : null;
$topCount = $topDim !== null ? $counts[$topDim] : 0;

$report = [];
$report[] = "6.x.3 Dominanzstrukturen – Teilnehmersicht";
$report[] = "================================================";
$report[] = "";
$report[] = "Datengrundlage: {$total} Teilnehmerzustände aus frzk_semantische_dichte_teilnehmer_7d.";
$report[] = "Teilnehmer: " . count($participants) . " | Gruppen: " . count($groups) . " | Lehrkraftunterscheidung: nein.";
$report[] = "";
$report[] = "1. Gesamtverteilung der dominanten Dimensionen";
foreach ($dimensions as $d) {
    $n = $counts[$d] ?? 0;
    $report[] = "   - {$d}: {$n} Zustände (" . pct($n, $total) . ")";
}
if ($topDim !== null) {
    $report[] = "   Hauptbefund: Die häufigste Dominanzdimension ist '{$topDim}' mit {$topCount} Zuständen.";
}
$report[] = "";
$report[] = "2. Stärke der Dominanz";
$report[] = "   - Mittlere absolute Dominanz: " . number_format((float)mean_arr($domAbs), 4, ',', '.');
$report[] = "   - Streuung der Dominanz: " . number_format((float)std_pop_arr($domAbs), 4, ',', '.');
$report[] = "   - Mittlere Lücke zur zweitstärksten Dimension: " . number_format((float)mean_arr($gaps), 4, ',', '.');
$report[] = "   Interpretation: Eine große Lücke zeigt klar profilierte Zustände; eine kleine Lücke spricht für diffuse oder mehrdimensionale Zustände.";
$report[] = "";
$report[] = "3. Gruppenbezogene Dominanzmuster";
ksort($byGroup, SORT_NATURAL);
$groupCsv = [];
foreach ($byGroup as $gid => $bucket) {
    $c = [];
    foreach ($bucket as $r) {
        $d = strtolower(trim((string)($r['dominante_dimension'] ?? 'unbestimmt')));
        if (!isset($c[$d])) $c[$d] = 0;
        $c[$d]++;
    }
    arsort($c);
    $dTop = array_key_first($c);
    $nTop = $c[$dTop] ?? 0;
    $report[] = "   - Gruppe {$gid}: häufigste Dominanz '{$dTop}' ({$nTop}/" . count($bucket) . "; " . pct($nTop, count($bucket)) . ")";
    $row = ['gruppe_id' => $gid, 'n' => count($bucket), 'haeufigste_dominanz' => $dTop, 'haeufigste_dominanz_n' => $nTop];
    foreach ($dimensions as $d) $row[$d] = $c[$d] ?? 0;
    $groupCsv[] = $row;
}
$report[] = "";
$report[] = "4. Dominanzwechsel";
$report[] = "   - Dominanzwechsel gesamt: {$wechsel}";
$report[] = "   - Anteil bezogen auf alle Zustände: " . pct($wechsel, $total);
$report[] = "   Interpretation: Häufige Dominanzwechsel deuten auf dynamische, möglicherweise instabile oder suchende Lernzustände hin.";
$report[] = "";
$report[] = "5. Bezug zu den Leitfragen";
$report[] = "   - Kognitive Dominanz: hoher Anteil 'kognition' spricht für erkenntnis- und verstehensorientierte Lernzustände.";
$report[] = "   - Affektive Dominanz: hoher Anteil 'affektiv' verweist auf emotionale Färbung, Irritation oder Zustimmung im Lernprozess.";
$report[] = "   - Motivationale Dominanz: hoher Anteil 'motivation' zeigt Zustände, in denen Antrieb, Interesse oder Widerstand strukturprägend werden.";
$report[] = "   - Regulatorische Dominanz: hoher Anteil 'regulation' zeigt Selbststeuerung, Konzentration, Vorbereitung und Ordnung als tragende Dimensionen.";
$report[] = "";
$report[] = "Erzeugte Dateien:";
$report[] = "   - 6x3_dominanzstrukturen_report_php.txt";
$report[] = "   - 6x3_dominanz_dimensionen_haeufigkeit.csv";
$report[] = "   - 6x3_dominanz_gruppen.csv";
$report[] = "   - 6x3_dominanz_records_flat.csv";

file_put_contents($outDir . DIRECTORY_SEPARATOR . "6x3_dominanzstrukturen_report_php.txt", implode("\n", $report));

$countsCsv = [];
foreach ($dimensions as $d) {
    $n = $counts[$d] ?? 0;
    $countsCsv[] = ['dimension' => $d, 'anzahl' => $n, 'anteil' => $total > 0 ? $n / $total : 0];
}
csv_write($outDir . DIRECTORY_SEPARATOR . "6x3_dominanz_dimensionen_haeufigkeit.csv", $countsCsv, ['dimension', 'anzahl', 'anteil']);
csv_write($outDir . DIRECTORY_SEPARATOR . "6x3_dominanz_gruppen.csv", $groupCsv, array_merge(['gruppe_id', 'n', 'haeufigste_dominanz', 'haeufigste_dominanz_n'], $dimensions));

$flatRows = [];
foreach ($records as $r) {
    $row = [
        'id' => $r['id'] ?? null,
        'teilnehmer_id' => $r['teilnehmer_id'] ?? null,
        'gruppe_id' => $r['gruppe_id'] ?? null,
        'zeitpunkt' => $r['zeitpunkt'] ?? null,
        'dominante_dimension' => $r['dominante_dimension'] ?? null,
        'dominante_dimension_wert' => $r['dominante_dimension_wert'] ?? null,
        'dominanz_abs' => $r['dominanz_abs'] ?? null,
        'dominanz_luecke_zur_zweiten_dimension' => $r['dominanz_luecke_zur_zweiten_dimension'] ?? null,
        'd_semantisch' => $r['d_semantisch'] ?? null,
        'dominanzwechsel' => $r['dominanzwechsel'] ?? null,
    ];
    foreach ($dimensions as $d) $row['x_' . $d] = $r['dimensionen'][$d] ?? null;
    $flatRows[] = $row;
}
csv_write($outDir . DIRECTORY_SEPARATOR . "6x3_dominanz_records_flat.csv", $flatRows, array_merge(['id','teilnehmer_id','gruppe_id','zeitpunkt','dominante_dimension','dominante_dimension_wert','dominanz_abs','dominanz_luecke_zur_zweiten_dimension','d_semantisch','dominanzwechsel'], array_map(fn($d) => 'x_' . $d, $dimensions)));

echo implode("\n", $report) . "\n";
echo "\nAnalyseordner: {$outDir}\n";
