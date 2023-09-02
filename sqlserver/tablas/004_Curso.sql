Select 'Curso';
-- de cada plan-nivel(1rio, 2rio etc)
-- aca va 1er año, 2do grado, etc etc
create table Curso (
	id integer primary key auto_increment,
	planestudioid integer not null,
	nivelid integer not null,
	nombre varchar(1024) not null,
	foreign key (planestudioid)
	references PlanEstudios(id),
	foreign key (nivelid)
	references Nivel(id));

create unique index uix_curso_plan_nivel
on Curso(planestudioid,nivelid);
