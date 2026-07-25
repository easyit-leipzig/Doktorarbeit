/* ============================================================
 FRZK Repository-Update
 Kapitel 3.8.11 – Durchführung, Auswertung und Dokumentation
 systematischer Simulationsstudien
 Version 1.0 – MariaDB-kompatibel

 Manuskriptgleichungen: (3.653)–(3.694)
 Repositorygleichungen: 3.1441–3.1482
 Neue Literatur: keine

 Kompatibilität:
 - MariaDB 10.4+
 - keine abgeleiteten Spaltenlisten hinter Tabellenaliasen
 - idempotente INSERT ... SELECT-Struktur
 ============================================================ */

START TRANSACTION;

SET @revision_code := 'RKB-K3.8.11-V1';

SET @parent_section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.8'
    LIMIT 1
);

SET @parent_revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code IN ('RKB-K3.8.10-V2','RKB-K3.8.10-V1')
    ORDER BY
        CASE revision_code
            WHEN 'RKB-K3.8.10-V2' THEN 1
            WHEN 'RKB-K3.8.10-V1' THEN 2
            ELSE 3
        END
    LIMIT 1
);

/* 1. Repository-Revision */

INSERT INTO repository_revisions
(
    revision_code, revision_date, scope_type, scope_reference,
    version_label, summary, created_by, parent_revision_id
)
SELECT
    @revision_code, NOW(), 'section', '3.8.11', '1.0',
    'Durchführung, Auswertung und Dokumentation systematischer Simulationsstudien.',
    'Olaf Thiele / ChatGPT', @parent_revision_id
WHERE @parent_section_id IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM repository_revisions
    WHERE revision_code = @revision_code
);

SET @revision_id := (
    SELECT revision_id
    FROM repository_revisions
    WHERE revision_code = @revision_code
    LIMIT 1
);

/* 2. Dissertation-Abschnitt */

INSERT INTO dissertation_sections
(
    parent_section_id, section_code, title, chapter_no,
    section_order, status, is_original_contribution, notes
)
SELECT
    @parent_section_id,
    '3.8.11',
    'Durchführung, Auswertung und Dokumentation systematischer Simulationsstudien',
    3,
    3.8110,
    'draft',
    1,
    'Manuskriptgleichungen (3.653) bis (3.694); Repositorygleichungen 3.1441 bis 3.1482.'
WHERE @parent_section_id IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM dissertation_sections
    WHERE section_code = '3.8.11'
);

UPDATE dissertation_sections
SET
    parent_section_id = @parent_section_id,
    title = 'Durchführung, Auswertung und Dokumentation systematischer Simulationsstudien',
    chapter_no = 3,
    section_order = 3.8110,
    status = 'draft',
    is_original_contribution = 1,
    notes = 'Manuskriptgleichungen (3.653) bis (3.694); Repositorygleichungen 3.1441 bis 3.1482.'
WHERE section_code = '3.8.11';

SET @section_id := (
    SELECT section_id
    FROM dissertation_sections
    WHERE section_code = '3.8.11'
    LIMIT 1
);

/* 3. Definitionen */

INSERT INTO definitions
(
    definition_number, section_id, title, definition_text,
    formal_latex, word_latex, provenance, source_id,
    assumptions, notes, validation_status, created_revision_id
)
SELECT
    x.definition_number,
    @section_id,
    x.title,
    x.definition_text,
    x.formal_latex,
    x.word_latex,
    'original',
    NULL,
    x.assumptions,
    x.notes,
    'draft',
    @revision_id
