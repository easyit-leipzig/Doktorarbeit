import re
import mysql.connector
from datetime import datetime
import os

# DB-Zugang
DB_CONFIG = {
    "user": "root",
    "password": "",
    "host": "127.0.0.1",
    "database": "icas",
    "raise_on_warnings": True
}

CHIP_MAP = {
    "Absprachen einhaltend": "absprachen",
    "Absprachen nicht einhaltend": "absprachen_nicht_einhaltend",
    "beteiligt sich": "mitarbeit",
    "gute Mitarbeit": "mitarbeit",
    "fleißig": "fleissig",
    "bemüht": "fleissig",
    "arbeitet selbstständig": "selbststaendig",
    "vorbereitet": "vorbereitet",
    "konzentriert": "konzentriert",
    "unkonzentriert": "unkonzentriert",
    "Lernfortschritt erzielt": "lernfortschritt",
    "beherrscht Thema": "beherrscht_thema",
    "Transferdenken": "transferdenken",
    "fähig zu Transferdenken": "transferdenken",
    "Basiswissen vorhanden": "basiswissen",
    "benötigt Aufforderung": "benoetigt_aufforderung",
    "störend": "stoerend_blockierend_resignierend",
    "blockierend": "stoerend_blockierend_resignierend",
    "resignierend": "stoerend_blockierend_resignierend",
    "desinteressiert": "desinteressiert_gleichgueltig",
    "gleichgültig": "desinteressiert_gleichgueltig",
    "Materialien fehlen": "materialien_fehlen",
    "unpünktlich": "unpuenktlich",
    "Unverständnis": "unverstaendnis"
}
ALL_DB_FIELDS = list(CHIP_MAP.values())

def read_lines(path):
    with open(path, encoding="utf-8") as f:
        return f.read().replace('\r\n', '\n').replace('\r', '\n').split('\n')

def split_pages(lines):
    pages, page = [], []
    for line in lines:
        if line.strip() == "Wie sehen Sie Ihren Schüler add":
            continue
        if line.strip().startswith("Datum") and "Signatur" in line:
            page.append(line)
            pages.append(page)
            page = []
        else:
            page.append(line)
    return pages

def extract_blocks(lines):
    pos = [i for i, l in enumerate(lines) if re.match(r"^\d{2}\.\d{2}\.\d{2} .*geändert: \d{2}\.\d{2}\.\d{2}", l)]
    pos.append(len(lines))
    return [(pos[i], pos[i+1]) for i in range(len(pos)-1)]

def parse_datum(line):
    try:
        return datetime.strptime(line.strip().split(" ")[0], "%d.%m.%y").date()
    except:
        return None

def extract_participant(line):
    m = re.match(r"([\wäöüÄÖÜß]+)\s*,\s*([\wäöüÄÖÜß]+)\s+(\d+)\s+(\w+)\s+(Probeschüler|.*)", line.strip())
    if not m:
        return None
    return {
        "nachname": m.group(1),
        "vorname": m.group(2),
        "klassenstufe": m.group(3),
        "schultyp": m.group(4),
        "status": m.group(5),
        "besondere_hinweise": ""
    }

def get_or_create_tn_id(cursor, tn):
    cursor.execute("SELECT id FROM tmp_teilnehmer WHERE vorname=%s AND nachname=%s AND klassenstufe=%s AND schultyp=%s",
                   (tn["vorname"], tn["nachname"], tn["klassenstufe"], tn["schultyp"]))
    row = cursor.fetchone()
    if row:
        return row[0]
    cursor.execute("INSERT INTO tmp_teilnehmer (vorname, nachname, klassenstufe, schultyp, status, besondere_hinweise) VALUES (%s, %s, %s, %s, %s, %s)",
                   (tn["vorname"], tn["nachname"], tn["klassenstufe"], tn["schultyp"], tn["status"], tn["besondere_hinweise"]))
    return cursor.lastrowid

def extract_thema(lines, start):
    for i in range(start+1, len(lines)):
        if lines[i].strip():
            return lines[i].strip()
    return "Thema unbekannt"

def extract_freitext(lines, start, thema):
    text = []
    for i in range(start+1, len(lines)):
        if "Chips container" in lines[i]:
            break
        text.append(lines[i])
    joined = "\n".join(text).strip()
    return joined[len(thema):].strip() if joined.startswith(thema) else joined

