import sqlite3

conn = sqlite3.connect('Escuelas.db', check_same_thread=False)
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


def genFORMS(tablas):
    print("genForm")
    with open('work/forms.py','w') as f:
        f.write("from flask_wtf import FlaskForm\n")
        f.write("from wtforms import StringField, SubmitField\n")
        f.write("from wtforms.validators import DataRequired\n")

        for x in tablas:
            f.write("\n# ----------------------------------\n")
            f.write(f"# Form para {x['name'].title()}\n")
            f.write("# ----------------------------------\n")
            f.write(f"class {x['name']}Form(FlaskForm):\n")
            for c in columnas(x):
                tipo = "StringField"
                nn = ""
                if c['colnul'] == 1:
                    nn = ", validators=[DataRequired()]"
                    
                f.write(f"    {c['colname'].replace(' ','_')} = {tipo}('{c['colname'].replace(' ','_').title()}'{nn})\n")
            f.write("    submit = SubmitField('Submit')\n")
    f.close()

def gen():
    genFORMS(tablas())
