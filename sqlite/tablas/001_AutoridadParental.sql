create table AutoridadParental (
	id integer primary key autoincrement,
	nombre varchar(1024) not null);

create unique index uix_relacion_parental
on AutoridadParental(nombre);

-- Madre, Padre, Tutor, Encargado
