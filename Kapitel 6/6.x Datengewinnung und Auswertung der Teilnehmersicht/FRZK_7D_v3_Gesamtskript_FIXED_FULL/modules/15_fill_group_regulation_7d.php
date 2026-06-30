<?php
// ============================================================================
// 15_fill_group_regulation_7d.php
// Neues Regulationsmodul. Ersetzt das alte frzk_group_regulation-Skript und
// schreibt ausschließlich in frzk_group_regulation_7d.
// ============================================================================

function frzk7d_fill_group_regulation(PDO $pdo): void
{
    $groupRows = $pdo->query("SELECT
            gruppe_id,
            zeitpunkt,
            gruppen_drift_norm,
            gruppen_stabilitaet,
            d_semantisch_mean,
            gruppen_transition_marker
        FROM frzk_group_semantische_dichte_7d
        WHERE gruppe_id IS NOT NULL
        ORDER BY gruppe_id, zeitpunkt")->fetchAll();

    $loopRows = $pdo->query("SELECT
            gruppe_id,
            COUNT(*) AS loop_count,
            AVG(stabilitaet) AS loop_stabilitaet_mean,
            AVG(COALESCE(verdichtung, verdichtungsgrad, 0)) AS loop_verdichtung_mean
        FROM frzk_group_loops_7d
        GROUP BY gruppe_id")->fetchAll(PDO::FETCH_UNIQUE | PDO::FETCH_ASSOC);

    $transitionRows = $pdo->query("SELECT
            gruppe_id,
            COUNT(*) AS transition_count,
            SUM(CASE WHEN dominanzwechsel = 1 THEN 1 ELSE 0 END) AS dominanzwechsel_count
        FROM frzk_group_transitions_7d
        GROUP BY gruppe_id")->fetchAll(PDO::FETCH_UNIQUE | PDO::FETCH_ASSOC);

    $groups = [];
    foreach ($groupRows as $row) {
        $groups[(int)$row['gruppe_id']][] = $row;
    }

    $insert = $pdo->prepare("INSERT INTO frzk_group_regulation_7d
        (gruppe_id, mean_drift_norm, var_drift_norm, mean_d_semantisch, var_d_semantisch,
         loop_density, loop_stabilitaet_mean, gruppen_stabilitaet_mean, transition_rate,
         regulation_score, regulation_typ, bemerkung)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $count = 0;
    foreach ($groups as $gid => $rows) {
        $n = count($rows);
        if ($n === 0) {
            continue;
        }

        $driftValues = array_map(fn($r) => (float)$r['gruppen_drift_norm'], $rows);
        $densityValues = array_map(fn($r) => (float)$r['d_semantisch_mean'], $rows);
        $stabilityValues = array_map(fn($r) => (float)$r['gruppen_stabilitaet'], $rows);

        $meanDrift = frzk7d_mean($driftValues);
        $varDrift = varianceN($driftValues);
        $meanDensity = frzk7d_mean($densityValues);
        $varDensity = varianceN($densityValues);
        $meanStability = frzk7d_mean($stabilityValues);

        $loopCount = (int)($loopRows[$gid]['loop_count'] ?? 0);
        $loopDensity = $loopCount / max(1, $n);
        $loopStabilityMean = isset($loopRows[$gid]['loop_stabilitaet_mean']) ? (float)$loopRows[$gid]['loop_stabilitaet_mean'] : null;

        $transitionCount = (int)($transitionRows[$gid]['transition_count'] ?? 0);
        $transitionRate = $transitionCount / max(1, max(1, $n - 1));

        $score =
            0.30 * frzk7d_clamp01($meanDrift)
            + 0.20 * frzk7d_clamp01($varDrift)
            + 0.20 * frzk7d_clamp01($transitionRate)
            + 0.15 * frzk7d_clamp01($loopDensity)
            + 0.15 * (1.0 - frzk7d_clamp01($meanStability));
        $score = frzk7d_clamp01($score);

        if ($score < 0.30) {
            $type = 'selbstregulierend';
        } elseif ($score < 0.60) {
            $type = 'strukturell geführt';
        } else {
            $type = 'regulationsabhängig';
        }

        $remark = sprintf(
            'Drift=%.4f; Var(Drift)=%.4f; Dichte=%.4f; Var(Dichte)=%.4f; Loopdichte=%.4f; Loop-Stabilität=%s; Stabilität=%.4f; Transitionen=%.4f',
            $meanDrift,
            $varDrift,
            $meanDensity,
            $varDensity,
            $loopDensity,
            $loopStabilityMean === null ? 'NULL' : sprintf('%.4f', $loopStabilityMean),
            $meanStability,
            $transitionRate
        );

        $insert->execute([
            $gid,
            $meanDrift,
            $varDrift,
            $meanDensity,
            $varDensity,
            $loopDensity,
            $loopStabilityMean,
            $meanStability,
            $transitionRate,
            $score,
            $type,
            $remark
        ]);
        $count++;
    }

    echo "✅ frzk_group_regulation_7d befüllt ($count Gruppen).\n";
}

function frzk7d_mean(array $values): float
{
    return count($values) ? array_sum($values) / count($values) : 0.0;
}

function frzk7d_clamp01(float $value): float
{
    if (is_nan($value) || is_infinite($value)) {
        return 0.0;
    }
    return max(0.0, min(1.0, $value));
}
?>
