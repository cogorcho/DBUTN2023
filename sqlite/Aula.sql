create table Aula(
	id integer primary key autoincrement,
	sedeid integer not null,
	nombre varchar(512) not null default 'Sin Nombre',
	capacidad integer not null default 0);


