<?php
/**
 * Auswertungspunkt 2: Zeitversetzte Resonanzvalidierung – Analyse/Visualisierung mit GD
 *
 * Liest zeitversetzte_resonanzvalidierung_export.json und erzeugt:
 * - summary_by_lag.csv
 * - bericht_zeitversetzte_resonanzvalidierung.md
 * - PNG-Balkendiagramme mit GD
 */

declare(strict_types=1);

const INPUT_FILE = 'zeitversetzte_resonanzvalidierung_export.json';
const OUT_DIR = 'zeitversetzte_resonanzvalidierung_output_php';

if (!extension_loaded('gd')) {
    fwrite(STDERR, "PHP-GD ist nicht geladen. Bitte in php.ini aktivieren.\n");
    exit(1);
}
if (!file_exists(INPUT_FILE)) {
    fwrite(STDERR, "JSON-Datei nicht gefunden: ".INPUT_FILE."\n");
    exit(1);
}
if (!is_dir(OUT_DIR)) mkdir(OUT_DIR, 0777, true);

$payload = json_decode(file_get_contents(INPUT_FILE), true, 512, JSON_THROW_ON_ERROR);

function fmt(?float $v): string { return $v === null ? '—' : number_format($v, 4, '.', ''); }
function rows_from_payload(array $payload): array {
    $rows = [];
    foreach ($payload['scopes'] as $scopeName => $scope) {
        foreach ($scope['summary_by_lag'] as $lag => $s) {
            $rows[] = [
                'scope' => $scopeName,
                'lag_sitzungen' => (int)$lag,
                'n_matches' => (int)$s['n_matches'],
                'kosinus_mean' => $s['kosinus_mean'],
                'kosinus_median' => $s['kosinus_median'],
                'distanz_mean' => $s['distanz_mean'],
                'distanz_median' => $s['distanz_median'],
                'korrelation_mean' => $s['korrelation_mean'],
                'korrelation_median' => $s['korrelation_median'],
            ];
        }
    }
    return $rows;
}
function write_csv(array $rows): void {
    $f = fopen(OUT_DIR.'/summary_by_lag.csv', 'w');
    fputcsv($f, array_keys($rows[0]), ';');
    foreach ($rows as $r) fputcsv($f, $r, ';');
    fclose($f);
}
function color($im, int $r, int $g, int $b) { return imagecolorallocate($im, $r, $g, $b); }
function plot_metric(array $rows, string $metric, string $ylabel, string $filename): void {
    $w = 1000; $h = 560; $mL = 80; $mB = 80; $mT = 50; $mR = 40;
    $im = imagecreatetruecolor($w, $h);
    $white = color($im, 255,255,255); $black = color($im, 0,0,0); $gray = color($im, 220,220,220);
    $palette = [color($im, 70,110,180), color($im, 80,150,90), color($im, 190,110,70)];
    imagefill($im, 0, 0, $white);
    imagestring($im, 5, $mL, 18, 'Zeitversetzte Resonanzvalidierung - '.$ylabel, $black);
    $scopes = array_values(array_unique(array_column($rows, 'scope'))); sort($scopes);
    $lags = array_values(array_unique(array_column($rows, 'lag_sitzungen'))); sort($lags);
    $vals = array_values(array_filter(array_map(fn($r) => $r[$metric], $rows), fn($v) => $v !== null));
    $minVal = min(0.0, count($vals) ? min($vals) : 0.0); $maxVal = max(1.0, count($vals) ? max($vals) : 1.0);
    if ($metric === 'distanz_mean') { $minVal = 0.0; }
    $plotW = $w - $mL - $mR; $plotH = $h - $mT - $mB;
    imageline($im, $mL, $mT, $mL, $h-$mB, $black); imageline($im, $mL, $h-$mB, $w-$mR, $h-$mB, $black);
    for ($g=0; $g<=5; $g++) {
        $y = (int)($mT + $g*$plotH/5); imageline($im, $mL, $y, $w-$mR, $y, $gray);
        $val = $maxVal - $g*($maxVal-$minVal)/5; imagestring($im, 2, 8, $y-7, number_format($val,2), $black);
    }
    $groupW = $plotW / max(1, count($lags)); $barW = $groupW / (count($scopes)+1.5);
    foreach ($lags as $li => $lag) {
        $xBase = $mL + $li*$groupW + $barW*0.75;
        imagestring($im, 3, (int)($mL + $li*$groupW + $groupW/2 - 5), $h-$mB+20, (string)$lag, $black);
        foreach ($scopes as $si => $scope) {
            $row = null; foreach ($rows as $r) if ($r['scope']===$scope && $r['lag_sitzungen']===$lag) { $row=$r; break; }
            $v = $row[$metric] ?? null; if ($v === null) continue;
            $ratio = ($v - $minVal) / max(0.000001, ($maxVal - $minVal));
            $barH = $ratio * $plotH; $x1 = (int)($xBase + $si*$barW); $x2 = (int)($x1 + $barW*0.8);
            $y1 = (int)($h-$mB-$barH); $y2 = $h-$mB;
            imagefilledrectangle($im, $x1, $y1, $x2, $y2, $palette[$si % count($palette)]);
        }
    }
    foreach ($scopes as $si => $scope) {
        $x = $mL + 20 + $si*260; $y = $h - 35;
        imagefilledrectangle($im, $x, $y, $x+16, $y+16, $palette[$si % count($palette)]);
        imagestring($im, 3, $x+24, $y+2, $scope, $black);
    }
    imagestring($im, 3, $w/2-60, $h-25, 'Lag in Folgesitzungen', $black);
    imagepng($im, OUT_DIR.'/'.$filename); imagedestroy($im);
}
function interpretation(array $rows): string {
    $kos = array_values(array_filter($rows, fn($r) => $r['kosinus_mean'] !== null));
    usort($kos, fn($a,$b) => $b['kosinus_mean'] <=> $a['kosinus_mean']);
    $dist = array_values(array_filter($rows, fn($r) => $r['distanz_mean'] !== null));
    usort($dist, fn($a,$b) => $a['distanz_mean'] <=> $b['distanz_mean']);
    $out = [];
    if ($kos) $out[] = 'Die stärkste mittlere Richtungsresonanz liegt in `'.$kos[0]['scope'].'` bei Lag n='.$kos[0]['lag_sitzungen'].' mit Kosinus='.fmt((float)$kos[0]['kosinus_mean']).'.';
    if ($dist) $out[] = 'Die geringste mittlere euklidische Distanz liegt in `'.$dist[0]['scope'].'` bei Lag n='.$dist[0]['lag_sitzungen'].' mit Distanz='.fmt((float)$dist[0]['distanz_mean']).'.';
    $out[] = 'Relevant ist, ob eine der Verzögerungen n=1, n=2 oder n=3 stabil höhere Kosinuswerte und niedrigere Distanzen zeigt. Dann wird zeitversetzte pädagogische Kopplung sichtbar.';
    return implode("\n\n", $out);
}
function write_report(array $payload, array $rows): void {
    $md = [];
    $md[] = '# Auswertungspunkt 2 – Zeitversetzte Resonanzvalidierung';
    $md[] = '';
    $md[] = 'Verglichen wird L_t mit T_{t+n}; n bezeichnet reale Folgesitzungen derselben Gruppe und desselben Teilnehmers.';
    $md[] = '';
    $md[] = '| Sicht | Lag | n | Kosinus Mittel | Distanz Mittel | Korrelation Mittel |';
    $md[] = '|---|---:|---:|---:|---:|---:|';
    foreach ($rows as $r) $md[] = '| '.$r['scope'].' | '.$r['lag_sitzungen'].' | '.$r['n_matches'].' | '.fmt($r['kosinus_mean']).' | '.fmt($r['distanz_mean']).' | '.fmt($r['korrelation_mean']).' |';
    $md[] = ''; $md[] = '## Automatische Interpretation'; $md[] = interpretation($rows);
    file_put_contents(OUT_DIR.'/bericht_zeitversetzte_resonanzvalidierung.md', implode("\n", $md));
}

$rows = rows_from_payload($payload);
if (!$rows) { fwrite(STDERR, "Keine auswertbaren Daten.\n"); exit(1); }
write_csv($rows);
plot_metric($rows, 'kosinus_mean', 'mittlere Kosinusaehnlichkeit', 'kosinus_by_lag.png');
plot_metric($rows, 'distanz_mean', 'mittlere euklidische Distanz', 'distanz_by_lag.png');
plot_metric($rows, 'korrelation_mean', 'mittlere Pearson-Korrelation', 'korrelation_by_lag.png');
write_report($payload, $rows);
echo "Analyse abgeschlossen: ".realpath(OUT_DIR).PHP_EOL;
