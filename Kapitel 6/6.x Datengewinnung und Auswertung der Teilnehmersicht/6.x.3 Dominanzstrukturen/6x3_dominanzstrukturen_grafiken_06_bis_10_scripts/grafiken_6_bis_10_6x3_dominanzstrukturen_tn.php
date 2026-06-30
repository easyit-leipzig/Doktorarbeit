<?php
/**
 * 6.x.3 Dominanzstrukturen – Grafiken 6 bis 10 (PHP/SVG)
 *
 * Erzeugt aus 6x3_dominanzstrukturen_tn.json die folgenden Grafiken als SVG:
 *   06 Heatmap Gruppe × dominante Dimension
 *   07 Dominanznetzwerk der Dimensionen
 *   08 Sankey-/Alluvial-Diagramm der Dominanzwechsel
 *   09 Zeitliche Entwicklung der Dominanzanteile
 *   10 Boxplot der Dominanzwerte nach Gruppe
 *
 * Ablage:
 *   ./6x3_dominanzstrukturen_tn_anlage_grafiken_php/
 *
 * Aufruf:
 *   php grafiken_6_bis_10_6x3_dominanzstrukturen_tn.php
 *   php grafiken_6_bis_10_6x3_dominanzstrukturen_tn.php /pfad/zur/datei.json /ausgabeordner
 *
 * Hinweis:
 *   Das Skript benötigt keine GD- oder Imagick-Erweiterung, weil es reine SVG-Dateien schreibt.
 */

ini_set('memory_limit', '1024M');
set_time_limit(0);

$baseDir = __DIR__;
$inputFile = $argv[1] ?? ($baseDir . DIRECTORY_SEPARATOR . '6x3_dominanzstrukturen_tn.json');
$outputDir = $argv[2] ?? ($baseDir . DIRECTORY_SEPARATOR . '6x3_dominanzstrukturen_tn_anlage_grafiken_php');

$dimensions = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];

if (!file_exists($inputFile)) {
    fwrite(STDERR, "JSON-Datei nicht gefunden: $inputFile\n");
    exit(1);
}
if (!is_dir($outputDir)) {
    mkdir($outputDir, 0777, true);
}

$data = json_decode(file_get_contents($inputFile), true);
if ($data === null) {
    fwrite(STDERR, "JSON konnte nicht gelesen werden.\n");
    exit(1);
}
$records = $data['records'] ?? (is_array($data) ? $data : []);
if (!$records) {
    fwrite(STDERR, "Keine Datensätze gefunden. Erwartet wird ein JSON mit Schlüssel 'records'.\n");
    exit(1);
}

function esc($s): string { return htmlspecialchars((string)$s, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); }
function dimIndex(string $dim, array $dimensions): int { $i = array_search($dim, $dimensions, true); return $i === false ? 999 : $i; }
function num($v): float { return is_numeric($v) ? (float)$v : 0.0; }
function colorGray(float $v): string {
    $v = max(0.0, min(1.0, $v));
    $c = (int)round(245 - 170 * $v);
    return "rgb($c,$c,$c)";
}
function writeSvg(string $path, int $w, int $h, string $body): void {
    $svg = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    $svg .= "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"$w\" height=\"$h\" viewBox=\"0 0 $w $h\">\n";
    $svg .= "<rect width=\"100%\" height=\"100%\" fill=\"white\"/>\n";
    $svg .= $body . "\n</svg>\n";
    file_put_contents($path, $svg);
}
function dominantDimension(array $r): string {
    return strtolower(trim((string)($r['dominante_dimension'] ?? '')));
}
function groupId(array $r): string { return (string)($r['gruppe_id'] ?? ''); }
function teilnehmerId(array $r): string { return (string)($r['teilnehmer_id'] ?? ''); }
function zeitpunkt(array $r): string { return (string)($r['zeitpunkt'] ?? ''); }
function dateOnly(string $z): string { return substr($z, 0, 10); }
function dominanceAbs(array $r): float {
    if (isset($r['dominanz_abs']) && is_numeric($r['dominanz_abs'])) return abs((float)$r['dominanz_abs']);
    if (isset($r['dominante_dimension_wert']) && is_numeric($r['dominante_dimension_wert'])) return abs((float)$r['dominante_dimension_wert']);
    return 0.0;
}
function transitionCounts(array $records, array $dimensions): array {
    $byTn = [];
    foreach ($records as $r) {
        $tid = teilnehmerId($r);
        $zp = zeitpunkt($r);
        $dim = dominantDimension($r);
        if ($tid === '' || $zp === '' || !in_array($dim, $dimensions, true)) continue;
        $byTn[$tid][] = ['zeitpunkt' => $zp, 'dim' => $dim];
    }
    $edges = [];
    foreach ($byTn as $tid => $rows) {
        usort($rows, fn($a, $b) => strcmp($a['zeitpunkt'], $b['zeitpunkt']));
        for ($i=0; $i<count($rows)-1; $i++) {
            $key = $rows[$i]['dim'] . '|' . $rows[$i+1]['dim'];
            $edges[$key] = ($edges[$key] ?? 0) + 1;
        }
    }
    return $edges;
}

