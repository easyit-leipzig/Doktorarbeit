<?php
/**
 * 6.x.24 Analyse-/Auswertungsskript PHP
 * Liest 6x24_lehrkraftprofil_gruppendynamik.json und erzeugt CSV + Textbericht.
 * Grafiken werden im Python-Analyseskript erzeugt.
 */

$inputFile = __DIR__ . DIRECTORY_SEPARATOR . '6x24_lehrkraftprofil_gruppendynamik.json';
$outDir = __DIR__ . DIRECTORY_SEPARATOR . '6x24_lehrkraftprofil_gruppendynamik_output_php';
if (!file_exists($inputFile)) {
    fwrite(STDERR, "JSON nicht gefunden: $inputFile\n");
    exit(1);
}
if (!is_dir($outDir)) mkdir($outDir, 0777, true);

$payload = json_decode(file_get_contents($inputFile), true);
if (!$payload) {
    fwrite(STDERR, "JSON konnte nicht gelesen werden.\n");
    exit(1);
}

$summary = $payload['summary_by_group'] ?? [];
usort($summary, fn($a, $b) => (int)$a['gruppe_id'] <=> (int)$b['gruppe_id']);

function fnum($v, int $nd = 4): string {
    return is_numeric($v) ? number_format((float)$v, $nd, '.', '') : 'n/a';
}

$csvFile = $outDir . DIRECTORY_SEPARATOR . '6x24_summary_by_group.csv';
$fh = fopen($csvFile, 'w');
fputcsv($fh, [
    'gruppe_id','n','mean_distance_lk1','mean_distance_other','mean_delta_distance',
    'mean_dynamik','mean_stabilitaet','profile_binding','risk_counts'
], ';');
foreach ($summary as $r) {
    fputcsv($fh, [
        $r['gruppe_id'] ?? '',
        $r['n'] ?? '',
        $r['mean_distance_lk1'] ?? '',
        $r['mean_distance_other'] ?? '',
        $r['mean_delta_distance'] ?? '',
        $r['mean_dynamik'] ?? '',
        $r['mean_stabilitaet'] ?? '',
        $r['profile_binding'] ?? '',
        json_encode($r['risk_counts'] ?? [], JSON_UNESCAPED_UNICODE),
    ], ';');
}
fclose($fh);

$lk1 = $payload['profiles']['lehrkraft_1'] ?? [];
$other = $payload['profiles']['andere_lehrkraft'] ?? [];
$rowsSorted = $summary;
usort($rowsSorted, fn($a, $b) => (($b['mean_delta_distance'] ?? 0) <=> ($a['mean_delta_distance'] ?? 0)));

$lines = [];
$lines[] = '6.x.24 Kontrafaktische Lehrkraftprofilwirkung auf gruppendynamische Stabilität';
$lines[] = str_repeat('=', 78);
$lines[] = '';
$lines[] = '1. Datenbasis';
$lines[] = '- Profil Lehrkraft 1: n=' . ($lk1['n'] ?? 'n/a');
$lines[] = '- Profil andere Lehrkraft: n=' . ($other['n'] ?? 'n/a');
$lines[] = '- Gruppenzeitpunkte: n=' . count($payload['group_projection_rows'] ?? []);
$lines[] = '';
$lines[] = '2. Gruppenzusammenfassung';
foreach ($rowsSorted as $r) {
    $lines[] = '- Gruppe ' . $r['gruppe_id']
        . ': ΔDistanz=' . fnum($r['mean_delta_distance'] ?? null)
        . ', D(LK1)=' . fnum($r['mean_distance_lk1'] ?? null)
        . ', D(andere)=' . fnum($r['mean_distance_other'] ?? null)
        . ', Dynamik=' . fnum($r['mean_dynamik'] ?? null)
        . ', Stabilität=' . fnum($r['mean_stabilitaet'] ?? null)
        . ', Bindung=' . ($r['profile_binding'] ?? '')
        . ', Risiko=' . json_encode($r['risk_counts'] ?? [], JSON_UNESCAPED_UNICODE);
}
$lines[] = '';
$lines[] = '3. Interpretation';
$lines[] = 'Ein positives ΔDistanz bedeutet, dass die Gruppendynamik näher am Profil von Lehrkraft 1 liegt als am kontrafaktischen Profil anderer Lehrkräfte. Damit wird keine reale Wirkung anderer Lehrkräfte behauptet, sondern eine Profilanfälligkeit des Gruppensystems modelliert.';
$lines[] = '';
$lines[] = '4. Methodischer Hinweis';
$lines[] = 'Da frzk_group_emotion keine vollständigen 7D-Gruppenvektoren enthält, wird ein 7D-Proxy aus affektivem Zustand, Kohärenz, Stabilität und Dynamik gebildet. Sobald echte gruppensemantische 7D-Werte vorliegen, sollte der Proxy durch diese Werte ersetzt werden.';

$reportFile = $outDir . DIRECTORY_SEPARATOR . '6x24_analysebericht.txt';
file_put_contents($reportFile, implode("\n", $lines));

echo "OK: Analyse erzeugt in $outDir\n";
