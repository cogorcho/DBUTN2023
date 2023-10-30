from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired

# ----------------------------------
# Form para Autoridadparental
# ----------------------------------
class AutoridadParentalForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Institucion
# ----------------------------------
class InstitucionForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    diegrep = StringField('Diegrep')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Materia
# ----------------------------------
class MateriaForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Nivel
# ----------------------------------
class NivelForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Orientacion
# ----------------------------------
class OrientacionForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Pais
# ----------------------------------
class PaisForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Tipodocumento
# ----------------------------------
class TipoDocumentoForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Institucionorientacion
# ----------------------------------
class InstitucionOrientacionForm(FlaskForm):
    id = StringField('Id')
    institucionid = StringField('Institucionid', validators=[DataRequired()])
    orientacionid = StringField('Orientacionid', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Provincia
# ----------------------------------
class ProvinciaForm(FlaskForm):
    id = StringField('Id')
    paisid = StringField('Paisid', validators=[DataRequired()])
    nombre = StringField('Nombre')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Localidad
# ----------------------------------
class LocalidadForm(FlaskForm):
    id = StringField('Id')
    provinciaid = StringField('Provinciaid', validators=[DataRequired()])
    nombre = StringField('Nombre')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Planestudios
# ----------------------------------
class PlanEstudiosForm(FlaskForm):
    id = StringField('Id')
    InstitucionOrientacionId = StringField('Institucionorientacionid', validators=[DataRequired()])
    nombre = StringField('Nombre', validators=[DataRequired()])
    fechainicio = StringField('Fechainicio')
    fechafin = StringField('Fechafin')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Curso
# ----------------------------------
class CursoForm(FlaskForm):
    id = StringField('Id')
    planestudioid = StringField('Planestudioid', validators=[DataRequired()])
    nivelid = StringField('Nivelid', validators=[DataRequired()])
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Domicilio
# ----------------------------------
class DomicilioForm(FlaskForm):
    id = StringField('Id')
    localidadid = StringField('Localidadid', validators=[DataRequired()])
    direccion = StringField('Direccion', validators=[DataRequired()])
    codpos = StringField('Codpos')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Materiasplan
# ----------------------------------
class MateriasPlanForm(FlaskForm):
    id = StringField('Id')
    planestudiosid = StringField('Planestudiosid', validators=[DataRequired()])
    materiaid = StringField('Materiaid', validators=[DataRequired()])
    horassemanales = StringField('Horassemanales')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Comision
# ----------------------------------
class ComisionForm(FlaskForm):
    id = StringField('Id')
    cursoid = StringField('Cursoid', validators=[DataRequired()])
    nombre = StringField('Nombre', validators=[DataRequired()])
    periodoanual = StringField('Periodoanual', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Persona
# ----------------------------------
class PersonaForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    apellido = StringField('Apellido', validators=[DataRequired()])
    tipodocumentoid = StringField('Tipodocumentoid', validators=[DataRequired()])
    documento = StringField('Documento', validators=[DataRequired()])
    fnacto = StringField('Fnacto', validators=[DataRequired()])
    genero = StringField('Genero', validators=[DataRequired()])
    domicilioid = StringField('Domicilioid')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Sede
# ----------------------------------
class SedeForm(FlaskForm):
    id = StringField('Id')
    institucionid = StringField('Institucionid', validators=[DataRequired()])
    nombre = StringField('Nombre')
    domicilioid = StringField('Domicilioid', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Alumno
# ----------------------------------
class AlumnoForm(FlaskForm):
    id = StringField('Id')
    institucionid = StringField('Institucionid', validators=[DataRequired()])
    personaid = StringField('Personaid', validators=[DataRequired()])
    fingreso = StringField('Fingreso', validators=[DataRequired()])
    fegreso = StringField('Fegreso')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Aula
# ----------------------------------
class AulaForm(FlaskForm):
    id = StringField('Id')
    sedeid = StringField('Sedeid', validators=[DataRequired()])
    nombre = StringField('Nombre', validators=[DataRequired()])
    capacidad = StringField('Capacidad', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Docente
# ----------------------------------
class DocenteForm(FlaskForm):
    id = StringField('Id')
    personaid = StringField('Personaid', validators=[DataRequired()])
    institucionid = StringField('Institucionid', validators=[DataRequired()])
    fingreso = StringField('Fingreso', validators=[DataRequired()])
    fegreso = StringField('Fegreso')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Relacionparental
# ----------------------------------
class RelacionParentalForm(FlaskForm):
    id = StringField('Id')
    autoridadparentalid = StringField('Autoridadparentalid', validators=[DataRequired()])
    padreid = StringField('Padreid', validators=[DataRequired()])
    hijoid = StringField('Hijoid', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Responsablelegal
# ----------------------------------
class ResponsableLegalForm(FlaskForm):
    id = StringField('Id')
    personaid = StringField('Personaid', validators=[DataRequired()])
    fingreso = StringField('Fingreso', validators=[DataRequired()])
    fegreso = StringField('Fegreso')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Turno
# ----------------------------------
class TurnoForm(FlaskForm):
    id = StringField('Id')
    institucionorientacionid = StringField('Institucionorientacionid', validators=[DataRequired()])
    sedeid = StringField('Sedeid', validators=[DataRequired()])
    nombre = StringField('Nombre', validators=[DataRequired()])
    horaentrada = StringField('Horaentrada', validators=[DataRequired()])
    horasalida = StringField('Horasalida', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Alumnoscomision
# ----------------------------------
class AlumnosComisionForm(FlaskForm):
    id = StringField('Id')
    comisionid = StringField('Comisionid', validators=[DataRequired()])
    alumnoid = StringField('Alumnoid', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Horasturno
# ----------------------------------
class HorasTurnoForm(FlaskForm):
    id = StringField('Id')
    turnoid = StringField('Turnoid', validators=[DataRequired()])
    horainicio = StringField('Horainicio', validators=[DataRequired()])
    horafin = StringField('Horafin', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Materiasdocente
# ----------------------------------
class MateriasDocenteForm(FlaskForm):
    id = StringField('Id', validators=[DataRequired()])
    docenteid = StringField('Docenteid', validators=[DataRequired()])
    materiaid = StringField('Materiaid', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Responsablelegalalumno
# ----------------------------------
class ResponsableLegalAlumnoForm(FlaskForm):
    id = StringField('Id')
    ResponsableLegalid = StringField('Responsablelegalid', validators=[DataRequired()])
    alumnoid = StringField('Alumnoid', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Clase
# ----------------------------------
class ClaseForm(FlaskForm):
    id = StringField('Id')
    comisionid = StringField('Comisionid', validators=[DataRequired()])
    docenteid = StringField('Docenteid', validators=[DataRequired()])
    materiaid = StringField('Materiaid', validators=[DataRequired()])
    aulaid = StringField('Aulaid', validators=[DataRequired()])
    submit = SubmitField('Submit')
