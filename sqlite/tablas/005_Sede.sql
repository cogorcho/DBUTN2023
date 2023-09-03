create table Sede (
	id integer primary key autoincrement,
	institucionid integer not null,
	nombre varchar(1024) null,
	domicilioid integer not null,
	foreign key (domicilioid)
	references Domicilio(id),
	foreign key (institucionid)
	references Institucion(id));	

create unique index uix_sede_institucion_nombre
on Sede(institucionid,nombre);
