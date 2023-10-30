import sqlite3

conn = sqlite3.connect('Master.db', check_same_thread=False)
conn.row_factory = sqlite3.Row

def tablas():
    sql = "select name from sqlite_master where type = 'table' and name != 'sqlite_sequence'"
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()


def columnas(tabla):
    sql = """
        SELECT m.name as table_name,
        p.cid as colid, p.name as colname, p.type as coltype, p.'notnull' as colnul, 
        p.dflt_value as coldef, p.pk as colpk
        FROM sqlite_master AS m
        JOIN pragma_table_info(m.name) AS p
        WHERE m.type = 'table' 
          AND m.name = ?
        ORDER BY m.name, p.cid
    """
    cursor = conn.cursor()
    res = cursor.execute(sql, (tabla['name'],))
    return res.fetchall()

def genDB(tablas):
    print("genDb")
    with open('work/db.py', 'w') as f:
        f.write("import sqlite3\n")
        f.write("conn = sqlite3.connect('Escuelas.db', check_same_thread=False)\n")
        f.write("conn.row_factory = sqlite3.Row\n")

        for t in tablas:
            tabla = dict(t)['name']
            if tabla[-1] in 'aeiou':
                f.write(f"\ndef {tabla.lower()+'s'}():\n")
                f.write(f"    sql = 'select {','.join([dict(c)['colname'] for c in columnas(t)])} from {tabla}'\n")
                f.write("    cursor = conn.cursor()\n")
                f.write("    res = cursor.execute(sql)\n")
                f.write("    return res.fetchall()\n")
            else:
                f.write(f"\ndef {tabla.lower()+'xs'}():\n")
                f.write(f"    sql = 'select {','.join([dict(c)['colname'] for c in columnas(t)])} from {tabla}'\n")
                f.write("    cursor = conn.cursor()\n")
                f.write("    res = cursor.execute(sql)\n")
                f.write("    return res.fetchall()\n")

            f.write(f"\ndef {tabla.lower()}(id):\n") 
            f.write(f"    sql = 'select {','.join([dict(c)['colname'] for c in columnas(t)])} from {tabla} where id = ?'\n")
            f.write("    cursor = conn.cursor()\n")
            f.write("    res = cursor.execute(sql, (id,))\n")
            f.write("    return res.fetchone()\n")

def gen():
    genDB(tablas())
