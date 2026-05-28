<?php
// analyse_01_perspektivische_zustandskohaerenz_sdlg_gd.php

declare(strict_types=1);

$input = __DIR__ . "/auswertung_01_perspektivische_zustandskohaerenz_sdlg_export.json";
$outDir = __DIR__ . "/auswertung_01_perspektivische_zustandskohaerenz_sdlg_analyse_php_gd";

$dimensions = ["kognition","sozial","affektiv","motivation","methodik","performanz","regulation"];

if (!extension_loaded("gd")) {
    die("PHP-GD ist nicht geladen.\n");
}

if (!file_exists($input)) {
    die("JSON nicht gefunden: {$input}\n");
}

if (!is_dir($outDir)) {
    mkdir($outDir, 0777, true);
}

function mean_arr(array $a): ?float {
    if (!$a) return null;
    return array_sum($a) / count($a);
}

function median_arr(array $a): ?float {
    if (!$a) return null;
    sort($a);
    $n=count($a); $m=intdiv($n,2);
    return $n%2 ? $a[$m] : ($a[$m-1]+$a[$m])/2;
}

function cls(float $d): string {
    if ($d <= 0.75) return "hoch_kohärent";
    if ($d <= 1.50) return "teilkohärent";
    if ($d <= 2.50) return "divergent";
    return "stark_divergent";
}

function flatten(string $dataset, array $m, array $dims): array {
    $r = [
        "dataset" => $dataset,
        "delta_days" => $m["delta_days"],
        "matching_type" => $m["matching_type"],
        "distance_euclidean" => $m["distance_euclidean"],
        "cosine_similarity" => $m["cosine_similarity"],
        "dominance_match" => $m["dominance_match"] ? 1 : 0,
        "polarity_match" => $m["polarity_match"] ? 1 : 0,
        "lehrkraft_id" => $m["lehrkraft"]["lehrkraft_id"],
        "gruppe_id" => $m["lehrkraft"]["gruppe_id"],
        "lehrkraft_datum" => $m["lehrkraft"]["datum"],
        "teilnehmer_datum" => $m["teilnehmer"]["datum"],
        "lk_dom" => $m["lehrkraft"]["dominante_dimension"],
        "tn_dom" => $m["teilnehmer"]["dominante_dimension"],
        "lk_pol" => $m["lehrkraft"]["polaritaet_gesamt"],
        "tn_pol" => $m["teilnehmer"]["polaritaet_gesamt"],
        "satzanzahl" => $m["lehrkraft"]["analyze"]["satzanzahl"],
        "semantische_breite" => $m["lehrkraft"]["analyze"]["semantische_breite"],
        "d_semantisch_mean" => $m["lehrkraft"]["analyze"]["d_semantisch_mean"],
        "polaritaet_index" => $m["lehrkraft"]["analyze"]["polaritaet_index"]
    ];

    foreach ($dims as $d) {
        $lk = $m["lehrkraft"]["vector"][$d];
        $tn = $m["teilnehmer"]["vector"][$d];
        $r["lk_".$d] = $lk;
        $r["tn_".$d] = $tn;
        $r["diff_".$d] = $lk - $tn;
    }

    return $r;
}

function summarize(array $rows): array {
    $dist=[]; $cos=[]; $classes=[]; $delta=[]; $pairs=[];

    foreach ($rows as $r) {
        $d = (float)$r["distance_euclidean"];
        $dist[] = $d;
        if ($r["cosine_similarity"] !== null) $cos[] = (float)$r["cosine_similarity"];

        $c = cls($d);
        $classes[$c] = ($classes[$c] ?? 0) + 1;

        $dk = (string)$r["delta_days"];
        $delta[$dk][] = $d;

        $p = ($r["lk_dom"] ?? "NULL") . " → " . ($r["tn_dom"] ?? "NULL");
        $pairs[$p] = ($pairs[$p] ?? 0) + 1;
    }

    ksort($delta, SORT_NUMERIC);
    arsort($pairs);

    $deltaSummary = [];
    foreach ($delta as $k => $v) {
        $deltaSummary[$k] = [
            "n" => count($v),
            "mean" => mean_arr($v),
            "median" => median_arr($v)
        ];
    }

    $n = count($rows);

    return [
        "n" => $n,
        "distance_mean" => mean_arr($dist),
        "distance_median" => median_arr($dist),
        "distance_min" => $dist ? min($dist) : null,
        "distance_max" => $dist ? max($dist) : null,
        "cosine_mean" => mean_arr($cos),
        "cosine_median" => median_arr($cos),
        "dominance_match_rate" => $n ? array_sum(array_column($rows, "dominance_match")) / $n : null,
        "polarity_match_rate" => $n ? array_sum(array_column($rows, "polarity_match")) / $n : null,
        "distance_classes" => $classes,
        "distance_by_delta" => $deltaSummary,
        "dominance_pairs_top15" => array_slice($pairs, 0, 15, true)
    ];
}

function write_csv(string $path, array $rows): void {
    if (!$rows) return;
    $fp = fopen($path, "w");
    fputcsv($fp, array_keys($rows[0]), ";");
    foreach ($rows as $r) fputcsv($fp, $r, ";");
    fclose($fp);
}

function img_base(int $w=1100, int $h=650): array {
    $im = imagecreatetruecolor($w,$h);
    $white=imagecolorallocate($im,255,255,255);
    $black=imagecolorallocate($im,20,20,20);
    $gray=imagecolorallocate($im,220,220,220);
    $blue=imagecolorallocate($im,70,120,190);
    imagefilledrectangle($im,0,0,$w,$h,$white);
    return [$im,$w,$h,$black,$gray,$blue];
}

