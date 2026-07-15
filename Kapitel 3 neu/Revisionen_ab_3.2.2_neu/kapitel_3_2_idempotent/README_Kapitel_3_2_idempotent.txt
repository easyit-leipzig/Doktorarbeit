Kapitel 3.2.1–3.2.6 – idempotente Revisionsskripte V4

Wichtig:
1. Vor dem Import eine aktuelle Datenbanksicherung erstellen.
2. Die Dateien numerisch in der Reihenfolge 3.2.1 bis 3.2.6 importieren.
3. Nach einem Fehler die gesamte betreffende Datei erneut von Anfang an ausführen.
4. Nicht erst hinter der fehlerhaften Zeile fortsetzen.
5. Die internen AUTO_INCREMENT-Werte müssen nicht lückenlos sein. Verbindlich sind
   citation_number, equation_number, definition_number und revision_code.

Robustheitsänderungen:
- equations: Upsert über uq_equation_number; equation_id wird mit LAST_INSERT_ID erhalten.
- definitions: Upsert über uq_definition_number.
- equation_symbols: Upsert über uq_equation_symbol (equation_id, symbol_latex).
- source_authors: korrektes Feld role und Upsert.
- Revisionen: vorhandene Revisionen werden aktualisiert statt verdoppelt.
