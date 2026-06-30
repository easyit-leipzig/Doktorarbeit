<?php
/**
 * 6.x.24 Kontrafaktische Lehrkraftprofilwirkung auf gruppendynamische Stabilität
 * Exportskript PHP
 */

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$db = new mysqli('127.0.0.1', 'root', '', 'icas_19_4_2', 3306);
$db->set_charset('utf8mb4');

$outputFile = __DIR__ . DIRECTORY_SEPARATOR . '6x24_lehrkraftprofil_gruppendynamik.json';
$dimensions = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];

function fetchAllAssoc(mysqli $db, string $sql): array {
    $res = $db->query($sql);
    $rows = [];
    while ($row = $res->fetch_assoc()) {
        $rows[] = $row;
    }
    return $rows;
}

function fval0($v): float {
    return is_numeric($v) ? (float)$v : 0.0;
}

function euclidean(array $a, array $b): float {
    $s = 0.0;
    for ($i = 0; $i < count($a); $i++) {
        $s += ($a[$i] - $b[$i]) * ($a[$i] - $b[$i]);
    }
    return sqrt($s);
}

function cosine(array $a, array $b): ?float {
    $dot = 0.0; $na = 0.0; $nb = 0.0;
    for ($i = 0; $i < count($a); $i++) {
        $dot += $a[$i] * $b[$i];
        $na += $a[$i] * $a[$i];
        $nb += $b[$i] * $b[$i];
    }
    if ($na <= 0 || $nb <= 0) return null;
    return $dot / (sqrt($na) * sqrt($nb));
}

function profileVector(array $profile, array $dimensions): array {
    $v = [];
    foreach ($dimensions as $d) {
        $v[] = fval0($profile['mean_' . $d] ?? 0);
    }
    return $v;
}

function groupVector(array $row): array {
    $zAff = fval0($row['z_affektiv'] ?? 0);
    $koh = fval0($row['kohaerenz'] ?? 0);
    $stab = fval0($row['stabilitaet'] ?? 0);
    $dyn = max(0.0, fval0($row['dynamik'] ?? 0));
    $motivation = max(0.0, (($koh + $stab) / 2.0) - ($dyn / 2.0));
    return [
        ($koh + $stab) / 2.0,
        $koh,
        $zAff,
        $motivation,
        $koh,
        $stab,
        $stab,
    ];
}

function getProfile(mysqli $db, string $label, string $whereSql, array $dimensions): array {
    $select = ['COUNT(*) AS n'];
    foreach ($dimensions as $d) {
        $select[] = "AVG(mean_$d) AS mean_$d";
        $select[] = "AVG(var_$d) AS avg_var_$d";
        $select[] = "AVG(range_$d) AS avg_range_$d";
    }
    $select[] = 'AVG(semantische_breite) AS semantische_breite_mean';
    $select[] = 'AVG(d_semantisch_mean) AS d_semantisch_mean';
    $select[] = 'AVG(d_semantisch_std) AS d_semantisch_std_mean';
    $select[] = 'AVG(polaritaet_index) AS polaritaet_index_mean';
    $select[] = 'AVG(dominanz_breite) AS dominanz_breite_mean';
    $sql = 'SELECT ' . implode(', ', $select) . " FROM analyze_lehrkraftdaten WHERE $whereSql";
    $rows = fetchAllAssoc($db, $sql);
    $p = $rows[0] ?? [];
    $p['label'] = $label;
    $p['vector'] = profileVector($p, $dimensions);
    return $p;
}

function getProfileByGroup(mysqli $db, string $whereSql, array $dimensions): array {
    $select = ['gruppe_id', 'COUNT(*) AS n'];
    foreach ($dimensions as $d) {
        $select[] = "AVG(mean_$d) AS mean_$d";
    }
    $sql = 'SELECT ' . implode(', ', $select) . " FROM analyze_lehrkraftdaten WHERE $whereSql GROUP BY gruppe_id";
    $rows = fetchAllAssoc($db, $sql);
    $out = [];
    foreach ($rows as $row) {
        $row['vector'] = profileVector($row, $dimensions);
        $out[(string)$row['gruppe_id']] = $row;
    }
    return $out;
}

function getDominanceDistribution(mysqli $db, string $whereSql): array {
    try {
        return fetchAllAssoc($db, "SELECT dominante_dimension, COUNT(*) AS n FROM sql_semantische_dichte_lehrer_type_1 WHERE $whereSql GROUP BY dominante_dimension ORDER BY n DESC");
    } catch (Throwable $e) {
        return [];
    }
}

function classifyRisk(float $delta, float $distOther, float $dyn, float $stab): string {
    $instability = max(0.0, $dyn) + max(0.0, 1.0 - $stab);
    $score = $delta + 0.5 * $instability + 0.25 * $distOther;
    if ($score >= 1.25) return 'hoch';
    if ($score >= 0.75) return 'mittel';
    return 'niedrig';
}

