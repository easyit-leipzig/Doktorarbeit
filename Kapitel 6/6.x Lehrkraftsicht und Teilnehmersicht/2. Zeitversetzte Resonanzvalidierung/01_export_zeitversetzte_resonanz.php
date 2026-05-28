<?php
/**
 * Auswertungspunkt 2: Zeitversetzte Resonanzvalidierung – Export
 *
 * Erzeugt eine JSON-Datei mit drei Vergleichsräumen:
 * - alle_lehrkraefte
 * - lehrkraft_1
 * - ohne_lehrkraft_1
 */

declare(strict_types=1);

$pdo = new PDO(
    'mysql:host=127.0.0.1;port=3306;dbname=icas_19_4_2;charset=utf8mb4',
    'root',
    '',
    [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]
);

const OUTPUT_FILE = 'zeitversetzte_resonanzvalidierung_export.json';
$dimensions = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];
$lags = [1,2,3];

function fval_or_zero($v): float { return $v === null ? 0.0 : (float)$v; }
function vector_from_row(array $row, array $dims): array {
    $v = [];
    foreach ($dims as $d) { $v[] = fval_or_zero($row['x_'.$d] ?? null); }
    return $v;
}
function cosine(array $a, array $b): ?float {
    $dot = 0.0; $na = 0.0; $nb = 0.0;
    foreach ($a as $i => $x) { $y = $b[$i]; $dot += $x*$y; $na += $x*$x; $nb += $y*$y; }
    if ($na <= 0.0 || $nb <= 0.0) return null;
    return $dot / (sqrt($na) * sqrt($nb));
}
function euclid(array $a, array $b): float {
    $s = 0.0; foreach ($a as $i => $x) { $s += ($x - $b[$i]) ** 2; } return sqrt($s);
}
function pearson(array $a, array $b): ?float {
    $n = count($a); if ($n < 2) return null;
    $ma = array_sum($a)/$n; $mb = array_sum($b)/$n;
    $num = 0.0; $da = 0.0; $db = 0.0;
    for ($i=0; $i<$n; $i++) { $xa=$a[$i]-$ma; $yb=$b[$i]-$mb; $num += $xa*$yb; $da += $xa*$xa; $db += $yb*$yb; }
    if ($da <= 0.0 || $db <= 0.0) return null;
    return $num / sqrt($da*$db);
}
function mean_nonnull(array $values): ?float {
    $c = array_values(array_filter($values, fn($v) => $v !== null));
    return count($c) ? array_sum($c)/count($c) : null;
}
function median_nonnull(array $values): ?float {
    $c = array_values(array_filter($values, fn($v) => $v !== null));
    sort($c); $n=count($c); if (!$n) return null;
    $m = intdiv($n, 2); return $n % 2 ? (float)$c[$m] : (($c[$m-1] + $c[$m]) / 2.0);
}
function fetch_teacher_states(PDO $pdo, string $where = '', array $params = []): array {
    $sql = "SELECT id_mtr_rueckkopplung_datenmaske, datum, teilnehmer_id, lehrkraft_id, gruppe_id, satzanzahl,
                   mean_kognition AS x_kognition, mean_sozial AS x_sozial, mean_affektiv AS x_affektiv,
                   mean_motivation AS x_motivation, mean_methodik AS x_methodik,
                   mean_performanz AS x_performanz, mean_regulation AS x_regulation,
                   d_semantisch_mean AS d_semantisch, polaritaet_index, dominanz_breite
            FROM analyze_lehrkraftdaten $where
            ORDER BY gruppe_id, teilnehmer_id, datum, lehrkraft_id";
    $stmt = $pdo->prepare($sql); $stmt->execute($params); return $stmt->fetchAll();
}
function fetch_participant_states(PDO $pdo): array {
    $sql = "SELECT id, rueckkopplung_teilnehmer_id, ue_id, teilnehmer_id, gruppe_id, zeitpunkt, DATE(zeitpunkt) AS datum,
                   x_kognition, x_sozial, x_affektiv, x_motivation, x_methodik, x_performanz, x_regulation,
                   dominante_dimension, dominante_dimension_wert, polaritaet_gesamt, d_semantisch,
                   emotion_valenz, emotion_aktivierung, emotion_anzahl
            FROM frzk_semantische_dichte_teilnehmer_7d
            ORDER BY gruppe_id, teilnehmer_id, zeitpunkt, id";
    return $pdo->query($sql)->fetchAll();
}
function index_participants(array $rows): array {
    $idx = [];
    foreach ($rows as $r) { $idx[$r['gruppe_id'].'|'.$r['teilnehmer_id']][] = $r; }
    return $idx;
}
function future_by_lag(array $rows, string $teacherDate, int $lag): ?array {
    $future = [];
    foreach ($rows as $r) {
        if (substr($r['zeitpunkt'], 0, 10) > $teacherDate) $future[] = $r;
    }
    return count($future) >= $lag ? $future[$lag-1] : null;
}
function summarize(array $matches, array $lags): array {
    $byLag = [];
    foreach ($lags as $lag) {
        $subset = array_values(array_filter($matches, fn($m) => $m['lag_sitzungen'] === $lag));
        $byLag[(string)$lag] = [
            'n_matches' => count($subset),
            'kosinus_mean' => mean_nonnull(array_column($subset, 'kosinus')),
            'kosinus_median' => median_nonnull(array_column($subset, 'kosinus')),
            'distanz_mean' => mean_nonnull(array_column($subset, 'euklidische_distanz')),
            'distanz_median' => median_nonnull(array_column($subset, 'euklidische_distanz')),
            'korrelation_mean' => mean_nonnull(array_column($subset, 'korrelation')),
            'korrelation_median' => median_nonnull(array_column($subset, 'korrelation')),
        ];
    }
    return ['summary_by_lag' => $byLag, 'matches' => $matches];
}
function build_matches(array $teacherRows, array $participantRows, array $dimensions, array $lags): array {
    $idx = index_participants($participantRows); $matches = [];
    foreach ($teacherRows as $t) {
        $key = $t['gruppe_id'].'|'.$t['teilnehmer_id']; if (!isset($idx[$key])) continue;
        $teacherDate = substr((string)$t['datum'], 0, 10); $lv = vector_from_row($t, $dimensions);
        foreach ($lags as $lag) {
            $p = future_by_lag($idx[$key], $teacherDate, $lag); if ($p === null) continue;
            $tv = vector_from_row($p, $dimensions);
            $matches[] = [
                'lag_sitzungen' => $lag,
                'gruppe_id' => (int)$t['gruppe_id'],
                'teilnehmer_id' => (int)$t['teilnehmer_id'],
                'lehrkraft_id' => (int)$t['lehrkraft_id'],
                'lehrkraft_datum' => $teacherDate,
                'teilnehmer_zeitpunkt' => $p['zeitpunkt'],
                'id_mtr_rueckkopplung_datenmaske' => $t['id_mtr_rueckkopplung_datenmaske'],
                'teilnehmer_state_id' => $p['id'],
                'lehrkraft_vector' => array_combine($dimensions, $lv),
                'teilnehmer_vector' => array_combine($dimensions, $tv),
                'kosinus' => cosine($lv, $tv),
                'euklidische_distanz' => euclid($lv, $tv),
                'korrelation' => pearson($lv, $tv),
                'lehrkraft_d_semantisch' => $t['d_semantisch'] === null ? null : (float)$t['d_semantisch'],
                'teilnehmer_d_semantisch' => $p['d_semantisch'] === null ? null : (float)$p['d_semantisch'],
                'lehrkraft_polaritaet_index' => $t['polaritaet_index'] === null ? null : (float)$t['polaritaet_index'],
                'teilnehmer_polaritaet_gesamt' => $p['polaritaet_gesamt'],
                'teilnehmer_dominante_dimension' => $p['dominante_dimension'],
            ];
        }
    }
    return summarize($matches, $lags);
}

