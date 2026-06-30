<?php
// ============================================================================
// 14_fill_group_hubs_7d.php
// Gruppen-Hubs als Bedeutungszentren der 7D-Gruppenzustände.
// ============================================================================

function frzk7d_fill_group_hubs(PDO $pdo, array $dimensions): void
{
    $rows = $pdo->query("SELECT
            s.*,
            o.operator_level,
            o.dominanter_operator
        FROM frzk_group_semantische_dichte_7d s
        LEFT JOIN frzk_group_operatoren_7d o
          ON o.gruppe_id = s.gruppe_id AND o.zeitpunkt = s.zeitpunkt
        ORDER BY s.gruppe_id, s.zeitpunkt")->fetchAll();

    $insert = $pdo->prepare("INSERT INTO frzk_group_hubs_7d
        (gruppe_id, zeitpunkt, hub_dimension, hub_wert, hub_score, hub_typ, bedeutungszentrum, stabilitaet, bemerkung)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $count = 0;
    foreach ($rows as $row) {
        $values = [];
        foreach ($dimensions as $dim) {
            $values[$dim] = (float)$row['mean_' . $dim];
        }

        [$dom, $domValue] = dominantDimension($values, $dimensions);
        $stability = (float)$row['gruppen_stabilitaet'];
        $operatorLevel = (float)($row['operator_level'] ?? 0.0);
        $hubScore = frzk7d_clamp01((abs($domValue) / 2.0) * 0.50 + $stability * 0.30 + $operatorLevel * 0.20);
        $type = frzk7d_group_hub_type((string)$dom, $hubScore, $stability);
        $center = frzk7d_group_hub_center((string)$dom);
        $remark = sprintf('Hub %s=%.4f; Score=%.4f; Stabilität=%.4f; Operator=%s', $dom, $domValue, $hubScore, $stability, (string)($row['dominanter_operator'] ?? ''));

        $insert->execute([(int)$row['gruppe_id'], $row['zeitpunkt'], $dom, $domValue, $hubScore, $type, $center, $stability, $remark]);
        $count++;
    }

    echo "✅ frzk_group_hubs_7d befüllt ($count Einträge).\n";
}

function frzk7d_group_hub_type(string $dimension, float $score, float $stability): string
{
    $strength = $score < 0.33 ? 'schwach' : ($score < 0.66 ? 'mittel' : 'stark');
    if ($stability < 0.35) {
        return 'instabiler ' . $dimension . '-Hub (' . $strength . ')';
    }
    if ($stability > 0.75) {
        return 'stabiler ' . $dimension . '-Hub (' . $strength . ')';
    }
    return 'adaptiver ' . $dimension . '-Hub (' . $strength . ')';
}

function frzk7d_group_hub_center(string $dimension): string
{
    return match ($dimension) {
        'kognition' => 'kognitives Bedeutungszentrum',
        'sozial' => 'soziales Resonanzzentrum',
        'affektiv' => 'affektives Aktivierungszentrum',
        'motivation' => 'motivationales Zielzentrum',
        'methodik' => 'methodisches Strukturzentrum',
        'performanz' => 'performanzbezogenes Kompetenzzentrum',
        'regulation' => 'regulatorisches Steuerungszentrum',
        default => 'integratives Bedeutungszentrum',
    };
}
?>
