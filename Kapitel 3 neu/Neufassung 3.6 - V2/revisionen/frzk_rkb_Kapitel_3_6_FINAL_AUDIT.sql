/* ============================================================
   FRZK Repository
   Kapitel 3.6 FINAL AUDIT

   Zweck:
   Vollständige Prüfung Kapitel 3.6.0 - 3.6.5

   Prüft:
   - Abschnittsstruktur
   - Revision
   - Gleichungen
   - Quellenverknüpfungen
   - Dubletten
   - Konsistenz Übergang 3.5 -> 3.6

   Keine Änderungen an Daten!
   ============================================================ */


USE frzk_rkb;


/* ============================================================
   1. Revision prüfen
   ============================================================ */

SELECT
    revision_id,
    revision_code,
    revision_date,
    scope_type,
    scope_reference,
    version_label,
    parent_revision_id
FROM repository_revisions
WHERE scope_reference='3.6'
ORDER BY revision_id DESC;



/* ============================================================
   2. Kapitelstruktur prüfen
   ============================================================ */

SELECT
    section_id,
    parent_section_id,
    section_code,
    title,
    chapter_no,
    section_order,
    status,
    is_original_contribution
FROM dissertation_sections
WHERE section_code LIKE '3.6%'
ORDER BY section_order;



/* ============================================================
   3. Fehlende Abschnitte erkennen
   ============================================================ */

SELECT required.section_code

FROM
(
 SELECT '3.6' section_code
 UNION ALL SELECT '3.6.0'
 UNION ALL SELECT '3.6.1'
 UNION ALL SELECT '3.6.2'
 UNION ALL SELECT '3.6.3'
 UNION ALL SELECT '3.6.4'
 UNION ALL SELECT '3.6.5'
) required

LEFT JOIN dissertation_sections ds
ON ds.section_code=required.section_code

WHERE ds.section_id IS NULL;



/* ============================================================
   4. Gleichungen Kapitel 3.6
   ============================================================ */

SELECT
    equation_number,
    section_id,
    title,
    equation_type,
    validation_status
FROM equations
WHERE equation_number BETWEEN '3.1213'
AND '3.1235'
ORDER BY equation_number;



/* ============================================================
   5. Fehlende Gleichungen
   ============================================================ */

SELECT required.equation_number

FROM
(
 SELECT '3.1213' equation_number
 UNION ALL SELECT '3.1214'
 UNION ALL SELECT '3.1215'
 UNION ALL SELECT '3.1216'
 UNION ALL SELECT '3.1217'
 UNION ALL SELECT '3.1218'
 UNION ALL SELECT '3.1219'
 UNION ALL SELECT '3.1220'
 UNION ALL SELECT '3.1221'
 UNION ALL SELECT '3.1222'
 UNION ALL SELECT '3.1223'
 UNION ALL SELECT '3.1224'
 UNION ALL SELECT '3.1225'
 UNION ALL SELECT '3.1226'
 UNION ALL SELECT '3.1227'
 UNION ALL SELECT '3.1228'
 UNION ALL SELECT '3.1229'
 UNION ALL SELECT '3.1230'
 UNION ALL SELECT '3.1231'
 UNION ALL SELECT '3.1232'
 UNION ALL SELECT '3.1233'
 UNION ALL SELECT '3.1234'
 UNION ALL SELECT '3.1235'
) required

LEFT JOIN equations e
ON e.equation_number=required.equation_number

WHERE e.equation_id IS NULL;



/* ============================================================
   6. Quellen Kapitel 3.6
   ============================================================ */

SELECT
    s.citation_number,
    s.title,
    COUNT(su.usage_id) AS usage_count

FROM sources s

LEFT JOIN source_usage su
ON su.source_id=s.source_id

WHERE s.citation_number BETWEEN 68 AND 73

GROUP BY
s.source_id,
s.citation_number,
s.title

ORDER BY s.citation_number;



/* ============================================================
   7. Source Usage ohne Quelle
   ============================================================ */

SELECT
    su.usage_id,
    su.source_id,
    su.section_id

FROM source_usage su

LEFT JOIN sources s
ON s.source_id=su.source_id

WHERE s.source_id IS NULL;



/* ============================================================
   8. Gleichungen ohne Abschnitt
   ============================================================ */

SELECT
    e.equation_number,
    e.section_id

FROM equations e

LEFT JOIN dissertation_sections ds
ON ds.section_id=e.section_id

WHERE e.equation_number BETWEEN '3.1213'
AND '3.1235'

AND ds.section_id IS NULL;



/* ============================================================
   9. Doppelte Gleichungsnummern
   ============================================================ */

SELECT
    equation_number,
    COUNT(*) AS anzahl

FROM equations

GROUP BY equation_number

HAVING COUNT(*) > 1;



/* ============================================================
   10. Doppelte Abschnittscodes
   ============================================================ */

SELECT
    section_code,
    COUNT(*) AS anzahl

FROM dissertation_sections

GROUP BY section_code

HAVING COUNT(*) > 1;



/* ============================================================
   11. Change Log
   ============================================================ */

SELECT
    scl.section_id,
    ds.section_code,
    scl.revision_id,
    scl.change_type,
    scl.object_type,
    scl.object_reference,
    scl.changed_at

FROM section_change_log scl

JOIN dissertation_sections ds
ON ds.section_id=scl.section_id

WHERE ds.section_code LIKE '3.6%'

ORDER BY scl.changed_at;



/* ============================================================
   12. Abschlussbewertung
   ============================================================ */

SELECT

CASE

WHEN
(
 SELECT COUNT(*)
 FROM dissertation_sections
 WHERE section_code LIKE '3.6%'
)
>=7

AND

(
 SELECT COUNT(*)
 FROM equations
 WHERE equation_number BETWEEN '3.1213'
 AND '3.1235'
)
=23

THEN 'Kapitel 3.6 strukturell vollständig'

ELSE 'Kapitel 3.6 unvollständig'

END AS audit_status;
