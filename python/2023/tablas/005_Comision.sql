--Select 'Comision';
create table Comision (
	id integer primary key autoincrement,
	cursoid integer not null,
	nombre varchar(1024) not null,
	periodoanual integer not null,
	foreign key (cursoid)
	references Curso(id));

create unique index uix_comision_curso
on Comision(cursoid, periodoanual);
