create table PlanEstudios(
	id integer primary key autoincrement,
	InstitucionOrientacionId integer not null,
	nombre varchar(1024) not null,
	fechainicio date,
	fechafin inicio,
	foreign key (InstitucionOrientacionId)
	references InstitucionOrientacion(id));

create unique index uix_PlanEstudios_InstOrient_nombre
on PlanEstudios(InstitucionOrientacionId,nombre);

