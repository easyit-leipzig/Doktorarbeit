<?php
// export_dominanztransitionen.php

$outfile = "dominanztransitionen.json";

$pdo = new PDO(
    "mysql:host=127.0.0.1;port=3306;dbname=icas_19_4_2;charset=utf8mb4",
    "root",
    "",
    [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
);

$sql = "
SELECT
    m.gruppe_id,
    m.teilnehmer_id,
    m.datum,
    s.id AS sdlg_id,
    s.id_mtr_rueckkopplung_datenmaske,
    s.dominante_dimension,
    s.dominante_dimension_wert,
    s.polaritaet_gesamt,
    s.d_semantisch,
    s.type
FROM frzk_semantische_dichte_lehrer_gesamt s
JOIN mtr_rueckkopplung_datenmaske m
  ON m.id = s.id_mtr_rueckkopplung_datenmaske
WHERE s.type = 1
  AND s.dominante_dimension IS NOT NULL
ORDER BY m.gruppe_id, m.teilnehmer_id, m.datum, s.id
";

$rows = $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);

$groups = [];
foreach ($rows as $r) {
    $key = $r["gruppe_id"] . "_" . $r["teilnehmer_id"];
    $groups[$key][] = $r;
}

$transitions = [];
foreach ($groups as $seq) {
    for ($i = 0; $i < count($seq) - 1; $i++) {
        $a = $seq[$i];
        $b = $seq[$i + 1];
        $from = $a["dominante_dimension"];
        $to = $b["dominante_dimension"];

        $transitions[] = [
            "gruppe_id" => (int)$a["gruppe_id"],
            "teilnehmer_id" => (int)$a["teilnehmer_id"],
            "datum_t" => $a["datum"],
            "datum_t1" => $b["datum"],
            "from" => $from,
            "to" => $to,
            "transition" => $from . "->" . $to,
            "stable" => $from === $to,
            "wert_t" => (float)$a["dominante_dimension_wert"],
            "wert_t1" => (float)$b["dominante_dimension_wert"],
            "delta_wert" => (float)$b["dominante_dimension_wert"] - (float)$a["dominante_dimension_wert"],
            "polaritaet_t" => (int)$a["polaritaet_gesamt"],
            "polaritaet_t1" => (int)$b["polaritaet_gesamt"],
            "d_semantisch_t" => (float)$a["d_semantisch"],
            "d_semantisch_t1" => (float)$b["d_semantisch"],
            "delta_d_semantisch" => (float)$b["d_semantisch"] - (float)$a["d_semantisch"]
        ];
    }
}

$transitionCounts = [];
$fromCounts = [];
foreach ($transitions as $t) {
    $transitionCounts[$t["transition"]] = ($transitionCounts[$t["transition"]] ?? 0) + 1;
    $fromCounts[$t["from"]] = ($fromCounts[$t["from"]] ?? 0) + 1;
}

$matrix = [];
foreach ($transitionCounts as $tr => $count) {
    [$from, $to] = explode("->", $tr);
    $matrix[$from][$to] = [
        "count" => $count,
        "probability" => $fromCounts[$from] > 0 ? $count / $fromCounts[$from] : 0
    ];
}

$stable = 0;
foreach ($transitions as $t) {
    if ($t["stable"]) $stable++;
}

$out = [
    "metadata" => [
        "auswertungspunkt" => "Dominanztransitionen",
        "scope" => "ohne_lehrkraftunterscheidung",
        "source_tables" => [
            "frzk_semantische_dichte_lehrer_gesamt",
            "mtr_rueckkopplung_datenmaske"
        ]
    ],
    "summary" => [
        "n_records" => count($rows),
        "n_sequences" => count($groups),
        "n_transitions" => count($transitions),
        "stable_transitions" => $stable,
        "stability_rate" => count($transitions) > 0 ? $stable / count($transitions) : 0,
        "transition_counts" => $transitionCounts,
        "transition_matrix" => $matrix
    ],
    "records" => $rows,
    "transitions" => $transitions
];

file_put_contents($outfile, json_encode($out, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
echo "JSON exportiert: $outfile\n";
?>