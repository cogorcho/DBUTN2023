Select 'Materia';
create table Materia (
	id integer primary key auto_increment,
	nombre varchar(1024) not null);

create unique index uix_materia_nombre
on Materia(nombre);
