/* MASTER-REIHENFOLGE KAPITEL 3.2.1–3.2.6
   Die Einzeldateien in dieser Reihenfolge ausführen.
   In der MySQL-Konsole kann SOURCE verwendet werden; phpMyAdmin unterstützt SOURCE meist nicht.

   1. 3_2_1_repository_update_V4_idempotent.sql
   2. 3_2_2_repository_update_V4_idempotent.sql
   3. 3_2_3_repository_update_V4_idempotent.sql
   4. 3_2_4_repository_update_V4_idempotent.sql
   5. 3_2_5_repository_update_V4_idempotent.sql
   6. 3_2_6_repository_update_V4_idempotent.sql

   Die Skripte verwenden:
   - vorgelagerte Parent-Revisionen,
   - ON DUPLICATE KEY UPDATE für global eindeutige Definitionen und Gleichungen,
   - ON DUPLICATE KEY UPDATE für equation_symbols,
   - das tatsächliche Feld `role` in source_authors,
   - abschnittsbezogene Bereinigung von source_usage und section_change_log.
*/
SELECT 'Kapitel 3.2: Einzeldateien in numerischer Reihenfolge importieren.' AS Hinweis;
