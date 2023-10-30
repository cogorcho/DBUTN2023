from flask import Flask, render_template
from forms import (AutoridadParentalForm,InstitucionForm,MateriaForm,NivelForm,OrientacionForm,PaisForm,TipoDocumentoForm,InstitucionOrientacionForm,ProvinciaForm,LocalidadForm,PlanEstudiosForm,CursoForm,DomicilioForm,MateriasPlanForm,ComisionForm,PersonaForm,SedeForm,AlumnoForm,AulaForm,DocenteForm,RelacionParentalForm,ResponsableLegalForm,TurnoForm,AlumnosComisionForm,HorasTurnoForm,MateriasDocenteForm,ResponsableLegalAlumnoForm,ClaseForm)
from flask_bootstrap import Bootstrap
app = Flask(__name__)
app.config['SECRET_KEY'] = 'hard to guess string'
bootstrap = Bootstrap(app)
@app.route('/autoridadparental', methods=['GET', 'POST'])
def autoridadparental():
    name = 'Autoridadparental'
    form = AutoridadParentalForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/institucion', methods=['GET', 'POST'])
def institucion():
    name = 'Institucion'
    form = InstitucionForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
         diegrep = form.data.diegrep
    return render_template('index.html', form=form, name=name)

@app.route('/materia', methods=['GET', 'POST'])
def materia():
    name = 'Materia'
    form = MateriaForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/nivel', methods=['GET', 'POST'])
def nivel():
    name = 'Nivel'
    form = NivelForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/orientacion', methods=['GET', 'POST'])
def orientacion():
    name = 'Orientacion'
    form = OrientacionForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/pais', methods=['GET', 'POST'])
def pais():
    name = 'Pais'
    form = PaisForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/tipodocumento', methods=['GET', 'POST'])
def tipodocumento():
    name = 'Tipodocumento'
    form = TipoDocumentoForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/institucionorientacion', methods=['GET', 'POST'])
def institucionorientacion():
    name = 'Institucionorientacion'
    form = InstitucionOrientacionForm()
    if form.validate_on_submit():
         id = form.data.id
         institucionid = form.data.institucionid
         orientacionid = form.data.orientacionid
    return render_template('index.html', form=form, name=name)

@app.route('/provincia', methods=['GET', 'POST'])
def provincia():
    name = 'Provincia'
    form = ProvinciaForm()
    if form.validate_on_submit():
         id = form.data.id
         paisid = form.data.paisid
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/localidad', methods=['GET', 'POST'])
def localidad():
    name = 'Localidad'
    form = LocalidadForm()
    if form.validate_on_submit():
         id = form.data.id
         provinciaid = form.data.provinciaid
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/planestudios', methods=['GET', 'POST'])
def planestudios():
    name = 'Planestudios'
    form = PlanEstudiosForm()
    if form.validate_on_submit():
         id = form.data.id
         institucionorientacionid = form.data.institucionorientacionid
         nombre = form.data.nombre
         fechainicio = form.data.fechainicio
         fechafin = form.data.fechafin
    return render_template('index.html', form=form, name=name)

@app.route('/curso', methods=['GET', 'POST'])
def curso():
    name = 'Curso'
    form = CursoForm()
    if form.validate_on_submit():
         id = form.data.id
         planestudioid = form.data.planestudioid
         nivelid = form.data.nivelid
         nombre = form.data.nombre
    return render_template('index.html', form=form, name=name)

@app.route('/domicilio', methods=['GET', 'POST'])
def domicilio():
    name = 'Domicilio'
    form = DomicilioForm()
    if form.validate_on_submit():
         id = form.data.id
         localidadid = form.data.localidadid
         direccion = form.data.direccion
         codpos = form.data.codpos
    return render_template('index.html', form=form, name=name)

@app.route('/materiasplan', methods=['GET', 'POST'])
def materiasplan():
    name = 'Materiasplan'
    form = MateriasPlanForm()
    if form.validate_on_submit():
         id = form.data.id
         planestudiosid = form.data.planestudiosid
         materiaid = form.data.materiaid
         horassemanales = form.data.horassemanales
    return render_template('index.html', form=form, name=name)

@app.route('/comision', methods=['GET', 'POST'])
def comision():
    name = 'Comision'
    form = ComisionForm()
    if form.validate_on_submit():
         id = form.data.id
         cursoid = form.data.cursoid
         nombre = form.data.nombre
         periodoanual = form.data.periodoanual
    return render_template('index.html', form=form, name=name)

