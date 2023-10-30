--Select 'Pais';
create table Pais (
	id integer primary key autoincrement,
	nombre varchar(1024) not null);

create unique index uix_pais
on Pais(nombre);
