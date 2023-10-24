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


def fks(tabla):
    sql = f"select * from pragma_foreign_key_list('{tabla}')"
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def uniq(tabla):
    sql = """
    SELECT m.name table_name,
        p.*
    FROM sqlite_master AS m
    JOIN pragma_index_list(m.name) AS l
    JOIN pragma_index_info(l.name) AS p
    where l.origin = 'c'
    and l."unique" = 1
    and table_name = ?
    """
    cursor = conn.cursor()
    res = cursor.execute(sql, (tabla,))
    return res.fetchall()

def genORM(tablas):
    print("genOrm")
    with open('work/orm.py','w') as f:
        f.write("import os\n")
        f.write("from flask_sqlalchemy import SQLAlchemy\n")
        f.write("from flask import Flask\n")
        f.write("basedir = os.path.abspath(os.path.dirname(__file__))\n")
        f.write("\napp = Flask(__name__)\n")
        f.write("app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'data.sqlite')\n")
        f.write("app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False\n")
        f.write("\ndb = SQLAlchemy(app)\n")
    
        for x in tablas:
            tabla=x['name']
            f.write("# ---------------------------------------------------\n")
            f.write(f"#   {x['name'].title()}\n")
            f.write("# ---------------------------------------------------\n")
            f.write(f"class {x['name'].title()}(db.Model):\n")
            f.write(f"    __tablename__ = '{x['name'].title()}'\n\n")
        
            cols = columnas(x)
            fkeys = [ dict(k) for k in fks(tabla)]
            uniques0 = [ dict(h)['name'] for h in uniq(tabla)]
            uniques = None
            if len(uniques0) > 0:
                uniques1 = ','.join(uniques0)
                uniques2 = uniques1.replace(",","','")
                uniques = f"db.UniqueConstraint({uniques2})".replace("(","('").replace(")",f"', name='uix_{tabla}')")
            else:
                uniques = ""
        
            for col in [dict(c) for c in cols]:
                flen = col['coltype'][col['coltype'].find("(")+1:col['coltype'].find(")")]
                pk = ""
                if col['colpk'] ==  1:
                    pk = ", primary_key=True"
        
                tipo = ""
                if "varchar" in col['coltype']:
                    tipo = f"db.String({flen})"
                else:
                    tipo= f"db.{col['coltype'].title()}"
        
                nn = ""
                if col['colnul'] == 1:
                    nn = ", nullable=False"
        
                fk = [ {'tabla': x['table'], 'columna': x['to']} for x in fkeys if x['from'] == col['colname']]
                fkrec = ""
                for z in fk:
                    fkrec = f", db.ForeignKey(\'{z['tabla']}.{z['columna']}\')"
        
                f.write(f"    {col['colname'].lower().replace(' ','_')} = db.Column({tipo}{fkrec}{nn}{pk})\n")

            if uniques != "":
                f.write(f"    __table_args__ = ({uniques},)\n")

            f.write("\n    def __repr__(self):\n")
            f.write('        return f"""\n')
            for col in [dict(c) for c in cols]:
                f.write(f"            <{col['colname'].lower().replace(' ','_')}: {{self.{col['colname'].lower().replace(' ','_')}}}>\n")
            f.write('        """\n')
    f.close()

def gen():
    genORM(tablas())
