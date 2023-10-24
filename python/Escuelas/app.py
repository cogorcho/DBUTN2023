from flask import Flask
import json
import db

app = Flask(__name__)

@app.route('/provincia/<id>')
def provincia(id):
    return dict(db.provincia(id))

@app.route('/')
@app.route('/provincias')
def provincias():
    return [dict(row) for row in db.provincias()]

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
