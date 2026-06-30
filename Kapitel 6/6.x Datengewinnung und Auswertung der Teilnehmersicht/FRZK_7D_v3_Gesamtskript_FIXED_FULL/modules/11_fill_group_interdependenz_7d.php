<?php
// ============================================================================
// 11_fill_group_interdependenz_7d.php
// Interdependenz/Kohärenz der sieben Gruppendimensionen.
// ============================================================================

function frzk7d_fill_group_interdependenz(PDO $pdo, array $dimensions): void
{
    $rows = $pdo->query("SELECT * FROM frzk_group_semantische_dichte_7d ORDER BY gruppe_id, zeitpunkt")->fetchAll();
    $insert = $pdo->prepare("INSERT INTO frzk_group_interdependenz_7d
        (gruppe_id, zeitpunkt, mean_kognition, mean_sozial, mean_affektiv, mean_motivation, mean_methodik, mean_performanz, mean_regulation,
         d_semantisch_mean, korrelationsscore, kohaerenz_index, varianz_7d, bemerkung)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $count = 0;
    foreach ($rows as $row) {
        $v = [];
        foreach ($dimensions as $dim) {
            $v[$dim] = (float)$row['mean_' . $dim];
        }
        $values = array_values($v);
        $var = varianceN($values);
        $norm = normN($values);
        $meanAbs = count($values) ? array_sum(array_map('abs', $values)) / count($values) : 0.0;
        $spread = max($values) - min($values);
        $coherence = 1.0 / (1.0 + $var + abs($spread));
        $corr = $norm > 0 ? ($meanAbs / $norm) : 0.0;
        $remark = sprintf('7D-Interdependenz: Corr=%.4f; Kohärenz=%.4f; Varianz=%.4f; Spread=%.4f', $corr, $coherence, $var, $spread);

        $insert->execute([
            (int)$row['gruppe_id'],
            $row['zeitpunkt'],
            $v['kognition'], $v['sozial'], $v['affektiv'], $v['motivation'], $v['methodik'], $v['performanz'], $v['regulation'],
            (float)$row['d_semantisch_mean'],
            $corr,
            $coherence,
            $var,
            $remark
        ]);
        $count++;
    }

    echo "✅ frzk_group_interdependenz_7d befüllt ($count Einträge).\n";
}
?>
