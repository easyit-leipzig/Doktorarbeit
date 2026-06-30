#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Analyse 6.x Kausalität des FRZK-Vektorraums

Liest die JSON-Datei aus export_6x_kausalitaet_vektorraum.py und erzeugt:
  - Markdown-Bericht
  - CSV-Tabellen
  - PNG-Grafiken

Kernprüfungen:
  1. echte Kopplung vs. permutierte Nullmodelle
  2. zeitversetzte Resonanz L(t) -> T(t+n), n=0..3 Sitzungen
  3. Gegenmodellvergleich: klassische Ratings vs. FRZK-Vektoren
  4. Dominanz- und Polaritätskopplung

Hinweis: Das Skript arbeitet bewusst robust. Wenn keine vollwertigen Teilnehmer-7D-Vektoren
im Export vorhanden sind, wird eine aus klassischen Ratings normalisierte Teilnehmer-Signatur
als Gegenmodell-/Zielraum verwendet. Sobald frzk_semantische_dichte_teilnehmer_7d in den Export
integriert ist, kann die Funktion participant_target_vector direkt darauf umgestellt werden.
"""

from __future__ import annotations

import argparse
import csv
import json
import math
import random
import statistics
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Tuple

import matplotlib.pyplot as plt

DIMENSIONS = ["kognition", "sozial", "affektiv", "motivation", "methodik", "performanz", "regulation"]
RATING_FIELDS = [
    "mitarbeit", "absprachen", "selbststaendigkeit", "konzentration", "fleiss", "lernfortschritt",
    "beherrscht_thema", "transferdenken", "basiswissen", "vorbereitet", "themenauswahl", "materialien",
    "methodenvielfalt", "individualisierung", "aufforderung", "zielgruppen"
]

# Ratings im ICAS-Datensatz sind überwiegend ordinal. Für den Gegenmodellraum wird niedrig = positiv gesetzt.
POSITIVE_RATING_DIRECTION = -1.0


def safe_float(value: Any, default: Optional[float] = None) -> Optional[float]:
    try:
        if value is None or value == "":
            return default
        return float(value)
    except (TypeError, ValueError):
        return default


def vector_norm(v: Iterable[float]) -> float:
    return math.sqrt(sum(float(x) * float(x) for x in v))


def cosine(a: List[float], b: List[float]) -> Optional[float]:
    if not a or not b or len(a) != len(b):
        return None
    na = vector_norm(a)
    nb = vector_norm(b)
    if na == 0 or nb == 0:
        return None
    return sum(x * y for x, y in zip(a, b)) / (na * nb)


def euclidean(a: List[float], b: List[float]) -> Optional[float]:
    if not a or not b or len(a) != len(b):
        return None
    return math.sqrt(sum((x - y) ** 2 for x, y in zip(a, b)))


def mean(values: Iterable[float]) -> Optional[float]:
    vals = [v for v in values if v is not None and not math.isnan(v)]
    return sum(vals) / len(vals) if vals else None


def stdev(values: Iterable[float]) -> Optional[float]:
    vals = [v for v in values if v is not None and not math.isnan(v)]
    return statistics.stdev(vals) if len(vals) >= 2 else None


def percentile(values: List[float], p: float) -> Optional[float]:
    vals = sorted(v for v in values if v is not None and not math.isnan(v))
    if not vals:
        return None
    k = (len(vals) - 1) * p
    f = math.floor(k)
    c = math.ceil(k)
    if f == c:
        return vals[int(k)]
    return vals[f] + (vals[c] - vals[f]) * (k - f)


def pearson(x: List[float], y: List[float]) -> Optional[float]:
    pairs = [(a, b) for a, b in zip(x, y) if a is not None and b is not None]
    if len(pairs) < 3:
        return None
    xs, ys = zip(*pairs)
    mx = sum(xs) / len(xs)
    my = sum(ys) / len(ys)
    sx = math.sqrt(sum((a - mx) ** 2 for a in xs))
    sy = math.sqrt(sum((b - my) ** 2 for b in ys))
    if sx == 0 or sy == 0:
        return None
    return sum((a - mx) * (b - my) for a, b in pairs) / (sx * sy)


def frzk_vector(row: Dict[str, Any]) -> List[float]:
    derived = row.get("_derived", {})
    if isinstance(derived.get("lk_vector"), list):
        return [safe_float(x, 0.0) or 0.0 for x in derived["lk_vector"]]
    return [safe_float(row.get(f"x_{d}"), 0.0) or 0.0 for d in DIMENSIONS]


def frzk_mean_vector(row: Dict[str, Any]) -> List[float]:
    derived = row.get("_derived", {})
    if isinstance(derived.get("lk_mean_vector"), list):
        return [safe_float(x, 0.0) or 0.0 for x in derived["lk_mean_vector"]]
    return [safe_float(row.get(f"mean_{d}"), 0.0) or 0.0 for d in DIMENSIONS]


def participant_target_vector(row: Dict[str, Any]) -> List[float]:
    """Erzeugt eine 7D-Zielsignatur aus Teilnehmer-Ratings, falls kein Teilnehmer-7D-Vektor exportiert wurde."""
    # Nahe Zuordnung der klassischen Ratings zu den sieben FRZK-Dimensionen.
    mapping = {
        "kognition": ["beherrscht_thema", "transferdenken", "basiswissen", "lernfortschritt"],
        "sozial": ["mitarbeit", "absprachen", "zielgruppen"],
        "affektiv": ["emotions"],
        "motivation": ["fleiss", "mitarbeit", "lernfortschritt"],
        "methodik": ["methodenvielfalt", "materialien", "themenauswahl", "individualisierung"],
        "performanz": ["lernfortschritt", "beherrscht_thema", "basiswissen"],
        "regulation": ["selbststaendigkeit", "konzentration", "vorbereitet", "aufforderung"],
    }
    out: List[float] = []
    for dim in DIMENSIONS:
        vals: List[float] = []
        for field in mapping[dim]:
            if field == "emotions":
                # Kein direkter Valenzwert im Export pro Zeile; Anzahl kognitiv/negativer Emotionen wird neutral abgebildet.
                emotion_ids = row.get("_derived", {}).get("emotion_ids", [])
                vals.append(0.0 if not emotion_ids else min(len(emotion_ids), 5) / 5.0)
            else:
                val = safe_float(row.get(field))
                if val is not None:
                    # Skala grob auf [-1, 1], niedrige Werte positiver.
                    vals.append(POSITIVE_RATING_DIRECTION * ((val - 2.5) / 2.5))
        out.append(mean(vals) if vals else 0.0)
    return out


def rating_vector(row: Dict[str, Any]) -> List[float]:
    vals = []
    for field in RATING_FIELDS:
        v = safe_float(row.get(field))
        if v is not None:
            vals.append(POSITIVE_RATING_DIRECTION * ((v - 2.5) / 2.5))
    return vals


def dominant(v: List[float]) -> Optional[str]:
    if not v:
        return None
    return DIMENSIONS[max(range(len(v)), key=lambda i: abs(v[i]))]


def polarity(v: List[float]) -> int:
    s = sum(v)
    return 1 if s > 0 else (-1 if s < 0 else 0)


def sort_rows(rows: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    return sorted(rows, key=lambda r: (str(r.get("teilnehmer_id")), str(r.get("teilnehmer_datum")), str(r.get("sdlg_id"))))


def pairs_for_lag(rows: List[Dict[str, Any]], lag: int) -> List[Tuple[Dict[str, Any], Dict[str, Any]]]:
    by_participant: Dict[str, List[Dict[str, Any]]] = defaultdict(list)
    for r in sort_rows(rows):
        by_participant[str(r.get("teilnehmer_id"))].append(r)
    pairs = []
    for _, seq in by_participant.items():
        # Gleiche Datumseinträge verdichten: erste Zeile pro Datum/Teilnehmer verwenden.
        unique = []
        seen = set()
        for r in seq:
            key = (r.get("teilnehmer_datum"), r.get("id_mtr_rueckkopplung_datenmaske"))
            if key not in seen:
                unique.append(r)
                seen.add(key)
        for i in range(0, len(unique) - lag):
            pairs.append((unique[i], unique[i + lag]))
    return pairs


def lag_metrics(rows: List[Dict[str, Any]], max_lag: int = 3) -> List[Dict[str, Any]]:
    result = []
    for lag in range(max_lag + 1):
        cos_vals, dist_vals, dom_hits, pol_hits = [], [], [], []
        for a, b in pairs_for_lag(rows, lag):
            lv = frzk_vector(a)
            tv = participant_target_vector(b)
            c = cosine(lv, tv)
            d = euclidean(lv, tv)
            if c is not None:
                cos_vals.append(c)
            if d is not None:
                dist_vals.append(d)
            dom_hits.append(1 if dominant(lv) == dominant(tv) else 0)
            pol_hits.append(1 if polarity(lv) == polarity(tv) else 0)
        result.append({
            "lag": lag,
            "n_pairs": len(pairs_for_lag(rows, lag)),
            "cosine_mean": mean(cos_vals),
            "cosine_std": stdev(cos_vals),
            "distance_mean": mean(dist_vals),
            "dominance_accuracy": mean(dom_hits),
            "polarity_accuracy": mean(pol_hits),
        })
    return result


def permutation_test(rows: List[Dict[str, Any]], lag: int, n_perm: int, seed: int = 42) -> Dict[str, Any]:
    rng = random.Random(seed)
    pairs = pairs_for_lag(rows, lag)
    real = [cosine(frzk_vector(a), participant_target_vector(b)) for a, b in pairs]
    real_vals = [x for x in real if x is not None]
    real_mean = mean(real_vals)
    target_vectors = [participant_target_vector(b) for _, b in pairs]
    null_means: List[float] = []
    for _ in range(n_perm):
        shuffled = list(target_vectors)
        rng.shuffle(shuffled)
        vals = [cosine(frzk_vector(a), tv) for (a, _), tv in zip(pairs, shuffled)]
        m = mean([v for v in vals if v is not None])
        if m is not None:
            null_means.append(m)
    if real_mean is None or not null_means:
        p_value = None
        z_score = None
    else:
        extreme = sum(1 for x in null_means if x >= real_mean)
        p_value = (extreme + 1) / (len(null_means) + 1)
        sd = stdev(null_means) or 0.0
        z_score = (real_mean - (mean(null_means) or 0.0)) / sd if sd > 0 else None
    return {
        "lag": lag,
        "n_pairs": len(pairs),
        "n_permutations": len(null_means),
        "real_cosine_mean": real_mean,
        "null_cosine_mean": mean(null_means),
        "null_p95": percentile(null_means, 0.95),
        "null_p99": percentile(null_means, 0.99),
        "z_score": z_score,
        "p_value_right_tail": p_value,
    }


def simple_linear_predict(train_x: List[List[float]], train_y: List[float], test_x: List[List[float]]) -> List[float]:
    # Ridge-ähnliches lineares Modell ohne numpy: nur Baseline bei zu wenigen Daten.
    # Für robuste Nutzung ohne Zusatzpakete wird hier ein korrelationsgewichteter Score verwendet.
    if not train_x or not train_y:
        return [0.0 for _ in test_x]
    y_mean = mean(train_y) or 0.0
    weights = []
    for j in range(len(train_x[0])):
        col = [x[j] for x in train_x]
        r = pearson(col, train_y)
        weights.append(r or 0.0)
    denom = sum(abs(w) for w in weights) or 1.0
    preds = []
    for x in test_x:
        preds.append(y_mean + sum(w * xj for w, xj in zip(weights, x)) / denom)
    return preds


def prediction_comparison(rows: List[Dict[str, Any]], lag: int = 1) -> Dict[str, Any]:
    pairs = pairs_for_lag(rows, lag)
    data = []
    for a, b in pairs:
        target = mean(participant_target_vector(b))
        if target is None:
            continue
        data.append((frzk_vector(a), rating_vector(a), target))
    if len(data) < 12:
        return {"lag": lag, "n": len(data), "error": "Zu wenige Datenpunkte für Vorhersagevergleich."}

    split = max(3, int(len(data) * 0.75))
    train, test = data[:split], data[split:]
    y_train = [t for _, _, t in train]
    y_test = [t for _, _, t in test]

    frzk_pred = simple_linear_predict([x for x, _, _ in train], y_train, [x for x, _, _ in test])
    rating_pred = simple_linear_predict([x for _, x, _ in train], y_train, [x for _, x, _ in test])
    baseline_pred = [mean(y_train) or 0.0 for _ in y_test]

    def metrics(pred: List[float]) -> Dict[str, Optional[float]]:
        errors = [p - y for p, y in zip(pred, y_test)]
        mae = mean([abs(e) for e in errors])
        rmse = math.sqrt(mean([e * e for e in errors]) or 0.0)
        ybar = mean(y_test) or 0.0
        ss_res = sum((p - y) ** 2 for p, y in zip(pred, y_test))
        ss_tot = sum((y - ybar) ** 2 for y in y_test)
        r2 = 1 - ss_res / ss_tot if ss_tot > 0 else None
        return {"MAE": mae, "RMSE": rmse, "R2": r2, "corr_pred_observed": pearson(pred, y_test)}

    return {
        "lag": lag,
        "n": len(data),
        "train_n": len(train),
        "test_n": len(test),
        "target": "mittlere normalisierte Teilnehmerzustandssignatur t+n",
        "FRZK_model": metrics(frzk_pred),
        "ratings_model": metrics(rating_pred),
        "baseline_model": metrics(baseline_pred),
    }


def write_csv(path: Path, rows: List[Dict[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    if not rows:
        return
    fields = list(rows[0].keys())
    with path.open("w", newline="", encoding="utf-8-sig") as f:
        writer = csv.DictWriter(f, fieldnames=fields, delimiter=";")
        writer.writeheader()
        writer.writerows(rows)


def plot_lag_metrics(path: Path, rows: List[Dict[str, Any]]) -> None:
    xs = [r["lag"] for r in rows]
    ys = [r.get("cosine_mean") or 0 for r in rows]
    plt.figure(figsize=(8, 5))
    plt.plot(xs, ys, marker="o")
    plt.xlabel("Zeitversatz n in Sitzungen")
    plt.ylabel("mittlere Kosinusähnlichkeit")
    plt.title("Zeitversetzte Resonanzvalidierung L(t) → T(t+n)")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig(path, dpi=200)
    plt.close()


def plot_permutation(path: Path, rows: List[Dict[str, Any]]) -> None:
    xs = [r["lag"] for r in rows]
    real = [r.get("real_cosine_mean") or 0 for r in rows]
    null = [r.get("null_cosine_mean") or 0 for r in rows]
    plt.figure(figsize=(8, 5))
    plt.plot(xs, real, marker="o", label="echte Zuordnung")
    plt.plot(xs, null, marker="o", label="Permutation / Nullmodell")
    plt.xlabel("Zeitversatz n in Sitzungen")
    plt.ylabel("mittlere Kosinusähnlichkeit")
    plt.title("FRZK-Kopplung gegen Nullmodell")
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig(path, dpi=200)
    plt.close()


def fmt(x: Any, digits: int = 4) -> str:
    if isinstance(x, (int, str)):
        return str(x)
    if x is None:
        return "n/a"
    try:
        return f"{float(x):.{digits}f}"
    except Exception:
        return str(x)


def markdown_table(rows: List[Dict[str, Any]], keys: List[str]) -> str:
    out = ["| " + " | ".join(keys) + " |", "| " + " | ".join(["---"] * len(keys)) + " |"]
    for r in rows:
        out.append("| " + " | ".join(fmt(r.get(k)) for k in keys) + " |")
    return "\n".join(out)


def analyze_scope(scope_name: str, rows: List[Dict[str, Any]], outdir: Path, n_perm: int) -> Dict[str, Any]:
    scope_dir = outdir / scope_name
    scope_dir.mkdir(parents=True, exist_ok=True)
    lags = lag_metrics(rows, max_lag=3)
    perms = [permutation_test(rows, lag=i, n_perm=n_perm) for i in range(4)]
    pred = [prediction_comparison(rows, lag=i) for i in range(1, 4)]

    write_csv(scope_dir / "tabelle_zeitversetzte_resonanz.csv", lags)
    write_csv(scope_dir / "tabelle_permutation_nullmodell.csv", perms)
    write_csv(scope_dir / "tabelle_vorhersagevergleich.csv", [flatten_prediction(p) for p in pred])
    plot_lag_metrics(scope_dir / "abb_01_zeitversetzte_resonanz.png", lags)
    plot_permutation(scope_dir / "abb_02_permutation_nullmodell.png", perms)

    report = []
    report.append(f"# 6.x Kausalität des FRZK-Vektorraums – Scope {scope_name}\n")
    report.append(f"Datensätze: {len(rows)}\n")
    report.append("## 1. Zeitversetzte Resonanzvalidierung\n")
    report.append(markdown_table(lags, ["lag", "n_pairs", "cosine_mean", "distance_mean", "dominance_accuracy", "polarity_accuracy"]))
    report.append("\n\n## 2. Permutations-/Nullmodellanalyse\n")
    report.append(markdown_table(perms, ["lag", "n_pairs", "real_cosine_mean", "null_cosine_mean", "null_p95", "z_score", "p_value_right_tail"]))
    report.append("\n\n## 3. Vorhersagevergleich FRZK vs. klassische Ratings\n")
    report.append(markdown_table([flatten_prediction(p) for p in pred], ["lag", "n", "FRZK_RMSE", "FRZK_R2", "ratings_RMSE", "ratings_R2", "baseline_RMSE"]))
    report.append("\n\n## 4. Interpretationsregel\n")
    report.append(
        "Eine starke Stützung der Artefaktgegenhypothese liegt nicht vor, wenn die echte Zuordnung "
        "systematisch über dem permutierten Nullmodell liegt, wenn zeitversetzte Kopplungen erhalten bleiben "
        "und wenn das FRZK-Modell im Vorhersagevergleich niedrigere Fehler bzw. höhere R²-Werte erreicht "
        "als klassische Ratings oder Baseline. Umgekehrt muss bei kollabierenden Unterschieden vorsichtig "
        "von einer nur internen oder überangepassten Struktur gesprochen werden.\n"
    )
    report_path = scope_dir / "bericht_6x_kausalitaet_vektorraum.md"
    report_path.write_text("\n".join(report), encoding="utf-8")

    return {"scope": scope_name, "lag_metrics": lags, "permutation": perms, "prediction": pred, "report": str(report_path)}


def flatten_prediction(p: Dict[str, Any]) -> Dict[str, Any]:
    out = {"lag": p.get("lag"), "n": p.get("n")}
    for prefix, key in [("FRZK", "FRZK_model"), ("ratings", "ratings_model"), ("baseline", "baseline_model")]:
        m = p.get(key, {}) if isinstance(p.get(key), dict) else {}
        out[f"{prefix}_MAE"] = m.get("MAE")
        out[f"{prefix}_RMSE"] = m.get("RMSE")
        out[f"{prefix}_R2"] = m.get("R2")
        out[f"{prefix}_corr"] = m.get("corr_pred_observed")
    if "error" in p:
        out["error"] = p["error"]
    return out


def main() -> None:
    parser = argparse.ArgumentParser(description="Analysiert JSON-Daten zur Kausalität des FRZK-Vektorraums.")
    parser.add_argument("--input", default="6x_kausalitaet_vektorraum_export.json", help="Export-JSON")
    parser.add_argument("--outdir", default="6x_kausalitaet_vektorraum_output", help="Ausgabeverzeichnis")
    parser.add_argument("--permutations", type=int, default=1000, help="Anzahl Permutationen pro Scope/Lag")
    args = parser.parse_args()

    input_path = Path(args.input)
    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    data = json.loads(input_path.read_text(encoding="utf-8"))
    scopes = data.get("scopes", {})
    summary = {"input": str(input_path), "scopes": {}}
    for scope_name, scope_data in scopes.items():
        rows = scope_data.get("rows", [])
        summary["scopes"][scope_name] = analyze_scope(scope_name, rows, outdir, args.permutations)

    (outdir / "summary_6x_kausalitaet_vektorraum.json").write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Analyse abgeschlossen: {outdir.resolve()}")


if __name__ == "__main__":
    main()
