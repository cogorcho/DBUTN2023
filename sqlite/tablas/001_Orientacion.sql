create table Orientacion (
	id integer primary key autoincrement,
	nombre varchar(1024) not null);

create unique index uix_orientacion_nombre
on Orientacion(nombre);
