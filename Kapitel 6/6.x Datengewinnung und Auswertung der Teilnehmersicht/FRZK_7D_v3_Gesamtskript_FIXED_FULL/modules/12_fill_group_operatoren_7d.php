<?php
// ============================================================================
// 12_fill_group_operatoren_7d.php
// Gruppenoperatoren sigma, M, R, E aus kognitiver Struktur, Meta-Kohärenz,
// sozialer Resonanz und emergenter Drift.
// ============================================================================

function frzk7d_fill_group_operatoren(PDO $pdo): void
{
    $rows = $pdo->query("SELECT
            s.*,
            i.kohaerenz_index,
            i.varianz_7d
        FROM frzk_group_semantische_dichte_7d s
        LEFT JOIN frzk_group_interdependenz_7d i
          ON i.gruppe_id = s.gruppe_id AND i.zeitpunkt = s.zeitpunkt
        ORDER BY s.gruppe_id, s.zeitpunkt")->fetchAll();

    $insert = $pdo->prepare("INSERT INTO frzk_group_operatoren_7d
        (gruppe_id, zeitpunkt, sigma, M, R, E, operator_level, dominanter_operator, operator_status, bemerkung)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $count = 0;
    foreach ($rows as $row) {
        $sigma = frzk7d_clamp01(abs((float)$row['mean_kognition']) / 2.0 + abs((float)$row['mean_methodik']) / 4.0);
        $meta = frzk7d_clamp01((float)($row['kohaerenz_index'] ?? 0.0) + (float)$row['gruppen_stabilitaet'] * 0.25);
        $resonance = frzk7d_clamp01(abs((float)$row['mean_sozial']) / 2.0 + (float)$row['gruppen_stabilitaet'] * 0.35);
        $emergence = frzk7d_clamp01((float)$row['gruppen_drift_norm'] + abs((float)$row['mean_affektiv']) / 4.0 + (float)($row['varianz_7d'] ?? 0.0));
        $level = ($sigma + $meta + $resonance + $emergence) / 4.0;

        $ops = ['σ' => $sigma, 'M' => $meta, 'R' => $resonance, 'E' => $emergence];
        arsort($ops);
        $dominant = array_key_first($ops);
        $status = frzk7d_operator_status($dominant, $level);
        $remark = sprintf('σ=%.4f; M=%.4f; R=%.4f; E=%.4f; Level=%.4f; dominant=%s', $sigma, $meta, $resonance, $emergence, $level, $dominant);

        $insert->execute([(int)$row['gruppe_id'], $row['zeitpunkt'], $sigma, $meta, $resonance, $emergence, $level, $dominant, $status, $remark]);
        $count++;
    }

    echo "✅ frzk_group_operatoren_7d befüllt ($count Einträge).\n";
}

function frzk7d_operator_status(string $dominant, float $level): string
{
    $strength = $level < 0.33 ? 'niedrig' : ($level < 0.66 ? 'mittel' : 'hoch');
    return match ($dominant) {
        'σ' => 'semantisch-fokussiert (' . $strength . ')',
        'M' => 'meta-kohaerent (' . $strength . ')',
        'R' => 'resonant (' . $strength . ')',
        'E' => 'emergent/perturbativ (' . $strength . ')',
        default => 'unbestimmt (' . $strength . ')',
    };
}
?>
