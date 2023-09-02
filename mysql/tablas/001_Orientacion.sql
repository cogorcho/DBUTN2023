Select 'Orientacion';
create table Orientacion (
	id integer primary key auto_increment,
	nombre varchar(1024) not null);

create unique index uix_orientacion_nombre
on Orientacion(nombre);
