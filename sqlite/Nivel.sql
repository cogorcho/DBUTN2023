create table Nivel (
	id integer primary key autoincrement,
	nombre varchar(1024) not null);

create unique index uix_nivel_nombre
on Nivel(nombre);