$participantRows = fetch_participant_states($pdo);
$scopes = [
    'alle_lehrkraefte' => ['', []],
    'lehrkraft_1' => ['WHERE lehrkraft_id = ?', [1]],
    'ohne_lehrkraft_1' => ['WHERE lehrkraft_id <> ?', [1]],
];
$payload = [
    'auswertungspunkt' => '2. Zeitversetzte Resonanzvalidierung',
    'beschreibung' => 'Vergleich L_t mit T_{t+n}; n = 1, 2, 3 reale Folgesitzungen innerhalb gleicher Gruppe und gleichem Teilnehmer.',
    'created_at' => date('c'),
    'database' => 'icas_19_4_2',
    'dimensions' => $dimensions,
    'lags_sitzungen' => $lags,
    'source_tables' => ['lehrkraft' => 'analyze_lehrkraftdaten', 'teilnehmer' => 'frzk_semantische_dichte_teilnehmer_7d'],
    'scopes' => [],
];
foreach ($scopes as $name => [$where, $params]) {
    $teacherRows = fetch_teacher_states($pdo, $where, $params);
    $payload['scopes'][$name] = array_merge([
        'n_teacher_states' => count($teacherRows),
        'n_participant_states_total' => count($participantRows),
    ], build_matches($teacherRows, $participantRows, $dimensions, $lags));
}
file_put_contents(OUTPUT_FILE, json_encode($payload, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
echo "Export geschrieben: ".realpath(OUTPUT_FILE).PHP_EOL;