// Grafik 06: Heatmap Gruppe × Dimension
function grafik06(array $records, array $dimensions, string $outputDir): void {
    $counts = []; $totals = [];
    foreach ($records as $r) {
        $g = groupId($r); $d = dominantDimension($r);
        if ($g === '' || !in_array($d, $dimensions, true)) continue;
        $counts[$g][$d] = ($counts[$g][$d] ?? 0) + 1;
        $totals[$g] = ($totals[$g] ?? 0) + 1;
    }
    ksort($counts, SORT_NATURAL);
    $groups = array_keys($counts);
    $cellW = 110; $cellH = 34; $left = 120; $top = 80;
    $w = $left + count($dimensions)*$cellW + 40;
    $h = $top + count($groups)*$cellH + 60;
    $body = "<text x=\"30\" y=\"35\" font-size=\"20\" font-family=\"Arial\">Grafik 6: Heatmap der Dominanzanteile nach Gruppe</text>\n";
    foreach ($dimensions as $j => $d) {
        $x = $left + $j*$cellW + $cellW/2;
        $body .= "<text x=\"$x\" y=\"65\" font-size=\"12\" font-family=\"Arial\" text-anchor=\"middle\">".esc($d)."</text>\n";
    }
    foreach ($groups as $i => $g) {
        $y = $top + $i*$cellH;
        $body .= "<text x=\"105\" y=\"".($y+22)."\" font-size=\"12\" font-family=\"Arial\" text-anchor=\"end\">Gruppe ".esc($g)."</text>\n";
        foreach ($dimensions as $j => $d) {
            $v = ($counts[$g][$d] ?? 0) / max(1, $totals[$g]);
            $x = $left + $j*$cellW;
            $fill = colorGray($v);
            $pct = round($v*100);
            $body .= "<rect x=\"$x\" y=\"$y\" width=\"$cellW\" height=\"$cellH\" fill=\"$fill\" stroke=\"#ffffff\"/>\n";
            $body .= "<text x=\"".($x+$cellW/2)."\" y=\"".($y+22)."\" font-size=\"11\" font-family=\"Arial\" text-anchor=\"middle\">$pct%</text>\n";
        }
    }
    writeSvg($outputDir . DIRECTORY_SEPARATOR . 'grafik_06_heatmap_gruppe_dimension.svg', $w, $h, $body);
}

