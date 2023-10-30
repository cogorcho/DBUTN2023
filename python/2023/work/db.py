import sqlite3
conn = sqlite3.connect('Escuelas.db', check_same_thread=False)
conn.row_factory = sqlite3.Row

def autoridadparentalxs():
    sql = 'select id,nombre from AutoridadParental'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def autoridadparental(id):
    sql = 'select id,nombre from AutoridadParental where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def institucionxs():
    sql = 'select id,nombre,diegrep from Institucion'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def institucion(id):
    sql = 'select id,nombre,diegrep from Institucion where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def materias():
    sql = 'select id,nombre from Materia'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def materia(id):
    sql = 'select id,nombre from Materia where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def nivelxs():
    sql = 'select id,nombre from Nivel'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def nivel(id):
    sql = 'select id,nombre from Nivel where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def orientacionxs():
    sql = 'select id,nombre from Orientacion'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def orientacion(id):
    sql = 'select id,nombre from Orientacion where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def paisxs():
    sql = 'select id,nombre from Pais'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def pais(id):
    sql = 'select id,nombre from Pais where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def tipodocumentos():
    sql = 'select id,nombre from TipoDocumento'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def tipodocumento(id):
    sql = 'select id,nombre from TipoDocumento where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def institucionorientacionxs():
    sql = 'select id,institucionid,orientacionid from InstitucionOrientacion'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def institucionorientacion(id):
    sql = 'select id,institucionid,orientacionid from InstitucionOrientacion where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def provincias():
    sql = 'select id,paisid,nombre from Provincia'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def provincia(id):
    sql = 'select id,paisid,nombre from Provincia where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def localidadxs():
    sql = 'select id,provinciaid,nombre from Localidad'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def localidad(id):
    sql = 'select id,provinciaid,nombre from Localidad where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def planestudiosxs():
    sql = 'select id,InstitucionOrientacionId,nombre,fechainicio,fechafin from PlanEstudios'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def planestudios(id):
    sql = 'select id,InstitucionOrientacionId,nombre,fechainicio,fechafin from PlanEstudios where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def cursos():
    sql = 'select id,planestudioid,nivelid,nombre from Curso'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def curso(id):
    sql = 'select id,planestudioid,nivelid,nombre from Curso where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def domicilios():
    sql = 'select id,localidadid,direccion,codpos from Domicilio'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def domicilio(id):
    sql = 'select id,localidadid,direccion,codpos from Domicilio where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def materiasplanxs():
    sql = 'select id,planestudiosid,materiaid,horassemanales from MateriasPlan'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def materiasplan(id):
    sql = 'select id,planestudiosid,materiaid,horassemanales from MateriasPlan where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def comisionxs():
    sql = 'select id,cursoid,nombre,periodoanual from Comision'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def comision(id):
    sql = 'select id,cursoid,nombre,periodoanual from Comision where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def personas():
    sql = 'select id,nombre,apellido,tipodocumentoid,documento,fnacto,genero,domicilioid from Persona'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def persona(id):
    sql = 'select id,nombre,apellido,tipodocumentoid,documento,fnacto,genero,domicilioid from Persona where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def sedes():
    sql = 'select id,institucionid,nombre,domicilioid from Sede'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def sede(id):
    sql = 'select id,institucionid,nombre,domicilioid from Sede where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def alumnos():
    sql = 'select id,institucionid,personaid,fingreso,fegreso from Alumno'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def alumno(id):
    sql = 'select id,institucionid,personaid,fingreso,fegreso from Alumno where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def aulas():
    sql = 'select id,sedeid,nombre,capacidad from Aula'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def aula(id):
    sql = 'select id,sedeid,nombre,capacidad from Aula where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def docentes():
    sql = 'select id,personaid,institucionid,fingreso,fegreso from Docente'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def docente(id):
    sql = 'select id,personaid,institucionid,fingreso,fegreso from Docente where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def relacionparentalxs():
    sql = 'select id,autoridadparentalid,padreid,hijoid from RelacionParental'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def relacionparental(id):
    sql = 'select id,autoridadparentalid,padreid,hijoid from RelacionParental where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def responsablelegalxs():
    sql = 'select id,personaid,fingreso,fegreso from ResponsableLegal'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def responsablelegal(id):
    sql = 'select id,personaid,fingreso,fegreso from ResponsableLegal where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def turnos():
    sql = 'select id,institucionorientacionid,sedeid,nombre,horaentrada,horasalida from Turno'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def turno(id):
    sql = 'select id,institucionorientacionid,sedeid,nombre,horaentrada,horasalida from Turno where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def alumnoscomisionxs():
    sql = 'select id,comisionid,alumnoid from AlumnosComision'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def alumnoscomision(id):
    sql = 'select id,comisionid,alumnoid from AlumnosComision where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def horasturnos():
    sql = 'select id,turnoid,horainicio,horafin from HorasTurno'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def horasturno(id):
    sql = 'select id,turnoid,horainicio,horafin from HorasTurno where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def materiasdocentes():
    sql = 'select id,docenteid,materiaid from MateriasDocente'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def materiasdocente(id):
    sql = 'select id,docenteid,materiaid from MateriasDocente where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def responsablelegalalumnos():
    sql = 'select id,ResponsableLegalid,alumnoid from ResponsableLegalAlumno'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def responsablelegalalumno(id):
    sql = 'select id,ResponsableLegalid,alumnoid from ResponsableLegalAlumno where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()

def clases():
    sql = 'select id,comisionid,docenteid,materiaid,aulaid from Clase'
    cursor = conn.cursor()
    res = cursor.execute(sql)
    return res.fetchall()

def clase(id):
    sql = 'select id,comisionid,docenteid,materiaid,aulaid from Clase where id = ?'
    cursor = conn.cursor()
    res = cursor.execute(sql, (id,))
    return res.fetchone()
