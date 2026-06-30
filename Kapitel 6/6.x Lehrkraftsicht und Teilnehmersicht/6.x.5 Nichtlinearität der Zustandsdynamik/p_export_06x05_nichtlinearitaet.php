<?php

$host = "127.0.0.1";
$dbname = "icas_19_4_2";
$user = "root";
$password = "";

$outputFile = "06x05_nichtlinearitaet.json";

try {
    $pdo = new PDO(
        "mysql:host=$host;dbname=$dbname;charset=utf8mb4",
        $user,
        $password,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
        ]
    );

    $sql = "
        SELECT
            *
        FROM match_tn_daten_analyze_lehrkraft
        ORDER BY datum, teilnehmer_id, sdlg_type
    ";

    $stmt = $pdo->query($sql);
    $rows = $stmt->fetchAll();

    $result = [
        "auswertung" => "6.x.5 Nichtlinearität der Zustandsdynamik",
        "beschreibung" => "Export ohne Lehrkraftunterscheidung aus match_tn_daten_analyze_lehrkraft",
        "anzahl_datensaetze" => count($rows),
        "records" => $rows
    ];

    file_put_contents(
        $outputFile,
        json_encode(
            $result,
            JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
        )
    );

    echo "JSON erzeugt: " . $outputFile . PHP_EOL;
    echo "Datensätze: " . count($rows) . PHP_EOL;

} catch (PDOException $e) {
    echo "Datenbankfehler: " . $e->getMessage() . PHP_EOL;
    exit(1);
}