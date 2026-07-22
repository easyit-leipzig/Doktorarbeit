/* ============================================================
   FRZK Repository
   Kapitel 3.6 Gleichungen Ergänzung

   Gleichungen:
   3.1226 - 3.1235

   Grundlage:
   Kapitel 3.6 MASTER_REBUILD_V3

   ============================================================ */

USE frzk_rkb;

START TRANSACTION;


/* ============================================================
   Revision
   ============================================================ */

SET @revision_id =
(
 SELECT revision_id
 FROM repository_revisions
 WHERE revision_code='RKB-REV-K3.6-REBUILD-V3'
 LIMIT 1
);


/* ============================================================
   Sections
   ============================================================ */

SET @s364 =
(
 SELECT section_id
 FROM dissertation_sections
 WHERE section_code='3.6.4'
);


SET @s365 =
(
 SELECT section_id
 FROM dissertation_sections
 WHERE section_code='3.6.5'
);



/* ============================================================
   Alte Einträge entfernen
   ============================================================ */

DELETE FROM equations
WHERE equation_number BETWEEN '3.1226'
AND '3.1235';



/* ============================================================
   Gleichungen 3.1226 - 3.1235
   ============================================================ */


INSERT INTO equations
(
 equation_number,
 section_id,
 title,
 equation_latex,
 word_latex,
 plain_description,
 equation_type,
 provenance,
 validation_status,
 created_revision_id
)

VALUES


(
'3.1226',
@s364,
'Funktionale Beobachtungsrepräsentation',
'\Phi_F:\mathcal{S}_F\rightarrow V_F',
'\Phi_F:\mathcal{S}_F\rightarrow V_F',
'Abbildung einer funktionalen Organisation in einen beobachtbaren Merkmalsraum.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1227',
@s364,
'Funktionaler Beobachtungsvektor',
'v_F=\begin{pmatrix}a_1\\a_2\\\vdots\\a_n\end{pmatrix}',
'v_F=\begin{pmatrix}a_1\\a_2\\\vdots\\a_n\end{pmatrix}',
'Darstellung funktionaler Eigenschaften als Vektor.',
'representation',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1228',
@s364,
'Funktionale Zustandsüberführung',
'T_F(v_F(t_i))=v_F(t_{i+1})',
'T_F(v_F(t_i))=v_F(t_{i+1})',
'Transformation zwischen beobachteten funktionalen Zuständen.',
'operator',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1229',
@s364,
'Zeitabhängige funktionale Kohärenz',
'K_F(t)=f(\mathcal{V}_F(t),\Gamma_F(t),T_F(t))',
'K_F(t)=f(\mathcal{V}_F(t),\Gamma_F(t),T_F(t))',
'Zeitabhängige Betrachtung funktionaler Kohärenz.',
'model',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1230',
@s364,
'Lernprozess als Zustandsraumtransformation',
'L_F:V_F(t)\rightarrow V_F(t+1)',
'L_F:V_F(t)\rightarrow V_F(t+1)',
'Beschreibung eines Lernprozesses als funktionale Zustandsänderung.',
'operator',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1231',
@s365,
'Funktionale Organisationsstruktur',
'\mathcal{O}_F=(\mathcal{V}_F,\Gamma_F)',
'\mathcal{O}_F=(\mathcal{V}_F,\Gamma_F)',
'Organisation aus Zuständen und Relationen.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1232',
@s365,
'Funktionales Netzwerk',
'\mathcal{N}_F=(\mathcal{V}_F,\Gamma_F,W_F)',
'\mathcal{N}_F=(\mathcal{V}_F,\Gamma_F,W_F)',
'Netzwerk mit gewichteten funktionalen Beziehungen.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1233',
@s365,
'Funktionale Zentralität',
'Z_F(v_i)=f(d_i,w_i,\kappa_i)',
'Z_F(v_i)=f(d_i,w_i,\kappa_i)',
'Beschreibung der funktionalen Bedeutung eines Zustands.',
'model',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1234',
@s365,
'Emergenz funktionaler Organisation',
'E_F:\mathcal{N}_F\rightarrow\mathcal{O}_F^{*}',
'E_F:\mathcal{N}_F\rightarrow\mathcal{O}_F^{*}',
'Transformation eines Netzwerks in eine höherwertige Organisationsform.',
'operator',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1235',
@s365,
'Zeitabhängiges funktionales Netzwerk',
'\mathcal{N}_F(t)=(\mathcal{V}_F(t),\Gamma_F(t),W_F(t))',
'\mathcal{N}_F(t)=(\mathcal{V}_F(t),\Gamma_F(t),W_F(t))',
'Dynamische Darstellung eines funktionalen Netzwerks.',
'model',
'FRZK Eigenentwicklung',
'checked',
@revision_id
);



COMMIT;


/* ============================================================
   Audit
   ============================================================ */

SELECT
 equation_number,
 title,
 section_id
FROM equations
WHERE equation_number BETWEEN '3.1226'
AND '3.1235'
ORDER BY equation_number;