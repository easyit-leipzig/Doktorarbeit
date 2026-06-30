<?php
/**
 * 6.x.6 Drift- und Varianzkorrelationen – Exportskript (PHP)
 * Erzeugt EIN JSON ohne Lehrkraftunterscheidung.
 */
declare(strict_types=1);

$outfile = __DIR__ . DIRECTORY_SEPARATOR . '6x6_drift_varianz_korrelationen.json';
$dims = ['kognition','sozial','affektiv','motivation','methodik','performanz','regulation'];
$tnFields = ['mitarbeit','absprachen','selbststaendigkeit','konzentration','fleiss','lernfortschritt','beherrscht_thema','transferdenken','basiswissen','vorbereitet','themenauswahl','materialien','methodenvielfalt','individualisierung','aufforderung','zielgruppen'];

$pdo = new PDO('mysql:host=127.0.0.1;port=3306;dbname=icas_19_4_2;charset=utf8mb4', 'root', '', [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$tnSelect = implode(', ', $tnFields);
$sql = "
    SELECT
        teilnehmer_feedback_id, teilnehmer_ue_id, teilnehmer_id, gruppe_id,
        erfasst_am, teilnehmer_datum,
        $tnSelect, emotions, bemerkungen,
        id_mtr_rueckkopplung_datenmaske, datum, satzanzahl,
        mean_kognition, mean_sozial, mean_affektiv, mean_motivation,
        mean_methodik, mean_performanz, mean_regulation,
        var_kognition, var_sozial, var_affektiv, var_motivation,
        var_methodik, var_performanz, var_regulation,
        d_semantisch_mean, d_semantisch_std, semantische_breite, dominanz_breite,
        x_kognition, x_sozial, x_affektiv, x_motivation, x_methodik, x_performanz, x_regulation,
        dominante_dimension, dominante_dimension_wert, polaritaet_gesamt,
        d_semantisch, token_anzahl, funktionsklassen_anzahl_gesamt
    FROM match_tn_daten_analyze_lehrkraft
    WHERE sdlg_type = 1
    ORDER BY teilnehmer_id, erfasst_am, teilnehmer_feedback_id
";
$rows = $pdo->query($sql)->fetchAll();
$emotions = $pdo->query("SELECT id, type_name, fine_label, emotion, map_field, valenz, aktivierung FROM _mtr_emotionen ORDER BY id")->fetchAll();

$payload = [
    'meta' => [
        'auswertung' => '6.x.6 Drift- und Varianzkorrelationen',
        'created_at' => date('c'),
        'database' => 'icas_19_4_2',
        'source_view' => 'match_tn_daten_analyze_lehrkraft',
        'emotion_table' => '_mtr_emotionen',
        'teacher_filter' => 'keine Lehrkraftunterscheidung; alle Datensätze gemeinsam',
        'row_count' => count($rows),
        'dimensions' => $dims,
        'teilnehmer_fields' => $tnFields,
        'method' => 'Exportiert gepaarte Lehrkraft-/Teilnehmerzustände. Analyse berechnet Teilnehmerdrift aus zeitlich aufeinanderfolgenden Teilnehmerzuständen und korreliert diese mit Lehrkraftvarianz, semantischer Breite und Emotionsambivalenz.'
    ],
    'emotion_lookup' => $emotions,
    'data' => $rows,
];

file_put_contents($outfile, json_encode($payload, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
echo "OK: $outfile geschrieben (" . count($rows) . " Datensätze).\n";
