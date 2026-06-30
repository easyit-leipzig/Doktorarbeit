import json
import mysql.connector
from decimal import Decimal
from datetime import date, datetime

DB = {
    "host": "127.0.0.1",
    "port": 3306,
    "user": "root",
    "password": "",
    "database": "icas_19_4_2",
    "charset": "utf8mb4",
    "connection_timeout": 5,
    "use_pure": True
}

OUTPUT_FILE = "06x05_nichtlinearitaet.json"


def json_converter(obj):
    if isinstance(obj, Decimal):
        return float(obj)
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    return str(obj)


def main():
    conn = mysql.connector.connect(**DB)
    cur = conn.cursor(dictionary=True)

    sql = """
    SELECT
        *
    FROM match_tn_daten_analyze_lehrkraft
    ORDER BY datum, teilnehmer_id, sdlg_type
    """

    cur.execute(sql)
    rows = cur.fetchall()

    result = {
        "auswertung": "6.x.5 Nichtlinearität der Zustandsdynamik",
        "beschreibung": "Export ohne Lehrkraftunterscheidung aus match_tn_daten_analyze_lehrkraft",
        "anzahl_datensaetze": len(rows),
        "records": rows
    }

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        json.dump(
            result,
            f,
            ensure_ascii=False,
            indent=2,
            default=json_converter
        )

    cur.close()
    conn.close()

    print(f"JSON erzeugt: {OUTPUT_FILE}")
    print(f"Datensätze: {len(rows)}")


if __name__ == "__main__":
    main()