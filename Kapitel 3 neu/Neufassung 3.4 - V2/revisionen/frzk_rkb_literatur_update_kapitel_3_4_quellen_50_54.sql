/* ============================================================
   FRZK-RKB Literatur-Update Kapitel 3.4

   Ergänzung:
   [50] Khalil
   [51] Prigogine / Stengers
   [52] Kauffman
   [53] Holland
   [54] von Bertalanffy

   Schema:
   sources(citation_number, source_key, title)

   Keine nicht vorhandenen Felder verwenden.
   ============================================================ */

START TRANSACTION;


/* [50] Stabilität nichtlinearer Systeme */

INSERT INTO sources
(
 citation_number,
 source_key,
 title
)
VALUES
(
 50,
 'khalil_nonlinear_systems',
 'Nonlinear Systems'
)
ON DUPLICATE KEY UPDATE
title=VALUES(title);


/* [51] Selbstorganisation und dissipative Strukturen */

INSERT INTO sources
(
 citation_number,
 source_key,
 title
)
VALUES
(
 51,
 'prigogine_stengers_order_out_of_chaos',
 'Order Out of Chaos: Man’s New Dialogue with Nature'
)
ON DUPLICATE KEY UPDATE
title=VALUES(title);


/* [52] Emergenz komplexer Systeme */

INSERT INTO sources
(
 citation_number,
 source_key,
 title
)
VALUES
(
 52,
 'kauffman_origins_of_order',
 'The Origins of Order: Self-Organization and Selection in Evolution'
)
ON DUPLICATE KEY UPDATE
title=VALUES(title);


/* [53] Adaptive Systeme und Emergenz */

INSERT INTO sources
(
 citation_number,
 source_key,
 title
)
VALUES
(
 53,
 'holland_hidden_order',
 'Hidden Order: How Adaptation Builds Complexity'
)
ON DUPLICATE KEY UPDATE
title=VALUES(title);


/* [54] Allgemeine Systemtheorie */

INSERT INTO sources
(
 citation_number,
 source_key,
 title
)
VALUES
(
 54,
 'von_bertalanffy_general_system_theory',
 'General System Theory: Foundations, Development, Applications'
)
ON DUPLICATE KEY UPDATE
title=VALUES(title);


COMMIT;
