<?php
/**
 * Auswertungspunkt 3: Dominanzkopplungsanalyse mit GD-Grafiken.
 * Aufruf: php 02_analyse_dominanzkopplung.php dominanzkopplung_export.json [outdir]
 */
$JSON = $argv[1] ?? 'dominanzkopplung_export.json';
$OUTDIR = $argv[2] ?? 'dominanzkopplung_output_php';
$DIMS = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];
if (!is_dir($OUTDIR)) mkdir($OUTDIR, 0777, true);
$data = json_decode(file_get_contents($JSON), true);
function avg($arr) { return count($arr) ? array_sum($arr)/count($arr) : 0; }
function writeCsv($path, $rows) { $f=fopen($path,'w'); if (!$rows) { fclose($f); return; } fputcsv($f, array_keys($rows[0]), ';'); foreach($rows as $r) fputcsv($f, $r, ';'); fclose($f); }
function drawBar($path, $summary, $title) {
    $w=900; $h=520; $im=imagecreatetruecolor($w,$h); $bg=imagecolorallocate($im,255,255,255); $fg=imagecolorallocate($im,0,0,0); $bar=imagecolorallocate($im,90,90,90); imagefill($im,0,0,$bg); imagestring($im,5,20,15,$title,$fg);
    $left=70; $bottom=450; $plotW=760; $plotH=350; imageline($im,$left,80,$left,$bottom,$fg); imageline($im,$left,$bottom,$left+$plotW,$bottom,$fg);
    $n=max(1,count($summary)); $bw=$plotW/($n*1.6); $i=0; foreach($summary as $lag=>$rate){ $x=$left+40+$i*($plotW/$n); $bh=$plotH*max(0,min(1,$rate)); imagefilledrectangle($im,$x,$bottom-$bh,$x+$bw,$bottom,$bar); imagestring($im,4,$x,$bottom+10,"Lag $lag",$fg); imagestring($im,3,$x,$bottom-$bh-18,number_format($rate,2),$fg); $i++; }
    imagestring($im,4,20,470,'Dominanz-Match-Rate', $fg); imagepng($im,$path); imagedestroy($im);
}
function drawMatrix($path, $matrix, $dims, $title) {
    $cell=70; $left=150; $top=70; $w=$left+$cell*count($dims)+50; $h=$top+$cell*count($dims)+120; $im=imagecreatetruecolor($w,$h); $bg=imagecolorallocate($im,255,255,255); $fg=imagecolorallocate($im,0,0,0); imagefill($im,0,0,$bg); imagestring($im,5,20,15,$title,$fg);
    foreach($dims as $i=>$r){ imagestring($im,3,10,$top+$i*$cell+25,$r,$fg); imagestringup($im,3,$left+$i*$cell+25,$h-10,$r,$fg); foreach($dims as $j=>$c){ $v=$matrix[$r][$c] ?? 0; $shade=255-intval($v*180); $col=imagecolorallocate($im,$shade,$shade,$shade); imagefilledrectangle($im,$left+$j*$cell,$top+$i*$cell,$left+($j+1)*$cell-2,$top+($i+1)*$cell-2,$col); imagestring($im,3,$left+$j*$cell+18,$top+$i*$cell+25,number_format($v,2),$fg); }}
    imagepng($im,$path); imagedestroy($im);
}
$report = "# Auswertungspunkt 3 – Dominanzkopplungsanalyse\n\n";
foreach (($data['cohorts'] ?? []) as $name=>$cohort) {
    $pairs = $cohort['coupling_pairs'] ?? []; writeCsv("$OUTDIR/{$name}_kopplungspaare.csv", $pairs);
    $byLag=[]; $matrix=[]; $rowCounts=[];
    foreach($pairs as $p){ $lag=$p['lag']; $byLag[$lag]['dom'][]=$p['dominanz_match']; $byLag[$lag]['pol'][]=$p['polaritaet_match']; $td=$p['teacher_dominante_dimension']; $pd=$p['participant_dominante_dimension']; $matrix[$td][$pd]=($matrix[$td][$pd] ?? 0)+1; $rowCounts[$td]=($rowCounts[$td] ?? 0)+1; }
    $summaryRows=[]; $rates=[]; foreach($byLag as $lag=>$vals){ $rates[$lag]=avg($vals['dom']); $summaryRows[]=['lag'=>$lag, 'n'=>count($vals['dom']), 'dominanz_match_rate'=>avg($vals['dom']), 'polaritaet_match_rate'=>avg($vals['pol'])]; }
    writeCsv("$OUTDIR/{$name}_lag_summary.csv", $summaryRows); drawBar("$OUTDIR/{$name}_dominanz_match_lag.png", $rates, "Dominanzkopplung nach Zeitversatz - $name");
    foreach($DIMS as $r) foreach($DIMS as $c) $matrix[$r][$c]=($rowCounts[$r]??0) ? (($matrix[$r][$c]??0)/$rowCounts[$r]) : 0;
    drawMatrix("$OUTDIR/{$name}_dominanz_matrix.png", $matrix, $DIMS, "Dominanz-Uebergangsmatrix - $name");
    $bestLag='-'; $bestRate=-1; foreach($rates as $lag=>$rate) if($rate>$bestRate){$bestRate=$rate;$bestLag=$lag;}
    $report .= "## $name\nLehrkraft-Rohwerte: ".($cohort['teacher_raw_n']??0)."; aggregierte Lehrkraft-Ereignisse: ".count($cohort['teacher_events']??[])."; Kopplungspaare: ".count($pairs).".\n";
    $report .= "Stärkste Dominanzkopplung bei Lag $bestLag mit Match-Rate ".number_format(max(0,$bestRate),3).".\n\n";
}
file_put_contents("$OUTDIR/dominanzkopplung_report.md", $report);
echo "Auswertung geschrieben nach: $OUTDIR\n";