function save_img($im, string $path): void {
    imagepng($im,$path);
    imagedestroy($im);
}

function plot_hist(string $path, string $title, array $values): void {
    if (!$values) return;
    [$im,$w,$h,$black,$gray,$blue] = img_base();

    imagestring($im,5,40,25,$title,$black);
    $left=80; $top=80; $right=$w-50; $bottom=$h-80;

    imageline($im,$left,$bottom,$right,$bottom,$black);
    imageline($im,$left,$top,$left,$bottom,$black);

    $bins=25;
    $min=min($values); $max=max($values);
    if ($max==$min) $max=$min+1;

    $counts=array_fill(0,$bins,0);
    foreach ($values as $v) {
        $i=(int)floor(($v-$min)/($max-$min)*$bins);
        if ($i<0) $i=0;
        if ($i>=$bins) $i=$bins-1;
        $counts[$i]++;
    }

    $maxC=max($counts) ?: 1;
    $barW=($right-$left)/$bins;

    for ($i=0;$i<$bins;$i++) {
        $bh=(int)($counts[$i]/$maxC*($bottom-$top));
        $x1=(int)($left+$i*$barW+2);
        $x2=(int)($left+($i+1)*$barW-2);
        imagefilledrectangle($im,$x1,$bottom-$bh,$x2,$bottom,$blue);
    }

    imagestring($im,3,$left,$bottom+25,"D_LT min=".round($min,3)." max=".round($max,3),$black);
    save_img($im,$path);
}

function plot_bar(string $path, string $title, array $labels, array $values): void {
    if (!$values) return;
    [$im,$w,$h,$black,$gray,$blue] = img_base();

    imagestring($im,5,40,25,$title,$black);
    $left=80; $top=80; $right=$w-50; $bottom=$h-130;

    imageline($im,$left,$bottom,$right,$bottom,$black);
    imageline($im,$left,$top,$left,$bottom,$black);

    $max=max($values) ?: 1;
    $n=count($values);
    $bw=($right-$left)/$n;

    for ($i=0;$i<$n;$i++) {
        $bh=(int)($values[$i]/$max*($bottom-$top));
        $x1=(int)($left+$i*$bw+10);
        $x2=(int)($left+($i+1)*$bw-10);
        imagefilledrectangle($im,$x1,$bottom-$bh,$x2,$bottom,$blue);
        imagestringup($im,3,$x1+15,$bottom+95,substr($labels[$i],0,12),$black);
        imagestring($im,2,$x1,$bottom-$bh-15,round($values[$i],3),$black);
    }

    save_img($im,$path);
}

$data = json_decode(file_get_contents($input), true);

$report = [];
$report[] = "# Auswertung 01 – Perspektivische Zustandskohärenz auf Basis SDL_GESAMT";
$report[] = "";
$report[] = "Lehrkraftbasis: `frzk_semantische_dichte_lehrer_gesamt` unter Berücksichtigung von `analyze_lehrkraftdaten`.";
$report[] = "";

$allRows=[];

foreach ($data["datasets"] as $name => $dataset) {
    $rows=[];
    foreach ($dataset["matches"] as $m) {
        $rows[] = flatten($name, $m, $dimensions);
    }
    $allRows = array_merge($allRows,$rows);

    $s = summarize($rows);

    file_put_contents(
        "{$outDir}/{$name}_summary.json",
        json_encode($s, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)
    );

    write_csv("{$outDir}/{$name}_matches.csv", $rows);

    $dist = array_map(fn($r)=>(float)$r["distance_euclidean"], $rows);
    plot_hist("{$outDir}/{$name}_distanz_histogramm.png", "D_LT-Verteilung {$name}", $dist);

    $dimVals=[];
    foreach ($dimensions as $d) {
        $vals=[];
        foreach ($rows as $r) $vals[] = abs((float)$r["diff_".$d]);
        $dimVals[] = mean_arr($vals) ?? 0;
    }
    plot_bar("{$outDir}/{$name}_dimensionsdifferenzen.png", "Dimensionsdifferenzen {$name}", $dimensions, $dimVals);

    $report[] = "## {$name}";
    $report[] = "";
    $report[] = "- Matches: ".$s["n"];
    $report[] = "- D_LT Mittelwert: ".$s["distance_mean"];
    $report[] = "- D_LT Median: ".$s["distance_median"];
    $report[] = "- Cosine Mittelwert: ".$s["cosine_mean"];
    $report[] = "- Dominanz-Matchrate: ".$s["dominance_match_rate"];
    $report[] = "- Polaritäts-Matchrate: ".$s["polarity_match_rate"];
    $report[] = "";
    $report[] = "### Distanzklassen";
    foreach ($s["distance_classes"] as $k=>$v) $report[] = "- {$k}: {$v}";
    $report[] = "";
    $report[] = "### Zeitfenster";
    foreach ($s["distance_by_delta"] as $k=>$v) {
        $report[] = "- Δ={$k}: n={$v["n"]}, mean={$v["mean"]}, median={$v["median"]}";
    }
    $report[] = "";
    $report[] = "### Dominanzkopplungen";
    foreach ($s["dominance_pairs_top15"] as $k=>$v) $report[] = "- {$k}: {$v}";
    $report[] = "";

    echo "Ausgewertet: {$name}\n";
}

write_csv("{$outDir}/alle_matches_langformat.csv", $allRows);
file_put_contents("{$outDir}/auswertung_01_report.md", implode("\n",$report));

echo "Analyse abgeschlossen: {$outDir}\n";