<?php
$outFile = __DIR__ . "/6x7_regulatorische_stabilisierung.json";

$pdo = new PDO(
    "mysql:host=127.0.0.1;port=3306;dbname=icas_19_4_2;charset=utf8mb4",
    "root",
    "",
    [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
);

$dim = ["kognition","sozial","affektiv","motivation","methodik","performanz","regulation"];

$emoStmt = $pdo->query("SELECT id, valenz, aktivierung FROM _mtr_emotionen");
$emotions = [];
foreach ($emoStmt->fetchAll(PDO::FETCH_ASSOC) as $e) {
    $emotions[(int)$e["id"]] = [
        "valenz" => (float)$e["valenz"],
        "aktivierung" => (float)$e["aktivierung"]
    ];
}

$stmt = $pdo->query("
    SELECT *
    FROM match_tn_daten_analyze_lehrkraft
    WHERE sdlg_type = 1
    ORDER BY teilnehmer_datum, gruppe_id, teilnehmer_id
");

$records = [];

function avg_or_null($arr) {
    $arr = array_values(array_filter($arr, fn($v) => $v !== null));
    return count($arr) ? array_sum($arr) / count($arr) : null;
}

foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $r) {
    global $dim, $emotions;

    $emoIds = [];
    if (!empty($r["emotions"])) {
        foreach (explode(",", $r["emotions"]) as $x) {
            $x = trim($x);
            if (ctype_digit($x)) $emoIds[] = (int)$x;
        }
    }

    $valenzen = [];
    $aktivierungen = [];
    foreach ($emoIds as $id) {
        if (isset($emotions[$id])) {
            $valenzen[] = $emotions[$id]["valenz"];
            $aktivierungen[] = $emotions[$id]["aktivierung"];
        }
    }

    $varSum = 0.0;
    foreach ($dim as $d) $varSum += (float)$r["var_$d"];

    $meanVector = [];
    $xVector = [];
    foreach ($dim as $d) {
        $meanVector[$d] = (float)$r["mean_$d"];
        $xVector[$d] = (float)$r["x_$d"];
    }

    $records[] = [
        "teilnehmer_feedback_id" => (int)$r["teilnehmer_feedback_id"],
        "datum" => $r["teilnehmer_datum"],
        "gruppe_id" => (int)$r["gruppe_id"],
        "teilnehmer_id" => (int)$r["teilnehmer_id"],

        "regulation_lehrkraft" => (float)$r["mean_regulation"],
        "affektiv_lehrkraft" => (float)$r["mean_affektiv"],
        "motivation_lehrkraft" => (float)$r["mean_motivation"],
        "methodik_lehrkraft" => (float)$r["mean_methodik"],
        "performanz_lehrkraft" => (float)$r["mean_performanz"],

        "varianz_summe" => $varSum,
        "semantische_breite" => (float)$r["semantische_breite"],
        "d_semantisch_mean" => (float)$r["d_semantisch_mean"],
        "d_semantisch_std" => (float)$r["d_semantisch_std"],
        "dominanz_breite" => (float)$r["dominanz_breite"],
        "coherence_index" => 1 / (1 + $varSum + (float)$r["semantische_breite"]),
        "ambivalence_index" => (float)$r["d_semantisch_std"] + ((float)$r["dominanz_breite"] / 7),

        "emotion_ids" => $emoIds,
        "emotion_valenz_mean" => avg_or_null($valenzen),
        "emotion_aktivierung_mean" => avg_or_null($aktivierungen),

        "x_vector" => $xVector,
        "mean_vector" => $meanVector
    ];
}

usort($records, fn($a, $b) =>
    [$a["gruppe_id"], $a["teilnehmer_id"], $a["datum"]]
    <=>
    [$b["gruppe_id"], $b["teilnehmer_id"], $b["datum"]]
);

$prev = [];
foreach ($records as &$r) {
    $key = $r["gruppe_id"] . "_" . $r["teilnehmer_id"];
    $vec = array_values($r["mean_vector"]);

    if (isset($prev[$key])) {
        $sum = 0;
        for ($i = 0; $i < count($vec); $i++) {
            $sum += pow($vec[$i] - $prev[$key][$i], 2);
        }
        $r["drift_zur_vorsitzung"] = sqrt($sum);
    } else {
        $r["drift_zur_vorsitzung"] = null;
    }

    $prev[$key] = $vec;
}

$data = [
    "auswertung" => "6.x.7 Regulatorische Stabilisierung",
    "beschreibung" => "Regulatorische Lehrkraftzustände ohne Lehrkraftunterscheidung im Zusammenhang mit emotionaler Stabilisierung, Drift, Kohärenz und Ambivalenz.",
    "datenquelle" => "match_tn_daten_analyze_lehrkraft + _mtr_emotionen",
    "dimensionen" => $dim,
    "n" => count($records),
    "records" => $records
];

file_put_contents($outFile, json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
echo "JSON erzeugt: $outFile | Datensätze: " . count($records) . PHP_EOL;