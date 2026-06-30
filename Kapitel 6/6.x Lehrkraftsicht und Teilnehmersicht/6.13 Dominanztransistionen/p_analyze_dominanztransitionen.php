<?php
// analyze_dominanztransitionen.php

$infile = "dominanztransitionen.json";
$outfile = "dominanztransitionen_bericht.html";

$data = json_decode(file_get_contents($infile), true);
$transitions = $data["transitions"];

if (!$transitions) {
    die("Keine Transitionen vorhanden.\n");
}

$counts = [];
$stable = 0;
$dims = [];

foreach ($transitions as $t) {
    $counts[$t["transition"]] = ($counts[$t["transition"]] ?? 0) + 1;
    if ($t["stable"]) $stable++;
    $dims[$t["from"]] = true;
    $dims[$t["to"]] = true;
}

arsort($counts);
$dims = array_keys($dims);
sort($dims);

$matrix = [];
foreach ($dims as $a) {
    foreach ($dims as $b) {
        $matrix[$a][$b] = 0;
    }
}
foreach ($transitions as $t) {
    $matrix[$t["from"]][$t["to"]]++;
}

$html = "<!doctype html><html><head><meta charset='utf-8'>
<title>Dominanztransitionen</title>
<style>
body{font-family:Arial,sans-serif;margin:30px}
table{border-collapse:collapse;margin:20px 0}
td,th{border:1px solid #ccc;padding:6px 9px;text-align:center}
.bar{background:#ddd;height:18px;display:inline-block}
</style></head><body>";

$html .= "<h1>Auswertung Dominanztransitionen</h1>";
$html .= "<p><b>Datensätze:</b> ".$data["summary"]["n_records"]."</p>";
$html .= "<p><b>Sequenzen:</b> ".$data["summary"]["n_sequences"]."</p>";
$html .= "<p><b>Transitionen:</b> ".$data["summary"]["n_transitions"]."</p>";
$html .= "<p><b>Stabilitätsrate:</b> ".round($data["summary"]["stability_rate"], 4)."</p>";

$html .= "<h2>Häufigste Übergänge</h2><table><tr><th>Transition</th><th>Anzahl</th><th>Grafik</th></tr>";
$max = max($counts);
foreach (array_slice($counts, 0, 20) as $tr => $c) {
    $w = round(($c / $max) * 300);
    $html .= "<tr><td>$tr</td><td>$c</td><td><span class='bar' style='width:".$w."px'></span></td></tr>";
}
$html .= "</table>";

$html .= "<h2>Transitionsmatrix</h2><table><tr><th>D(t) \\ D(t+1)</th>";
foreach ($dims as $d) $html .= "<th>$d</th>";
$html .= "</tr>";

foreach ($dims as $from) {
    $html .= "<tr><th>$from</th>";
    foreach ($dims as $to) {
        $html .= "<td>".$matrix[$from][$to]."</td>";
    }
    $html .= "</tr>";
}
$html .= "</table>";

$html .= "<h2>FRZK-Deutung</h2>";
$html .= "<p>Stabile Übergänge zeigen Attraktorbindung. Dominanzwechsel zeigen funktionale Zustandsverschiebungen. 
Besonders relevant sind Übergänge wie Motivation→Regulation, Kognition→Performanz oder Affektiv→Regulation, 
weil sie nicht nur eine neue Dominanz anzeigen, sondern eine Veränderung der pädagogischen Zustandslogik.</p>";

$html .= "</body></html>";

file_put_contents($outfile, $html);
echo "Erzeugt: $outfile\n";
?>