// Grafik 07: Dominanznetzwerk
function grafik07(array $records, array $dimensions, string $outputDir): void {
    $nodeCounts = array_fill_keys($dimensions, 0);
    foreach ($records as $r) {
        $d = dominantDimension($r);
        if (isset($nodeCounts[$d])) $nodeCounts[$d]++;
    }
    $edges = transitionCounts($records, $dimensions);
    $w = 900; $h = 900; $cx = 450; $cy = 450; $radius = 300;
    $maxNode = max(1, max($nodeCounts));
    $maxEdge = max(1, $edges ? max($edges) : 1);
    $pos = [];
    foreach ($dimensions as $i => $d) {
        $angle = 2*pi()*$i/count($dimensions) - pi()/2;
        $pos[$d] = [$cx + $radius*cos($angle), $cy + $radius*sin($angle)];
    }
    $body = "<defs><marker id=\"arrow\" markerWidth=\"10\" markerHeight=\"10\" refX=\"8\" refY=\"3\" orient=\"auto\"><path d=\"M0,0 L0,6 L9,3 z\" fill=\"#555\"/></marker></defs>\n";
    $body .= "<text x=\"30\" y=\"35\" font-size=\"22\" font-family=\"Arial\">Grafik 7: Dominanznetzwerk der Dimensionsübergänge</text>\n";
    foreach ($edges as $key => $n) {
        [$a, $b] = explode('|', $key);
        if (!isset($pos[$a]) || !isset($pos[$b])) continue;
        [$x1, $y1] = $pos[$a]; [$x2, $y2] = $pos[$b];
        $stroke = 1 + 6*$n/$maxEdge;
        if ($a === $b) {
            $body .= "<path d=\"M$x1,$y1 C".($x1+70).",".($y1-70)." ".($x1+90).",".($y1+70)." $x1,$y1\" fill=\"none\" stroke=\"#555\" stroke-width=\"$stroke\" opacity=\"0.35\" marker-end=\"url(#arrow)\"/>\n";
        } else {
            $mx = ($x1+$x2)/2; $my = ($y1+$y2)/2;
            $body .= "<path d=\"M$x1,$y1 Q$mx,$my $x2,$y2\" fill=\"none\" stroke=\"#555\" stroke-width=\"$stroke\" opacity=\"0.30\" marker-end=\"url(#arrow)\"/>\n";
        }
    }
    foreach ($dimensions as $d) {
        [$x, $y] = $pos[$d];
        $r = 30 + 35*$nodeCounts[$d]/$maxNode;
        $body .= "<circle cx=\"$x\" cy=\"$y\" r=\"$r\" fill=\"#dddddd\" stroke=\"#555\"/>\n";
        $body .= "<text x=\"$x\" y=\"".($y-4)."\" font-size=\"13\" font-family=\"Arial\" text-anchor=\"middle\">".esc($d)."</text>\n";
        $body .= "<text x=\"$x\" y=\"".($y+14)."\" font-size=\"12\" font-family=\"Arial\" text-anchor=\"middle\">".$nodeCounts[$d]."</text>\n";
    }
    writeSvg($outputDir . DIRECTORY_SEPARATOR . 'grafik_07_dominanznetzwerk.svg', $w, $h, $body);
}

