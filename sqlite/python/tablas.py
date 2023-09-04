import sqlite3 
import json

sql = """
SELECT
p.cid AS col_id,
p.name AS col_name,
p.type AS col_type,
p.pk AS col_is_pk,
p.dflt_value AS col_default_val,
p.[notnull] AS col_is_not_null
FROM sqlite_master m
LEFT OUTER JOIN pragma_table_info((m.name)) p
ON m.name <> p.name
WHERE m.type = 'table'
AND m.name = '{tabla}'
ORDER BY col_id
"""

con = sqlite3.connect("../escuelas.sqlite")
clases = list()

class Tabla:
    def __init__(self, tabla, columnas, fks):
        self.tabla = tabla
        self.columnas = columnas
        self.fks = fks

    def __repr__(self):
        s = """
        -----------------------------------------------------
        -- Tabla: {tabla}
        -----------------------------------------------------
        -- Columnas:
        -----------------------------------------------------\n""".format(tabla=self.tabla)
        for col in self.columnas:
            for key in col.keys():
                s += f"\t\t{key}: {col[key]}\n"
            s += "\n"

        for fk in self.fks:
            #print(fk['table'], fk['from'], fk['to'])
            s += f"\t\tFK: Column {fk['from']} references {fk['table']}.{fk['to']}\n"
        return s

def getTablas():
    lista = list()
    cur = con.cursor()
    res = cur.execute("select name from sqlite_master where type = 'table' and name != 'sqlite_sequence'")
    rows = cur.fetchall()
    for row in rows:
        lista.append(row[0])
    cur.close()

    return lista

def header(xcur):
    lista = list()
    for row in xcur.description:
        lista.append(row[0])
    return lista


def getColumnas(ptabla):
    lista = list()
    cur = con.cursor()
    result = cur.execute(sql.format(tabla=ptabla))
    hcol = header(cur)
    for row in result.fetchall():
        lista.append(dict(zip(hcol,list(row))))
    cur.close()
    return lista

def getFKs(ptabla):
    lista = list()
    sql="select * from pragma_foreign_key_list('{tabla}')"
    cur = con.cursor()
    result = cur.execute(sql.format(tabla=ptabla))
    hcol = header(cur)
    for row in result.fetchall():
        lista.append(dict(zip(hcol,list(row))))
    return lista

def cargarTablas():
    clases = list()
    for tabla in getTablas():
        c = Tabla(tabla,getColumnas(tabla),getFKs(tabla))
        clases.append(c)
    return clases


for c in cargarTablas():
    print(c)
    print("#------------------------------------------")
    print(f"# Tabla {c.tabla} version json: ")
    print("#------------------------------------------")
    print(json.dumps(c.__dict__, indent=4))
