<?php
$inFile = __DIR__ . "/6x7_regulatorische_stabilisierung.json";
$outDir = __DIR__ . "/6x7_regulatorische_stabilisierung_auswertung_php";

if (!is_dir($outDir)) mkdir($outDir);

$data = json_decode(file_get_contents($inFile), true);
$rows = $data["records"];

function mean_col($rows, $col) {
    $vals = [];
    foreach ($rows as $r) {
        if (isset($r[$col]) && $r[$col] !== null) $vals[] = (float)$r[$col];
    }
    return count($vals) ? array_sum($vals) / count($vals) : null;
}

function corr_col($rows, $a, $b) {
    $x = [];
    $y = [];
    foreach ($rows as $r) {
        if (isset($r[$a], $r[$b]) && $r[$a] !== null && $r[$b] !== null) {
            $x[] = (float)$r[$a];
            $y[] = (float)$r[$b];
        }
    }
    $n = count($x);
    if ($n < 3) return null;

    $mx = array_sum($x) / $n;
    $my = array_sum($y) / $n;

    $num = $sx = $sy = 0;
    for ($i = 0; $i < $n; $i++) {
        $dx = $x[$i] - $mx;
        $dy = $y[$i] - $my;
        $num += $dx * $dy;
        $sx += $dx * $dx;
        $sy += $dy * $dy;
    }

    if ($sx == 0 || $sy == 0) return null;
    return $num / sqrt($sx * $sy);
}

$metrics = [
    "n" => count($rows),
    "regulation_mean" => mean_col($rows, "regulation_lehrkraft"),
    "corr_regulation_emotion_valenz" => corr_col($rows, "regulation_lehrkraft", "emotion_valenz_mean"),
    "corr_regulation_drift" => corr_col($rows, "regulation_lehrkraft", "drift_zur_vorsitzung"),
    "corr_regulation_coherence" => corr_col($rows, "regulation_lehrkraft", "coherence_index"),
    "corr_regulation_ambivalence" => corr_col($rows, "regulation_lehrkraft", "ambivalence_index"),
    "corr_regulation_semantische_breite" => corr_col($rows, "regulation_lehrkraft", "semantische_breite"),
    "corr_regulation_dichte_std" => corr_col($rows, "regulation_lehrkraft", "d_semantisch_std")
];

file_put_contents(
    $outDir . "/kennwerte.json",
    json_encode($metrics, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE)
);

$bericht = "# 6.x.7 Regulatorische Stabilisierung – PHP-Auswertung\n\n";
$bericht .= "Datensätze: " . $metrics["n"] . "\n\n";
$bericht .= "Mittelwert Regulation: " . round($metrics["regulation_mean"], 4) . "\n\n";
$bericht .= "## Korrelationen\n";

foreach ($metrics as $k => $v) {
    if (str_starts_with($k, "corr_")) {
        $bericht .= "- $k: " . ($v === null ? "nicht berechenbar" : round($v, 4)) . "\n";
    }
}

$bericht .= "\n## Interpretation\n";
$bericht .= "Positive Zusammenhänge zwischen Regulation und Kohärenz bzw. emotionaler Valenz sprechen für regulatorische Stabilisierung. ";
$bericht .= "Negative Zusammenhänge zwischen Regulation und Drift, Ambivalenz oder semantischer Breite sprechen dafür, dass Regulation im FRZK-Raum als stabilisierende Kopplungsdimension wirkt.\n";

file_put_contents($outDir . "/bericht.md", $bericht);

echo "PHP-Auswertung erzeugt in: $outDir" . PHP_EOL;