// Grafik 08: Sankey-/Alluvial-Diagramm
function grafik08(array $records, array $dimensions, string $outputDir): void {
    $edges = transitionCounts($records, $dimensions);
    if (!$edges) return;
    $leftTotals = array_fill_keys($dimensions, 0); $rightTotals = array_fill_keys($dimensions, 0);
    foreach ($edges as $key => $n) { [$a,$b] = explode('|',$key); $leftTotals[$a]+=$n; $rightTotals[$b]+=$n; }
    $total = max(1, array_sum($edges));
    $w = 1000; $h = 700; $top = 80; $bottom = 40; $usable = $h-$top-$bottom; $gap = 8;
    $scale = ($usable - $gap*6) / $total;
    $makePos = function($totals) use ($dimensions, $top, $gap, $scale) {
        $pos=[]; $y=$top;
        foreach ($dimensions as $d) {
            if ($totals[$d] <= 0) continue;
            $hh = max(3, $totals[$d]*$scale);
            $pos[$d] = [$y, $y+$hh]; $y += $hh + $gap;
        }
        return $pos;
    };
    $leftPos=$makePos($leftTotals); $rightPos=$makePos($rightTotals);
    $leftCursor=[]; $rightCursor=[];
    foreach ($leftPos as $d=>$p) $leftCursor[$d]=$p[0];
    foreach ($rightPos as $d=>$p) $rightCursor[$d]=$p[0];
    $body = "<text x=\"30\" y=\"35\" font-size=\"22\" font-family=\"Arial\">Grafik 8: Sankey-Diagramm der Dominanzwechsel</text>\n";
    $body .= "<text x=\"180\" y=\"65\" font-size=\"14\" font-family=\"Arial\" text-anchor=\"middle\">t</text><text x=\"820\" y=\"65\" font-size=\"14\" font-family=\"Arial\" text-anchor=\"middle\">t+1</text>\n";
    uksort($edges, function($ka,$kb) use($dimensions){ [$aa,$ab]=explode('|',$ka); [$ba,$bb]=explode('|',$kb); return (dimIndex($aa,$dimensions)<=>dimIndex($ba,$dimensions)) ?: (dimIndex($ab,$dimensions)<=>dimIndex($bb,$dimensions)); });
    foreach ($edges as $key=>$n) {
        [$a,$b]=explode('|',$key); if (!isset($leftCursor[$a]) || !isset($rightCursor[$b])) continue;
        $hh=max(2,$n*$scale); $y1=$leftCursor[$a]; $y2=$rightCursor[$b]; $leftCursor[$a]+=$hh; $rightCursor[$b]+=$hh;
        $body .= "<path d=\"M220,$y1 C430,$y1 570,$y2 780,$y2 L780,".($y2+$hh)." C570,".($y2+$hh)." 430,".($y1+$hh)." 220,".($y1+$hh)." Z\" fill=\"#999\" opacity=\"0.25\" stroke=\"#777\" stroke-width=\"0.5\"/>\n";
    }
    foreach ([['x'=>180,'tot'=>$leftTotals,'pos'=>$leftPos], ['x'=>820,'tot'=>$rightTotals,'pos'=>$rightPos]] as $side) {
        foreach ($side['pos'] as $d=>$p) {
            [$y0,$y1]=$p; $hh=$y1-$y0; $x=$side['x'];
            $body .= "<rect x=\"".($x-45)."\" y=\"$y0\" width=\"90\" height=\"$hh\" fill=\"#dddddd\" stroke=\"#555\"/>\n";
            $body .= "<text x=\"$x\" y=\"".($y0+$hh/2-2)."\" font-size=\"11\" font-family=\"Arial\" text-anchor=\"middle\">".esc($d)."</text>\n";
            $body .= "<text x=\"$x\" y=\"".($y0+$hh/2+12)."\" font-size=\"10\" font-family=\"Arial\" text-anchor=\"middle\">".$side['tot'][$d]."</text>\n";
        }
    }
    writeSvg($outputDir . DIRECTORY_SEPARATOR . 'grafik_08_sankey_dominanzwechsel.svg', $w, $h, $body);
}

