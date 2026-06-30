<?php
/**
 * 6.x.9 Attraktor- und Dominanzstrukturen – Analyse-/Visualisierungsskript PHP
 * Liest 6x9_attraktor_dominanzstrukturen.json und erzeugt TXT, CSV und einfache SVG-Grafiken.
 */
$jsonFile = __DIR__ . DIRECTORY_SEPARATOR . '6x9_attraktor_dominanzstrukturen.json';
$outDir = __DIR__ . DIRECTORY_SEPARATOR . '6x9_attraktor_dominanzstrukturen_output_php';
$dimensions = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];
if (!is_dir($outDir)) { mkdir($outDir, 0777, true); }
if (!file_exists($jsonFile)) { die("JSON nicht gefunden: $jsonFile\n"); }
$payload = json_decode(file_get_contents($jsonFile), true);
$records = $payload['records'] ?? [];
if (count($records) === 0) { die("Keine Datensätze im JSON.\n"); }

function num($v): float { return is_numeric($v) ? floatval($v) : 0.0; }
function csv_write(string $file, array $rows): void {
    $fh = fopen($file, 'w');
    foreach ($rows as $row) { fputcsv($fh, $row, ';'); }
    fclose($fh);
}
function svg_bar(string $file, array $values, string $title): void {
    $w=900; $h=480; $m=70; $max=max($values ?: [1]); $n=max(count($values),1); $bw=($w-2*$m)/$n*0.75; $gap=($w-2*$m)/$n*0.25;
    $svg="<svg xmlns='http://www.w3.org/2000/svg' width='$w' height='$h'><rect width='100%' height='100%' fill='white'/><text x='$m' y='35' font-size='20'>$title</text>";
    $i=0;
    foreach ($values as $label=>$val) {
        $x=$m+$i*($bw+$gap+$gap); $barH=($h-140)*($max>0?$val/$max:0); $y=$h-80-$barH;
        $svg.="<rect x='$x' y='$y' width='$bw' height='$barH' fill='#777'/><text x='$x' y='".($h-55)."' font-size='12' transform='rotate(35 $x ".($h-55).")'>$label</text><text x='$x' y='".($y-5)."' font-size='12'>".round($val,2)."</text>";
        $i++;
    }
    $svg.="</svg>"; file_put_contents($file,$svg);
}

$domCounts = array_fill_keys($dimensions, 0);
$stateCounts = [];
$reaction = [];
$groupDom = [];
foreach ($records as $r) {
    $dim = $r['dominante_dimension'] ?? 'unbekannt';
    if (!isset($domCounts[$dim])) { $domCounts[$dim]=0; }
    $domCounts[$dim]++;
    $state = $dim . '|p=' . intval(num($r['polaritaet_gesamt'] ?? 0));
    $stateCounts[$state] = ($stateCounts[$state] ?? 0) + 1;
    $g = strval($r['gruppe_id'] ?? 'NA');
    if (!isset($groupDom[$g])) { $groupDom[$g] = array_fill_keys($dimensions, 0); }
    if (isset($groupDom[$g][$dim])) { $groupDom[$g][$dim]++; }
    if (!isset($reaction[$dim])) { $reaction[$dim] = ['n'=>0,'performanz'=>0,'motivation'=>0,'regulation'=>0]; }
    $perf = (5-num($r['lernfortschritt']??0) + 5-num($r['beherrscht_thema']??0) + 5-num($r['basiswissen']??0) + 5-num($r['transferdenken']??0))/4;
    $mot = (5-num($r['mitarbeit']??0) + 5-num($r['fleiss']??0) + 5-num($r['konzentration']??0))/3;
    $reg = (5-num($r['selbststaendigkeit']??0) + 5-num($r['absprachen']??0) + 5-num($r['vorbereitet']??0))/3;
    $reaction[$dim]['n']++; $reaction[$dim]['performanz'] += $perf; $reaction[$dim]['motivation'] += $mot; $reaction[$dim]['regulation'] += $reg;
}
arsort($stateCounts); arsort($domCounts);

$rows = [['dimension','anzahl','anteil_prozent']];
$total = count($records);
foreach ($domCounts as $dim=>$n) { $rows[] = [$dim,$n,round($n/$total*100,2)]; }
csv_write($outDir . DIRECTORY_SEPARATOR . 'tab_6x9_01_dominanzhaeufigkeit.csv', $rows);

$rows = [['zustand','anzahl','anteil_prozent']];
foreach ($stateCounts as $st=>$n) { $rows[] = [$st,$n,round($n/$total*100,2)]; }
csv_write($outDir . DIRECTORY_SEPARATOR . 'tab_6x9_02_attraktor_zustaende.csv', $rows);

$rows = [['dominante_dimension','n','reaktion_performanz','reaktion_motivation','reaktion_regulation']];
foreach ($reaction as $dim=>$v) {
    $n=max($v['n'],1); $rows[] = [$dim,$v['n'],round($v['performanz']/$n,4),round($v['motivation']/$n,4),round($v['regulation']/$n,4)];
}
csv_write($outDir . DIRECTORY_SEPARATOR . 'tab_6x9_03_teilnehmerreaktionen_nach_dominanz.csv', $rows);

svg_bar($outDir . DIRECTORY_SEPARATOR . 'abb_6x9_01_dominanzhaeufigkeit.svg', $domCounts, 'Abb. 6x9-1: Dominanzhäufigkeit');
svg_bar($outDir . DIRECTORY_SEPARATOR . 'abb_6x9_02_attraktor_zustaende.svg', array_slice($stateCounts,0,12,true), 'Abb. 6x9-2: Häufigste Attraktorzustände');

$report = "6.x.9 Attraktor- und Dominanzstrukturen – PHP-Auswertung\n\n";
$report .= "Datengrundlage: $total gematchte Zustände ohne Lehrkraftunterscheidung.\n\n";
$report .= "Dominante Dimensionen:\n";
foreach ($domCounts as $dim=>$n) { $report .= "- $dim: $n (" . round($n/$total*100,2) . " %)\n"; }
$report .= "\nHäufigste Attraktorzustände:\n";
foreach (array_slice($stateCounts,0,8,true) as $st=>$n) { $report .= "- $st: $n\n"; }
$report .= "\nInterpretation: Attraktoren werden als wiederkehrende Dominanz-/Polaritätszustände gelesen. Die Tabellen verbinden diese Zustände mit Teilnehmerreaktionen in Performanz, Motivation und Regulation.\n";
file_put_contents($outDir . DIRECTORY_SEPARATOR . 'bericht_6x9_attraktor_dominanzstrukturen.txt', $report);
echo "OK: PHP-Auswertung erzeugt in $outDir\n";
