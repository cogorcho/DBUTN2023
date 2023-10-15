# API REST con Flask para Escuelas

Crearemos una API REST para acceder a la data de la 
base de datos de escuelas.

Para eso, creamos una nueva carpeta a elección donde copiamos
el archivo Escuelas.db y abrimos una consola CMD en
ese directorio. En mi caso, la carpeta nueva se llama **Escuelas**.

Al hacer DIR deberíamos ver el archivo **Escuelas.db** que copiamos antes.
## Virtualización
Para proyectos con **python** se recomienda la virtualización del entorno
de desarrollo. Esto facilita entre otras cosas la portabilidad del proyecto
desarrollado.

Para virtualizar el entorno, estando en la consola CMD y dentro de la carpeta
**Escuelas** ejecutamos el siguiente comando:
```
    python3 -m venv venv
```
Si python3 no existe probar así:
```
    python -m venv venv
```
Si todo termina bien, en la consola ejecutamos **DIR** y veremos que se ha creado
un directorio **venv**. 

Para finalmente virtualizar el entorno, ejecutamos el siguiente comando:
- En CMD:
```
    venv\Scrtips\activate.bat
```
- En linux:
```
    source venv/bin/activate
```
Veremos que el prompt de la consola cambió anteponiendo **(venv)** 
al path donde estamos ubicados.

## Instalación de flask
En la consola CMD ejecutar:
```
    pip install flask
```
Verificación:
Abrir una sesion python ejecutando el comando **python**.\
Si no funciona probar con **python3**.\
Debería verse algo asi:
```
    Python 3.8.10 (default, May 26 2023, 14:05:08) 
    [GCC 9.4.0] on linux 
    Type "help", "copyright", "credits" or "license" for more information.
    >>> (Aqui es donde le enviamos comandos a python)

    >>> from flask import Flask    
    >>>
```
Si pasa esto, quiere decir que pudo importar Flask y todo anda Ok.

seguimos...

## Creacion del package db para acceder a la base de datos.

En la consola CMD, estando en el directorio Escuelas tipeamos:
```
    mkdir db
```
Nos metemos en ese nuevo directorio:
```
    cd db
```
Y aqui creamos un archivo llamado ```__init__.py``` con nuestro editor de 
texto favorito. :)
Recomiendo VSCode.

Mas info sobre packages en python [aqui](https://www.learnpython.org/es/Modules%20and%20Packages)

----
## Contenido del archivo __init__.py

Este módulo contiene las funciones de acceso a la base de datos.
```
import sqlite3

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
        on p.id = e.provincia
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
```
----
## Contenido del archivo app.py
Este es el módulo que utiliza **flask** y facilita los **endpoints** o **rutas**
 de acceso a los datos.

Los datos devueltos estan en formato **json**
```
from flask import Flask
import db

app = Flask(__name__)

@app.route('/provincia/<id>')
def provincia(id):
    return dict(db.provincia(id))

@app.route('/')
@app.route('/provincias')
def provincias():
    return dict(db.provincias())

@app.route('/departamento/<id>')
def departamento(id):
    return dict(db.departamento(id))

@app.route('/departamento/provincia/<id>')
def departamentos_x_provincia(id):
    return [dict(row) for row in db.departamentos_x_provincia(id)]

@app.route('/localidad/<id>')
def localidad(id):
    return [dict(row) for row in db.localidad(id)]

@app.route('/localidad/departamento/<id>')
def localidades_x_departamento(id):
    return [dict(row) for row in db.localidades_x_departamento(id)]

@app.route('/localidad/provincia/<id>')
def localidades_x_provincia(id):
    return [dict(row) for row in db.localidades_x_provincia(id)]

@app.route('/sectores')
def sectores():
    return dict(db.sectores())

@app.route('/sector/<id>')
def sector(id):
    return dict(db.sector(id))

@app.route('/ambitos')
def ambitos():
    return dict(db.ambitos())

@app.route('/ambito/<id>')
def ambito(id):
    return dict(db.ambito(id))

@app.route('/escuela/<id>')
def escuela(id):
    return dict(db.escuela(id))

@app.route('/escuelas/localidad/<id>')
def escuelas_x_localidad(id):
    return [dict(row) for row in db.escuelas_x_localidad(id)]

@app.route('/escuelas/provincia/<id>')
def escuelas_x_provincia(id):
    return [dict(row) for row in db.escuelas_x_provincia(id)]

```
