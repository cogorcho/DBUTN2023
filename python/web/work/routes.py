from flask import Flask, render_template
from forms import (BaseEscuelaForm,SectorForm,AmbitoForm,ProvinciaForm,DepartamentoForm,LocalidadForm,EscuelaForm)
from flask_bootstrap import Bootstrap
app = Flask(__name__)
app.config['SECRET_KEY'] = 'hard to guess string'
bootstrap = Bootstrap(app)
@app.route('/baseescuela', methods=['GET', 'POST'])
def baseescuela():
    name = 'Baseescuela'
    form = BaseEscuelaForm()
    if form.validate_on_submit():
         jurisdiccion = form.data.jurisdiccion
         sector = form.data.sector
         ambito = form.data.ambito
         departamento = form.data.departamento
         codigo_de_departamento = form.data.codigo_de_departamento
         localidad = form.data.localidad
         codigo_de_localidad = form.data.codigo_de_localidad
         cueanexo = form.data.cueanexo
         nombre = form.data.nombre
         domicilio = form.data.domicilio
         codpos = form.data.codpos
         telefono = form.data.telefono
         mail = form.data.mail
    return render_template('index.html', form=form, name=name)

@app.route('/sector', methods=['GET', 'POST'])
def sector():
    name = 'Sector'
    form = SectorForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/ambito', methods=['GET', 'POST'])
def ambito():
    name = 'Ambito'
    form = AmbitoForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/provincia', methods=['GET', 'POST'])
def provincia():
    name = 'Provincia'
    form = ProvinciaForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/departamento', methods=['GET', 'POST'])
def departamento():
    name = 'Departamento'
    form = DepartamentoForm()
    if form.validate_on_submit():
         id = form.data.id
         provinciaid = form.data.provinciaid
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/localidad', methods=['GET', 'POST'])
def localidad():
    name = 'Localidad'
    form = LocalidadForm()
    if form.validate_on_submit():
         id = form.data.id
         departamentoid = form.data.departamentoid
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/escuela', methods=['GET', 'POST'])
def escuela():
    name = 'Escuela'
    form = EscuelaForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
         cueanexo = form.data.cueanexo
         domicilio = form.data.domicilio
         codpos = form.data.codpos
         telefono = form.data.telefono
         email = form.data.email
         sectorid = form.data.sectorid
         ambitoid = form.data.ambitoid
         provinciaid = form.data.provinciaid
         departamentoid = form.data.departamentoid
         localidadid = form.data.localidadid
    return render_template('index.html', form=form, name=name)

