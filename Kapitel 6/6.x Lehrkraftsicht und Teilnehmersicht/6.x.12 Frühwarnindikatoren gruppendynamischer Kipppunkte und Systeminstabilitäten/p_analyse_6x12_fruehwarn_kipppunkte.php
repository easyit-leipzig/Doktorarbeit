<?php
/**
 * 6.x.12 Frühwarnindikatoren gruppendynamischer Kipppunkte und Systeminstabilitäten
 * Analyse-/Auswertungsskript PHP
 *
 * Liest 6x12_fruehwarn_kipppunkte.json und erzeugt:
 * - CSV Tabellen
 * - HTML-Bericht
 *
 * Für Grafiken bitte das Python-Analyseskript verwenden.
 */

$infile = __DIR__ . DIRECTORY_SEPARATOR . '6x12_fruehwarn_kipppunkte.json';
$outdir = __DIR__ . DIRECTORY_SEPARATOR . '6x12_fruehwarn_kipppunkte_output_php';
$dimensions = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];

if (!file_exists($infile)) {
    die("FEHLER: JSON nicht gefunden: $infile\nBitte zuerst export_6x12_fruehwarn_kipppunkte.php oder .py ausführen.\n");
}
if (!is_dir($outdir)) {
    mkdir($outdir, 0777, true);
}

$payload = json_decode(file_get_contents($infile), true);
if (!$payload) {
    die("FEHLER: JSON konnte nicht gelesen werden.\n");
}

function fnum($v): float {
    if ($v === null || $v === '') return 0.0;
    return floatval(str_replace(',', '.', (string)$v));
}

function mean(array $xs): float {
    if (count($xs) === 0) return 0.0;
    return array_sum($xs) / count($xs);
}

function stddev(array $xs): float {
    if (count($xs) === 0) return 0.0;
    $m = mean($xs);
    $s = 0.0;
    foreach ($xs as $x) $s += ($x - $m) * ($x - $m);
    return sqrt($s / count($xs));
}

function zscores(array $xs): array {
    $m = mean($xs);
    $sd = stddev($xs);
    if ($sd == 0.0) return array_fill(0, count($xs), 0.0);
    return array_map(fn($x) => ($x - $m) / $sd, $xs);
}

function dominantDimension(array $row, array $dimensions): string {
    $best = '';
    $bestVal = -INF;
    foreach ($dimensions as $d) {
        $v = abs(fnum($row["mean_$d"] ?? 0));
        if ($v > $bestVal) {
            $bestVal = $v;
            $best = $d;
        }
    }
    return $best;
}

function percentile(array $xs, float $p): float {
    if (count($xs) === 0) return 0.0;
    sort($xs, SORT_NUMERIC);
    $idx = ($p / 100.0) * (count($xs) - 1);
    $lo = (int)floor($idx);
    $hi = (int)ceil($idx);
    if ($lo == $hi) return $xs[$lo];
    return $xs[$lo] + ($xs[$hi] - $xs[$lo]) * ($idx - $lo);
}

function writeCsv(string $path, array $rows): void {
    $fh = fopen($path, 'w');
    if (!$fh) return;
    if (count($rows) > 0) {
        fputcsv($fh, array_keys($rows[0]), ';');
        foreach ($rows as $r) fputcsv($fh, $r, ';');
    }
    fclose($fh);
}

