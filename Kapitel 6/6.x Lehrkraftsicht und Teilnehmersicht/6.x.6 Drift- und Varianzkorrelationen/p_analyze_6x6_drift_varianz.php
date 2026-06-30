<?php
/**
 * 6.x.6 Drift- und Varianzkorrelationen – Analyse-/Visualisierungsskript (PHP)
 * Liest JSON, erzeugt CSV, TXT und einfache SVG-Grafiken ohne externe Bibliotheken.
 */
declare(strict_types=1);

$infile = __DIR__ . DIRECTORY_SEPARATOR . '6x6_drift_varianz_korrelationen.json';
$outdir = __DIR__ . DIRECTORY_SEPARATOR . '6x6_drift_varianz_output_php';
if (!is_dir($outdir)) mkdir($outdir, 0777, true);

$dims = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];
$tnFields = ['mitarbeit','absprachen','selbststaendigkeit','konzentration','fleiss','lernfortschritt','beherrscht_thema','transferdenken','basiswissen','vorbereitet','themenauswahl','materialien','methodenvielfalt','individualisierung','aufforderung','zielgruppen'];

function f($x): ?float { return ($x === null || $x === '') ? null : (float)$x; }
function mean_arr(array $a): ?float { $v = array_values(array_filter($a, fn($x) => $x !== null && !is_nan((float)$x))); return count($v) ? array_sum($v)/count($v) : null; }
function std_arr(array $a): ?float { $m = mean_arr($a); if ($m === null) return null; $v = array_values(array_filter($a, fn($x) => $x !== null)); if (count($v) < 2) return 0.0; $s=0.0; foreach($v as $x){$s += (($x-$m)**2);} return sqrt($s/count($v)); }
function pearson(array $x, array $y): ?float { $xx=[]; $yy=[]; foreach($x as $i=>$v){ if($v!==null && isset($y[$i]) && $y[$i]!==null){$xx[]=(float)$v; $yy[]=(float)$y[$i];}} $n=count($xx); if($n<3) return null; $mx=array_sum($xx)/$n; $my=array_sum($yy)/$n; $num=0;$dx=0;$dy=0; for($i=0;$i<$n;$i++){ $a=$xx[$i]-$mx; $b=$yy[$i]-$my; $num+=$a*$b; $dx+=$a*$a; $dy+=$b*$b; } return ($dx>0 && $dy>0) ? $num/sqrt($dx*$dy) : null; }
function euclid(array $a, array $b): ?float { $s=0.0; $n=0; foreach($a as $i=>$v){ if($v!==null && isset($b[$i]) && $b[$i]!==null){$s += (($v-$b[$i])**2); $n++;}} return $n ? sqrt($s) : null; }
function emotion_ids($s): array { if($s===null || $s==='') return []; return array_values(array_filter(array_map('intval', preg_split('/[,;]+/', (string)$s)), fn($v)=>$v>0)); }
function csv_write(string $file, array $rows): void { $fp=fopen($file,'w'); if(!$fp)return; if(count($rows)){ fputcsv($fp, array_keys($rows[0]), ';'); foreach($rows as $r) fputcsv($fp, $r, ';'); } fclose($fp); }
function svg_bar(string $file, array $items): void { $w=1100; $h=max(220, 28*count($items)+70); $max=1.0; $svg="<svg xmlns='http://www.w3.org/2000/svg' width='$w' height='$h'><style>text{font-family:Arial;font-size:12px}.title{font-size:18px;font-weight:bold}</style><text x='20' y='28' class='title'>6.x.6 stärkste Drift-/Varianzkorrelationen</text>"; $y=55; foreach($items as $it){ $label=htmlspecialchars($it['label']); $r=(float)$it['r']; $bar=abs($r)*360; $x=$r>=0?560:560-$bar; $svg.="<text x='20' y='$y'>$label</text><rect x='$x' y='".($y-12)."' width='$bar' height='16' fill='steelblue'/><text x='930' y='$y'>".number_format($r,4)."</text>"; $y+=28; } $svg.="<line x1='560' y1='45' x2='560' y2='".($h-20)."' stroke='black'/></svg>"; file_put_contents($file,$svg); }

$payload = json_decode(file_get_contents($infile), true);
$rows = $payload['data'] ?? [];
$emotionLookup=[];
foreach(($payload['emotion_lookup'] ?? []) as $e){ $emotionLookup[(int)$e['id']] = ['valenz'=>f($e['valenz'] ?? null), 'aktivierung'=>f($e['aktivierung'] ?? null)]; }

