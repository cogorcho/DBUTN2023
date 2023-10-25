 # El diccionario de datos

 ## Aplicaciones

Usando sqlite y su diccionario de datos, aprovechamos
su contenido para automatizar la creación de:
- La base de datos en otra plataforma
- Forms para cada tabla
- Acceso a todas las filas o una por id de cada tabla
- Rutas para acceso vis flask

Se proveen los siguientes archivos:
- Escuelas.db (la base de datos sqlite normalizada)
- genall.py (script que llama al resto)
- Package gen con los scripts para crear todo.

Scripts en el directorio **gen**:
- **db.py**: Genera las funciones de acceso a la DB
- **orm.py**: Genera el código  **SQLAlchemy** que conectados a cualquier 
motor de bases de datos (mysql,postresql, sqlserver, oracle) creará todas
las tablas con sus respectivas constraints e índices.
- **forms.py**: Genera forms HTML usando flasl-wtf
- **routes.py**: Genera las rutas para acceder a los datos


# Práctica:
1. Bajar el repo, entrar a la carpeta, virtualizar y activar la virtualización.
2. Ejecutar **python genall.sh**
3. En el directorio **work**, abrir los scripts generados.

# Análisis:

El archivo generado **orm.py** tiene lo necesaria para crear todos los
objetos de nuestra base origen **(Escuelas.db)**.
Para ejecutarlo en otro motor de DB distinto de **sqlite** hay q cambiar la
cadena de conexión.

Antes de crear la base de datos destino en **mysql o sql server** (basada en Escuelas.db), hay q hacer lo siguiente:
- Con el entorno virtualizado, cd a work
- pip install pymsql (para mysql)
- pip install pyodbc (para sql server)
- Descomentar las lineas necesarias

## orm.py
```
import os
from flask_sqlalchemy import SQLAlchemy
from flask import Flask
basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)

# ----------------------------------------
# Para sqlite, descomentar estas 2 lineas
# ----------------------------------------
#app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'data.sqlite')
#app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# ----------------------------------------
# Para mysql, descomentar esta linea
# reemplazando lo que sea necesario.
# ----------------------------------------
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Soler225@localhost/test'


MSSQLengine = sqlalchemy.create_engine('mssql+pyodbc://localhost\\master/Test/?driver=SQL+Server+Native+Client+17.0')

db = SQLAlchemy(app)
# ---------------------------------------------------
#   Baseescuela
# ---------------------------------------------------
class Baseescuela(db.Model):
    __tablename__ = 'Baseescuela'

    jurisdiccion = db.Column(db.Text)
    sector = db.Column(db.Text)
    ambito = db.Column(db.Text)
    departamento = db.Column(db.Text)
    codigo_de_departamento = db.Column(db.Text)
    localidad = db.Column(db.Text)
    codigo_de_localidad = db.Column(db.Text)
    cueanexo = db.Column(db.Text)
    nombre = db.Column(db.Text)
    domicilio = db.Column(db.Text)
    codpos = db.Column(db.Text)
    telefono = db.Column(db.Text)
    mail = db.Column(db.Text)

    def __repr__(self):
        return f"""
            <jurisdiccion: {self.jurisdiccion}>
            <sector: {self.sector}>
            <ambito: {self.ambito}>
            <departamento: {self.departamento}>
            <codigo_de_departamento: {self.codigo_de_departamento}>
            <localidad: {self.localidad}>
            <codigo_de_localidad: {self.codigo_de_localidad}>
            <cueanexo: {self.cueanexo}>
            <nombre: {self.nombre}>
            <domicilio: {self.domicilio}>
            <codpos: {self.codpos}>
            <telefono: {self.telefono}>
            <mail: {self.mail}>
        """
# ---------------------------------------------------
#   Sector
# ---------------------------------------------------
class Sector(db.Model):
    __tablename__ = 'Sector'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(128), nullable=False)
    __table_args__ = (db.UniqueConstraint('nombre', name='uix_Sector'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Ambito
# ---------------------------------------------------
class Ambito(db.Model):
    __tablename__ = 'Ambito'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(128), nullable=False)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Provincia
# ---------------------------------------------------
class Provincia(db.Model):
    __tablename__ = 'Provincia'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(128), nullable=False)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Departamento
# ---------------------------------------------------
class Departamento(db.Model):
    __tablename__ = 'Departamento'

    id = db.Column(db.Integer, primary_key=True)
    provinciaid = db.Column(db.Integer, db.ForeignKey('Provincia.id'), nullable=False)
    nombre = db.Column(db.String(128), nullable=False)
    __table_args__ = (db.UniqueConstraint('provinciaid','nombre', name='uix_Departamento'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <provinciaid: {self.provinciaid}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Localidad
# ---------------------------------------------------
class Localidad(db.Model):
    __tablename__ = 'Localidad'

    id = db.Column(db.Integer, primary_key=True)
    departamentoid = db.Column(db.Integer, db.ForeignKey('Departamento.id'), nullable=False)
    nombre = db.Column(db.String(512), nullable=False)
    __table_args__ = (db.UniqueConstraint('departamentoid','nombre', name='uix_Localidad'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <departamentoid: {self.departamentoid}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Escuela
# ---------------------------------------------------
class Escuela(db.Model):
    __tablename__ = 'Escuela'

    id = db.Column(db.Integer, nullable=False, primary_key=True)
    nombre = db.Column(db.String(512), nullable=False)
    cueanexo = db.Column(db.String(32), nullable=False)
    domicilio = db.Column(db.String(2048), nullable=False)
    codpos = db.Column(db.String(15))
    telefono = db.Column(db.String(64))
    email = db.Column(db.String(1024))
    sectorid = db.Column(db.Integer, db.ForeignKey('Sector.id'), nullable=False)
    ambitoid = db.Column(db.Integer, db.ForeignKey('Ambito.id'), nullable=False)
    provinciaid = db.Column(db.Integer, db.ForeignKey('Provincia.id'), nullable=False)
    departamentoid = db.Column(db.Integer, db.ForeignKey('Departamento.id'), nullable=False)
    localidadid = db.Column(db.Integer, db.ForeignKey('Localidad.id'), nullable=False)
    __table_args__ = (db.UniqueConstraint('nombre','cueanexo','sectorid','ambitoid','provinciaid','departamentoid','localidadid', name='uix_Escuela'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
            <cueanexo: {self.cueanexo}>
            <domicilio: {self.domicilio}>
            <codpos: {self.codpos}>
            <telefono: {self.telefono}>
            <email: {self.email}>
            <sectorid: {self.sectorid}>
            <ambitoid: {self.ambitoid}>
            <provinciaid: {self.provinciaid}>
            <departamentoid: {self.departamentoid}>
            <localidadid: {self.localidadid}>
        """

```

# Creacion de la DB
Estando en el directorio **work** ejecutar:
- En cmd: set FLASK_APP=orm.py, en linux: export FLASK_APP=orm.py
- flask shell (cambia el prompt)
```
python 3.10.12 (main, Jun 11 2023, 05:26:28) [GCC 11.4.0] on linux
App: orm
Instance: /home/juan/dev/DBUTN2023/python/web/work/instance
>>> from orm import db
>>> db_create_all()
```
- Conectados a mysql/la base elegida (en este caso "test") vemos si las tablas se crearon:
```
use test
SELECT * FROM information_schema.tables
where table_schema = 'test';
```

```
table_name  |
------------+
Ambito      |
Baseescuela |
Departamento|
Escuela     |
Localidad   |
Provincia   |
Sector      |
```


