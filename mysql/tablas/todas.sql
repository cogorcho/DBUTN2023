Select 'AutoridadParental';
create table AutoridadParental (
	id integer primary key auto_increment,
	nombre varchar(1024) not null);

create unique index uix_relacion_parental
on AutoridadParental(nombre);

-- Madre, Padre, Tutor, Encargado
Select 'Institucion';
create table Institucion (
	id integer primary key auto_increment,
	nombre varchar(1024) not null,
	diegrep varchar(512));

create unique index uix_institucion_nombre
on Institucion(nombre);
Select 'Materia';
create table Materia (
	id integer primary key auto_increment,
	nombre varchar(1024) not null);

create unique index uix_materia_nombre
on Materia(nombre);
Select 'Nivel';
create table Nivel (
	id integer primary key auto_increment,
	nombre varchar(1024) not null);

create unique index uix_nivel_nombre
on Nivel(nombre);
Select 'Orientacion';
create table Orientacion (
	id integer primary key auto_increment,
	nombre varchar(1024) not null);

create unique index uix_orientacion_nombre
on Orientacion(nombre);
Select 'Pais';
create table Pais (
	id integer primary key auto_increment,
	nombre varchar(1024) not null);

create unique index uix_pais
on Pais(nombre);
Select 'TipoDocumento';
create table TipoDocumento (
	id integer primary key auto_increment,
	nombre varchar(1024) not null);

create unique index uix_tipodocumento_nombre
on TipoDocumento(nombre);
Select 'InstitucionOrientacion';
create table InstitucionOrientacion (
	id integer primary key auto_increment,
	institucionid integer not null,
	orientacionid integer not null,
	foreign key (institucionid)
	references Institucion(id),
	foreign key (orientacionid)
	references Orientacion(id));

create unique index uix_institucion_orientacion
on InstitucionOrientacion(institucionid, orientacionid);
Select 'Provincia';
create table Provincia (
	id integer primary key auto_increment,
	paisid integer not null,
	nombre varchar(1024) null,
	foreign key (paisid)
	references Pais(id));	

create unique index uix_pais_provincia_nombre
on Provincia(paisid,nombre);
Select 'Localidad';
create table Localidad (
	id integer primary key auto_increment,
	provinciaid integer not null,
	nombre varchar(1024) null,
	foreign key (provinciaid)
	references Provincia(id));	

create unique index uix_Localidad_Provincia_nombre
on Localidad(provinciaid,nombre);
Select 'PlanEstudios';
create table PlanEstudios(
	id integer primary key auto_increment,
	InstitucionOrientacionId integer not null,
	nombre varchar(1024) not null,
	fechainicio date,
	fechafin date,
	foreign key (InstitucionOrientacionId)
	references InstitucionOrientacion(id));

create unique index uix_PlanEstudios_InstOrient_nombre
on PlanEstudios(InstitucionOrientacionId,nombre);

Select 'Curso';
-- de cada plan-nivel(1rio, 2rio etc)
-- aca va 1er año, 2do grado, etc etc
create table Curso (
	id integer primary key auto_increment,
	planestudioid integer not null,
	nivelid integer not null,
	nombre varchar(1024) not null,
	foreign key (planestudioid)
	references PlanEstudios(id),
	foreign key (nivelid)
	references Nivel(id));

create unique index uix_curso_plan_nivel
on Curso(planestudioid,nivelid);
Select 'Domicilio';
create table Domicilio (
	id integer primary key auto_increment,
	localidadid integer not null,
	direccion varchar(2048) not null,
	codpos varchar(32),
	foreign key (localidadid)
	references Localidad(id));
Select 'MateriasPlan';
create table MateriasPlan (
	id integer primary key auto_increment,
	planestudiosid integer not null,
	materiaid integer not null,
	horassemanales integer,
	foreign key (planestudiosid)
	references PlanEstudios(id),
	foreign key (materiaid)
	references Materia(id));

create unique index uix_MateriasPlan 
on MateriasPlan(planestudiosid, materiaid);
Select 'Comision';
create table Comision (
	id integer primary key auto_increment,
	cursoid integer not null,
	nombre varchar(1024) not null,
	periodoanual integer not null,
	foreign key (cursoid)
	references Curso(id));

create unique index uix_comision_curso
on Comision(cursoid, periodoanual);
Select 'Persona';
create table Persona (
    id integer primary key auto_increment,
    nombre varchar(128) not null,
    apellido varchar(128) not null,
    tipodocumentoid integer not null,
    documento varchar(32) not null,
    fnacto datetime not null,
    genero char(1) not null check (genero in ('F','M','O')),
    domicilioid integer,
    foreign key (tipodocumentoid)
    references TipoDocumento(id),
    foreign key (domicilioid)
    references Domicilio(id));

create index ix_persona_apellido_nombre
on Persona(apellido,nombre);

