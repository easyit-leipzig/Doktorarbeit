<?php
/**
 * 6.x.10 Emergente Gruppenmuster – Analyse-/Visualisierungsskript (PHP)
 * Liest JSON und erzeugt Markdown, CSV und einfache SVG-Grafiken.
 */

declare(strict_types=1);

$INFILE = '6x10_emergente_gruppenmuster.json';
$REPORT = '6x10_emergente_gruppenmuster_report_php.md';
$CSV = '6x10_group_centroids_php.csv';
$OUTDIR = 'plots_6x10_emergente_gruppenmuster_php';

function fmt($v, int $d=4): string { return $v === null ? 'n/a' : number_format((float)$v, $d, '.', ''); }
function ensure_dir($dir): void { if (!is_dir($dir)) mkdir($dir, 0777, true); }
function svg_bar(array $labels, array $values, string $title, string $ylabel, string $file): void {
    $w=900; $h=500; $m=70; $plotW=$w-2*$m; $plotH=$h-2*$m;
    $max = max(array_map('abs', $values)); if ($max <= 0) $max = 1;
    $barW = $plotW / max(1, count($values));
    $svg = "<svg xmlns='http://www.w3.org/2000/svg' width='$w' height='$h'>";
    $svg .= "<rect width='100%' height='100%' fill='white'/><text x='".($w/2)."' y='30' text-anchor='middle' font-size='18'>$title</text>";
    $svg .= "<line x1='$m' y1='".($h-$m)."' x2='".($w-$m)."' y2='".($h-$m)."' stroke='black'/><line x1='$m' y1='$m' x2='$m' y2='".($h-$m)."' stroke='black'/>";
    foreach ($values as $i=>$v) {
        $x = $m + $i*$barW + 8;
        $bh = abs($v)/$max*$plotH;
        $y = $h-$m-$bh;
        $svg .= "<rect x='$x' y='$y' width='".max(4,$barW-16)."' height='$bh' fill='#888'/>";
        $svg .= "<text x='".($x+$barW/2-8)."' y='".($h-$m+20)."' text-anchor='middle' font-size='12'>".htmlspecialchars((string)$labels[$i])."</text>";
    }
    $svg .= "<text x='20' y='".($h/2)."' transform='rotate(-90 20,".($h/2).")' text-anchor='middle' font-size='13'>$ylabel</text></svg>";
    file_put_contents($file, $svg);
}

if (!file_exists($INFILE)) die("Fehler: $INFILE nicht gefunden. Bitte zuerst Exportskript ausführen.\n");
$data = json_decode(file_get_contents($INFILE), true);
if (!$data) die("Fehler: JSON konnte nicht gelesen werden.\n");
ensure_dir($OUTDIR);

$dims = $data['meta']['dimensions'];
$fh = fopen($CSV, 'w');
fputcsv($fh, array_merge(['gruppe_id','n_records','n_participants','date_min','date_max'], $dims, ['dominant_axis','mean_d_semantisch','mean_semantische_breite','mean_euclidean_drift','mean_cosine_transition','attraktoranteil','mean_emotion_valenz','mean_emotion_aktivierung']), ';');
foreach ($data['groups'] as $gid=>$g) {
    $row = [$gid, $g['n_records'], $g['n_participants'], $g['date_min'], $g['date_max']];
    foreach ($dims as $d) $row[] = $g['centroid_7d'][$d] ?? null;
    $row[] = $g['dominant_axis'];
    $row[] = $g['mean_d_semantisch'];
    $row[] = $g['mean_semantische_breite'];
    $row[] = $g['drift_summary']['mean_euclidean_drift'];
    $row[] = $g['drift_summary']['mean_cosine_transition'];
    $row[] = $g['attractor_summary']['share_cosine_ge_0_95'];
    $row[] = $g['emotion_summary']['mean_valenz'];
    $row[] = $g['emotion_summary']['mean_aktivierung'];
    fputcsv($fh, $row, ';');
}
fclose($fh);

$labels = array_keys($data['groups']);
$drift = array_map(fn($gid) => (float)($data['groups'][$gid]['drift_summary']['mean_euclidean_drift'] ?? 0), $labels);
$attr = array_map(fn($gid) => (float)($data['groups'][$gid]['attractor_summary']['share_cosine_ge_0_95'] ?? 0), $labels);
$val = array_map(fn($gid) => (float)($data['groups'][$gid]['emotion_summary']['mean_valenz'] ?? 0), $labels);
svg_bar($labels, $drift, 'Abb. 6.x.10 – Mittlere Drift je Gruppe', 'Euklidische Drift', "$OUTDIR/abb_6x10_mittlere_drift_je_gruppe.svg");
svg_bar($labels, $attr, 'Abb. 6.x.10 – Attraktoranteil je Gruppe', 'Anteil Kosinus ≥ 0.95', "$OUTDIR/abb_6x10_attraktoranteil_je_gruppe.svg");
svg_bar($labels, $val, 'Abb. 6.x.10 – Emotionsvalenz je Gruppe', 'Valenz', "$OUTDIR/abb_6x10_emotionsvalenz_je_gruppe.svg");

$lines = [];
$lines[] = '# '.$data['meta']['auswertung'].' – PHP-Analysebericht';
$lines[] = '';
$lines[] = '## Datenbasis';
$lines[] = 'Die Auswertung liest `'.$INFILE.'` ohne Lehrkraftunterscheidung.';
$lines[] = 'Datensätze: **'.$data['global_summary']['n_records'].'**, Gruppen: **'.$data['global_summary']['n_groups'].'**.';
$lines[] = '';
$lines[] = '## Gruppenprofile';
$lines[] = '| Gruppe | n | TN | Dominanzachse | Dichte | Drift | Übergangs-Kosinus | Attraktoranteil | Valenz | Aktivierung |';
$lines[] = '|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|';
foreach ($data['groups'] as $gid=>$g) {
    $lines[] = '| '.$gid.' | '.$g['n_records'].' | '.$g['n_participants'].' | '.$g['dominant_axis'].' | '.fmt($g['mean_d_semantisch']).' | '.fmt($g['drift_summary']['mean_euclidean_drift']).' | '.fmt($g['drift_summary']['mean_cosine_transition']).' | '.fmt($g['attractor_summary']['share_cosine_ge_0_95']).' | '.fmt($g['emotion_summary']['mean_valenz']).' | '.fmt($g['emotion_summary']['mean_aktivierung']).' |';
}
$lines[] = '';
$lines[] = '## Kurzinterpretation';
$lines[] = 'Emergente Gruppenmuster werden hier durch wiederkehrende Dominanzachsen, geringe Drift, hohe Übergangsähnlichkeit, kollektive Emotionslagen und hohe Attraktoranteile operationalisiert.';
file_put_contents($REPORT, implode("\n", $lines));

echo "OK: $REPORT geschrieben\n";
echo "OK: $CSV geschrieben\n";
echo "OK: SVG-Grafiken in $OUTDIR geschrieben\n";
