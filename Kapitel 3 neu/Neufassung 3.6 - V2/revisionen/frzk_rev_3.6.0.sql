USE frzk_rkb;

SET NAMES utf8mb4;

START TRANSACTION;


/* ============================================================
   Parent Revision laden
   ============================================================ */

SET @parent_revision_id :=
(
    SELECT revision_id
    FROM repository_revisions
    ORDER BY revision_id DESC
    LIMIT 1
);


/* ============================================================
   Neue Revision 3.6.0
   ============================================================ */

INSERT INTO repository_revisions
(
    revision_code,
    revision_date,
    scope_type,
    scope_reference,
    version_label,
    summary,
    created_by,
    parent_revision_id
)
VALUES
(
    'RKB-REV-K3.6.0-V1',
    NOW(),
    'section',
    '3.6.0',
    '1.0',
    'Kapitel 3.6.0 Einleitung: empirische und praktische Anschlussfähigkeit des FRZK.',
    'Olaf Thiele / ChatGPT',
    @parent_revision_id
);

SET @revision_id = LAST_INSERT_ID();