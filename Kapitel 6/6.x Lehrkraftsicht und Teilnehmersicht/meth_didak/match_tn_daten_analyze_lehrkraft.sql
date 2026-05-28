SELECT
    mt.id AS teilnehmer_feedback_id,
    mt.ue_id AS teilnehmer_ue_id,
    mt.teilnehmer_id,
    mt.gruppe_id,
    mt.erfasst_am,
    CAST(mt.erfasst_am AS DATE) AS teilnehmer_datum,

    mt.mitarbeit,
    mt.absprachen,
    mt.selbststaendigkeit,
    mt.konzentration,
    mt.fleiss,
    mt.lernfortschritt,
    mt.beherrscht_thema,
    mt.transferdenken,
    mt.basiswissen,
    mt.vorbereitet,
    mt.themenauswahl,
    mt.materialien,
    mt.methodenvielfalt,
    mt.individualisierung,
    mt.aufforderung,
    mt.zielgruppen,
    mt.emotions,
    mt.bemerkungen,

    al.id_mtr_rueckkopplung_datenmaske,
    al.lehrkraft_id,
    al.datum,
    al.satzanzahl,

    al.mean_kognition,
    al.mean_sozial,
    al.mean_affektiv,
    al.mean_motivation,
    al.mean_methodik,
    al.mean_performanz,
    al.mean_regulation,

    al.var_kognition,
    al.var_sozial,
    al.var_affektiv,
    al.var_motivation,
    al.var_methodik,
    al.var_performanz,
    al.var_regulation,

    al.d_semantisch_mean,
    al.d_semantisch_std,
    al.semantische_breite,
    al.dominanz_breite,

    sdlg.id AS sdlg_id,
    sdlg.type AS sdlg_type,
    sdlg.ue_id AS sdlg_ue_id,

    sdlg.x_kognition,
    sdlg.x_sozial,
    sdlg.x_affektiv,
    sdlg.x_motivation,
    sdlg.x_methodik,
    sdlg.x_performanz,
    sdlg.x_regulation,

    sdlg.sum_kognition,
    sdlg.sum_sozial,
    sdlg.sum_affektiv,
    sdlg.sum_motivation,
    sdlg.sum_methodik,
    sdlg.sum_performanz,
    sdlg.sum_regulation,

    sdlg.h_kognition,
    sdlg.h_sozial,
    sdlg.h_affektiv,
    sdlg.h_motivation,
    sdlg.h_methodik,
    sdlg.h_performanz,
    sdlg.h_regulation,

    sdlg.token_anzahl,
    sdlg.funktionsklassen_anzahl_gesamt,
    sdlg.dominante_dimension,
    sdlg.dominante_dimension_wert,
    sdlg.polaritaet_gesamt,
    sdlg.d_semantisch,
    sdlg.created_at AS sdlg_created_at

FROM icas_19_4_2.mtr_rueckkopplung_teilnehmer mt

JOIN icas_19_4_2.analyze_lehrkraftdaten al
    ON al.teilnehmer_id = mt.teilnehmer_id
   AND al.datum = CAST(mt.erfasst_am AS DATE)

JOIN icas_19_4_2.frzk_semantische_dichte_lehrer_gesamt sdlg
    ON sdlg.id_mtr_rueckkopplung_datenmaske = al.id_mtr_rueckkopplung_datenmaske

ORDER BY
    mt.erfasst_am,
    mt.teilnehmer_id,
    sdlg.type;