@app.route('/persona', methods=['GET', 'POST'])
def persona():
    name = 'Persona'
    form = PersonaForm()
    if form.validate_on_submit():
         id = form.data.id
         nombre = form.data.nombre
         apellido = form.data.apellido
         tipodocumentoid = form.data.tipodocumentoid
         documento = form.data.documento
         fnacto = form.data.fnacto
         genero = form.data.genero
         domicilioid = form.data.domicilioid
    return render_template('index.html', form=form, name=name)

@app.route('/sede', methods=['GET', 'POST'])
def sede():
    name = 'Sede'
    form = SedeForm()
    if form.validate_on_submit():
         id = form.data.id
         institucionid = form.data.institucionid
         nombre = form.data.nombre
         domicilioid = form.data.domicilioid
    return render_template('index.html', form=form, name=name)

@app.route('/alumno', methods=['GET', 'POST'])
def alumno():
    name = 'Alumno'
    form = AlumnoForm()
    if form.validate_on_submit():
         id = form.data.id
         institucionid = form.data.institucionid
         personaid = form.data.personaid
         fingreso = form.data.fingreso
         fegreso = form.data.fegreso
    return render_template('index.html', form=form, name=name)

@app.route('/aula', methods=['GET', 'POST'])
def aula():
    name = 'Aula'
    form = AulaForm()
    if form.validate_on_submit():
         id = form.data.id
         sedeid = form.data.sedeid
         nombre = form.data.nombre
         capacidad = form.data.capacidad
    return render_template('index.html', form=form, name=name)

@app.route('/docente', methods=['GET', 'POST'])
def docente():
    name = 'Docente'
    form = DocenteForm()
    if form.validate_on_submit():
         id = form.data.id
         personaid = form.data.personaid
         institucionid = form.data.institucionid
         fingreso = form.data.fingreso
         fegreso = form.data.fegreso
    return render_template('index.html', form=form, name=name)

@app.route('/relacionparental', methods=['GET', 'POST'])
def relacionparental():
    name = 'Relacionparental'
    form = RelacionParentalForm()
    if form.validate_on_submit():
         id = form.data.id
         autoridadparentalid = form.data.autoridadparentalid
         padreid = form.data.padreid
         hijoid = form.data.hijoid
    return render_template('index.html', form=form, name=name)

@app.route('/responsablelegal', methods=['GET', 'POST'])
def responsablelegal():
    name = 'Responsablelegal'
    form = ResponsableLegalForm()
    if form.validate_on_submit():
         id = form.data.id
         personaid = form.data.personaid
         fingreso = form.data.fingreso
         fegreso = form.data.fegreso
    return render_template('index.html', form=form, name=name)

@app.route('/turno', methods=['GET', 'POST'])
def turno():
    name = 'Turno'
    form = TurnoForm()
    if form.validate_on_submit():
         id = form.data.id
         institucionorientacionid = form.data.institucionorientacionid
         sedeid = form.data.sedeid
         nombre = form.data.nombre
         horaentrada = form.data.horaentrada
         horasalida = form.data.horasalida
    return render_template('index.html', form=form, name=name)

@app.route('/alumnoscomision', methods=['GET', 'POST'])
def alumnoscomision():
    name = 'Alumnoscomision'
    form = AlumnosComisionForm()
    if form.validate_on_submit():
         id = form.data.id
         comisionid = form.data.comisionid
         alumnoid = form.data.alumnoid
    return render_template('index.html', form=form, name=name)

@app.route('/horasturno', methods=['GET', 'POST'])
def horasturno():
    name = 'Horasturno'
    form = HorasTurnoForm()
    if form.validate_on_submit():
         id = form.data.id
         turnoid = form.data.turnoid
         horainicio = form.data.horainicio
         horafin = form.data.horafin
    return render_template('index.html', form=form, name=name)

@app.route('/materiasdocente', methods=['GET', 'POST'])
def materiasdocente():
    name = 'Materiasdocente'
    form = MateriasDocenteForm()
    if form.validate_on_submit():
         id = form.data.id
         docenteid = form.data.docenteid
         materiaid = form.data.materiaid
    return render_template('index.html', form=form, name=name)

@app.route('/responsablelegalalumno', methods=['GET', 'POST'])
def responsablelegalalumno():
    name = 'Responsablelegalalumno'
    form = ResponsableLegalAlumnoForm()
    if form.validate_on_submit():
         id = form.data.id
         responsablelegalid = form.data.responsablelegalid
         alumnoid = form.data.alumnoid
    return render_template('index.html', form=form, name=name)

@app.route('/clase', methods=['GET', 'POST'])
def clase():
    name = 'Clase'
    form = ClaseForm()
    if form.validate_on_submit():
         id = form.data.id
         comisionid = form.data.comisionid
         docenteid = form.data.docenteid
         materiaid = form.data.materiaid
         aulaid = form.data.aulaid
    return render_template('index.html', form=form, name=name)