DELIMITER //
CREATE TRIGGER check_insert_fnacto
BEFORE INSERT ON Persona FOR EACH ROW
BEGIN
    IF (NEW.fnacto > CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'la fecha de nacimiento es invalida';
    END IF;
END;


CREATE TRIGGER check_udate_fnacto
BEFORE UPDATE ON Persona FOR EACH ROW
BEGIN
    IF (NEW.fnacto > CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'la fecha de nacimiento es invalida';
    END IF;
END;
//

DELIMITER ;

Select 'Sede';
create table Sede (
	id integer primary key auto_increment,
	institucionid integer not null,
	nombre varchar(1024) null,
	domicilioid integer not null,
	foreign key (domicilioid)
	references Domicilio(id),
	foreign key (institucionid)
	references Institucion(id));	

create unique index uix_sede_institucion_nombre
on Sede(institucionid,nombre);
Select 'Alumno';
create table Alumno  (
	id integer primary key auto_increment,
	institucionid integer not null,
	personaid integer not null,
	fingreso date not null,
	fegreso date,
	foreign key (institucionid)
	references Institucion(id),
	foreign key (personaid)
	references Persona(id));

create unique index uix_alumno
on Alumno(institucionid,personaid);
Select 'Aula';
create table Aula(
	id integer primary key auto_increment,
	sedeid integer not null,
	nombre varchar(512) not null default 'Sin Nombre',
	capacidad integer not null default 0,
	foreign key (sedeid)
	references Sede(Id));


Select 'Docente';
create table Docente (
	id integer primary key auto_increment,
	personaid integer not null,
	institucionid integer not null,
	fingreso date not null,
	fegreso date,
	foreign key (personaid)
	references Persona(id),
	foreign key (institucionid)
	references Institucion(id));


Select 'RelacionParental';
create table RelacionParental (
	id integer primary key auto_increment,
	autoridadparentalid int not null,
	padreid integer not null,
	hijoid integer not null,
	constraint check_padre check (padreid != hijoid),
	constraint check_hijo check(hijoid != padreid),
	foreign key (padreid)
	references Persona(id),
	foreign key (hijoid)
	references Persona(id),
	foreign key (autoridadparentalid)
	references AutoridadParental(id));

create unique index uix_RelacionParental
on RelacionParental(padreid,hijoid);

create index ix_RelacionParental
on RelacionParental(autoridadparentalid);
-- Cuando haga un join para buscar todos los
-- padres/madres/etc de un curso.
Select 'ResponsableLegal';
create table ResponsableLegal  (
	id integer primary key auto_increment,
	personaid integer not null,
	fingreso date not null,
	fegreso date,
	foreign key (personaid)
	references Persona(id));
Select 'Turno';
create table Turno (
	id integer primary key auto_increment,
	institucionorientacionid integer not null,
	sedeid integer not null,
	nombre varchar(512) not null,
	horaentrada time not null,
	horasalida time not null,
	foreign key (sedeid)
	references Sede(id),
	constraint chk_horaentrada check (horaentrada < horasalida),
	constraint chk_horasalida check (horasalida > horaentrada),
	foreign key (institucionorientacionid)
	references InstitucionOrientacion(id));

create unique index uix_turno
on Turno(institucionorientacionid,sedeid,nombre);
Select 'AlumnosComision';
create table AlumnosComision (
	id integer primary key auto_increment,
	comisionid integer not null,
	alumnoid integer not null,
	foreign key (comisionid)
	references Comision(id),
	foreign key (alumnoid)
	references Alumno(id));

create unique index uix_alumnos_comision
on AlumnosComision(comisionid, alumnoid);
Select 'HorasTurno';
create table HorasTurno (
	id integer primary key auto_increment,
	turnoid integer not null,
	horainicio time not null,
	horafin time not null,
	constraint chk_horainicio check(horainicio < horafin),
	constraint chk_horafin check(horafin > horainicio));

create unique index uix_horas_turno 
on HorasTurno(turnoid, horainicio, horafin);
Select 'MateriasDocente';
create table MateriasDocente (
	id integer primary key not null,
	docenteid integer not null,
	materiaid integer not null,
	foreign key (docenteid)
	references Docente(id),
	foreign key (materiaid)
	references Materia(id));

create unique index uix_materia_docente
on MateriasDocente(docenteid,materiaid);
Select 'ResponsableLegalAlumno';
create table ResponsableLegalAlumno (
    id integer primary key auto_increment,
    ResponsableLegalid integer not null,
    alumnoid integer not null,
    foreign key (ResponsableLegalid)
    references ResponsableLegal(id),
    foreign key (alumnoid)
    references Alumno(id));

create unique index uix_resp_alumno
on ResponsableLegalAlumno(ResponsableLegalid, alumnoid);Select 'Clase';
create table Clase (
    id integer primary key auto_increment,
    comisionid integer not null,
    docenteid integer not null,
    materiaid integer not null,
    aulaid integer not null,
    foreign key (aulaid)
    references Aula(id),
    foreign key (comisionid)
    references Comision(id),
    foreign key (docenteid)
    references Docente(id),
    foreign key (materiaid)
    references Materia(id));

create unique index uix_clase
on Clase(comisionid, aulaid, docenteid, materiaid);
