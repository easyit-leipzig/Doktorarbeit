/* ============================================================
   FRZK Repository
   Kapitel 3.6 Gleichungen Rebuild FINAL

   Grundlage:
   Kapitel 3.6 MASTER_REBUILD_V3

   Gleichungen:
   3.1213 - 3.1235

   ============================================================ */

USE frzk_rkb;

START TRANSACTION;


/* ============================================================
   Revision holen
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

SET @s360=(SELECT section_id FROM dissertation_sections WHERE section_code='3.6.0');
SET @s361=(SELECT section_id FROM dissertation_sections WHERE section_code='3.6.1');
SET @s362=(SELECT section_id FROM dissertation_sections WHERE section_code='3.6.2');
SET @s363=(SELECT section_id FROM dissertation_sections WHERE section_code='3.6.3');
SET @s364=(SELECT section_id FROM dissertation_sections WHERE section_code='3.6.4');
SET @s365=(SELECT section_id FROM dissertation_sections WHERE section_code='3.6.5');


/* ============================================================
   Alte Gleichungen 3.6 entfernen
   ============================================================ */

DELETE FROM equations
WHERE equation_number BETWEEN '3.1213' AND '3.1235';



/* ============================================================
   Gleichungen einfügen
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
'3.1213',
@s360,
'Funktionale Beobachtungsrepräsentation',
'\Phi_F:\mathcal{S}_F\rightarrow V_F',
'\Phi_F:\mathcal{S}_F\rightarrow V_F',
'Abbildung einer funktionalen Organisation in einen Beobachtungsraum.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1214',
@s361,
'Funktionaler Zustandsraum',
'\mathcal{V}_F=\{\Phi_F(\mathcal{S}_i)|\mathcal{S}_i\in\mathcal{G}_F\}',
'\mathcal{V}_F=\{\Phi_F(\mathcal{S}_i)|\mathcal{S}_i\in\mathcal{G}_F\}',
'Menge beobachtbarer funktionaler Zustände.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1215',
@s361,
'Funktionale Differenz',
'\Delta_V:\mathcal{V}_F\times\mathcal{V}_F\rightarrow\mathbb{R}_{\geq0}',
'\Delta_V:\mathcal{V}_F\times\mathcal{V}_F\rightarrow\mathbb{R}_{\geq0}',
'Vergleich funktionaler Zustände.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1216',
@s361,
'Zustandsfolge',
'\mathcal{V}_F(t)=(v_1(t),v_2(t),...,v_n(t))',
'\mathcal{V}_F(t)=(v_1(t),v_2(t),...,v_n(t))',
'Zeitliche Folge funktionaler Zustände.',
'representation',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1217',
@s361,
'Funktionale Transformation',
'T_F:\mathcal{V}_F(t)\rightarrow\mathcal{V}_F(t+1)',
'T_F:\mathcal{V}_F(t)\rightarrow\mathcal{V}_F(t+1)',
'Übergang zwischen funktionalen Zuständen.',
'operator',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1218',
@s362,
'Funktionale Zustandsmenge',
'\mathcal{V}_F=\{v_1,v_2,...,v_n\}',
'\mathcal{V}_F=\{v_1,v_2,...,v_n\}',
'Menge funktionaler Zustände.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1219',
@s362,
'Relationsstruktur',
'\Gamma_F\subseteq\mathcal{V}_F\times\mathcal{V}_F',
'\Gamma_F\subseteq\mathcal{V}_F\times\mathcal{V}_F',
'Relationen zwischen funktionalen Zuständen.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1220',
@s362,
'Funktionale Organisation',
'\mathcal{O}_F=(\mathcal{V}_F,\Gamma_F)',
'\mathcal{O}_F=(\mathcal{V}_F,\Gamma_F)',
'Organisation aus Zuständen und Relationen.',
'definition',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1221',
@s362,
'Funktionale Kohärenz',
'K_F=\frac{\Omega_{stabil}}{\Omega_{gesamt}}',
'K_F=\frac{\Omega_{stabil}}{\Omega_{gesamt}}',
'Verhältnis stabilisierender Beziehungen.',
'model',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1222',
@s362,
'Kohärenzfunktion',
'K_F=f(\mathcal{V}_F,\Gamma_F,T_F)',
'K_F=f(\mathcal{V}_F,\Gamma_F,T_F)',
'Abhängigkeit der Kohärenz von Struktur und Transformation.',
'model',
'FRZK Eigenentwicklung',
'checked',
@revision_id
),


(
'3.1223',
@s363,
'Kybernetischer Zustandsübergang',
'x(t+1)=F(x(t),u(t))',
'x(t+1)=F(x(t),u(t))',
'Dynamischer Zustandsübergang.',
'model',
'Literaturmodell',
'checked',
@revision_id
),


(
'3.1224',
@s363,
'Dynamisches System',
'x_{t+1}=F(x_t)',
'x_{t+1}=F(x_t)',
'Zustandsentwicklung eines dynamischen Systems.',
'model',
'Literaturmodell',
'checked',
@revision_id
),


(
'3.1225',
@s363,
'Netzwerkdarstellung',
'G=(V,E)',
'G=(V,E)',
'Graph aus Knoten und Kanten.',
'definition',
'Literaturmodell',
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
WHERE equation_number BETWEEN '3.1213'
AND '3.1225'
ORDER BY equation_number;