<?php
/**
 * Export 6.x Kausalität des FRZK-Vektorraums als Beschreibungssystem
 *
 * Erzeugt eine gemeinsame JSON-Datei mit drei Scopes:
 *  - alle
 *  - lehrkraft_1
 *  - ohne_lehrkraft_1
 *
 * Nutzung:
 *   php export_6x_kausalitaet_vektorraum.php --out=6x_kausalitaet_vektorraum_export.json
 *   php export_6x_kausalitaet_vektorraum.php --limit=50
 */

$DB = [
    'host' => '127.0.0.1',
    'port' => 3306,
    'user' => 'root',
    'password' => '',
    'database' => 'icas_19_4_2',
    'charset' => 'utf8mb4',
];

$DIMENSIONS = ['kognition', 'sozial', 'affektiv', 'motivation', 'methodik', 'performanz', 'regulation'];
$RATING_FIELDS = [
    'mitarbeit', 'absprachen', 'selbststaendigkeit', 'konzentration', 'fleiss', 'lernfortschritt',
    'beherrscht_thema', 'transferdenken', 'basiswissen', 'vorbereitet', 'themenauswahl', 'materialien',
    'methodenvielfalt', 'individualisierung', 'aufforderung', 'zielgruppen'
];

function cli_option(string $name, $default = null) {
    foreach ($_SERVER['argv'] as $arg) {
        if (strpos($arg, "--$name=") === 0) {
            return substr($arg, strlen($name) + 3);
        }
    }
    return $default;
}

function as_float($value, $default = null) {
    if ($value === null || $value === '') return $default;
    return is_numeric($value) ? floatval($value) : $default;
}

function norm_vec(array $v): float {
    $s = 0.0;
    foreach ($v as $x) $s += floatval($x) * floatval($x);
    return sqrt($s);
}

function polarity(array $v): int {
    $s = array_sum($v);
    if ($s > 0) return 1;
    if ($s < 0) return -1;
    return 0;
}

function dominant_dimension_from_vector(array $row, string $prefix, array $dims): ?string {
    $best = null;
    $bestVal = null;
    foreach ($dims as $d) {
        $key = $prefix . '_' . $d;
        $val = abs(as_float($row[$key] ?? null, 0.0));
        if ($bestVal === null || $val > $bestVal) {
            $bestVal = $val;
            $best = $d;
        }
    }
    return $best;
}

function add_derived_fields(array $row, array $dims, array $ratingFields): array {
    $lkVector = [];
    $lkMeanVector = [];
    foreach ($dims as $d) {
        $lkVector[] = as_float($row['x_' . $d] ?? null, 0.0);
        $lkMeanVector[] = as_float($row['mean_' . $d] ?? null, 0.0);
    }
    $ratingVector = [];
    $ratingClean = [];
    foreach ($ratingFields as $field) {
        $v = as_float($row[$field] ?? null, null);
        $ratingVector[] = $v;
        if ($v !== null) $ratingClean[] = $v;
    }
    $emotionIds = [];
    $raw = str_replace(';', ',', strval($row['emotions'] ?? ''));
    foreach (explode(',', $raw) as $part) {
        $part = trim($part);
        if ($part !== '' && ctype_digit($part)) $emotionIds[] = intval($part);
    }
    $row['_derived'] = [
        'lk_vector' => $lkVector,
        'lk_mean_vector' => $lkMeanVector,
        'lk_norm' => norm_vec($lkVector),
        'lk_mean_norm' => norm_vec($lkMeanVector),
        'lk_polarity_from_vector' => polarity($lkVector),
        'lk_dominant_from_vector' => dominant_dimension_from_vector($row, 'x', $dims),
        'rating_vector' => $ratingVector,
        'rating_mean' => count($ratingClean) ? array_sum($ratingClean) / count($ratingClean) : null,
        'rating_norm' => count($ratingClean) ? norm_vec($ratingClean) : null,
        'emotion_ids' => $emotionIds,
    ];
    return $row;
}

function build_scope_clause(string $scope): string {
    if ($scope === 'lehrkraft_1') return 'WHERE lehrkraft_id = 1';
    if ($scope === 'ohne_lehrkraft_1') return 'WHERE lehrkraft_id <> 1';
    return '';
}

