# 6.x Kausalität des FRZK-Vektorraums – Scope lehrkraft_1

Datensätze: 282

## 1. Zeitversetzte Resonanzvalidierung

| lag | n_pairs | cosine_mean | distance_mean | dominance_accuracy | polarity_accuracy |
| --- | --- | --- | --- | --- | --- |
| 0 | 272 | 0.6498 | 0.8262 | 0.0404 | 0.9485 |
| 1 | 245 | 0.6631 | 0.8196 | 0.0367 | 0.9510 |
| 2 | 219 | 0.6683 | 0.8133 | 0.0502 | 0.9543 |
| 3 | 195 | 0.6633 | 0.8197 | 0.0564 | 0.9538 |


## 2. Permutations-/Nullmodellanalyse

| lag | n_pairs | real_cosine_mean | null_cosine_mean | null_p95 | z_score | p_value_right_tail |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | 272 | 0.6498 | 0.6525 | 0.6564 | -1.2690 | 0.9271 |
| 1 | 245 | 0.6631 | 0.6644 | 0.6683 | -0.5604 | 0.7003 |
| 2 | 219 | 0.6683 | 0.6700 | 0.6750 | -0.6623 | 0.7433 |
| 3 | 195 | 0.6633 | 0.6641 | 0.6699 | -0.2666 | 0.5465 |


## 3. Vorhersagevergleich FRZK vs. klassische Ratings

| lag | n | FRZK_RMSE | FRZK_R2 | ratings_RMSE | ratings_R2 | baseline_RMSE |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 245 | 0.2110 | -0.2654 | 0.3254 | -2.0109 | 0.1903 |
| 2 | 219 | 0.2309 | -0.5477 | 0.3270 | -2.1038 | 0.1881 |
| 3 | 195 | 0.2140 | -0.2633 | 0.3255 | -1.9228 | 0.1924 |


## 4. Interpretationsregel

Eine starke Stützung der Artefaktgegenhypothese liegt nicht vor, wenn die echte Zuordnung systematisch über dem permutierten Nullmodell liegt, wenn zeitversetzte Kopplungen erhalten bleiben und wenn das FRZK-Modell im Vorhersagevergleich niedrigere Fehler bzw. höhere R²-Werte erreicht als klassische Ratings oder Baseline. Umgekehrt muss bei kollabierenden Unterschieden vorsichtig von einer nur internen oder überangepassten Struktur gesprochen werden.
