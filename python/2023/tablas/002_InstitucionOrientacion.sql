--Select 'InstitucionOrientacion';
create table InstitucionOrientacion (
	id integer primary key autoincrement,
	institucionid integer not null,
	orientacionid integer not null,
	foreign key (institucionid)
	references Institucion(id),
	foreign key (orientacionid)
	references Orientacion(id));

create unique index uix_institucion_orientacion
on InstitucionOrientacion(institucionid, orientacionid);
