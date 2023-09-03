create table Institucion (
	id integer primary key autoincrement,
	nombre varchar(1024) not null,
	diegrep varchar(512));

create unique index uix_institucion_nombre
on Institucion(nombre);