function analyseScope(array $scopeData, array $dimensions): array {
    $rows = $scopeData['lehrkraft_daily'] ?? [];
    usort($rows, function($a, $b) {
        if (intval($a['gruppe_id']) === intval($b['gruppe_id'])) return strcmp($a['datum'], $b['datum']);
        return intval($a['gruppe_id']) <=> intval($b['gruppe_id']);
    });

    $prevByGroup = [];
    foreach ($rows as $i => &$r) {
        $gid = (string)$r['gruppe_id'];
        $vec = [];
        foreach ($dimensions as $d) $vec[] = fnum($r["mean_$d"] ?? 0);
        $dom = dominantDimension($r, $dimensions);
        $r['dominante_dimension_calc'] = $dom;
        $r['varianzlast'] = mean(array_map(fn($d) => fnum($r["var_$d"] ?? 0), $dimensions));

        if (!isset($prevByGroup[$gid])) {
            $r['drift'] = 0.0;
            $r['dominanzwechsel'] = 0;
        } else {
            $prev = $prevByGroup[$gid];
            $sum = 0.0;
            foreach ($vec as $k => $v) $sum += ($v - $prev['vec'][$k]) * ($v - $prev['vec'][$k]);
            $r['drift'] = sqrt($sum);
            $r['dominanzwechsel'] = ($dom !== $prev['dom']) ? 1 : 0;
        }
        $r['polaritaet_negativ'] = -fnum($r['polaritaet_index'] ?? 0);
        $prevByGroup[$gid] = ['vec' => $vec, 'dom' => $dom];
    }
    unset($r);

    $driftZ = zscores(array_map(fn($r) => fnum($r['drift'] ?? 0), $rows));
    $varZ = zscores(array_map(fn($r) => fnum($r['varianzlast'] ?? 0), $rows));
    $stdZ = zscores(array_map(fn($r) => fnum($r['d_semantisch_std'] ?? 0), $rows));
    $breiteZ = zscores(array_map(fn($r) => fnum($r['semantische_breite'] ?? 0), $rows));
    $polZ = zscores(array_map(fn($r) => fnum($r['polaritaet_negativ'] ?? 0), $rows));

    foreach ($rows as $i => &$r) {
        $r['risiko_score'] =
            0.25 * $driftZ[$i] +
            0.15 * $varZ[$i] +
            0.15 * $stdZ[$i] +
            0.15 * $breiteZ[$i] +
            0.10 * $polZ[$i] +
            0.10 * fnum($r['dominanzwechsel'] ?? 0);
    }
    unset($r);

    $scores = array_map(fn($r) => fnum($r['risiko_score']), $rows);
    $q70 = percentile($scores, 70);
    $q85 = percentile($scores, 85);
    foreach ($rows as &$r) {
        $x = fnum($r['risiko_score']);
        $r['risiko_klasse'] = ($x >= $q85) ? 'hoch' : (($x >= $q70) ? 'latent' : 'niedrig');
    }
    unset($r);

    $groups = [];
    foreach ($rows as $r) {
        $gid = (string)$r['gruppe_id'];
        if (!isset($groups[$gid])) $groups[$gid] = [];
        $groups[$gid][] = $r;
    }
    $summary = [];
    foreach ($groups as $gid => $gr) {
        $scores = array_map(fn($r) => fnum($r['risiko_score']), $gr);
        $summary[] = [
            'gruppe_id' => $gid,
            'n' => count($gr),
            'risiko_mean' => mean($scores),
            'risiko_max' => max($scores),
            'drift_mean' => mean(array_map(fn($r) => fnum($r['drift']), $gr)),
            'varianzlast_mean' => mean(array_map(fn($r) => fnum($r['varianzlast']), $gr)),
            'dominanzwechsel_sum' => array_sum(array_map(fn($r) => intval($r['dominanzwechsel']), $gr)),
            'hoch_count' => count(array_filter($gr, fn($r) => $r['risiko_klasse'] === 'hoch')),
            'latent_count' => count(array_filter($gr, fn($r) => $r['risiko_klasse'] === 'latent')),
        ];
    }
    usort($summary, fn($a, $b) => fnum($b['risiko_max']) <=> fnum($a['risiko_max']));

    return ['rows' => $rows, 'summary' => $summary];
}

$html = "<html><head><meta charset='utf-8'><title>6.x.12 Frühwarnindikatoren</title>";
$html .= "<style>body{font-family:Arial,sans-serif;line-height:1.4} table{border-collapse:collapse;margin:1em 0}td,th{border:1px solid #ccc;padding:4px 7px}th{background:#eee}</style></head><body>";
$html .= "<h1>6.x.12 Frühwarnindikatoren gruppendynamischer Kipppunkte und Systeminstabilitäten</h1>";
$html .= "<p>Der Risikoindex kombiniert Drift, Varianzlast, semantische Breite, Dichte-Streuung, Polaritätsbelastung und Dominanzwechsel. Grafiken werden im Python-Analyseskript erzeugt.</p>";

foreach ($payload['scopes'] as $scopeName => $scopeData) {
    $result = analyseScope($scopeData, $dimensions);
    writeCsv($outdir . DIRECTORY_SEPARATOR . "daten_6x12_fruehwarn_$scopeName.csv", $result['rows']);
    writeCsv($outdir . DIRECTORY_SEPARATOR . "gruppenuebersicht_6x12_$scopeName.csv", $result['summary']);

    $html .= "<h2>Scope: " . htmlspecialchars($scopeName) . "</h2>";
    $html .= "<table><tr><th>Gruppe</th><th>n</th><th>Risiko Ø</th><th>Risiko max</th><th>Drift Ø</th><th>Varianzlast Ø</th><th>Dominanzwechsel</th><th>hoch</th><th>latent</th></tr>";
    foreach ($result['summary'] as $s) {
        $html .= "<tr><td>{$s['gruppe_id']}</td><td>{$s['n']}</td><td>" . round($s['risiko_mean'], 4) . "</td><td>" . round($s['risiko_max'], 4) . "</td><td>" . round($s['drift_mean'], 4) . "</td><td>" . round($s['varianzlast_mean'], 4) . "</td><td>{$s['dominanzwechsel_sum']}</td><td>{$s['hoch_count']}</td><td>{$s['latent_count']}</td></tr>";
    }
    $html .= "</table>";
}

$html .= "</body></html>";
file_put_contents($outdir . DIRECTORY_SEPARATOR . 'bericht_6x12_fruehwarn_kipppunkte.html', $html);
echo "OK: PHP-Auswertung erzeugt in $outdir\n";
