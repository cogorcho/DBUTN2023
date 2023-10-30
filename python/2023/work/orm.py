import os
from flask_sqlalchemy import SQLAlchemy
from flask import Flask
basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'Master.db')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
# ---------------------------------------------------
#   Autoridadparental
# ---------------------------------------------------
class Autoridadparental(db.Model):
    __tablename__ = 'Autoridadparental'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(1024), nullable=False)
    __table_args__ = (db.UniqueConstraint('nombre', name='uix_AutoridadParental'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Institucion
# ---------------------------------------------------
class Institucion(db.Model):
    __tablename__ = 'Institucion'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(1024), nullable=False)
    diegrep = db.Column(db.String(512))
    __table_args__ = (db.UniqueConstraint('nombre', name='uix_Institucion'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
            <diegrep: {self.diegrep}>
        """
# ---------------------------------------------------
#   Materia
# ---------------------------------------------------
class Materia(db.Model):
    __tablename__ = 'Materia'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(1024), nullable=False)
    __table_args__ = (db.UniqueConstraint('nombre', name='uix_Materia'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Nivel
# ---------------------------------------------------
class Nivel(db.Model):
    __tablename__ = 'Nivel'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(1024), nullable=False)
    __table_args__ = (db.UniqueConstraint('nombre', name='uix_Nivel'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Orientacion
# ---------------------------------------------------
class Orientacion(db.Model):
    __tablename__ = 'Orientacion'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(1024), nullable=False)
    __table_args__ = (db.UniqueConstraint('nombre', name='uix_Orientacion'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Pais
# ---------------------------------------------------
class Pais(db.Model):
    __tablename__ = 'Pais'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(1024), nullable=False)
    __table_args__ = (db.UniqueConstraint('nombre', name='uix_Pais'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Tipodocumento
# ---------------------------------------------------
class Tipodocumento(db.Model):
    __tablename__ = 'Tipodocumento'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(1024), nullable=False)
    __table_args__ = (db.UniqueConstraint('nombre', name='uix_TipoDocumento'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Institucionorientacion
# ---------------------------------------------------
class Institucionorientacion(db.Model):
    __tablename__ = 'Institucionorientacion'

    id = db.Column(db.Integer, primary_key=True)
    institucionid = db.Column(db.Integer, db.ForeignKey('Institucion.id'), nullable=False)
    orientacionid = db.Column(db.Integer, db.ForeignKey('Orientacion.id'), nullable=False)
    __table_args__ = (db.UniqueConstraint('institucionid','orientacionid', name='uix_InstitucionOrientacion'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <institucionid: {self.institucionid}>
            <orientacionid: {self.orientacionid}>
        """
# ---------------------------------------------------
#   Provincia
# ---------------------------------------------------
class Provincia(db.Model):
    __tablename__ = 'Provincia'

    id = db.Column(db.Integer, primary_key=True)
    paisid = db.Column(db.Integer, db.ForeignKey('Pais.id'), nullable=False)
    nombre = db.Column(db.String(1024))
    __table_args__ = (db.UniqueConstraint('paisid','nombre', name='uix_Provincia'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <paisid: {self.paisid}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Localidad
# ---------------------------------------------------
class Localidad(db.Model):
    __tablename__ = 'Localidad'

    id = db.Column(db.Integer, primary_key=True)
    provinciaid = db.Column(db.Integer, db.ForeignKey('Provincia.id'), nullable=False)
    nombre = db.Column(db.String(1024))
    __table_args__ = (db.UniqueConstraint('provinciaid','nombre', name='uix_Localidad'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <provinciaid: {self.provinciaid}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Planestudios
# ---------------------------------------------------
class Planestudios(db.Model):
    __tablename__ = 'Planestudios'

    id = db.Column(db.Integer, primary_key=True)
    institucionorientacionid = db.Column(db.Integer, db.ForeignKey('InstitucionOrientacion.id'), nullable=False)
    nombre = db.Column(db.String(1024), nullable=False)
    fechainicio = db.Column(db.Date)
    fechafin = db.Column(db.Date)
    __table_args__ = (db.UniqueConstraint('InstitucionOrientacionId','nombre', name='uix_PlanEstudios'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <institucionorientacionid: {self.institucionorientacionid}>
            <nombre: {self.nombre}>
            <fechainicio: {self.fechainicio}>
            <fechafin: {self.fechafin}>
        """
# ---------------------------------------------------
#   Curso
# ---------------------------------------------------
class Curso(db.Model):
    __tablename__ = 'Curso'

    id = db.Column(db.Integer, primary_key=True)
    planestudioid = db.Column(db.Integer, db.ForeignKey('PlanEstudios.id'), nullable=False)
    nivelid = db.Column(db.Integer, db.ForeignKey('Nivel.id'), nullable=False)
    nombre = db.Column(db.String(1024), nullable=False)
    __table_args__ = (db.UniqueConstraint('planestudioid','nivelid', name='uix_Curso'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <planestudioid: {self.planestudioid}>
            <nivelid: {self.nivelid}>
            <nombre: {self.nombre}>
        """
# ---------------------------------------------------
#   Domicilio
# ---------------------------------------------------
class Domicilio(db.Model):
    __tablename__ = 'Domicilio'

    id = db.Column(db.Integer, primary_key=True)
    localidadid = db.Column(db.Integer, db.ForeignKey('Localidad.id'), nullable=False)
    direccion = db.Column(db.String(2048), nullable=False)
    codpos = db.Column(db.String(32))

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <localidadid: {self.localidadid}>
            <direccion: {self.direccion}>
            <codpos: {self.codpos}>
        """
# ---------------------------------------------------
#   Materiasplan
# ---------------------------------------------------
class Materiasplan(db.Model):
    __tablename__ = 'Materiasplan'

    id = db.Column(db.Integer, primary_key=True)
    planestudiosid = db.Column(db.Integer, db.ForeignKey('PlanEstudios.id'), nullable=False)
    materiaid = db.Column(db.Integer, db.ForeignKey('Materia.id'), nullable=False)
    horassemanales = db.Column(db.Integer)
    __table_args__ = (db.UniqueConstraint('planestudiosid','materiaid', name='uix_MateriasPlan'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <planestudiosid: {self.planestudiosid}>
            <materiaid: {self.materiaid}>
            <horassemanales: {self.horassemanales}>
        """
# ---------------------------------------------------
#   Comision
# ---------------------------------------------------
class Comision(db.Model):
    __tablename__ = 'Comision'

    id = db.Column(db.Integer, primary_key=True)
    cursoid = db.Column(db.Integer, db.ForeignKey('Curso.id'), nullable=False)
    nombre = db.Column(db.String(1024), nullable=False)
    periodoanual = db.Column(db.Integer, nullable=False)
    __table_args__ = (db.UniqueConstraint('cursoid','periodoanual', name='uix_Comision'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <cursoid: {self.cursoid}>
            <nombre: {self.nombre}>
            <periodoanual: {self.periodoanual}>
        """
# ---------------------------------------------------
#   Persona
# ---------------------------------------------------
class Persona(db.Model):
    __tablename__ = 'Persona'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(128), nullable=False)
    apellido = db.Column(db.String(128), nullable=False)
    tipodocumentoid = db.Column(db.Integer, db.ForeignKey('TipoDocumento.id'), nullable=False)
    documento = db.Column(db.String(32), nullable=False)
    fnacto = db.Column(db.Datetime, nullable=False)
    genero = db.Column(db.Char(1), nullable=False)
    domicilioid = db.Column(db.Integer, db.ForeignKey('Domicilio.id'))

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <nombre: {self.nombre}>
            <apellido: {self.apellido}>
            <tipodocumentoid: {self.tipodocumentoid}>
            <documento: {self.documento}>
            <fnacto: {self.fnacto}>
            <genero: {self.genero}>
            <domicilioid: {self.domicilioid}>
        """
# ---------------------------------------------------
#   Sede
# ---------------------------------------------------
class Sede(db.Model):
    __tablename__ = 'Sede'

    id = db.Column(db.Integer, primary_key=True)
    institucionid = db.Column(db.Integer, db.ForeignKey('Institucion.id'), nullable=False)
    nombre = db.Column(db.String(1024))
    domicilioid = db.Column(db.Integer, db.ForeignKey('Domicilio.id'), nullable=False)
    __table_args__ = (db.UniqueConstraint('institucionid','nombre', name='uix_Sede'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <institucionid: {self.institucionid}>
            <nombre: {self.nombre}>
            <domicilioid: {self.domicilioid}>
        """
# ---------------------------------------------------
#   Alumno
# ---------------------------------------------------
class Alumno(db.Model):
    __tablename__ = 'Alumno'

    id = db.Column(db.Integer, primary_key=True)
    institucionid = db.Column(db.Integer, db.ForeignKey('Institucion.id'), nullable=False)
    personaid = db.Column(db.Integer, db.ForeignKey('Persona.id'), nullable=False)
    fingreso = db.Column(db.Date, nullable=False)
    fegreso = db.Column(db.Date)
    __table_args__ = (db.UniqueConstraint('institucionid','personaid', name='uix_Alumno'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <institucionid: {self.institucionid}>
            <personaid: {self.personaid}>
            <fingreso: {self.fingreso}>
            <fegreso: {self.fegreso}>
        """
# ---------------------------------------------------
#   Aula
# ---------------------------------------------------
class Aula(db.Model):
    __tablename__ = 'Aula'

    id = db.Column(db.Integer, primary_key=True)
    sedeid = db.Column(db.Integer, db.ForeignKey('Sede.Id'), nullable=False)
    nombre = db.Column(db.String(512), nullable=False)
    capacidad = db.Column(db.Integer, nullable=False)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <sedeid: {self.sedeid}>
            <nombre: {self.nombre}>
            <capacidad: {self.capacidad}>
        """
# ---------------------------------------------------
#   Docente
# ---------------------------------------------------
class Docente(db.Model):
    __tablename__ = 'Docente'

    id = db.Column(db.Integer, primary_key=True)
    personaid = db.Column(db.Integer, db.ForeignKey('Persona.id'), nullable=False)
    institucionid = db.Column(db.Integer, db.ForeignKey('Institucion.id'), nullable=False)
    fingreso = db.Column(db.Date, nullable=False)
    fegreso = db.Column(db.Date)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <personaid: {self.personaid}>
            <institucionid: {self.institucionid}>
            <fingreso: {self.fingreso}>
            <fegreso: {self.fegreso}>
        """
# ---------------------------------------------------
#   Relacionparental
# ---------------------------------------------------
class Relacionparental(db.Model):
    __tablename__ = 'Relacionparental'

    id = db.Column(db.Integer, primary_key=True)
    autoridadparentalid = db.Column(db.Int, db.ForeignKey('AutoridadParental.id'), nullable=False)
    padreid = db.Column(db.Integer, db.ForeignKey('Persona.id'), nullable=False)
    hijoid = db.Column(db.Integer, db.ForeignKey('Persona.id'), nullable=False)
    __table_args__ = (db.UniqueConstraint('padreid','hijoid', name='uix_RelacionParental'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <autoridadparentalid: {self.autoridadparentalid}>
            <padreid: {self.padreid}>
            <hijoid: {self.hijoid}>
        """
# ---------------------------------------------------
#   Responsablelegal
# ---------------------------------------------------
class Responsablelegal(db.Model):
    __tablename__ = 'Responsablelegal'

    id = db.Column(db.Integer, primary_key=True)
    personaid = db.Column(db.Integer, db.ForeignKey('Persona.id'), nullable=False)
    fingreso = db.Column(db.Date, nullable=False)
    fegreso = db.Column(db.Date)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <personaid: {self.personaid}>
            <fingreso: {self.fingreso}>
            <fegreso: {self.fegreso}>
        """
# ---------------------------------------------------
#   Turno
# ---------------------------------------------------
class Turno(db.Model):
    __tablename__ = 'Turno'

    id = db.Column(db.Integer, primary_key=True)
    institucionorientacionid = db.Column(db.Integer, db.ForeignKey('InstitucionOrientacion.id'), nullable=False)
    sedeid = db.Column(db.Integer, db.ForeignKey('Sede.id'), nullable=False)
    nombre = db.Column(db.String(512), nullable=False)
    horaentrada = db.Column(db.Time, nullable=False)
    horasalida = db.Column(db.Time, nullable=False)
    __table_args__ = (db.UniqueConstraint('institucionorientacionid','sedeid','nombre', name='uix_Turno'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <institucionorientacionid: {self.institucionorientacionid}>
            <sedeid: {self.sedeid}>
            <nombre: {self.nombre}>
            <horaentrada: {self.horaentrada}>
            <horasalida: {self.horasalida}>
        """
# ---------------------------------------------------
#   Alumnoscomision
# ---------------------------------------------------
class Alumnoscomision(db.Model):
    __tablename__ = 'Alumnoscomision'

    id = db.Column(db.Integer, primary_key=True)
    comisionid = db.Column(db.Integer, db.ForeignKey('Comision.id'), nullable=False)
    alumnoid = db.Column(db.Integer, db.ForeignKey('Alumno.id'), nullable=False)
    __table_args__ = (db.UniqueConstraint('comisionid','alumnoid', name='uix_AlumnosComision'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <comisionid: {self.comisionid}>
            <alumnoid: {self.alumnoid}>
        """
# ---------------------------------------------------
#   Horasturno
# ---------------------------------------------------
class Horasturno(db.Model):
    __tablename__ = 'Horasturno'

    id = db.Column(db.Integer, primary_key=True)
    turnoid = db.Column(db.Integer, nullable=False)
    horainicio = db.Column(db.Time, nullable=False)
    horafin = db.Column(db.Time, nullable=False)
    __table_args__ = (db.UniqueConstraint('turnoid','horainicio','horafin', name='uix_HorasTurno'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <turnoid: {self.turnoid}>
            <horainicio: {self.horainicio}>
            <horafin: {self.horafin}>
        """
# ---------------------------------------------------
#   Materiasdocente
# ---------------------------------------------------
class Materiasdocente(db.Model):
    __tablename__ = 'Materiasdocente'

    id = db.Column(db.Integer, nullable=False, primary_key=True)
    docenteid = db.Column(db.Integer, db.ForeignKey('Docente.id'), nullable=False)
    materiaid = db.Column(db.Integer, db.ForeignKey('Materia.id'), nullable=False)
    __table_args__ = (db.UniqueConstraint('docenteid','materiaid', name='uix_MateriasDocente'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <docenteid: {self.docenteid}>
            <materiaid: {self.materiaid}>
        """
# ---------------------------------------------------
#   Responsablelegalalumno
# ---------------------------------------------------
class Responsablelegalalumno(db.Model):
    __tablename__ = 'Responsablelegalalumno'

    id = db.Column(db.Integer, primary_key=True)
    responsablelegalid = db.Column(db.Integer, db.ForeignKey('ResponsableLegal.id'), nullable=False)
    alumnoid = db.Column(db.Integer, db.ForeignKey('Alumno.id'), nullable=False)
    __table_args__ = (db.UniqueConstraint('ResponsableLegalid','alumnoid', name='uix_ResponsableLegalAlumno'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <responsablelegalid: {self.responsablelegalid}>
            <alumnoid: {self.alumnoid}>
        """
# ---------------------------------------------------
#   Clase
# ---------------------------------------------------
class Clase(db.Model):
    __tablename__ = 'Clase'

    id = db.Column(db.Integer, primary_key=True)
    comisionid = db.Column(db.Integer, db.ForeignKey('Comision.id'), nullable=False)
    docenteid = db.Column(db.Integer, db.ForeignKey('Docente.id'), nullable=False)
    materiaid = db.Column(db.Integer, db.ForeignKey('Materia.id'), nullable=False)
    aulaid = db.Column(db.Integer, db.ForeignKey('Aula.id'), nullable=False)
    __table_args__ = (db.UniqueConstraint('comisionid','aulaid','docenteid','materiaid', name='uix_Clase'),)

    def __repr__(self):
        return f"""
            <id: {self.id}>
            <comisionid: {self.comisionid}>
            <docenteid: {self.docenteid}>
            <materiaid: {self.materiaid}>
            <aulaid: {self.aulaid}>
        """