FROM
(
    SELECT
        '3.8.11.1' AS definition_number,
        'Simulationsstudie' AS title,
        'Eine Simulationsstudie ist eine geordnete, versionierte und auswertbare Menge von Simulationsläufen.' AS definition_text,
        '\\mathcal{S}_{\\mathrm{sim}}=\\left\\{\\mathcal{R}_1,\\ldots,\\mathcal{R}_N\\right\\}' AS formal_latex,
        '\\mathcal{S}_{\\mathrm{sim}}=\\left\\{\\mathcal{R}_1,\\ldots,\\mathcal{R}_N\\right\\}' AS word_latex,
        'Die im Abschnitt festgelegten Voraussetzungen gelten.' AS assumptions,
        'Definition aus Abschnitt 3.8.11.' AS notes

    UNION ALL

    SELECT
        '3.8.11.2',
        'Simulationslaufobjekt',
        'Ein Simulationslaufobjekt verbindet Parametrisierung, Anfangszustand, Operatorenkonfiguration, Zufallszustand, Trajektorie, Merkmale und Status.',
        '\\mathcal{R}_i=\\left(\\Theta_i,S_{0,i},\\mathcal{O}_i,\\xi_i,\\Gamma_i,F_{\\Gamma_i},Z_i\\right)',
        '\\mathcal{R}_i=\\left(\\Theta_i,S_{0,i},\\mathcal{O}_i,\\xi_i,\\Gamma_i,F_{\\Gamma_i},Z_i\\right)',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'

    UNION ALL

    SELECT
        '3.8.11.3',
        'Versuchsplan',
        'Der Versuchsplan ist die endliche Menge der innerhalb einer Studie untersuchten Parameterpunkte.',
        '\\mathcal{D}\\subseteq\\mathcal{P}',
        '\\mathcal{D}\\subseteq\\mathcal{P}',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'

    UNION ALL

    SELECT
        '3.8.11.4',
        'Wiederholungsgruppe',
        'Eine Wiederholungsgruppe enthält Simulationsläufe mit demselben Parameterpunkt und kontrolliert variierten oder identischen Zufallszuständen.',
        'G_{\\Theta_j}=\\left\\{\\mathcal{R}_{j,1},\\ldots,\\mathcal{R}_{j,n_{\\xi}}\\right\\}',
        'G_{\\Theta_j}=\\left\\{\\mathcal{R}_{j,1},\\ldots,\\mathcal{R}_{j,n_{\\xi}}\\right\\}',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'

    UNION ALL

    SELECT
        '3.8.11.5',
        'Auswertbare Laufmenge',
        'Die auswertbare Laufmenge enthält ausschließlich abgeschlossene und validierte Simulationsläufe.',
        '\\mathcal{S}_{\\mathrm{eval}}\\subseteq\\mathcal{S}_{\\mathrm{sim}}',
        '\\mathcal{S}_{\\mathrm{eval}}\\subseteq\\mathcal{S}_{\\mathrm{sim}}',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'

    UNION ALL

    SELECT
        '3.8.11.6',
        'Vollständigkeitsindex',
        'Der Vollständigkeitsindex ist das Verhältnis abgeschlossener zu geplanten Simulationsläufen.',
        'I_{\\mathrm{complete}}=\\frac{N_{\\mathrm{completed}}}{N_{\\mathrm{planned}}}',
        'I_{\\mathrm{complete}}=\\frac{N_{\\mathrm{completed}}}{N_{\\mathrm{planned}}}',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'

    UNION ALL

    SELECT
        '3.8.11.7',
        'Validitätsindex',
        'Der Validitätsindex ist das Verhältnis valider zu abgeschlossenen Simulationsläufen.',
        'I_{\\mathrm{valid}}=\\frac{N_{\\mathrm{valid}}}{N_{\\mathrm{completed}}}',
        'I_{\\mathrm{valid}}=\\frac{N_{\\mathrm{valid}}}{N_{\\mathrm{completed}}}',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'

    UNION ALL

    SELECT
        '3.8.11.8',
        'Abdeckungsindex',
        'Der Abdeckungsindex beschreibt den durch die untersuchten Parameterpunkte repräsentierten Anteil des vorgesehenen Parameterraums.',
        'I_{\\mathrm{coverage}}\\in[0,1]',
        'I_{\\mathrm{coverage}}\\in[0,1]',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'

    UNION ALL

    SELECT
        '3.8.11.9',
        'Reproduzierbarkeitsindex',
        'Der Reproduzierbarkeitsindex bewertet die Übereinstimmung wiederholter Läufe mit identischer Konfiguration.',
        'I_{\\mathrm{reprod}}\\in[0,1]',
        'I_{\\mathrm{reprod}}\\in[0,1]',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'

    UNION ALL

    SELECT
        '3.8.11.10',
        'Studienstatusvektor',
        'Der Studienstatusvektor verbindet Vollständigkeit, Validität, Reproduzierbarkeit, Abdeckung und Interpretationsstatus.',
        'Z_{\\mathrm{study}}=\\left(I_{\\mathrm{complete}},I_{\\mathrm{valid}},I_{\\mathrm{reprod}},I_{\\mathrm{coverage}},I_{\\mathrm{interpret}}\\right)',
        'Z_{\\mathrm{study}}=\\left(I_{\\mathrm{complete}},I_{\\mathrm{valid}},I_{\\mathrm{reprod}},I_{\\mathrm{coverage}},I_{\\mathrm{interpret}}\\right)',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'

    UNION ALL

    SELECT
        '3.8.11.11',
        'Studienergebnisobjekt',
        'Das Studienergebnisobjekt führt Status, Merkmale, Verteilungen, robuste und kritische Bereiche, Cluster, Anomalien und Interpretationen zusammen.',
        'E_{\\mathrm{study}}=\\left(Z_{\\mathrm{study}},\\overline{F}_{\\Gamma},\\Sigma_F,P_K,P_A,R,C,\\mathcal{G},\\mathcal{A},\\mathcal{I}\\right)',
        'E_{\\mathrm{study}}=\\left(Z_{\\mathrm{study}},\\overline{F}_{\\Gamma},\\Sigma_F,P_K,P_A,R,C,\\mathcal{G},\\mathcal{A},\\mathcal{I}\\right)',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'

    UNION ALL

    SELECT
        '3.8.11.12',
        'Studienfreigabe',
        'Eine Studie wird freigegeben, wenn die Mindestanforderungen an Vollständigkeit, Validität, Reproduzierbarkeit, Abdeckung und Interpretation erfüllt sind.',
        'z_{\\mathrm{release}}=1',
        'z_{\\mathrm{release}}=1',
        'Die im Abschnitt festgelegten Voraussetzungen gelten.',
        'Definition aus Abschnitt 3.8.11.'
) x
WHERE @section_id IS NOT NULL
AND @revision_id IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM definitions d
    WHERE d.definition_number = x.definition_number
);

/* 4. Gleichungen */

INSERT INTO equations
(
    equation_number, section_id, title, equation_latex,
    word_latex, plain_description, equation_type,
    provenance, source_id, derivation, assumptions,
    validation_status, created_revision_id
)
SELECT
    x.equation_number,
    @section_id,
    x.title,
    x.equation_latex,
    x.word_latex,
    x.plain_description,
    x.equation_type,
    'original',
    NULL,
    'Herleitung gemäß Abschnitt 3.8.11.',
    'Die im Abschnitt festgelegten Bedingungen der Simulationsstudie gelten.',
    'draft',
    @revision_id
