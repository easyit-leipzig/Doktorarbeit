<?php

$inputFile = "06x05_nichtlinearitaet.json";
$outputFile = "06x05_nichtlinearitaet_auswertung.html";

if (!file_exists($inputFile)) {
    die("JSON-Datei nicht gefunden: $inputFile");
}

$json = json_decode(
    file_get_contents($inputFile),
    true
);

if (!$json || !isset($json["records"])) {
    die("Ungültige JSON-Struktur.");
}

$rows = $json["records"];

$positive = [
    "1","2","3","4","5","6","7",
    "8","9","10","11","12","13","14",
    "23","26","27","28"
];

$negative = [
    "15","16","17","18","19","20",
    "21","22","24","25"
];

function num($value) {
    if ($value === null || $value === "") {
        return 0.0;
    }
    return floatval($value);
}

function parse_emotions($value) {
    if ($value === null || trim($value) === "") {
        return [];
    }

    $parts = explode(",", $value);
    $result = [];

    foreach ($parts as $p) {
        $p = trim($p);
        if ($p !== "") {
            $result[] = $p;
        }
    }

    return $result;
}

function emotion_count($value) {
    return count(parse_emotions($value));
}

function ambivalenz_index($value, $positive, $negative) {
    $ids = parse_emotions($value);

    $pos = 0;
    $neg = 0;

    foreach ($ids as $id) {
        if (in_array($id, $positive)) {
            $pos++;
        }
        if (in_array($id, $negative)) {
            $neg++;
        }
    }

    if ($pos > 0 && $neg > 0) {
        return min($pos, $neg);
    }

    return 0;
}

$auswertung = [];

foreach ($rows as $r) {
    $emotionCount = emotion_count($r["emotions"] ?? "");
    $ambivalenz = ambivalenz_index($r["emotions"] ?? "", $positive, $negative);

    $index =
        num($r["semantische_breite"] ?? 0)
        + num($r["dominanz_breite"] ?? 0)
        + num($r["var_affektiv"] ?? 0)
        + num($r["var_motivation"] ?? 0)
        + num($r["var_regulation"] ?? 0)
        + $emotionCount
        + $ambivalenz;

    $r["emotion_count"] = $emotionCount;
    $r["ambivalenz_index"] = $ambivalenz;
    $r["nichtlinearitaets_index"] = $index;

    $auswertung[] = $r;
}

usort($auswertung, function($a, $b) {
    return $b["nichtlinearitaets_index"] <=> $a["nichtlinearitaets_index"];
});

$sumIndex = 0;
$sumEmotion = 0;
$sumAmbivalenz = 0;
$n = count($auswertung);

foreach ($auswertung as $r) {
    $sumIndex += $r["nichtlinearitaets_index"];
    $sumEmotion += $r["emotion_count"];
    $sumAmbivalenz += $r["ambivalenz_index"];
}

$meanIndex = $n > 0 ? $sumIndex / $n : 0;
$meanEmotion = $n > 0 ? $sumEmotion / $n : 0;
$meanAmbivalenz = $n > 0 ? $sumAmbivalenz / $n : 0;

$html = "<!DOCTYPE html>
<html lang='de'>
<head>
<meta charset='utf-8'>
<title>6.x.5 Nichtlinearität der Zustandsdynamik</title>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 40px;
}
table {
    border-collapse: collapse;
    width: 100%;
    font-size: 13px;
}
th, td {
    border: 1px solid #ccc;
    padding: 6px;
}
th {
    background: #eee;
}
h1, h2 {
    margin-top: 30px;
}
.summary {
    padding: 15px;
    background: #f5f5f5;
    border: 1px solid #ccc;
    margin-bottom: 25px;
}
</style>
</head>
<body>";

$html .= "<h1>6.x.5 Nichtlinearität der Zustandsdynamik</h1>";

$html .= "<div class='summary'>";
$html .= "<p><strong>Datensätze:</strong> " . $n . "</p>";
$html .= "<p><strong>Mittelwert Nichtlinearitätsindex:</strong> " . round($meanIndex, 4) . "</p>";
$html .= "<p><strong>Mittelwert Emotionsanzahl:</strong> " . round($meanEmotion, 4) . "</p>";
$html .= "<p><strong>Mittelwert Ambivalenzindex:</strong> " . round($meanAmbivalenz, 4) . "</p>";
$html .= "</div>";

$html .= "<h2>Top 30 Fälle mit höchster Nichtlinearität</h2>";

$html .= "<table>";
$html .= "<tr>
<th>Datum</th>
<th>Teilnehmer</th>
<th>Gruppe</th>
<th>semantische_breite</th>
<th>dominanz_breite</th>
<th>var_affektiv</th>
<th>var_motivation</th>
<th>var_regulation</th>
<th>Emotionen</th>
<th>Emotionsanzahl</th>
<th>Ambivalenz</th>
<th>Nichtlinearitätsindex</th>
</tr>";

$top = array_slice($auswertung, 0, 30);

foreach ($top as $r) {
    $html .= "<tr>";
    $html .= "<td>" . htmlspecialchars($r["datum"] ?? "") . "</td>";
    $html .= "<td>" . htmlspecialchars($r["teilnehmer_id"] ?? "") . "</td>";
    $html .= "<td>" . htmlspecialchars($r["gruppe_id"] ?? "") . "</td>";
    $html .= "<td>" . round(num($r["semantische_breite"] ?? 0), 4) . "</td>";
    $html .= "<td>" . round(num($r["dominanz_breite"] ?? 0), 4) . "</td>";
    $html .= "<td>" . round(num($r["var_affektiv"] ?? 0), 4) . "</td>";
    $html .= "<td>" . round(num($r["var_motivation"] ?? 0), 4) . "</td>";
    $html .= "<td>" . round(num($r["var_regulation"] ?? 0), 4) . "</td>";
    $html .= "<td>" . htmlspecialchars($r["emotions"] ?? "") . "</td>";
    $html .= "<td>" . $r["emotion_count"] . "</td>";
    $html .= "<td>" . $r["ambivalenz_index"] . "</td>";
    $html .= "<td>" . round($r["nichtlinearitaets_index"], 4) . "</td>";
    $html .= "</tr>";
}

$html .= "</table>";

$html .= "<h2>Methodische Kurzdeutung</h2>";
$html .= "<p>
Der Nichtlinearitätsindex verbindet semantische Breite, Dominanzbreite,
affektive Varianz, motivationale Varianz, regulatorische Varianz,
Emotionsvielfalt und Ambivalenz. Hohe Werte markieren Zustände, in denen
keine einfache lineare Spiegelung zwischen Lehrkraft- und Teilnehmerraum
angenommen werden sollte. Stattdessen sprechen solche Fälle für
hybride, überlagerte und rekursiv-transformatorische Zustandsdynamiken
im Sinne des FRZK.
</p>";

$html .= "</body></html>";

file_put_contents($outputFile, $html);

echo "HTML-Auswertung erzeugt: " . $outputFile . PHP_EOL;

?>