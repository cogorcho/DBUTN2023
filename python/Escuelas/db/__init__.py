import sqlite3

#conn = sqlite3.connect('Escuelas.db', check_same_thread=False)
conn = sqlite3.connect('Escuelas.db', check_same_thread=False)
conn.row_factory = sqlite3.Row

def provincias():
    sql = "select id, nombre from Provincia order by 1"
    cursor =  conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def provincia(id):
    sql = "select id, nombre from Provincia where id = ?"
    cursor =  conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def departamentos_x_provincia(pciaid):
    sql = "select id, nombre from departamento where provinciaid = ?"
    cursor = conn.cursor()
    res = cursor.execute(sql, (pciaid,))
    return res.fetchall()

def departamento(id):
    sql = "select id, nombre from Departamento where id = ?"
    cursor =  conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def localidades_x_departamento(deptoid):
    sql = "select id, nombre from localidad where departamentoid = ?"
    cursor = conn.cursor()
    res = cursor.execute(sql, (deptoid,))
    return res.fetchall()

def localidades_x_provincia(pciaid):
    sql = """select d.id as departamentoid, d.nombre as departamento,
    l.id as localidadid, l.nombre as localidadnombe 
    from localidad l
    inner join Departamento d
        on d.id = l.departamentoid
    inner join Provincia p
        on p.id = d.provinciaid
    where p.id = ?
    """
    cursor = conn.cursor()
    res = cursor.execute(sql, (pciaid,))
    return res.fetchall()

def localidad(locid):
    sql = """
        select id, nombre, departamentoid
        from Localidad
        where id = ?
    """
    cursor = conn.cursor()
    res = cursor.execute(sql, (locid,))
    return res.fetchall()

def escuela(id):
    sql = """
    select id, nombre, cueanexo, domicilio,
    codpos, telefono, email, sectorid,
    ambitoid, provinciaid, departamentoid, localidadid
    from Escuela
    where id = ?
    """
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def escuelas_x_localidad(locid):
    sql = """
    select e.id, e.nombre, e.cueanexo, e.domicilio,
    e.codpos, e.telefono, e.email, e.sectorid,
    e.ambitoid, e.provinciaid, e.departamentoid, e.localidadid
    from Escuela e
    inner join Localidad l
        on l.id = e.localidadid
    where l.id = ?
    """
    cursor = conn.cursor()
    res = cursor.execute(sql, (locid,))
    return res.fetchall()

def escuelas_x_provincia(pciaid):
    sql = """
    select e.id, e.nombre, e.cueanexo, e.domicilio,
    e.codpos, e.telefono, e.email, e.sectorid,
    e.ambitoid, e.provinciaid, e.departamentoid, e.localidadid
    from Escuela e
    inner join Provincia p
        on p.id = e.provinciaid
        and p.id = ?
    """
    cursor = conn.cursor()
    res = cursor.execute(sql, (pciaid,))
    return res.fetchall()

def sectores():
    sql = "select id, nombre from Sector order by nombre"
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def sector(id):
    sql = "select id, nombre from Sector where id = ?"
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def ambitos():
    sql = "select id, nombre from Ambito order by nombre"
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def ambito(id):
    sql = "select id, nombre from Ambito where id = ?"
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()
