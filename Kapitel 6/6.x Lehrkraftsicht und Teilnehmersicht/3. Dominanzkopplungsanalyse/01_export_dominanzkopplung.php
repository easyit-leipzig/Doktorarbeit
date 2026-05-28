<?php
/**
 * Auswertungspunkt 3: Dominanzkopplungsanalyse
 * Exportiert alle Lehrkräfte, lehrkraft_id=1 und alle außer lehrkraft_id=1 in eine JSON-Datei.
 * Aufruf: php 01_export_dominanzkopplung.php [output.json] [maxLag]
 */
$OUT = $argv[1] ?? 'dominanzkopplung_export.json';
$MAX_LAG = intval($argv[2] ?? 3);
$DIMENSIONS = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];
$pdo = new PDO('mysql:host=127.0.0.1;port=3306;dbname=icas_19_4_2;charset=utf8mb4', 'root', '', [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);

function fetchAllRows(PDO $pdo, string $sql): array { return $pdo->query($sql)->fetchAll(); }
function dominantFromVector(array $row, array $dims): array {
    $best = $dims[0]; $bestVal = floatval($row['x_'.$best] ?? 0);
    foreach ($dims as $d) { $v = floatval($row['x_'.$d] ?? 0); if (abs($v) > abs($bestVal)) { $best = $d; $bestVal = $v; } }
    return [$best, $bestVal];
}
function aggregateTeacherEvents(array $rows, array $dims): array {
    $buckets = [];
    foreach ($rows as $r) {
        $key = implode('|', [$r['id_mtr_rueckkopplung_datenmaske'], $r['datum'], $r['lehrkraft_id'], $r['gruppe_id'], $r['teilnehmer_id']]);
        $buckets[$key][] = $r;
    }
    $events = [];
    foreach ($buckets as $items) {
        $first = $items[0]; $n = count($items);
        $ev = ['id_mtr_rueckkopplung_datenmaske'=>$first['id_mtr_rueckkopplung_datenmaske'], 'datum'=>$first['datum'], 'lehrkraft_id'=>intval($first['lehrkraft_id']), 'gruppe_id'=>intval($first['gruppe_id']), 'teilnehmer_id'=>intval($first['teilnehmer_id']), 'satzanzahl'=>$n];
        foreach ($dims as $d) { $s=0.0; foreach ($items as $x) $s += floatval($x['x_'.$d] ?? 0); $ev['x_'.$d] = $s / $n; }
        $ds=0.0; $ps=0; foreach ($items as $x) { $ds += floatval($x['d_semantisch'] ?? 0); $ps += intval($x['polaritaet_gesamt'] ?? 0); }
        $ev['d_semantisch'] = $ds/$n; $ev['polaritaet_gesamt'] = $ps > 0 ? 1 : ($ps < 0 ? -1 : 0);
        [$dim,$val] = dominantFromVector($ev, $dims); $ev['dominante_dimension'] = $dim; $ev['dominante_dimension_wert'] = $val;
        $events[] = $ev;
    }
    usort($events, fn($a,$b) => [$a['gruppe_id'],$a['teilnehmer_id'],$a['datum'],$a['lehrkraft_id']] <=> [$b['gruppe_id'],$b['teilnehmer_id'],$b['datum'],$b['lehrkraft_id']]);
    return $events;
}
function buildPairs(array $teacherEvents, array $participantEvents, int $maxLag): array {
    $pByKey = [];
    foreach ($participantEvents as $p) { $pByKey[$p['gruppe_id'].'|'.$p['teilnehmer_id']][] = $p; }
    foreach ($pByKey as &$arr) usort($arr, fn($a,$b) => strcmp($a['zeitpunkt'],$b['zeitpunkt'])); unset($arr);
    $pairs = [];
    foreach ($teacherEvents as $l) {
        $key = $l['gruppe_id'].'|'.$l['teilnehmer_id']; $cand = $pByKey[$key] ?? [];
        if (!$cand) { foreach ($pByKey as $k=>$arr) if (str_starts_with($k, $l['gruppe_id'].'|')) foreach ($arr as $p) $cand[] = $p; usort($cand, fn($a,$b)=>strcmp($a['zeitpunkt'],$b['zeitpunkt'])); }
        $sameOrAfter = array_values(array_filter($cand, fn($p) => substr($p['zeitpunkt'],0,10) >= $l['datum']));
        for ($lag=0; $lag <= $maxLag && $lag < count($sameOrAfter); $lag++) {
            $p = $sameOrAfter[$lag];
            $pairs[] = ['lag'=>$lag, 'match_type'=>'same_or_following_session', 'lehrkraft_id'=>$l['lehrkraft_id'], 'gruppe_id'=>$l['gruppe_id'], 'teilnehmer_id'=>$l['teilnehmer_id'] ?: intval($p['teilnehmer_id']), 'teacher_date'=>$l['datum'], 'participant_time'=>$p['zeitpunkt'], 'teacher_dominante_dimension'=>$l['dominante_dimension'], 'participant_dominante_dimension'=>$p['dominante_dimension'], 'dominanz_match'=>($l['dominante_dimension']===$p['dominante_dimension'] ? 1 : 0), 'teacher_dominante_dimension_wert'=>$l['dominante_dimension_wert'], 'participant_dominante_dimension_wert'=>floatval($p['dominante_dimension_wert'] ?? 0), 'teacher_polaritaet_gesamt'=>$l['polaritaet_gesamt'], 'participant_polaritaet_gesamt'=>intval($p['polaritaet_gesamt'] ?? 0), 'polaritaet_match'=>(intval($l['polaritaet_gesamt'])===intval($p['polaritaet_gesamt'] ?? 0) ? 1 : 0)];
        }
    }
    return $pairs;
}

$teacherSql = "SELECT id, datum, lehrkraft_id, gruppe_id, teilnehmer_id, id_mtr_rueckkopplung_datenmaske, mtr_rueckkopplung_datenmaske_values_id, x_kognition, x_sozial, x_affektiv, x_motivation, x_methodik, x_performanz, x_regulation, dominante_dimension, dominante_dimension_wert, polaritaet_gesamt, d_semantisch FROM sql_semantische_dichte_lehrer_type_1 WHERE dominante_dimension IS NOT NULL ORDER BY datum, gruppe_id, teilnehmer_id, lehrkraft_id, id";
$participantSql = "SELECT id, rueckkopplung_teilnehmer_id, ue_id, teilnehmer_id, gruppe_id, zeitpunkt, x_kognition, x_sozial, x_affektiv, x_motivation, x_methodik, x_performanz, x_regulation, dominante_dimension, dominante_dimension_wert, polaritaet_gesamt, d_semantisch, emotion_valenz, emotion_aktivierung, emotion_anzahl FROM frzk_semantische_dichte_teilnehmer_7d WHERE dominante_dimension IS NOT NULL ORDER BY zeitpunkt, gruppe_id, teilnehmer_id, id";
$teacherRaw = fetchAllRows($pdo, $teacherSql); $participants = fetchAllRows($pdo, $participantSql);
$cohortFilters = ['alle_lehrkraefte'=>fn($r)=>true, 'lehrkraft_1'=>fn($r)=>intval($r['lehrkraft_id'])===1, 'ohne_lehrkraft_1'=>fn($r)=>intval($r['lehrkraft_id'])!==1];
$data = ['meta'=>['auswertungspunkt'=>3, 'name'=>'Dominanzkopplungsanalyse', 'max_lag'=>$MAX_LAG, 'dimensions'=>$DIMENSIONS, 'created_at'=>date('c')], 'cohorts'=>[]];
foreach ($cohortFilters as $name=>$fn) { $rows = array_values(array_filter($teacherRaw, $fn)); $te = aggregateTeacherEvents($rows, $DIMENSIONS); $data['cohorts'][$name] = ['teacher_raw_n'=>count($rows), 'teacher_events'=>$te, 'participant_events'=>$participants, 'coupling_pairs'=>buildPairs($te, $participants, $MAX_LAG)]; }
file_put_contents($OUT, json_encode($data, JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE));
echo "JSON geschrieben: $OUT\n";
