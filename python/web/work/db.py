import sqlite3
conn = sqlite3.connect('Escuelas.db', check_same_thread=False)
conn.row_factory = sqlite3.Row

def baseescuelas():
    sql = 'select Jurisdiccion,Sector,Ambito,Departamento,Codigo de departamento,Localidad,Codigo de localidad,Cueanexo,Nombre,Domicilio,codpos,Telefono,Mail from BaseEscuela'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def baseescuela(id):
    sql = 'select Jurisdiccion,Sector,Ambito,Departamento,Codigo de departamento,Localidad,Codigo de localidad,Cueanexo,Nombre,Domicilio,codpos,Telefono,Mail from BaseEscuela where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def sectorxs():
    sql = 'select id,nombre from Sector'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def sector(id):
    sql = 'select id,nombre from Sector where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def ambitos():
    sql = 'select id,nombre from Ambito'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def ambito(id):
    sql = 'select id,nombre from Ambito where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def provincias():
    sql = 'select id,nombre from Provincia'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def provincia(id):
    sql = 'select id,nombre from Provincia where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def departamentos():
    sql = 'select id,provinciaid,nombre from Departamento'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def departamento(id):
    sql = 'select id,provinciaid,nombre from Departamento where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def localidadxs():
    sql = 'select id,departamentoid,nombre from Localidad'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def localidad(id):
    sql = 'select id,departamentoid,nombre from Localidad where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def escuelas():
    sql = 'select id,nombre,cueanexo,domicilio,codpos,telefono,email,sectorid,ambitoid,provinciaid,departamentoid,localidadid from Escuela'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def escuela(id):
    sql = 'select id,nombre,cueanexo,domicilio,codpos,telefono,email,sectorid,ambitoid,provinciaid,departamentoid,localidadid from Escuela where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()