// Grafik 09: Zeitliche Entwicklung
function grafik09(array $records, array $dimensions, string $outputDir): void {
    $counts=[]; $totals=[];
    foreach ($records as $r) {
        $date = dateOnly(zeitpunkt($r)); $d = dominantDimension($r);
        if ($date === '' || !in_array($d, $dimensions, true)) continue;
        $counts[$date][$d] = ($counts[$date][$d] ?? 0) + 1; $totals[$date] = ($totals[$date] ?? 0) + 1;
    }
    ksort($counts);
    if (!$counts) return;
    $dates = array_keys($counts); $n = count($dates);
    $w=1100; $h=650; $left=80; $right=220; $top=70; $bottom=110; $plotW=$w-$left-$right; $plotH=$h-$top-$bottom;
    $body = "<text x=\"30\" y=\"35\" font-size=\"22\" font-family=\"Arial\">Grafik 9: Zeitliche Entwicklung der Dominanzanteile</text>\n";
    $body .= "<line x1=\"$left\" y1=\"".($top+$plotH)."\" x2=\"".($left+$plotW)."\" y2=\"".($top+$plotH)."\" stroke=\"#333\"/><line x1=\"$left\" y1=\"$top\" x2=\"$left\" y2=\"".($top+$plotH)."\" stroke=\"#333\"/>\n";
    for ($i=0; $i<=5; $i++) { $v=$i/5; $y=$top+$plotH-$v*$plotH; $body.="<line x1=\"$left\" y1=\"$y\" x2=\"".($left+$plotW)."\" y2=\"$y\" stroke=\"#eee\"/><text x=\"".($left-10)."\" y=\"".($y+4)."\" font-size=\"10\" font-family=\"Arial\" text-anchor=\"end\">".round($v*100)."%</text>\n"; }
    foreach ($dimensions as $di=>$d) {
        $pts=[];
        foreach ($dates as $i=>$date) {
            $share = ($counts[$date][$d] ?? 0) / max(1, $totals[$date]);
            $x = $left + ($n==1 ? $plotW/2 : $i*$plotW/($n-1)); $y = $top + $plotH - $share*$plotH;
            $pts[] = [$x,$y];
        }
        $dash = $di % 3 == 0 ? '' : ($di % 3 == 1 ? ' stroke-dasharray="6,4"' : ' stroke-dasharray="2,4"');
        $path=''; foreach($pts as $i=>$p){ $path .= ($i==0?'M':'L') . $p[0] . ',' . $p[1] . ' '; }
        $body .= "<path d=\"$path\" fill=\"none\" stroke=\"#333\" stroke-width=\"2\"$dash/>\n";
        foreach($pts as $p){ $body.="<circle cx=\"{$p[0]}\" cy=\"{$p[1]}\" r=\"3\" fill=\"#333\"/>\n"; }
        $ly=$top+20+$di*22; $body.="<line x1=\"".($w-$right+40)."\" y1=\"$ly\" x2=\"".($w-$right+80)."\" y2=\"$ly\" stroke=\"#333\" stroke-width=\"2\"$dash/><text x=\"".($w-$right+88)."\" y=\"".($ly+4)."\" font-size=\"12\" font-family=\"Arial\">".esc($d)."</text>\n";
    }
    $step = max(1, (int)ceil($n/10));
    foreach ($dates as $i=>$date) if ($i % $step == 0) { $x=$left+($n==1?$plotW/2:$i*$plotW/($n-1)); $body.="<text x=\"$x\" y=\"".($top+$plotH+20)."\" font-size=\"10\" font-family=\"Arial\" text-anchor=\"end\" transform=\"rotate(-45 $x ".($top+$plotH+20).")\">".esc($date)."</text>\n"; }
    writeSvg($outputDir . DIRECTORY_SEPARATOR . 'grafik_09_zeitliche_entwicklung_dominanzanteile.svg', $w, $h, $body);
}

