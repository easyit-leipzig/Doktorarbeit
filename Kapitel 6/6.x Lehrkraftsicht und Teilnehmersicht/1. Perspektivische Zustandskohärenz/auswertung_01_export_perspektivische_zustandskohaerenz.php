<?php
// export_01_perspektivische_zustandskohaerenz_sdlg.php

declare(strict_types=1);

$dbHost = "127.0.0.1";
$dbPort = 3306;
$dbName = "icas_19_4_2";
$dbUser = "root";
$dbPass = "";

$outputFile = __DIR__ . "/auswertung_01_perspektivische_zustandskohaerenz_sdlg_export.json";

$dimensions = ["kognition","sozial","affektiv","motivation","methodik","performanz","regulation"];
$maxDayWindow = 3;
$sdlgType = 2; // bei Bedarf auf null setzen

function pdo_conn(): PDO {
    global $dbHost, $dbPort, $dbName, $dbUser, $dbPass;
    return new PDO(
        "mysql:host={$dbHost};port={$dbPort};dbname={$dbName};charset=utf8mb4",
        $dbUser,
        $dbPass,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4"
        ]
    );
}

function fv($v): float {
    return ($v === null || $v === "") ? 0.0 : (float)$v;
}

function norm_date($v): ?string {
    if ($v === null || $v === "") return null;
    return (new DateTime((string)$v))->format("Y-m-d");
}

function day_diff(string $a, string $b): int {
    return (int)(new DateTime($a))->diff(new DateTime($b))->format("%r%a");
}

function vector(array $row, array $dims): array {
    $v = [];
    foreach ($dims as $d) $v[] = fv($row["x_" . $d] ?? null);
    return $v;
}

function euclid(array $a, array $b): float {
    $s = 0.0;
    for ($i=0; $i<count($a); $i++) $s += ($a[$i]-$b[$i]) ** 2;
    return sqrt($s);
}

function cosine(array $a, array $b): ?float {
    $dot=0.0; $na=0.0; $nb=0.0;
    for ($i=0; $i<count($a); $i++) {
        $dot += $a[$i]*$b[$i];
        $na += $a[$i]*$a[$i];
        $nb += $b[$i]*$b[$i];
    }
    if ($na <= 0 || $nb <= 0) return null;
    return $dot / (sqrt($na)*sqrt($nb));
}

function load_teacher(PDO $pdo, string $where = "", array $params = []): array {
    global $sdlgType;

    $typeSql = "";
    if ($sdlgType !== null) {
        $typeSql = " AND sdlg.type = :sdlg_type ";
        $params[":sdlg_type"] = $sdlgType;
    }

    $sql = "
        SELECT DISTINCT
            sdlg.id,
            sdlg.ue_id,
            sdlg.id_mtr_rueckkopplung_datenmaske,
            a.datum,
            a.teilnehmer_id,
            a.lehrkraft_id,
            a.gruppe_id,

            sdlg.x_kognition,
            sdlg.x_sozial,
            sdlg.x_affektiv,
            sdlg.x_motivation,
            sdlg.x_methodik,
            sdlg.x_performanz,
            sdlg.x_regulation,

            sdlg.dominante_dimension,
            sdlg.dominante_dimension_wert,
            sdlg.polaritaet_gesamt,
            sdlg.d_semantisch,

            a.satzanzahl,
            a.semantische_breite,
            a.d_semantisch_mean,
            a.d_semantisch_std,
            a.polaritaet_index,
            a.dominanz_breite
        FROM frzk_semantische_dichte_lehrer_gesamt sdlg
        INNER JOIN analyze_lehrkraftdaten a
            ON a.id_mtr_rueckkopplung_datenmaske = sdlg.id_mtr_rueckkopplung_datenmaske
        WHERE a.datum IS NOT NULL
        {$typeSql}
        {$where}
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return $stmt->fetchAll();
}

function load_participants(PDO $pdo): array {
    $sql = "
        SELECT
            id,
            ue_id,
            gruppe_id,
            teilnehmer_id,
            zeitpunkt,
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
            d_semantisch
        FROM frzk_semantische_dichte_teilnehmer_7d
        WHERE zeitpunkt IS NOT NULL
    ";
    return $pdo->query($sql)->fetchAll();
}