usort($rows, fn($a,$b) => [$a['teilnehmer_id'], $a['erfasst_am'], $a['teilnehmer_feedback_id']] <=> [$b['teilnehmer_id'], $b['erfasst_am'], $b['teilnehmer_feedback_id']]);
$prevByTn=[]; $analysed=[];
foreach($rows as $r){
    $tn=[]; foreach($tnFields as $c) $tn[] = f($r[$c] ?? null) !== null ? f($r[$c]) - 1.0 : null;
    $tid=(string)$r['teilnehmer_id'];
    $drift = isset($prevByTn[$tid]) ? euclid($tn, $prevByTn[$tid]) : null;
    $prevByTn[$tid]=$tn;
    $vars=[]; foreach($dims as $d) $vars[] = f($r['var_'.$d] ?? null);
    $ids = emotion_ids($r['emotions'] ?? ''); $vals=[]; $acts=[]; $pos=0; $neg=0;
    foreach($ids as $id){ if(isset($emotionLookup[$id])){ $v=$emotionLookup[$id]['valenz']; $a=$emotionLookup[$id]['aktivierung']; if($v!==null){$vals[]=$v; if($v>0)$pos++; if($v<0)$neg++;} if($a!==null)$acts[]=$a; }}
    $amb = min($pos,$neg)/max($pos+$neg,1);
    $r['teilnehmer_drift']=$drift;
    $r['tn_belastung_mean']=mean_arr($tn);
    $r['tn_belastung_std']=std_arr($tn);
    $r['lehrkraft_varianz_mean']=mean_arr($vars);
    $r['lehrkraft_varianz_max']=count(array_filter($vars, fn($x)=>$x!==null)) ? max(array_filter($vars, fn($x)=>$x!==null)) : null;
    $r['emotion_count']=count($ids);
    $r['emotion_valenz_mean']=mean_arr($vals);
    $r['emotion_valenz_std']=std_arr($vals);
    $r['emotion_aktivierung_mean']=mean_arr($acts);
    $r['emotion_ambivalenz']=$amb;
    $r['semantische_instabilitaet']=mean_arr([f($r['d_semantisch_std'] ?? null), f($r['semantische_breite'] ?? null), f($r['dominanz_breite'] ?? null)]);
    $analysed[]=$r;
}

$drivers=[]; foreach($dims as $d) $drivers[]='var_'.$d; $drivers=array_merge($drivers,['lehrkraft_varianz_mean','lehrkraft_varianz_max','semantische_breite','d_semantisch_std','dominanz_breite']);
$targets=['teilnehmer_drift','emotion_ambivalenz','emotion_valenz_std','semantische_instabilitaet','tn_belastung_mean','tn_belastung_std'];
$corrs=[];
foreach($drivers as $d){ foreach($targets as $t){ $x=[];$y=[]; foreach($analysed as $r){$x[]=f($r[$d] ?? null); $y[]=f($r[$t] ?? null);} $corrs[]=['driver'=>$d,'target'=>$t,'pearson_r'=>pearson($x,$y)]; }}
usort($corrs, fn($a,$b)=>abs($b['pearson_r'] ?? 0)<=>abs($a['pearson_r'] ?? 0));

csv_write($outdir.'/6x6_drift_varianz_analysed_rows.csv', $analysed);
csv_write($outdir.'/6x6_drift_varianz_korrelationen.csv', $corrs);
$top=array_slice($corrs,0,20); $bars=[]; foreach($top as $c){$bars[]=['label'=>$c['driver'].' → '.$c['target'],'r'=>$c['pearson_r'] ?? 0];}
svg_bar($outdir.'/plot_top_korrelationen.svg', $bars);

$report=[];
$report[]='6.x.6 Drift- und Varianzkorrelationen – automatischer PHP-Auswertungsbericht';
$report[]=str_repeat('=',78);
$report[]='Datensätze: '.count($analysed);
$report[]='Stärkste Korrelationen:';
foreach(array_slice($corrs,0,12) as $c){$report[]='- '.$c['driver'].' → '.$c['target'].': Pearson r='.($c['pearson_r']===null?'n/a':number_format($c['pearson_r'],4));}
$report[]='Interpretation: Positive Korrelationen zwischen Varianzmaßen und Drift/Ambivalenz sprechen für Übergangs- oder Destabilisierungsprozesse.';
file_put_contents($outdir.'/6x6_bericht.txt', implode("\n", $report));
echo "OK: Auswertung in $outdir geschrieben.\n";