// Grafik 10: Boxplot Dominanzwerte nach Gruppe
function quartiles(array $values): array {
    sort($values); $n=count($values); if ($n===0) return [0,0,0,0,0];
    $percentile = function($p) use ($values, $n) { $idx=($n-1)*$p; $lo=(int)floor($idx); $hi=(int)ceil($idx); if($lo===$hi) return $values[$lo]; return $values[$lo]+($values[$hi]-$values[$lo])*($idx-$lo); };
    return [min($values), $percentile(0.25), $percentile(0.5), $percentile(0.75), max($values)];
}
function grafik10(array $records, array $outputDims, string $outputDir): void {
    $byGroup=[];
    foreach($records as $r){ $g=groupId($r); if($g==='') continue; $byGroup[$g][] = dominanceAbs($r); }
    ksort($byGroup, SORT_NATURAL); if(!$byGroup) return;
    $groups=array_keys($byGroup); $all=[]; foreach($byGroup as $vals) $all=array_merge($all,$vals); $max=max(0.0001,max($all));
    $w=1100; $h=650; $left=80; $top=70; $plotW=960; $plotH=480; $bottomY=$top+$plotH; $step=$plotW/max(1,count($groups));
    $body="<text x=\"30\" y=\"35\" font-size=\"22\" font-family=\"Arial\">Grafik 10: Verteilung der Dominanzwerte nach Gruppe</text>\n";
    $body.="<line x1=\"$left\" y1=\"$bottomY\" x2=\"".($left+$plotW)."\" y2=\"$bottomY\" stroke=\"#333\"/><line x1=\"$left\" y1=\"$top\" x2=\"$left\" y2=\"$bottomY\" stroke=\"#333\"/>\n";
    for($i=0;$i<=5;$i++){ $v=$max*$i/5; $y=$bottomY-($v/$max)*$plotH; $body.="<line x1=\"$left\" y1=\"$y\" x2=\"".($left+$plotW)."\" y2=\"$y\" stroke=\"#eee\"/><text x=\"".($left-10)."\" y=\"".($y+4)."\" font-size=\"10\" font-family=\"Arial\" text-anchor=\"end\">".number_format($v,2)."</text>\n"; }
    foreach($groups as $i=>$g){ [$min,$q1,$med,$q3,$mx]=quartiles($byGroup[$g]); $x=$left+$step*$i+$step/2; $boxW=min(55,$step*0.55); $fy=function($v)use($bottomY,$plotH,$max){ return $bottomY-($v/$max)*$plotH; };
        $body.="<line x1=\"$x\" y1=\"".$fy($min)."\" x2=\"$x\" y2=\"".$fy($mx)."\" stroke=\"#333\"/>\n";
        $body.="<line x1=\"".($x-$boxW/3)."\" y1=\"".$fy($min)."\" x2=\"".($x+$boxW/3)."\" y2=\"".$fy($min)."\" stroke=\"#333\"/><line x1=\"".($x-$boxW/3)."\" y1=\"".$fy($mx)."\" x2=\"".($x+$boxW/3)."\" y2=\"".$fy($mx)."\" stroke=\"#333\"/>\n";
        $body.="<rect x=\"".($x-$boxW/2)."\" y=\"".$fy($q3)."\" width=\"$boxW\" height=\"".max(1,$fy($q1)-$fy($q3))."\" fill=\"#ddd\" stroke=\"#333\"/>\n";
        $body.="<line x1=\"".($x-$boxW/2)."\" y1=\"".$fy($med)."\" x2=\"".($x+$boxW/2)."\" y2=\"".$fy($med)."\" stroke=\"#333\" stroke-width=\"2\"/>\n";
        $body.="<text x=\"$x\" y=\"".($bottomY+22)."\" font-size=\"11\" font-family=\"Arial\" text-anchor=\"middle\">".esc($g)."</text>\n";
    }
    writeSvg($outputDir . DIRECTORY_SEPARATOR . 'grafik_10_boxplot_dominanzwerte_nach_gruppe.svg', $w, $h, $body);
}

grafik06($records, $dimensions, $outputDir);
grafik07($records, $dimensions, $outputDir);
grafik08($records, $dimensions, $outputDir);
grafik09($records, $dimensions, $outputDir);
grafik10($records, $dimensions, $outputDir);

$readme = "Grafiken 6 bis 10 – Dominanzstrukturen Teilnehmersicht\n" .
          "======================================================\n\n" .
          "06: grafik_06_heatmap_gruppe_dimension.svg\n" .
          "07: grafik_07_dominanznetzwerk.svg\n" .
          "08: grafik_08_sankey_dominanzwechsel.svg\n" .
          "09: grafik_09_zeitliche_entwicklung_dominanzanteile.svg\n" .
          "10: grafik_10_boxplot_dominanzwerte_nach_gruppe.svg\n";
file_put_contents($outputDir . DIRECTORY_SEPARATOR . 'README_grafiken_06_bis_10.txt', $readme);

echo "Fertig. Ausgabeverzeichnis: $outputDir\n";
foreach (glob($outputDir . DIRECTORY_SEPARATOR . 'grafik_*.svg') as $f) {
    echo '- ' . basename($f) . "\n";
}
