import mysql.connector

# 🔐 Verbindung zur Datenbank herstellen
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="datenanalyse"
)

cursor = conn.cursor()

# 📋 Alle relevanten Tabellen (ohne tmp* und ue*)
cursor.execute("""
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'datenanalyse'
      AND table_name NOT LIKE 'tmp_%'
      AND table_name NOT LIKE 'ue_%';
""")
alle_tabellen = {row[0] for row in cursor.fetchall()}

# 🔗 Alle Tabellen, die durch FOREIGN KEYs referenziert werden
cursor.execute("""
    SELECT DISTINCT referenced_table_name
    FROM information_schema.key_column_usage
    WHERE table_schema = 'datenanalyse'
      AND referenced_table_name IS NOT NULL;
""")
verknuepfte_tabellen = {row[0] for row in cursor.fetchall()}

# ❗ Nicht verknüpfte Tabellen
nicht_verknuepfte = alle_tabellen - verknuepfte_tabellen

# 🖨️ Ausgabe
print("Nicht verknüpfte Tabellen:")
for t in sorted(nicht_verknuepfte):
    print(" -", t)

cursor.close()
conn.close()
