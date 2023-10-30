--Select 'Aula';
create table Aula(
	id integer primary key autoincrement,
	sedeid integer not null,
	nombre varchar(512) not null default 'Sin Nombre',
	capacidad integer not null default 0,
	foreign key (sedeid)
	references Sede(Id));