FROM
(
    SELECT
        '3.1441' AS equation_number,
        'Simulationsstudie' AS title,
        '\\mathcal{S}_{\\mathrm{sim}}=\\left\\{\\mathcal{R}_1,\\mathcal{R}_2,\\ldots,\\mathcal{R}_N\\right\\}' AS equation_latex,
        '\\mathcal{S}_{\\mathrm{sim}}=\\left\\{\\mathcal{R}_1,\\mathcal{R}_2,\\ldots,\\mathcal{R}_N\\right\\}' AS word_latex,
        'Geordnete Menge der Simulationsläufe.' AS plain_description,
        'definition' AS equation_type

    UNION ALL

    SELECT
        '3.1442',
        'Simulationslaufobjekt',
        '\\mathcal{R}_i=\\left(\\Theta_i,S_{0,i},\\mathcal{O}_i,\\xi_i,\\Gamma_i,F_{\\Gamma_i},Z_i\\right)',
        '\\mathcal{R}_i=\\left(\\Theta_i,S_{0,i},\\mathcal{O}_i,\\xi_i,\\Gamma_i,F_{\\Gamma_i},Z_i\\right)',
        'Vollständige Beschreibung eines Simulationslaufs.',
        'definition'

    UNION ALL

    SELECT
        '3.1443',
        'Versuchsplan',
        '\\mathcal{D}=\\left\\{\\Theta_1,\\Theta_2,\\ldots,\\Theta_m\\right\\}\\subseteq\\mathcal{P}',
        '\\mathcal{D}=\\left\\{\\Theta_1,\\Theta_2,\\ldots,\\Theta_m\\right\\}\\subseteq\\mathcal{P}',
        'Endliche Menge untersuchter Parameterpunkte.',
        'definition'

    UNION ALL

    SELECT
        '3.1444',
        'Gesamtzahl der Simulationsläufe',
        'N=m\\cdot n_S\\cdot n_{\\xi}',
        'N=m\\cdot n_S\\cdot n_{\\xi}',
        'Anzahl aller geplanten Kombinationen.',
        'definition'

    UNION ALL

    SELECT
        '3.1445',
        'Studienabbildung',
        '\\Pi_{\\mathrm{study}}:\\mathcal{D}\\times\\mathcal{S}_0\\times\\Xi\\longrightarrow\\mathcal{S}_{\\mathrm{sim}}',
        '\\Pi_{\\mathrm{study}}:\\mathcal{D}\\times\\mathcal{S}_0\\times\\Xi\\longrightarrow\\mathcal{S}_{\\mathrm{sim}}',
        'Zuordnung von Parametern, Anfangszuständen und Seeds zu Läufen.',
        'mapping'

    UNION ALL

    SELECT
        '3.1446',
        'Deterministische Laufidentität',
        '\\mathcal{R}_a\\equiv\\mathcal{R}_b',
        '\\mathcal{R}_a\\equiv\\mathcal{R}_b',
        'Identität deterministischer Simulationsläufe.',
        'criterion'

    UNION ALL

    SELECT
        '3.1447',
        'Identische deterministische Eingaben',
        '\\Theta_a=\\Theta_b,\\qquad S_{0,a}=S_{0,b},\\qquad\\mathcal{O}_a=\\mathcal{O}_b',
        '\\Theta_a=\\Theta_b,\\qquad S_{0,a}=S_{0,b},\\qquad\\mathcal{O}_a=\\mathcal{O}_b',
        'Bedingungen identischer deterministischer Eingaben.',
        'constraint'

    UNION ALL

    SELECT
        '3.1448',
        'Identischer Zufallszustand',
        '\\xi_a=\\xi_b',
        '\\xi_a=\\xi_b',
        'Bedingung identischer Zufallszustände.',
        'constraint'

    UNION ALL

    SELECT
        '3.1449',
        'Vollständige Reproduzierbarkeit',
        '\\left(\\Theta_a,S_{0,a},\\mathcal{O}_a,\\xi_a\\right)=\\left(\\Theta_b,S_{0,b},\\mathcal{O}_b,\\xi_b\\right)\\Rightarrow\\Gamma_a=\\Gamma_b',
        '\\left(\\Theta_a,S_{0,a},\\mathcal{O}_a,\\xi_a\\right)=\\left(\\Theta_b,S_{0,b},\\mathcal{O}_b,\\xi_b\\right)\\Rightarrow\\Gamma_a=\\Gamma_b',
        'Identische Eingaben führen zu identischen Trajektorien.',
        'criterion'

    UNION ALL

    SELECT
        '3.1450',
        'Laufgruppe eines Parameterpunkts',
        'G_{\\Theta_j}=\\left\\{\\mathcal{R}_{j,1},\\mathcal{R}_{j,2},\\ldots,\\mathcal{R}_{j,n_{\\xi}}\\right\\}',
        'G_{\\Theta_j}=\\left\\{\\mathcal{R}_{j,1},\\mathcal{R}_{j,2},\\ldots,\\mathcal{R}_{j,n_{\\xi}}\\right\\}',
        'Wiederholungsgruppe zu einem Parameterpunkt.',
        'definition'

    UNION ALL

    SELECT
        '3.1451',
        'Mittlerer Ergebniswert',
        '\\overline{Q}_{\\Theta_j}=\\frac{1}{n_{\\xi}}\\sum_{r=1}^{n_{\\xi}}Q_{j,r}',
        '\\overline{Q}_{\\Theta_j}=\\frac{1}{n_{\\xi}}\\sum_{r=1}^{n_{\\xi}}Q_{j,r}',
        'Mittelwert einer Laufgruppe.',
        'metric'

    UNION ALL

    SELECT
        '3.1452',
        'Streuung einer Laufgruppe',
        '\\sigma_{\\Theta_j}=\\sqrt{\\frac{1}{n_{\\xi}-1}\\sum_{r=1}^{n_{\\xi}}\\left(Q_{j,r}-\\overline{Q}_{\\Theta_j}\\right)^2}',
        '\\sigma_{\\Theta_j}=\\sqrt{\\frac{1}{n_{\\xi}-1}\\sum_{r=1}^{n_{\\xi}}\\left(Q_{j,r}-\\overline{Q}_{\\Theta_j}\\right)^2}',
        'Streuung der Ergebnisse innerhalb einer Wiederholungsgruppe.',
        'metric'

    UNION ALL

    SELECT
        '3.1453',
        'Laufstatusmenge',
        'z_{\\mathrm{run}}\\in\\left\\{z_{\\mathrm{planned}},z_{\\mathrm{running}},z_{\\mathrm{completed}},z_{\\mathrm{failed}},z_{\\mathrm{invalid}}\\right\\}',
        'z_{\\mathrm{run}}\\in\\left\\{z_{\\mathrm{planned}},z_{\\mathrm{running}},z_{\\mathrm{completed}},z_{\\mathrm{failed}},z_{\\mathrm{invalid}}\\right\\}',
        'Zulässige technische Laufstatus.',
        'definition'

    UNION ALL

    SELECT
        '3.1454',
        'Auswertbarkeitsbedingung',
        'z_{\\mathrm{run}}=z_{\\mathrm{completed}}\\land z_{\\mathrm{valid}}=1',
        'z_{\\mathrm{run}}=z_{\\mathrm{completed}}\\land z_{\\mathrm{valid}}=1',
        'Bedingung für die Aufnahme eines Laufs in die Auswertung.',
        'criterion'

    UNION ALL

    SELECT
        '3.1455',
        'Auswertbare Laufmenge',
        '\\mathcal{S}_{\\mathrm{eval}}=\\left\\{\\mathcal{R}_i\\in\\mathcal{S}_{\\mathrm{sim}}\\mid z_{\\mathrm{run},i}=z_{\\mathrm{completed}}\\land z_{\\mathrm{valid},i}=1\\right\\}',
        '\\mathcal{S}_{\\mathrm{eval}}=\\left\\{\\mathcal{R}_i\\in\\mathcal{S}_{\\mathrm{sim}}\\mid z_{\\mathrm{run},i}=z_{\\mathrm{completed}}\\land z_{\\mathrm{valid},i}=1\\right\\}',
        'Menge abgeschlossener und valider Läufe.',
        'definition'

    UNION ALL

    SELECT
        '3.1456',
        'Vollständigkeitsindex',
        'I_{\\mathrm{complete}}=\\frac{N_{\\mathrm{completed}}}{N_{\\mathrm{planned}}}',
        'I_{\\mathrm{complete}}=\\frac{N_{\\mathrm{completed}}}{N_{\\mathrm{planned}}}',
        'Anteil abgeschlossener an geplanten Läufen.',
        'metric'

    UNION ALL

    SELECT
        '3.1457',
        'Wertebereich des Vollständigkeitsindex',
        '0\\le I_{\\mathrm{complete}}\\le1',
        '0\\le I_{\\mathrm{complete}}\\le1',
        'Zulässiger Wertebereich des Vollständigkeitsindex.',
        'constraint'

    UNION ALL

    SELECT
        '3.1458',
        'Vollständige Studie',
        'I_{\\mathrm{complete}}=1',
        'I_{\\mathrm{complete}}=1',
        'Bedingung einer vollständig durchgeführten Studie.',
        'criterion'

    UNION ALL

    SELECT
        '3.1459',
        'Validitätsindex',
        'I_{\\mathrm{valid}}=\\frac{N_{\\mathrm{valid}}}{N_{\\mathrm{completed}}}',
        'I_{\\mathrm{valid}}=\\frac{N_{\\mathrm{valid}}}{N_{\\mathrm{completed}}}',
        'Anteil valider an abgeschlossenen Läufen.',
        'metric'

    UNION ALL

    SELECT
        '3.1460',
        'Studienstatusvektor',
        'Z_{\\mathrm{study}}=\\left(I_{\\mathrm{complete}},I_{\\mathrm{valid}},I_{\\mathrm{reprod}},I_{\\mathrm{coverage}},I_{\\mathrm{interpret}}\\right)',
        'Z_{\\mathrm{study}}=\\left(I_{\\mathrm{complete}},I_{\\mathrm{valid}},I_{\\mathrm{reprod}},I_{\\mathrm{coverage}},I_{\\mathrm{interpret}}\\right)',
        'Zusammengefasster Status einer Simulationsstudie.',
        'definition'

    UNION ALL

    SELECT
        '3.1461',
        'Kontinuierlicher Abdeckungsindex',
        'I_{\\mathrm{coverage}}=\\frac{V_{\\mathrm{covered}}}{V_{\\mathcal{P}_{\\mathrm{study}}}}',
        'I_{\\mathrm{coverage}}=\\frac{V_{\\mathrm{covered}}}{V_{\\mathcal{P}_{\\mathrm{study}}}}',
        'Abdeckung eines kontinuierlichen Parameterraums.',
        'metric'

    UNION ALL

    SELECT
        '3.1462',
        'Diskreter Abdeckungsindex',
        'I_{\\mathrm{coverage}}=\\frac{N_{\\mathrm{tested}}}{N_{\\mathrm{possible}}}',
        'I_{\\mathrm{coverage}}=\\frac{N_{\\mathrm{tested}}}{N_{\\mathrm{possible}}}',
        'Abdeckung eines diskreten Parameterraums.',
        'metric'

    UNION ALL

    SELECT
        '3.1463',
        'Mittlerer Trajektorienmerkmalsvektor',
        '\\overline{F}_{\\Gamma}=\\frac{1}{N_{\\mathrm{eval}}}\\sum_{i=1}^{N_{\\mathrm{eval}}}F_{\\Gamma_i}',
        '\\overline{F}_{\\Gamma}=\\frac{1}{N_{\\mathrm{eval}}}\\sum_{i=1}^{N_{\\mathrm{eval}}}F_{\\Gamma_i}',
        'Mittelwert der Trajektorienmerkmalsvektoren.',
        'metric'

    UNION ALL

    SELECT
        '3.1464',
        'Kovarianzmatrix der Trajektorienmerkmale',
        '\\Sigma_F=\\frac{1}{N_{\\mathrm{eval}}-1}\\sum_{i=1}^{N_{\\mathrm{eval}}}\\left(F_{\\Gamma_i}-\\overline{F}_{\\Gamma}\\right)\\left(F_{\\Gamma_i}-\\overline{F}_{\\Gamma}\\right)^{\\mathsf{T}}',
        '\\Sigma_F=\\frac{1}{N_{\\mathrm{eval}}-1}\\sum_{i=1}^{N_{\\mathrm{eval}}}\\left(F_{\\Gamma_i}-\\overline{F}_{\\Gamma}\\right)\\left(F_{\\Gamma_i}-\\overline{F}_{\\Gamma}\\right)^{\\mathsf{T}}',
        'Empirische Kovarianzmatrix der Trajektorienmerkmale.',
        'metric'

    UNION ALL

    SELECT
        '3.1465',
        'Absolute Klassenhäufigkeit',
        'N_{K_j}=\\sum_{i=1}^{N_{\\mathrm{eval}}}\\mathbf{1}\\left[\\kappa(F_{\\Gamma_i})=K_j\\right]',
        'N_{K_j}=\\sum_{i=1}^{N_{\\mathrm{eval}}}\\mathbf{1}\\left[\\kappa(F_{\\Gamma_i})=K_j\\right]',
        'Absolute Häufigkeit einer funktionalen Klasse.',
        'metric'

    UNION ALL

    SELECT
        '3.1466',
        'Relative Klassenhäufigkeit',
        'p_{K_j}=\\frac{N_{K_j}}{N_{\\mathrm{eval}}}',
        'p_{K_j}=\\frac{N_{K_j}}{N_{\\mathrm{eval}}}',
        'Relative Häufigkeit einer funktionalen Klasse.',
        'metric'

    UNION ALL

    SELECT
        '3.1467',
        'Normierung der Klassenhäufigkeiten',
        '\\sum_{j=1}^{r}p_{K_j}=1',
        '\\sum_{j=1}^{r}p_{K_j}=1',
        'Normierungsbedingung der Klassenverteilung.',
        'constraint'

    UNION ALL

    SELECT
        '3.1468',
        'Empirische Attraktorhäufigkeit',
        'p(A_j)=\\frac{N(A_j)}{N_{\\mathrm{eval}}}',
        'p(A_j)=\\frac{N(A_j)}{N_{\\mathrm{eval}}}',
        'Relative Häufigkeit eines Attraktors.',
        'metric'

    UNION ALL

    SELECT
        '3.1469',
        'Bedingte Attraktorhäufigkeit',
        'p(A_j\\mid B)=\\frac{N(A_j\\cap B)}{N(B)}',
        'p(A_j\\mid B)=\\frac{N(A_j\\cap B)}{N(B)}',
        'Attraktorhäufigkeit innerhalb eines Parameterbereichs.',
        'metric'

    UNION ALL

    SELECT
        '3.1470',
        'Gesamtzahl kritischer Übergänge',
        'N_{\\mathrm{crit}}=\\sum_{i=1}^{N_{\\mathrm{eval}}}N_{\\mathrm{crit},i}',
        'N_{\\mathrm{crit}}=\\sum_{i=1}^{N_{\\mathrm{eval}}}N_{\\mathrm{crit},i}',
        'Gesamtzahl kritischer Übergänge.',
        'metric'

    UNION ALL

    SELECT
        '3.1471',
        'Mittlere kritische Übergangszahl',
        '\\overline{N}_{\\mathrm{crit}}=\\frac{N_{\\mathrm{crit}}}{N_{\\mathrm{eval}}}',
        '\\overline{N}_{\\mathrm{crit}}=\\frac{N_{\\mathrm{crit}}}{N_{\\mathrm{eval}}}',
        'Mittlere Zahl kritischer Übergänge pro Lauf.',
        'metric'

    UNION ALL

    SELECT
        '3.1472',
        'Kritische Übergangsdichte',
        '\\rho_{\\mathrm{crit}}(B)=\\frac{N_{\\mathrm{crit}}(B)}{N_{\\mathrm{eval}}(B)}',
        '\\rho_{\\mathrm{crit}}(B)=\\frac{N_{\\mathrm{crit}}(B)}{N_{\\mathrm{eval}}(B)}',
        'Dichte kritischer Übergänge in einem Parameterbereich.',
        'metric'

    UNION ALL

    SELECT
        '3.1473',
        'Mittlere paarweise Trajektoriendistanz',
        '\\overline{D}_{G_j}=\\frac{2}{n_j(n_j-1)}\\sum_{a<b}D_{\\Gamma}\\left(\\Gamma_{j,a},\\Gamma_{j,b}\\right)',
        '\\overline{D}_{G_j}=\\frac{2}{n_j(n_j-1)}\\sum_{a<b}D_{\\Gamma}\\left(\\Gamma_{j,a},\\Gamma_{j,b}\\right)',
        'Mittlere paarweise Distanz innerhalb einer Wiederholungsgruppe.',
        'metric'

    UNION ALL

    SELECT
        '3.1474',
        'Gruppenbezogener Reproduzierbarkeitsindex',
        'I_{\\mathrm{reprod},j}=1-\\frac{\\overline{D}_{G_j}}{D_{\\max}}',
        'I_{\\mathrm{reprod},j}=1-\\frac{\\overline{D}_{G_j}}{D_{\\max}}',
        'Reproduzierbarkeit einer Wiederholungsgruppe.',
        'metric'

    UNION ALL

    SELECT
        '3.1475',
        'Studienbezogener Reproduzierbarkeitsindex',
        'I_{\\mathrm{reprod}}=\\frac{1}{m}\\sum_{j=1}^{m}I_{\\mathrm{reprod},j}',
        'I_{\\mathrm{reprod}}=\\frac{1}{m}\\sum_{j=1}^{m}I_{\\mathrm{reprod},j}',
        'Mittlere Reproduzierbarkeit der gesamten Studie.',
        'metric'

    UNION ALL

    SELECT
        '3.1476',
        'Studienergebnisobjekt',
        'E_{\\mathrm{study}}=\\left(Z_{\\mathrm{study}},\\overline{F}_{\\Gamma},\\Sigma_F,P_K,P_A,R,C,\\mathcal{G},\\mathcal{A},\\mathcal{I}\\right)',
        'E_{\\mathrm{study}}=\\left(Z_{\\mathrm{study}},\\overline{F}_{\\Gamma},\\Sigma_F,P_K,P_A,R,C,\\mathcal{G},\\mathcal{A},\\mathcal{I}\\right)',
        'Zusammengeführtes Ergebnisobjekt einer Simulationsstudie.',
        'definition'

    UNION ALL

    SELECT
        '3.1477',
        'Mindestvollständigkeit',
        'I_{\\mathrm{complete}}\\ge\\varepsilon_{\\mathrm{complete}}',
        'I_{\\mathrm{complete}}\\ge\\varepsilon_{\\mathrm{complete}}',
        'Mindestbedingung für die Vollständigkeit.',
        'criterion'

    UNION ALL

    SELECT
        '3.1478',
        'Mindestvalidität',
        'I_{\\mathrm{valid}}\\ge\\varepsilon_{\\mathrm{valid}}',
        'I_{\\mathrm{valid}}\\ge\\varepsilon_{\\mathrm{valid}}',
        'Mindestbedingung für die Validität.',
        'criterion'

    UNION ALL

    SELECT
        '3.1479',
        'Mindreproduzierbarkeit',
        'I_{\\mathrm{reprod}}\\ge\\varepsilon_{\\mathrm{reprod}}',
        'I_{\\mathrm{reprod}}\\ge\\varepsilon_{\\mathrm{reprod}}',
        'Mindestbedingung für die Reproduzierbarkeit.',
        'criterion'

    UNION ALL

    SELECT
        '3.1480',
        'Mindestabdeckung',
        'I_{\\mathrm{coverage}}\\ge\\varepsilon_{\\mathrm{coverage}}',
        'I_{\\mathrm{coverage}}\\ge\\varepsilon_{\\mathrm{coverage}}',
        'Mindestbedingung für die Parameterraumabdeckung.',
        'criterion'

    UNION ALL

    SELECT
        '3.1481',
        'Studienfreigabe',
        'z_{\\mathrm{release}}=1',
        'z_{\\mathrm{release}}=1',
        'Kennzeichnung einer freigegebenen Simulationsstudie.',
        'criterion'

    UNION ALL

    SELECT
        '3.1482',
        'Zusammengefasste Freigabebedingung',
        'z_{\\mathrm{release}}=\\prod_{k=1}^{4}\\mathbf{1}\\left[I_k\\ge\\varepsilon_k\\right]\\cdot z_{\\mathrm{interpret}}',
        'z_{\\mathrm{release}}=\\prod_{k=1}^{4}\\mathbf{1}\\left[I_k\\ge\\varepsilon_k\\right]\\cdot z_{\\mathrm{interpret}}',
        'Verknüpfung aller Mindestkriterien mit dem Interpretationsstatus.',
        'criterion'
) x
WHERE @section_id IS NOT NULL
AND @revision_id IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM equations e
    WHERE e.equation_number = x.equation_number
);

