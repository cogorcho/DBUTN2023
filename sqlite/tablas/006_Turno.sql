create table Turno (
	id integer primary key autoincrement,
	institucionorientacionid integer not null,
	sedeid integer not null,
	nombre varchar(512) not null,
	horaentrada varchar(5) not null
	check(strftime('%H:%M',horaentrada) < strftime('%H:%M',horasalida)),
	horasalida varchar(5) not null
	check(strftime('%H:%M',horasalida) > strftime('%H:%M',horaentrada)),
	foreign key (sedeid)
	references Sede(id),
	foreign key (institucionorientacionid)
	references InstitucionOrientacion(id));

create unique index uix_turno
on Turno(institucionorientacionid,sedeid,nombre);
