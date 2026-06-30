<?php
// ============================================================================
// 7d_sem_dichte_teilnehmer_neu.php
// Überführt Teilnehmer-Rückkopplungen in die 7-dimensionale FRZK-Struktur.
//
// Ergebnis:
//   1) Tabelle: frzk_semantische_dichte_teilnehmer_7d
//   2) JSON:    frzk_semantische_dichte_teilnehmer_7d.json
//   3) JSON:    frzk_group_semantische_dichte_7d.json
//
// Ergänzungen gegenüber der bisherigen Version:
//   - JSON-Export der Teilnehmerzustände
//   - Drift pro Teilnehmer
//   - Stabilitätswert
//   - Dominanzwechsel
//   - Transition-Marker
//   - Gruppenaggregation auf Tages-/Gruppenebene
// ============================================================================

header('Content-Type: text/plain; charset=utf-8');
ini_set('display_errors', '1');
error_reporting(E_ALL);
ini_set('memory_limit', '1024M');
set_time_limit(0);

// --------------------------------------------------------------------------
// DB-Verbindung
// --------------------------------------------------------------------------
$pdo = new PDO(
    "mysql:host=localhost;dbname=icas_19_4_2;charset=utf8mb4",
    "root",
    "",
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]
);

// --------------------------------------------------------------------------
// Hilfsfunktionen
// --------------------------------------------------------------------------
function noteToSigned($note): ?float
{
    if ($note === null || $note === '') {
        return null;
    }

    $note = (float)$note;

    if ($note < 1 || $note > 6) {
        return null;
    }

    // 1 -> +1, 3.5 -> 0, 6 -> -1
    return (3.5 - $note) / 2.5;
}

function signedFromRow(array $row, string $field): ?float
{
    return noteToSigned($row[$field] ?? null);
}

function addWeighted(array &$sum, array &$weight, string $dim, ?float $value, float $w = 1.0): void
{
    if ($value === null) {
        return;
    }

    $sum[$dim] += $value * $w;
    $weight[$dim] += $w;
}

function norm7(array $v): float
{
    $s = 0.0;

    foreach ($v as $x) {
        $s += ((float)$x) * ((float)$x);
    }

    return sqrt($s);
}

function transitionMarker(float $driftNorm): string
{
    if ($driftNorm == 0.0) {
        return 'stabil';
    }

    if ($driftNorm < 0.15) {
        return 'adaptiv';
    }

    if ($driftNorm < 0.35) {
        return 'koordinativ';
    }

    if ($driftNorm < 0.60) {
        return 'transformativ';
    }

    return 'kritisch';
}

function dominantDimension(array $values, array $dimensions): array
{
    $dominantDim = null;
    $dominantVal = 0.0;

    foreach ($dimensions as $dim) {
        $val = (float)($values[$dim] ?? 0.0);

        if ($dominantDim === null || abs($val) > abs($dominantVal)) {
            $dominantDim = $dim;
            $dominantVal = $val;
        }
    }

    return [$dominantDim, $dominantVal];
}

function polarityFromValues(array $values): int
{
    $sumAll = array_sum($values);

    if ($sumAll > 0) {
        return 1;
    }

    if ($sumAll < 0) {
        return -1;
    }

    return 0;
}

// --------------------------------------------------------------------------
// Dimensionen
// --------------------------------------------------------------------------
$dimensions = [
    'kognition',
    'sozial',
    'affektiv',
    'motivation',
    'methodik',
    'performanz',
    'regulation',
];

// --------------------------------------------------------------------------
// Tabelle um dynamische Zusatzspalten erweitern
// --------------------------------------------------------------------------
echo "Prüfe/erweitere Tabelle frzk_semantische_dichte_teilnehmer_7d ...\n";