/* 5. Abschnittssymbole */

INSERT INTO symbols
(
    symbol_latex, symbol_word_latex, symbol_name, definition_text,
    scope_type, first_section_id, first_equation_id,
    unit_text, domain_text, codomain_text,
    is_vector, is_matrix, is_operator,
    notes, validation_status, created_revision_id
)
SELECT
    x.symbol_latex,
    x.symbol_latex,
    x.symbol_name,
    x.definition_text,
    'section',
    @section_id,
    (
        SELECT equation_id
        FROM equations
        WHERE equation_number = x.first_equation_number
        LIMIT 1
    ),
    NULL,
    NULL,
    NULL,
    x.is_vector,
    x.is_matrix,
    x.is_operator,
    'Abschnittssymbol 3.8.11.',
    'draft',
    @revision_id
FROM
(
    SELECT
        '\\mathcal{S}_{\\mathrm{sim}}' AS symbol_latex,
        'Simulationsstudie' AS symbol_name,
        'Menge aller Simulationsläufe einer Studie.' AS definition_text,
        '3.1441' AS first_equation_number,
        0 AS is_vector,
        0 AS is_matrix,
        0 AS is_operator

    UNION ALL

    SELECT
        '\\mathcal{R}_i',
        'Simulationslauf',
        'Vollständig beschriebenes Laufobjekt.',
        '3.1441',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\Theta_i',
        'Parametervektor des Laufs',
        'Parametrisierung des i-ten Laufs.',
        '3.1442',
        1,
        0,
        0

    UNION ALL

    SELECT
        'S_{0,i}',
        'Anfangszustand',
        'Anfangszustand des i-ten Laufs.',
        '3.1442',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\mathcal{O}_i',
        'Operatorenkonfiguration',
        'Operatorenkonfiguration des i-ten Laufs.',
        '3.1442',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\xi_i',
        'Zufallszustand',
        'Seed beziehungsweise Zufallszustand des i-ten Laufs.',
        '3.1442',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\Gamma_i',
        'Simulationstrajektorie',
        'Trajektorie des i-ten Laufs.',
        '3.1442',
        0,
        0,
        0

    UNION ALL

    SELECT
        'F_{\\Gamma_i}',
        'Trajektorienmerkmalsvektor',
        'Merkmalsvektor der i-ten Trajektorie.',
        '3.1442',
        1,
        0,
        0

    UNION ALL

    SELECT
        'Z_i',
        'Laufstatus',
        'Validierungs- und Interpretationsstatus des Laufs.',
        '3.1442',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\mathcal{D}',
        'Versuchsplan',
        'Menge untersuchter Parameterpunkte.',
        '3.1443',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\Pi_{\\mathrm{study}}',
        'Studienabbildung',
        'Abbildung von Versuchskombinationen auf Simulationsläufe.',
        '3.1445',
        0,
        0,
        1

    UNION ALL

    SELECT
        'G_{\\Theta_j}',
        'Wiederholungsgruppe',
        'Laufgruppe zu einem Parameterpunkt.',
        '3.1450',
        0,
        0,
        0

    UNION ALL

    SELECT
        'I_{\\mathrm{complete}}',
        'Vollständigkeitsindex',
        'Anteil abgeschlossener Läufe.',
        '3.1456',
        0,
        0,
        0

    UNION ALL

    SELECT
        'I_{\\mathrm{valid}}',
        'Validitätsindex',
        'Anteil valider Läufe.',
        '3.1459',
        0,
        0,
        0

    UNION ALL

    SELECT
        'Z_{\\mathrm{study}}',
        'Studienstatusvektor',
        'Zusammengefasster Studienstatus.',
        '3.1460',
        1,
        0,
        0

    UNION ALL

    SELECT
        'I_{\\mathrm{coverage}}',
        'Abdeckungsindex',
        'Abdeckung des Parameterraums.',
        '3.1461',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\overline{F}_{\\Gamma}',
        'Mittlerer Merkmalsvektor',
        'Mittelwert der Trajektorienmerkmale.',
        '3.1463',
        1,
        0,
        0

    UNION ALL

    SELECT
        '\\Sigma_F',
        'Merkmalskovarianzmatrix',
        'Kovarianzmatrix der Trajektorienmerkmale.',
        '3.1464',
        0,
        0,
        0

    UNION ALL

    SELECT
        'I_{\\mathrm{reprod}}',
        'Reproduzierbarkeitsindex',
        'Mittlere Reproduzierbarkeit der Studie.',
        '3.1475',
        0,
        0,
        0

    UNION ALL

    SELECT
        'E_{\\mathrm{study}}',
        'Studienergebnisobjekt',
        'Zusammengeführtes Ergebnis der Studie.',
        '3.1476',
        0,
        0,
        0

    UNION ALL

    SELECT
        'z_{\\mathrm{release}}',
        'Freigabestatus',
        'Binärer Status der Studienfreigabe.',
        '3.1481',
        0,
        0,
        0
) x
WHERE @section_id IS NOT NULL
AND @revision_id IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM symbols s
    WHERE s.symbol_latex = x.symbol_latex
      AND s.scope_type = 'section'
      AND s.first_section_id = @section_id
);

