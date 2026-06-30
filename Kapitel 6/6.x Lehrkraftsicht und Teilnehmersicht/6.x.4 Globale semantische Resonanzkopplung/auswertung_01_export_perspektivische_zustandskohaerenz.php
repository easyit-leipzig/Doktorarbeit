<?php
$out = __DIR__ . "/6x4_globale_semantische_resonanz_match.json";

$pdo = new PDO(
    "mysql:host=127.0.0.1;port=3306;dbname=icas_19_4_2;charset=utf8mb4",
    "root",
    "",
    [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]
);

$dims = ["kognition","sozial","affektiv","motivation","methodik","performanz","regulation"];

function num($v) {
    return $v === null ? null : (float)$v;
}

function rating_to_positive($v) {
    if ($v === null || $v === "" || (float)$v <= 0) return null;
    $x = (5.0 - (float)$v) / 4.0;
    return max(0.0, min(1.0, $x));
}

function avg_vals($arr) {
    $vals = array_values(array_filter($arr, fn($v) => $v !== null));
    if (count($vals) === 0) return null;
    return array_sum($vals) / count($vals);
}

function cosine($a, $b) {
    foreach (array_merge($a, $b) as $v) if ($v === null) return null;
    $dot = 0; $na = 0; $nb = 0;
    for ($i=0; $i<count($a); $i++) {
        $dot += $a[$i] * $b[$i];
        $na += $a[$i] * $a[$i];
        $nb += $b[$i] * $b[$i];
    }
    if ($na == 0 || $nb == 0) return null;
    return $dot / (sqrt($na) * sqrt($nb));
}

function euclid($a, $b) {
    foreach (array_merge($a, $b) as $v) if ($v === null) return null;
    $s = 0;
    for ($i=0; $i<count($a); $i++) $s += pow($a[$i] - $b[$i], 2);
    return sqrt($s);
}

function build_tn_vector($r) {
    return [
        "kognition" => avg_vals([rating_to_positive($r["beherrscht_thema"]), rating_to_positive($r["transferdenken"]), rating_to_positive($r["basiswissen"])]),
        "sozial" => avg_vals([rating_to_positive($r["mitarbeit"]), rating_to_positive($r["zielgruppen"])]),
        "affektiv" => avg_vals([rating_to_positive($r["fleiss"])]),
        "motivation" => avg_vals([rating_to_positive($r["fleiss"]), rating_to_positive($r["lernfortschritt"])]),
        "methodik" => avg_vals([rating_to_positive($r["themenauswahl"]), rating_to_positive($r["methodenvielfalt"]), rating_to_positive($r["individualisierung"])]),
        "performanz" => avg_vals([rating_to_positive($r["lernfortschritt"]), rating_to_positive($r["beherrscht_thema"])]),
        "regulation" => avg_vals([rating_to_positive($r["absprachen"]), rating_to_positive($r["selbststaendigkeit"]), rating_to_positive($r["konzentration"]), rating_to_positive($r["vorbereitet"]), rating_to_positive($r["aufforderung"])]),
    ];
}

function summarize($items) {
    $cos = array_values(array_filter(array_map(fn($r) => $r["cosine_tn_lk_sdlg"], $items), fn($v) => $v !== null));
    $dst = array_values(array_filter(array_map(fn($r) => $r["euclid_tn_lk_sdlg"], $items), fn($v) => $v !== null));
    return [
        "n" => count($items),
        "cosine_mean" => count($cos) ? array_sum($cos)/count($cos) : null,
        "cosine_min" => count($cos) ? min($cos) : null,
        "cosine_max" => count($cos) ? max($cos) : null,
        "euclid_mean" => count($dst) ? array_sum($dst)/count($dst) : null,
    ];
}

$sql = "SELECT * FROM match_tn_daten_analyze_lehrkraft WHERE sdlg_type = 1 ORDER BY datum, gruppe_id, teilnehmer_id";
$rows = $pdo->query($sql)->fetchAll();

$records = [];
foreach ($rows as $r) {
    $tnVec = build_tn_vector($r);
    $lkVec = [];
    $lkMean = [];
    foreach ($dims as $d) {
        $lkVec[$d] = num($r["x_$d"]);
        $lkMean[$d] = num($r["mean_$d"]);
    }

    $tn = array_map(fn($d) => $tnVec[$d], $dims);
    $lk = array_map(fn($d) => $lkVec[$d], $dims);
    $lkm = array_map(fn($d) => $lkMean[$d], $dims);

    $records[] = [
        "teilnehmer_feedback_id" => (int)$r["teilnehmer_feedback_id"],
        "teilnehmer_id" => (int)$r["teilnehmer_id"],
        "gruppe_id" => (int)$r["gruppe_id"],
        "lehrkraft_id" => (int)$r["lehrkraft_id"],
        "datum" => $r["datum"],
        "erfasst_am" => $r["erfasst_am"],
        "id_mtr_rueckkopplung_datenmaske" => (int)$r["id_mtr_rueckkopplung_datenmaske"],
        "satzanzahl" => (int)$r["satzanzahl"],
        "teilnehmer_vector_7d" => $tnVec,
        "lehrkraft_vector_7d_sdlg" => $lkVec,
        "lehrkraft_vector_7d_mean" => $lkMean,
        "cosine_tn_lk_sdlg" => cosine($tn, $lk),
        "cosine_tn_lk_mean" => cosine($tn, $lkm),
        "euclid_tn_lk_sdlg" => euclid($tn, $lk),
        "euclid_tn_lk_mean" => euclid($tn, $lkm),
        "d_semantisch_lehrkraft" => num($r["d_semantisch"]),
        "d_semantisch_mean" => num($r["d_semantisch_mean"]),
        "semantische_breite" => num($r["semantische_breite"]),
        "dominanz_breite" => num($r["dominanz_breite"]),
        "dominante_dimension" => $r["dominante_dimension"],
        "polaritaet_gesamt" => $r["polaritaet_gesamt"] === null ? null : (int)$r["polaritaet_gesamt"],
        "subset" => ((int)$r["lehrkraft_id"] === 1) ? "lehrkraft_1" : "ohne_lehrkraft_1",
    ];
}

$data = [
    "meta" => [
        "title" => "6.x.4 Globale semantische Resonanzkopplung",
        "source_view" => "match_tn_daten_analyze_lehrkraft",
        "dimensions" => $dims,
        "participant_mapping" => "Teilnehmer-Skalenwerte invers normiert: 1 -> 1.0, 4 -> 0.25, 0/NULL -> fehlend.",
        "created_at" => date("c"),
    ],
    "summary" => [
        "alle" => summarize($records),
        "lehrkraft_1" => summarize(array_values(array_filter($records, fn($r) => $r["subset"] === "lehrkraft_1"))),
        "ohne_lehrkraft_1" => summarize(array_values(array_filter($records, fn($r) => $r["subset"] === "ohne_lehrkraft_1"))),
    ],
    "records" => $records,
];

file_put_contents($out, json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
echo "JSON erzeugt: $out\n";
echo json_encode($data["summary"], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT) . "\n";