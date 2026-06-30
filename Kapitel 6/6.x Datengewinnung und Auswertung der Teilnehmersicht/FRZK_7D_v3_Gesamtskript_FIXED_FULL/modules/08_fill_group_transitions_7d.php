<?php
// ============================================================================
// 08_fill_group_transitions_7d.php
// Gruppentransitionen aus frzk_group_semantische_dichte_7d.
// ============================================================================

function frzk7d_fill_group_transitions(PDO $pdo): void
{
    $rows = $pdo->query("SELECT * FROM frzk_group_semantische_dichte_7d ORDER BY gruppe_id, zeitpunkt")->fetchAll();
    $groups = [];
    foreach ($rows as $row) {
        $groups[(int)$row['gruppe_id']][] = $row;
    }

    $insert = $pdo->prepare("INSERT INTO frzk_group_transitions_7d
        (gruppe_id, zeitpunkt_von, zeitpunkt_nach, dominante_dimension_von, dominante_dimension_nach,
         d_von, d_nach, delta, transition_typ, dominanzwechsel, bemerkung)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $count = 0;
    foreach ($groups as $gid => $entries) {
        if (count($entries) < 2) {
            continue;
        }

        for ($i = 1; $i < count($entries); $i++) {
            $prev = $entries[$i - 1];
            $curr = $entries[$i];
            $delta = (float)$curr['gruppen_drift_norm'];
            $stability = (float)$curr['gruppen_stabilitaet'];
            $change = ((string)$prev['dominante_dimension'] !== (string)$curr['dominante_dimension']) ? 1 : 0;
            $type = transitionMarker7d($delta, $stability);
            $remark = sprintf(
                'Gruppe %d: %s -> %s; D %.4f -> %.4f; Delta=%.4f; Stabilitaet=%.4f',
                $gid,
                (string)$prev['dominante_dimension'],
                (string)$curr['dominante_dimension'],
                (float)$prev['d_semantisch_mean'],
                (float)$curr['d_semantisch_mean'],
                $delta,
                $stability
            );

            $insert->execute([
                $gid,
                $prev['zeitpunkt'],
                $curr['zeitpunkt'],
                $prev['dominante_dimension'],
                $curr['dominante_dimension'],
                (float)$prev['d_semantisch_mean'],
                (float)$curr['d_semantisch_mean'],
                $delta,
                $type,
                $change,
                $remark
            ]);
            $count++;
        }
    }

    echo "✅ frzk_group_transitions_7d befüllt ($count Einträge).\n";
}
?>