/* 6. Gleichung-Symbol-Verknüpfungen */

INSERT INTO equation_symbols
(
    equation_id, symbol_latex, symbol_name, definition_text,
    unit_text, domain_text, symbol_order
)
SELECT
    e.equation_id,
    x.symbol_latex,
    x.symbol_name,
    x.definition_text,
    NULL,
    NULL,
    1
FROM
(
    SELECT
        '\\mathcal{S}_{\\mathrm{sim}}' AS symbol_latex,
        'Simulationsstudie' AS symbol_name,
        'Menge aller Simulationsläufe einer Studie.' AS definition_text,
        '3.1441' AS first_equation_number,
        0 AS is_vector,
        0 AS is_matrix,
        0 AS is_operator

    UNION ALL

    SELECT
        '\\mathcal{R}_i',
        'Simulationslauf',
        'Vollständig beschriebenes Laufobjekt.',
        '3.1441',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\Theta_i',
        'Parametervektor des Laufs',
        'Parametrisierung des i-ten Laufs.',
        '3.1442',
        1,
        0,
        0

    UNION ALL

    SELECT
        'S_{0,i}',
        'Anfangszustand',
        'Anfangszustand des i-ten Laufs.',
        '3.1442',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\mathcal{O}_i',
        'Operatorenkonfiguration',
        'Operatorenkonfiguration des i-ten Laufs.',
        '3.1442',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\xi_i',
        'Zufallszustand',
        'Seed beziehungsweise Zufallszustand des i-ten Laufs.',
        '3.1442',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\Gamma_i',
        'Simulationstrajektorie',
        'Trajektorie des i-ten Laufs.',
        '3.1442',
        0,
        0,
        0

    UNION ALL

    SELECT
        'F_{\\Gamma_i}',
        'Trajektorienmerkmalsvektor',
        'Merkmalsvektor der i-ten Trajektorie.',
        '3.1442',
        1,
        0,
        0

    UNION ALL

    SELECT
        'Z_i',
        'Laufstatus',
        'Validierungs- und Interpretationsstatus des Laufs.',
        '3.1442',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\mathcal{D}',
        'Versuchsplan',
        'Menge untersuchter Parameterpunkte.',
        '3.1443',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\Pi_{\\mathrm{study}}',
        'Studienabbildung',
        'Abbildung von Versuchskombinationen auf Simulationsläufe.',
        '3.1445',
        0,
        0,
        1

    UNION ALL

    SELECT
        'G_{\\Theta_j}',
        'Wiederholungsgruppe',
        'Laufgruppe zu einem Parameterpunkt.',
        '3.1450',
        0,
        0,
        0

    UNION ALL

    SELECT
        'I_{\\mathrm{complete}}',
        'Vollständigkeitsindex',
        'Anteil abgeschlossener Läufe.',
        '3.1456',
        0,
        0,
        0

    UNION ALL

    SELECT
        'I_{\\mathrm{valid}}',
        'Validitätsindex',
        'Anteil valider Läufe.',
        '3.1459',
        0,
        0,
        0

    UNION ALL

    SELECT
        'Z_{\\mathrm{study}}',
        'Studienstatusvektor',
        'Zusammengefasster Studienstatus.',
        '3.1460',
        1,
        0,
        0

    UNION ALL

    SELECT
        'I_{\\mathrm{coverage}}',
        'Abdeckungsindex',
        'Abdeckung des Parameterraums.',
        '3.1461',
        0,
        0,
        0

    UNION ALL

    SELECT
        '\\overline{F}_{\\Gamma}',
        'Mittlerer Merkmalsvektor',
        'Mittelwert der Trajektorienmerkmale.',
        '3.1463',
        1,
        0,
        0

    UNION ALL

    SELECT
        '\\Sigma_F',
        'Merkmalskovarianzmatrix',
        'Kovarianzmatrix der Trajektorienmerkmale.',
        '3.1464',
        0,
        0,
        0

    UNION ALL

    SELECT
        'I_{\\mathrm{reprod}}',
        'Reproduzierbarkeitsindex',
        'Mittlere Reproduzierbarkeit der Studie.',
        '3.1475',
        0,
        0,
        0

    UNION ALL

    SELECT
        'E_{\\mathrm{study}}',
        'Studienergebnisobjekt',
        'Zusammengeführtes Ergebnis der Studie.',
        '3.1476',
        0,
        0,
        0

    UNION ALL

    SELECT
        'z_{\\mathrm{release}}',
        'Freigabestatus',
        'Binärer Status der Studienfreigabe.',
        '3.1481',
        0,
        0,
        0
) x
INNER JOIN equations e
    ON e.equation_number = x.first_equation_number
