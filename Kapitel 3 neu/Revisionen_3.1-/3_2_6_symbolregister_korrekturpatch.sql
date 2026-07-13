USE `frzk_rkb`;
SET NAMES utf8mb4;

START TRANSACTION;

/* ============================================================
   KORREKTURPATCH ZU ABSCHNITT 3.2.6
   Fehlerbehebung für:
   #1062 - Doppelter Eintrag '247-x' für Schlüssel uq_equation_symbol

   Ursache:
   Für mindestens eine Gleichung existierte bereits ein Symbolsatz.
   Der Patch löscht deshalb die Symbolzuordnungen der Gleichungen
   (3.25) bis (3.28) unmittelbar vor dem Neueinfügen vollständig
   und verwendet zusätzlich ON DUPLICATE KEY UPDATE.
   ============================================================ */

/* 1. Gleichungs-IDs eindeutig bestimmen. */
SET @eq_3_25 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.25'
);

SET @eq_3_26 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.26'
);

SET @eq_3_27 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.27'
);

SET @eq_3_28 := (
    SELECT MIN(e.`equation_id`)
    FROM `equations` e
    WHERE e.`equation_number` = '3.28'
);

/* 2. Eventuelle doppelte Gleichungsdatensätze diagnostizieren. */
SELECT
    e.`equation_number`,
    COUNT(*) AS `equation_rows`,
    GROUP_CONCAT(e.`equation_id` ORDER BY e.`equation_id`) AS `equation_ids`
FROM `equations` e
WHERE e.`equation_number` IN ('3.25','3.26','3.27','3.28')
GROUP BY e.`equation_number`
ORDER BY e.`equation_number`;

/* 3. Symbolzuordnungen der vier Gleichungen vollständig entfernen. */
DELETE FROM `equation_symbols`
WHERE `equation_id` IN (
    @eq_3_25,
    @eq_3_26,
    @eq_3_27,
    @eq_3_28
);

/* 4. Symbolregister idempotent neu anlegen. */
INSERT INTO `equation_symbols` (
    `equation_id`,
    `symbol_latex`,
    `symbol_name`,
    `definition_text`,
    `unit_text`,
    `domain_text`,
    `symbol_order`
)
VALUES
(@eq_3_25, 'X', 'Zustandsraum',
 'Menge aller zulässigen Zustände des betrachteten Systems.',
 NULL, 'Menge', 1),

(@eq_3_25, 'x', 'Zustand',
 'Ein zulässiger Zustand des betrachteten Systems.',
 NULL, 'x\\in X', 2),

(@eq_3_26, 'x(t)', 'Zustandsfunktion',
 'Vom Entwicklungsparameter t abhängiger Zustand.',
 NULL, 'x(t)\\in X', 1),

(@eq_3_26, 't', 'Entwicklungsparameter',
 'Parameter zur Ordnung der Zustandsdarstellung.',
 NULL, 'Parameterbereich', 2),

(@eq_3_26, 'X', 'Zustandsraum',
 'Menge aller zulässigen Zustände.',
 NULL, 'Menge', 3),

(@eq_3_27, '\\dot{x}', 'Zustandsänderung',
 'Ableitung des Zustands nach dem Entwicklungsparameter.',
 NULL, 'Tangentialraum bzw. Änderungsraum', 1),

(@eq_3_27, 'F', 'Entwicklungsoperator',
 'Operator oder Vektorfeld, das die kontinuierliche Zustandsänderung bestimmt.',
 NULL, 'F:X\\rightarrow TX', 2),

(@eq_3_27, 'x', 'aktueller Zustand',
 'Aktueller Zustand des Systems.',
 NULL, 'x\\in X', 3),

(@eq_3_28, 'x_k', 'aktueller Zustand',
 'Zustand im diskreten Entwicklungsschritt k.',
 NULL, 'x_k\\in X', 1),

(@eq_3_28, 'x_{k+1}', 'Folgezustand',
 'Zustand im nachfolgenden Entwicklungsschritt.',
 NULL, 'x_{k+1}\\in X', 2),

(@eq_3_28, 'F', 'diskrete Transformationsregel',
 'Abbildung zur Erzeugung des Folgezustands.',
 NULL, 'F:X\\rightarrow X', 3)

ON DUPLICATE KEY UPDATE
    `symbol_name` = VALUES(`symbol_name`),
    `definition_text` = VALUES(`definition_text`),
    `unit_text` = VALUES(`unit_text`),
    `domain_text` = VALUES(`domain_text`),
    `symbol_order` = VALUES(`symbol_order`);

/* 5. Prüfen, ob jede Gleichungsnummer eindeutig ist. */
SELECT
    e.`equation_number`,
    COUNT(*) AS `equation_rows`
FROM `equations` e
WHERE e.`equation_number` IN ('3.25','3.26','3.27','3.28')
GROUP BY e.`equation_number`
HAVING COUNT(*) <> 1;

/* 6. Symbolregister kontrollieren. */
SELECT
    e.`equation_number`,
    es.`symbol_latex`,
    es.`symbol_name`,
    es.`domain_text`,
    es.`symbol_order`
FROM `equation_symbols` es
INNER JOIN `equations` e
    ON e.`equation_id` = es.`equation_id`
WHERE e.`equation_number` IN ('3.25','3.26','3.27','3.28')
ORDER BY
    CAST(SUBSTRING_INDEX(e.`equation_number`, '.', -1) AS UNSIGNED),
    es.`symbol_order`;

COMMIT;
