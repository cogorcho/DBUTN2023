--Select 'Localidad';
create table Localidad (
	id integer primary key autoincrement,
	provinciaid integer not null,
	nombre varchar(1024) null,
	foreign key (provinciaid)
	references Provincia(id));	

create unique index uix_Localidad_Provincia_nombre
on Localidad(provinciaid,nombre);
