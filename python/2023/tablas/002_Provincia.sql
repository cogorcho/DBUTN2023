--Select 'Provincia';
create table Provincia (
	id integer primary key autoincrement,
	paisid integer not null,
	nombre varchar(1024) null,
	foreign key (paisid)
	references Pais(id));	

create unique index uix_pais_provincia_nombre
on Provincia(paisid,nombre);
