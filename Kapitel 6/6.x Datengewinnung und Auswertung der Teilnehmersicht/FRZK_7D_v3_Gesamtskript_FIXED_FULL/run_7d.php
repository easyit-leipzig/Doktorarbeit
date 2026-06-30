<?php
// ============================================================================
// run_7d.php
// Neues Gesamtskript fuer die FRZK-7D-v3-Neustruktur.
//
// Ablauf:
// 1. Schema erzeugen/aktualisieren
// 2. alle Zieltabellen leeren
// 3. Teilnehmersicht berechnen
// 4. Gruppensicht berechnen
// 5. fehlende Gruppentabellen befüllen
// 6. JSON exportieren
// ============================================================================

header('Content-Type: text/plain; charset=utf-8');
ini_set('display_errors', '1');
error_reporting(E_ALL);
ini_set('memory_limit', '1024M');
set_time_limit(0);

require_once __DIR__ . '/config_7d.php';
require_once __DIR__ . '/modules/00_schema_7d.php';
require_once __DIR__ . '/modules/01_fill_semantische_dichte_teilnehmer_7d.php';
require_once __DIR__ . '/modules/02_fill_interdependenz_7d.php';
require_once __DIR__ . '/modules/03_fill_loops_7d.php';
require_once __DIR__ . '/modules/04_fill_operatoren_7d.php';
require_once __DIR__ . '/modules/05_fill_reflexion_7d.php';
require_once __DIR__ . '/modules/06_fill_transitions_7d.php';
require_once __DIR__ . '/modules/07_fill_group_semantische_dichte_7d.php';
require_once __DIR__ . '/modules/08_fill_group_transitions_7d.php';
require_once __DIR__ . '/modules/09_fill_group_reflexion_7d.php';
require_once __DIR__ . '/modules/10_fill_group_loops_7d.php';
require_once __DIR__ . '/modules/11_fill_group_interdependenz_7d.php';
require_once __DIR__ . '/modules/12_fill_group_operatoren_7d.php';
require_once __DIR__ . '/modules/13_fill_group_emotion_7d.php';
require_once __DIR__ . '/modules/14_fill_group_hubs_7d.php';
require_once __DIR__ . '/modules/15_fill_group_regulation_7d.php';
require_once __DIR__ . '/modules/16_export_7d.php';

$pdo = frzk_pdo();

echo "🚀 Starte FRZK-7D-v3-Gesamtlauf\n";
echo "1/5 Schema erzeugen und Zieltabellen leeren...\n";
frzk7d_schema($pdo);
frzk7d_truncate($pdo);

echo "2/5 Teilnehmersicht berechnen...\n";
frzk7d_fill_semantische_dichte_teilnehmer($pdo, $DIMENSIONS_7D);
frzk7d_fill_interdependenz($pdo, $DIMENSIONS_7D);
frzk7d_fill_loops($pdo);
frzk7d_fill_operatoren($pdo);
frzk7d_fill_reflexion($pdo);
frzk7d_fill_transitions($pdo, $DIMENSIONS_7D);

echo "3/5 Gruppenbasis berechnen...\n";
frzk7d_fill_group_semantische_dichte($pdo, $DIMENSIONS_7D);
frzk7d_fill_group_transitions($pdo);
frzk7d_fill_group_reflexion($pdo);
frzk7d_fill_group_loops($pdo);

echo "4/5 fehlende Gruppentabellen berechnen...\n";
frzk7d_fill_group_interdependenz($pdo, $DIMENSIONS_7D);
frzk7d_fill_group_operatoren($pdo);
frzk7d_fill_group_emotion($pdo);
frzk7d_fill_group_hubs($pdo, $DIMENSIONS_7D);
frzk7d_fill_group_regulation($pdo);

echo "5/5 JSON exportieren...\n";
frzk7d_export_all($pdo);

echo "🏁 Fertig: FRZK-7D-v3 vollständig berechnet. Alle Gruppentabellen verwenden *_7d, insbesondere frzk_group_regulation_7d.\n";
?>
