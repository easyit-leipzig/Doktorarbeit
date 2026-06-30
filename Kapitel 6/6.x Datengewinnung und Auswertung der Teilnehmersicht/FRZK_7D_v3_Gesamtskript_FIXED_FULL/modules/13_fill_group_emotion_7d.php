<?php
// ============================================================================
// 13_fill_group_emotion_7d.php
// Gruppenemotion aus Affekt, Emotionsvalenz/-aktivierung, Kohärenz und Dynamik.
// ============================================================================

function frzk7d_fill_group_emotion(PDO $pdo): void
{
    $rows = $pdo->query("SELECT
            s.gruppe_id,
            s.zeitpunkt,
            s.mean_affektiv,
            s.mean_emotion_valenz,
            s.mean_emotion_aktivierung,
            s.emotion_n,
            s.gruppen_stabilitaet,
            s.gruppen_drift_norm,
            i.kohaerenz_index
        FROM frzk_group_semantische_dichte_7d s
        LEFT JOIN frzk_group_interdependenz_7d i
          ON i.gruppe_id = s.gruppe_id AND i.zeitpunkt = s.zeitpunkt
        ORDER BY s.gruppe_id, s.zeitpunkt")->fetchAll();

    $insert = $pdo->prepare("INSERT INTO frzk_group_emotion_7d
        (gruppe_id, zeitpunkt, mean_affektiv, mean_emotion_valenz, mean_emotion_aktivierung, emotion_n,
         kohaerenz_index, stabilitaet, dynamik, emotionaler_status, emotionaler_modus, bemerkung)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $count = 0;
    foreach ($rows as $row) {
        $aff = (float)$row['mean_affektiv'];
        $val = $row['mean_emotion_valenz'] !== null ? (float)$row['mean_emotion_valenz'] : null;
        $act = $row['mean_emotion_aktivierung'] !== null ? (float)$row['mean_emotion_aktivierung'] : null;
        $coh = (float)($row['kohaerenz_index'] ?? 0.0);
        $stab = (float)$row['gruppen_stabilitaet'];
        $dyn = (float)$row['gruppen_drift_norm'];

        if ($aff > 0.40 && $stab > 0.70) {
            $status = 'emotional integriert';
        } elseif ($aff > 0.20) {
            $status = 'emotional aktiviert';
        } elseif ($aff < -0.20) {
            $status = 'emotional belastet/gedämpft';
        } else {
            $status = 'emotional balanciert';
        }

        if ($coh > 0.65 && $stab > 0.70) {
            $mode = 'Resonanzmodus';
        } elseif ($coh < 0.35 && $dyn > 0.30) {
            $mode = 'Spannungsmodus';
        } elseif ($stab < 0.40) {
            $mode = 'Fragmentierungsmodus';
        } elseif ($dyn < 0.05) {
            $mode = 'Trägheitsmodus';
        } else {
            $mode = 'Adaptiver Modus';
        }

        $remark = sprintf('Affekt=%.4f; Valenz=%s; Aktivierung=%s; Kohärenz=%.4f; Stabilität=%.4f; Dynamik=%.4f',
            $aff,
            $val === null ? 'NULL' : sprintf('%.4f', $val),
            $act === null ? 'NULL' : sprintf('%.4f', $act),
            $coh,
            $stab,
            $dyn
        );

        $insert->execute([(int)$row['gruppe_id'], $row['zeitpunkt'], $aff, $val, $act, (int)$row['emotion_n'], $coh, $stab, $dyn, $status, $mode, $remark]);
        $count++;
    }

    echo "✅ frzk_group_emotion_7d befüllt ($count Einträge).\n";
}
?>
