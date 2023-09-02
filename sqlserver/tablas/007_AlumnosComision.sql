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