WHERE NOT EXISTS
(
    SELECT 1
    FROM equation_symbols es
    WHERE es.equation_id = e.equation_id
      AND es.symbol_latex = x.symbol_latex
);

/* 7. Änderungsprotokoll */

INSERT INTO section_change_log
(
    revision_id, section_id, change_type, object_type,
    object_reference, change_summary, previous_value,
    new_value, changed_at
)
SELECT
    @revision_id,
    @section_id,
    x.change_type,
    x.object_type,
    x.object_reference,
    x.change_summary,
    x.previous_value,
    x.new_value,
    NOW()
FROM
(
    SELECT
        'created' AS change_type,
        'section' AS object_type,
        '3.8.11' AS object_reference,
        'Abschnitt 3.8.11 wurde angelegt.' AS change_summary,
        NULL AS previous_value,
        'draft' AS new_value

    UNION ALL

    SELECT
        'definition_added',
        'definitions',
        '3.8.11.1-3.8.11.12',
        'Zwölf Definitionen wurden registriert.',
        NULL,
        '12 definitions'

    UNION ALL

    SELECT
        'equation_added',
        'equations',
        '3.1441-3.1482',
        'Zweiundvierzig Gleichungen wurden registriert.',
        'last_equation=3.1440',
        'last_equation=3.1482'

    UNION ALL

    SELECT
        'symbol_added',
        'symbols',
        '3.8.11',
        'Abschnittssymbole und Gleichungsverwendungen wurden registriert.',
        NULL,
        '21 section symbols'
) x
WHERE @revision_id IS NOT NULL
AND @section_id IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM section_change_log scl
    WHERE scl.revision_id = @revision_id
      AND scl.section_id = @section_id
      AND scl.change_type = x.change_type
      AND COALESCE(scl.object_reference,'') = COALESCE(x.object_reference,'')
);

