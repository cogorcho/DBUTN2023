create table MateriasPlan (
	id integer primary key autoincrement,
	planestudiosid integer not null,
	materiaid integer not null,
	horassemanales integer,
	foreign key (planestudiosid)
	references PlanEstudios(id),
	foreign key (materiaid)
	references Materia(id));

create unique index uix_MateriasPlan 
on MateriasPlan(planestudiosid, materiaid);