function match_rows(array $teachers, array $participants, array $dims, int $maxDayWindow): array {
    $byGroup = [];
    foreach ($participants as $t) {
        $byGroup[(string)$t["gruppe_id"]][] = $t;
    }

    $matches = [];

    foreach ($teachers as $l) {
        $ld = norm_date($l["datum"] ?? null);
        if (!$ld) continue;

        $lv = vector($l, $dims);
        $group = (string)$l["gruppe_id"];

        foreach ($byGroup[$group] ?? [] as $t) {
            $td = norm_date($t["zeitpunkt"] ?? null);
            if (!$td) continue;

            $delta = day_diff($ld, $td);
            if (abs($delta) > $maxDayWindow) continue;

            if (($l["ue_id"] ?? null) !== null && ($t["ue_id"] ?? null) !== null) {
                if ((int)$l["ue_id"] !== (int)$t["ue_id"]) continue;
            }

            $tv = vector($t, $dims);

            $lvAssoc = [];
            $tvAssoc = [];
            foreach ($dims as $i => $d) {
                $lvAssoc[$d] = $lv[$i];
                $tvAssoc[$d] = $tv[$i];
            }

            $matches[] = [
                "delta_days" => $delta,
                "matching_type" => $delta === 0 ? "gleicher_tag" :
                    ($delta > 0 ? "teilnehmersicht_nach_{$delta}_tag(en)" : "teilnehmersicht_vor_" . abs($delta) . "_tag(en)"),
                "distance_euclidean" => euclid($lv, $tv),
                "cosine_similarity" => cosine($lv, $tv),
                "dominance_match" => ($l["dominante_dimension"] ?? null) === ($t["dominante_dimension"] ?? null),
                "polarity_match" =>
                    ($l["polaritaet_gesamt"] ?? null) !== null &&
                    ($t["polaritaet_gesamt"] ?? null) !== null &&
                    (int)$l["polaritaet_gesamt"] === (int)$t["polaritaet_gesamt"],

                "lehrkraft" => [
                    "quelle" => "frzk_semantische_dichte_lehrer_gesamt + analyze_lehrkraftdaten",
                    "id" => $l["id"],
                    "ue_id" => $l["ue_id"],
                    "id_mtr_rueckkopplung_datenmaske" => $l["id_mtr_rueckkopplung_datenmaske"],
                    "datum" => $ld,
                    "gruppe_id" => $l["gruppe_id"],
                    "teilnehmer_id" => $l["teilnehmer_id"],
                    "lehrkraft_id" => $l["lehrkraft_id"],
                    "vector" => $lvAssoc,
                    "dominante_dimension" => $l["dominante_dimension"],
                    "dominante_dimension_wert" => fv($l["dominante_dimension_wert"] ?? null),
                    "polaritaet_gesamt" => $l["polaritaet_gesamt"],
                    "d_semantisch" => fv($l["d_semantisch"] ?? null),
                    "analyze" => [
                        "satzanzahl" => $l["satzanzahl"],
                        "semantische_breite" => fv($l["semantische_breite"] ?? null),
                        "d_semantisch_mean" => fv($l["d_semantisch_mean"] ?? null),
                        "d_semantisch_std" => fv($l["d_semantisch_std"] ?? null),
                        "polaritaet_index" => fv($l["polaritaet_index"] ?? null),
                        "dominanz_breite" => $l["dominanz_breite"]
                    ]
                ],
                "teilnehmer" => [
                    "id" => $t["id"],
                    "ue_id" => $t["ue_id"],
                    "datum" => $td,
                    "gruppe_id" => $t["gruppe_id"],
                    "teilnehmer_id" => $t["teilnehmer_id"],
                    "vector" => $tvAssoc,
                    "dominante_dimension" => $t["dominante_dimension"],
                    "dominante_dimension_wert" => fv($t["dominante_dimension_wert"] ?? null),
                    "polaritaet_gesamt" => $t["polaritaet_gesamt"],
                    "d_semantisch" => fv($t["d_semantisch"] ?? null)
                ]
            ];
        }
    }

    return $matches;
}

function mean_arr(array $a): ?float {
    if (!$a) return null;
    return array_sum($a) / count($a);
}

function median_arr(array $a): ?float {
    if (!$a) return null;
    sort($a);
    $n = count($a);
    $m = intdiv($n, 2);
    return $n % 2 ? $a[$m] : ($a[$m-1] + $a[$m]) / 2;
}

function summarize(array $matches): array {
    $d=[]; $c=[]; $byDelta=[];
    foreach ($matches as $m) {
        $d[] = $m["distance_euclidean"];
        if ($m["cosine_similarity"] !== null) $c[] = $m["cosine_similarity"];
        $k = (string)$m["delta_days"];
        $byDelta[$k] = ($byDelta[$k] ?? 0) + 1;
    }

    $n = count($matches);

    return [
        "n_matches" => $n,
        "distance_mean" => mean_arr($d),
        "distance_median" => median_arr($d),
        "distance_min" => $d ? min($d) : null,
        "distance_max" => $d ? max($d) : null,
        "cosine_mean" => mean_arr($c),
        "cosine_median" => median_arr($c),
        "dominance_match_rate" => $n ? count(array_filter($matches, fn($m)=>$m["dominance_match"])) / $n : null,
        "polarity_match_rate" => $n ? count(array_filter($matches, fn($m)=>$m["polarity_match"])) / $n : null,
        "matches_by_delta_days" => $byDelta
    ];
}

function build_dataset(PDO $pdo, string $name, string $where="", array $params=[]): array {
    global $dimensions, $maxDayWindow, $sdlgType;

    $teachers = load_teacher($pdo, $where, $params);
    $participants = load_participants($pdo);
    $matches = match_rows($teachers, $participants, $dimensions, $maxDayWindow);

    return [
        "name" => $name,
        "source_teacher" => "frzk_semantische_dichte_lehrer_gesamt joined analyze_lehrkraftdaten",
        "sdlg_type" => $sdlgType,
        "summary" => summarize($matches),
        "matches" => $matches
    ];
}

$pdo = pdo_conn();

$export = [
    "auswertung" => "01_perspektivische_zustandskohaerenz_sdlg",
    "korrektur" => "Lehrkraftbasis ist frzk_semantische_dichte_lehrer_gesamt unter Berücksichtigung von analyze_lehrkraftdaten.",
    "parameter" => [
        "max_day_window" => $maxDayWindow,
        "sdlg_type" => $sdlgType,
        "dimensions" => $dimensions
    ],
    "datasets" => [
        "alle_lehrkraefte" => build_dataset($pdo, "alle_lehrkraefte"),
        "lehrkraft_1" => build_dataset($pdo, "lehrkraft_1", "AND a.lehrkraft_id = :lk", [":lk" => 1]),
        "ohne_lehrkraft_1" => build_dataset($pdo, "ohne_lehrkraft_1", "AND a.lehrkraft_id <> :lk", [":lk" => 1])
    ]
];

file_put_contents(
    $outputFile,
    json_encode($export, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)
);

echo "JSON geschrieben: {$outputFile}\n";
foreach ($export["datasets"] as $k => $v) {
    echo "\n{$k}\n";
    print_r($v["summary"]);
}