/* 8. Abschlussaudit */

SET @definition_count := (
    SELECT COUNT(*)
    FROM definitions
    WHERE section_id = @section_id
      AND definition_number IN
      (
          '3.8.11.1','3.8.11.2','3.8.11.3','3.8.11.4',
          '3.8.11.5','3.8.11.6','3.8.11.7','3.8.11.8',
          '3.8.11.9','3.8.11.10','3.8.11.11','3.8.11.12'
      )
);

SET @equation_count := (
    SELECT COUNT(*)
    FROM equations
    WHERE section_id = @section_id
      AND equation_number BETWEEN '3.1441' AND '3.1482'
);

SET @symbol_count := (
    SELECT COUNT(*)
    FROM symbols
    WHERE first_section_id = @section_id
      AND scope_type = 'section'
);

SET @equation_symbol_count := (
    SELECT COUNT(*)
    FROM equation_symbols es
    INNER JOIN equations e
        ON e.equation_id = es.equation_id
    WHERE e.section_id = @section_id
);

SET @audit_ok := (
       @parent_section_id IS NOT NULL
   AND @revision_id IS NOT NULL
   AND @section_id IS NOT NULL
   AND @definition_count = 12
   AND @equation_count = 42
   AND @symbol_count >= 21
   AND @equation_symbol_count >= 21
);

COMMIT;

SELECT
    @audit_ok AS audit_ok,
    @revision_id AS revision_id,
    @section_id AS section_id,
    @definition_count AS definition_count,
    @equation_count AS equation_count,
    @symbol_count AS symbol_count,
    @equation_symbol_count AS equation_symbol_count,
    CASE
        WHEN @audit_ok = 1
        THEN 'Kapitel 3.8.11 wurde vollständig und MariaDB-kompatibel importiert.'
        ELSE 'FEHLER: Abschnitt 3.8.11 ist unvollständig. Auditwerte prüfen.'
    END AS audit_message;

SELECT
    definition_number,
    title,
    validation_status
FROM definitions
WHERE section_id = @section_id
ORDER BY definition_number;

SELECT
    equation_number,
    title,
    validation_status
FROM equations
WHERE section_id = @section_id
ORDER BY CAST(SUBSTRING_INDEX(equation_number,'.',-1) AS UNSIGNED);
