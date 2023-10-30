import os
from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'data.sqlite')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
from orm import Provincia, Sector, Ambito, Departamento, Localidad, Escuela

engine = create_engine(app.config['SQLALCHEMY_DATABASE_URI'])
Session = sessionmaker(bind=engine)
session = Session()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/provincias')
def provincias():
    data = [{'id': x.id, 'nombre': x.nombre} for x in session.query(Provincia).all()]
    return render_template('provincias.html', data=data, titulo='Provincias')

@app.route('/provincia/<id>')
def provincia(id):
    data = session.query(Provincia).filter(Provincia.id == id).first().__dict__
    del data['_sa_instance_state']
    return render_template('registro.html', data=data, titulo='Provincia')

@app.route('/sectores')
def sectores():
    return [{'id': x.id, 'nombre': x.nombre} for x in session.query(Sector).all()]

@app.route('/sector/<id>')
def sector(id):
    data = session.query(Sector).filter(Sector.id == id).first().__dict__
    del data['_sa_instance_state']
    action = f"/sector/{id}"
    return render_template('registro.html', titulo='Sector', data=data, action=action)

@app.route('/ambitos')
def ambitos():
    return [{'id': x.id, 'nombre': x.nombre} for x in session.query(Ambito).all()]

@app.route('/ambito/<id>')
def ambito(id):
    data = session.query(Ambito).filter(Ambito.id == id).first().__dict__
    del data['_sa_instance_state']
    action = f"/ambito/{id}"
    return render_template('registro.html', titulo='Ambito', data=data, action=action)

@app.route('/departamentos/<provinciaid>')
def departamentos(provinciaid):
    provincia = [{'id': x.id, 'nombre': x.nombre} for x in session.query(Provincia).filter(Provincia.id == provinciaid)][0]
    data = [{'id': x.id, 'provinciaid': x.provinciaid, 'nombre': x.nombre} for x in session.query(Departamento).filter(Departamento.provinciaid == provinciaid)]
    return render_template('departamentos.html', data=data, titulo=f"Departamentos de {provincia['nombre']}")

@app.route('/localidades/<departamentoid>')
def localidades(departamentoid):
    departamento = [{'id': x.id, 'nombre': x.nombre, 'provinciaid': x.provinciaid} for x in session.query(Departamento).filter(Departamento.id == departamentoid)][0]
    provincia = [{'id': x.id, 'nombre': x.nombre} for x in session.query(Provincia).filter(Provincia.id == departamento['provinciaid'])][0]
    data = [{'id': x.id, 'departamentoid': x.departamentoid, 'nombre': x.nombre} for x in session.query(Localidad).filter(Localidad.departamentoid == departamentoid)]
    return render_template('localidades.html', data=data, titulo=f"Localidades del departamento {departamento['nombre']} de {provincia['nombre']}")

@app.route('/escuelasxlocalidad/<localidadid>')
def escuelasxlocalidad(localidadid):
    data = [{'id': x.id, 'provinciaid': x.provinciaid, 'departamentoid': x.departamentoid, 'nombre': x.nombre} for x in session.query(Escuela).filter(Escuela.localidadid == localidadid).order_by(Escuela.nombre)]
    localidad = [{'id': x.id, 'nombre': x.nombre, 'departamentoid': x.departamentoid} for x in session.query(Localidad).filter(Localidad.id == localidadid)][0]
    departamento = [{'id': x.id, 'nombre': x.nombre, 'provinciaid': x.provinciaid} for x in session.query(Departamento).filter(Departamento.id == localidad['departamentoid'])][0]
    provincia = [{'id': x.id, 'nombre': x.nombre} for x in session.query(Provincia).filter(Provincia.id == departamento['provinciaid'])][0]
    return render_template('escuelas.html', data=data, titulo=f"Escuelas de {localidad['nombre'].title()}, {departamento['nombre']}, {provincia['nombre']}")


# Not ready yet
"""
@app.route('/escuela/<id>', methods=['GET','POST'])
def escuela(id):
    data = session.query(Escuela).filter(Escuela.id == id).first().__dict__
    del data['_sa_instance_state']
    action = f"/escuela/{id}"
    if request.method == 'POST':
        return render_template('edit_escuela.html', data=data, titulo='Escuela', action=action)
    return render_template('registro.html', data=data, titulo='Escuela', action=action)
    """