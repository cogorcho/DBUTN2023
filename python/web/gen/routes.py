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

def genROUTES(tablas):
    print("genRoutes")
    with open('work/routes.py','w') as f:
        f.write("from flask import Flask, render_template\n")
        f.write(f"from forms import ({','.join([ dict(x)['name']+'Form' for x in tablas])})\n")
        f.write("from flask_bootstrap import Bootstrap\n")
        f.write("app = Flask(__name__)\n")
        f.write("app.config['SECRET_KEY'] = 'hard to guess string'\n")
        f.write("bootstrap = Bootstrap(app)\n")
        
        for x in tablas:
            tabla = dict(x)['name']
            f.write(f"@app.route('/{tabla.lower()}', methods=['GET', 'POST'])\n")
            f.write(f"def {tabla.lower()}():\n")
            f.write(f"    name = '{tabla.title()}'\n")
            f.write(f"    form = {tabla}Form()\n")
            f.write("    if form.validate_on_submit():\n")
            for c in columnas(x):
                f.write(f"         {c['colname'].lower().replace(' ','_')} = form.data.{c['colname'].replace(' ','_').lower()}\n")
            f.write(f"    return render_template('index.html', form=form, name=name)\n\n")
    f.close()        
    

def gen():
    genROUTES(tablas())