$lk1Profile = getProfile($db, 'lehrkraft_1', 'lehrkraft_id = 1', $dimensions);
$otherProfile = getProfile($db, 'andere_lehrkraft', 'lehrkraft_id <> 1', $dimensions);
$lk1ByGroup = getProfileByGroup($db, 'lehrkraft_id = 1', $dimensions);
$otherByGroup = getProfileByGroup($db, 'lehrkraft_id <> 1', $dimensions);

$groupRows = fetchAllAssoc($db, "
    SELECT gruppe_id, zeitpunkt, z_affektiv, kohärenz AS kohaerenz,
           stabilitaet, dynamik, emotionaler_status, emotionaler_modus, bemerkung
    FROM frzk_group_emotion
    ORDER BY gruppe_id, zeitpunkt
");

$projected = [];
foreach ($groupRows as $row) {
    $gid = (string)$row['gruppe_id'];
    $gv = groupVector($row);
    $lk1Vec = $lk1ByGroup[$gid]['vector'] ?? $lk1Profile['vector'];
    $otherVec = $otherByGroup[$gid]['vector'] ?? $otherProfile['vector'];

    $dLk1 = euclidean($gv, $lk1Vec);
    $dOther = euclidean($gv, $otherVec);
    $delta = $dOther - $dLk1;

    $vecAssoc = [];
    foreach ($dimensions as $i => $d) $vecAssoc[$d] = $gv[$i];

    $row['group_vector_7d_proxy'] = $vecAssoc;
    $row['distance_to_lk1_profile'] = $dLk1;
    $row['distance_to_other_profile'] = $dOther;
    $row['delta_distance_other_minus_lk1'] = $delta;
    $row['cosine_to_lk1_profile'] = cosine($gv, $lk1Vec);
    $row['cosine_to_other_profile'] = cosine($gv, $otherVec);
    $row['risk_level'] = classifyRisk($delta, $dOther, fval0($row['dynamik'] ?? 0), fval0($row['stabilitaet'] ?? 0));
    $row['interpretation'] = 'positives Delta = Gruppe liegt näher an LK1 als am Profil andere Lehrkraft';
    $projected[] = $row;
}

$summary = [];
foreach ($projected as $row) {
    $gid = (string)$row['gruppe_id'];
    if (!isset($summary[$gid])) {
        $summary[$gid] = [
            'gruppe_id' => $row['gruppe_id'],
            'n' => 0,
            'mean_distance_lk1' => 0.0,
            'mean_distance_other' => 0.0,
            'mean_delta_distance' => 0.0,
            'mean_dynamik' => 0.0,
            'mean_stabilitaet' => 0.0,
            'risk_counts' => [],
        ];
    }
    $summary[$gid]['n']++;
    $summary[$gid]['mean_distance_lk1'] += $row['distance_to_lk1_profile'];
    $summary[$gid]['mean_distance_other'] += $row['distance_to_other_profile'];
    $summary[$gid]['mean_delta_distance'] += $row['delta_distance_other_minus_lk1'];
    $summary[$gid]['mean_dynamik'] += fval0($row['dynamik'] ?? 0);
    $summary[$gid]['mean_stabilitaet'] += fval0($row['stabilitaet'] ?? 0);
    $risk = $row['risk_level'];
    $summary[$gid]['risk_counts'][$risk] = ($summary[$gid]['risk_counts'][$risk] ?? 0) + 1;
}

foreach ($summary as &$s) {
    $n = max(1, $s['n']);
    foreach (['mean_distance_lk1','mean_distance_other','mean_delta_distance','mean_dynamik','mean_stabilitaet'] as $k) {
        $s[$k] /= $n;
    }
    if ($s['mean_delta_distance'] > 0.15) $s['profile_binding'] = 'stärker an Lehrkraft 1 gebunden';
    elseif ($s['mean_delta_distance'] < -0.15) $s['profile_binding'] = 'näher am Profil andere Lehrkraft';
    else $s['profile_binding'] = 'profilrobust / geringe Distanzdifferenz';
}

$payload = [
    'meta' => [
        'auswertungspunkt' => '6.x.24',
        'titel' => 'Kontrafaktische Lehrkraftprofilwirkung auf gruppendynamische Stabilität',
        'created_at' => date('c'),
        'database' => 'icas_19_4_2',
        'dimensions' => $dimensions,
        'method_note' => 'Gruppendynamik liegt nur für LK1 real vor; Profil andere Lehrkraft wird kontrafaktisch projiziert.',
        'group_vector_note' => 'frzk_group_emotion wird als 7D-Proxy abgebildet; bei echten 7D-Gruppenwerten ersetzen.',
    ],
    'profiles' => [
        'lehrkraft_1' => $lk1Profile,
        'andere_lehrkraft' => $otherProfile,
        'lehrkraft_1_by_group' => $lk1ByGroup,
        'andere_lehrkraft_by_group' => $otherByGroup,
        'dominanz_lehrkraft_1' => getDominanceDistribution($db, 'lehrkraft_id = 1'),
        'dominanz_andere_lehrkraft' => getDominanceDistribution($db, 'lehrkraft_id <> 1'),
    ],
    'group_projection_rows' => $projected,
    'summary_by_group' => array_values($summary),
];

file_put_contents($outputFile, json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
echo "OK: Export geschrieben: $outputFile\n";