function pdo_connect(array $DB): PDO {
    $dsn = sprintf('mysql:host=%s;port=%d;dbname=%s;charset=%s', $DB['host'], $DB['port'], $DB['database'], $DB['charset']);
    $pdo = new PDO($dsn, $DB['user'], $DB['password'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
    return $pdo;
}

function export_scope(PDO $pdo, string $scope, ?int $limit, array $dims, array $ratingFields): array {
    $where = build_scope_clause($scope);
    $limitSql = $limit ? ' LIMIT ' . intval($limit) : '';
    $sql = "
        SELECT
            teilnehmer_feedback_id, teilnehmer_ue_id, teilnehmer_id, gruppe_id, erfasst_am,
            teilnehmer_datum, mitarbeit, absprachen, selbststaendigkeit, konzentration, fleiss,
            lernfortschritt, beherrscht_thema, transferdenken, basiswissen, vorbereitet,
            themenauswahl, materialien, methodenvielfalt, individualisierung, aufforderung,
            zielgruppen, emotions, bemerkungen, id_mtr_rueckkopplung_datenmaske, lehrkraft_id,
            datum, satzanzahl, mean_kognition, mean_sozial, mean_affektiv, mean_motivation,
            mean_methodik, mean_performanz, mean_regulation, var_kognition, var_sozial,
            var_affektiv, var_motivation, var_methodik, var_performanz, var_regulation,
            d_semantisch_mean, d_semantisch_std, semantische_breite, dominanz_breite,
            sdlg_id, sdlg_type, sdlg_ue_id, x_kognition, x_sozial, x_affektiv, x_motivation,
            x_methodik, x_performanz, x_regulation, sum_kognition, sum_sozial, sum_affektiv,
            sum_motivation, sum_methodik, sum_performanz, sum_regulation, h_kognition,
            h_sozial, h_affektiv, h_motivation, h_methodik, h_performanz, h_regulation,
            token_anzahl, funktionsklassen_anzahl_gesamt, dominante_dimension,
            dominante_dimension_wert, polaritaet_gesamt, d_semantisch, sdlg_created_at
        FROM match_tn_daten_analyze_lehrkraft
        $where
        ORDER BY teilnehmer_id, teilnehmer_datum, sdlg_type, sdlg_id
        $limitSql";
    $rows = $pdo->query($sql)->fetchAll();
    $outRows = [];
    $byGroup = [];
    $byTeacher = [];
    foreach ($rows as $row) {
        $row = add_derived_fields($row, $dims, $ratingFields);
        $outRows[] = $row;
        $g = strval($row['gruppe_id'] ?? '');
        $t = strval($row['lehrkraft_id'] ?? '');
        $byGroup[$g] = ($byGroup[$g] ?? 0) + 1;
        $byTeacher[$t] = ($byTeacher[$t] ?? 0) + 1;
    }
    return [
        'scope' => $scope,
        'n_rows' => count($outRows),
        'by_group' => $byGroup,
        'by_teacher' => $byTeacher,
        'rows' => $outRows,
    ];
}

function export_emotions(PDO $pdo): array {
    try {
        return $pdo->query('SELECT id, type_name, fine_label, emotion, valenz, aktivierung FROM _mtr_emotionen ORDER BY id')->fetchAll();
    } catch (Throwable $e) {
        return [];
    }
}

$out = cli_option('out', '6x_kausalitaet_vektorraum_export.json');
$limitOpt = cli_option('limit', null);
$limit = $limitOpt !== null ? intval($limitOpt) : null;
$DB['host'] = cli_option('host', $DB['host']);
$DB['port'] = intval(cli_option('port', $DB['port']));
$DB['user'] = cli_option('user', $DB['user']);
$DB['password'] = cli_option('password', $DB['password']);
$DB['database'] = cli_option('database', $DB['database']);

try {
    $pdo = pdo_connect($DB);
    $payload = [
        'metadata' => [
            'title' => '6.x Kausalität des FRZK-Vektorraums als Beschreibungssystem',
            'created_at' => date('c'),
            'database' => $DB['database'],
            'source_view' => 'match_tn_daten_analyze_lehrkraft',
            'method' => 'Export für Permutationstest, zeitversetzte Resonanz und Vorhersagevergleich',
            'dimensions' => $DIMENSIONS,
            'rating_fields' => $RATING_FIELDS,
            'scopes' => ['alle', 'lehrkraft_1', 'ohne_lehrkraft_1'],
        ],
        'emotions' => export_emotions($pdo),
        'scopes' => [],
    ];
    foreach ($payload['metadata']['scopes'] as $scope) {
        $payload['scopes'][$scope] = export_scope($pdo, $scope, $limit, $DIMENSIONS, $RATING_FIELDS);
    }
    file_put_contents($out, json_encode($payload, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
    echo "Export abgeschlossen: " . realpath($out) . PHP_EOL;
} catch (Throwable $e) {
    fwrite(STDERR, "Fehler beim Export: " . $e->getMessage() . PHP_EOL);
    exit(1);
}
