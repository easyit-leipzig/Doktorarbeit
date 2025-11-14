import mysql.connector

# Verbindung zur Datenbank
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",        # 🔐 dein Passwort
    database="datenanalyse"
)

cursor = conn.cursor()

# Alle Tabellen, die mit "mtr_" beginnen (ohne tmp_ oder ue_)
cursor.execute("""
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'datenanalyse'
      AND table_name LIKE 'mtr_%';
""")
mtr_tables = [row[0] for row in cursor.fetchall()]

print("📊 Metrik-Tabellen und ihre Objekte:\n")

for table in mtr_tables:
    cursor.execute(f"SHOW COLUMNS FROM `{table}`")
    columns = cursor.fetchall()
    
    metric_fields = [col[0] for col in columns if col[0] not in ("id", "created_at", "updated_at")]
    
    print(f"🔹 {table}")
    for field in metric_fields:
        print(f"   └─ {field}")
    print()

cursor.close()
conn.close()

input("\n⏳ Drücke [Enter], um das Fenster zu schließen...")
#
 mtr_bak_didaktik_gruppe
   └─ name
   └─ beschreibung

🔹 mtr_didaktik
   └─ veranstaltungs_id
   └─ schueler_id
   └─ datum
   └─ themenauswahl_id
   └─ methodenvielfalt_id
   └─ individualisierung_id
   └─ aufforderung_id
   └─ materialien_id
   └─ zielgruppen_id

🔹 mtr_didaktik_gruppe
   └─ bezeichnung

🔹 mtr_didaktik_gruppe_zuordnung
   └─ gruppe_id
   └─ bezeichnung_id

🔹 mtr_emotion
   └─ beschreibung
   └─ erstellt_am

🔹 mtr_feedback
   └─ beschreibung
   └─ erstellt_am

🔹 mtr_kompetenz
   └─ beschreibung
   └─ erstellt_am

🔹 mtr_leistung
   └─ veranstaltungs_id
   └─ datum
   └─ lernfortschritt
   └─ beherrscht_thema
   └─ transferdenken
   └─ basiswissen
   └─ vorbereitet
   └─ verhaltensbeurteilung_code
   └─ reflexionshinweis

🔹 mtr_medien
   └─ beschreibung
   └─ erstellt_am

🔹 mtr_rueckkopplung_lehrkraft
   └─ unterrichts_id
   └─ lehrkraft_id
   └─ themenauswahl
   └─ materialien
   └─ methodenvielfalt
   └─ individualisierung
   └─ aufforderung
   └─ mitarbeit
   └─ absprachen
   └─ selbststaendigkeit
   └─ konzentration
   └─ fleiss
   └─ lernfortschritt
   └─ beherrscht_thema
   └─ transferdenken
   └─ basiswissen
   └─ vorbereitet
   └─ erfasst_am
   └─ themenauswahl_level_id
   └─ materialien_level_id
   └─ methodenvielfalt_level_id
   └─ individualisierung_level_id
   └─ aufforderung_level_id

🔹 mtr_rueckkopplung_teilnehmer
   └─ unterrichts_id
   └─ schueler_id
   └─ themenauswahl
   └─ materialien
   └─ methodenvielfalt
   └─ individualisierung
   └─ aufforderung
   └─ mitarbeit
   └─ absprachen
   └─ selbststaendigkeit
   └─ konzentration
   └─ fleiss
   └─ lernfortschritt
   └─ beherrscht_thema
   └─ transferdenken
   └─ basiswissen
   └─ vorbereitet
   └─ erfasst_am
   └─ themenauswahl_level_id
   └─ materialien_level_id
   └─ methodenvielfalt_level_id
   └─ individualisierung_level_id
   └─ aufforderung_level_id

🔹 mtr_sozial
   └─ veranstaltungs_id
   └─ datum
   └─ mitarbeit
   └─ absprachen
   └─ selbststaendigkeit
   └─ konzentration
   └─ fleiss

🔹 mtr_sozial_gruppe
   └─ name
   └─ beschreibung

🔹 mtr_sozial_gruppe_zuordnung
   └─ gruppe_id
   └─ bezeichnung_id

🔹 mtr_thema
   └─ beschreibung
   └─ erstellt_am
#