Select 'Turno';
create table Turno (
	id integer primary key auto_increment,
	institucionorientacionid integer not null,
	sedeid integer not null,
	nombre varchar(512) not null,
	horaentrada time not null,
	horasalida time not null,
	foreign key (sedeid)
	references Sede(id),
	constraint chk_horaentrada check (horaentrada < horasalida),
	constraint chk_horasalida check (horasalida > horaentrada),
	foreign key (institucionorientacionid)
	references InstitucionOrientacion(id));

create unique index uix_turno
on Turno(institucionorientacionid,sedeid,nombre);
