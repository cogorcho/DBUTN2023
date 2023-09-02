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
