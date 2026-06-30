<?php
// ============================================================================
// 09_fill_group_reflexion_7d.php
// Gruppenreflexion aus Stabilität und Meta-Kohärenz der Gruppendrift.
// ============================================================================

function frzk7d_fill_group_reflexion(PDO $pdo): void
{
    $rows = $pdo->query("SELECT * FROM frzk_group_semantische_dichte_7d ORDER BY gruppe_id, zeitpunkt")->fetchAll();
    $groups = [];
    foreach ($rows as $row) {
        $groups[(int)$row['gruppe_id']][] = $row;
    }

    $insert = $pdo->prepare("INSERT INTO frzk_group_reflexion_7d
        (gruppe_id, zeitpunkt, reflexionsgrad, meta_kohaerenz, selbstbezug_index, stabilitaet, marker, bemerkung)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

    $count = 0;
    foreach ($groups as $gid => $entries) {
        if (!$entries) {
            continue;
        }

        $drift = array_map(fn($r) => (float)$r['gruppen_drift_norm'], $entries);
        $stabilities = array_map(fn($r) => (float)$r['gruppen_stabilitaet'], $entries);
        $meta = 1.0 / (1.0 + varianceN($drift));
        $stability = count($stabilities) ? array_sum($stabilities) / count($stabilities) : 0.0;
        $selfRef = 0.0;
        $degree = 0.60 * $stability + 0.40 * $meta;
        $marker = $degree < 0.33 ? 'niedrig' : ($degree < 0.66 ? 'mittel' : 'hoch');
        $lastDate = end($entries)['zeitpunkt'];
        $remark = sprintf('Reflexionsgrad=%.4f; Meta-Kohärenz=%.4f; Stabilität=%.4f; Driftvarianz=%.4f', $degree, $meta, $stability, varianceN($drift));

        $insert->execute([$gid, $lastDate, $degree, $meta, $selfRef, $stability, $marker, $remark]);
        $count++;
    }

    echo "✅ frzk_group_reflexion_7d befüllt ($count Einträge).\n";
}
?>