$pdo->exec("
    ALTER TABLE frzk_semantische_dichte_teilnehmer_7d
    ADD COLUMN IF NOT EXISTS drift_norm DOUBLE DEFAULT NULL,
    ADD COLUMN IF NOT EXISTS d_semantisch_delta DOUBLE DEFAULT NULL,
    ADD COLUMN IF NOT EXISTS dominanzwechsel TINYINT(1) DEFAULT NULL,
    ADD COLUMN IF NOT EXISTS stabilitaet DOUBLE DEFAULT NULL,
    ADD COLUMN IF NOT EXISTS transition_marker VARCHAR(50) DEFAULT NULL
");

$pdo->exec("TRUNCATE TABLE frzk_semantische_dichte_teilnehmer_7d");

// --------------------------------------------------------------------------
// Emotionsdaten laden
// _mtr_emotionen enthält im aktuellen Modell:
// id, type_name, fine_label, emotion, valenz, aktivierung
// --------------------------------------------------------------------------
echo "Lade Emotionsdaten ...\n";

$emotionMap = [];
$stmtEmo = $pdo->query("
    SELECT id, type_name, fine_label, emotion, valenz, aktivierung
    FROM _mtr_emotionen
");

while ($e = $stmtEmo->fetch()) {
    $emotionMap[(int)$e['id']] = [
        'type_name'   => (string)($e['type_name'] ?? ''),
        'fine_label'  => (string)($e['fine_label'] ?? ''),
        'emotion'     => (string)($e['emotion'] ?? ''),
        'valenz'      => (float)($e['valenz'] ?? 0.0),
        'aktivierung' => (float)($e['aktivierung'] ?? 0.0),
    ];
}

echo "→ " . count($emotionMap) . " Emotionen geladen.\n";

// --------------------------------------------------------------------------
// Teilnehmerdaten laden
// --------------------------------------------------------------------------
echo "Lade Teilnehmer-Rückkopplungen ...\n";

$stmt = $pdo->query("
    SELECT *
    FROM mtr_rueckkopplung_teilnehmer
    WHERE erfasst_am IS NOT NULL
    ORDER BY teilnehmer_id ASC, erfasst_am ASC, id ASC
");

$rows = $stmt->fetchAll();
$total = count($rows);

echo "→ {$total} Teilnehmerdatensätze gefunden.\n";

// --------------------------------------------------------------------------
// Insert vorbereiten
// --------------------------------------------------------------------------
$insert = $pdo->prepare("
    INSERT INTO frzk_semantische_dichte_teilnehmer_7d
    (
        rueckkopplung_teilnehmer_id,
        ue_id,
        ue_zuweisung_teilnehmer_id,
        teilnehmer_id,
        gruppe_id,
        zeitpunkt,

        x_kognition,
        x_sozial,
        x_affektiv,
        x_motivation,
        x_methodik,
        x_performanz,
        x_regulation,

        sum_kognition,
        sum_sozial,
        sum_affektiv,
        sum_motivation,
        sum_methodik,
        sum_performanz,
        sum_regulation,

        emotion_ids,
        emotion_valenz,
        emotion_aktivierung,
        emotion_anzahl,

        dominante_dimension,
        dominante_dimension_wert,
        polaritaet_gesamt,
        d_semantisch,

        drift_norm,
        d_semantisch_delta,
        dominanzwechsel,
        stabilitaet,
        transition_marker
    )
    VALUES
    (
        ?,?,?,?,?,?,
        ?,?,?,?,?,?,?,
        ?,?,?,?,?,?,?,
        ?,?,?,?,
        ?,?,?,?,
        ?,?,?,?,?
    )
");

// --------------------------------------------------------------------------
// Hauptberechnung
// --------------------------------------------------------------------------
echo "Berechne 7D-Teilnehmerzustände ...\n";

$jsonData = [];
$previousByTeilnehmer = [];
$counter = 0;
$eps = 1e-9;

foreach ($rows as $r) {
    $counter++;

    $sum = array_fill_keys($dimensions, 0.0);
    $weight = array_fill_keys($dimensions, 0.0);

    // ----------------------------------------------------------------------
    // Numerische Skalenwerte transformieren
    // ----------------------------------------------------------------------
    $mitarbeit          = signedFromRow($r, 'mitarbeit');
    $absprachen         = signedFromRow($r, 'absprachen');
    $selbst             = signedFromRow($r, 'selbststaendigkeit');
    $konzentration      = signedFromRow($r, 'konzentration');
    $fleiss             = signedFromRow($r, 'fleiss');
    $lernfortschritt    = signedFromRow($r, 'lernfortschritt');
    $beherrscht         = signedFromRow($r, 'beherrscht_thema');
    $transfer           = signedFromRow($r, 'transferdenken');
    $basiswissen        = signedFromRow($r, 'basiswissen');
    $vorbereitet        = signedFromRow($r, 'vorbereitet');
    $themenauswahl      = signedFromRow($r, 'themenauswahl');
    $materialien        = signedFromRow($r, 'materialien');
    $methodenvielfalt   = signedFromRow($r, 'methodenvielfalt');
    $individualisierung = signedFromRow($r, 'individualisierung');
    $aufforderung       = signedFromRow($r, 'aufforderung');
    $zielgruppen        = signedFromRow($r, 'zielgruppen');

    // Kognition
    addWeighted($sum, $weight, 'kognition', $lernfortschritt, 1.0);
    addWeighted($sum, $weight, 'kognition', $beherrscht, 1.2);
    addWeighted($sum, $weight, 'kognition', $transfer, 1.3);
    addWeighted($sum, $weight, 'kognition', $basiswissen, 1.2);

    // Sozial
    addWeighted($sum, $weight, 'sozial', $mitarbeit, 1.0);
    addWeighted($sum, $weight, 'sozial', $absprachen, 1.1);
    addWeighted($sum, $weight, 'sozial', $aufforderung, 0.8);
    addWeighted($sum, $weight, 'sozial', $zielgruppen, 0.9);

    // Affektiv
    addWeighted($sum, $weight, 'affektiv', $fleiss, 0.7);
    addWeighted($sum, $weight, 'affektiv', $lernfortschritt, 0.5);
    addWeighted($sum, $weight, 'affektiv', $themenauswahl, 0.5);

    // Motivation
    addWeighted($sum, $weight, 'motivation', $fleiss, 1.2);
    addWeighted($sum, $weight, 'motivation', $vorbereitet, 0.8);
    addWeighted($sum, $weight, 'motivation', $themenauswahl, 0.9);
    addWeighted($sum, $weight, 'motivation', $lernfortschritt, 0.7);

    // Methodik
    addWeighted($sum, $weight, 'methodik', $materialien, 1.0);
    addWeighted($sum, $weight, 'methodik', $methodenvielfalt, 1.1);
    addWeighted($sum, $weight, 'methodik', $individualisierung, 1.0);
    addWeighted($sum, $weight, 'methodik', $themenauswahl, 0.7);

    // Performanz
    addWeighted($sum, $weight, 'performanz', $mitarbeit, 0.8);
    addWeighted($sum, $weight, 'performanz', $lernfortschritt, 1.2);
    addWeighted($sum, $weight, 'performanz', $beherrscht, 1.3);
    addWeighted($sum, $weight, 'performanz', $transfer, 1.0);

    // Regulation
    addWeighted($sum, $weight, 'regulation', $selbst, 1.3);
    addWeighted($sum, $weight, 'regulation', $konzentration, 1.2);
    addWeighted($sum, $weight, 'regulation', $vorbereitet, 1.0);
    addWeighted($sum, $weight, 'regulation', $absprachen, 1.0);

    // ----------------------------------------------------------------------
    // Emotionen verarbeiten
    // emotions ist kommagetrennt, z. B. "3,28,1,2"
    // ----------------------------------------------------------------------
    $emotionIds = [];
    $valenzSum = 0.0;
    $aktivSum = 0.0;
    $emotionCount = 0;

    $rawEmotions = trim((string)($r['emotions'] ?? ''));

    if ($rawEmotions !== '') {
        foreach (explode(',', $rawEmotions) as $part) {
            $eid = (int)trim($part);

            if ($eid <= 0 || !isset($emotionMap[$eid])) {
                continue;
            }

            $emotionIds[] = $eid;
            $emo = $emotionMap[$eid];

            $v = (float)$emo['valenz'];
            $a = (float)$emo['aktivierung'];

            $valenzSum += $v;
            $aktivSum += $a;
            $emotionCount++;

            // Affektive Grundwirkung
            addWeighted($sum, $weight, 'affektiv', $v * (0.65 + 0.35 * $a), 1.0);

            // Motivation: positive Aktivierung verstärkt, negative Aktivierung schwächt
            addWeighted($sum, $weight, 'motivation', $v * $a, 0.6);

            // Regulation: negative hochaktivierte Emotionen destabilisieren
            if ($v < 0) {
                addWeighted($sum, $weight, 'regulation', $v * $a, 0.5);
            } else {
                addWeighted($sum, $weight, 'regulation', $v * (1.0 - $a), 0.25);
            }

            // Sozialdimension bei sozial markierten Emotionen/Labels
            $label = strtolower(
                ($emo['type_name'] ?? '') . ' ' .
                ($emo['fine_label'] ?? '') . ' ' .
                ($emo['emotion'] ?? '')
            );

            if (
                str_contains($label, 'sozial') ||
                str_contains($label, 'dankbarkeit') ||
                str_contains($label, 'stolz')
            ) {
                addWeighted($sum, $weight, 'sozial', $v, 0.4);
            }
        }
    }

    $emotionValenz = $emotionCount > 0 ? $valenzSum / $emotionCount : null;
    $emotionAktivierung = $emotionCount > 0 ? $aktivSum / $emotionCount : null;

    // ----------------------------------------------------------------------
    // Mittelwerte pro Dimension: unnormierter 7D-Zustand V
    // ----------------------------------------------------------------------
    $V = [];
    foreach ($dimensions as $dim) {
        $V[$dim] = $weight[$dim] > 0 ? $sum[$dim] / $weight[$dim] : 0.0;
    }

    // ----------------------------------------------------------------------
    // Normierung: X = Richtungsvektor, Norm = semantische Dichte
    // ----------------------------------------------------------------------
    $norm = norm7($V);

    $X = [];
    foreach ($dimensions as $dim) {
        $X[$dim] = $V[$dim] / ($norm + $eps);
    }

    [$dominantDim, $dominantVal] = dominantDimension($V, $dimensions);
    $polaritaet = polarityFromValues($V);

    // ----------------------------------------------------------------------
    // Drift / Stabilität / Dominanzwechsel pro Teilnehmer
    // ----------------------------------------------------------------------
    $tidCurrent = (int)($r['teilnehmer_id'] ?? 0);

    $driftVector = array_fill_keys($dimensions, 0.0);
    $driftNorm = 0.0;
    $dSemantischDelta = 0.0;
    $dominanzwechsel = 0;

    if ($tidCurrent > 0 && isset($previousByTeilnehmer[$tidCurrent])) {
        $prev = $previousByTeilnehmer[$tidCurrent];

        foreach ($dimensions as $dim) {
            $driftVector[$dim] = $V[$dim] - $prev['V'][$dim];
        }

        $driftNorm = norm7($driftVector);
        $dSemantischDelta = $norm - $prev['d_semantisch'];
        $dominanzwechsel = ($dominantDim !== $prev['dominante_dimension']) ? 1 : 0;
    }

    $stabilitaet = 1 / (1 + $driftNorm);
    $transition_marker = transitionMarker($driftNorm);

    // ----------------------------------------------------------------------
    // Datenbank schreiben
    // ----------------------------------------------------------------------
    $insert->execute([
        (int)($r['id'] ?? 0),
        (int)($r['ue_id'] ?? 0),
        (int)($r['ue_zuweisung_teilnehmer_id'] ?? 0),
        $tidCurrent,
        (int)($r['gruppe_id'] ?? 0),
        $r['erfasst_am'] ?? null,

        $X['kognition'],
        $X['sozial'],
        $X['affektiv'],
        $X['motivation'],
        $X['methodik'],
        $X['performanz'],
        $X['regulation'],

        $V['kognition'],
        $V['sozial'],
        $V['affektiv'],
        $V['motivation'],
        $V['methodik'],
        $V['performanz'],
        $V['regulation'],

        implode(',', $emotionIds),
        $emotionValenz,
        $emotionAktivierung,
        $emotionCount,

        $dominantDim,
        $dominantVal,
        $polaritaet,
        $norm,

        $driftNorm,
        $dSemantischDelta,
        $dominanzwechsel,
        $stabilitaet,
        $transition_marker,
    ]);

    // ----------------------------------------------------------------------
    // JSON-Datensatz sammeln
    // ----------------------------------------------------------------------
    $jsonRow = [
        'rueckkopplung_teilnehmer_id' => (int)($r['id'] ?? 0),
        'ue_id' => (int)($r['ue_id'] ?? 0),
        'ue_zuweisung_teilnehmer_id' => (int)($r['ue_zuweisung_teilnehmer_id'] ?? 0),
        'teilnehmer_id' => $tidCurrent,
        'gruppe_id' => (int)($r['gruppe_id'] ?? 0),
        'zeitpunkt' => $r['erfasst_am'] ?? null,

        'x_kognition' => $X['kognition'],
        'x_sozial' => $X['sozial'],
        'x_affektiv' => $X['affektiv'],
        'x_motivation' => $X['motivation'],
        'x_methodik' => $X['methodik'],
        'x_performanz' => $X['performanz'],
        'x_regulation' => $X['regulation'],

        'sum_kognition' => $V['kognition'],
        'sum_sozial' => $V['sozial'],
        'sum_affektiv' => $V['affektiv'],
        'sum_motivation' => $V['motivation'],
        'sum_methodik' => $V['methodik'],
        'sum_performanz' => $V['performanz'],
        'sum_regulation' => $V['regulation'],

        'emotion_ids' => implode(',', $emotionIds),
        'emotion_valenz' => $emotionValenz,
        'emotion_aktivierung' => $emotionAktivierung,
        'emotion_anzahl' => $emotionCount,

        'dominante_dimension' => $dominantDim,
        'dominante_dimension_wert' => $dominantVal,
        'polaritaet_gesamt' => $polaritaet,
        'd_semantisch' => $norm,

        'drift_kognition' => $driftVector['kognition'],
        'drift_sozial' => $driftVector['sozial'],
        'drift_affektiv' => $driftVector['affektiv'],
        'drift_motivation' => $driftVector['motivation'],
        'drift_methodik' => $driftVector['methodik'],
        'drift_performanz' => $driftVector['performanz'],
        'drift_regulation' => $driftVector['regulation'],
        'drift_norm' => $driftNorm,
        'd_semantisch_delta' => $dSemantischDelta,
        'dominanzwechsel' => $dominanzwechsel,
        'stabilitaet' => $stabilitaet,
        'transition_marker' => $transition_marker,
    ];

    $jsonData[] = $jsonRow;

    // Vorzustand aktualisieren
    if ($tidCurrent > 0) {
        $previousByTeilnehmer[$tidCurrent] = [
            'V' => $V,
            'd_semantisch' => $norm,
            'dominante_dimension' => $dominantDim,
        ];
    }

    if ($counter % 100 === 0) {
        echo "→ {$counter} / {$total} verarbeitet.\n";
    }
}

// --------------------------------------------------------------------------
// JSON-Export Teilnehmerzustände
// --------------------------------------------------------------------------
$teilnehmerJsonFile = __DIR__ . '/frzk_semantische_dichte_teilnehmer_7d.json';
file_put_contents(
    $teilnehmerJsonFile,
    json_encode($jsonData, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)
);

echo "✅ Teilnehmer-JSON geschrieben: {$teilnehmerJsonFile}\n";

// --------------------------------------------------------------------------
// Gruppenaggregation aus 7D-Teilnehmerzuständen
// Gruppierung: gruppe_id + Datum
// --------------------------------------------------------------------------
echo "Berechne Gruppenaggregation ...\n";

$groups = [];

foreach ($jsonData as $row) {
    if (empty($row['gruppe_id']) || empty($row['zeitpunkt'])) {
        continue;
    }

    $datum = substr((string)$row['zeitpunkt'], 0, 10);
    $key = $row['gruppe_id'] . '|' . $datum;

    if (!isset($groups[$key])) {
        $groups[$key] = [
            'gruppe_id' => (int)$row['gruppe_id'],
            'datum' => $datum,
            'n' => 0,
            'sum' => array_fill_keys($dimensions, 0.0),
            'xsum' => array_fill_keys($dimensions, 0.0),
            'd_semantisch_sum' => 0.0,
            'drift_sum' => 0.0,
            'stabilitaet_sum' => 0.0,
            'dominanzwechsel_sum' => 0,
            'polaritaet_sum' => 0,
            'emotion_valenz_sum' => 0.0,
            'emotion_aktivierung_sum' => 0.0,
            'emotion_n' => 0,
        ];
    }

    $groups[$key]['n']++;

    foreach ($dimensions as $dim) {
        $groups[$key]['sum'][$dim] += (float)$row['sum_' . $dim];
        $groups[$key]['xsum'][$dim] += (float)$row['x_' . $dim];
    }

    $groups[$key]['d_semantisch_sum'] += (float)$row['d_semantisch'];
    $groups[$key]['drift_sum'] += (float)$row['drift_norm'];
    $groups[$key]['stabilitaet_sum'] += (float)$row['stabilitaet'];
    $groups[$key]['dominanzwechsel_sum'] += (int)$row['dominanzwechsel'];
    $groups[$key]['polaritaet_sum'] += (int)$row['polaritaet_gesamt'];

    if ($row['emotion_valenz'] !== null) {
        $groups[$key]['emotion_valenz_sum'] += (float)$row['emotion_valenz'];
        $groups[$key]['emotion_aktivierung_sum'] += (float)$row['emotion_aktivierung'];
        $groups[$key]['emotion_n']++;
    }
}

ksort($groups);

$groupJson = [];
$previousByGroup = [];

foreach ($groups as $g) {
    $n = max(1, (int)$g['n']);

    $mean = [];
    $meanX = [];

    foreach ($dimensions as $dim) {
        $mean[$dim] = $g['sum'][$dim] / $n;
        $meanX[$dim] = $g['xsum'][$dim] / $n;
    }

    [$dominanteGruppendimension, $dominanteGruppenwert] = dominantDimension($mean, $dimensions);
    $gruppenPolaritaet = $g['polaritaet_sum'] > 0 ? 1 : ($g['polaritaet_sum'] < 0 ? -1 : 0);
    $meanDSemantisch = $g['d_semantisch_sum'] / $n;

    $gruppenDriftVector = array_fill_keys($dimensions, 0.0);
    $gruppenDriftNorm = 0.0;
    $gruppenDSemantischDelta = 0.0;
    $gruppenDominanzwechsel = 0;

    $gid = (int)$g['gruppe_id'];

    if (isset($previousByGroup[$gid])) {
        $prev = $previousByGroup[$gid];

        foreach ($dimensions as $dim) {
            $gruppenDriftVector[$dim] = $mean[$dim] - $prev['mean'][$dim];
        }

        $gruppenDriftNorm = norm7($gruppenDriftVector);
        $gruppenDSemantischDelta = $meanDSemantisch - $prev['mean_d_semantisch'];
        $gruppenDominanzwechsel = ($dominanteGruppendimension !== $prev['dominante_dimension']) ? 1 : 0;
    }

    $gruppenStabilitaet = 1 / (1 + $gruppenDriftNorm);
    $gruppenTransitionMarker = transitionMarker($gruppenDriftNorm);

    $emotionN = max(1, (int)$g['emotion_n']);

    $groupRow = [
        'gruppe_id' => $gid,
        'datum' => $g['datum'],
        'n' => (int)$g['n'],

        'mean_kognition' => $mean['kognition'],
        'mean_sozial' => $mean['sozial'],
        'mean_affektiv' => $mean['affektiv'],
        'mean_motivation' => $mean['motivation'],
        'mean_methodik' => $mean['methodik'],
        'mean_performanz' => $mean['performanz'],
        'mean_regulation' => $mean['regulation'],

        'mean_x_kognition' => $meanX['kognition'],
        'mean_x_sozial' => $meanX['sozial'],
        'mean_x_affektiv' => $meanX['affektiv'],
        'mean_x_motivation' => $meanX['motivation'],
        'mean_x_methodik' => $meanX['methodik'],
        'mean_x_performanz' => $meanX['performanz'],
        'mean_x_regulation' => $meanX['regulation'],

        'mean_d_semantisch' => $meanDSemantisch,
        'mean_individuelle_drift_norm' => $g['drift_sum'] / $n,
        'mean_individuelle_stabilitaet' => $g['stabilitaet_sum'] / $n,
        'dominanzwechsel_anzahl' => (int)$g['dominanzwechsel_sum'],
        'dominanzwechsel_quote' => (int)$g['dominanzwechsel_sum'] / $n,

        'dominante_gruppendimension' => $dominanteGruppendimension,
        'dominante_gruppendimension_wert' => $dominanteGruppenwert,
        'gruppen_polaritaet' => $gruppenPolaritaet,

        'gruppen_drift_kognition' => $gruppenDriftVector['kognition'],
        'gruppen_drift_sozial' => $gruppenDriftVector['sozial'],
        'gruppen_drift_affektiv' => $gruppenDriftVector['affektiv'],
        'gruppen_drift_motivation' => $gruppenDriftVector['motivation'],
        'gruppen_drift_methodik' => $gruppenDriftVector['methodik'],
        'gruppen_drift_performanz' => $gruppenDriftVector['performanz'],
        'gruppen_drift_regulation' => $gruppenDriftVector['regulation'],
        'gruppen_drift_norm' => $gruppenDriftNorm,
        'gruppen_d_semantisch_delta' => $gruppenDSemantischDelta,
        'gruppen_dominanzwechsel' => $gruppenDominanzwechsel,
        'gruppen_stabilitaet' => $gruppenStabilitaet,
        'gruppen_transition_marker' => $gruppenTransitionMarker,

        'mean_emotion_valenz' => $g['emotion_n'] > 0 ? $g['emotion_valenz_sum'] / $emotionN : null,
        'mean_emotion_aktivierung' => $g['emotion_n'] > 0 ? $g['emotion_aktivierung_sum'] / $emotionN : null,
        'emotion_n' => (int)$g['emotion_n'],
    ];

    $groupJson[] = $groupRow;

    $previousByGroup[$gid] = [
        'mean' => $mean,
        'mean_d_semantisch' => $meanDSemantisch,
        'dominante_dimension' => $dominanteGruppendimension,
    ];
}

$groupJsonFile = __DIR__ . '/frzk_group_semantische_dichte_7d.json';
file_put_contents(
    $groupJsonFile,
    json_encode($groupJson, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)
);

echo "✅ Gruppen-JSON geschrieben: {$groupJsonFile}\n";

echo "🏁 Fertig. {$counter} Teilnehmerzustände und " . count($groupJson) . " Gruppenzustände erzeugt.\n";
