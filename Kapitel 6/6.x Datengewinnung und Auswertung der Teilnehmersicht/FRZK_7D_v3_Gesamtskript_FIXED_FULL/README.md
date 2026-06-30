# FRZK 7D v3 Gesamtskript - bereinigte Neufassung

Startdatei: `run_7d.php`

Dieses Paket ersetzt den fehlerhaften Zwischenstand. Alle Gruppentabellen verwenden konsequent den Suffix `_7d`.

Wichtige Korrekturen:

- `frzk_group_regulation_7d` statt `frzk_group_regulation`
- `frzk_group_reflexion_7d` enthält `selbstbezug_index`
- `frzk_group_loops_7d` enthält `verdichtung` und `verdichtungsgrad`
- `CREATE TABLE IF NOT EXISTS` wird durch `frzk7d_add_missing_columns()` ergänzt, damit bestehende fehlerhafte Tabellen automatisch nachmigriert werden
- alle PHP-Dateien wurden mit `php -l` syntaktisch geprüft

Ablauf:

```bash
php run_7d.php
```

Datenbankkonfiguration steht in `config_7d.php`.
