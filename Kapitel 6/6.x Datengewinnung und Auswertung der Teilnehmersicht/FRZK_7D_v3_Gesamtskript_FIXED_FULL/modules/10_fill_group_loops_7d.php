<?php
// ============================================================================
// 10_fill_group_loops_7d.php
// Rückkopplungsschleifen der Gruppe aus Drift, Dominanzrückkehr und Plateau.
// ============================================================================

function frzk7d_fill_group_loops(PDO $pdo): void
{
    $rows = $pdo->query("SELECT * FROM frzk_group_semantische_dichte_7d ORDER BY gruppe_id, zeitpunkt")->fetchAll();
    $groups = [];
    foreach ($rows as $row) {
        $groups[(int)$row['gruppe_id']][] = $row;
    }

    $insert = $pdo->prepare("INSERT INTO frzk_group_loops_7d
        (gruppe_id, start_zeit, end_zeit, schleifen_typ, dauer, drift_avg, verdichtung, verdichtungsgrad, stabilitaet, pausenmarker, bemerkung)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $count = 0;
    foreach ($groups as $gid => $entries) {
        $n = count($entries);
        if ($n < 2) {
            continue;
        }

        $drifts = array_map(fn($r) => (float)$r['gruppen_drift_norm'], $entries);
        $stabilities = array_map(fn($r) => (float)$r['gruppen_stabilitaet'], $entries);
        $avgDrift = array_sum($drifts) / max(1, count($drifts));
        $avgStability = array_sum($stabilities) / max(1, count($stabilities));
        $density = array_sum(array_map(fn($r) => (float)$r['d_semantisch_mean'], $entries)) / max(1, $n);

        $type = $avgDrift < 0.10 ? 'Plateau' : ($avgDrift < 0.30 ? 'Rückkopplung' : 'Oszillation');
        $pause = $avgDrift < 0.05 ? 'pausenartig' : 'aktiv';
        $remark = sprintf('Gruppenloop: Typ=%s; Dauer=%d; Drift_avg=%.4f; Dichte=%.4f; Stabilität=%.4f', $type, $n, $avgDrift, $density, $avgStability);

        $insert->execute([
            $gid,
            $entries[0]['zeitpunkt'],
            end($entries)['zeitpunkt'],
            $type,
            $n,
            $avgDrift,
            $density,
            $density,
            $avgStability,
            $pause,
            $remark
        ]);
        $count++;

        if ($n >= 3) {
            for ($i = 2; $i < $n; $i++) {
                $a = $entries[$i - 2];
                $b = $entries[$i - 1];
                $c = $entries[$i];
                $returnDominance = ((string)$a['dominante_dimension'] === (string)$c['dominante_dimension']);
                $d1 = (float)$b['d_semantisch_mean'] - (float)$a['d_semantisch_mean'];
                $d2 = (float)$c['d_semantisch_mean'] - (float)$b['d_semantisch_mean'];
                $signChange = ($d1 * $d2) < 0;

                if (!$returnDominance && !$signChange) {
                    continue;
                }

                $localDrift = (((float)$a['gruppen_drift_norm']) + ((float)$b['gruppen_drift_norm']) + ((float)$c['gruppen_drift_norm'])) / 3.0;
                $localStability = (((float)$a['gruppen_stabilitaet']) + ((float)$b['gruppen_stabilitaet']) + ((float)$c['gruppen_stabilitaet'])) / 3.0;
                $localType = $returnDominance ? 'Dominanzrückkehr' : 'Pendelbewegung';
                $remark = sprintf('%s über drei Zeitpunkte; ΔD1=%.4f; ΔD2=%.4f; Drift=%.4f', $localType, $d1, $d2, $localDrift);

                $insert->execute([$gid, $a['zeitpunkt'], $c['zeitpunkt'], $localType, 3, $localDrift, null, null, $localStability, null, $remark]);
                $count++;
            }
        }
    }

    echo "✅ frzk_group_loops_7d befüllt ($count Einträge).\n";
}
?>
