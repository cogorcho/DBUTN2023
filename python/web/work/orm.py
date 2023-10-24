import os
from flask_sqlalchemy import SQLAlchemy
from flask import Flask
basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'data.sqlite')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

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
