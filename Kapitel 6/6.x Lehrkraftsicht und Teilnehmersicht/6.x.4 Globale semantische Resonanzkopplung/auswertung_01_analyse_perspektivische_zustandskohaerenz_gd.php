<?php
$in = __DIR__ . "/6x4_globale_semantische_resonanz_match.json";
$outDir = __DIR__ . "/6x4_globale_resonanz_output_php";
if (!is_dir($outDir)) mkdir($outDir, 0777, true);

$data = json_decode(file_get_contents($in), true);
$records = $data["records"];

function mean($arr) {
    $arr = array_values(array_filter($arr, fn($v) => $v !== null));
    return count($arr) ? array_sum($arr) / count($arr) : null;
}

function summarize($items) {
    $cos = array_values(array_filter(array_map(fn($r) => $r["cosine_tn_lk_sdlg"], $items), fn($v) => $v !== null));
    $dst = array_values(array_filter(array_map(fn($r) => $r["euclid_tn_lk_sdlg"], $items), fn($v) => $v !== null));
    return [
        "n" => count($items),
        "cos_mean" => mean($cos),
        "cos_min" => count($cos) ? min($cos) : null,
        "cos_max" => count($cos) ? max($cos) : null,
        "dist_mean" => mean($dst),
    ];
}

$groups = [
    "alle" => $records,
    "lehrkraft_1" => array_values(array_filter($records, fn($r) => $r["subset"] === "lehrkraft_1")),
    "ohne_lehrkraft_1" => array_values(array_filter($records, fn($r) => $r["subset"] === "ohne_lehrkraft_1")),
];

$summary = [];
foreach ($groups as $name => $items) $summary[$name] = summarize($items);

file_put_contents($outDir . "/summary_globale_resonanz.json", json_encode($summary, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));

$txt = "6.x.4 Globale semantische Resonanzkopplung\n\n";
$txt .= "Datenbasis: match_tn_daten_analyze_lehrkraft\n";
$txt .= "Resonanzmaß: Kosinusähnlichkeit Teilnehmer ↔ Lehrkraft im 7D-FRZK-Raum.\n\n";

foreach ($summary as $name => $s) {
    $txt .= sprintf(
        "%s: n=%d, mittlere Kosinusähnlichkeit=%.4f, Bereich=%.4f–%.4f, mittlere euklidische Distanz=%.4f\n",
        $name,
        $s["n"],
        $s["cos_mean"],
        $s["cos_min"],
        $s["cos_max"],
        $s["dist_mean"]
    );
}

$txt .= "\nDissertationsfähige Kurzinterpretation:\n";
$txt .= "Die globale semantische Resonanzkopplung prüft, ob die Teilnehmerzustände und die Lehrkraftzustände ";
$txt .= "nicht nur in Einzelmerkmalen, sondern als vollständige 7D-Richtungsstruktur gekoppelt sind. ";
$txt .= "Hohe Kosinusähnlichkeiten zeigen, dass beide Perspektiven innerhalb eines gemeinsamen semantischen ";
$txt .= "Resonanzraumes organisiert sind. Entscheidend ist dabei nicht die Identität der Werte, sondern die ";
$txt .= "Richtungsähnlichkeit der Zustandsvektoren.\n";

file_put_contents($outDir . "/dissertationsauswertung_6x4.txt", $txt);

echo $txt;