def extract_flags(lines):
    flags = {k: 0 for k in ALL_DB_FIELDS}
    for line in lines:
        for chip, feld in CHIP_MAP.items():
            if chip.lower() in line.lower():
                flags[feld] = 1
    return flags

def has_chip(lines):
    for line in lines:
        for chip in CHIP_MAP:
            if chip.lower() in line.lower():
                return True
    return False

def is_datum(text):
    return re.match(r"\d{2}\.\d{2}\.\d{2}", text.strip())

def find_valid_fach(block):
    for i, line in enumerate(block):
        if "person group" in line.lower():
            this_line = line.strip()
            next_line = block[i+1].strip() if i+1 < len(block) else ""
            if is_datum(this_line) or is_datum(next_line):
                continue
            return (this_line.replace("person group", "").strip() + "\n" + next_line).strip()[:100]
    return None

def insert_ue(cursor, tn_id, datum, wochentag, fach, lehrkraft, thema, inhalt, freitext, flags):
    sql = f"""INSERT INTO tmp_unterrichtseinheiten (tn_id, datum, wochentag, fach, lehrkraft, thema, inhalt, freitext, {", ".join(flags)})
              VALUES (%s, %s, %s, %s, %s, %s, %s, %s, {", ".join(["%s"] * len(flags))})"""
    cursor.execute(sql, (tn_id, datum, wochentag, fach, lehrkraft, thema, inhalt, freitext, *[flags[k] for k in flags]))

def main():
    path = input("Pfad zur Rohdatei (z. B. Noah_roh.txt): ").strip()
    manu = input("tn_id manuell eingeben? (j/n): ").strip().lower() == "j"
    tn_id_fix = int(input("tn_id: ")) if manu else None
    base = os.path.splitext(os.path.basename(path))[0]
    debug_path = os.path.join(os.path.dirname(path), f"{base}_debug.txt")
    debug = []

    lines = read_lines(path)
    if not lines:
        print("[FEHLER] Keine Zeilen gelesen – Datei leer oder nicht gefunden.")
        input("⏎ Drücken zum Beenden...")
        return

    pages = split_pages(lines)
    conn = mysql.connector.connect(**DB_CONFIG)
    cur = conn.cursor()
    count, skipped = 0, 0

    for seite, page in enumerate(pages, 1):
        if not page: continue
        tn_id = tn_id_fix
        if not manu:
            tn = extract_participant(page[0])
            if not tn:
                debug.append(f"[Seite {seite}] Teilnehmer nicht erkannt:\n" + "\n".join(page))
                continue
            tn_id = get_or_create_tn_id(cur, tn)

        for start, end in extract_blocks(page):
            block = page[start:end]
            fach = find_valid_fach(block)
            datum = parse_datum(block[0])
            if not datum:
                debug.append(f"[Seite {seite}] Ungültiges Datum:\n" + "\n".join(block))
                skipped += 1
                continue

            wochentag = datum.weekday()
            lehrkraft = block[0][9:].strip() if len(block[0]) >= 9 else block[0]
            lehrkraft = re.sub(r"- geändert.*", "", lehrkraft).strip()
            thema_zeile = extract_thema(block, 0)
            if ":" in thema_zeile:
                parts = thema_zeile.split(":", 1)
                thema = parts[0].strip()
                inhalt = parts[1].strip()
            else:
                thema = thema_zeile
                inhalt = ""
            freitext = extract_freitext(block, 0, thema_zeile)
            flags = extract_flags(block)

            if not fach and not has_chip(block):
                debug.append(f"[Seite {seite}] Kein Fach & keine Chips:\n" + "\n".join(block))
                skipped += 1
                continue

            try:
                insert_ue(cur, tn_id, datum, wochentag, fach, lehrkraft, thema, inhalt, freitext, flags)
                count += 1
                print(f"[{count:03}] {datum} – {thema} – {lehrkraft} – Fach: {fach or 'NULL'}")
            except Exception as e:
                debug.append(f"[Seite {seite}] DB FEHLER {str(e)}:\n" + "\n".join(block))
                skipped += 1

    conn.commit()
    cur.close()
    conn.close()

    with open(debug_path, "w", encoding="utf-8") as f:
        if debug:
            f.write("\n\n".join(debug))
        else:
            f.write("Alle Einträge wurden übernommen.\n")

    print(f"\n[✓] {count} Unterrichtseinheiten gespeichert.")
    print(f"[⚠] {skipped} Einträge übersprungen – Details in: {debug_path}")
    input("⏎ Drücken zum Beenden...")

if __name__ == "__main__":
    main()