<?php
/**
 * 6.x.8 Epistemische Übergangsemotionen – JSON-Export ohne Lehrkraftunterscheidung
 * Erzeugt: 6x8_epistemische_uebergangsemotionen.json
 */

$host = '127.0.0.1';
$db   = 'icas_19_4_2';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';
$outfile = __DIR__ . DIRECTORY_SEPARATOR . '6x8_epistemische_uebergangsemotionen.json';

$epistemicEmotions = [
    23 => 'Interesse',
    26 => 'Überraschung',
    27 => 'Erwartung',
    28 => 'Erleichterung'
];

$dimensions = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

function parse_emotions($value) {
    if ($value === null || trim((string)$value) === '') return [];
    $parts = preg_split('/[,;]/', (string)$value);
    $ids = [];
    foreach ($parts as $p) {
        $p = trim($p);
        if ($p !== '' && is_numeric($p)) $ids[] = intval($p);
    }
    return $ids;
}

function fnum($v) { return ($v === null || $v === '') ? 0.0 : floatval($v); }
function inum($v) { return ($v === null || $v === '') ? 0 : intval($v); }

try {
    $pdo = new PDO($dsn, $user, $pass, $options);

    $emotionMeta = [];
    foreach ($pdo->query("SELECT id, type_name, fine_label, emotion, map_field, valenz, aktivierung FROM _mtr_emotionen") as $row) {
        $emotionMeta[intval($row['id'])] = $row;
    }

    $sql = "
    SELECT
        teilnehmer_feedback_id,
        teilnehmer_ue_id,
        teilnehmer_id,
        gruppe_id,
        erfasst_am,
        teilnehmer_datum,
        emotions,
        bemerkungen,
        id_mtr_rueckkopplung_datenmaske,
        datum,
        satzanzahl,
        mean_kognition,
        mean_sozial,
        mean_affektiv,
        mean_motivation,
        mean_methodik,
        mean_performanz,
        mean_regulation,
        var_kognition,
        var_sozial,
        var_affektiv,
        var_motivation,
        var_methodik,
        var_performanz,
        var_regulation,
        d_semantisch_mean,
        d_semantisch_std,
        semantische_breite,
        dominanz_breite,
        x_kognition,
        x_sozial,
        x_affektiv,
        x_motivation,
        x_methodik,
        x_performanz,
        x_regulation,
        dominante_dimension,
        dominante_dimension_wert,
        polaritaet_gesamt,
        d_semantisch,
        token_anzahl,
        funktionsklassen_anzahl_gesamt
    FROM match_tn_daten_analyze_lehrkraft
    WHERE emotions IS NOT NULL AND TRIM(emotions) <> ''
    ORDER BY teilnehmer_datum, gruppe_id, teilnehmer_id, teilnehmer_feedback_id";

    $records = [];
    $epistemicRecords = [];

    foreach ($pdo->query($sql) as $row) {
        $emotionIds = parse_emotions($row['emotions']);
        $transitionIds = [];
        $transitionNames = [];
        $emotionNames = [];
        foreach ($emotionIds as $eid) {
            $emotionNames[] = $emotionMeta[$eid]['emotion'] ?? (string)$eid;
            if (isset($epistemicEmotions[$eid])) {
                $transitionIds[] = $eid;
                $transitionNames[] = $epistemicEmotions[$eid];
            }
        }

        $meanVector = [];
        $xVector = [];
        $varVector = [];
        foreach ($dimensions as $d) {
            $meanVector[$d] = fnum($row['mean_' . $d]);
            $xVector[$d] = fnum($row['x_' . $d]);
            $varVector[$d] = fnum($row['var_' . $d]);
        }

        $record = [
            'teilnehmer_feedback_id' => inum($row['teilnehmer_feedback_id']),
            'teilnehmer_ue_id' => inum($row['teilnehmer_ue_id']),
            'teilnehmer_id' => inum($row['teilnehmer_id']),
            'gruppe_id' => inum($row['gruppe_id']),
            'datum' => $row['teilnehmer_datum'],
            'erfasst_am' => $row['erfasst_am'],
            'id_mtr_rueckkopplung_datenmaske' => inum($row['id_mtr_rueckkopplung_datenmaske']),
            'emotions_raw' => $row['emotions'],
            'emotion_ids' => $emotionIds,
            'emotion_names' => $emotionNames,
            'epistemic_transition_ids' => $transitionIds,
            'epistemic_transition_names' => $transitionNames,
            'has_epistemic_transition' => count($transitionIds) > 0,
            'transition_count' => count($transitionIds),
            'bemerkungen' => $row['bemerkungen'],
            'mean_vector' => $meanVector,
            'x_vector' => $xVector,
            'var_vector' => $varVector,
            'd_semantisch_mean' => fnum($row['d_semantisch_mean']),
            'd_semantisch_std' => fnum($row['d_semantisch_std']),
            'd_semantisch' => fnum($row['d_semantisch']),
            'semantische_breite' => fnum($row['semantische_breite']),
            'dominanz_breite' => inum($row['dominanz_breite']),
            'dominante_dimension' => $row['dominante_dimension'],
            'dominante_dimension_wert' => fnum($row['dominante_dimension_wert']),
            'polaritaet_gesamt' => inum($row['polaritaet_gesamt']),
            'satzanzahl' => inum($row['satzanzahl']),
            'token_anzahl' => inum($row['token_anzahl']),
            'funktionsklassen_anzahl_gesamt' => inum($row['funktionsklassen_anzahl_gesamt']),
        ];
        $records[] = $record;
        if ($record['has_epistemic_transition']) $epistemicRecords[] = $record;
    }

    $dataset = [
        'metadata' => [
            'auswertung' => '6.x.8 Epistemische Übergangsemotionen',
            'created_at' => date('c'),
            'database' => $db,
            'scope' => 'ohne Lehrkraftunterscheidung',
            'source_view' => 'match_tn_daten_analyze_lehrkraft',
            'emotion_source_table' => '_mtr_emotionen',
            'epistemic_transition_emotions' => $epistemicEmotions,
            'dimensions' => $dimensions,
        ],
        'emotion_meta' => $emotionMeta,
        'records' => $records,
        'epistemic_transition_records' => $epistemicRecords,
    ];

    file_put_contents($outfile, json_encode($dataset, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
    echo "Export abgeschlossen: $outfile\n";
    echo "Datensätze gesamt: " . count($records) . "\n";
    echo "Mit epistemischer Übergangsemotion: " . count($epistemicRecords) . "\n";

} catch (Throwable $e) {
    fwrite(STDERR, "Fehler: " . $e->getMessage() . "\n");
    exit(1);
}
